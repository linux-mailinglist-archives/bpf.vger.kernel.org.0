Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8124634E86
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiKWDy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWDy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:54:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CDD725CE
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:54:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-399c3d7b039so100895907b3.3
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukg2aPi/Ten3K/Aj7Vf9FNvaNgXidzBR5Mgco6HjygQ=;
        b=KQFURfbQjjO6L+aBB28fm9U1UTfbSlXtCk6DbbqQEMPaon7kUzgZg1EplEHTu1JkpF
         7J1txqTqUIR1LkRRKqLwf0eec57KKUVmj6xxDU92mf0od7IdxQKN1F3/TWAJ0cetZ9k2
         osRFwfr+7WD7YFbQbrGn0+OqDCWCE8PgjKNmMNFmuxSDq5Cgl+LATNy2dHsmhHwk7ml7
         sL2EKlKD+O4NotzOKvZFHs48wYmcxX37+7TZWgRaTCyPoB6aCsYiNvP3A+k2ZNPDamok
         f2t/pil4BRp8Rm0IoM11/ZiOhN8e8odnI4wi4Id0TsmVitalFu+UHQcx916x1ZkRIiC7
         82Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukg2aPi/Ten3K/Aj7Vf9FNvaNgXidzBR5Mgco6HjygQ=;
        b=6CCUqFdBDrZURS5Zhr6q8yvv0g6C6tor8cHn8s9oFAMytisgE+CzHY8r63Jvv2dLFL
         8BSwDrNGUR7T8A+l5wt9C7nWpmaxlozzf7iCBGgBMb8ha6tszY583RmBbfvB3d6oGZEH
         47ljPjyPiG2DMBa1fu/abF+MOtH0cn3xCo5hPxwvV/oc/BRb9RViWS+yd4Cy6KLGqByw
         CyY+ypk75ltIu58gaQ+/90pWylIb6oSiem/9qNjOZpRmrjc4oc+/d6mJhSSUe1+hPB6T
         3/tLWmkEyl4fpIDwVAgFkdwUxZCqoRM2EERD+n2PJuezvhvMqzjEhL6sWRV5fy9kJd4m
         RuzA==
X-Gm-Message-State: ANoB5pmaNuqU5ydqibQQDDojWd2cV0R6FabKYkShChHFRggqZD5UTNPK
        T9LOKdbjoED0uTP0IZXI/2rLhbEsfB68HAuGlQrgsNZcxpHpmAl5TdxIY69A/0/SyYIbSCyh2SS
        00UkGDJ711cW4V3RPbJrdCFFTdJMfubdYoqfVgBCN3DrhJ1aiSw==
X-Google-Smtp-Source: AA0mqf7LCXnDczwp4Bv5KtMqU8tBX+xEU/YKf2luMughzwRNgrh4ql/DPXS2XM9kdWQOhYjCmOgTCl4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:d607:0:b0:388:390a:478c with SMTP id
 y7-20020a0dd607000000b00388390a478cmr7189896ywd.356.1669175666193; Tue, 22
 Nov 2022 19:54:26 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:54:22 -0800
In-Reply-To: <20221123035422.872531-1-sdf@google.com>
Mime-Version: 1.0
References: <20221123035422.872531-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123035422.872531-2-sdf@google.com>
Subject: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced in
 func_proto arg
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller managed to hit anoher decl_tag issue:

 btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
 btf_check_all_types kernel/bpf/btf.c:4734 [inline]
 btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
 btf_parse kernel/bpf/btf.c:5042 [inline]
 btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
 bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
 __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
 __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
 do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48

This seems similar to commit ea68376c8bed ("bpf: prevent decl_tag from
being referenced in func_proto") but for the argument.

Reported-by: syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1a59cc7ad730..cb43cb842e16 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4792,6 +4792,11 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 			break;
 		}
 
+		if (btf_type_is_resolve_source_only(arg_type)) {
+			btf_verifier_log_type(env, t, "Invalid arg#%u", i + 1);
+			return -EINVAL;
+		}
+
 		if (args[i].name_off &&
 		    (!btf_name_offset_valid(btf, args[i].name_off) ||
 		     !btf_name_valid_identifier(btf, args[i].name_off))) {
-- 
2.38.1.584.g0f3c55d4c2-goog

