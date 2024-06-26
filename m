Return-Path: <bpf+bounces-33152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37186917FE5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DA1C22756
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DD17F4FE;
	Wed, 26 Jun 2024 11:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49616A921;
	Wed, 26 Jun 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402023; cv=none; b=K/wxSvQA7M/lDI2klMsoLvdCcJdd/y/yEcGfsPJZxplOQkxt45etry9AxlLvtWjVNL6WrrNgF2V08sfJbiycIFOuo6g4J9L97DlmQzlF08THtjkGqOORuoaTIhRuffzcqRykE1p3f9sd5jdUzn5XwEnDQ4xOGKMz8bm8rR41noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402023; c=relaxed/simple;
	bh=gmz8qoGt4HlkkRGypkJtOw1vyW+PnKevF/oqxo1AH2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg1AGoAcjOHRcKTsRe1sMBMerxGpd+5g+u3G5pwlDFFaXAqDra8CKVwmT/7OnNBJNEE3wd5dBF37MNcBfqv4QZGOJAww3Bsn2WOsmlJQqw7+Cu22U5auCDc+KzPI/YxoxR5Cka6xskV8LMyAW/WRK4g5z54H+jRMw6zjxBLKSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-63127fc434aso54464727b3.0;
        Wed, 26 Jun 2024 04:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402019; x=1720006819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C4tP0Pw41t+Yl8189/n1Z9I+NNWx13UjirR9hPyNbs=;
        b=MvNrgH935qFnCud7KY6u95BMbV3UwgoFUQSxSaKt0a0tyxVVmaH6DG1FLXyHmbMmmq
         JMxCfBEmAF7mhvkazR+XJcfxikXsgmLYN1bhce5OI6odCaCU0MLM/iOTe1ZM13WmCWY1
         pV/k3x8ZQJ54pD6OnF/fqUVhrW0UZZnEeerzWAcdrTFJth+3LLRAYOb5/nX8YfKMtXLO
         9Cmmbz77zBobOusrlZE080NyHw72Oki3T27ZX6XVyEXOh4F3dkgGKW04P9fIlVy+IaIO
         7zYVozCNIwLSatBGYGPffB+P9qjIPMVLQXtOBKb83MejizEO28Q4A84hjqtl0s8flf/A
         1oiA==
X-Forwarded-Encrypted: i=1; AJvYcCWCv/yjKKnklKFBKScmjsZq/kPRj5D6p9vSX3akDCqah/pWAotJOqOz//ah+oaPaa4SnzxS9jGZwy7qNcThXyzlVnCfXqf0ylY5os6wgd3Cm5oAu2LjMn1SAaYu7g9qKf3VKzeGopCNO0w6p+oy6W5JESgEEtjdvhff
X-Gm-Message-State: AOJu0YyLDFS2aChUZSUmn3GItm1Ah1rSLtB4Skb53KBo4u3iO+sFD4hc
	pG9v8eRY9eNDJ4fH82f2Zcfp7h1/eGFCm+JEikFt1/akKk4gUDxaxdsSbAwT
X-Google-Smtp-Source: AGHT+IHtE3GwPaUWjRfWe1JbVNGdhAB6fyQKPP0akdYawotx66h9jbFSeP0Lhk77ouu5G2M4KyBKyA==
X-Received: by 2002:a0d:e647:0:b0:61b:bd7f:c62b with SMTP id 00721157ae682-643a990b6f1mr94839557b3.2.1719402018926;
        Wed, 26 Jun 2024 04:40:18 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f11b0f2casm38179987b3.50.2024.06.26.04.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 04:40:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-63127fc434aso54464327b3.0;
        Wed, 26 Jun 2024 04:40:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlDrg12JKwxEhaSSyBOJfo472OSQBBdPIeYRgGJId1W+XqOg0RmyqgOsPz4m2GdjiAUGBf8d/UJx1sPZwTRlhMHsFi8qSSxCDJT+2Ff2H7f1dN3VLLSphXXr/lBoolHTJMz5JrLkI8KYla3m66kB1x8tINMxMZiGxQ
X-Received: by 2002:a81:9182:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-643aa0c6422mr88411277b3.16.1719402017812; Wed, 26 Jun 2024
 04:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717413886.git.Tony.Ambardar@gmail.com> <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
 <51bc27e-f073-f6f7-df63-f9bbf96e2024@linux-m68k.org> <ZnvkxLQBideJH4MB@krava>
