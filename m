Return-Path: <bpf+bounces-65468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9DB23BB4
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF1A5831DE
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297E24BCF5;
	Tue, 12 Aug 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axsI/Rgy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522282F0687;
	Tue, 12 Aug 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037203; cv=none; b=HLMqDyet4Y5oQeONZmnBIl88OnpyguBHUuTNgjtWwomG4oKIjQfoFeHRqvo9qTE8tcrkTghDJ6Ooqz3C3NEgXqxKzNi7+AXctJF+UhxC8fWbSLO/k6Z4UNLiOec1H3pG1MzLt/pfe3fet7eKm2IIFiSsZ8lfhEGFL1EqUV2oYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037203; c=relaxed/simple;
	bh=eysjhqI/afCve3wZHEIHtFpmTM4kswjIrhnsd7eD/XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMGESDmC1oAmbaGgvzu5h+WKC3KVV/TD7eDfEYyRODW1B1Wqy/7FzF5jfGlShva6MphVjfiFFQn1VYkVQHdDyd3x1F1pwbHDiVGXFqNjNkqJShQlVXLntkW78Dy0VQon6xjS3AB5w87hQG4Y22kCPMqZKkNT9q3RecodwfnhMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axsI/Rgy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3218283cf21so3830037a91.3;
        Tue, 12 Aug 2025 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037199; x=1755641999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GtUZpxWGPMnm45Y1seWoZ3VRsYHK5Qk6EDxRyZXjnc=;
        b=axsI/RgyAFjG2rpvc05ErSaTh2hStwhu4uKGOVB/oO2ijyFho3oxSoOdk3p2UWmbfX
         hXLC2EzupRaHTPKb+Um4NcDMlUWneCNWXUCTA+xVsOBNVZLPpuyGXZfAieNFpTedmsAc
         iJaeaf4ICfL91LSfplWWuwmyv1ljOibi9QL6FqQ6BJh1/slbmenAuU01jpHFb+Wo3U0K
         9tsaZl5vsXwFA2KBCpKigsNhThIDBT2IlqFYiq8maQTwgO3kYNLON3kAlVrEs3hehBlG
         ElrBsLoxOIdZ8YKOl9V9Dao3L7tBBU4+LzQOfA+GJNtfScrUpGdNCUUJ4rP4UGcLrdcL
         TIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037199; x=1755641999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GtUZpxWGPMnm45Y1seWoZ3VRsYHK5Qk6EDxRyZXjnc=;
        b=w3YVq+AfiXrIKT34ZWE5fZCEEvMGi+u1ROSlHFs0/7FHiwpkcdC+WROGx/LSQLINBP
         lSdXrFvEIFwqnQA0VXJOChtpFnx5HlDFfepptyzzAPFVaVJjnqhXmP2VarzstJaPJX58
         jEI3GJptueNjc3w1xNW7fQey4kiMil3ww6Egy8BaPaBYngZazxJFXutfFWKFjylhyf7U
         zftILY4K0pOgQJI97va6ODF79InxEJHeDK3g7LZuL+brmoME3Lh3vD2fzJ9s+jGZPIBy
         9keOau7gN/ko+Yo1GInq1gjcgSfC+23C6eTa6OrSL6icwIO3t3CsQAgZ78eHNnOezDGj
         1qWw==
X-Forwarded-Encrypted: i=1; AJvYcCXFg1AjujVjHoQkkoI5QKIXsyAWsPv0kt391Y4QHBtHbDl8aWF1VlD2g6rxglSEZNy6mDaw51pDoc3+ZmoX@vger.kernel.org, AJvYcCXdoT5g/IZ0BUjFb/OAeydj+5ypa+qfjw0wJwegcErJDPDOybY5dt14qBd+veuxg3B1720=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzys9ClrSfVeGRurY7l10Eu520LgAt9MmFn0kerVqLlEOHYNNBT
	5TGJbqhIyh9bzlBBvX6ybhYXNNnwRostVeaZ4G9s1dJL4uKAvgursbeUcOdT+yj21PorICKq07d
	sZ/OLeXREAivBhEm9G2YE35S3eDM9cwDloUP3
X-Gm-Gg: ASbGncugRV7BbsyERT4Sr04iSA5grnCR2x5gFFJFZ4uDOsG2pGroM69lbt6YLkocxYJ
	DKCCWeF0Ov4v+nhdQxP8j7oGoHxPZla6nLVteIUGiap0nB3FQIk0RGkEFYaEr2nDKUaAlpNJb6Q
	ER6dVF2WgIHKVT8QVA6o8e9WbnAhwWfWeNZ+CxfRNeSbBGrHO+rA7rYZfBuqyvkHKgy26QRsDyY
	ISFimld+nztk9tJoK90OHdOtr+YJkBa/A==
X-Google-Smtp-Source: AGHT+IEoxNw/25h+kYmYetGbwyKccTHv5wKUt1LAlFh6b72gSVE3a/fBzjgeLWyRNqaN/4R9Xl1yYxiFGdm4GAKxuR8=
X-Received: by 2002:a17:90b:1b4d:b0:321:59e7:c5ba with SMTP id
 98e67ed59e1d1-321d0ddaec9mr997606a91.15.1755037199396; Tue, 12 Aug 2025
 15:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
In-Reply-To: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 15:19:45 -0700
X-Gm-Features: Ac12FXwRx_cExOm5u9LHQWDJ0mtLb9jdTKaXrJHE7V4pl4NU0b-eSrLLbh_wrhU
Message-ID: <CAEf4Bzb7DFwvh6J8sPv34U+M=prFKQ8QZiJAk2SE5hPvy7DG1g@mail.gmail.com>
Subject: Re: [PATCH] bpf: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:08=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
>
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/linux/filter.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 1e7fd3ee759e07534eee7d8b48cffa1dfea056fb..52fecb7a1fe36d233328aabbe=
5eadcbd7e07cc5a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1296,7 +1296,7 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp=
, struct bpf_prog *fp_other);
>  static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
>                                 u32 pass, void *image)
>  {
> -       pr_err("flen=3D%u proglen=3D%u pass=3D%u image=3D%pK from=3D%s pi=
d=3D%d\n", flen,
> +       pr_err("flen=3D%u proglen=3D%u pass=3D%u image=3D%p from=3D%s pid=
=3D%d\n", flen,
>                proglen, pass, image, current->comm, task_pid_nr(current))=
;

this particular printk won't ever be called from atomic context, so I
don't think the leak from atomic context matters much here. On the
other hand, %pK behavior is controlled by kptr_restrict and that might
be useful for debugging, so not sure there is much of a benefit to
switching to always obfuscated %p? Or am I missing something else
here?

>
>         if (image)
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-restricted-pointers-bpf-04da04ea1b8a
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

