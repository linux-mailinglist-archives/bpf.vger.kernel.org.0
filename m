Return-Path: <bpf+bounces-4164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DA74946B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE74281175
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5CAD54;
	Thu,  6 Jul 2023 03:35:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90034A952;
	Thu,  6 Jul 2023 03:35:55 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564C1BD2;
	Wed,  5 Jul 2023 20:35:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a1ebb85f99so343464b6e.2;
        Wed, 05 Jul 2023 20:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614546; x=1691206546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0bRuM+0zPcN3qYoxYOiMZ4uRyYlqx6ScAuNZFVccm0=;
        b=gKl3d8oMUw6/NKNF76YIYaD9bBO8RSyO5PM6Cvw46qzjnMBiNhuaxGxL6CCPqSm8Ph
         Kdv0J1iQVb5rDbvNokRqHU9Qtu8gXUySAtwJHXkVT/uSDuhVpLbtSgzGG85LGl3nkL71
         e2N+yJ/d5U3v+P9yvpzefePVJmbPTcUcxH6pg9vUg4nFn7svcM0jpy9iV8bcHzMmY24Q
         56A5nLRsjyG15Dbt1UUaU8fk5H2XgFVHQvOrC4zkNtnRaStQijhbH16Wmi1tL3vi3iUF
         k6i7GHsoUdMTFZ27mRt8ZszzzAH6du7QNvccq+3pcNQz3z+5bzO4yIZKXUM2zvqwVRFZ
         9rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614546; x=1691206546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0bRuM+0zPcN3qYoxYOiMZ4uRyYlqx6ScAuNZFVccm0=;
        b=ALmhEcmnOm52jxyW+Vh2iNBjOU+dZWLlb0Fvx0v4nqFYv5sy+JJf6o4z0gjy/t0Sc0
         ALB4mN3nkt7ahhgk5eh7rrlfWLDeIdz4eJECP6zWUMTEMGdqEMGz/JV/DoJqo6+fdxmK
         Wdfp6heiNnICDI9sZAaU8wvtiKGXL/8O475MRnSIu7CjRZR5xZzlUXT7w4bzrDodsVF8
         sdUDQTy9qlVssGDhHuqceVf3rX52sfSEo1HbFHc4QcrYqQ0sTh8XfvS1mD1wOT++UWnS
         CBGkleV+fWXIAUJFMxXj9Qgbx9dJDRBMtLjAnyzKk1Y0Q8tRQ2LKwztLrMryLPEhXLjv
         hEIQ==
X-Gm-Message-State: ABy/qLZXQXesEtbH50f0CVe8JF2qycBnz/j521y2dbdAL8vLppuWhRk8
	RIJS2RCTaJGoxZGVeLFx0CUWhn3KKZo=
X-Google-Smtp-Source: APBJJlH13nj7856GlvWlvgyF7+YXlmnZ9rkeUgo+KEcrnC/DvOFqbkJ3BjFYflyTflMwfjfxDC6gCQ==
X-Received: by 2002:a05:6808:1596:b0:3a1:ecdf:5f74 with SMTP id t22-20020a056808159600b003a1ecdf5f74mr646205oiw.43.1688614546277;
        Wed, 05 Jul 2023 20:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id z18-20020aa791d2000000b006829b28b393sm228322pfa.199.2023.07.05.20.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 14/14] bpf: Add object leak check.
Date: Wed,  5 Jul 2023 20:34:47 -0700
Message-Id: <20230706033447.54696-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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

From: Hou Tao <houtao1@huawei.com>

The object leak check is cheap. Do it unconditionally to spot difficult races
in bpf_mem_alloc.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 17ef2e9b278a..51d6389e5152 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -567,8 +567,43 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
+static void check_mem_cache(struct bpf_mem_cache *c)
+{
+	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
+	WARN_ON_ONCE(!llist_empty(&c->free_llist));
+	WARN_ON_ONCE(!llist_empty(&c->free_llist_extra));
+	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu));
+	WARN_ON_ONCE(!llist_empty(&c->free_llist_extra_rcu));
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+}
+
+static void check_leaked_objs(struct bpf_mem_alloc *ma)
+{
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	int cpu, i;
+
+	if (ma->cache) {
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			check_mem_cache(c);
+		}
+	}
+	if (ma->caches) {
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				check_mem_cache(c);
+			}
+		}
+	}
+}
+
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 {
+	check_leaked_objs(ma);
 	free_percpu(ma->cache);
 	free_percpu(ma->caches);
 	ma->cache = NULL;
-- 
2.34.1


