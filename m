Return-Path: <bpf+bounces-1361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC97139FF
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F11C2095C
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA95672;
	Sun, 28 May 2023 14:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C12566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:38 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50163BE
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6c0d651adso28578171cf.2
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283636; x=1687875636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXpGPWz5BLT8lQdv0GfwGSvcA9bkfg8xrata1pia1ig=;
        b=IZqBLOkdA6PU2/Gnw3erZji9JnkMEl3cysWjcWlMOfA8iKJuXqLR0MRS22OxPlgBPa
         lWH6NDoiR4xMeRpPcwG8PyvSQN+KsHG24Zf9IZD/2JyZ3RVqZfOE1xTgv8Y2J64nOfgN
         ZqE7K5ZwWla34OD7/8E/R7nlEvXxTWSdOUyx/h5RZXZFWeAVWmsVRVMD1KpPpVGGikIh
         rAAlSnLRTkQAC+8hLgM1reiVNYU+pG2SjLaneq2a2rxS+WZ9ItmIy7QzPdikTO5VaK5F
         otMXIy9hihEO2jWq34enkvzlk4eu2VnF9Tn3QBme+X/XAnkfkK9q0DJpG1x2Xj/Zi+la
         MI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283636; x=1687875636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXpGPWz5BLT8lQdv0GfwGSvcA9bkfg8xrata1pia1ig=;
        b=ZAnEAwYCCopKd/EbnrRkMkB2KM4r6Tdre8H6fg/OZgVbeeO9KeEhKDEODA5CBiJRjG
         kLrj8waM7XK9IumQ6kwfnnxigzg2WTGn7x5Gf7eJQceiU76P4edMLbDOReanhSmyoTmo
         W7YRgTi7kmrGw6v/WLq/+07QoZl9XvREC03W4U4M03qjrKMZS1uOE/haGCEYCuTQ2f22
         lUxzMr6RV8zfLbxyUqx2X1q/zvrOT32716gqNrcfLKR+NAvhbzVBPWJKWU67f9ZZ/8eD
         WPKyX/cE6FUcQ3tq7JbObDtlPApsm2GIlkKaDXAT8yfj2w4hmVS5lw6b45OaVP8ps/Mi
         xMPw==
X-Gm-Message-State: AC+VfDxclsU2OizCACgwisXM6qu/FYaRl+yWHL5T0UQKspnJ79Q3rnYI
	QS3BvVl4qSuhlc3WgDEnUTc=
X-Google-Smtp-Source: ACHHUZ54XQ1mo94lUZ3X/9MvbA5KFLF8WZ0elnJlBmzxlOwhBTK9g9lYaAxYrk3kZllHsyCvrOVTSQ==
X-Received: by 2002:ad4:5f4d:0:b0:621:6bcb:e49 with SMTP id p13-20020ad45f4d000000b006216bcb0e49mr9550036qvg.0.1685283636479;
        Sun, 28 May 2023 07:20:36 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/8] bpf: Support ->fill_link_info for kprobe_multi
Date: Sun, 28 May 2023 14:20:21 +0000
Message-Id: <20230528142027.5585-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
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
 kernel/trace/bpf_trace.c       | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 39 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9273c65..6be9b1d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6434,6 +6434,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs;
+			__u32 count;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0d84a7a..00a0009 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,10 +2564,41 @@ static void bpf_kprobe_multi_link_show_fdinfo(const struct bpf_link *link,
 	}
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+	u64 *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
+	u32 ucount = info->kprobe_multi.count;
+	int i;
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
+
+	if (ucount != kmulti_link->cnt)
+		return -EINVAL;
+
+	for (i = 0; i < ucount; i++)
+		if (copy_to_user(uaddrs + i, kmulti_link->addrs + i,
+				 sizeof(u64)))
+			return -EFAULT;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
 	.show_fdinfo = bpf_kprobe_multi_link_show_fdinfo,
+	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9273c65..6be9b1d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6434,6 +6434,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs;
+			__u32 count;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


