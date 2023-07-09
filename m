Return-Path: <bpf+bounces-4512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E543B74C079
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB78F1C208DF
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3B17FA;
	Sun,  9 Jul 2023 02:56:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B917EC
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:47 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375CFE46;
	Sat,  8 Jul 2023 19:56:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666683eb028so1716546b3a.0;
        Sat, 08 Jul 2023 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871405; x=1691463405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aInYh/3dgHNaIULayQTQ+fUxHabeAAdv2/uG4ImY5rs=;
        b=LwHgwyWFu5AqeZF5mL5YiY9Qhotf2cOxXESu5fkM8wAthg9xapVKZc6WPa6PDbyI/+
         p4xG6i7g/Q+t27Djal+jHc6HpR8ItPSEst7gbJyP8QBbZ3VVuHcvxss3Dd0SfY/8GAov
         Ujey27yagp/LUgDinhdBpjC1UigRORzbd2MZ149NB+3kEZ7IFg40CoR8A5WdK9FN6nyc
         l40e3jvOdr9h6iQmT7Y5im7k64lO5WCTXvRP3y/NIMt7Zj2ekmPYZeVpGy51T4IZjeio
         /BBvCpNZBYoQnn8toKlYrRcOtLOirqXAGwx9EZUn/G+3Zz5CLqmIWBp6NCGgYt4aH7nn
         K8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871405; x=1691463405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aInYh/3dgHNaIULayQTQ+fUxHabeAAdv2/uG4ImY5rs=;
        b=Ei5NUIvoco9mx59IZMguS8cDp0QoZb9X7e/nWapGqlaQ0UUCTrIXb3HEDw3ZL/EPQu
         EIKyKn73xvYqM5Ug2JJZ58D91oOuoueemFFD+ExK5Y1XYsNXdG7QuX2NjgRvOQL61ybp
         RqTWblygLRHQJjU36TNPMHAPHSnNcKu+OukX1UWj3h056UswhpDsyZsmmpZeT7NQth+z
         34PmaUePQP52gz6AlMJQo+abn7uf0n6ZFkUiXPWisDW2PpF9DIVwVU8QZaoq913ueCl0
         zRnXNiHZYe9HmbpFqGAHQi6FX+Rz33Lq49ZbRPf1EbosO0f3GPpT3G70nh8h2Nj6o+rV
         hzYw==
X-Gm-Message-State: ABy/qLbTW4VNzzlIWQIqWmdFvSxJvAx8rvEZUqXgqYp5ElLcrdG26lSy
	3s416izwg+Dn72NXCCv4PAk=
X-Google-Smtp-Source: APBJJlEUmdmfISsgbMh0tL1yDLfGErTcLSq9pksVrk9YGAchbp33C3rSlc5AJcSFgWNUw19PHgc2Vw==
X-Received: by 2002:a05:6a00:21d5:b0:668:94a2:2ec7 with SMTP id t21-20020a056a0021d500b0066894a22ec7mr8645505pfj.25.1688871405523;
        Sat, 08 Jul 2023 19:56:45 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:45 -0700 (PDT)
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
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 01/10] bpf: Support ->fill_link_info for kprobe_multi
Date: Sun,  9 Jul 2023 02:56:21 +0000
Message-Id: <20230709025630.3735-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the addition of support for fill_link_info to the kprobe_multi link,
users will gain the ability to inspect it conveniently using the
`bpftool link show`. This enhancement provides valuable information to the
user, including the count of probed functions and their respective
addresses. It's important to note that if the kptr_restrict setting is not
permitted, the probed address will not be exposed, ensuring security.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/trace/bpf_trace.c       | 37 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..a4e881c64e0f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6439,6 +6439,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs;
+			__u32 count; /* in/out: kprobe_multi function count */
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 03b7f6b8e4f0..acb3d6dd7a77 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2469,6 +2469,7 @@ struct bpf_kprobe_multi_link {
 	u32 cnt;
 	u32 mods_cnt;
 	struct module **mods;
+	u32 flags;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2558,9 +2559,44 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
+	struct bpf_kprobe_multi_link *kmulti_link;
+	u32 ucount = info->kprobe_multi.count;
+	int err = 0, i;
+
+	if (!uaddrs ^ !ucount)
+		return -EINVAL;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	info->kprobe_multi.count = kmulti_link->cnt;
+	info->kprobe_multi.flags = kmulti_link->flags;
+
+	if (!uaddrs)
+		return 0;
+	if (ucount < kmulti_link->cnt)
+		err = -ENOSPC;
+	else
+		ucount = kmulti_link->cnt;
+
+	if (kallsyms_show_value(current_cred())) {
+		if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
+			return -EFAULT;
+	} else {
+		for (i = 0; i < ucount; i++) {
+			if (put_user(0, uaddrs + i))
+				return -EFAULT;
+		}
+	}
+	return err;
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
@@ -2872,6 +2908,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
+	link->flags = flags;
 
 	if (cookies) {
 		/*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..a4e881c64e0f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6439,6 +6439,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs;
+			__u32 count; /* in/out: kprobe_multi function count */
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
2.30.1 (Apple Git-130)


