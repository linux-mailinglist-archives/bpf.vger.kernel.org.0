Return-Path: <bpf+bounces-10294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213907A4D6A
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01E9281328
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4842210E4;
	Mon, 18 Sep 2023 15:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC91F60F
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:46:59 +0000 (UTC)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BA170A
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:45:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-5007abb15e9so7742465e87.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695051723; x=1695656523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4FGlzhXZN5NY/tTY6QggXhoYxgUI68tcp58OerBbMo=;
        b=MP+GNJJ9Wzw0DvNdomugJWAa7I2t7qBoNMYkQt91rG3kXPm3Z/FR42xnsFFmIlYVG6
         5MX/2C3E4aleRacXBLe9rop+KJtdLTRiPubSUjpWd4HaX+K0deCFWJyHCFTlO93GS49t
         CfKkgiMglO3vrPg01k1rR+toSN52ju4jxrvAp2GM38OussbpyNRY6tTaxS55dmuS78Pc
         6YQB3Bo9c7XhTxpHRkraD9/dFekG0vj8GscKUIAbzPiYJOB0qANPGNEwOaXTJRJdVsOU
         K+aN6gFe/Itp5mzQgFAmfGB9+AH+I4Ixr7eU3jemyCHPihiDn8IMRNd5D49WhE9n14Sb
         5oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051723; x=1695656523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4FGlzhXZN5NY/tTY6QggXhoYxgUI68tcp58OerBbMo=;
        b=Qxdcl76hpVee0yfBE8qIueSpHB6vpBR8waz91sNFIkVmyogpmL2BHZdSc9ol2XM0Iq
         JzXLpP4FQcOHLZ4YWdRIVZinHl1gKhdSpolUEXnZ2hqRp7BMTadvqKdGP5MvQ9AclzUa
         pxdWv3bObIcQwVIyNy7dew9MU/MiHBXf+tE6twYb58VAlgYNzPXdqHavJxsetuUptEIm
         SqTT3gjLoM0DjcKhNBZHvJgmqCgkhL1IDcPd8dY5gATM1hulro/sSMx//g3lq7wPqb68
         kUHbvWzb/GAa+iCd6nCCWVLgkPzbSHfnjtgm4vidZwfrYAP5+fPeMCzUd8YTZM9nuZew
         Yl6w==
X-Gm-Message-State: AOJu0YwCu1qh44xkNqQM21DIA2ka6ckOt0nqx0e8CICBa2BeM/pio9+6
	c5PX1CndwLg3gnGSmqQhDh2KlSXY8M1qPQ==
X-Google-Smtp-Source: AGHT+IGXoUTWs16eeGgewJr1p2+y0yee0wljTGiTMDAW1zYL5BWCqF+ow+Gp283tLzut3Dwoyi37Fg==
X-Received: by 2002:a17:907:780e:b0:9a3:b0c9:81fe with SMTP id la14-20020a170907780e00b009a3b0c981femr8028842ejc.57.1695047956329;
        Mon, 18 Sep 2023 07:39:16 -0700 (PDT)
Received: from localhost (vpn-253-124.epfl.ch. [128.179.253.124])
        by smtp.gmail.com with ESMTPSA id u11-20020a170906068b00b00991faf3810esm6601433ejb.146.2023.09.18.07.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:39:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v1 0/3] Fixes for Exceptions
Date: Mon, 18 Sep 2023 16:39:11 +0200
Message-ID: <20230918143914.292526-1-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=589; i=memxor@gmail.com; h=from:subject; bh=0AuNN5h0wrZ43+UN/7j6/ie3bJg3jCgC3cT0v4EaiFg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCGDZrm04BcKOgGOTaPvXzRPLOhMSGxTvAwEbx hKAg315k8eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhg2QAKCRBM4MiGSL8R ynDSD/sHE/XEUMe9I5VYtzNkDq9N4qkcey6za8+bvUzYfRFktKXrPGxFUVLtXHGMBH3vXMYCox/ wR0JMNTNQu7wT/lT6lOwU56VNT09at4gCdFKdF3oo+T22d7lW4YTrNREmyW/InVgjVktvEitROT uKatY/fRQ/au1LFNZLB/bKoa23rBL5EJHXnR3I8itD82DBdlgESUcP5BEEAZVpyWtEn1ZZ45Vfs Uyp0gvgadNrJdkAznFvZ8xUxuJmonHcFfqv5blbdezudToNsODsD3+pJnuXUTFRfqUt2DPLyaHO yX4Sz592QkcsgSzszrJPgDKdWrqRFSGYI7beKBZcyhvvAfj2/TXV85q/32anTWuEUefgXSboXER yaB8ZlwN5nOLuCTA1AXH8qMCD0/Fz8EVhu2MkGdFoOkcigw/TnftMFLCKrW3EMIXezb5+pI2WH2 k4mjpBzN1qvceF13D2aMoy4EBGXiNvxFyG/11enjr/ItGyBrYgvATBW4mTAPRH7Lc5l1RjbdZUy RePSXLkfxjn/pwXlwMCWiMrl9NxIgQzKE1d73HzXG7BiDcPkr/ctwNGyLh7GINuxYQu6Ne4CyD9 dhKfqnaRw3JF6pxZFdc823nFUeVXWUUCEdIpZTwZHaDERSPeVuR0F4gq8nDy/mXpMZKlciIbhlv 41hIAHIFbjQuYpw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Set of fixes for bugs reported for the exceptions series.

Kumar Kartikeya Dwivedi (3):
  selftests/bpf: Print log buffer for exceptions test only on failure
  bpf: Fix bpf_throw warning on 32-bit arch
  bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y

 arch/x86/net/bpf_jit_comp.c                         | 9 ++++-----
 kernel/bpf/helpers.c                                | 2 +-
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 5 +++--
 3 files changed, 8 insertions(+), 8 deletions(-)


base-commit: ec6f1b4db95b7eedb3fe85f4f14e08fa0e9281c3
-- 
2.41.0


