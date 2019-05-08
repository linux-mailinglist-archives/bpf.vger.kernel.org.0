Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F949182A2
	for <lists+bpf@lfdr.de>; Thu,  9 May 2019 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfEHXRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 19:17:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36503 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfEHXRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 19:17:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id q185so359099ywe.3
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arzlWlxPv2OymsEHTQYVqat+ZNRKJaW7m2Sd15vAYKI=;
        b=uzXYgC/JFWHLD17dh31clIrTzYYKBttuO+F3BBulBqFp/B+0EdUvEjVu+Z4RLOn1Ix
         MeyPvmqeaaO5d+LSULaABT8GH6lP4FO1QU/3btIm+DZ6cRsDULZuGEi97KKuU/UObLnL
         7tLH3ghLiCnwZcLusFXeR1pQq8R67E2xWe7s5LdpcXcgimf8+RRd1Am6Bgq3QCEddHRT
         vgtm+skiJ15cq/ZIATLwIUA3Y7ECrJlznEBwRxPAJxMPq7LB4vhT9g9LGi3OvyWsGqHD
         VGl9TnCvV0+4OLI8+b1dsXI1fjFrzHpl8i2hETu27nOSdbM5bgV5ZcfduLDGefvpEMPl
         VaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arzlWlxPv2OymsEHTQYVqat+ZNRKJaW7m2Sd15vAYKI=;
        b=Yhrvq5MYxoqwHh/INe1uNUmE2AaTnUqWYXcOa998sAM8kclR8W7hfMwxygpp9yu1wM
         r/TyUv6wd6u97gOTEpHucAlRDlkfRRw/T80xc5Z84G/wdPncrep8PcoxHpm1HSH5+iFL
         AFd9bf+N2pie2MBXe2Hb6i1TBgFBYKyIPqESmXtPB4wt/lkhGumNm9I8jXE/IYqpq4DV
         TpOo4R9lRxGLai71610PKOJc9v1zjFV3e6jLHlAK7CI5ee5j2a7BpL82JSC79xzMPfMq
         HwRJGgLWJ5KY0By0b4X4lAgMoKI3jpxiLspHFict5oafNmVNrTTwF8Y+ThAAOK7grG0H
         tGjw==
X-Gm-Message-State: APjAAAXqyMp0KNItGxYhgSAh7k1xdNRPBGt5lfZfQbvYtdNnmho+tOdK
        a3ZAv1sVAz71ItDuDD/kWEtgflKkekzxO7959xlG/A==
X-Google-Smtp-Source: APXvYqwO32lw7Q547HjV5okCMbcsiOF0jVzqi9/qPCvyxGGfgTG7kTHSP6nYt4CD8IAcl2D/g8LOKH7he/eo03KLaaY=
X-Received: by 2002:a25:d68d:: with SMTP id n135mr345070ybg.461.1557357461388;
 Wed, 08 May 2019 16:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL_XLb5C-+DY5PRhneZDJv585xfbLtiEVc3-ejzNNXaVg@mail.gmail.com>
 <20190508230941.6rqccgijqzkxmz4t@ast-mbp>
In-Reply-To: <20190508230941.6rqccgijqzkxmz4t@ast-mbp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 May 2019 16:17:29 -0700
Message-ID: <CANn89iL_1n8Lb5yCEk3ZrBsUtPPWPZ=0BiELUo+jyBWfLfaAzg@mail.gmail.com>
Subject: Re: Question about seccomp / bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 8, 2019 at 4:09 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 08, 2019 at 02:21:52PM -0700, Eric Dumazet wrote:
> > Hi Alexei and Daniel
> >
> > I have a question about seccomp.
> >
> > It seems that after this patch, seccomp no longer needs a helper
> > (seccomp_bpf_load())
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd4cf0ed331a275e9bf5a49e6d0fd55dffc551b8
> >
> > Are we detecting that a particular JIT code needs to call at least one
> > function from the kernel at all ?
>
> Currently we don't track such things and trying very hard to avoid
> any special cases for classic vs extended.
>
> > If the filter contains self-contained code (no call, just inline
> > code), then we could use any room in whole vmalloc space,
> > not only from the modules (which is something like 2GB total on x86_64)
>
> I believe there was an effort to make bpf progs and other executable things
> to be everywhere too, but I lost the track of it.
> It's not that hard to tweak x64 jit to emit 64-bit calls to helpers
> when delta between call insn and a helper is more than 32-bit that fits
> into call insn. iirc there was even such patch floating around.
>
> but what motivated you question? do you see 2GB space being full?!


A customer seems to hit the limit, with about 75,000 threads,
each one having a seccomp filter with 6 pages (plus one guard page
given by vmalloc)
