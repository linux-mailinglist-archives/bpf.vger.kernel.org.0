Return-Path: <bpf+bounces-78189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CAD00C28
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6070B301511B
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91427A45C;
	Thu,  8 Jan 2026 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5hJu33h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989E272E7C
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841372; cv=none; b=dHtg8a6YT0+1v6R6lqV8XLl/GR8kADf3zpRME/F9va5/2HQG1wQm/cueymtSrmRSRdNbWR5oWviYx84KM7hPbXMsh5XjwuT5VbgVLH5pXrhoO0Ss+ndDFxb4p/w97+MVcTFAQ9E3YMcDJujDFnyUf1oJISjqlP5Ryg8Ib10YC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841372; c=relaxed/simple;
	bh=a1RoPEBc3Wwr14BkNfsBMLUakvIh0moEc6K1EVQg+VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG7UmoeCn7OsxzmhLJyQlPaHjfc1IgaHzN4u1sfsXZ9+lqZQwmgF9org6kv3MAgIboK4jhOwhMdb3+RLI5MMJeFQGv2f5XEY/XcAfMcjfEUG6pAwHgVqOSqCvxW0cOAQ7j4sSNlmeZhZCbG3dXXJUY43CgHVdHGcI2eZVmIUjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5hJu33h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so27504905e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767841369; x=1768446169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY0Wa1WSCYpKugnUdEH4qnlMyznAtnS0fsyNGN8xDaQ=;
        b=W5hJu33hoo5YWNtxoY5QrA2DwZ8TemQzQitYCsyGvO0iPyEU1imnlB80Tq+jYXsRU6
         fiwR09Li44vhpgdLxwBKbyLyomYktAB7pLMXzwiG6/bt7MVWXgEBaHwkF3ZyefHN7E6T
         Eamfygr68E0LWAFlP31lJpm62OqDnyFE+6eCNs784v9MH0xzigh/rMuVFOMILWqPtRW1
         IbDuGhpVsA9ZRVaZ8OzatcQxUoU1BuFG/99ryBeP3u3sXleltOh7FgzoNB3J4gZDfBGu
         xlrwV2lVrKOnyiPJmjekoxNwgrBCVuHtQSig6YVYEW2r8OysAI2pd6oGQM9F8FnaPifD
         4Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767841369; x=1768446169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EY0Wa1WSCYpKugnUdEH4qnlMyznAtnS0fsyNGN8xDaQ=;
        b=w075df1IMXCOXwpg9gxJExt43pOTW6taMUIk9RbQPvZW4J9MgoGpee+WLEoN0v6NaN
         H5kw1RgheUp9ANUO60ALitBgshDTY6VCMZFhyyqTzrescpmodlMbavPoUNl1Ay572DaY
         BzbaRuqspvq8PxHA56rRb6WCTJYOI3UExPDmup67WGs0IhGI66qtKZu6ArPL2sWo1Psa
         EYdSYexqBb6MmJPp101yTm87jfmwZvMU1NN/KMNK8s3eR4RjBJ8RcfrplHTs6W4qOYnb
         vmThRXWgKw0pq+ivYm5O8tRCGnb5bhrdeO+kxyzhsKarwnmpn416Jg1wSNgZqPvT2Hjx
         rXGw==
X-Forwarded-Encrypted: i=1; AJvYcCVsxkA/V4DSJgTvJ2La793xpHwABRWkKihPuXOmF0avQfOZcQfunsgrZRP9wt3xfJp8hfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PeYED7fX+vdyCO98xDQGRpG7aR1Rn1S8t2GiRidoxtuMtFYT
	QvGCSmXANYG4HuJ8nvxliwWIV4m7rH64iflkOWxmeOutyARgMVdTxHhTpyajUpi+uI2xJOjbN9c
	gqoJgV3K31BWtU57tSe3z++CtDLrtSM8=
