Return-Path: <bpf+bounces-46733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D929EFCC1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD2B1882AFD
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9032B191F85;
	Thu, 12 Dec 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haoHVZXJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34131422D4
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032993; cv=none; b=eeslxPPYAvKc5k/RAuUIsbWHYePZhBkyFhFeS9V4ZJiqMI7s+3On+Qiftav8sa4DMfK1OOlboR8Z+Tzcrla5zBgjWvpVwN+4pJyGuy75K8BU5YeAABqBpNqleBqB9ed5vAZOW3+hGcsatE3GSa4Hgbuc0UljmD/WUSufUqkBhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032993; c=relaxed/simple;
	bh=usMsuwcdw1bEyyMKuncMVdZljOKtOTyWYZVk0CFtGCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtQ4FkJ7ZonaVt3aDWT7ylnx3wlmQVN4S9EJKhuql4A+ooy1oovjrq/qdkBV4LrdsS5WXXCYpRBsXld3BBJaxXp1wX+ShcJieHE29RN7qe4txb9Ylm4BCpImd4ZN18rbZT8BiOEubxhVeTqzqcfdSgcUfhjXQi+D8hzscn+Us5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haoHVZXJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21619108a6bso8137955ad.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 11:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734032991; x=1734637791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tg5F0wAIs/4wlzxc+SDrYOCYCP+taL7f2LZJT+TcflM=;
        b=haoHVZXJRjxFIJcySBkxW7ELRDSRCZp54FzI2DZB8rYFGoRBr0q1aF3LepQMU89A1q
         HLk4yotAMEKxc3NOTszccbzBmKuzVabTsw/GyKxzqtwzh7CnLP3Jc7TRiImLRD10UH9i
         Mk7mI+VlnghZGiohaMcJ8N827hzCIl3wKZcStBjn0KEpQVe8hZg/6zr9MHPoBPuiVux7
         7pXJGaWeezLSMQu2RkDvc+r1W6lc+NpP1NjLOofVMyYEBZ0mAUQ5ovHm9Qii/4HscBey
         Lf8tbeCLrbuN1VoFVsuivPOf2bmmBgurww40fGi6vNdyV1EX7fIa+ntJiBKY+iHAmKZn
         IvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032991; x=1734637791;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg5F0wAIs/4wlzxc+SDrYOCYCP+taL7f2LZJT+TcflM=;
        b=QKvQFPdXNQ9Or7hUDF0QPjnifnoOaFO3hwcD4PD5i3ooKStY9TwIo4f/Q2RaUz+Vzc
         6WuYMZjMOkIjkOy0XVmGR9AKVGqrxegwfmDKmvZkghxljhLhzLVuE7d8w5qPjse7X4zQ
         zP3yl9eGL8EBwQWned6KjI5v5I7DwewuCupGF9mcp6rInOXMHi9Wx3yRNYwkCXc2biUW
         qrT2li1JP5cFtyWEbjVKsdjCsOHoa7agOzTKgx8ubE/lw8NdLBM41JMjfqsRJq8g0fLa
         6ki72EyW+kcldGJYD3yxm9Bhz5ZBk6u6YMsSUrHpniBL7gA8tQD2Bm7jRiTWeRN938UV
         AC7w==
X-Forwarded-Encrypted: i=1; AJvYcCWPkZrz+sopPVFetoCAVffHrGC5PYToPyFHM4kw59kfeN8AvTLW1JgtQGiIHEdzyrqhS6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyhIrIgbznGNzixXKuPUJ5cXGS1zUF+1rpNlifzMW0sToByQB
	hSFOKrPgK+TcjvLlXJp5QATvKH4El462qgKLafPegUhYD/y8va8S
