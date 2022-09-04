Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E715AC663
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIDUl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIDUlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:55 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238272CDDB
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e18so9042658edj.3
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=22IfOWZyWCxsUKHsCYpSYlJvTYtLaS4EVu+zayZpr2w=;
        b=i33BNbcTwERS3cEwo0aBgny1BP7k/nj+66sHYa9mMsdyojlK06P1DPVrI4r0rpEgh5
         jw6OEPtG4cToLMmXtnLVvxzo0buJREOyj8I1RtAipFqHEd5lqRLSuV6z9lfilli0O8Ay
         XIm1dLUAfPSYEapZL2VnPYe0ikPKij0p0QcKojjM2R6FR/fjdkfmCx5ZzrRuf+gVkqTg
         GLh+RQ2U+fYqArbErBRzXV9a+O3PlhVUZGMpXxu1CE8xKJm17oZvNml0XuVFK5jgGEsS
         RbuzW88hOkoS34boQJK1S4nb2OSjJBdOnX+FXrF2wna1VNbixlLRNmh0m8L0zHta6Klu
         NRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=22IfOWZyWCxsUKHsCYpSYlJvTYtLaS4EVu+zayZpr2w=;
        b=Wut6N7cTFse99PQcdCmx5IxmbTft0rvpPLcnKq8yMKMEs44FIA32/0MAtDo6s8ZeeC
         UK2e4r2t0/5ueESideeAUJfq907FedJuUBLvPyZQhoYK5z1j9G8c/QManwhHsXuRlMkO
         LQzYDnYIJf8q9fnth9rkpvcv7SRuI+cujs9mVBwz8AFOdN1SsYLEzR5FT+kWH8et9dtw
         /MJoDxiYC01lCUWd1qrLSx37vL5P3KTN/7El13hkYj1Lsvwo/ErMa2jWRc8Pv9zios5y
         mHgry+C3MSkB+nlogILKpizOYB5RT7V+6Ik+SyLAT1eaAc3H7zBsjFKGz7hEapeLIn/5
         Tgmw==
X-Gm-Message-State: ACgBeo07T5vG+fjKDEYlIpC0fGVRLUzpXwHLFbopXo6GT/BYAMLE9ZzD
        1FSQE2iyOV4M+KN7W7CZ8fuXGnw1pIFtcw==
X-Google-Smtp-Source: AA6agR7P84LIXjenNWPDhiJsIPQ4D+/ol8VNZf4LKIIcdjSIhO3tsvaNbSjCxHrvF28zkJlGckyN2w==
X-Received: by 2002:aa7:d0d3:0:b0:44d:ef98:2075 with SMTP id u19-20020aa7d0d3000000b0044def982075mr4954539edo.122.1662324111482;
        Sun, 04 Sep 2022 13:41:51 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402231500b00445f2dc2901sm5266044eda.21.2022.09.04.13.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 02/32] bpf: Support kptrs in percpu arraymap
Date:   Sun,  4 Sep 2022 22:41:15 +0200
Message-Id: <20220904204145.3089-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=memxor@gmail.com; h=from:subject; bh=CQKsT4wfH9xNh6D5ZLSCpdbdtmutMryjTfI62Vo85uU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1vVrahocLHcPDkFAKNORIFPbd7ThGjPNC0S6nb 9K8fVQOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8Ryv75D/ 9lXt6hl1wf8LrDmUgN7QRMgUCFO9tPi0Fmsk85Llnk0p+a4M54TchQzwKZ7oXdqR/GLClz98DxxgqA imIfpe5s+AGrWXvjz1N9bNuB24T6XQQJ5vPb/ZObsAAn5v8oaUH/I5VqRRAv33FE0ac854mYuWsZAh s7/Ye+VM8bGs1TKtdg6Ac6ig4N9o96IITtwCSDhrdXAiFCftzRaET3ED1KlbH2cMYgwGuUjcJtsMtq S6nMhKNVvgBIU6uW9/gpntSINgBiisljSkUt77iDxm444DSWOow4iAXB9uViib2rcNdwX1DUvu3RVa xOTZqHRiDIE/vB7dw1Veu9iQykaUIoXtB2s+AOTC0WatWEw9H99AMGp8bXivbwSSXqt8c/DFxZU9j3 93n/Irc9nkwnM6DjU6gFlQ7KYEp99Kqk3Ah/aJuZ5Ka/wcfSSnbDvVDagKRzwyW5yWBuoqqrpUWrkj 5FkHLxSvnKy8sG2ijSJ0jPSzRod4YHV6x3+7wSHrosex6pbIJwj1thorvCsStbMSnRpj8GO0rMDw9X mIhEwwh9k26UutAi2YylgwTbn9JkWb1kWO5drIAdd40qB0mb2vWD71eD5toNJG0sSC1UoJLYOQ4pDb OSf3p3C2r+/SjU+IgKwSfAMUEPct3HJ8FWztIfqUk4rp5xsQueqJuVOx922g==
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

Enable support for kptrs in percpu BPF arraymap by wiring up the freeing
of these kptrs from percpu map elements.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arraymap.c | 33 ++++++++++++++++++++++++---------
 kernel/bpf/syscall.c  |  3 ++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 624527401d4d..832b2659e96e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -279,7 +279,8 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(value + off, per_cpu_ptr(pptr, cpu), size);
+		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value + off);
 		off += size;
 	}
 	rcu_read_unlock();
@@ -338,8 +339,9 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		return -EINVAL;
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		memcpy(this_cpu_ptr(array->pptrs[index & array->index_mask]),
-		       value, map->value_size);
+		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
+		copy_map_value(map, val, value);
+		check_and_free_fields(array, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -383,7 +385,8 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value + off, size);
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+		check_and_free_fields(array, per_cpu_ptr(pptr, cpu));
 		off += size;
 	}
 	rcu_read_unlock();
@@ -421,8 +424,20 @@ static void array_map_free(struct bpf_map *map)
 	int i;
 
 	if (map_value_has_kptrs(map)) {
-		for (i = 0; i < array->map.max_entries; i++)
-			bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
+		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+			for (i = 0; i < array->map.max_entries; i++) {
+				void __percpu *pptr = array->pptrs[i & array->index_mask];
+				int cpu;
+
+				for_each_possible_cpu(cpu) {
+					bpf_map_free_kptrs(map, per_cpu_ptr(pptr, cpu));
+					cond_resched();
+				}
+			}
+		} else {
+			for (i = 0; i < array->map.max_entries; i++)
+				bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
+		}
 		bpf_map_free_kptr_off_tab(map);
 	}
 
@@ -608,9 +623,9 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 			pptr = v;
 			size = array->elem_size;
 			for_each_possible_cpu(cpu) {
-				bpf_long_memcpy(info->percpu_value_buf + off,
-						per_cpu_ptr(pptr, cpu),
-						size);
+				copy_map_value_long(map, info->percpu_value_buf + off,
+						    per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(map, info->percpu_value_buf + off);
 				off += size;
 			}
 			ctx.value = info->percpu_value_buf;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e9d4622aef7..723699263a62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1046,7 +1046,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		}
 		if (map->map_type != BPF_MAP_TYPE_HASH &&
 		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		    map->map_type != BPF_MAP_TYPE_ARRAY) {
+		    map->map_type != BPF_MAP_TYPE_ARRAY &&
+		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
 			ret = -EOPNOTSUPP;
 			goto free_map_tab;
 		}
-- 
2.34.1

