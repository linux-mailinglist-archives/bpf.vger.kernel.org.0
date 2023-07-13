Return-Path: <bpf+bounces-4885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D175154D
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1001C21018
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF5629;
	Thu, 13 Jul 2023 00:31:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9F633
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 00:31:27 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83051FF0
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3a1e6022b93so147391b6e.1
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689208282; x=1691800282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhCGYtSeqmS/9ccJHmaoXObAQsTYdPkI3+8GjFJBNIg=;
        b=O6ZHNgLMHQjULKsLMn223F5YdVhBDZHmhO2iIM9XY1lPQdgmTyKwJDeNgbG6jTbzM3
         sOjP7DCX/Uj0eBYYhgAhifwhv2dmeHHx6yBuif7E8owVJzX4F3NqmLH+Ih96Bl8Ng5Od
         Z7QPZ9A5iUYu8USChf6mIb+AsPtFkk1Z+wfC4LKsNzn4Wa1vX24dUmkOKQONDDTtMNeT
         98VfyuJ9SVwan1fwiZlFiSEGFijm7hoQpS3GZ2X0267I4AlicXD2jQJNaMsYAWuonhyk
         iUmJ4HErk5ZFPzEPtTVyTCn0Lme1rBMnq5FnBcEwPPQBXFtHsrG9VgHhtHNJ3pAidIWT
         sVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689208282; x=1691800282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhCGYtSeqmS/9ccJHmaoXObAQsTYdPkI3+8GjFJBNIg=;
        b=EA3pNR6pKCiT685tQTQ/z8CNyXDeLVMcEUkwWwtF7hEffj/izfjCsgmOfVXNxgtedX
         Kih1NI+sUq1UilWwQRoM/ZydZbDjFsapUAGWeVQjd/I2+AdqjrraS0PJIySHMZwGgiEN
         fMR7ANhSZaXcjR7GQrAWDMBG7OABYtGz2DTI5KG5cA7M83ZUdsUfQAIRoAtcbjKldvUN
         Ty3Oq+2eZbu+t4iDGJaxW3hhn5o5a4n/ZVNXniILZGMniaHsTnXDK/ts2DHSfVsl1SUN
         Nt0lUF2LnRbNAKEuckgk5/nARy5SN7iY21NoYrHK9tL2HnZa0ADUGTRkTzTKuDKz6yTG
         tHkw==
X-Gm-Message-State: ABy/qLbTBzv3eoWe/5MPliRoQK7Su+BnhdUiMkuijQHWseIumPbicgaJ
	nA16/VqEUZ2ds+lJWeRlqnFDGLWCqhkyYA==
X-Google-Smtp-Source: APBJJlFqcczzN1DmeOtWyVKpVRoRRiQd8BPX0h15iiU8tX3KqpL97k5JnovZuDYzLeIo8yh7oYv19Q==
X-Received: by 2002:a05:6808:2188:b0:3a3:f324:bf3d with SMTP id be8-20020a056808218800b003a3f324bf3dmr87762oib.17.1689208282386;
        Wed, 12 Jul 2023 17:31:22 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a62e316000000b006736bce8581sm4312195pfh.16.2023.07.12.17.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:31:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 0/3] Two more fixes for check_max_stack_depth
Date: Thu, 13 Jul 2023 06:01:15 +0530
Message-Id: <20230713003118.1327943-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=memxor@gmail.com; h=from:subject; bh=aQHVDkx3Ol511hWG6X9Xzh5XXI7OBJTPIvAoxhl5oVI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr0XQ4akW0hrM3ch/ZBarwLrLu2Oajdb1pV38E a+9vaWyLxWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9F0AAKCRBM4MiGSL8R yn0KEACD3iMiwJW176JTIEr7lUUvmNRaiWse27lFplidi4F9U1bHAgZXgx2CQMMbV4JTGbNqtcB WRk90DubRY1BKBg0O4RKAz87J7GzEZukXP57ZRrgoHP2a2E/FHNvexKkQ9QnJ5PxW4w5KYRF7mT DkBzmy6ENLehyto+6MpTl82XsR84JAcejVuMs8Wn0oKRWSNvy/hpSMdCkb4YIoPYCw1Hu0V/KKP MFIo+MYzCHqCFAlmjXvOZwjLfepq7i05ZO434UNiJEaJTo6ac6KfBjaH1pOTB216fSDmEDtN62m ZlRF05WS73xpmscyjKnJUIsizPD0FzguMxHYXCeuThGbUhGkVmzbtaCOIe6qw+06XUkfBjIo4hJ MEvXdq6dnMI6NwT0qEAqrSePMXHMGLp9IIIYrzpBf0sKcibFrIHzhvAewg9sWpnrG80HCbe9kfP oF1VwM4vlHdTPEipoOThUaAiwH2hJwI+pTQtks3roP1GEpZLY0oQrSXGqV0qX/3UfFD74Acf3cS tW70hHGP2sGBgmFWdwASgrD//G47wLX6bSSxDXg4o2H+UYD61DqYzEWJqlvjfBaEWlL3ORNOfgl KnhjSHAWh4EHtzH1rMJ8eh+DRiq6HsHJxNBg4Y/xyTj3vsJ4pzfs4cPX/K31HUe37dqmi+MHAuN fNsEkD7wkBlpKIA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I noticed two more bugs while reviewing the code, description and
examples available in the patches.

One leads to incorrect subprog index to be stored in the frame stack
maintained by the function (leading to incorrect tail_call_reachable
marks, among other things).

The other problem is missing exploration pass of other async callbacks
when they are not called from the main prog. Call chains rooted at them
can thus bypass the stack limits (32 call frames * max permitted stack
depth per function).

Kumar Kartikeya Dwivedi (3):
  bpf: Fix subprog idx logic in check_max_stack_depth
  bpf: Repeat check_max_stack_depth for async callbacks
  selftests/bpf: Add more tests for check_max_stack_depth bug

 kernel/bpf/verifier.c                         | 32 +++++++++++++++----
 .../selftests/bpf/progs/async_stack_depth.c   | 25 +++++++++++++--
 2 files changed, 48 insertions(+), 9 deletions(-)


base-commit: 2e06c57d66d3f6c26faa5f5b479fb3add34ce85a
-- 
2.40.1


