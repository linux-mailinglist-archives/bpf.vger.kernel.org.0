Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121D3F8F01
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbhHZTmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243616AbhHZTmU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3b9pUdzhGyKoDaWX2s5ijJmxL2rpVCQT5XLwXyJeOo=;
        b=PQ2m8lVchFfD1LdldJTGj3chjXaDdaDSLj9QC9/HSMFD+Ejx5atd49EO46gjgPxEX95A15
        3P1H/k+w/CWuZ5ffdK+WvdQAKWBR88QYovfQT9DxIYPqC3Jh61Rdn2RpCwNlsD896ROhb7
        LVAKXWmEF/1zxsLAtphvrU7dau2R34A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-fOsbiRfnPLSE4UAqg8JSFQ-1; Thu, 26 Aug 2021 15:41:31 -0400
X-MC-Unique: fOsbiRfnPLSE4UAqg8JSFQ-1
Received: by mail-wr1-f69.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso1196024wrp.12
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3b9pUdzhGyKoDaWX2s5ijJmxL2rpVCQT5XLwXyJeOo=;
        b=BF6caG2pqwuRiY0S4M1/l1dH+qzn9idvMdLVWnqme1SFYNaa8Dxw1bkYHAnR/Ntpis
         HfLd9nuRvZLs2GrwFG+EXGxtj6nMmPUcXSsDrzL1F/V8ZIqX5I+gGoT2IYlGU6UaHLPQ
         M4dSAyewiPdPGPFgZ8+HlKdVZ9NJvddJYIRzoJcmx84Vf3ETlnanD8/88mWzaR28Sh4v
         07pGUSHorabM2FYEmILsqjRpbxiBHf+Z+e/VOeQerK4X5cxKFLllh7aNB/ypD8kwWnkh
         Rla5PLXLtEERnVFVgpwgAm8em9p/c2cZPOJ5B02ZGhkmZ4UNfWG08DEZRszO9dE/bP4T
         v1qQ==
X-Gm-Message-State: AOAM531HRnWTSlrJ5C2vX/ZFFY1RaFlyHO71Cyh/jFB04CvEH7xfAZyN
        76SapJ0LrRvAQuQQMuHagYuHKlf5R6IixmwKcDW2Kxa2BFKAqd9Nkobfe7FLzNse35qt9XYd0tc
        O4FrcgS275mQi
X-Received: by 2002:adf:fa82:: with SMTP id h2mr6020802wrr.195.1630006888611;
        Thu, 26 Aug 2021 12:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8AA9YdhAgPNPAGj1JNJ0gytWblM+WJehjDHzc5IbNAoSE+WpYNT8IVVFqve3IdWXLaRtpqg==
X-Received: by 2002:adf:fa82:: with SMTP id h2mr6020793wrr.195.1630006888354;
        Thu, 26 Aug 2021 12:41:28 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id w14sm3956093wrt.23.2021.08.26.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:41:28 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 20/27] libbpf: Add btf__find_by_glob_kind function
Date:   Thu, 26 Aug 2021 21:39:15 +0200
Message-Id: <20210826193922.66204-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding btf__find_by_glob_kind function that returns array of
BTF ids that match given kind and allow/deny patterns.

int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
                           const char *allow_pattern,
                           const char *deny_pattern,
                           __u32 **__ids);

The __ids array is allocated and needs to be manually freed.

At the moment the supported pattern is '*' at the beginning or
the end of the pattern.

Kindly borrowed from retsnoop.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h |  3 ++
 2 files changed, 83 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 77dc24d58302..5baaca6c3134 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -711,6 +711,86 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 	return libbpf_err(-ENOENT);
 }
 
+/* 'borrowed' from retsnoop */
+static bool glob_matches(const char *glob, const char *s)
+{
+	int n = strlen(glob);
+
+	if (n == 1 && glob[0] == '*')
+		return true;
+
+	if (glob[0] == '*' && glob[n - 1] == '*') {
+		const char *subs;
+		/* substring match */
+
+		/* this is hacky, but we don't want to allocate for no good reason */
+		((char *)glob)[n - 1] = '\0';
+		subs = strstr(s, glob + 1);
+		((char *)glob)[n - 1] = '*';
+
+		return subs != NULL;
+	} else if (glob[0] == '*') {
+		size_t nn = strlen(s);
+		/* suffix match */
+
+		/* too short for a given suffix */
+		if (nn < n - 1)
+			return false;
+
+		return strcmp(s + nn - (n - 1), glob + 1) == 0;
+	} else if (glob[n - 1] == '*') {
+		/* prefix match */
+		return strncmp(s, glob, n - 1) == 0;
+	} else {
+		/* exact match */
+		return strcmp(glob, s) == 0;
+	}
+}
+
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids)
+{
+	__u32 i, nr_types = btf__get_nr_types(btf);
+	int cnt = 0, alloc = 0;
+	__u32 *ids = NULL;
+
+	for (i = 1; i <= nr_types; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		bool match = false;
+		const char *name;
+		__u32 *p;
+
+		if (btf_kind(t) != kind)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (allow_pattern && glob_matches(allow_pattern, name))
+			match = true;
+		if (deny_pattern && !glob_matches(deny_pattern, name))
+			match = true;
+		if (!match)
+			continue;
+
+		if (cnt == alloc) {
+			alloc = max(100, alloc * 3 / 2);
+			p = realloc(ids, alloc * sizeof(__u32));
+			if (!p) {
+				free(ids);
+				return -ENOMEM;
+			}
+			ids = p;
+		}
+		ids[cnt] = i;
+		cnt++;
+	}
+
+	*__ids = ids;
+	return cnt ?: -ENOENT;
+}
+
 static bool btf_is_modifiable(const struct btf *btf)
 {
 	return (void *)btf->hdr != btf->raw_data;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4a711f990904..b288211770c3 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -396,6 +396,9 @@ btf_var_secinfos(const struct btf_type *t)
 	return (struct btf_var_secinfo *)(t + 1);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.31.1

