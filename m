Return-Path: <bpf+bounces-55744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE8A8631F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BB1BA099A
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFFC219A6B;
	Fri, 11 Apr 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azQ8JZsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1526AD9;
	Fri, 11 Apr 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388573; cv=none; b=UtWCPI0VTEc1346eCZ71BEMXrpPgzmmG5H5fbM4OkOVRt2CI4hyMgAWpprzQMeUS7OfO5gs/dkWbrVVQX00295kaz6+CM0RYoxI59gkIy9KVqCdxjIth8+Wbc8EnUgOpofB7z6y6WjUYFpm7nRUkZkOXNtYNXc1aUyY77dom6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388573; c=relaxed/simple;
	bh=5rB2vSHPlJjeLbucCa9fOjc63VVGLRNKyQuL3lgdq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGZxUt4Az7VskADrIZkbO5iNH9qDyJRTI5DSjtmm68y5ApDN3wvyCvVyGQq4DgSkXDOCCr6aPQL+dY9XSecgyDL0y5Z7sU9zHAHTcBnO8OaRHWTnFgf1/mo+w/GAwvbsVAzFsLNUcfQbPPOuwI5EZujR1AYksa+PXCqTWzjDyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azQ8JZsV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73712952e1cso2184850b3a.1;
        Fri, 11 Apr 2025 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744388570; x=1744993370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baX3GRriSGAR4q6Gb5P6eXLG5DHv9DgzrxJCCNiVizU=;
        b=azQ8JZsVSy3cyZvEpm6FX3inRQhQLTFiq935uayrAev4FLcbjnaUsdZJS5kmviKzjq
         Ui/Hm8TyTsgRUsdE9ZkcmL//9hmNuJ9gA4hFtAtIEX4DGnkeo9QmfI9ZzTQdebCVTYSy
         YANGQsYCX1BEnpz/jpXWcNWHLutEgHm6W80PLNVPY7WuY6u3lhG2PEXbPNhqaV8Nb81L
         7BF6Zc/ZaV/j/mPzDHYIDiUXvhRuEjCTs5TIiGzJZ3RRIZTyUjWKyxyOX21uNQDfXeJ0
         1kE3QIZLVlF8LHU6RVikjedUB3t9PCJ/g1+gq76iw+5Lt727ahtVssFC7o+XRQHT4M/Q
         8INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388570; x=1744993370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baX3GRriSGAR4q6Gb5P6eXLG5DHv9DgzrxJCCNiVizU=;
        b=Qq70g5V8R4v8CbDj6RzEgAqtLQ90JCJe+lKWT7uAxuh3/nY5S3TWqZXBx8aMSxa4e7
         QdnW7svbfwJkQMMetX2hzV8zhEi4AqG8/XwI/UQVdjmHNnkMroIt06h5LiqD3/w+0/qI
         Ccx3q+3zbdwYTryL+tSQUXMjO65kutXevvjxdAa9VNSx97QfgSGBDU74FxFXwor3OQ9e
         W2BXHbsKr5P2n27grb9zPblKGmL+xz9eaTBZ149sCWzcJbOzBF1urOUI2QFuKyE2zFbx
         ddY1nY5JHOdwdgKl5SNEku16j6ZHltvPbxgwepOoDBP/eWqpWbZpSTHLCT1KKYyeQ0IQ
         Utgg==
X-Forwarded-Encrypted: i=1; AJvYcCX32fhO5E4UA6EBE2hWw/z/OMwWWsLbUZYpR7W+PY39+xhhxRUh7Y4LQrL8qWubUyOZC3AquRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xkuJjel6uCNtFFHGrZjnfT5L0gVQ7e2LuIARrGimfg81MKNH
	+QJclDpymQWzWw3ygIsZ7gse+15mPFllrSLn3iCtqyBcLD7X6zHsCRCIcNrr6QMKiC5xcAkSerh
	km61eO8LT6EgR5jiPMuSZh00cfLI=
X-Gm-Gg: ASbGncvd8ibeIfxhGB4lZl36KfyzEHNtHYuiLkMVZj1bnqf2gkmFHh0Dtxynh4/Wxa+
	iaUbR1MquzLI5og8GX/zzHtY7os+n1J/t25y93ZUQhCSlldkk59nRtEOgqyuOc1K2hAVBVdj9Cm
	U6Md9dQwBkNWEAH3/np0tNS3JNsw33DY6ddZ5PKj96h3Pp4fs=
