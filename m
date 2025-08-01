Return-Path: <bpf+bounces-64911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA72B18593
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41FE7ACE8C
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775428C866;
	Fri,  1 Aug 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euvx6rhs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5B1A0BF3;
	Fri,  1 Aug 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065083; cv=none; b=gaIumqd+UG8u/85+wfXOTyhu8yoyRiZUwV5Hz26mnhnHnUAbUMKbOTaiBP95pdK4tyMBPGh72CNdabvMQ618hqlhaFUwgYiD0XzupUJqWlfM8SNPj3kw+Ip1i2ZOJCAWaAVJghVma7GTvddIYYLqupjlkYAqj9VlD3brb4zUl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065083; c=relaxed/simple;
	bh=IWtqxFVicIREieMW4896VRoD6F24Ir30+XrdQU1a+l8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtfLYtbPPE9fSbxDinzx9alvA1UsYLwV673u9wjX/20No3FcilLolcFnjXL9Zg3I6QSDo27PYZWcuM9wgILNyZQR6oHVi6IUEJDu4fgvzFzuKkiZ0QwU5UFSm9MJ+pBDIhtbucUkg/tNWWbSBLBj4A5AjeNoY/6J//pdwWRFGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euvx6rhs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31efefd2655so1780452a91.0;
        Fri, 01 Aug 2025 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754065081; x=1754669881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWtqxFVicIREieMW4896VRoD6F24Ir30+XrdQU1a+l8=;
        b=euvx6rhsWONm4j7R4orbnfpU26jp/kbg2qZ7VMMoIDfqA1Js4wPIe0QW+0Koa/2TyM
         hZ9TRYRd9e3F1jpnYG/Sfd0HccsCWtQZrj8iQucU3CQPJcy36ewJB7kl50kbRDWId6uy
         s39jQ98SVJTnmzypkvOkN8yEKCb3PFlwGHiXTEvoP6e8Dib+RuZVefkQvuju73wtffVg
         g6CPMld8oZPe+MsFhqvn2lwcme8fRT7ePrpC0lC47auKi9RPqkzrkLZqYClVBTMLMHSH
         34biqtPH5HOXM8EWHgWdE2YGKF/G/D240MFtTb/s8+RwHqdZ+t9Th0b0KaBcQ35iHDTa
         z65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065081; x=1754669881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWtqxFVicIREieMW4896VRoD6F24Ir30+XrdQU1a+l8=;
        b=g0i3iIaTolrGr3NjR5Ub25feIGxx9ze5swbGbxytEI4CoD4FeZ4y+Zo3huTmSb2dQH
         Xah0dJmD1JDUJtwDSc29LDILBml2MW5JYzMFeTaYiRPyVUJkpfQwAiyhRmR4YDSpU06a
         dz7qBTg9rd9go+GBlgSjTQKJaUOU6W1utcnXY9qqtenpu5nSnIZAyybpA+Zja4ZRh+Dz
         BPffjYQQVR8nBel9HuREQW3+zfmErBH5zTn6ntdg73gZq0bud6/vJwgRsQ/s6oI8MSZn
         +J6uzXeOOEiuhOvHhzY7XCsw4aZrtfU0he/xDWTzeNsAzU7vapwbuEuQeQBzR9G+gZGn
         oDug==
X-Forwarded-Encrypted: i=1; AJvYcCU895TwpyLA3QxsWr2ND4wdBRbEBkGbXMsSyi/RO3hqjiu4UsyHvd28GwwJ94SFsKyypwrohUSHjg5yDD+IUsNX@vger.kernel.org, AJvYcCXkWq28WrU6+8aA5oTBEgZARW7oQiLFmPgRfLvXjugid93Y7U1Usa+KwDIs4gqQ2p0oJPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdplE/+Ct6HJX1+1s4+BPW96+XBWdYHgju/oN5ImO7WoagGXHX
	wU7z8mOL5/ZxSPRtb5ubqs7v6Tr6OpQhzLVEHevDvjPo0VPxqkwDw7+x
X-Gm-Gg: ASbGncuzrIVIQzFlhx9QZxUump3ia/OXt4vSOmLOnLk+0BM8P13WDXJ1aWIzvEorfZw
	6khI66yWFhbZDPcYMA34It8Qd+RdMLzDPKh4EtAsQHLHMBNVMW8mv8PyzPNJMQM662p9QeC6+sh
	E7ri+V8Abnd53wb3raZWEz8b+oOYB7lqH4rBo6zeVOvyjhaG+2VD+ugXmLi9WpUUT5KJ5Cln562
	U5gp1GO2wOH1tIc5BLbvOJ9OsczRROMS9ebZkXJ+c/dctHwG/PWS+rYrRgKUgRpgZTJ2mw3xasR
	csQmz/pWBVTJ2Q52td0OcRC65AUVfpNgrZYKgMPmQONuBDXQbAgtvanhv9Yqju81KwtstWqGn/k
	LK9KyCE9kbRWZJvLWMLk=
X-Google-Smtp-Source: AGHT+IEqL0BBeYGacOCFzX0QMTZjLPBF9hcdvdcm86TgJiT332M1ZGEMFwp6jzkh6Hnf90JazAWNhg==
X-Received: by 2002:a17:90b:388c:b0:31e:f36a:3532 with SMTP id 98e67ed59e1d1-320da613e78mr9586640a91.13.1754065080753;
        Fri, 01 Aug 2025 09:18:00 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc167dsm7826538a91.11.2025.08.01.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:18:00 -0700 (PDT)
Message-ID: <6028814f139d568865aa504b9ae0b2c6126453c9.camel@gmail.com>
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Test for unaligned
 flow_dissector ctx access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Petar
 Penkov <ppenkov@google.com>,  Florian Westphal	 <fw@strlen.de>
Date: Fri, 01 Aug 2025 09:17:57 -0700
In-Reply-To: <bf014046ddcf41677fb8b98d150c14027e9fddba.1754039605.git.paul.chaignon@gmail.com>
References: 
	<cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
	 <bf014046ddcf41677fb8b98d150c14027e9fddba.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 11:49 +0200, Paul Chaignon wrote:
> This patch adds tests for two context fields where unaligned accesses
> were not properly rejected.
>=20
> Note the new macro is similar to the existing narrow_load macro, but we
> need a different description and access offset. Combining the two
> macros into one is probably doable but I don't think it would help
> readability.
>=20
> vmlinux.h is included in place of bpf.h so we have the definition of
> struct bpf_nf_ctx.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

