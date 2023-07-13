Return-Path: <bpf+bounces-4887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEC75154F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88E2280A71
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292B647;
	Thu, 13 Jul 2023 00:31:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3E634
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 00:31:36 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D031FF5
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6686708c986so188882b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689208291; x=1691800291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEE6zx35d16/kbM01kThG2BCGWZrCA9SdHm01FpogwY=;
        b=sSUn7watb3E3VtB/pEIilHKsA3UDm5YDak0U0i9/0oBl/CLcDw2dGGNxFvVmqVeGBj
         +ua3Zrn9JzoOAHHjoDlOugEUai2LG9+cfAiai2hifMpeOu3pRhIfKqPuXYa1OS6yLMW4
         BjAsqqTc7OKfvWvantz9IvZV0wiQvWx2yrHCiThlYrgnZgMb7e3URWoKGprMudxcYBNp
         dWSm0jZt0tJS6PHlIQaXRUE1XDhNR6TWW15MIEcR0jK3BcwzizaG92V826wXrHTJ3q6L
         l7/VD49AAExlycGLf9uVxRxXTxRE6KgbCOkdgn5WwC4+RcpXMG1FJtQQnWqL86hfeuE3
         PpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689208291; x=1691800291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEE6zx35d16/kbM01kThG2BCGWZrCA9SdHm01FpogwY=;
        b=EU2+mywNtjdJXguomK6H6x5WI2rY1yb5vUUzep43xYhqQCLMag9VqipSPUhzycaDhz
         IZyoqGGPCF3Ngrgz7XBxGaFGBVRvmXJnF23mAve2Oqh3Am3iqDkSdevMnZKMKfOgsx3y
         gnGUwJcpXwjo5wcOHfGdKFnqF2RjZSEWTlqsn94ps1dZWoPSgjIEObRctDtmQmL4p7VB
         J5UdVD1Wngnv/waBu2lAdd/w2Xm8RAPchlKYtNZ+ztWndjWk0TdGgbjnfipMilvRgFEj
         l+ECdVb0Wy/3SpKPLSm+mW2nBu6sJKkR+guI7dSEm2XoolJLraG+wjw5zjsJckc4aXuP
         GF7Q==
X-Gm-Message-State: ABy/qLbEHCrGrVNtv9GuE3uYbgBUJczWM0IJi0u12y17KPcmnku/WgqQ
	v7n9htJ2gdyHOHDxccYrR911F4VEdBtzEw==
X-Google-Smtp-Source: APBJJlHZMDapMDyVZrWYxdlzR+YV5MsmL7tcTRBv/mm5kkm/OHPIBsUTXp6/+j7L+jnWT/zrkaJvHA==
X-Received: by 2002:a05:6a00:198c:b0:63a:ea82:b7b7 with SMTP id d12-20020a056a00198c00b0063aea82b7b7mr208572pfl.28.1689208291442;
        Wed, 12 Jul 2023 17:31:31 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0067ea048cf83sm4131537pfn.186.2023.07.12.17.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:31:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 2/3] bpf: Repeat check_max_stack_depth for async callbacks
Date: Thu, 13 Jul 2023 06:01:17 +0530
Message-Id: <20230713003118.1327943-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713003118.1327943-1-memxor@gmail.com>
References: <20230713003118.1327943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3068; i=memxor@gmail.com; h=from:subject; bh=TqMAxpoVZzh8Mq8VkVgnZKNByejTlGc5Z/jls6bJ190=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr0XROgeENIyHRrSGfSQGrorJZxnjqlFKE5OGN Bllf7IQdXmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9F0QAKCRBM4MiGSL8R ypXtEACUkxMZi0AHiChd9EQ3Z8IRkJI1ZTXT4jj9uNZbAhzfJluvITkNDGd1Y+CLmatFqiJ/UzF TrH9fPcgcWpVVEFfBdclObI1lsyKs87H3YS0oIak5GwtRtve0bFshKFp8qP0cPHp+6H8juHTniL qfBKm0XPw6bnftA7BkPCB8I/A1bmZ2sntQkOcDWtTAYmenTyyI9YAYCLQR/e8hu39zFF1avOwh4 XiSnjh1Uhb5t/Wj7Y//2qxLdEu7chIeE4p0UWhrCJtz9xq5QkfltCvCNuhdotKy5rA81yx+sP51 tJg2yrOKxugwXCzvHbQ6HxdybBw/W/HG8JKKzEKz1ziGn9bHTeIPXgzFzJ6B/CMQfVYG3s79kH5 KR7WOrmok4RLrgcblRbYY8SJGrzt4m3vzsXJoxFOwVz69LfJFhwYlM18C6aqyJa/j5n5OpPttd2 BEr0ud79rl8I2n+It4onu686qVVoyzqWONMFw2VninM7f5NhcaIdonicQf9vimVt0Ju+QXCvN0z 2kQy/aJHcnyg0ev50vQw6136K377xfAzMHjwd6720Be1ybji9ZleatY9StDuAaKOhGtrAXJDoER TilCVzgXeTlQ7PsdPEeV9qwxqyCV0+7+hkXG89y5vfhV29phO1HXfx69IAUGsO786e4Gu4Jgu4S TOOZWazaJeglzMQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While the check_max_stack_depth function explores call chains emanating
from the main prog, which is typically enough to cover all possible call
chains, it doesn't explore those rooted at async callbacks unless the
async callback will have been directly called, since unlike non-async
callbacks it skips their instruction exploration as they don't
contribute to stack depth.

It could be the case that the async callback leads to a callchain which
exceeds the stack depth, but this is never reachable while only
exploring the entry point from main subprog. Hence, repeat the check for
the main subprog *and* all async callbacks marked by the symbolic
execution pass of the verifier, as execution of the program may begin at
any of them.

Consider a function with following stack depths:
main : 256
async : 256
foo: 256

main:
    rX = async
    bpf_timer_set_callback(...)

async:
    foo()

Here, async is never seen to contribute to the stack depth of main, so
it is not descended, but when async is invoked asynchronously when the
timer fires, it will end up breaching MAX_BPF_STACK limit imposed by the
verifier.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e682056dd144..02a021c524ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5573,16 +5573,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth(struct bpf_verifier_env *env)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 {
-	int depth = 0, frame = 0, idx = 0, i = 0, subprog_end;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
+	int depth = 0, frame = 0, i, subprog_end;
 	bool tail_call_reachable = false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
 	int j;
 
+	i = subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -5683,6 +5684,22 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	goto continue_func;
 }
 
+static int check_max_stack_depth(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int ret;
+
+	for (int i = 0; i < env->subprog_cnt; i++) {
+		if (!i || si[i].is_async_cb) {
+			ret = check_max_stack_depth_subprog(env, i);
+			if (ret < 0)
+				return ret;
+		}
+		continue;
+	}
+	return 0;
+}
+
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 static int get_callee_stack_depth(struct bpf_verifier_env *env,
 				  const struct bpf_insn *insn, int idx)
-- 
2.40.1


