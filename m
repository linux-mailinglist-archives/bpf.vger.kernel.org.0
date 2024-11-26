Return-Path: <bpf+bounces-45642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5C9D9E03
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC62847F8
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA01DE894;
	Tue, 26 Nov 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjU26gzM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1271DE3CA;
	Tue, 26 Nov 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649196; cv=none; b=pidu0ZG1MmA/Bho4KKeqvBfhK7jsuahq0ctw71+zEdA52xDSEKKt+i2M7lBgddcDIIRiFQiYfBHXUPKPu3/pv2fBZrQXYCf43vIZA9nedP3lYernABwN3k47VLOgkidf1+JzL6ppPjNBPYri72SE8/oxSSjGGOEJQHAPxXKHF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649196; c=relaxed/simple;
	bh=a0N0Nikb2ppGmyDS/EfrhIlYMCZMTRO4zbkKUQc92h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHqB9tHH+G8XmHOV8lJCBprdFINDyXwGnGozuG5fFP8sohBRKtYtHr6jPlY7+1w7TZYuZz/iIcNRBcpoivnkNNccNZ9L6xzYafjrsw+EU1xrGEth8dUimMdURauqhpb8GtTpFfp4kTzzzG6rbhm4aNcR/4TWAXfKTieHQcbNgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjU26gzM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2124a86f4cbso53678595ad.3;
        Tue, 26 Nov 2024 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732649194; x=1733253994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTDkAnq2+7FInGjOGBkSG3ELuDlns35SYL/g3aTt6w8=;
        b=IjU26gzMKzpJJ04IlXiHFqk4yLsFLKbHuCKJ9/e9082IZrH659XxtIHtmsrCB2SefD
         +72DYrE7HAeJ4wWa7WhK4XrHzDtGOEiYPeGElbXKk92UGNGYjROEZk2EL/UwFVynCSsD
         s60s2QBQfCC/vMatKEK/GWpDWx2pWig/TkqRyB9xs/UkwanGtNCdRFIq70q2omfdnxM0
         JhH3r7gmrUrpHN/cbwBgbBzcxG04yjiYh6sL+7FHrG0FEgkPSjUdiS79iAnfNy/dZlNK
         1XLARquNmPlRO52E+JQHG6aikYgsBBGXXn1QRCcZ/8XJyquoonP7lh4VSLXE8OZTZKgZ
         VrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649194; x=1733253994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTDkAnq2+7FInGjOGBkSG3ELuDlns35SYL/g3aTt6w8=;
        b=Mt+WMOHO26oXYlMrJc8MO7VCOhsPkPl0A2xB05sm0Yt4t8TDfZcUFNKMEhb1MlWhg2
         QffZMb/TECKCwGf56nFHTwpepgNPjx6MC97sJei3ip3CikYyfq8TetT5Kl/UYmxEdAxs
         UQSEQ/gxS28EaK3BNUz9iOeVTb4O6p6AGKhuRpigxYz5K9iPDi8gP8b9RFBz64yzgRyg
         /yszhCt0qg2wN32rKdhITpaCzHAlAEGbBC3nh9RsDZKgo8dj8WV4hoVH/An5wBRU00Il
         8OD8txHrGeOjha/OdNNrAsHeArR7gVwdaYPuGj+hqrk8FNdhvbGQytYC183lCqmK3fDP
         KIGw==
X-Forwarded-Encrypted: i=1; AJvYcCU1iFJyvXQH9nxyhPQxdk3wwwwGRFKDA4+rsAw9vP5OC4objzuds9p0iV7vXxGCbN07oW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5K74hmCNFvvrUn1jDk8wecxbmck0rmuXK4z1C0jDPRmN9+HH4
	ZGszd36WAVrj5qV9GmTvXcVDqhI7crFbjsGU8sIH/ITgEhN+HRyHi1I58BX6xKN9lRPROhV8DQ9
	fLA00mNISw00g9iCopwqiK5klI3U=
X-Gm-Gg: ASbGnct6m86nR/StTvg6ifC9kdZU8MUPsJO0hyK3x5K7qbX7KNfzNJ4QzefV0Zv2+E9
	7/v5hPdw7MQQWtJ5aHdT7tBoLOYBbiH4wAtqN4TYHMFJ3XL4=
X-Google-Smtp-Source: AGHT+IE6de1p/fVdq+y3Oszrz6EeYn/HBw5EuO0ubtjKIH7TZxU9cH521y6YWUBmY8ENmnbXgU2YZEX1n3rL4NTx6DM=
X-Received: by 2002:a17:90b:1bcb:b0:2ea:874b:7da7 with SMTP id
 98e67ed59e1d1-2ee097e3a84mr590657a91.33.1732649194005; Tue, 26 Nov 2024
 11:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122070218.3832680-1-eddyz87@gmail.com>
In-Reply-To: <20241122070218.3832680-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 11:26:22 -0800
Message-ID: <CAEf4BzakAiPWF9x2h-F737LbJ9ovXCJLbXV9R5vKg0Et5CbqSQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> kfuncs present in the ELF being processed. This section consists of
> records of the following shape:
>
>   struct btf_id_and_flag {
>       uint32_t id;
>       uint32_t flags;
>   };
>

Can we just set data->d_type to ELF_T_WORD and let libelf handle the byte s=
wap?

> When endianness of binary operated by pahole differs from the
> host endianness these fields require byte swap before using.
>
> At the moment such byte swap does not happen and kfuncs are not marked
> with decl tags when e.g. s390 kernel is compiled on x86.
> To reproduces the bug:
> - follow instructions from [0] to build an s390 vmlinux;
> - execute:
>   pahole --btf_features_strict=3Ddecl_tag_kfuncs,decl_tag \
>          --btf_encode_detached=3Dtest.btf vmlinux
> - observe no kfuncs generated:
>   bpftool btf dump test.btf format c | grep __ksym
>
> This commit fixes the issue by adding an endianness conversion step
> for .BTF_ids section data before main processing step, modifying the
> Elf_Data object in-place.
> The choice is such in order to:
> - minimize changes;
> - keep using Elf_Data, as it provides fields {d_size,d_off} used
>   by kfunc processing routines;
> - avoid sprinkling bswap_32 at each 'struct btf_id_and_flag' field
>   access in fear of forgetting to add new ones when code is modified.
>
> [0] https://docs.kernel.org/bpf/s390.html
>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  btf_encoder.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  lib/bpf       |  2 +-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>

[...]

