Return-Path: <bpf+bounces-30322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027078CC618
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77FA1F24CB9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE5145A1E;
	Wed, 22 May 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObmbgP2v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112851419BA
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401251; cv=none; b=FFdB6xbnyIFbS+Miy9oJHoCyRa2NmEGBWK49FLqymaKF87Lq9E6arglaUvd4vFHCk2ih0fcgabbsFOBlY06XODnzw7JRGDpAlbC7R0nsprh7byJ4pSrQagOWzI7iskKKNDcCPTAuPBU9IdnmMVImo3Bg1EgMt8aD0Wgt3L7kSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401251; c=relaxed/simple;
	bh=Vf0E9CDIMJ96KkJh8eTeS1AgoDQu+hRLoAvGoMJQSyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txfweX5s1TT9fITFXEZltYOe+jD1mKaFtOIy2GfBpQuHATtbM1G9P5LKGbjfLPRGaTLoA5SX3slgeL58jEjkVicf8cFUUvAD7RUK6ICpZB3kHSJwydGgttpHTvhJDV1nrcixCNOvXapNtJ2GB/CAg4p6WlZAnZyCOlXh3D0+j2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObmbgP2v; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2438871a12.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716401249; x=1717006049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vf0E9CDIMJ96KkJh8eTeS1AgoDQu+hRLoAvGoMJQSyk=;
        b=ObmbgP2vDvrcq9J8ZWIPW7Qd8TTlby4PHu6iNCxWyQBE5PA/Jq2rjzKaEw6ECx3lAn
         KvqeF1BOTxYSKp5oJTLisuymFviJn99DNg86gyWduRdxB6prxsFf1CtnOlPGsXNpi7mS
         Uh/WnAnFMjCaDS8v+Nvx/DcYI7hIbmxVMgOF7fn5JHkzJRniamYvRm2BaO2LV6gOhl9K
         ev/esueTmIisZCMJJTWR3n1+sNAVEE2MRldi0Tyw3KLO3V+jxbSRsri/WBBsMOqhsD1E
         u87gWnNyDZnihZTmEsYjfyVSJSdFdMGkN7V9PC5UZDouZCo9kgQaVQOyQRal0jfRV/5j
         2WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401249; x=1717006049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf0E9CDIMJ96KkJh8eTeS1AgoDQu+hRLoAvGoMJQSyk=;
        b=k3T2H2LdnHacud6hi7eHb/6JyVuQAV+xalmWvLXBlXVc5/C11C7oiPQBh5SrDXwCb2
         7G036lXmkZ8se9vba7TasotGHMtCkBlwHz1joALkl6n9d/lNM/TtNUPRE94TuNo1uDcY
         HcTycgfEfu21LdPs/BH5MW9ZMVxJbUwGvz8F7Y9UQshKNR4I5XSMDgjB2JPpL92FFE83
         wq+0CIu7xAvjO40Pqn41/I4ZlKrFmn7VQtoBdkYCVL97/rWh1xP0DdAqhYYu05RRFbAF
         g5E9KdYN3pagKiPRjZVonrrjxuKhEtSq6m22KbSPLFnw2CDCS1Yz71ld2fkTx1bJYxBx
         WdkA==
X-Gm-Message-State: AOJu0YxKvXWO95lePJ5u0nkLy8wcY2JpggESOWIRXMD6r7fmoJ871MGt
	OD3u3wPPmiEknx5IRipG7UR7iPjkYDbKfWXRhmeHQmZsJ0yFdHyf
X-Google-Smtp-Source: AGHT+IGL3pSC1RadK2Q7wcIqHikZZBKvBsJOUg04G76O97y6mBanL80B2qU+aURCs1MjdhfCEQM0/w==
X-Received: by 2002:a17:90a:db42:b0:2b3:28be:ede3 with SMTP id 98e67ed59e1d1-2bd9f5c0d9dmr3018819a91.47.1716401249165;
        Wed, 22 May 2024 11:07:29 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f2a180sm63810a91.47.2024.05.22.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:07:28 -0700 (PDT)
Message-ID: <d13c923a07d91391e7c4adc6a6dfff7279ab6a4b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: crypto: adjust bench to
 use nullable IV
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Date: Wed, 22 May 2024 11:07:27 -0700
In-Reply-To: <73add1b3-b1e4-4d83-85b3-5be45f2658d6@linux.dev>
References: <20240510122823.1530682-1-vadfed@meta.com>
	 <20240510122823.1530682-5-vadfed@meta.com>
	 <73add1b3-b1e4-4d83-85b3-5be45f2658d6@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 11:01 -0700, Martin KaFai Lau wrote:


[...]

> Inlining it would be nice (as Eduard mentioned in another thread). I also=
 wonder=20
> if Eduard's work on the no caller saved registers could help the dynptr k=
func? I=20
> think the dynptr kfunc optimization could be a followup.

For the context:
https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registe=
rs

Basically the attribute says that compiler does not need
to save all r0-r5 registers for some function calls.
My changes for LLVM/verifier are not public yet,
I'll try to speedup.


