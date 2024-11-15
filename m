Return-Path: <bpf+bounces-44987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39699CF556
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F712822C4
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DB1E1C08;
	Fri, 15 Nov 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUT0tYdg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46616D4E6;
	Fri, 15 Nov 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700658; cv=none; b=DjGYx+0oqh+HNtPs1Xm0QIkkFsIafiSD5u+HftcJhu0FEn+Eni6htsEKUzBZQfKAjYW68/dQQq6AXNnPXVwe5VtUhe/V71Cg7OLK+mfhDC1Z06NnD80P4DWYBKDiZJEVwGdiZ0A6TQWc7j8rjQbyIWx2FTwW1+WP6NJvdoxF4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700658; c=relaxed/simple;
	bh=EHiLgshycf1eieqiOpzzDDPKAvfiKoyQOr9THsKU62w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwUDWz+gE0nMzObfA33ty9VevvhxTRGiEY/IvFscjF5SqcNnGuVoqrIWwwkwRnTV24bVCwJfoZMcnqirUtl0IESn+lkAAu8o5h77TBiBi+nzGfvGTbS1ACMaf/EIQypbjHDpkNSC9lgQrOw5vWobPeo6pg7iSV0c0+jS8N2GuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUT0tYdg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-723db2798caso1947549b3a.0;
        Fri, 15 Nov 2024 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731700656; x=1732305456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xwg26uJqyJJNoApjHYibPOjhnbtOYqw9dx9vp0pAww=;
        b=aUT0tYdgWd3lOGZiPCJo2v9N1AfX84d/1fM3m0su0CzvAdS3/y9MAKm0EfO/x6wolq
         HIPc7qWVKQ0G7ojG9YBJYKvz5y8bQyQxL+myvUBhatPjBL9pXE6/lr4PzYuaiJcSN6nR
         YYGKwZ3nY/YV2fDfJx4Y+eifNylURBB92WRnIHEslioXBliusvoXS18PgNJdbiFWcuyc
         gYAOFRUpxJQNKNTgUFTGsN9Ldz8JspLUfP0HVCfI7pvvBPtSPjwl199Yk7q0MGA3EDKb
         OBsaUCABdVWyb6VTBWlLUpd/L5rSwURZrCgpA6GajW2F76R4mABBSJ8RxxT+MDr8kBIv
         IW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700656; x=1732305456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xwg26uJqyJJNoApjHYibPOjhnbtOYqw9dx9vp0pAww=;
        b=qFAr56M6BbSW9OFn04E/2IdIwGDJesemGwjTFU5uE07tl8XCHg6kUW6mybaZccsyDC
         HW7/W1SgmXS04p+kutzmt1U38dX+mA09ZvZgzGqBZoaJhBz5WCA2qh46SjkX4i5CTUQX
         ErB0EK85ZIpRXuoZI9WG3zezSJjIPxfe2JecDGCo0+tEUjJcHb5Zt95p/Pks9F3Q5o/K
         1XOnBcTi0/qb2npP1AWNPr8kkv04xFDva4S4vl2w1GA6Ptp00ln4u/FQKEspzPhA3Fc8
         NeNIfiAwpxcUAs9OdAGsM3Q3PLLjEOwU4qk7JAHxdpDOWLLKQcQPDMNwFr0IDRVS+wFx
         l3nw==
X-Forwarded-Encrypted: i=1; AJvYcCX4fnTx97lFhvWKE0P3OZtSSdSNfUYu1L7hcfAtYgO73feW948B4ixNQLZHXanaUxeSi5X/+38vzCIftFJq@vger.kernel.org, AJvYcCXveXJrCEp93hAbJBRpkuLBLpPk004bmbK/gDgZqlTDlb9cghjzlUgrfidoExmwQJ2b6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKBNHmTRTpJ5ZH+lfWohsW/dktWasaY/rK+d6DQLUl01IaCRw
	b7mvyNkFGQJGv8zqMQ1HSLB8w9y7hYVvectw7397n8R2Sueb/uTWB8VjZxa6pPrR6BuBLKZ7EHt
	JZcgEIt7z2eVgCxOwomOhRtWh9x8=
X-Google-Smtp-Source: AGHT+IGtcGamPjh1CkOd9RJI6X+OCqPljcJPXvqCzPOoiRWyDCtXN7lFmzHEouLVnuO65mUnUDFdkVpMbo1BeACEEPA=
X-Received: by 2002:a17:90b:4d86:b0:2d8:dd14:79ed with SMTP id
 98e67ed59e1d1-2ea155943cbmr4259464a91.31.1731700656505; Fri, 15 Nov 2024
 11:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115103422.55040-1-sidong.yang@furiosa.ai>
In-Reply-To: <20241115103422.55040-1-sidong.yang@furiosa.ai>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Nov 2024 11:57:24 -0800
Message-ID: <CAEf4BzYape9gtc7k1NQMD5BrfakzDXV_9SHNqZeamcaSKn744Q@mail.gmail.com>
Subject: Re: [RFC PATCH] libbpf: Change hash_combine parameters from long to __u32
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:51=E2=80=AFAM Sidong Yang <sidong.yang@furiosa.ai=
> wrote:
>
> The hash_combine() could be trapped when compiled with sanitizer like "zi=
g cc".
> This patch changes parameters to __u32 to fix it.

Can you please elaborate? What exactly are you fixing? "Undefined"
signed integer overflow? I can consider changing long to unsigned
long, but I don't think we should downgrade from long all the way to
32-bit u32. I'd rather keep all those 64 bits for hash.

pw-bot: cr

>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8befb8103e32..11ccb5aa4958 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3548,7 +3548,7 @@ struct btf_dedup {
>         struct strset *strs_set;
>  };
>
> -static long hash_combine(long h, long value)
> +static __u32 hash_combine(__u32 h, __u32 value)
>  {
>         return h * 31 + value;
>  }
> --
> 2.42.0
>
>