X-Google-Smtp-Source: AGHT+IH/AHSMPpcHMSpdd831NVuZ6wPIlyassBglWdslI21V1PqlLgFfogK98BXS1nokG6d6/15QBelPvbiGAAnfAYg=
X-Received: by 2002:a05:6a00:909c:b0:736:ff65:3fcc with SMTP id
 d2e1a72fcca58-73bd1263c4bmr4375124b3a.16.1744388570483; Fri, 11 Apr 2025
 09:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410095517.141271-1-vmalik@redhat.com>
In-Reply-To: <20250410095517.141271-1-vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Apr 2025 09:22:37 -0700
X-Gm-Features: ATxdqUFwzogkAAn6Mma_RCicNnu3ETJW2tli5HmLORLn3X8bRqdq1ym85aJOBDY
Message-ID: <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in bpf_object__init_prog
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>, stable@vger.kernel.org, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 2:55=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
> file such that arbitrary BPF instructions are loaded by libbpf. This can
> be done by setting a symbol (BPF program) section offset to a large
> (unsigned) number such that <section start + symbol offset> overflows
> and points before the section data in the memory.
>
> Consider the situation below where:
> - prog_start =3D sec_start + symbol_offset    <-- size_t overflow here
> - prog_end   =3D prog_start + prog_size
>
>     prog_start        sec_start        prog_end        sec_end
>         |                |                 |              |
>         v                v                 v              v
>     .....................|################################|............
>
> The CVE report in [1] also provides a corrupted BPF ELF which can be
> used as a reproducer:
>
>     $ readelf -S crash
>     Section Headers:
>       [Nr] Name              Type             Address           Offset
>            Size              EntSize          Flags  Link  Info  Align
>     ...
>       [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
>            0000000000000068  0000000000000000  AX       0     0     8
>
>     $ readelf -s crash
>     Symbol table '.symtab' contains 8 entries:
>        Num:    Value          Size Type    Bind   Vis      Ndx Name
>     ...
>          6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
>
> Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
> point before the actual memory where section 2 is allocated.
>
> This is also reported by AddressSanitizer:
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     =3D=3D1232=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addr=
ess 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
>     READ of size 104 at 0x7c7302fe0000 thread T0
>         #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
>         #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf=
.c:856
>         #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/lib=
bpf.c:928
>         #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libb=
pf.c:3930
>         #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:806=
7
>         #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf=
.c:8090
>         #6 0x000000400c16 in main /poc/poc.c:8
>         #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x3=
5b4)
>         #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.s=
o.6+0x3667)
>         #9 0x000000400b34 in _start (/poc/poc+0x400b34)
>
>     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe=
0040,0x7c7302fe00a8)
>     allocated by thread T0 here:
>         #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
>         #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.s=
o.1+0xb600)
>         #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc=
018)
>         #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740
>
> The problem here is that currently, libbpf only checks that the program
> end is within the section bounds. There used to be a check
> `while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
> removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
> sections to support overriden weak functions").
>
> Put the above condition back to bpf_object__init_prog to make sure that
> the program start is also within the bounds of the section to avoid the
> potential buffer overflow.
>
> [1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>
> Reported-by: lmarch2 <2524158037@qq.com>
> Cc: stable@vger.kernel.org

Libbpf is packaged and consumed from Github mirror, which is produced
from latest bpf-next and bpf trees, so there is no point in
backporting fixes like this to stable kernel branches. Please drop the
CC: stable in the next revision.

> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to suppo=
rt overriden weak functions")
> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> Link: https://www.cve.org/CVERecord?id=3DCVE-2025-29481

libbpf is meant to load BPF programs under root. It's a
highly-privileged operation, and libbpf is not meant, designed, and
actually explicitly discouraged from loading untrusted ELF files. As
such, this is just a normal bug fix, like lots of others. So let's
drop the CVE link as well.

Again, no one in their sane mind should be passing untrusted ELF files
into libbpf while running under root. Period.

All production use cases load ELF that they generated and control
(usually embedded into their memory through BPF skeleton header). And
if that ELF file is corrupted, you have problems somewhere else,
libbpf is not a culprit.

> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..d0ece3c9618e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_=
Data *sec_data,
>                         return -LIBBPF_ERRNO__FORMAT;
>                 }
>
> -               if (sec_off + prog_sz > sec_sz) {
> +               if (sec_off >=3D sec_sz || sec_off + prog_sz > sec_sz) {

So the thing we are protecting against is that sec_off + prog_sz can
overflow and turn out to be < sec_sz (even though the sum is actually
bigger), right?

If my understanding is correct, then I'd find it much more obviously
expressed as:


if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off)

We have such an overflow detection checking pattern used in a few
places already, I believe. WDYT?

pw-bot: cr

>                         pr_warn("sec '%s': program at offset %zu crosses =
section boundary\n",
>                                 sec_name, sec_off);
>                         return -LIBBPF_ERRNO__FORMAT;
> --
> 2.49.0
>