In-Reply-To: <ZnvkxLQBideJH4MB@krava>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Jun 2024 13:40:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaYP3-2JHk-OE9B-AWNU3ikhBdLyWDm0R8DwQpUS9eCw@mail.gmail.com>
Message-ID: <CAMuHMdUaYP3-2JHk-OE9B-AWNU3ikhBdLyWDm0R8DwQpUS9eCw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Harden __bpf_kfunc tag against linker
 kfunc removal
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Jun 26, 2024 at 11:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> On Tue, Jun 25, 2024 at 12:46:48PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 3 Jun 2024, Tony Ambardar wrote:
> > > BPF kfuncs are often not directly referenced and may be inadvertently
> > > removed by optimization steps during kernel builds, thus the __bpf_kf=
unc
> > > tag mitigates against this removal by including the __used macro. How=
ever,
> > > this macro alone does not prevent removal during linking, and may sti=
ll
> > > yield build warnings (e.g. on mips64el):
> > >
> > >    LD      vmlinux
> > >    BTFIDS  vmlinux
> > >  WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > >  WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > >  WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > >  WARN: resolve_btfids: unresolved symbol bpf_key_put
> > >  WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > >  WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > >  WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > >  WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > >  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > >    NM      System.map
> > >    SORTTAB vmlinux
> > >    OBJCOPY vmlinux.32
> > >
> > > Update the __bpf_kfunc tag to better guard against linker optimizatio=
n by
> > > including the new __retain compiler macro, which fixes the warnings a=
bove.
> > >
> > > Verify the __retain macro with readelf by checking object flags for '=
R':
> > >
> > >  $ readelf -Wa kernel/trace/bpf_trace.o
> > >  Section Headers:
> > >    [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf =
Al
> > >  ...
> > >    [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0 =
 8
> > >  ...
> > >  Key to Flags:
> > >  ...
> > >    R (retain), D (mbind), p (processor specific)
> > >
> > > Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com=
/
> > > Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel fun=
ctions as kfuncs")
> > > Cc: stable@vger.kernel.org # v6.6+
> > > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> >
> > Thanks for your patch, which is now commit 7bdcedd5c8fb88e7
> > ("bpf: Harden __bpf_kfunc tag against linker kfunc removal") in
> > v6.10-rc5.
> >
> > This is causing build failures on ARM with
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy:
> >
> >     net/core/filter.c:11859:1: error: =E2=80=98retain=E2=80=99 attribut=
e ignored [-Werror=3Dattributes]
> >     11859 | {
> >           | ^
> >     net/core/filter.c:11872:1: error: =E2=80=98retain=E2=80=99 attribut=
e ignored [-Werror=3Dattributes]
> >     11872 | {
> >           | ^
> >     net/core/filter.c:11885:1: error: =E2=80=98retain=E2=80=99 attribut=
e ignored [-Werror=3Dattributes]
> >     11885 | {
> >           | ^
> >     net/core/filter.c:11906:1: error: =E2=80=98retain=E2=80=99 attribut=
e ignored [-Werror=3Dattributes]
> >     11906 | {
> >           | ^
> >     net/core/filter.c:12092:1: error: =E2=80=98retain=E2=80=99 attribut=
e ignored [-Werror=3Dattributes]
> >     12092 | {
> >           | ^
> >     net/core/xdp.c:713:1: error: =E2=80=98retain=E2=80=99 attribute ign=
ored [-Werror=3Dattributes]
> >       713 | {
> >           | ^
> >     net/core/xdp.c:736:1: error: =E2=80=98retain=E2=80=99 attribute ign=
ored [-Werror=3Dattributes]
> >       736 | {
> >           | ^
> >     net/core/xdp.c:769:1: error: =E2=80=98retain=E2=80=99 attribute ign=
ored [-Werror=3Dattributes]
> >       769 | {
> >           | ^
> >     [...]
> >
> > My compiler is arm-linux-gnueabihf-gcc version 11.4.0 (Ubuntu 11.4.0-1u=
buntu1~22.04).
>
> hum, so it'd mean __has_attribute(__retain__) returns true while gcc stil=
l
> ignores the retain attribute.. like in this bug which seems similar:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99587
> but not sure how it got fixed.. any chance you can upgrade gcc and retest=
?

Indeed, __has_attribute(__retain__) returns true, while the attribute
is not supported.

My test program:

cat > /tmp/a.c <<EOF
#if __has_attribute(__retain__)
#warning __retain__ OK
#else
#warning No __retain__
#endif

int x __attribute__((__retain__));
EOF

$ arm-linux-gnueabihf-gcc-11 -c /tmp/a.c # gcc version 11.4.0 (Ubuntu
11.4.0-1ubuntu1~22.04))

/tmp/a.c:2:2: warning: #warning __retain__ OK [-Wcpp]
    2 | #warning __retain__ OK
      |  ^~~~~~~
/tmp/a.c:7:1: warning: =E2=80=98retain=E2=80=99 attribute ignored [-Wattrib=
utes]
    7 | int x __attribute__((__retain__));
      | ^~~

Oops

$ arm-linux-gnueabihf-gcc-12 -c /tmp/a.c # gcc version 12.3.0 (Ubuntu
12.3.0-1ubuntu1~22.04)
/tmp/a.c:2:2: warning: #warning __retain__ OK [-Wcpp]
    2 | #warning __retain__ OK
      |  ^~~~~~~

Fixed

It works fine with the native gcc-11:

$ gcc-11 -c /tmp/a.c # gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
/tmp/a.c:2:2: warning: #warning __retain__ OK [-Wcpp]
    2 | #warning __retain__ OK
      |  ^~~~~~~

I gave it a try on all installed gcc-11 compilers.

/usr/bin/aarch64-linux-gnu-gcc-11
/usr/bin/alpha-linux-gnu-gcc-11
/usr/bin/arm-linux-gnueabi-gcc-11
/usr/bin/arm-linux-gnueabihf-gcc-11
/usr/bin/hppa64-linux-gnu-gcc-11
/usr/bin/hppa-linux-gnu-gcc-11
/usr/bin/m68k-linux-gnu-gcc-11
/usr/bin/powerpc64le-linux-gnu-gcc-11
/usr/bin/powerpc64-linux-gnu-gcc-11
/usr/bin/powerpc-linux-gnu-gcc-11
/usr/bin/riscv64-linux-gnu-gcc-11
/usr/bin/s390x-linux-gnu-gcc-11
/usr/bin/sh4-linux-gnu-gcc-11
/usr/bin/sparc64-linux-gnu-gcc-11
/usr/bin/x86_64-linux-gnu-gcc-11
/usr/bin/x86_64-linux-gnux32-gcc-11

All of them failed (incl. x32), except for the native x86_64-linux-gnu-gcc-=
11.

It works fine with all installed gcc-12 compilers
(arm-linux-gnueabihf-gcc-12, m68k-linux-gnu-gcc-12, x86_64-linux-gnu-gcc-12=
).

With gcc-9, the absence of __retain__ is detected correctly.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

