Return-Path: <bpf+bounces-26586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130A8A21A4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934DB1C21EA7
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61304405E6;
	Thu, 11 Apr 2024 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfWTltoO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBD3B2A8
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873615; cv=none; b=A2mJ7XB06bWJPbr4FqEoJzjCCl5yRROVluQaQb64KbjdDhLX2O6aiU14lvn6j3mm8YtoS6OxWo/LPP8danDgoSogJMlttMBY3hunSKXVz7nri1CXN8hTM2eff4r/MK4IXMhoqm6SIsznH6BZg1QjnBkm+UnpMNBy3oDC707WS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873615; c=relaxed/simple;
	bh=OxLgP3x0du5P/oZw6EcAVOIhIgnW7JuDLI78h1aQtnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oi2zKZCd3HwzFjCQn4sYd1zQg35D1gpSRQ6ippWKln44OtFd0Z+7Dj70tey7KpVBfvfNnBmR0ASA7VL5vDOw7FfDGmt4EHOSk3qEX20I5NJvx7kW/A44DreX70HrcuKj1HGaSKVuRjroXmUkhvLQZN8AssLndYGrW2x6yMWSvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfWTltoO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d47ce662so435720e87.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873612; x=1713478412; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rEKsDlvhtcnTsI1qOWCxGyAbyKIdYGqpCvUi7u7TECQ=;
        b=nfWTltoO/uPWj0fBdngJ0Xc/AdaVXrHlo9zwKmG5+PBNxhALwwFlxpqIU879kekZ0x
         g0Ewip49O6uYTIqLYdF7ksYdkndVr3YdoRl2RJJMpvHjGTZH3NRGKRxNaan3gNNyabMS
         tciP1k02S5P4xrPm2Th3IaOr4xmX/XWg7TNScRpemrKcut2hs3OJ3vNbzP+Bx4oB88l8
         BlQyA45Wk0jLBEI0qKrmogvlgM4U+vm6ixQ5XutfTuyfDJus8ydb+qFCs9x3qgakqm+f
         MAIJnFAN7+riUard7NlsE5jlsUGSPStdHiV+hugdwiX5ZhL+zI6Y1+J5mflBQg4PxlRg
         gCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873612; x=1713478412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEKsDlvhtcnTsI1qOWCxGyAbyKIdYGqpCvUi7u7TECQ=;
        b=jql5C70BXokYdYOoKByCJ3UA+etFCflFIHlrOqzWi8U0ERS1IZ1JHpdDCr4VDQcgtI
         UHcDZuAMIY64fsipeF6dk//QdDvEPTXW0Hxtnd+GBeIN3nizTTCF9nsJJ/LxH6Q4qGbA
         gZHjaWSBzFQinhTA8ITJnVN2nwzJXL3oaHACgb9NtwkhwxPXd4Qm5YQMzI65MdsAXEQN
         AtEcM1u4bwpkCnw5OB6dimKBwnDwCsTjDz1gqy6aDobqJkI77EQ+hZRQp4eoaTK4gLzn
         dUsXMqN3OCFqv4SVP53qsWkyj0fKSPza94EXyVLVxcayn7RSlYdG6dYAsj3RkX03UMPr
         CSmA==
X-Forwarded-Encrypted: i=1; AJvYcCUww07foWFgMMRXqakMk/Pd+dPtSm4cC5DxvP4xNkk0kJagXg7i8ZbghfB+hvexmhOs6K7bseXbaMnpKA9YOb3c2QW+
X-Gm-Message-State: AOJu0YwHXnUqDcDXgxX+Hb0TqNrkAHG99EU/TgazFWB/zvXr5WedIk1K
	5F4CCBDQNKm6dAKUSOuzel6imQiFHlz2oNkcUFsw780dP/GXiBva
X-Google-Smtp-Source: AGHT+IEdFLgPMJVU9k1ZKznH8rgTwUaowSd4E0N9s8T34GcVU77ybFTB2PAUlmVxXxlemudSceNZMw==
X-Received: by 2002:a05:6512:29c:b0:515:d196:6d4d with SMTP id j28-20020a056512029c00b00515d1966d4dmr697283lfp.24.1712873611425;
        Thu, 11 Apr 2024 15:13:31 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id sa41-20020a1709076d2900b00a4e03823107sm1123808ejc.210.2024.04.11.15.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:13:30 -0700 (PDT)
Message-ID: <57d016ec8ccb9cbc454f318d74b6d657de59ffcd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: initialize/free array of
 btf_field(s).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:13:29 +0300
In-Reply-To: <20240410004150.2917641-6-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-6-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f397ccdc6d4b..ee53dcd14bd4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -390,6 +390,9 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
> =20
>  static inline void bpf_obj_init_field(const struct btf_field *field, voi=
d *addr)
>  {
> +	u32 elem_size;
> +	int i;
> +
>  	memset(addr, 0, field->size);
> =20
>  	switch (field->type) {
> @@ -400,6 +403,10 @@ static inline void bpf_obj_init_field(const struct b=
tf_field *field, void *addr)
>  		RB_CLEAR_NODE((struct rb_node *)addr);
>  		break;
>  	case BPF_LIST_HEAD:
> +		elem_size =3D field->size / field->nelems;
> +		for (i =3D 0; i < field->nelems; i++, addr +=3D elem_size)
> +			INIT_LIST_HEAD((struct list_head *)addr);
> +		break;

In btf_find_datasec_var() nelem > 1 is allowed for the following types:
- BPF_LIST_{NODE,HEAD}
- BPF_KPTR_{REF,UNREF,PERCPU}:
- BPF_RB_{NODE,ROOT}

Of these types bpf_obj_init_field() handles in a special way
BPF_RB_NODE, BPF_LIST_HEAD and BPF_LIST_NODE.
However, only BPF_LIST_HEAD handling is adjusted in this patch.
Is there a reason to omit BPF_RB_NODE and BPF_LIST_NODE?

>  	case BPF_LIST_NODE:
>  		INIT_LIST_HEAD((struct list_head *)addr);
>  		break;

[...]


