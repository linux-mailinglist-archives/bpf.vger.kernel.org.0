Return-Path: <bpf+bounces-15329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2407F08AB
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 20:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760DA280D16
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA06199AE;
	Sun, 19 Nov 2023 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is/pUo2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CFC6
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 11:53:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso2742344f8f.2
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423593; x=1701028393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAat1QTTkHaSFOpxNSQoJUkFUJn2WIlPR8yaSKx60DA=;
        b=Is/pUo2N/1VTsBLbbC1WxoKqLqnc78NWN7bZp7Ghs5Mcel9wFvGrQAGIkt5S1rTItD
         iRPAfYysJRhHxcb4cGc21cjg5JCl+OqsiEC9xmAC+L5K8DxBE1sad6PYaQTZyJJu7/X4
         OyCkYB8laqTO9hPwqmSO+oLelilGIiKqsDMdG9qJ8Z14bDccisxQo27tN7t9Q+Sp7ces
         aSPlpGPHQvdQt+u6889ScZ903ryRAGwHBsm7AxkcW4+U5hLrIENiKPIV1POVB8Bszxfw
         MCz4zy2vXYHb0kJer11s8b7Sk/OO7oM1aR41tXVXRIqV/MOK6PfN7GHOxHrsJb3RTSQd
         6+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423593; x=1701028393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAat1QTTkHaSFOpxNSQoJUkFUJn2WIlPR8yaSKx60DA=;
        b=b+4of87rRTBfvYDmVZ9dR5jgYACHurzVPX5RBesCO3jMD1hk4SdnMqBSCt2SYQKIax
         nBRsDtRBczihhfpC7vkhlQeuSN1WPtw8l3lnjW3iLok7vRXu076WiYddQJalmuDx5xLO
         2NwkUH2YpTtezAIyxP3O2Rl9KKEmM17Mj5Jl7p6IM+qBSqG1Zem7i5jUKnoCUw/TXIEB
         g1KN2eT3haOxbAWo/SBP3k+Iy5g2AEy2WAeZ4UGmkN2wX7kzmo43U+S3WoSTTsRutF2k
         GxSff3As+2Ngk6w1DP0keAGx5vGH4i9lGls1iUwQzMunkmI+FOsscnHiVuanmeowRiEJ
         X7tw==
X-Gm-Message-State: AOJu0Yzg3/fRZVi8rfQuB0OC4GgD810DRBQInKe3akIJKmBSB+YWhrt6
	dYaA8LQMd9hiK51qU854SorFm4hDAAvUhht1Oww=
X-Google-Smtp-Source: AGHT+IEHjxRqu1IdvipShAdUNHpHB1Ri+1gCkKJA+/getCfgvPJrOyDw3rrN7HbnbU1kHHV3ZgstcKekRf3vtzxaRl4=
X-Received: by 2002:a5d:5505:0:b0:331:6e01:2529 with SMTP id
 b5-20020a5d5505000000b003316e012529mr4000239wrv.24.1700423592452; Sun, 19 Nov
 2023 11:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112010609.848406-1-andrii@kernel.org> <20231112010609.848406-11-andrii@kernel.org>
In-Reply-To: <20231112010609.848406-11-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 11:53:01 -0800
Message-ID: <CAADnVQL-fyb5v9eyDEc82jcyeXO=xoYorgy1PheO41ZY4LcXMQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/13] selftests/bpf: add randomized
 reg_bounds tests
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 5:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> +/* [RANDOM] RANGE x RANGE, U64 initial range */
> +void test_reg_bounds_rand_ranges_u64_u64(void) { validate_rand_ranges(U6=
4, U64, false /* range */); }


All is great, but after seeing the lines scroll by so fast and so much
it feels like spam.

Could you reduce the verbosity and print "OK" once per test
instead of every random constant?

Like the following:
240/266 reg_bounds_rand_consts_u64_u64/(u64)[0x385e7e5eadec2778;
0x82047f51ee240764] (u64)<=3D 0x4213de45972c52b:OK
#240/267 reg_bounds_rand_consts_u64_u64/(u64)[0x385e7e5eadec2778;
0x82047f51ee240764] (u64)> 0x4213de45972c52b:OK
#240/268 reg_bounds_rand_consts_u64_u64/(u64)[0x385e7e5eadec2778;
0x82047f51ee240764] (u64)>=3D 0x4213de45972c52b:OK
#240/269 reg_bounds_rand_consts_u64_u64/(u64)[0x385e7e5eadec2778;
0x82047f51ee240764] (u64)=3D=3D 0x4213de45972c52b:OK
#240/270 reg_bounds_rand_consts_u64_u64/(u64)[0x385e7e5eadec2778;
0x82047f51ee240764] (u64)!=3D 0x4213de45972c52b:OK
#240/271 reg_bounds_rand_consts_u64_u64/(u64)0x4213de45972c52b (u64)<
[0x385e7e5eadec2778; 0x82047f51ee240764]:OK
#240/272 reg_bounds_rand_consts_u64_u64/(u64)0x4213de45972c52b (u64)<=3D
[0x385e7e5eadec2778; 0x82047f51ee240764]:OK
#240/273 reg_bounds_rand_consts_u64_u64/(u64)0x4213de45972c52b (u64)>
[0x385e7e5eadec2778; 0x82047f51ee240764]:OK
#240/274 reg_bounds_rand_consts_u64_u64/(u64)0x4213de45972c52b (u64)>=3D
[0x385e7e5eadec2778; 0x82047f51ee240764]:OK
#240/275 reg_bounds_rand_consts_u64_u64/(u64)0x4213de45972c52b (u64)=3D=3D
[0x385e7e5eadec2778; 0x82047f51ee240764]:OK

isn't that helpful to see every time.

