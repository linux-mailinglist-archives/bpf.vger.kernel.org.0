Return-Path: <bpf+bounces-32942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ECA9157B6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AE61F21E49
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685111A01D7;
	Mon, 24 Jun 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egopqwnG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B791567D;
	Mon, 24 Jun 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260169; cv=none; b=SW1iZNYP3TxahJXgrlJDp6JqXrPRenp1U0l3OLaj1Aj1/bs9VEs9hPsNyGjGbiUU/eYUCj7L92WtboMtSSCRGxOa1tyegWXbnqrQ+8IghuvQ0BFMxas5zGUiy7xDFcArzKSgGk/YSI1claPPJkbeOAGMFVzgFr209198zb+wLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260169; c=relaxed/simple;
	bh=5om0Ee+ZJDqVktM4gccxDrfIAMmk9ASqhtTDTkaWpFM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayG3Dm63p9HjMbCCcWrdUVzdIHYHhtJsioKUzBjpE1i7hkOIG7YQn+ZhSRMCmpVdyGNrjlbBwpPunED1wzhDFa/LZT2Gnr49/sFradCjPS6dUGDtFSb7Mq8GYBCcF9Uxj8O5/Vq2E83HcqdZ7Vq4L7qMT7w4HqS6SqgwqcoQjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egopqwnG; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-376069031c7so17710765ab.0;
        Mon, 24 Jun 2024 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719260166; x=1719864966; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhMLTiqBQVQcehAWQ5o9+zKK5mnbqWg4swdWE6BbVnk=;
        b=egopqwnGAhvJaVU35GLtcVABXNQvQ4/Z+wttbRNEoE2/TGqGQozpC2KOf78q3M0xwB
         GbdcFkLtzCdwzkApZJ59W3x0/MQeOi3aaf3qXs0P5HkFtfHwf3e4uaXTg9TO1y/8o16I
         Bc+qe7wRYRvRHfzu1DRjFzxM9nDnb9xvcu7e+FPxXpmQwuNZ5wRMGU5dy/cKWtqO2umB
         iKvP6O1KrLVsvY9kfpLx5EbSSdycaFHDqyEWsZWlyOmywRVz62beu6mpz8HQaH3VuyQ0
         bZf6WPnat8ZW6emzJf3eYtptGDXwc1CxmGeFop79diUOOpkAOsyyQHvm1kKS0pmYZyLa
         FAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260166; x=1719864966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhMLTiqBQVQcehAWQ5o9+zKK5mnbqWg4swdWE6BbVnk=;
        b=XabAZnjFM5lMgbV/AQp2YCrAHtZX/zZfxFdCkvZlvVpa7CaZZY/MH2J7FoAW1q0PJW
         TpEQOKww/GHBexwybAFjyA5YfZNMjAzuu038V+nhlTUHKVKwGY/ZpHTEBpA7sH1vPLan
         FDCrHtNP9mrSvHzu8vl5FMwgnE/RjaP2H9NQO3lVm1BhJqbnkb+2b9lrCJpysmIKW8FN
         CQDUj8Fku5tCtrqcXpFvHof5jQaRWhKa8UZf0FsMEX7rYjHRXd4L4pqyXZ2L3jLXp4+b
         qHXNEDCUOnW3wbojPAnxldbhmxSi+tP+LdUaLoRR9jANF2G4lZeb66RnyhXSIqNxZP0e
         Bl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXRrooQYpvq4NUT6YprV8lUH4E94x5aNspkYeB3Z4UJABzBfj3FlMRhl5WJurMJjEdKA0+vg5oeYRN0pvJc6nCQQM+IJLyaWu9ddFZxYLhqncId7c9/dczPF/2ng6XQJPAd
X-Gm-Message-State: AOJu0Yz9LV6denzLjZtx2S7Db2RPKAaV0U38GZSD9jG8SXLP+jkl6GIz
	95BVMYhCtmfu1hbHxP6PeMEjdb7JDA0AL/IkfQdUmlq/JyXe+D83
X-Google-Smtp-Source: AGHT+IGNt4DE71xSZsHBla5NE53ZLVzGj2cRelc+4LHy9BbIEB+KW66juZ6sANvovS1/+BAxicpRpw==
X-Received: by 2002:a05:6e02:1548:b0:375:9828:ae6 with SMTP id e9e14a558f8ab-3763e060679mr58406705ab.21.1719260166494;
        Mon, 24 Jun 2024 13:16:06 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71b80240456sm3129418a12.14.2024.06.24.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:16:06 -0700 (PDT)
Message-ID: <faf99c63015c6a5f619d85bd45405b91a3498bf9.camel@gmail.com>
Subject: Re: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
From: Eduard Zingerman <eddyz87@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, martin.lau@linux.dev, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com,  jolsa@kernel.org, yonghong.song@linux.dev,
 bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 13:16:00 -0700
In-Reply-To: <20240624195426.176827-2-thorsten.blum@toblux.com>
References: <20240624195426.176827-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 21:54 +0200, Thorsten Blum wrote:
> Explicitly test the iterator variable i > 0 to fix the following
> Coccinelle/coccicheck error reported by itnull.cocci:
>=20
> 	ERROR: iterator variable bound on line 4688 cannot be NULL
>=20
> Compile-tested only.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..7720f8967814 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4687,7 +4687,7 @@ static void btf_datasec_show(const struct btf *btf,
>  			    __btf_name_by_offset(btf, t->name_off));
>  	for_each_vsi(i, t, vsi) {
>  		var =3D btf_type_by_id(btf, vsi->type);
> -		if (i)
> +		if (i > 0)
>  			btf_show(show, ",");
>  		btf_type_ops(var)->show(btf, var, vsi->type,
>  					data + vsi->offset, bits_offset, show);

Could you please elaborate a bit?
Here is for_each_vsi is defined:

#define for_each_vsi(i, datasec_type, member)			\
	for (i =3D 0, member =3D btf_type_var_secinfo(datasec_type);	\
	     i < btf_type_vlen(datasec_type);			\
	     i++, member++)

Here it sets 'i' to zero for the first iteration.
Why would the tool report that 'i' can't be zero?

