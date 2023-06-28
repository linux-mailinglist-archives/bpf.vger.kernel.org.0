Return-Path: <bpf+bounces-3652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E28741072
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59E2280E28
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE89BE6F;
	Wed, 28 Jun 2023 11:53:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BCBA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:38 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AA32D73;
	Wed, 28 Jun 2023 04:53:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so3023401a12.0;
        Wed, 28 Jun 2023 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953217; x=1690545217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QcEzIK+0zEiKUf7bDF6ozjLuleytJPqwAt/qGZeocE=;
        b=ahXwWnjhuhpFXrJQRNYk4iFpcQoHLpSVjLXtMcG53fhP5YUsnmn/shFHGX/S6WzfUb
         +LbKFSFqs/z9UUEsL4/ApuBOTls/rCVB3dFlavVO0Dyf+TtU98WER1QOFc6FTg/qvPf1
         mQAo/KyUoUfq0Pkfpt6GwUl75ITLO9NBjhGqAuqQ5w7JdsIrCTP7spEyFoT0PxjUwpML
         GhVt3v1/Y/vxUEdLQgOlkDonG7KB3bzn0u+g7dY0CUsh0irS9hV+BezI5NjTkNtDlL+G
         H/RIUg+Kl9q/KOmzVFoLrQxBL2mrql5P3dyTBZ4vZ91r6w6/sIIkGRU3v0/B0uJ8k5yV
         TKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953217; x=1690545217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QcEzIK+0zEiKUf7bDF6ozjLuleytJPqwAt/qGZeocE=;
        b=JdW9W0j2TDreaxl/q7hUW493pYRgS4yQukzf2nAW3fed4Va8Q69/8ufV8tKY+vHZYc
         aV+qNCxilBWmn6Ej0B/2GxpfTlMZJrxY+YNaVLds3h2zXaMEEkQ3MFhKaFDhOcD3SZX8
         Rrzyv+n1jjsdSxg/xSwzqezvPeJXcOxTKb+ZfuiCQSU96cZS/agzKAevQdX1WKQJMViU
         3R58I8RKm8DEt1Tx49VavoeSXASgcwGyzmsjEXGFN43WFVfsD+OK9gQFLVgyeqB37ay7
         5qOx7F9DKXPGdvWN0P+ydWtspXsSHehuilMhkru6FNxRQyocl8bewjukO1Wf+y6YEeR8
         5soQ==
X-Gm-Message-State: AC+VfDx7i/qr4U3gBQhp8tYU5PAkgdocxpdVyqkiBvCxB7DLhfnhY9dc
	iCySNn895bOeRvcGl3MJSDs=
X-Google-Smtp-Source: ACHHUZ5W7ZNB16nZ6lxuxhhUU9DQ79RvUIYG5GevqZCFBno6op2r/uW0gQtnaUb6SwrndRJQuFibdg==
X-Received: by 2002:a17:90b:1050:b0:263:129e:80ac with SMTP id gq16-20020a17090b105000b00263129e80acmr4213940pjb.38.1687953216948;
        Wed, 28 Jun 2023 04:53:36 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:36 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
Date: Wed, 28 Jun 2023 11:53:19 +0000
Message-Id: <20230628115329.248450-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
 kernel/trace/bpf_trace.c       | 37 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..512ba3ba2ed3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6439,6 +6439,11 @@ struct bpf_link_info {
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
index 03b7f6b8e4f0..1f9f78e1992f 100644
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
+		err = -E2BIG;
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
index 60a9d59beeab..512ba3ba2ed3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6439,6 +6439,11 @@ struct bpf_link_info {
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
2.39.3


