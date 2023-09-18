Return-Path: <bpf+bounces-10300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B87A4DC6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B453282AD1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B1721109;
	Mon, 18 Sep 2023 15:57:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE20210FF
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:57:35 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E71B5
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:56:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2906754a12.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052354; x=1695657154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7/VCfZ/0qX+gh35pHtwLjYy8IOpSlbNWTMoh0TEEBo=;
        b=fYPAB/sGSVY021u4QDYp5k4t6JY8efi74NNarLUBDtAyTVuLc3uNIcsjCWQvrIqlni
         f4YBAZ4wZ0W+0ps67l1IlZ4z3SPoiP7b6ztUkwJbQKJWScNbx0w+gtO9/ysWTSn/MAyc
         mIUK1yc7wjhIPT1dX1+j0TA9nQksNZDGchXigKo6lwJH0JHRjXnAAUoPJRrlRXtqaRFV
         Tg61VIi61mdN4F7ekN/CoJorUdaP7wWL+QbcBwBfL5aPddl1pxTi41u6wukqT/3lxR24
         CwlD9hLtDRtrwJtdW030dvsMdU86WY0/1fXjjrJ4DFRbvmNK6C0Bkrtw/syQZKSQu4CG
         1ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052354; x=1695657154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7/VCfZ/0qX+gh35pHtwLjYy8IOpSlbNWTMoh0TEEBo=;
        b=g6WUAnyRA4KtQC/nbVqlQwu2HjnUmOWWUESNmJUw4jByyhHzeGs0EQN/G6c4bUgmCt
         O0TIpnqi6JN9w01Bzf4v4Nox2RwULrSZBFAG3qi9mwIescstebDS4vjcMyxfQrC6MLc4
         UctFYCCcckQE1V/hSTRv48LMs995Dm3F2Z91ImE16+VYQtIFl5aVg7EAsnWlbhhV7eWn
         5vjncftSGZoQ2OzX9SLj8L9v07MsKkagw+M/hHSCPbcxVhgRHkM+y2k+hiUEZbHJOidH
         YHO1xw5tz9R6QvbPeGfd1Nrx9ZhOLOoFM3hvP4bxPHUvh1yasAz2GSlFfKAC2SJIhOIV
         KKWg==
X-Gm-Message-State: AOJu0YwQEUd9OrC84XuJD6z5s1ZPwLDwvuAzkS6YTtvPQZvn9kEEEhOB
	NtwgAKFFSioH5gu4EE620j0TwyNzz4mCdQ==
X-Google-Smtp-Source: AGHT+IFH+oDN9EEdBCRWkZqFPGfEBttnBkrI4RJODj8XnAfmES7gu8Gr+fdeXyNBNDgg1tKBRtdINA==
X-Received: by 2002:a17:907:2c47:b0:9ad:eeb3:22f8 with SMTP id hf7-20020a1709072c4700b009adeeb322f8mr78483ejc.22.1695052354328;
        Mon, 18 Sep 2023 08:52:34 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b0099d798a6bb5sm6588203ejr.67.2023.09.18.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:52:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next v2 0/3] Fixes for Exceptions
Date: Mon, 18 Sep 2023 17:52:30 +0200
Message-ID: <20230918155233.297024-1-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=memxor@gmail.com; h=from:subject; bh=ObqxHCxeTcSdg+MxsdVb36xCD4Y7T6K6uCkrzZz3MWQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCHIauOyLQUHMfBZrwfIs6M5OLiWVltbILC4UH HOQWtqZ5SaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhyGgAKCRBM4MiGSL8R yvmoD/93mRXKP7EciammR/+Wxuihvai6uD04RDdhgd/JowyynhtZmCyIZEuabELToCcMmqSJdJa USz0xkfA2rkIXBPleKDns4W5n/JS3oG/9H6s3z4/NZxyyj05p9BoAsCQC5Rn74nDA9D7R17g2w4 DeAw+T4HM1Moex6GTFn+n1m+C03p5FEFMEhNvF9g2UIW2vfwYxx4g6l8eC70Ue8sC4xdbw5KsKK iAwRGrDf2D3Aovt4rzmNV5HIL+FFZkpsYQEkuIyD4TfGnpPiwebrRKuaU28xuBT0WjmBdofB865 H35zFlSbZGC9HZYL4O3qjis/soPf11ytiV9LcrLkfVeRT8fdhBhBxjEp1eoMGCl8QmI7HHPR3zR 7bq9fOjFppZVAznR/AGkDUhn7aHJH8eB6nEEr0uihM3053MdJdes1QdAnHGY1tVuESdh0aUUdU+ Io2S/Gln48qt8UYsAPZ9rJlIZZs4FJ4nRRbezVNqBYVh2GWuva5JWvVNxNTubvbCEcLNSErad7+ jfxmVcZZar1UZjqQy7iK5pr+lsZN2YH0A27qyV3ekcuGXTvSg5WCD3v94urlR4zdJ4WsLWZjNgL uyB0M89lNnzhAY18B9VnSfxWNTXjdhWmWtChIvj27K1+Kx2Xs3JbKK3Crtc5kBJXgYDgS4O1zy1 /nXUmU7NC3iyAqg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set of fixes for bugs reported for the exceptions series.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20230918143914.292526-1-memxor@gmail.com

 * Resend with trimmed Cc due to patchwork problem (Alexei)

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


