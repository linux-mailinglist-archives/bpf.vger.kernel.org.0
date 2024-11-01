Return-Path: <bpf+bounces-43771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB99B98A8
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3DA1C22083
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09331D07B2;
	Fri,  1 Nov 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvkp8qaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9413B792;
	Fri,  1 Nov 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489471; cv=none; b=f/PrOLw3+gG8nIzUqWZQlM1sSSDWLIi0du5x6BZBBnIYVKTDt0WoocvbM91NBCiorR/NsRNHTSamhhyT5h1SY40K5BhE39IDnjE1kXQrWSoD7YEl2+M52ae8jDtt0EZO3mMDv8b7bTamBIXGa3PlBVDAvMrPqarcin90gCMWt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489471; c=relaxed/simple;
	bh=AJ4CS96WAaefrS31owoIg2zPjF9ZVZyzGhKtLx/uVkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBbz0dLyxk1WvVwjIsnz/9SC8KWFaBkR329JSG0GAa2CYK8JKX0Dvkox93YeQUzwEa8TC1bEloPvf7bBB2bsvcbaHlmXIh9mK7EFAI+aLrbGXEUfzyIy7xujXUWMDVP6eweVMrLapApl8Fu243eZF+SOx1Rtz+1wRhZFddLLjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvkp8qaT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1621749a12.2;
        Fri, 01 Nov 2024 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730489469; x=1731094269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NDDCbG1ahSlEGv1KkyBWJl1W3ZyvWt4FXc2MkJZxdY=;
        b=Uvkp8qaT5l5VSGYReGAaPDRzd28eShGiIeY9A8iLiSXi4yGBtx8oduQn/CkQbNtLH5
         dFGUEXLomPNF8dEejM2/vLnjkIX5ttNpWYO+irA8sh+dBzv8ePGZ6N7e6D1F6RSbvQAR
         W+oav7pIkttrulD9AaNM2W8FNxLa/HRJrb0K9xZ5+eqGXYK5BX1YsCCVnFyCNUn17rAO
         0wRHf14TWWsXka3QezEAO/i1CRdIY5A9btRWvLRPvhO1k1EKg6mym0l+V8GDnvs+gBHA
         qDIT2VMbwCveED/tt0n5bZ0If8BThDeTEFNw0YS0mvfEK2HLFzcDRUkSRiKMMMqilYbZ
         3GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489469; x=1731094269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NDDCbG1ahSlEGv1KkyBWJl1W3ZyvWt4FXc2MkJZxdY=;
        b=qCoNBNO53h753w4ruqxMmTqOlaWVzzxZ2X/TsckucIkqF5Hhjjsdu8fs2Ma3X18zD0
         9CLsLmWasz1YilWo/CbaXG3DFMfD4+Z0xbScI8c5W5AZBQVK+2qMpLd0ITU6KyxS2fHn
         kyeqqDb5AvvvVNvOzvkYb+RQ8Y+iNS0TSfmc9HZTgvKfOfa5tag4giL7QUgOBY5tQI+c
         kK8fczZrDws1QHHZ8dbI/iBUeBBOCTcqLclQyma6iX9yYY1P1LNUPhod2akJAU3fmbHz
         d5XDjxe34qwgAmnJHCmlddrcTWVAMt9vv3hjo68d2daCyJTBOkqTw8W5w+XClOKQTHSU
         Kckg==
X-Forwarded-Encrypted: i=1; AJvYcCUgjt9VSjvMB4iJmqizO+9ASkU7rZIadgLA98Ur1cAGz+XXHEHy2kPCzcOfAzfWNFLQxag=@vger.kernel.org, AJvYcCX68W0FLVdFZuwbo30Oxcxe8Pbe9wKlWPj2aitpKN48MnCqdhg03TbV/UhrwOM/xJozo2yweESAosi0z2DK+8MF@vger.kernel.org, AJvYcCXvRznOWlmVTxrsKQXMTL8ICT5ipnV7yBtjGtfW8vQ+pBhZACbgyeIGtMmPBi0HJBf8GkRhSlOZjUoKErwo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhky+bUqLfknKJGFl+Pi59xjj8vNMehiSqwHDR364KVxS18lQS
	7WtvygWClhulDgrWKV3lXVmOfwKdFBFG6baqJ425Ojbdn1ztZtuIehiC/+v2sIzarnzr6Wex8Lg
	BIU83en4mcyjoKmGIo0ix/yxnvXw=
X-Google-Smtp-Source: AGHT+IH2JcQByIR08ndwyvZQilY6ZPngUA3Q8UPQqX29XjCXWrY8BWAu0dR78Tu6HtvLiDFNwB2xv2YGfXbsOuu6t/s=
X-Received: by 2002:a17:90b:4acc:b0:2e2:bb02:4668 with SMTP id
 98e67ed59e1d1-2e93c300b75mr8657535a91.40.1730489468993; Fri, 01 Nov 2024
 12:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031130704.3249126-1-colin.i.king@gmail.com>
In-Reply-To: <20241031130704.3249126-1-colin.i.king@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:30:56 -0700
Message-ID: <CAEf4Bzbd2qDmUmVYtX56oz7Cj4+H88LyemSVd3YxCmcPYLg5-Q@mail.gmail.com>
Subject: Re: [PATCH][next] bpf: replace redundant |= operation with assignmen
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:07=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The operation msk |=3D ~0ULL contains a redundant bit-wise or operation
> since all the bits are going to be set to 1, so replace this with
> an assignment since this is more optimal and probably clearer too.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/bpf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9aaf5124648b..fea07e12601f 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -914,7 +914,7 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
>                 str =3D param->string;
>                 while ((p =3D strsep(&str, ":"))) {
>                         if (strcmp(p, "any") =3D=3D 0) {
> -                               msk |=3D ~0ULL;
> +                               msk =3D ~0ULL;

This was done for consistency with the other branch. Is there anything
wrong with this code? Doesn't seem so, so I'd like to keep it as is.

pw-bot: cr

>                         } else if (find_btf_enum_const(info.btf, enum_t, =
enum_pfx, p, &val)) {
>                                 msk |=3D 1ULL << val;
>                         } else {
> --
> 2.39.5
>

