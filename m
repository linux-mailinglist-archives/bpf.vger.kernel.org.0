Return-Path: <bpf+bounces-1659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55D71FCB6
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA291C20B5E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA612B76;
	Fri,  2 Jun 2023 08:52:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED4C8EC
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:51 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8599170A
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:49 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-568ba7abc11so18509957b3.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695969; x=1688287969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/SQ2Fo2T0bYItWrPhzxcl37HvHH4TS9C3sENSUKJow=;
        b=ZkbIglzF1auDWMgWho4gjayZGvTckYf2LX/8uV8AnUnEcMNywS8Jv4KAaX4JnVUpCg
         AucbyovAN4vbdCx6PABmc9dOkShwB/bMyasPROUoYY656rXt4Q8LLNfK4It/jmskanco
         4kR5tu28teS6wW3W6jRFlVbADdEDxw0mNOv1wkx1yZDgAX/7jHMRWHTzNPZ2T79KqYto
         NqsCSl88bikC8SH552YSs6/Xn1jWJ1nS6IjY7Q2RJlpnWVNkd7B5c5X9UMFOJWHA5/wf
         Z98uIgrkufVcbKzgWlOKT8pDiCrNCGi52o4v7iQsADMcK9rssTX9CmKsku8xw8We9+m8
         wZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695969; x=1688287969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/SQ2Fo2T0bYItWrPhzxcl37HvHH4TS9C3sENSUKJow=;
        b=L5P8PwStVLo3f+X2UBkcg79pNS9AswBytsvsYYEQ+crKaRBr6duQ43hTUAIFxN76k9
         UYRV1WzrGU+RMn6/KtpVX1O0mLlnCv4Y4rULN7s3kU6DzSCS5TYhlO838PdiB6llJnrc
         I1mamPsjPVLJqP4GHg5/aUebZFkMXfInFaXtlsVO3ACcT7yDm568NyxUU+P/b/EdLZEC
         4Zwye4LaH2ivPcagI4D/nLK+JN9r4OwcdEtflODo2bxFQ0ch4WgQ8lZCu8IBSWHBC5HY
         J23awgzxPBUNy96v3C/ONywkByAB0eI9o5ZvVzgDx8a784oNZyZ9fiaRupnIDfHePgHF
         MPgQ==
X-Gm-Message-State: AC+VfDx6XWhjQ7s5GeOWuKYH1J6b4z6qV8Tl6K3DBmT5V1NRV/a9/qJW
	mWadcHT//3ufgwavO2IB1zo=
X-Google-Smtp-Source: ACHHUZ4fFXS6vx6f+h4QcnloXwMig6qlTw9CkZPjQetIj1TaCQLhRGtp8POsc5o8Gt6qYjodnrZcKQ==
X-Received: by 2002:a0d:d913:0:b0:561:b7bb:9cc with SMTP id b19-20020a0dd913000000b00561b7bb09ccmr11658640ywe.16.1685695968937;
        Fri, 02 Jun 2023 01:52:48 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/6] bpf: Support ->fill_link_info for kprobe_multi
Date: Fri,  2 Jun 2023 08:52:34 +0000
Message-Id: <20230602085239.91138-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230602085239.91138-1-laoar.shao@gmail.com>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
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

By adding support for ->fill_link_info to the kprobe_multi link, users will
be able to inspect it using `bpftool link show`. This enhancement will
expose both the count of probed functions and their respective addresses to
the user.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/trace/bpf_trace.c       | 26 ++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..22c8168 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__u64 addrs;
+			__u32 count;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..ec53bc9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2548,9 +2548,35 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 *uaddrs = (u64 *)u64_to_user_ptr(info->kprobe_multi.addrs);
+	struct bpf_kprobe_multi_link *kmulti_link;
+	u32 ucount = info->kprobe_multi.count;
+
+	if (!uaddrs ^ !ucount)
+		return -EINVAL;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	if (!uaddrs) {
+		info->kprobe_multi.count = kmulti_link->cnt;
+		return 0;
+	}
+
+	if (!ucount)
+		return 0;
+	if (ucount != kmulti_link->cnt)
+		return -EINVAL;
+	if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
+		return -EFAULT;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91..22c8168 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__u64 addrs;
+			__u32 count;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


