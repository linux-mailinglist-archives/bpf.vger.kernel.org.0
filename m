Return-Path: <bpf+bounces-66638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B0EB37B2A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 09:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2019172471F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9C2877FA;
	Wed, 27 Aug 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnzMtIfD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502CC2AE90;
	Wed, 27 Aug 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278077; cv=none; b=mRzTQEzdi8SdhetBaRmwcLSBM7517NTFvXOzgmA8RsLjXoOa+meJv0adjVP5ALCLjI44aAAiTs+Gyq/zP9j7JDUwTOZ82UwnAdI1wSDmUfk+kJa8ix+ifRpKINfzNxP69Vv+lNq/keKYv8pURPh54JYjYpgZcx8Lpk5ONdjYhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278077; c=relaxed/simple;
	bh=IPWz9mozyFse4XGl6CBpoKreYdDUOvbPJPpP2tvEbUU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nx6qyRy52zjplrX9EQSxGf6Xq9sHUNIMTqJ31GbchnXXS52SA/6IkU4/GaJ61Puedepy8R3X9ZGudKY5lSl5ZxUW70QcBouSw0NoDMmeTs3GdL/1iwc+v8nmFDgWm0xrfgX/cY7xiVydH2ItEvEiv50uSHX5bBlWZql5+ouk+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnzMtIfD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c1aefa8deso2028283a12.0;
        Wed, 27 Aug 2025 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756278075; x=1756882875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPWz9mozyFse4XGl6CBpoKreYdDUOvbPJPpP2tvEbUU=;
        b=HnzMtIfDwVdslwiWUZYmS+5pkThP4igFCNaCS1+pn+TRhdt9lrv547YBvPzMPIvd2M
         1b0Scny4l5k0xsJkkc4pxx2+csSNZ5UAlsls/LhUf+FYLP/7fzVTJv16zCihYbsa3rsp
         XNtwXf7KQuyT2ooenJYUcOBDewrGVcVln3EmibpzdiuF/xgsRp+E5KPQT90U/avAKPmc
         9mvha0e4dRe7ZNuzZhF1yxddCjHc3fDj+xQSTjT2OqqK0ph0lBPcv35V/BgZZS3lDGMq
         etIQfINjYtYbQWxUDWMJk/B0RfrJnmcwdNCiG5nUt89BogyUa55E7Ti+A3swxh3v65Uj
         i3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756278075; x=1756882875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPWz9mozyFse4XGl6CBpoKreYdDUOvbPJPpP2tvEbUU=;
        b=Z9/OVIpiaRKF0dkBqjVMv8W30UjcarUtxr4hXiQitaBvtO2qpaqH47B+RYLXkpQHge
         ak3eBngTi83kwZ0sTGMbFhF23yWdYjd9RkB/HaJoHs2ok4tYsFk2rR/cms6i++0YZZyS
         NWxakuFxaOJsVlivDWDBkaVmeAO5ut3m0Ct/jgIhIBIulvgk81sBtapsOw5URdhhkJxp
         aU80lxhp7tTIOefSa9E10x1XexIb8cUbv1TYfe5801Nd3tVGDXNHI7wRaOH+mg8YHNkT
         kCA9W1Qku0q52KKgCk2yrXLdR3GlExGsErhd5apPcPDsPfhASluFgWFUVT8EYIk7nGhV
         Pxmw==
X-Forwarded-Encrypted: i=1; AJvYcCUdS8lVSHv3aAjtjr8tL24W5PV8hH/lAtfOk6H37ucZg53NkOF93Pn4VuPwg8gp1qEHuxc=@vger.kernel.org, AJvYcCV1qZdEGUeb2aST9Gi58LtcdxYeYzFM3nQT+Jh+gP41XimSqNZn91i8sZDRruJzhOdYV7HwpsB/9odLI0HI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywty/JEvMI43hoqEnnRN0pqAoCeDsLBY11p5K9+1+OlP50ah0VC
	nHBTMs4D+Onaa2qADw0PaFfl6eqjV8U7EstGXu1ryWzACjyIYjh0IsJH
X-Gm-Gg: ASbGnctEenpsDKsgJAwytb6rPp7u3OZRUiQ0+w9unXHxsZND9BUKFEOaB9Umx0k2MCO
	c5rlqGS6dZHtTzRhiDNAYOa5kPrNrJwDeTixRAEW6Ei9irYFqxzmWmhqZ20YhxrCXsATEuDHM1V
	WWgBEFDttrtN5Yfg1cOU/q+gO/tS8E5Igu4Tt5eeuc2NnUdf+tsILXBcf5dGdlgLf/zacclZTbQ
	MdsdET0VlLDVQ0CC0AGh6aY7kMC2ZebH10GXsuuJ9ciC9THN2XAgzm1pLFbPwav7mzrhTCEkPly
	9Pl+NU9AoXM5YTv937fNLAyj9daL72dB6pgiPkkdgR1w7XwBgD8HHkf9zrqrxPyxwtSn1U+ZN8M
	0p9rQGxo/3yatFsfsvQ==
X-Google-Smtp-Source: AGHT+IHlH5psca6BIo7BTV8V8WK6FTp3iM8rWCKDIg8sIAozvTDovWUhe9vzotd6lHSqPwkJrLzuWQ==
X-Received: by 2002:a05:6a20:3d06:b0:240:2473:578b with SMTP id adf61e73a8af0-24340d91eeamr26941202637.33.1756278075373;
        Wed, 27 Aug 2025 00:01:15 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b01b2sm12140040b3a.64.2025.08.27.00.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 00:01:15 -0700 (PDT)
Message-ID: <afd8091d11429e63949a16fc24228078b08c7726.camel@gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Vernet
 <void@manifault.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 00:01:09 -0700
In-Reply-To: <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
References: <20250822140553.46273-1-arighi@nvidia.com>
		 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
		 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
		 <aK6aiEbgYaI9K-pt@gpd4>
	 <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 23:52 -0700, Eduard Zingerman wrote:

[...]

> If we are being really paranoid about LTO builds, is __noclone sufficient=
?
> E.g. [1] does not imply that signature can't be changed.
> We currently apply only __retain__, here is a little test with both attri=
butes:

Nope, there are also 'used' and 'noinline' applied.
With these the function is preserved as expected.
Sorry for the noise.

[...]