X-Gm-Gg: AY/fxX7EL7VORLXBafq0r/22XRLvmbjvE9AsxeaNktHwopPRVAyzDKeLoTmFRfYXF+p
	LEir8pVPTIsWQINmwMRbt0GlDASNzmAQg82wwIUKb0ZEQ/pCh7mHpeFt+ym8epJur8R/IGBoj9K
	RcOHAVKIeta6Q2ouVcwGz6khSgh0sbSreAFhbPzXSwldF/RBpObEIetZr9SvOa8Wq9MrWQJrgcG
	Oq9jTekZMDCYZw6BXsDdHeT276W+ooMjtsKBwd2rkHU9qzov1J2Gh323mWt7qj+Ddk0B+yYZeeq
	58XDKn+2/HH7y+HE57PbGJymFKsc
X-Google-Smtp-Source: AGHT+IFW66HRut9McAB8OEPWLeJFLNhe0/dDJVE93tL54XTWKmtvQQkTSQ8hA2441xczEvpcbAVxYSHf7hqnV2fwp8s=
X-Received: by 2002:a05:600c:4fc6:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-47d84b0aaa3mr49166775e9.3.1767841368671; Wed, 07 Jan 2026
 19:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <695bc686.050a0220.1c677c.032f.GAE@google.com> <tencent_8D33CB9E2A1B8D4B511BB0250FBAA8BB8708@qq.com>
In-Reply-To: <tencent_8D33CB9E2A1B8D4B511BB0250FBAA8BB8708@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 19:02:37 -0800
X-Gm-Features: AQt7F2pFxMkZPeYscSWsMcUQcIaqgB9d00Syi9jMit8X8Vd3bheI37TGkZZySQE
Message-ID: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Format string can't be empty
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:39=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> The user constructed a BPF program containing a bpf_snprintf() call.
> The fmt parameter passed to bpf_snprintf() was not assigned a value;
> it only executed the BPF_MAP_FREEZE command to freeze the fmt string.
> Furthermore, when bpf_check() executed check_reg_const_str() and
> check_bpf_snprintf_call() to check the fmt input parameter of the
> user-constructed BPF program's bpf_snprintf() call, strnchr() only
> checked if fmt was a null-terminated string. This led the BPF verifier
> to incorrectly assume the constant format string was valid.
> When the BPF program was actually executed, the out-of-bounds (OOB)
> issue reported by syzbot occurred [1].
>
> This issue is strongly related to bpf_snprintf(), therefore adding a
> check for an empty format string in check_bpf_snprintf_call() would
> be beneficial. Since it calls bpf_bprintf_prepare(), only adding a
> check on the result of strnchr() is needed to prevent the case where
> the format string is empty.
>
> [1]
> BUG: KASAN: slab-out-of-bounds in strnchr+0x5e/0x80 lib/string.c:405
> Read of size 1 at addr ffff888029e093b0 by task ksoftirqd/1/23
> Call Trace:
>  strnchr+0x5e/0x80 lib/string.c:405
>  bpf_bprintf_prepare+0x167/0x13d0 kernel/bpf/helpers.c:829
>  ____bpf_snprintf kernel/bpf/helpers.c:1065 [inline]
>  bpf_snprintf+0xd3/0x1b0 kernel/bpf/helpers.c:1049
>
> Allocated by task 6022:
>  __bpf_map_area_alloc kernel/bpf/syscall.c:395 [inline]
>  bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:408
>  insn_array_alloc+0x52/0x140 kernel/bpf/bpf_insn_array.c:49
>  map_create+0xafd/0x16a0 kernel/bpf/syscall.c:1514
>
> The buggy address is located 0 bytes to the right of
>  allocated 944-byte region [ffff888029e09000, ffff888029e093b0)
>
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf"=
)
> Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2c29addf92581b410079
> Tested-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index db72b96f9c8c..88da2d0e634c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size=
, const u64 *raw_args,
>         char fmt_ptype, cur_ip[16], ip_spec[] =3D "%pXX";
>
>         fmt_end =3D strnchr(fmt, fmt_size, 0);
> -       if (!fmt_end)
> +       if (!fmt_end || fmt_end =3D=3D fmt)
>                 return -EINVAL;

I don't think you root caused it correctly.
The better fix and analysis:
https://patchwork.kernel.org/project/netdevbpf/patch/20260107021037.289644-=
1-kartikey406@gmail.com/

pw-bot: cr