X-Gm-Gg: ASbGncv0P2E4KXCiPpQBoVZu6mRBqVZLXyeSLD2Wj3CUvRPpi8tXetmtgzJLMtfN2mP
	ZTat64lULnjS/VrxR4vU/1cmIzL8/Mmq4mXnJ3FcHZC8Z7nNl275A7X7Afwb5oJ1jynYaO8f6a/
	s7fAhmEQVFkhOv8KObx6yFTr3frt2Izju+J8JtarDEDf/um/N3coU1yprsV7cbHktg4ovjv9B2I
	7mp3UDyX825qfmVxhGNEj6HBmDZOM9yx+dLTWL5OxRzxdT/6DPRoA==
X-Google-Smtp-Source: AGHT+IGEOqFal/1kG++xMEsMnj8NkZQSYLYldNGMicGPHbc4t7j67tvTQ+UAVj4SQ1jeq5gno82JLA==
X-Received: by 2002:a17:902:ccc6:b0:215:b9a7:5282 with SMTP id d9443c01a7336-21778535458mr130767805ad.26.1734032990856;
        Thu, 12 Dec 2024 11:49:50 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21630fee27bsm92172595ad.269.2024.12.12.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:49:49 -0800 (PST)
Message-ID: <ba58df892ddbcf5650db26f46f730d55aa488353.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Check size for BTF-based ctx access of
 pointer members
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Robert Morris <rtm@mit.edu>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Thu, 12 Dec 2024 11:49:45 -0800
In-Reply-To: <20241212092050.3204165-2-memxor@gmail.com>
References: <20241212092050.3204165-1-memxor@gmail.com>
	 <20241212092050.3204165-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 01:20 -0800, Kumar Kartikeya Dwivedi wrote:
> Robert Morris reported the following program type which passes the
> verifier in [0]:
>=20
> SEC("struct_ops/bpf_cubic_init")
> void BPF_PROG(bpf_cubic_init, struct sock *sk)
> {
> 	asm volatile("r2 =3D *(u16*)(r1 + 0)");     // verifier should demand u6=
4
> 	asm volatile("*(u32 *)(r2 +1504) =3D 0");   // 1280 in some configs
> }
>=20
> The second line may or may not work, but the first instruction shouldn't
> pass, as it's a narrow load into the context structure of the struct ops
> callback. The code falls back to btf_ctx_access to ensure correctness
> and obtaining the types of pointers. Ensure that the size of the access
> is correctly checked to be 8 bytes, otherwise the verifier thinks the
> narrow load obtained a trusted BTF pointer and will permit loads/stores
> as it sees fit.
>=20
> Perform the check on size after we've verified that the load is for a
> pointer field, as for scalar values narrow loads are fine. Access to
> structs passed as arguments to a BPF program are also treated as
> scalars, therefore no adjustment is needed in their case.
>=20
> Existing verifier selftests are broken by this change, but because they
> were incorrect. Verifier tests for d_path were performing narrow load
> into context to obtain path pointer, had this program actually run it
> would cause a crash. The same holds for verifier_btf_ctx_access tests.
>=20
>   [0]: https://lore.kernel.org/bpf/51338.1732985814@localhost
>=20
> Fixes: 9e15db66136a ("bpf: Implement accurate raw_tp context access via B=
TF")
> Reported-by: Robert Morris <rtm@mit.edu>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/btf.c                                            | 6 ++++++
>  tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c | 4 ++--
>  tools/testing/selftests/bpf/progs/verifier_d_path.c         | 4 ++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e7a59e6462a9..a63a03582f02 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6543,6 +6543,12 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>  		return false;
>  	}
> =20
> +	if (size !=3D sizeof(u64)) {
> +		bpf_log(log, "func '%s' size %d must be 8\n",

Nit: the error message is somewhat confusing.
     Maybe print something like:
     "func '%s' param #%d access size should be 8, not %d"?

> +			tname, size);
> +		return false;
> +	}
> +
>  	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
>  	for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
>  		const struct bpf_ctx_arg_aux *ctx_arg_info =3D &prog->aux->ctx_arg_inf=
o[i];

[...]


