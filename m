Return-Path: <bpf+bounces-68865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F69B87261
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446167E4531
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA672D7DD3;
	Thu, 18 Sep 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmmxjsEF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E18986342
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231263; cv=none; b=QKb/5xuDQdIkLRERu0ctjtuTUjRaWGoVFjcQztBURU03x7AP93F9Nlu8mo0IZmYxH8532VbEK+jc2CsFL7L649AYxW4KeHEcc2XbbEsB9NKM+4N7dWyh5l9LTfeqSIAoG0VTeNw8feaPKdpibpw074EKy8jPjwTIUq9UfJ0yqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231263; c=relaxed/simple;
	bh=jiF8RftuTYW8SH2reimzhAXZq/kvD82kmvfYRQxK36E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1RLJ2f7Y3JSIBuqEMnxbm1bppersWRrrseUhiujdqX5KLQYCznaKX1/Ox7mulDF89dvFKCTOWJaQBMQUFPwi34SRLPtxh8bYSxh77zbOn0F1DipEGCre7FPxKTmBYGqHhZVZK+V/W/Fq+PLmbGVt2c5XRNDgdW8K4ez3Q11nbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmmxjsEF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1177374a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758231262; x=1758836062; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jiF8RftuTYW8SH2reimzhAXZq/kvD82kmvfYRQxK36E=;
        b=gmmxjsEF8zKSqGi4g1OjRHK3U69n7OO+2V2rS4IVmAYHzyPkBEDjCZjHsMaH7ZIzY3
         SUf8kHyMs1q15BGzRIqgwKKdHNJ70s/3Pii/Emtvx0dGal54LPg2dB9fV9TnzJ0JGeTz
         eGp4SJMvhjPXyEacOk1c/gej3FPtECenLymhhen5QmKGy5x/b4Vew9+nkZStFZaeQV4y
         xBJQPMpOjFhC5VIkuvytex4V7AsEjLAW7Bxl3shoFenDBm82LM+7qDoQygVq4/tzaraJ
         DakqYkD3eA45KnCf0/xbrNSXMNhvmK8eeFuI3wUpCdw24f0qYnEDf8r8+0w2C6isvNSG
         GVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758231262; x=1758836062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiF8RftuTYW8SH2reimzhAXZq/kvD82kmvfYRQxK36E=;
        b=tc/YZbzMu6AVjt0f/6czLWGE1l9+2RDcbcQk2yuqLDa53UVjZFC44uGxpubR9e1Be0
         vnsgErM95Uz4unsIGDm2ncbnjlB0ecY1CiIZpH1qyFPJfJRuQiwBMTO/AVYc/aZ6o4+Z
         rET4t1B++Ql90HBco+jv4y7CFU4k5bnz/IGhA4QW7PDRhKgq5xYiRj+rKjGSCDleAE6t
         jRp8J3sdjwOy+tVSynGsad70FiBalEYziF0MaOu2zVDiiXMJ0FM862LKbl7Vr8JGjaFk
         1FljktNGiv33A7+DOELcu4uv/7puquI20FmSfS/u1VTi9EJLQCcSKeIjPF3G/9fgmhKP
         BwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+yqFNBejtgNRUfLmO5yPCIJYirwuTfjxcdUhzJ5GjaT1/t5Bj78BL9ZAZzV6tLh/1bNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKYK5oQxi5PQaFVWflotcIMCvb5yhPe19Ettv9+p2dwBxI+0P
	0DgoTwJP8N7kLQOf4/i/oIMh02ZDBtVnTMwhEG4MWVE/MAu15abgm3d2
X-Gm-Gg: ASbGncshQcqhC9zPJHUD5k19kGeIOlw6XPveUMqqNm/zH+pJTj2Uqxn8idsVJtHiCky
	i+Dnv9lQocZELOcjrOzxRq05TzRsxJHJ0QqjzCb6ibmu4gnVmDNJ+Hf8ZhPu4u7vHGytE76y/Dv
	+8J99LK1qfQXVibEbpEpwrk2705KVqtmn1Bf7YIFQ+w2vmLLFdh+MT6aUaAxw7EFC0tpAwzJVcy
	SiWaIww3OK46DAop7S5mgp12ONF+b7ySoeCgfbmqaS5/PGaj8LspQRd6bo6PK+nB1L/VRekjOIB
	tvkxVoyNqZ1O895cixOsMIg2NKuytdArjZmsBoku5/olnVY0cYJj3hzYwHiDWbsy5ZoIetfoDDT
	bdKYUyA11xqh+Pkr1/IpVguCD6tEVO4/KLLbJqbSxrv5BEQHjpkKEyxPYBIjS2bgG1Wc+NjMdVC
	XA6QBxmS8kT66o
X-Google-Smtp-Source: AGHT+IGCb58xoAgjaWavHnxvSPHuWP+PjL2weVZ1bnupLdvwd4X/prAUel+aziXgurEsu3Q4RbpL5A==
X-Received: by 2002:a17:902:c402:b0:251:5900:9803 with SMTP id d9443c01a7336-269ba455012mr13021895ad.21.1758231261772;
        Thu, 18 Sep 2025 14:34:21 -0700 (PDT)
Received: from ?IPv6:2605:8d80:5825:6b48:8e77:6389:4ddb:e856? ([2605:8d80:5825:6b48:8e77:6389:4ddb:e856])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf96sm34447665ad.38.2025.09.18.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:34:21 -0700 (PDT)
Message-ID: <05487a3c7d8f24d2f71e1860aebbfc5b15d7d677.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for
 KF_RCU_PROTECTED
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,  Andrea Righi
 <arighi@nvidia.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 18 Sep 2025 14:34:20 -0700
In-Reply-To: <20250917032755.4068726-3-memxor@gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
	 <20250917032755.4068726-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 03:27 +0000, Kumar Kartikeya Dwivedi wrote:
> Add a couple of test cases to ensure RCU protection is kicked in
> automatically, and the return type is as expected.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

