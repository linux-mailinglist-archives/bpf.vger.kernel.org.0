Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BA27FC50
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgJAJNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 05:13:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbgJAJNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 05:13:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601543580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYBTMaQHVuVYsYUY0Zvr7F9tikwzDOAPYv+gCxumIkQ=;
        b=O/0fuph25Ea2RKXzd2OjiZOVQ1tE80qGWulsJ4UkxzyqgqqaBH4WyWqTms364VyGowCon5
        xLd+eICWgQSXDzM6fanCgUyfqR1bb/AMufqNYIdG8ecO3PB3JYYzav/8Gto0SN5Um9kBtH
        U/Afkzj6lgha1T4KmdY/0xNYYTku3Q8HhbSiFndUErxCEwnSutznbFbO6V3hVpl2l/zJkx
        4RkA3GMs/S3vmv/U/fc/TCKQk82tFPXBMpghPzhdo+KdDVsnLjeA0MEqJOCa0/zK5toWTU
        vo9Ud+bdAehLcvOqZbK2lAS9wQ+jWWb5POVrQK8/6YoWF7mXcr0HZl+to3UecA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601543580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYBTMaQHVuVYsYUY0Zvr7F9tikwzDOAPYv+gCxumIkQ=;
        b=LFcyRUxzhcWIgf1CEvwD9FOglI/VZj8UR07zAQeKJRi7uUqtsTyZnTN6kez8t1Y/tX6hGr
        VpnVTEebncTpbXCw==
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mb2q experience and couple issues
In-Reply-To: <CAADnVQLV86GcC5fE68Eiv0aM9g7o3a5ZDh0kmXv7Tba4x-jRbg@mail.gmail.com>
References: <CAADnVQLV86GcC5fE68Eiv0aM9g7o3a5ZDh0kmXv7Tba4x-jRbg@mail.gmail.com>
Date:   Thu, 01 Oct 2020 11:13:00 +0200
Message-ID: <87sgayfgwz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei,

On Wed, Sep 30 2020 at 11:12, Alexei Starovoitov wrote:
> For the last couple years we've been using mb2q tool to normalize patches
> and it worked wonderfully.

Fun. I thought I'm the only user of it :)

> Recently we've hit few bugs:
> curl -s https://patchwork.kernel.org/patch/11807443/mbox/ >
> /tmp/mbox.i; ~/bin/mb2q --mboxout mbox.o /tmp/mbox.i
> Drop Message w/o Message-ID: No subject
> No patches found in mbox
>
> I've tried to debug it, but couldn't figure out what's going on.
> The subject and message-id fields are parsed correctly,
> but later something happens.
> Could you please take a look?

The problem is the mbox storage format. The mbox created by curl has a
mail body which has a line starting with 'From' in the mail body:

  From the VAR btf_id, the verifier can also read the address of the
  ksym's corresponding kernel var from kallsyms and use that to fill
  dst_reg.

The mailbox parser trips over that From and takes it as start of the
next message.

     http://qmail.org/qmail-manual-html/man5/mbox.html

Usually mailbox storage escapes a From at the start of a
newline with '>':

  >From the VAR btf_id, the verifier can also read the address of the
  ksym's corresponding kernel var from kallsyms and use that to fill
  dst_reg.

Yes, it's ugly and I haven't figured out a proper way to deal with
that. There are quite some mbox formats out there and they all are
incompatible with each other and all of them have different horrors.

Let me think about it.

> Another issue we've hit was that some mailers split message-id
> into few lines like this:
> curl -s https://patchwork.kernel.org/patch/11809399/mbox/|grep -2 Message-Id:
> Subject: [PATCH bpf-next v4 1/6] bpf: add classid helper only based on skb->sk
> Date: Wed, 30 Sep 2020 17:18:15 +0200
> Message-Id:
>  <ed633cf27a1c620e901c5aa99ebdefb028dce600.1601477936.git.daniel@iogearbox.net>
> X-Mailer: git-send-email 2.21.0
>
> That was an easy fix:
> - mid = pmsg.msgid.lstrip('<').rstrip('>')
> + mid = pmsg.msgid.lstrip('\n').lstrip(' ').lstrip('<').rstrip('>')
>
> The tglx/quilttools.git doesn't have this fix, so I'm guessing you
> haven't seen it yet.

Indeed, but it just should be:

 + mid = pmsg.msgid.strip().lstrip('<').rstrip('>')

Thanks,

        tglx
