Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BA31E50D
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 05:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBRELL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 23:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBREJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 23:09:58 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D55C0613D6
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 20:09:18 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l3so614341oii.2
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 20:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BE7D43L1C8FmY3GUkvOp/RVzWGFmYIOVW7BNnqnqfBk=;
        b=m1Oji3lRrqnSnEzDP6zpSWmuCy2LK0CpPeHPD9FBnYdA2lTAQLtvsaQFPNX1fAaxm8
         QwFgufQyCT/SfsnMm0YweZGgrkq/JAqO6FrQUzNwnvKeSTYBpcf4l9/u+DSLK6TtAKtV
         qAv+txFxw5BWlkok9yMV6wpgsM81VCmCNJcng75p4LWMnOMz/6gTgAWQpylOeusWmrep
         bsmMeDLD2QASIWQu9K3LD2OlXSHaUBJhwLqFuzfAViD1T7v/hk88LfyvaFKz3z7oongF
         V991YKh/9Ob1NigTynPlGTD6UThmdTU6r0Gmc2J4YJLqS2o7S2nva2sHZgiVIL96cCD+
         EicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BE7D43L1C8FmY3GUkvOp/RVzWGFmYIOVW7BNnqnqfBk=;
        b=Y17lvBhnWQFE1LuwV4GcVoyofqE1J4whVIb2QF6G3r5AixgOwlRfaD3Soo8F9VYwcb
         mPz0CfTfZ/1Y/WgsP8jt3VlHTuOJEUdC5iDlkTzHMuqSF0+XOfShjRupUKBd3garDqCZ
         xUnVVEGXhrPL8VSN8B0i6KUtiYEuEZ8gJjswzq4QAOG+osVULJL6QYFbYPncm++58LmS
         5Kla5ISkjvE18lZ/q48pBAJIaiQOTQaCs4W/+1N5IpSws8YeD/AhdSTVN+Y0dOibsXdB
         w0W1WstIvQe+5JUMm/dWXWKec01ieDRFcM9jYjwubYCZ2lS9i4+kbykFLSIMRN4f0mY5
         3DOg==
X-Gm-Message-State: AOAM533bvJvpZ5GqAr6zYFk5UZ9Bz3DrWfgnlBeHBdU6TjEjBUwg7hkG
        T7ELolDKqGmyGuxCXD4lwO3xOflXmHjp19NvzTYOVw==
X-Google-Smtp-Source: ABdhPJyXYKMWcvAaXLekFUsOwKBZm38d4KDdm4TbxlI4KLuydvVZqeHZS9pboxYRzyFtMu047x1WIDZ9criObMAOEkw=
X-Received: by 2002:aca:1015:: with SMTP id 21mr1392597oiq.83.1613621357310;
 Wed, 17 Feb 2021 20:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20210217010821.1810741-1-joe@wand.net.nz> <87r1len6hi.fsf@toke.dk>
In-Reply-To: <87r1len6hi.fsf@toke.dk>
From:   Joe Stringer <joe@cilium.io>
Date:   Wed, 17 Feb 2021 20:08:59 -0800
Message-ID: <CADa=RywykZt_kMVcCJk8N0vm2sJHW2_mKTr9Z8m2rTsnqvinqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/17] Improve BPF syscall command documentation
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, Joe Stringer <joe@cilium.io>,
        linux-man@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        mtk.manpages@gmail.com, ast@kernel.org, brianvv@google.com,
        Daniel Borkmann <daniel@iogearbox.net>, daniel@zonque.org,
        john.fastabend@gmail.com, ppenkov@google.com,
        Quentin Monnet <quentin@isovalent.com>, sean@mess.org,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 5:55 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Joe Stringer <joe@wand.net.nz> writes:
> > Given the relative success of the process around bpf-helpers(7) to
> > encourage developers to document their user-facing changes, in this
> > patch series I explore applying this technique to bpf(2) as well.
> > Unfortunately, even with bpf(2) being so out-of-date, there is still a
> > lot of content to convert over. In particular, I've identified at least
> > the following aspects of the bpf syscall which could individually be
> > generated from separate documentation in the header:
> > * BPF syscall commands
> > * BPF map types
> > * BPF program types
> > * BPF attachment points
>
> Does this also include program subtypes (AKA expected_attach_type?)

I seem to have left my lawyerly "including, but not limited to..."
language at home today ;-) . Of course, I can add that to the list.

> > At this point I'd like to put this out for comments. In my mind, the
> > ideal eventuation of this work would be to extend kernel UAPI headers
> > such that each of the categories I had listed above (commands, maps,
> > progs, hooks) have dedicated documentation in the kernel tree, and that
> > developers must update the comments in the headers to document the APIs
> > prior to patch acceptance, and that we could auto-generate the latest
> > version of the bpf(2) manual pages based on a few static description
> > sections combined with the dynamically-generated output from the header=
.
>
> I like the approach, and I don't think it's too onerous to require
> updates to the documentation everywhere like we (as you note) already do
> for helpers.
>
> So with that, please feel free to add my enthusiastic:
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Thanks Toke.
