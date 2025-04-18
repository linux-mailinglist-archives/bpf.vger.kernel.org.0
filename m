Return-Path: <bpf+bounces-56231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523EA938A8
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1447A18851AE
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2A190072;
	Fri, 18 Apr 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EavZmFmC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36A45009
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986500; cv=none; b=B3Y8qjJ+3QyUeEL/d7iJOogVo+oXWO7QyH5LMyd/cr3+5r2YzifkTba3eVzgJTOQ7LW/GpKDkG73aqrierUMUbYKZxreb2NSkQbuK0K7Uf6csusIH5fe/3Qww1O3igKeuDK/tHB8OOkHMIUUlOYItlWXjFCaWWsUNBbh0iBVjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986500; c=relaxed/simple;
	bh=fLniYQXLWkc2yayv5IhAfde0cm5/dxdE8BTWK0RhKmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0M/dEGe74aUBKPr4mPy2x3QPNsWRUez2yApIapBEZm110+sy7h7YepcZPnxct1kfepV6Qm34fzV0vhYmmuoplQlUkbtExkTkMESwVXIrLARPxOZJw2WN1VxROO970D44sq+3YW5BwKsj6XyCBjPin/vHhuiAKD9r2thqzbN15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EavZmFmC; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac73723b2d5so360386166b.3
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744986496; x=1745591296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8m9w/9cVC/r98mKo+lQUa8z68XnzfVJeBB+ZtpmkVHI=;
        b=EavZmFmCDwezZHD2OO7ze9exLc9eILBZmm6bomjhfrPls1+bkTxiTMmI5DDC0/y2vT
         KRJ58Zo7mzmM6xvO0rLfe7smODAo1aJjQDj3Kw0BPtTiCJzb/xzBDQK7jV2ESIgWhuCH
         MU9lACMR/7Ac96T3SKrB7i0uRCB88D+iJOdcMn4uKIUfTWJbv3TSR+/bvmdxAN2RlcRK
         hRdoEo9K3edbo9tugHzYRnklh7Zvg9rW43ek9es2sUOVV+Daz6xfkxJ4IYJ6okIMteJO
         BC+ffL/aTMgHvNO15h0PDtANAl2oDu3oh1ELV4ZeA0uMHLUyH98izcgElj8t58CyJc5e
         pMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744986496; x=1745591296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m9w/9cVC/r98mKo+lQUa8z68XnzfVJeBB+ZtpmkVHI=;
        b=dCsgs4BB5OQi60k3XTIq8d270rPHNh6HPfbGjGBpEcOJ5pJm7LJb+94JUe7OuEtlsy
         vVI0dgdqBJ7PXrbjWVaB+eRjwQ3EUKr5zW/tOWWy101Z7TZPaMdj0Zhn80w7eqJXWxti
         azSiOQcfldhIVBrIjHRLr6A0RJkOZAH3TgFG2S4OE9NbQRrWV7KH+BVRH9Notjh5ygWa
         y0/c3Cgfrd4oNkw5XPxg8a5e87aDDrj4WvNR4AAYmKVsmrxyKL/zv9nj23UHESjDZy8s
         ko7HPzPbiqGRQso0m7Rs9UJMg3nfkGX1juExvZ8rqO7MXuNG4/+BsG1j63z1/fiZxY/R
         j9sg==
X-Gm-Message-State: AOJu0YxfZ87muNYG1iBq4DlSAYNAh7rIoTUZhHP1VmPn5iqNa4RTtHFU
	xOkD8L9XZAzWD2P/8ldo3DRbjGOeUgw3qXQbfug1K4/J8ZZIogTkjRssIyYSXMjjEj3I+lDL57Q
	U9biavIvf0e+fTXtXxtFA9E5ioUk=
X-Gm-Gg: ASbGncu02DSKBcrgzqIUBY7E2iDxvgscy3WCIcQrHsvRN+B8YCtDuwz8tYCMz2/uA7+
	oL4SwQLNo4hnsNAVT2UGYPtnX7bsmlloXHOOZbfA36mUYYlwzCye5owRKUeLAb44VBeOuqI65p9
	la20ZB08Xm3g2Mn8HAH0WZyOeSrcTOANSl8JYo+GaBhe0=
X-Google-Smtp-Source: AGHT+IFU+SW8OABctmjfDKlQXkyRVItiWWQgq/C8YAXgKvlh6EMn4YvThXXtjCXA6VDQCfztSdsFYNlbnoWPK3sG/6g=
X-Received: by 2002:a17:907:743:b0:ac4:3d1:e664 with SMTP id
 a640c23a62f3a-acb74d9a2edmr280127966b.46.1744986495663; Fri, 18 Apr 2025
 07:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418074946.35569-1-shung-hsi.yu@suse.com>
In-Reply-To: <20250418074946.35569-1-shung-hsi.yu@suse.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 18 Apr 2025 16:27:38 +0200
X-Gm-Features: ATxdqUE487ObUhl_A1P-O9mG0YhSL_kFu_utXbS3KfRdAj3RsXo4T4faKf4svzU
Message-ID: <CAP01T75kHzkyhnYhSWkSy5X3qyjE8bSvSouTZogQ=vWyK78iUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: use proper type to calculate
 bpf_raw_tp_null_args.mask index
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 09:49, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> The calculation of the index used to access the mask field in 'struct
> bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
> the tracepoint being attached has more than 8 arguments.
>
> While none of the tracepoints mentioned in raw_tp_null_args[] currently
> have more than 8 arguments, there do exist tracepoints that had more
> than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
> type for calculation and avoid Smatch static checker warning.
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

Not sure how I missed this, but thanks for fixing.
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfa..656ee11aff67 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6829,10 +6829,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                         /* Is this a func with potential NULL args? */
>                         if (strcmp(tname, raw_tp_null_args[i].func))
>                                 continue;
> -                       if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
> +                       if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
>                                 info->reg_type |= PTR_MAYBE_NULL;
>                         /* Is the current arg IS_ERR? */
> -                       if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
> +                       if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
>                                 ptr_err_raw_tp = true;
>                         break;
>                 }
> --
> 2.49.0
>

