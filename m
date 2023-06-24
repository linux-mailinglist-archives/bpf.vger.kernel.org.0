Return-Path: <bpf+bounces-3365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DA73CA1B
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2EE1C21225
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE976441A;
	Sat, 24 Jun 2023 09:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3C3FFF
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 09:28:14 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1355269A
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 02:28:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31126037f41so1684880f8f.2
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687598887; x=1690190887;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yALLPmOE7+hISGtYfMqKGpt/k5yG5q3Ed3XuC87leZ8=;
        b=Qv1Ua19tBkqyWfEwzA5JBVMzDRypzLj5juPHXL9MXlsxlPXF+KUNdGNDgktJlSrrTY
         0uUhXsfhl7DT+xVr7gb5ezCgaLruQC8cSfGL0mSvEzc+qr7S+JFU40WMbb2bl9TRwARX
         1ilpKnmsf105pKf+wJr3h9nsLH6kiCqFkud69H0mDwaB0ua0WTRnEnpGDZeb7War868m
         YprPYPiWM5MPAulDrmbxAOJcdh/SzuU4jL6hiTIE+hdqHOJmHR6DFGzz5FaP/44hcPM8
         jLnr6pYgF0jSh5Bdla2vC727/GtxmPoV0YvDpU9iuyQPkS/y2szdsUA1sgV+jnU+CXH0
         QQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687598887; x=1690190887;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yALLPmOE7+hISGtYfMqKGpt/k5yG5q3Ed3XuC87leZ8=;
        b=g+yrK0dilkgn6FbH3H4aCluCACxbI52BzadWWuHs3neBFsEGuXZMp2wmsXJJZm18MN
         ZXyu2luDB0PJafPvxRDocIJKmcEveOY7k5ZyHMsvlQiO6MGP/ccfF6UfBFkZlds1T3Bs
         IfdYXJve0+T2Ep7egaaz4po24DoEV2atPfwvgXscu0S5QrcK1W4io9GohCLEdN2Xh4kx
         lcsm+EaEIphhujFhzELgWFYpPVAQV0iGQFN+j9TbhYQm9MEHl1BGk8AcfWw7/xvQUvCW
         WCb/CB8saGDPGR4ptNyC/5hlR2UQTWonORgkuAWZuxThR4cTjxmIAfYD4L71nPRj6sh5
         6COA==
X-Gm-Message-State: AC+VfDyv2lr/vjDPabeV3VZXCNj5eCKwuH9Yrcwnudztn1ovoTr6N19F
	AflCnLt0fZuAkSgxFwljFza8pK+0sXatPvQqJuR7ew==
X-Google-Smtp-Source: ACHHUZ7UZ43FKF6Jax69cdaAZdJa6U/q1U7TusiAstVCGhkk0TjGj6cLc/jLumslzqFBTp16WULcow==
X-Received: by 2002:a5d:6ad1:0:b0:2f5:d3d7:7af4 with SMTP id u17-20020a5d6ad1000000b002f5d3d77af4mr18514644wrw.63.1687598887140;
        Sat, 24 Jun 2023 02:28:07 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8011:e80c:0:9f:41d5:6eae:4002])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b0030647d1f34bsm1652247wrt.1.2023.06.24.02.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:28:06 -0700 (PDT)
Date: Sat, 24 Jun 2023 10:28:05 +0100
From: Quentin Monnet <quentin@isovalent.com>
To: Fangrui Song <maskray@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
CC: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Yonghong Song <yhs@fb.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_bpf=3A_Replace_depreca?= =?US-ASCII?Q?ted_-target_with_--target=3D_for_Clang?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230624001856.1903733-1-maskray@google.com>
References: <20230624001856.1903733-1-maskray@google.com>
Message-ID: <A886FC2C-35BE-4215-B9FD-61B62EC56ACC@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 24 June 2023 01:18:56 BST, Fangrui Song <maskray@google=2Ecom> wrote:
>-target has been deprecated since Clang 3=2E4 in 2013=2E Use the preferre=
d
>--target=3Dbpf form instead=2E This matches how we use --target=3D in
>scripts/Makefile=2Eclang=2E
>
>Link: https://github=2Ecom/llvm/llvm-project/commit/274b6f0c87a6a1798de0a=
68135afc7f95def6277
>Signed-off-by: Fangrui Song <maskray@google=2Ecom>
>Acked-by: Yonghong Song <yhs@fb=2Ecom>

Acked-by: Quentin Monnet <quentin@isovalent=2Ecom>

