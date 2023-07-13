Return-Path: <bpf+bounces-4906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA81751686
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7A21C20F6F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E7A5D;
	Thu, 13 Jul 2023 02:56:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193577C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:56:51 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91E172C
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b7541d885cso179947a34.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217010; x=1691809010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iva9+IkHQXmkGP6zMWZGoPlGtFg6Su84hHocxJdrU+U=;
        b=iHPaPaLTeNxSL269JEE0QiYF6TBiFuq73YerB/ObAWI+fUkWb8X3Tw/hdnWatwRYE9
         kPjZ3u2KET1qGFFkAKWR+eJDnzK3c2cOWRZv673X8N38K3CQENH2aWzxDD+nkMheLBT0
         9KxQo7LV5uoy4ZBLHfsmDxPFb8RyWgxhSI1d4VVvzalxY9P+eF3rmPdMANMuybhf/eVO
         q+10nlkEP+hrhlpZEfBBKTl7iDDCBPkgwUV7L4ckcx3U9ayHQWwFX6QSSx3IB77LvQJV
         ljgM7Ln2XJZoJHzBNJ3YpCOdM1j04DeLItEcb7tUJjjHVE6tJm8ACEwcjo7umP24IGsK
         nQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217010; x=1691809010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iva9+IkHQXmkGP6zMWZGoPlGtFg6Su84hHocxJdrU+U=;
        b=eRIJxDrBdNGGozdWdc0p8S1s/xiq+Hc8xVeQKf2W+yExupTnCkUXb73KmxVl0AHrqi
         9V2s5Y/8gqkZ8m2WT4wa3bUTdp7cHjL+tdTjcNBJcn4S/3ry/57CS9JV+mV2OGGAEeDQ
         3aZkN1nKLBhsqOocDOjbdawxGrw2LpTJCWkaQSap0vb1qBuaNv/rs46k7zWyDOV1vHib
         r6ZH0U2+oMkdutx654/xcQWTu7TWkvG6XVh6+BtjF8/8lPnNRklgUXRtma14DQvfIXKR
         jiiPTMTDkRC8mDSlGjIdLncPtUXc/PWSBhBIVHthuSK9Km46SO5ZKKBo+cZLhQmqHgSO
         h9ZA==
X-Gm-Message-State: ABy/qLbiXE4ELlBNDSKIgGrlrO3lL+wLF2rhhJqf/rwMQG1USEiVTX71
	FTjHoypbx0J+2Hy/WaaQvuI=
X-Google-Smtp-Source: APBJJlFaRh/C2x4KWjwma19i9oX7R8KQ4KNCDSMelhb2OOFDXlxQnxHSWli9lkD+sZ8q35eO+ymY7g==
X-Received: by 2002:a9d:6545:0:b0:6b9:91d5:7700 with SMTP id q5-20020a9d6545000000b006b991d57700mr435940otl.6.1689217009950;
        Wed, 12 Jul 2023 19:56:49 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:a97:5400:4ff:fe81:66ad])
        by smtp.gmail.com with ESMTPSA id lr3-20020a17090b4b8300b00260a5ecd273sm4416681pjb.1.2023.07.12.19.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:56:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	root <root@vultr.guest>
Subject: [PATCH v2 bpf-next 0/4] bpf: Fix errors in verifying a union 
Date: Thu, 13 Jul 2023 02:56:38 +0000
Message-Id: <20230713025642.27477-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: root <root@vultr.guest>

Patch #1: Fix an issue found in code review
Patch #2: Selftest for #1
Patch #3: Fix an issue found in our dev server
Patch #4: Selftest for #3

Changes:
- bpf: Introduce union trusted
  https://lore.kernel.org/bpf/20230709025912.3837-1-laoar.shao@gmail.com/
- bpf: Fix errors in verifying a union
  https://lore.kernel.org/bpf/20230628115205.248395-1-laoar.shao@gmail.com/

Yafang Shao (4):
  bpf: Fix an error around PTR_UNTRUSTED
  selftests/bpf: Add selftests for nested_trust
  bpf: Fix an error in verifying a field in a union
  selftests/bpf: Add selftest for PTR_UNTRUSTED

 kernel/bpf/btf.c                              | 22 ++++++------
 kernel/bpf/verifier.c                         |  5 +++
 .../selftests/bpf/prog_tests/ptr_untrusted.c  | 36 +++++++++++++++++++
 .../bpf/progs/nested_trust_failure.c          | 16 +++++++++
 .../bpf/progs/nested_trust_success.c          | 15 ++++++++
 .../selftests/bpf/progs/test_ptr_untrusted.c  | 29 +++++++++++++++
 6 files changed, 111 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c

-- 
2.39.3


