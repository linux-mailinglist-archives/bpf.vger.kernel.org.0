Return-Path: <bpf+bounces-8057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB57807F3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0931C215DA
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A618B01;
	Fri, 18 Aug 2023 09:02:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62C18AFB;
	Fri, 18 Aug 2023 09:02:28 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F8B30E6;
	Fri, 18 Aug 2023 02:02:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdc8081147so12820445ad.1;
        Fri, 18 Aug 2023 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349321; x=1692954121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bdHXPT29PLcOi1vozCQ/EzZC5w7NFhRztdG1ykd4oE=;
        b=nsCgvHiP+FrG/IK1ExNqDBiNFM+CpDi9hpD3yi8xjmyoW1rIiMgslaR8UHU/UUltyT
         sEZydwK+IcMh8xII60zHmRnqiGu26aeTEmjrNyyIu9X5sp8YAgPmMLUtXl+TH4YKzE7+
         LWn5WFE8jpeSMMdVjj1+LOrMMJcFnVihNCgYnowgeivWDH7L9A4p/FX1FK0kp+bjvKvr
         DMY/Ic+gX0PA4AI+SxDWxvuyFi+hU3CF7Nx7YGfcmvw9ndFS+p0ICLxfhDdc4k02qGu6
         4nGaoKafwTOfG/2KcqnCcWZ+tqz8H5mOZvS5QrUTl1IHNENsZXnQzr2aiWZb8Tdj1jub
         9SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349321; x=1692954121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bdHXPT29PLcOi1vozCQ/EzZC5w7NFhRztdG1ykd4oE=;
        b=V9PxDZsqOQjp3GyoFzpSy15rKPLewwGe2sSmPPfXVCpl/npO8508YSDLKiZsbhKa4p
         4YIJYQeB7xoXjNiJvckwkNfPq/nXcP4+RvdSeU/7vRLnHtax6zTvNnVQAdxD9A9l3arb
         gJv19LbASlfbMG1hRtMPhSqgjp1yA8LcXZSrK3JPbKLBn7oxJrpQRvVYMHxVeFb99MIO
         oN0cgYzXfHQtod+rhd0sJinNkRTdPmna686Mavwv6jxN3v00brYgQi0+klIz/C7VFMMK
         fwHIjEqmLFsg6qUgOjNnOBMXwNSeCG7ZvOizFm5pX/lnh3U88V7T+irZiJaInOiv095G
         bIMA==
X-Gm-Message-State: AOJu0YxbiAQm3SxJWFCRIsPO1OIrgMnlG12T00hhcXAEULuipC93OjsB
	hcB70Z70zb11pFp/AMJ41A==
X-Google-Smtp-Source: AGHT+IE5EJZwZG81iNI9tvl+TF4KG5vD6y6dzBIGtxQwwckSkdZXBECEjPKWwnrC/um6iI2PErCx7Q==
X-Received: by 2002:a17:902:db05:b0:1be:e851:c076 with SMTP id m5-20020a170902db0500b001bee851c076mr2951149plx.27.1692349321496;
        Fri, 18 Aug 2023 02:02:01 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:02:01 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 9/9] samples/bpf: simplify spintest with kprobe.multi
Date: Fri, 18 Aug 2023 18:01:19 +0900
Message-Id: <20230818090119.477441-10-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the introduction of kprobe.multi, it is now possible to attach
multiple kprobes to a single BPF program without the need for multiple
definitions. Additionally, this method supports wildcard-based
matching, allowing for further simplification of BPF programs. In here,
an asterisk (*) wildcard is used to map to all symbols relevant to
spin_{lock|unlock}.

Furthermore, since kprobe.multi handles symbol matching, this commit
eliminates the need for the previous logic of reading the ksym table to
verify the existence of symbols.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/spintest.bpf.c  | 17 +++--------------
 samples/bpf/spintest_user.c | 22 +++++++---------------
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/samples/bpf/spintest.bpf.c b/samples/bpf/spintest.bpf.c
index 15740b16a3f7..cba5a9d50783 100644
--- a/samples/bpf/spintest.bpf.c
+++ b/samples/bpf/spintest.bpf.c
@@ -47,20 +47,9 @@ int foo(struct pt_regs *ctx) \
 }
 
 /* add kprobes to all possible *spin* functions */
-SEC("kprobe/spin_unlock")PROG(p1)
-SEC("kprobe/spin_lock")PROG(p2)
-SEC("kprobe/mutex_spin_on_owner")PROG(p3)
-SEC("kprobe/rwsem_spin_on_owner")PROG(p4)
-SEC("kprobe/spin_unlock_irqrestore")PROG(p5)
-SEC("kprobe/_raw_spin_unlock_irqrestore")PROG(p6)
-SEC("kprobe/_raw_spin_unlock_bh")PROG(p7)
-SEC("kprobe/_raw_spin_unlock")PROG(p8)
-SEC("kprobe/_raw_spin_lock_irqsave")PROG(p9)
-SEC("kprobe/_raw_spin_trylock_bh")PROG(p10)
-SEC("kprobe/_raw_spin_lock_irq")PROG(p11)
-SEC("kprobe/_raw_spin_trylock")PROG(p12)
-SEC("kprobe/_raw_spin_lock")PROG(p13)
-SEC("kprobe/_raw_spin_lock_bh")PROG(p14)
+SEC("kprobe.multi/spin_*lock*")PROG(spin_lock)
+SEC("kprobe.multi/*_spin_on_owner")PROG(spin_on_owner)
+SEC("kprobe.multi/_raw_spin_*lock*")PROG(raw_spin_lock)
 
 /* and to inner bpf helpers */
 SEC("kprobe/htab_map_update_elem")PROG(p15)
diff --git a/samples/bpf/spintest_user.c b/samples/bpf/spintest_user.c
index 8c77600776fb..55971edb1088 100644
--- a/samples/bpf/spintest_user.c
+++ b/samples/bpf/spintest_user.c
@@ -9,13 +9,12 @@
 
 int main(int ac, char **argv)
 {
-	char filename[256], symbol[256];
 	struct bpf_object *obj = NULL;
 	struct bpf_link *links[20];
 	long key, next_key, value;
 	struct bpf_program *prog;
 	int map_fd, i, j = 0;
-	const char *section;
+	char filename[256];
 	struct ksym *sym;
 
 	if (load_kallsyms()) {
@@ -44,20 +43,13 @@ int main(int ac, char **argv)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		section = bpf_program__section_name(prog);
-		if (sscanf(section, "kprobe/%s", symbol) != 1)
-			continue;
-
-		/* Attach prog only when symbol exists */
-		if (ksym_get_addr(symbol)) {
-			links[j] = bpf_program__attach(prog);
-			if (libbpf_get_error(links[j])) {
-				fprintf(stderr, "bpf_program__attach failed\n");
-				links[j] = NULL;
-				goto cleanup;
-			}
-			j++;
+		links[j] = bpf_program__attach(prog);
+		if (libbpf_get_error(links[j])) {
+			fprintf(stderr, "bpf_program__attach failed\n");
+			links[j] = NULL;
+			goto cleanup;
 		}
+		j++;
 	}
 
 	for (i = 0; i < 5; i++) {
-- 
2.34.1


