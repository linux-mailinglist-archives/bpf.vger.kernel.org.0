Return-Path: <bpf+bounces-2102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB39727CE4
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936832816AF
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D8947C;
	Thu,  8 Jun 2023 10:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425038495
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:41 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7A2D42
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75d4df773b4so33314885a.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220536; x=1688812536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi9s8LCdN3bDa4TRCbJie9LePONriO/RiRjf4ffMgD0=;
        b=imGqHwW2RHxWLqgUMEahhYa23jhf++qtboqZ5wdrj+vWqVQD+0f2MgVB+y9eRFsd/l
         Q6w82b1TvqU1VsEnnwJEbfbRHUAxYVpLhAnlj8jaV2TTAutAPh86/ELk3Dmke/Y7RntU
         VrAAO+RChWIu5aOPks5OdJRJ6qjBzyHx7jXZ7+CCffh0hfvWXcUvL3IznLh09VqKyIu4
         Y/wZfwiBlABCmrIxKaU++TlnNUuR0HPM8846LIN21egA5pvqiKE/m9z7eEtFgviH0u/N
         5pCyW8b3/j4uFTsxlf4yGCoG6VU5bHCCZ7CgaA+/qdtwmIJ3r3GliyATs8214xoLlvSK
         Xy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220536; x=1688812536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi9s8LCdN3bDa4TRCbJie9LePONriO/RiRjf4ffMgD0=;
        b=Tn2o/oR1XY0mDxSk0HfcRwxESrRhShf5lHXpt0OXkzOHC/ULoyM93bv4x2QnFNDaMj
         5JrOmz3JW9OMj8wKEQglGcESdOveeiiezM3u2asNRL4xE4KWIMtaT0ud8bor6nQMNXHG
         L+OeWmVUZFTMjX0oJt+5smh7Q6XdQ1bQbK99asgjMVKTbe/ZgANQgkifM2TJ6cOqUqPz
         p3fJ4O4oaSwp33hwVeQyGz6z0wJqP66uRbVkClGx5KhEvJvZfg2A64ma8LHt9iE7o9yw
         IjIhv6ZIKatphag024ICXmwuW1mWAwgyj0qN4Xop+vnBYI3emmU0/YtREDgvF5KhGE7N
         +VTg==
X-Gm-Message-State: AC+VfDydzLoBPmC+7G5fz/lIu/HoCpoAYepKLOqI9bxczuqFYlC2KLFt
	1oMqIyinabKuzjhdy5TRQCw=
X-Google-Smtp-Source: ACHHUZ4R2Sk0iyzhEUsjGOlQNR/qVGuY1sHi3Bd53vnEvkWD9mlfoGvJ5gPF2ZWHRuQhE/2h5lboVQ==
X-Received: by 2002:a05:622a:181e:b0:3f5:ef49:722c with SMTP id t30-20020a05622a181e00b003f5ef49722cmr7370397qtc.2.1686220536568;
        Thu, 08 Jun 2023 03:35:36 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:36 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
Date: Thu,  8 Jun 2023 10:35:13 +0000
Message-Id: <20230608103523.102267-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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

With the addition of support for fill_link_info to the kprobe_multi link,
users will gain the ability to inspect it conveniently using the
`bpftool link show` command. This enhancement provides valuable information
to the user, including the count of probed functions and their respective
addresses. It's important to note that if the kptr_restrict setting is set
to 2, the probed addresses will not be exposed, ensuring security.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/trace/bpf_trace.c       | 30 ++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 40 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..d99cc16 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u8  retprobe;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..738efcf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2548,9 +2548,39 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
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
+	info->kprobe_multi.retprobe = kmulti_link->fp.exit_handler ?
+				      true : false;
+	if (kptr_restrict == 2)
+		return 0;
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
index a7b5e91..d99cc16 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u8  retprobe;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


