Return-Path: <bpf+bounces-3049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A683738C89
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AC52816E2
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D219E41;
	Wed, 21 Jun 2023 17:02:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC819BCE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:02:51 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB75120
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f84f75bf4so2886828a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366970; x=1689958970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=CDe40wq+ByPLHcciah53IyY8ka+k/FUoh9rlvUpk0Rz5YkBccmLt3wUrapCI6HMtqD
         nZxp8Bqv60jel7eAZmLxSoMXdNENuypCbVFCeH8QquCA1Ip1q1nRmSimkOtsY9iWS1yl
         IYqe6Xx0LLp/gMBVqTyGXFOekUpDa8s4tCkYPZShFrbgwyr7qco/N+m9MyDrQmalEppi
         I3skQXpqbpInihHpmi1NwgCLEyg+/FMITmbNezFTMvVErPd0x7UWmDcJq50R35AxPuIq
         KT9dfW1d4gxU856yNbpSfj4HKOjxb27nbSJz4AMDDWJY8oPUAQqwY4ZLjgK2FnsEddvG
         j/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366970; x=1689958970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=ZpKjZ0XBQdDsyl/fjR4fFI4SUUu9J1UW1zsxXFYVvbb7ciesxcySOxlzurBY4cT2uz
         Bv2bI/ez9dtSd2ZkyPpUxmiG45rwXDE2/wUjMQ97r+5x/NlU1g6w4Lr01vp3+pUn6jaS
         rkkynPz84o3n/I0ATMV/WDhXg4Fv7xAqb32zpMYNCDd6e4CfejUFVJZmwpD+d/biwiRn
         5NwkVwx3bRXsu85QWV7W2RdtvXKdpx5MIQ+U/peOVKEOGCkJ1IxuoR3e38uLBysKt6W0
         ushMK+JEDxXfAwL6dLo/d0Lpz1weI25/xX5PdmT9LYd/+10qfuLxS9UOeqxRGaZFYwd+
         Ngog==
X-Gm-Message-State: AC+VfDwnQn6Ose+9x0mq2vvayGud9Rs/F4oIEmvxm+UQTibwsGUIrYI+
	ndm9eOvnQeCPNI1RP/9r1jhaZc5OSv8NTrE0Z98eTUL6cdYLtRzDPJZHF34sWlWdkwQgjiwPo8i
	C5Gs3wihxSWL3QlPKFDkPlE0iB8hVhZCcf4gLgRCcU2g9wKM7Ww==
X-Google-Smtp-Source: ACHHUZ7T4z5BMYP8aOK9EXSfV5iL1qhQkAqfBTuu6hJZfby78AK9fENfUPBKIY8cnY//hlpEXkd6pfE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:5896:b0:261:2e5:b5af with SMTP id
 j22-20020a17090a589600b0026102e5b5afmr266907pji.1.1687366969970; Wed, 21 Jun
 2023 10:02:49 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:35 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-3-sdf@google.com>
Subject: [RFC bpf-next v2 02/11] bpf: Resolve single typedef when walking structs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is impossible to use skb_frag_t in the tracing program. So let's
resolve a single typedef when walking the struct.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..9bdaa1225e8a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6140,6 +6140,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	*flag = 0;
 again:
 	tname = __btf_name_by_offset(btf, t->name_off);
+	if (btf_type_is_typedef(t))
+		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log, "Type '%s' is not a struct\n", tname);
 		return -EINVAL;
-- 
2.41.0.162.gfafddb0af9-goog


