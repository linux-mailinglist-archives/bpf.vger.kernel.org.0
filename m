Return-Path: <bpf+bounces-48878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED80A1159E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D1F7A15AF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AB2135A0;
	Tue, 14 Jan 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7mlM+lJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8414883C
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898434; cv=none; b=qKx29vpDK25yDQk4xJ0GKDx+8GbTPQcFrAQcRSyUXxAmAf265vF905U9X5T24bgXvCitLNWqy5XHksjc32PY//r7Qaf2eGJ/C3G3IDhNn1pRWnLhkbXL2Vf/++V1rcsWQ/bWsRoFU5hfFAS3auWcW3ZrGcMALMiUoSGIwf4rAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898434; c=relaxed/simple;
	bh=SGS5XciF/DQbKlqJW+hvceSspz9CFuIyb7lYQpLbfjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7EOJTi81nHVeeZbIUxFsL8NMZCgNV54myHAlMx0S35NxzPiE/aLL1TRYRB7febPy4Y3PzAGSRRt97+VwvgMFKQqGk/7/TGBaVU0XvqazfVGsgi6sr8E5m5oEtequdBKDVrM/OPS7Vj2qVnRpc7aF0wLyowQ/B93vCiVClkA0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7mlM+lJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so8356331a91.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736898432; x=1737503232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUuN0rD6Ts0aOurs1BeKX1yRLyAIAVscm0p/4ALjhLg=;
        b=g7mlM+lJ6Mh51h0VAhbCnVEW18txZI55BH9PAw5cDLoUP/BCC40coIUVj6JHhWN4gf
         av7XWaSAHn94lEK65hkWXLQB/Vf0tJRmW4tW8nJb+7L+R52xe87f42huHqSIDhG9PvDk
         W65j+t7omyC0nEqvDU7KpF3OFM3uPzhExiA5fYa1hF+dZwpeNlSSH6oPdtPD1Wzdf5uq
         covxnP1UE/0MRX+qURivVveD23Jj5BPtzusyFP6BILVUdEn9CBgH4gydUDgUg03Vn363
         eyFteW+1zFVnBGScitDKHah8/F3fJQL2kBAM/V7kK8Pr/xE5SacLClTOfat95wzncqsQ
         AKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898432; x=1737503232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUuN0rD6Ts0aOurs1BeKX1yRLyAIAVscm0p/4ALjhLg=;
        b=t0X1tV6UwQVkDKGgOH4knO44EgkQActIFOWzu23474qcgXCJ8RyjySPzVjD54iJnar
         W4Ak7g3Eq1g7b+ZUzTKEF0uSlGdV85twmnXmm4J4TJoKwcC3t0WMwhXVaalUFS0nIKJn
         OOro2IdqSLBMN6cXbKgn+5YeSyApKE8Ew24CRVj6ZKOJLLGf3f3geWActQm63UhZl1hu
         JwSbwW8pQZNx1/8VwyoLX0KSKwy8hlyC4yH184olWCzWjZyFsclp/2y465MR422yA6o/
         RPiQoK3KXkYBmxRy19BVzKfyZp+soUhu1oeV4XEAiEO9CAcYPq2spOTkFAdRtPSecI1f
         TiCQ==
X-Gm-Message-State: AOJu0YxuPGKK0ff3IoX0yYqA6PmVhG4jQP/ct9+bAJTZxB+yqvGmEWiY
	94AdRZNNvK2nYaRV4AptbD+wnlFBUNezJs+xRTtrVXX6MXEKkl40OYXfl2TtSmcgqBwoHChbfwY
	zgLbecv+Kwm9k2sMlsTFJZCTBW38=
X-Gm-Gg: ASbGncu97WeS5NDfMOVPK2kRYU9xWvs38PXT3CHMNS951noVIBIxREwS/SDNTg5px0/
	Y/ViWmLGNV6rPzl9gE8gQka6ult2zW5doxOf3
X-Google-Smtp-Source: AGHT+IHyvxwrriG4f227by9duMuMq8ovsm9Y572fygs/z8n0x2V1PGf3lv+anthOeSuX2IyqMvmcleafsTh+yPtVt1A=
X-Received: by 2002:a17:90a:d00c:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f548f1d783mr38047011a91.29.1736898431950; Tue, 14 Jan 2025
 15:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114140931.3844196-1-pulehui@huaweicloud.com> <20250114140931.3844196-2-pulehui@huaweicloud.com>
In-Reply-To: <20250114140931.3844196-2-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 15:46:57 -0800
X-Gm-Features: AbW1kvb7nc8MCaN3p32vALnPJ9sCc16gMWGPcfhS3_UPYBYQqc9ToprFFaQKGDA
Message-ID: <CAEf4Bzbuw_ZskaUti-s6bSqG9peRf1Z+oxp9G80hEwBGrW0CQQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] libbpf: Fix incorrect iter rounds when marking BTF_IS_EMBEDDED
To: Pu Lehui <pulehui@huaweicloud.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:06=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> When redirecting the base BTF of the split BTF from the distilled base
> BTF to the vmlinux base BTF, we need to mark distilled base struct/union
> members of split BTF structs/unions in id_map with BTF_IS_EMBEDDED,
> which indicates that these types need to match both name and size later.
> But, the current implementation uses the incorrect iter rounds, we need
> to correct it to iter from nr_dist_base_types to nr_types.

It's hard to understand what this description says without looking at
the code... the "iter rounds" and "iter" is very confusing, because we
are actually dealing with type IDs? Can you please reword to make it
clearer.

Also, why don't we see this issue in our tests? Can you come up with a
simple test to demonstrate a problem?

This looks correct, otherwise, but it would be nice for Alan to review
as well, thanks.

pw-bot: cr

>
> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/lib/bpf/btf_relocate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index b72f83e15156..53d1f3541bce 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -212,7 +212,7 @@ static int btf_relocate_map_distilled_base(struct btf=
_relocate *r)
>          * need to match both name and size, otherwise embedding the base
>          * struct/union in the split type is invalid.
>          */
> -       for (id =3D r->nr_dist_base_types; id < r->nr_split_types; id++) =
{
> +       for (id =3D r->nr_dist_base_types; id < r->nr_dist_base_types + r=
->nr_split_types; id++) {
>                 err =3D btf_mark_embedded_composite_type_ids(r, id);
>                 if (err)
>                         goto done;
> --
> 2.34.1
>

