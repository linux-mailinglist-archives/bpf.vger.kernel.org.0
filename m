Return-Path: <bpf+bounces-70378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944DDBB8EC3
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548C04A1618
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64696221FD0;
	Sat,  4 Oct 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZKZJaEQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BD21D3EE
	for <bpf@vger.kernel.org>; Sat,  4 Oct 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588119; cv=none; b=Jjbt+G17smkxOWMOZrt68l3odsJfrn5uF/tZI8kvM4/4syrBSBCUf5AQvcscFLXXROfOWLgVq/aDIlLqfufzfbxzuL7L0NDQgSArKaKKgGoBLKtOUxXp1GvHr2hBtxS8h6dEzQj/gmk1rvxL9iY0gyDe3a61AtGIzKXj6LAPjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588119; c=relaxed/simple;
	bh=ojfKhhX/8wUyfMb+0xl3q5bck6Je10S6jxPo6lslJEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Msjzi6IBKxhSKwV9ratyf9cEwfWu/VQcjnhsTSNwjtj6GBdV/KcG3aJIiEfpRueLPWaTjDCg8bSQof8dyK2qorqS+XM/Ydi54CTAAgemp+1gvtXJuxDgyATLmGkFp6WaTWFwKLbOHRpa2i4sNXphwRR1rL7ijPcpS8XcTUmh4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZKZJaEQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso26650235e9.3
        for <bpf@vger.kernel.org>; Sat, 04 Oct 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759588115; x=1760192915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=XZKZJaEQRpd5vYP6qooEAwK5kOayE4jcfODHzcU5UWQysIYInQJEfHZ6YSkp5MGNnD
         wtqHsB0pX9W1jMNePz8YHCvpYh78490I8Jv9pEwNjVHicLMaezBioZlA2K8d5VU1rOb5
         J3xm89wLYnil/HxZkXQMRFQ2F07atPA8buqTajbJE1RZbnP5uQdzML1hGdIA8AlsmFqD
         9/QEEAlr6xJqozmocI2PzuwhVtxrNeTEv6++hx3LL4GbS9qDz8heykCeTxAC0sNiv22A
         Z3GYZRh6iA1KK+tb0GczoDmH7mDY1pORgajFcZ2wOmaW/IsB74gFPqGRVa+8HXZKyX5t
         LO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588115; x=1760192915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=byvW6Sq0zYlg1prmbgVxnkKfRebXv8DZ8MYCoUnh7qcgW8pYm4cZfWtp+oSCepNk9h
         v1dEqD7y9/3QOXVB8Ocn27/cKvXvd9F7n1HM3y7s0FhFC4kTaXCuP9lWsV1hggQsgyot
         K4O5P+rOcudeJ8qTkdd6ajiO7+/lpfKYPdsL99BiLkrQOEQuJbNl82WdqWNTfRDvOUGD
         dfTp2TF28hjTm6RMCmS+OwjntjJzt6AHLWuRNtPAGk0CYU13RIc4cHwZV6hUjbAzrImF
         xFvJQKClT+Vs/yxaeSdg10rVGNN9JCU09y0o6MwE8gw+5f+zp0zin9DH0iVKUM2pDnhq
         vt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXYtuZpoqRhk0PyTo30lEiyHrdDNk3Iydm8wGLoOPtyt0bmhltKPp8ye6C/W4PIbw1NWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMZQmkkN9cIriTnDzbk4Il+AgRV9+sz0NeEzmrbNOEWuISxt5
	AHPsKGwv5p1hQDw6bQKcXM9Lo6DzdyW1D36VR8JfxXU5a/lWugH0Ii4bntGkcTFlCxF2mSDbIW8
	C5KJNP+66x7vlxewzx6Ha9vPZa3fxxM8=
X-Gm-Gg: ASbGncvaTDXauHkrF4Z5YwDa87Ae8TVQFmHaasSvkvcoO+qlaFYG2vqBGEd5vJ/6NpD
	neo55KePjMxVaWHy/0y4qLlKc7n1uOwebN1A0wzv6Cqj8wBBSfqwhKTolmHs6+v+VVOTNLLGvty
	Gia55908hjQrLZe8OlvTO8BBjFnLDUOCR92NLY9D5AEV/k6u4NHlPOVV/qVQxXjx6zLfu5iHsX8
	l2UXmmBwNIBwyJh1ydjzBI/kpOBxAt/v7JyFxR0wYNQVYTxjOphLrKZI/08
X-Google-Smtp-Source: AGHT+IE4Og6jwiPBBmHNkCPbBDPgBPqP5LwHuX1iUxTwECiL+8Mx2MUFp14C8Hb8qOdMhIteAMZP/szUC0EtCxKPQzg=
X-Received: by 2002:a05:6000:2dc3:b0:425:58d0:483b with SMTP id
 ffacd0b85a97d-425671ab837mr4385671f8f.45.1759588115404; Sat, 04 Oct 2025
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759584052.git.rongtao@cestc.cn> <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
In-Reply-To: <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 07:28:24 -0700
X-Gm-Features: AS18NWCncY86K82MEOsvI4_LR56kfq3c6aMGWJWk4LCNmAzvAbhcCXDAaeximk8
Message-ID: <CAADnVQ+iERbZZ35CbPRamMqEu32ptEAXL0OQAhansfzBX+HDKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Rong Tao <rongtao@cestc.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:37=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, si=
ze_t len)
> +__bpf_kfunc int __bpf_strnstr(const char *s1, const char *s2, size_t len=
,
> +                                                         bool ignore_cas=
e)
>  {

Still __bpf_kfunc ?

pw-bot: cr

