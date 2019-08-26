Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2407F9D384
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2019 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfHZP5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Aug 2019 11:57:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41333 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZP5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Aug 2019 11:57:41 -0400
Received: by mail-ua1-f68.google.com with SMTP id x2so1188261uar.8
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2019 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFnOT6vgu+r/lhkNN/tQF3NbbQWiENZLqVFsUKVA5rU=;
        b=BMInD5xOvrN2i1SL0H0iqKlICinwarz2/UC6/LzJNY+/qGEXF89sf1f+lUQOpeR8NJ
         jGrnv2++PVMJVjokc31NuRgeM0ObSc6MxtkUlTyYOrQBQ6mOpuj3xtE53u8cFLJoB1Kp
         Z6NnmdQdc4OTbghXq1k8XmPqTS/kpYhuXdQjuenDJtwpPIiY5kcorpFRuryTKSKwaTJw
         O4Opi8YPvYB3rKZfFaE0YxFCVSIEncAk1kEn85a7Uq4HYMCARrcOWX2/dhzZDJhtkePR
         wRUdL8i8g19avjYI7BJA9ifJTjDPQjuEzUovBDZVMwGB5mTgxIn+jZrZLRm+mBCQkKUP
         JUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFnOT6vgu+r/lhkNN/tQF3NbbQWiENZLqVFsUKVA5rU=;
        b=FuvsWjQKM1WCQXdXAGyv8P0EYPH/CucY6py6+YYiwrAFNYxOY/zJnPYPfFRTFg4AHK
         oZ7TyATkVFYzpTWJI98ya0v7sOrfI2AbjJct6TiZw+QWjU32V7G+G0DVH6+NaDD40HGA
         6zPceNDcLwMFQRTsKozmD2/QlqA+XkAYpHXAX0rfElYwmCcWM4YwgqfSOa66dyHvd4WW
         j3kp8vFjSKvTKI1PCr1fWegwRztjD+Fq2lhO1TwS7pJeKNUJ0au6RsVxrkQevMdOpre4
         os4gTk9PPA2wrbktoi7sBM45ZeTtixwGui3mS6jhXFZirBAWASRkp+7ahFkYtJTRSj1H
         f1sw==
X-Gm-Message-State: APjAAAUyvkGc5BYMF3EN9X8upE6ih1ctvATSLek1o+DZiT2B8w1QLJRR
        miDHNypaC20OkB/6LGTjwvt78zsgbBan0ZH3jZvi1A==
X-Google-Smtp-Source: APXvYqxb9EOME/yS8FxXdJ9AuKzls2c+zYtIBAXjNTg2VvJzAn/Vo1vD5JBG2oa2MXhSHox+v35wp+ejnd+eCrSR7Pk=
X-Received: by 2002:ab0:e19:: with SMTP id g25mr8360418uak.71.1566835060171;
 Mon, 26 Aug 2019 08:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190824020028.6242-1-jakub.kicinski@netronome.com> <CAPhsuW7_dSEPJOdKApQFU-aVmEXgOwmqLS7S1FC4JtnzjR6OiQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7_dSEPJOdKApQFU-aVmEXgOwmqLS7S1FC4JtnzjR6OiQ@mail.gmail.com>
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Mon, 26 Aug 2019 08:57:17 -0700
Message-ID: <CAJpBn1z736w5_uv7apwyy82vzcnc9c5Gua_9ZyUy-pSEwnQewA@mail.gmail.com>
Subject: Re: [PATCH bpf] nfp: bpf: fix latency bug when updating stack index register
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        OSS Drivers <oss-drivers@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 25, 2019 at 10:37 PM Song Liu <liu.song.a23@gmail.com> wrote:
> On Fri, Aug 23, 2019 at 7:04 PM Jakub Kicinski wrote:
> > From: Jiong Wang <jiong.wang@netronome.com>
> >
> > NFP is using Local Memory to model stack. LM_addr could be used as base of
> > a 16 32-bit word region of Local Memory. Then, if the stack offset is
> > beyond the current region, the local index needs to be updated. The update
> > needs at least three cycles to take effect, therefore the sequence normally
> > looks like:
> >
> >   local_csr_wr[ActLMAddr3, gprB_5]
> >   nop
> >   nop
> >   nop
> >
> > If the local index switch happens on a narrow loads, then the instruction
> > preparing value to zero high 32-bit of the destination register could be
> > counted as one cycle, the sequence then could be something like:
> >
> >   local_csr_wr[ActLMAddr3, gprB_5]
> >   nop
> >   nop
> >   immed[gprB_5, 0]
> >
> > However, we have zero extension optimization that zeroing high 32-bit could
> > be eliminated, therefore above IMMED insn won't be available for which case
> > the first sequence needs to be generated.
> >
> > Fixes: 0b4de1ff19bf ("nfp: bpf: eliminate zero extension code-gen")
> > Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> > Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> I haven't looked into the code yet. But ^^^ should be
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>
> right?

I prefer Review on code I review, ack on code I ack, and sign-off on
code I co-author.
