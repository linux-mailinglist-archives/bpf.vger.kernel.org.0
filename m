Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992D85AC67E
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiIDUm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiIDUmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DD2CDE2
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id u6so8975465eda.12
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tUW7fN0U3Bdn0eS84o+mUFEWzCrreSlHtjDPnQR4K/E=;
        b=aHcUFV+HHwlH5fRx6PfmyuapXQAOYOiY/CwJVztCYxga6J4VcGeMEP6kEX8+n6PNEw
         XHueJOvn7f50MoYsk878Qmd5CrifAS+UTG4G/1dUFaiQVIE6A9SHUv/1GAjS7lNF0Zr1
         4F1yBKyWBYsprqNsU9jxOJsufzJDOXVuiThPAsbPBa3LnI63+IfxXhzvWg7C+8tz7UJ/
         6pDkSHt5tfVqPs14+57BG9KBzodaVzX3MnJzF6MBZv6sK7sJkoMtkGTt49gja7ZZuhjm
         s8Eel4Z+NnGzBDae8rFJTQSJg67ZbyHbMDmdyGt6QlRVExvmps9oXutLsaHX1jmUJDIH
         ORvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tUW7fN0U3Bdn0eS84o+mUFEWzCrreSlHtjDPnQR4K/E=;
        b=HR+H/lvvOPhHkpXORyMNsuc1lW8dP9GBaYgxfKOSHYONapadlJJ5QJRMJviru2sBOS
         LO2szeX7WNYTPfL4GxbNzyBlf3XSKClHvmWU10ceo/grEjfzr0UgAXzDZiNlEu3iu399
         0cxw1x/1+at3k8HgrRpxEr868p5lxfWnj3D6AAu3nwaAurgQnL5CmJM1x86t0uYsUOTU
         PUNSpuydsJfst2zys3P4/3iKcYQVXPlZnhe88N465OiIVEMuua4dmeAFyNuwc9Ezo10W
         bUVqTe3tNXyStkgRFNT3/TGbpjWpT7Lw/0iDrEH1cV4Aa8+G9x+MMd63Se+2d4exQUMa
         2E3g==
X-Gm-Message-State: ACgBeo1xhJlPiXbW0ZA2KRybN0QNmrycZJS08OMKMWsVymlAvxWD70ik
        DNcTGiCzhhsSkYAqV77CgLPdlBjDUor4pg==
X-Google-Smtp-Source: AA6agR5JSlrnJYqTDXkTjR/irwW4iia4HbFACzwF4NhbUrY+XWd/CKnEvjAGE0/9GWv21ZdfOGhEcA==
X-Received: by 2002:aa7:d3d6:0:b0:44e:98b9:3d7b with SMTP id o22-20020aa7d3d6000000b0044e98b93d7bmr270110edr.259.1662324138603;
        Sun, 04 Sep 2022 13:42:18 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906384800b0074a82932e3bsm4062538ejc.77.2022.09.04.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:18 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 28/32] bpf: Remove duplicate PTR_TO_BTF_ID RO check
Date:   Sun,  4 Sep 2022 22:41:41 +0200
Message-Id: <20220904204145.3089-29-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=memxor@gmail.com; h=from:subject; bh=Jz+HWtUXvntZaxvszndEYeGjfkVLHtWKOC1xdX4Qr08=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xUPv6g4BSh8rHpcZDJxlPONcFdroBl4ydvFqH x1UHxqCJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RytFOEA CQ4A8KyCN6axtjTleu7AC1zrWeRuIQHKKtzXUfpzrjtDZiqF3heBc3CWuiBAIAAs2VqtDbtnNDotsn zdo8GijrlxPf5qfEo+mC/RwbLhm/3TNyHVuxUomkZFb2sC/NS+1vNrs9KIPJtBmoCTJgdA2ne40XZ+ ha9TtmJGUrGiOuSmvWbjM8O7r1hdPMkM3yYHZpS7DZSO/3dSz+ObbeOwKgedozg9zep0i8ZodQQ7Y/ BtSV4wqoY3i+RFCaom9Ig0P+01P+8AYY2TFxl6vFXAoXi3mZgrcuWpd95aeALpW+xqpoiWEo98DDPF KJNmAVIPAuWmGr0IRNEwvrOBvZTSL7iS1VIxEVKM/jvs13MMG7PEiaXzUhw5762z6KZ8In0KjVSd8q xeoBLbdRNf/rBcV6QxzAW+b8MwNjQBN8wZ+gBdXq8U6Y7/nV/BPsARHW2FzJyp4nk0oALRWtzMlZTu kmDDKtFyq7bnpVRL33wh+w6dwfJ+fgM0JtLn4OutnZ0ijTRFjJxGMiYNY74Y+yntY8E2kNj3tnfT1z IdWMOn692E1zTkx/6zevtVhJsu2hnvHC8qXcrJm7GmLhrZVkn2OibpLp41bSLQbW6jVB4feox1CkpW fo/HRV8l+AdGIZEJx84TxOHHlIK6POnIiKFoA22WDx2XmoUR844BKMPY7LPg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Xu <dxu@dxuuu.xyz>

Since commit 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
there has existed bpf_verifier_ops:btf_struct_access. When
btf_struct_access is _unset_ for a prog type, the verifier runs the
default implementation, which is to enforce read only:

        if (env->ops->btf_struct_access) {
                [...]
        } else {
                if (atype != BPF_READ) {
                        verbose(env, "only read is supported\n");
                        return -EACCES;
                }

                [...]
        }

When btf_struct_access is _set_, the expectation is that
btf_struct_access has full control over accesses, including if writes
are allowed.

Rather than carve out an exception for each prog type that may write to
BTF ptrs, delete the redundant check and give full control to
btf_struct_access.

[
 Kartikeya: We also require to remove this check, as we are enabling
 writes to local kptrs, which are a special type of PTR_TO_BTF_ID
 pointing to btf_id in program BTF.

 Note that probe_mem conversions, we only need then when such local
 kptr is marked with PTR_UNTRUSTED.

 There are two cases when it is so. One is when node is marked for
 expiry on the end of critical section, it is marked as PTR_UNTRUSTED
 but with a non-zero ref_obj_id. This means that writing is still
 permitted to it, as is reading, and technically PROBE_MEM load
 conversion is not needed. It is just used to prevent passing this
 local kptr elsewhere.

 The second case is loading reference local kptr from a map. In this
 case the pointer may well be invalid by the time we access it. Hence,
 writing to is disallowed but reading isn't. Here, PROBE_MEM conversion
 is crucial.

 We could discern between ref_obj_id set vs unset case, but for it's
 left out of the current series.
]

Cc: Martin KaFai Lau <kafai@fb.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
[ Kartikeya: Expanded commit message ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b795fe9a88da..2897f780e8be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14889,9 +14889,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
 				env->prog->aux->num_exentries++;
-			} else if (resolve_prog_type(env->prog) != BPF_PROG_TYPE_STRUCT_OPS) {
-				verbose(env, "Writes through BTF pointers are not allowed\n");
-				return -EINVAL;
 			}
 			continue;
 		default:
-- 
2.34.1

