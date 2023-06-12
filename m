Return-Path: <bpf+bounces-2406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80272C996
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C8E2810D1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE31D2B1;
	Mon, 12 Jun 2023 15:16:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042E1C744
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:19 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22141E63;
	Mon, 12 Jun 2023 08:16:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62de5392c7bso7809416d6.2;
        Mon, 12 Jun 2023 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582977; x=1689174977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWqmDiEzHKgFvHuqwuHTHpXuTD6o/LnYiSeoxlbJNGU=;
        b=AiOKuw4q7501E7JJ3RUs+Ar6uL7O0KL0o4e0BY+DX0bmdDyevJadnjuNLw9Qa448KI
         t0i/qEGzuqe+CImXulkA40zjqK5IRClcuaBsHxDlI1PRcmZ7mCYU/F/VH0mTYZPem9Ez
         64HLVdwKKn3M/fHaPXzNMARKqMnihvQ+3W5Jkrj1hP4GxFYnZwx3zNqo+vIUELNjDiT1
         CP8GYDMPFnu90Y0iywaHg0gZZKTKYysQoDUb5C5s+sDHbkjv58QKXwAmarMjjzAEhpW9
         D5Yz1l6cbgmmsD+HMzWe8uSTebyXxX3uvKoS5LoPzRqKTHq5YlyRfrqxvPygudU7F5LW
         NsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582977; x=1689174977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWqmDiEzHKgFvHuqwuHTHpXuTD6o/LnYiSeoxlbJNGU=;
        b=E+5SC6VCgL6/ZEDSbC374YLZTNdmvn8S5Ly0EPDP7Rrq0fsSVf4jXb7fSEGYNVDN17
         9qH4Zgh5LR+o9DBoPmbYyPAmnSG/DscB6E6bjlj/OHxApg25yYh1NjtKlEyKE9lzaeU1
         crXr3vhdWcY750wrdxseJ8scF4wQhB7Z3ECJRq19jnBufMODa22veG0MdAp464Z/KnOD
         Qf5fyTX/4oCW+kqgKtYDgbPlxUbdH/qI9SOliTl2HD5mBq4fhZuRl/PyfcwPTrUIqwLF
         2C8qcVbAThUX7FuReOClkhNgc+AP/ZQjw9d4T2sXJQgl+fG1SPcY2s+s7Dx+TEM2cF5j
         GjqA==
X-Gm-Message-State: AC+VfDwaotRaX7ag1XIzTqINqqzg4ow19+iM/b1Ob55ht3z7E8J1q6Hf
	Kv8yxEtXyzm2E5HE5KV6HpU=
X-Google-Smtp-Source: ACHHUZ7lkiw3vkuaXeYb3gsez9A7gf7zO12Nou/7uw9jIc4lhB3Hf8kOxIIQNYjLLIhIoxpZ5Y2stw==
X-Received: by 2002:a05:6214:130b:b0:623:42c5:612f with SMTP id pn11-20020a056214130b00b0062342c5612fmr9115703qvb.49.1686582977138;
        Mon, 12 Jun 2023 08:16:17 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:16 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 01/10] bpf: Support ->fill_link_info for kprobe_multi
Date: Mon, 12 Jun 2023 15:15:59 +0000
Message-Id: <20230612151608.99661-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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
`bpftool link show`. This enhancement provides valuable information to the
user, including the count of probed functions and their respective
addresses. It's important to note that if the kptr_restrict setting is not
permitted, the probed address will not be exposed, ensuring security.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..742047c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2548,9 +2548,36 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
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
+	if (ucount < kmulti_link->cnt)
+		return -EINVAL;
+	info->kprobe_multi.flags = kmulti_link->fp.flags;
+	if (!kallsyms_show_value(current_cred()))
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
@@ -2890,6 +2917,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return err;
 	}
 
+	link->fp.flags = flags;
 	return bpf_link_settle(&link_primer);
 
 error:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


