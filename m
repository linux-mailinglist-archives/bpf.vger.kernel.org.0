Return-Path: <bpf+bounces-41016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D49910B7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80471283E04
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034E231CBD;
	Fri,  4 Oct 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYeURvsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB0231C88
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074279; cv=none; b=cpLU5kuzCZz5Jg2ngEC7DUV+h9hWPH7go1OJPDNiP9DzPVifEXh9sbDZ4OE+rDWXT5wyeaO80dQmw+llMl4h5N6Wm3yyIGxjdVg8w90sUrlGDgjIpN/y+FQEn+vZgd/WU+XvLMm9wONJX3v63+NVhb3vDYm4PgDa3a+XnXwEFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074279; c=relaxed/simple;
	bh=0uXwTKOm80dAcfvU/WkwSit/eF6nbrfm9CGRU/iMKKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqzRv/o1l50JC48UV7XLdJZBBj4tb4CPhnyVudnPSi01G/8zYLhfpV6a/jPlQySrkRv3ugr/DWZJ1hnfGPIcRRuxc0giMQnTukwgSuCrim5D1GSEPrFMNJBAJnTIsLS/QO5gslYIEzT6jpaap6GgIvNenrjHqi2rBdpIwQZFb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYeURvsX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b5fb2e89dso20579525ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728074278; x=1728679078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uXwTKOm80dAcfvU/WkwSit/eF6nbrfm9CGRU/iMKKM=;
        b=MYeURvsX8U5R9vCVCLAk204g2hU0EXwddwreC9zIsaC72N3O+sP2wF/x2vVIDa4rvV
         +mP7Ag8tgmlTwzV7ElPliCN77NN/ypm8hb2efX4NQqLCbytdyyPsvl5HDMIZD+tlZ0iI
         AwemkAavJSwT+mGcZnmaRpq52svoOX2Jnn5dfzIQGKABTdjHDBldB21mfzR4YYxvwfeC
         Y8zUjYLN7OaRVtRBRGJmqneCOBgLDe42TNVX2HOIEsLn/xgUV9ad3KasZLA2LmU2Wflb
         fANj3Ay1JxGALRwoYK2YZ7/PfXUqCBsSH9mC8ocopm36R85dAjUkCgxjdCZPU9Zw4dPO
         yuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728074278; x=1728679078;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uXwTKOm80dAcfvU/WkwSit/eF6nbrfm9CGRU/iMKKM=;
        b=OPE+u/DsSr6mqZNz+4wwBX0PKpPK1zkg4vZQ0WLVCbpnPLm7orWIaq87ahO1ZdX4Mf
         Cm5ZXbKSl2MAJFJnsdcs4kr/IUJvxi0NjhPVXmyHiZCrOVzQ0aBDTceLGWhw3gYTy48y
         L1OubGGKq2b9eW4QTIwhcXu78dcuHdlbnuPpY24OLQwZVsLdyh9cViSbowhQQEoXH7aW
         eWdaJNt0K4xeuULws5FZZIStXm0T8NJ1IZfXZV2NKzzC+8lM8fhjHSKRCIxh4ZoA2BJC
         fZwDTIM2DFtFROecc9eOxrrCOuPzSWngM5N2ZGbL5YPuW6Nf38dx+bb9l/ZAFzeKlcQE
         AoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV37ENSzfEf47ABoeN3gomc8EJrAXGxv5UKz09p4CxpYpwucCqEIdIGMbcT85L7PcaTfkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DPr7UOyIVYjz0bcBnzjmObtlN4Xk+RUhegL9r+vfY/PfPMe9
	wnPjQ6JKmemi1PWGintwy8DOszP6NgzSpyJUSf2EizsJXLhs+w8p
X-Google-Smtp-Source: AGHT+IGo0I3nJGCdMXbEQrPPCXZf7o2HfmriitkKXh756AqebRm/awuwZCTk2KDIvIAv6mw/nxgdHw==
X-Received: by 2002:a17:902:e745:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20bfe05cfb6mr64994065ad.14.1728074277825;
        Fri, 04 Oct 2024 13:37:57 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afbf8sm2616855ad.14.2024.10.04.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 13:37:57 -0700 (PDT)
Message-ID: <152bd43f3fd5aa67de2d1356c3ca46b790b2b834.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog
 with freplace prog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang
	 <hffilwlqm@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Puranjay
 Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>,  kernel-patches-bot@fb.com
Date: Fri, 04 Oct 2024 13:37:52 -0700
In-Reply-To: <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
	 <20240929132757.79826-3-leon.hwang@linux.dev>
	 <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com>
	 <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-04 at 12:33 -0700, Alexei Starovoitov wrote:

[...]

> so 1 - initial state
> 2,3,.. - prog in prog_array
> 0 - prog was extended.

This sounds interesting, but need to think a bit.

> If =3D=3D 0 -> cannot add to prog_array
> if > 1 -> cannot freplace.
>=20
> but it's too clever.
> It's better to use mutex and keep bool + count,
> but extra mutex is unnecessary.
> Reuse prog->aux->dst_mutex.
> Grab it prog_fd_array_get_ptr() and do the check and cnt++

I think it is not possible to grab the correct mutex in
prog_fd_array_get_ptr().

bpf_tracing_prog_attach() operates on two programs:
- one named 'prog' is the freplace program;
- another named 'tgt_prog' is the program to attach 'prog' to.

bpf_tracing_prog_attach() grabs prog->aux->dst_mutex.
Inside prog_fd_array_get_ptr() there is only a pointer to program
being put into array, potential target of the freplace.
From bpf_tracing_prog_attach() it is referred as 'tgt_prog'.
As far as I understand, there is no way to get a pointer to an active
freplace program from prog_fd_array_get_ptr().

[...]


