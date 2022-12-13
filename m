Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77A64BB73
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiLMR6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 12:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiLMR61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 12:58:27 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC84220E3
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 09:58:26 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id y194-20020a4a45cb000000b004a08494e4b6so2488576ooa.7
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iam0SRV7ItknkUquUWujqPV80reUUNpRqwJZW39TTFM=;
        b=IZVHwdLrXF+PyrQctfWEs/jPHJI7SmRRQKluwe+7kmaLuONkoS+CSRNy59Q3xn7Tqe
         lUY4SCmpW5y6HpyEHXpAC4YckcoBbCrcbI2N4fMiNIVsjabC0qD5pQr+AnIKEnc/JGt7
         OvcvtUZFLRumjJaZgLgz1hAqAwYzFdjTKKDhzHQ+fbTDjsvXGMyAdW4T4iGibndCLvyX
         dD0+Eex/DAGeg/ioDIzwZi+fVe18JK+rS+Bdd7wbPoFPOydddxukQZ//+VaV1VvvRWNn
         9VxpshdE3OPVeZ0F0jsM4Idid/Z/vAA5LzYiL1UCI/a8Zdz5B9NNynllHWl/ZAGGuLmq
         4jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iam0SRV7ItknkUquUWujqPV80reUUNpRqwJZW39TTFM=;
        b=UV8Cr8WZuVdJ/2uCBgahw03OVpKe7OlJXWbsAssw62LF3ASlf7kauXFoLVrUlrDZ56
         qnSlbfYmicaKnsGMmlZzPFdzAP1dnfMO5QFHZUoprydEa1Z+DLf0GoB0sfPv3TnnnaCA
         jcrPDDHet6+EhhfBG/0zOD9z2l0MIx4auicM1ItRLh2ri6nrKxwgjbau/6w42D4HALh1
         lABy6iouak9ziQD77DTxu/ZOtw40pt9C23t8sx7DCw2PHp6o7CeV+5OoatmlKsWBjMCS
         0hEAWXIlNbJ9rLz0INtPbgZ8pCU8DmQ89bac4hxtpWwubpwASFZWNoBZ+Q7dNhRyAK0v
         4NOQ==
X-Gm-Message-State: ANoB5pmvs4k/ZQ4iJLtMaIinujG4dc58zrjua+1fFvEy4d0YMf43+LGC
        QJTy202sdRiZiJAg4775lyE+IkBSQelkGT7fmpE5yg==
X-Google-Smtp-Source: AA0mqf6jYTnicbPwkAItFGPdAfJfKF38sl1E3IwiTyQVQZrxi5uhRCCmqvJcjKnjBH/O+PSP7Q+sAA==
X-Received: by 2002:a4a:41:0:b0:4a5:5dbc:811c with SMTP id 62-20020a4a0041000000b004a55dbc811cmr33473ooh.3.1670954305075;
        Tue, 13 Dec 2022 09:58:25 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:6bf9:9d04:960d:7436])
        by smtp.gmail.com with ESMTPSA id s21-20020a4ac815000000b004a0aac2d28fsm1367756ooq.35.2022.12.13.09.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:58:24 -0800 (PST)
From:   Milan Landaverde <milan@mdaverde.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH bpf-next] bpf: prevent leak of lsm program after failed attach
Date:   Tue, 13 Dec 2022 12:57:14 -0500
Message-Id: <20221213175714.31963-1-milan@mdaverde.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In [0], we added the ability to bpf_prog_attach LSM programs to cgroups,
but in our validation to make sure the prog is meant to be attached to
BPF_LSM_CGROUP, we return too early if the check fails. This results in
lack of decrementing prog's refcnt (through bpf_prog_put)
leaving the LSM program alive past the point of the expected lifecycle.
This fix allows for the decrement to take place.

[0] https://lore.kernel.org/all/20220628174314.1216643-4-sdf@google.com/

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..64131f88c553 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3518,9 +3518,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LSM:
 		if (ptype == BPF_PROG_TYPE_LSM &&
 		    prog->expected_attach_type != BPF_LSM_CGROUP)
-			return -EINVAL;
-
-		ret = cgroup_bpf_prog_attach(attr, ptype, prog);
+			ret = -EINVAL;
+		else
+			ret = cgroup_bpf_prog_attach(attr, ptype, prog);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.34.1

