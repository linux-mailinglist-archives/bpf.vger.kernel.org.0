Return-Path: <bpf+bounces-16830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCF8062F5
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE69282166
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F841220;
	Tue,  5 Dec 2023 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kujMuDNS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12031AC
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:26:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50c0478f970so1550379e87.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818795; x=1702423595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBGWF3XhvL1NFgP6D7l7v7TtP5o07lwsMj7SKzhFiBs=;
        b=kujMuDNS+jVwG52YZURcswYRGOmiv4wommHlKByuhV/gnfcQtnfjvQQBH1pM1JXrJh
         eJYcNKyNOBIukrk7k5IjhA7wGiKcN5s92epH/lYKojl/IuPNan+Ivqa7hYOqUuJk6CMq
         RlwKzjmo7gPsMCZF65O80GMO6G5ksPhTy2Zo0wC1wRt/h8qSDDcfXoYeGwoHaxCKY3mu
         Xz50t4KfPbFot+JIiqCs5vL7sSLBtZL/GMwHFzEdAuPcuwb/OSxg5hBwG4RvpLt2trwe
         s3GpKaKJY5+KonARYvy2YDIC1trEPkuk3kSJ7IfMNkaFy9qADB/0czBrNIuUZsVx/tn4
         PKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818795; x=1702423595;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBGWF3XhvL1NFgP6D7l7v7TtP5o07lwsMj7SKzhFiBs=;
        b=HxwqrpNP9IYUK5to+YlLkLjK1qyL1os+r3NCGLtRPIX+LyylAlvvG7I7HdCDe2/w/J
         p9LllkZ3YKi4DpklKv1qyaA7hTRy8ibIg//L/aEu1MlrudG3hm6NnGynLppDbAsgv3fQ
         /xx4JhM7Us9gvYCndU3Pkrw3rm7aClXDKPP3CRljjAGMQ0lf4L3rh6m559XGhsbK0V//
         Lfv4XzC5UgYb29gDa6VN7n+H6aG+cZws+7nLNuSY0ra1ZaV3IqU3CH8W7LTVzVs64Ggu
         ronV05NVrh5Ba+KtTshsTeikQhYFRHOKonj92JNkBVo7tjcTskdGS7JmfNRSd/pYVchV
         nJHw==
X-Gm-Message-State: AOJu0Yw1PC7oB6fF6D98KyEpMIP2HozFFIDPfXpViL/pjXmj5ouTQKcf
	unR8k8Pxzn+8TFvNrNeSkLs=
X-Google-Smtp-Source: AGHT+IHeZ/Va+r/o0OTeJpSlV4DEzyft8xAv1gud+Fk8jq9Lo/ddGt2kzOLDmb7X1rvG+KCeHaLPKg==
X-Received: by 2002:a05:6512:3c8a:b0:50b:fdbc:78de with SMTP id h10-20020a0565123c8a00b0050bfdbc78demr39169lfv.18.1701818795185;
        Tue, 05 Dec 2023 15:26:35 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q18-20020a194312000000b0050be0049075sm714816lfa.251.2023.12.05.15.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:26:34 -0800 (PST)
Message-ID: <6146f99cadd854e98e8668a92a6d35899d39d763.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/13] bpf: prepare btf_prepare_func_args() for
 handling static subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:26:33 +0200
In-Reply-To: <20231204233931.49758-8-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-8-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> Generalize btf_prepare_func_args() to support both global and static
> subprogs. We are going to utilize this property in the next patch,
> reusing btf_prepare_func_args() for subprog call logic instead of
> reparsing BTF information in a completely separate implementation.
>=20
> btf_prepare_func_args() now detects whether subprog is global or static
> makes slight logic adjustments for static func cases, like not failing
> fatally (-EFAULT) for conditions that are allowable for static subprogs.
>=20
> Somewhat subtle (but major!) difference is the handling of pointer argume=
nts.
> Both global and static functions need to handle special context
> arguments (which are pointers to predefined type names), but static
> subprogs give up on any other pointers, falling back to marking subprog
> as "unreliable", disabling the use of BTF type information altogether.
>=20
> For global functions, though, we are assuming that such pointers to
> unrecognized types are just pointers to fixed-sized memory region (or
> error out if size cannot be established, like for `void *` pointers).
>=20
> This patch accommodates these small differences and sets up a stage for
> refactoring in the next patch, eliminating a separate BTF-based parsing
> logic in btf_check_func_arg_match().
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


