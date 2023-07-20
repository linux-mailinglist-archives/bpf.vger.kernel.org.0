Return-Path: <bpf+bounces-5494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8075B37A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAAE281E64
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CEE18C33;
	Thu, 20 Jul 2023 15:52:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBC1772A;
	Thu, 20 Jul 2023 15:52:44 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C674135;
	Thu, 20 Jul 2023 08:52:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89bc52cd1so5565575ad.1;
        Thu, 20 Jul 2023 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868361; x=1690473161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORmNTDEPuiXr5MQMrZYwdQ/7w0rdL3GvI/IS1eUVHPg=;
        b=pO8D9XEgTE5idQ2UZVNqlnawU3QvyqQyVIxRicqnpRehFpz2NX3esu9kZ1fWaJN04U
         juXEidGf7vz+DPboeiB3kDADDxufI+Xmp+qcKWOJp8bw11930m4KQRUKfL/EREuisTPQ
         JxGXpJ7hTJItjzdwDhiUoOq4FYNU214zvrfaihTDGkLK/mnvKWk0/uC8/QJPxj+wOwSf
         DMr01eHfU/YRd7hR9ZnTml6elrW9LHj6n+QfFAKnhIU8rGS4vYbAuWaDvSpX0NXr0YzF
         zMFw9mkO1MzSzPYgE7Qkpp4pF0UTe6OA+lfys3t/FaXQDDRBBnb82jdE4w27I1oM8bxz
         K2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868361; x=1690473161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORmNTDEPuiXr5MQMrZYwdQ/7w0rdL3GvI/IS1eUVHPg=;
        b=UgG8mvTD54HFm9H/9IlVJy9pYAHqfdBkdyIvyuqBGHoR6wGe9ZqtK6Hg6liZk85Ick
         Yj41Le8M/wtolXEn9A9GUY/eH3/mj91fHfBp0UbjOtEPWPUPMs0OqjjNFQSbfqIxh+Bs
         34YcZcvH9klAJwRGDoeMszCqpPbVRSG6XCP+toPjS7e90haC5I25p9i1SjqGdQlY14ul
         DFQKNcGhJ2tTuakkdo3oH2cSnjXEad8FqNbzm6sTnKNxutU28tCktPuokoSQgR+6j/IN
         HCYHnsQegPUlko1V5emkxkR0GFALcLyUdQvj0o8ZtDACRhkqVdHBzR2MgCmFInpZuab1
         XCvA==
X-Gm-Message-State: ABy/qLbLAVgJaNcD+EgmPKOP+IZaHsPKCDRtXHXxXwKXR+rE13cUMzRc
	MkyfQTfDOn509/egYHTOkYw=
X-Google-Smtp-Source: APBJJlG7GqysuARH+Cfjbel3FPTJxx4jIuqcoGVvGzSRV++31WECu+X1ePk62YWbHiUXbIETTnwMUw==
X-Received: by 2002:a17:903:2349:b0:1b6:4bbd:c3b6 with SMTP id c9-20020a170903234900b001b64bbdc3b6mr24362714plh.9.1689868361424;
        Thu, 20 Jul 2023 08:52:41 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001b8a00d4f7asm1569177plf.9.2023.07.20.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:52:41 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RESEND PATCH bpf-next v3 0/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date: Thu, 20 Jul 2023 23:52:26 +0800
Message-ID: <20230720155228.5708-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces a new tracepoint in bpf_xdp_link_attach(). By
this tracepoint, error message will be captured when error happens in
dev_xdp_attach(), e.g. invalid attaching flags.

Leon Hwang (2):
  bpf, xdp: Add tracepoint to xdp attaching failure
  selftests/bpf: Add testcase for xdp attaching failure tracepoint

 include/trace/events/xdp.h                    | 17 +++++
 net/core/dev.c                                |  5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     | 63 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 51 +++++++++++++++
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c


base-commit: 0858a95ec7491a7a5bfca4be9736dba4ee38c461
-- 
2.41.0


