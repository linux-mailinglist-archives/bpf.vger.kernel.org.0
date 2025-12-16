Return-Path: <bpf+bounces-76687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBFCC10B4
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C044D301738C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016F31B11D;
	Tue, 16 Dec 2025 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgPvnOgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF720320380
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864895; cv=none; b=HH8zoF57oHjnDI6vnxAlp0Df3bs8CPivIKfmLyrQ0t0oeFGI7FtOW/nw2IESbTudM1Kpb5hUiaiJ0AtBwRFEeiuTfVsWXXQ44nDI1zV47x6Eo3xXsRzS4UPz/BKDMwCfBh8kZiKN4HdmAKDGRAXh06aWJvmtaUfxMhVe/SPCLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864895; c=relaxed/simple;
	bh=XwpAaVywCyEesvbhFD+1jRlGMpfd5SIgyHs2knNz78o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtNQBOx9cU3FfP6N4/Vd1BanU4AtejAT4CCoWybaxyz88gO05rn7/dmzR7pC8+YoUTUC3827MphDqUgGrqUhlxcH11aOn0CF1cbq8sYRA9tv8QAwcWjN2oka/641pR9Ekx+3dhJFsGYRkR5ELUwIL87dHTj2WC4Vs5ebW0jO7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgPvnOgg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0bb2f093aso23900855ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765864889; x=1766469689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nU4M/L03xqpLSAHFWlJdaAXrhrSY3fxk1G2NJhrZ0VE=;
        b=WgPvnOggoJAdUe422rISE76jMDZpzMmQi05St+BsdKL6Nm8Mr6+aLDbEpBMKi1Y8l1
         ffZqfNdPhN7uEpyIpfr/pW3j7ehTiZtNaQIkwBfYpOhzb0koNF1on36KWEQoL25OQP2/
         xZTegeBBUMMNKz1FziTU/rw0qcDtN1jhG+CZb3cu9rBjC0A+XLCnCSDRAG+Rc4TO5L39
         Who18ldVsJAwLLPu7lU8ccdIVIhs0zL7nS/hWQH5HTsqCr6SC7rxlnugIviPwDNQkvXp
         QWIje3bB1x6+SAfpH04GCkzi7kvtX8rVye2gq35anebwMZBJNEf8yL/oBgGng/5DwHI4
         5c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765864889; x=1766469689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nU4M/L03xqpLSAHFWlJdaAXrhrSY3fxk1G2NJhrZ0VE=;
        b=Ayqp0apTuNgSlm0f6M5Sy5kwcpoyAwHjB4vP9PcT0iRx2mpinx7MDU2+fiCD0XOW+S
         8ZRlm7cEc4xapb28rqPUvY4fslSB8XzXeLV/Ke9uXfRa1RrH84/RWaX1TwwySOWw8NKF
         pOH4goxut8gflODJTTeek/NVoqNGaN434dp/iGLfHvhdZ8+0daRmHcCdNb9k7Ze+cXMs
         YcqlQz9eYXittbDpZIgRYAAaRgIPQBlBHyXmJFQ0dkSRYFGO+TKbc+HShckqG+3ujMmf
         NrW17zSK1v6nz4HZhhXVxGsRLSGy8TpJQJXsRdhSrArgl5TWYnwlw7lcn+Z2k9bb5pOs
         Wc6g==
X-Forwarded-Encrypted: i=1; AJvYcCVnOejX5I4GTWC+969X4y82Y3Qv7jGzWnhf0FSFI3gESs/Mk49HjwIxmBkARakq6jMguFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY9xiRZKhec8+rJpv1wr9LoWckVuveCiAYw8hyP4gG8ifjT0X
	kxIfPRQlVSbQadYvZMgN2LE1bFnIzXyXrnDVKpWtKwxS3nSYyLw2ktvW
X-Gm-Gg: AY/fxX5B28s+LogLBYdLqyYZf4+2sWeQc0dxd8kcfNI/0uAlY9aMwdSh7L+eEU4dmy2
	Dbx/FCOQqlv9/Hmp/OKB9aGrGj6WkwVs9NVvAlSfJiCC45rVLg7NkIRZyr1Zhkb1wnQngRlsVCJ
	HNTFgs2Zp/RmFPJV/m+3ZuKzYtCPoh9Wfg1t96LAK8hPu4n+nPhI5tA+XyRdOvx78dRr+sT8GOG
	vNckbj/SciiC1ZYRHByAbcy3WjMdkw+484c3SQlPPSNzzWytqNGoM1ZEfAJQTv1MY18dD8v5e4V
	PSaqi781wd5fCdCG800GQiuSx62iai2LAbVzK327noUwrC63ergfql6sGXkF01dC+6UIhxGvWjZ
	ZhjevuftqMyzK7777C6sqifrrEU36sy0UBdXCC4ZEf7OvQzSdmb0nSY6Ti/hvQEZtZe59qwur2f
	1QkrGVtrUXzvZVN/bhVms=
X-Google-Smtp-Source: AGHT+IGLwJVTz3tjNQHSPJ/HY/ivy2hxThwRXBUXcpoCVjhIFzGo5NEhsgAINS8tX2jDpRUlvpGoXA==
X-Received: by 2002:a17:902:dac8:b0:2a0:34ee:3725 with SMTP id d9443c01a7336-2a034ee381dmr127282095ad.14.1765864888964;
        Mon, 15 Dec 2025 22:01:28 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0b7f5c457sm70288645ad.67.2025.12.15.22.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:01:28 -0800 (PST)
Message-ID: <73e7a9185fa9de89513108a5ec2b545fa344d237.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:01:25 -0800
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

[...]

> @@ -951,7 +1018,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, =
const char *type_name,
> =20
>  static bool btf_is_modifiable(const struct btf *btf)
>  {
> -	return (void *)btf->hdr !=3D btf->raw_data;
> +	/* BTF is modifiable if split into multiple sections */
> +	return btf->modifiable;
>  }

One more thought.
If some kinds are not known to libbpf, BTF modifications are not safe,
e.g. endianness swap will fail for non-native endianness and anything
that depends on btf_field_iter will produce partial results.
So, maybe forbid conversion to modifiable in such scenarios?

[...]

