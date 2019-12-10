Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E67119037
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLJS6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 13:58:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36469 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfLJS6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 13:58:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so4424943wma.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvDFARgCT0LsrZ/bz1Y3KZ6G13ajYy+ecdz2Y5wO+o4=;
        b=JogH2eZ4Nhc/g73QDo4a7CNVK2d54Ay5JJclQzZ2XGAoWhHww28c40KZpbDE3OUs5Q
         LxqLakbePfjaWEZtzW9qE+6VQDXz+12h9Gbqxe5ZfzfSK4AhbV5cmsUWIltiNmsHHtcx
         hIg67qr9XGmb/1o5Dd+/k1/D7ovJBZmSfJPdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvDFARgCT0LsrZ/bz1Y3KZ6G13ajYy+ecdz2Y5wO+o4=;
        b=r3xGCv4tIrVJqXnqFQnwGr9Imdr/dQCnQYAVoSjLyh1gk+WHqZf/KUv5SfM0I57Wea
         7GbaSm4OwE4Tnnb5xwQbJ69V30g6FE2X6Xok1+El2T2AYWr8fGOtIUwQ1I03A+fWvEl9
         SWsc1iEN1Kbl2w7BrjqWq60+EmIcm9k/+B4D++ibIRS8iTCmOdjJ1GqYRCT7z4DV/VmT
         gl4HRZpAqar7WA6CsbhqcQzp3qFPmB2rs9tV5vn7eggOYWsvrfldQbmS6EVef6WH95tY
         zVdXsKTcRFrp8jalWFQPR0wIk3Wk5vpwwFd1iLjp0/V4tGhHchRfk91YkRmC/BezTwS4
         Ye3Q==
X-Gm-Message-State: APjAAAVtCSTpwkj70/SQCgN90xjwmT8IuZvB7osnmip+sXwJFm3JZN4Q
        7NiQeGsUep9rRmImHo5nOxVnPhhs+SrB3wg5+EOHrOpV91uhN5jw
X-Google-Smtp-Source: APXvYqwLybqhBx8RzCoka7tiW2rLLq1azZFzhsoPra5zQN6VCVrvOP6LJddIDsb4Qjv9QFK7+ZPUTVF2I/bJPSMqluE=
X-Received: by 2002:a1c:7310:: with SMTP id d16mr6679056wmb.165.1576004324170;
 Tue, 10 Dec 2019 10:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20191201195728.4161537-1-aurelien@aurel32.net>
 <87zhgbe0ix.fsf@mpe.ellerman.id.au> <20191202093752.GA1535@localhost.localdomain>
In-Reply-To: <20191202093752.GA1535@localhost.localdomain>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 10 Dec 2019 12:58:33 -0600
Message-ID: <CAFxkdAqg6RaGbRrNN3e_nHfHFR-xxzZgjhi5AnppTxxwdg0VyQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix readelf output parsing on powerpc with recent binutils
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Aurelien Jarno <aurelien@aurel32.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, debian-kernel@lists.debian.org,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 2, 2019 at 3:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On Mon, Dec 02, 2019 at 04:53:26PM +1100, Michael Ellerman wrote:
> > Aurelien Jarno <aurelien@aurel32.net> writes:
> > > On powerpc with recent versions of binutils, readelf outputs an extra
> > > field when dumping the symbols of an object file. For example:
> > >
> > >     35: 0000000000000838    96 FUNC    LOCAL  DEFAULT [<localentry>: 8]     1 btf_is_struct
> > >
> > > The extra "[<localentry>: 8]" prevents the GLOBAL_SYM_COUNT variable to
> > > be computed correctly and causes the checkabi target to fail.
> > >
> > > Fix that by looking for the symbol name in the last field instead of the
> > > 8th one. This way it should also cope with future extra fields.
> > >
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > >  tools/lib/bpf/Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Thanks for fixing that, it's been on my very long list of test failures
> > for a while.
> >
> > Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Looks good & also continues to work on x86. Applied, thanks!

This actually seems to break horribly on PPC64le with binutils 2.33.1
resulting in:
Warning: Num of global symbols in sharedobjs/libbpf-in.o (32) does NOT
match with num of versioned symbols in libbpf.so (184). Please make
sure all LIBBPF_API symbols are versioned in libbpf.map.

This is the only arch that fails, with x86/arm/aarch64/s390 all
building fine.  Reverting this patch allows successful build across
all arches.

Justin
