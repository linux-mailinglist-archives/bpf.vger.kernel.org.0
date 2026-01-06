Return-Path: <bpf+bounces-78012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CDCFB304
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 23:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DA33042836
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65C1D90DD;
	Tue,  6 Jan 2026 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drPvIKLo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A913FEE
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736915; cv=none; b=FdX9hbXqZ4zSqjXKEUIh7V2OtPikofc+Udp8MrefxL8dEqMMkxbos14aE+vkqO8GHey8nFPEUKzx4oWduf1n9lzRARrCA+NnzYhuq2N2f7xUoiPbITFZMu0UjUyEtC7PMuQOy4Dwa6uLOpKmLdKzndt4Co0BBFMgdJ4bk0UDWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736915; c=relaxed/simple;
	bh=V1vYI9OaW6JgbscL6zWnaQPik4nUq5Se6Pt3qC2XhEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3xlk9hehjPtwhuoTbewpvNGBrr6zupL8KjaIOlQtXJwyqWF3L+ZC2kkBW8yc7zdCo+J4dfQJmpH3w6dzJuOpdVGlZLsw/DoaE+Cc6Kpx4isbvbB9htDCbzXH8ftpsnZsoIx3fb809p79s3H7P8mIJ+XmjNXmrWmJRfw1ZD5yKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drPvIKLo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432755545fcso808390f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736912; x=1768341712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwWESQKHbbtswFeI0/RZNTuSNdIN0VtXuvpzyrmVP6o=;
        b=drPvIKLohCcgbEbgA9+/TIDonLq279sxJZQps0g7IajCrpbHaz0+5+S5DPVXpBuECN
         vbzZihDqFJuyNJjPtmtPLashVugwuuoNaqaF2z4xhLi8h45MeSKBhLoAbMouo5nzbzZh
         G9M4AZp/Fj8qtj4L0zgmJu+SMkwW/DuqQxgeIvPTJvyWO7kJIHb0kqbY1jyJYqp6Y+zL
         hj6ZUg4MnsiuCI9j836odnyjLRyI6338GruqLy65w5Go43j5ZdrPJkYNjjNqaYr63PBV
         SH4qZotblH+EtMavy7lOfWUMwQiva+ROw42qevWo58ieRTgJs5d5Yfokmgy8j2DFZ9c5
         5s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736912; x=1768341712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwWESQKHbbtswFeI0/RZNTuSNdIN0VtXuvpzyrmVP6o=;
        b=PZ5tx8thnnbRnReaxpvm2DcduYwzp2DTQLXISJAtsHidp3obHqorPhsEd1xCOtRsJK
         xACkMjRwTs5TShCBrDofJxA+n3I9im/dPvfv8oLVjpOtYDc/lRc4f41+Mh8KrSCVjAYT
         F4IVvVCsqlxigsY/zlIWSBhBwWgFghjSFAOxqCtPvU4u+GB+eI+aUm6FUiIAJtsc76ow
         yphTPquphar71mYHZmLXDLx+7mB/PWIjTzxCy+kfvsI93PKd5igXPOTzmKeRIVnvP296
         5PEI3ukFfYKT/V2ud/hD7Y/4yj7hps0AxbK1xF8ppDhUguklrhbAn8P0SWPI9N4GPC6F
         18Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUiLwvMOXOUD/B/ye8GBiE+WpaaVzzleae7bEb/aHlZTmW4B4OQmFPxJp3v728NddHJYZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY56odiNNDr1ngAYvhnwEairXDNzlOcEPtsplr6Fy2nZwBsKrB
	4RMAu9pxC4hJcL5jiZYkwpMwNTlMjXivbAjT//h1rRnWAsowenJKMjC4d6ErWhcHUXAXO9RgSqZ
	tlxgN/h0TLKQgHAo0ej2uCf3/xdtjiTs=
X-Gm-Gg: AY/fxX5FYLY44VA6oeVH7WUimolEPWQQpdVJ8z02ba3fmEuchxPLQU0IlPpgxraKMvh
	1EIPaZfi51psmGuhfXcFOkfg9B8nlAZd3HVOCKNsPJOGiu0nn+scMjWqPrtXYbOAV4Qq8y+nZx7
	6662PdmrWUbosoevMH3T2VGV/DAbcTc4GOdKO6BZZGPyr+6bfr/V1VVKh5ZGBmNJPGprSapxxM5
	8U/pzMM80QUOOt9gB0+s6Sa94i9HHAy7Ffw06DDneP6brWM4tlxKstK545IswOn3L/r9NLfslie
	Twss1UTfIQJsCYDql4xOIo64NEYH
X-Google-Smtp-Source: AGHT+IGVWUhcesNwOFxohgkrPyNuC7qUPkPS2EtjoIKqKkFBbDW49r6kaqbMPN9EXskH/cWwGr6VL3D+OJg0p9BDDwI=
X-Received: by 2002:a05:6000:230c:b0:430:f7dc:7e8e with SMTP id
 ffacd0b85a97d-432c374f482mr611672f8f.34.1767736911389; Tue, 06 Jan 2026
 14:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
 <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev> <20260105234605.GB1276749@ax162>
 <6908562f-4a99-44ea-bffb-19f33fcffe83@linux.dev> <20260106215327.GA1957425@ax162>
In-Reply-To: <20260106215327.GA1957425@ax162>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 14:01:39 -0800
X-Gm-Features: AQt7F2qslL7fAItbRDdc7oFPU9cDDc5nfhyI6doo6y8Hh3XbKxYba62tOseFywQ
Message-ID: <CAADnVQLDNHQtoOuLNdwt5yZ1qnTEqcruUpZfPQMhfTHNN6XX0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Mon, Jan 05, 2026 at 05:06:49PM -0800, Ihor Solodrai wrote:
> > I got curious and did a little experiment. Basically, I ran perf stat
> > on this part of gen-btf.sh:
> >
> >       echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_=
data} -
> >       ${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.BTF \
> >               --set-section-flags .BTF=3Dalloc,readonly ${btf_data}
> >       ${OBJCOPY} --only-section=3D.BTF --strip-all ${btf_data}
> >
> > Replacing ${CC} command with:
> >
> >       ${OBJCOPY} --strip-all "${ELF_FILE}" ${btf_data} 2>/dev/null
> >
> > for comparison.
> >
> > TL;DR is that using ${CC} is:
> >   * about 1.5x faster than GNU objcopy --strip-all .tmp_vmlinux1
> >   * about 16x (!) faster than llvm-objcopy --strip-all .tmp_vmlinux1
> >
> > With obvious caveats that this is a particular machine (Threadripper
> > PRO 3975WX), toolchain etc:
> >   * clang version 21.1.7
> >   * gcc (GCC) 15.2.1 20251211
> >
> > This is bpf-next (a069190b590e) with BPF CI-like kconfig.
>
> Oof, that difference between GNU and LLVM's objcopy implementations...
> At the same time, it was only a little over a second for llvm-objcopy.
> Maybe that gets worse if more is built into the kernel to the point
> where it is untenable but maybe it is worth the reduced complexity? That
> said, my patch is pretty simple (and a follow up for KBUILD_CPPFLAGS if
> needed would be equally simple), your testing demonstrates that there
> is some performance improvement, and I cannot imagine there being any
> other bugs of this nature in this area going forward. I have no real
> strong opinion, I just need my builds to finish :)

Pls resend both patches? Or squash as one ?
Sounds like the current one is incomplete.

