Return-Path: <bpf+bounces-11869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD507C4DEC
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10BE1C20E22
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D951A70E;
	Wed, 11 Oct 2023 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e18sClmE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C991A594
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:01:13 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE81E9;
	Wed, 11 Oct 2023 02:01:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054f790190so64742855e9.2;
        Wed, 11 Oct 2023 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014869; x=1697619669; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSR6qPmHCfHgxPs78KqEiNeIJSUPA1Iy3U8H+7sLIdE=;
        b=e18sClmEv8bDilKp+kWugUJLk9uaMlfTo/EC35+r27g0KP7zC00c9eKarqnzG9kZRC
         c4RiSovtL346oSaETG5d3mHsWWiGEkrvDGbrE2oYAstMvPVj2A9aeR2Nh9vr0MHbTec1
         PhxCuUmvW5d8/E481N0XYZLO1CxVvF0dZkX2sAgLJbgZDXSP+vuQzojQH/73aQTNpO9e
         fyUW6A1kiXz8UKU/z5aiH/hORmvTLiMIj3sOiXE+2RBh7uxgmycf2hhLo3ASoVSeIraE
         566tINjcmt9l8+YL1+dNQc0itC+Rl+O9tK5qRLAD2jeLLz9kKtDMR1BWzWRndGaDzYLl
         Fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014869; x=1697619669;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSR6qPmHCfHgxPs78KqEiNeIJSUPA1Iy3U8H+7sLIdE=;
        b=lw0+gebakNoyUdqDtAymO+Mkr8lI/rAsXd1ARmpz8YOQ6QPvrWQsofalz3apM4DXpn
         DLxcoH82yoXj8v7bjp5mn6kywH0DoR3wnj7lAfofJL6dFnnvpV8PtIrtDA8kMwpAE6s+
         Vo5bRUl5NYTNdmTbcMLXxRSjWKi9VIHObRwz0JU5LlB7RodloZ7KgS4jCuLsKo8rnIny
         +ajZJIBZl3jPnoyiGHzizx5ePDr+Wm2A3gIiNb2lO08NEEytuf/6WZ6hfdYhxmU6NLb7
         G+sYcHOa/hnwMBvBdgg8+CWj9G94b5imrknj5ceusWwF92cbWeDGcomMkEvkc8xTOibe
         xa4w==
X-Gm-Message-State: AOJu0YwM5TTnPD7XN5WGLW0MyWTV62n1K1AoJyyvvGUGHcnJA8AJ5M0z
	M1WmvGC8WesffNfp2FZQoA==
X-Google-Smtp-Source: AGHT+IEIG8Y3yVGZcisTYyYxgj03GBR4cJbEz6fBw58wL/IqrHbqh+k4TVwsApcJqyBqf+zntRI8sw==
X-Received: by 2002:adf:ef8f:0:b0:31f:a718:4cb6 with SMTP id d15-20020adfef8f000000b0031fa7184cb6mr16152770wro.46.1697014869141;
        Wed, 11 Oct 2023 02:01:09 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm554100wra.37.2023.10.11.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:01:08 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpf: Detect jumping to reserved code of
 ld_imm64
Date: Wed, 11 Oct 2023 11:00:11 +0200
Message-Id: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxkJmUC/4XNwQ6CMBAE0F8xPbumWxTBk/9hPNR2C2uAkpY0G
 MK/23DipMfJZN4sIlJgiuJ2WESgxJH9kENxPAjT6qEhYJuzUFIVKGUN734EHiYPgfI0kQXH1Nk
 IzqCuK13R1RqR52Mgx/NGP8RrdDDQPIlnblqOkw+f7TPh1v/nEwKCraQsSWmDrrw3vebuZHy/o
 UntIJQ/IJWhwtqLrs8WSeEeWtf1CxER/rETAQAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697014868; l=1797;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=PpW/LKH+HLXhoabm69yqJb+fF47MmoM9puktgjEaSYI=;
 b=GS/2dRweWp4nJ6UMKn6Y4WkIYZnMOux/3qiieewtbYuYG+DBMP8CfccfWTwVuD9tDWKP97ro8
 c0pPn/iqDDiCdy2NsSxig8BDB6s2NEZeG/UND4jZW0+ZBhLVuQa5DQ5
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the verifier rejects a program jumping to reserved code with
the log "invalid BPF_LD_IMM" in check_ld_imm(), which in not accurate,
because the program does not contain any invalid insns. The root cause
is that the verifier does not detect such jump, thus the reserved code
is passed to check_ld_imm().

The first patch makes the verifier detect jump to reserved code during
check_cfg(). Because jump to reserved code is just like jump out bound,
both break the CFG integrity immediately. The second makes the verifier
report internal error if it sees an invlid ld_imm64 in check_ld_imm(),
because we already have bpf_opcode_in_insntable() to check the validity
of insn code. The third patch adapts existing tests to make them pass,
and add a new case to test backward jump to reserved code.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>

---
Changes in v3:
- Separate changes to different commits, change verifier log
- Link to v2: https://lore.kernel.org/r/20231010-jmp-into-reserved-fields-v2-1-3dd5a94d1e21@gmail.com

Changes in v2:
- Adjust existing test cases
- Link to v1: https://lore.kernel.org/bpf/20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com/

---
Hao Sun (3):
      bpf: Detect jumping to reserved code during check_cfg()
      bpf: Report internal error on incorrect ld_imm64 in check_ld_imm()
      bpf: Adapt and add tests for detecting jump to reserved code

 kernel/bpf/verifier.c                           | 11 +++++++++--
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>


