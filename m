Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF67455A51
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhKRLcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:32:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343871AbhKRLaH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi37+rv3u/Bm4bA8fo7TndVIQusjlyQQ5lAmm+EnXUU=;
        b=Ciki0JH64iXGJKvx26m9VR+ZOJ3FIVkkhd1iOMGklOU102ABwkbRaseFepEj+/UFdZ1TuW
        hM6M6WDhNWnKgmoba5NfvlxZ1Mn8ma4LlIQgUihGxXkUcJ6l1q1ujN2SsGqKM2AjLmAedA
        C50U3LFM3mGxK7dsGfgt5A9GlHR1tW0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-E1S4qMVaMTSkcp2XPKupuw-1; Thu, 18 Nov 2021 06:27:05 -0500
X-MC-Unique: E1S4qMVaMTSkcp2XPKupuw-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so5040444edq.3
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hi37+rv3u/Bm4bA8fo7TndVIQusjlyQQ5lAmm+EnXUU=;
        b=vObJsDlbDcO4ZLxXhtvlHmRH8JGPU+VYMB0227VmIPV98pO3vKlJhW7mOC8XPxZqrW
         A4/20PXlKJDyfPwv+g7Qy7ZJTEn8ZwkSw5Z94yEPyGsAwUXc7KZuxFl9zb/Rf45NSbTD
         47mJBkmK7RYdBp870JSW7tngU0JwGPkUlDmJXArL9kE5PTIM8RkVITnhzJLgKzXQ0mma
         r4rAzLoT4ZDYFzWxdYqdZbYLKsV8FpX1+8DBpT+E1A8npWYtzYWnMYDhCqpVr1zsTMKI
         pR74i0PEgZVSMWaHOHzZEFEvq4XnT3LW0qRjbmh+7P5Y0tnZ9WrLdTVmMcG4/S9hBgCV
         Fe5Q==
X-Gm-Message-State: AOAM530F7uheqjX2Mwf5id6oX5Ogu1f7M0eswsaK/8mcX4X1dC820Zge
        vnroVRYQTe9tTpNvI5VfEvt2BeXD1GSLwoeM2XQ8gFOGhMjkSrT8CIJ/TqUqmw5NJ/mostHmv2p
        vRtSiqpBS6BTc
X-Received: by 2002:aa7:d997:: with SMTP id u23mr10186218eds.164.1637234823313;
        Thu, 18 Nov 2021 03:27:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5CZuVoobHUPvbd2K9Ul9ZEYH9a1jgeG1KjMB4ZHqm9OEPDgAz0puckb36VyPxan9tOL5pjA==
X-Received: by 2002:aa7:d997:: with SMTP id u23mr10186197eds.164.1637234823141;
        Thu, 18 Nov 2021 03:27:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l16sm568515edb.59.2021.11.18.03.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:27:02 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 21/29] libbpf: Add btf__find_by_glob_kind function
Date:   Thu, 18 Nov 2021 12:24:47 +0100
Message-Id: <20211118112455.475349-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
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
 tools/lib/bpf/btf.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b6be579e0dc6..ebc02576390d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -749,6 +749,83 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 	return btf_find_by_name_kind(btf, 1, type_name, kind);
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
+		const char *name;
+		__u32 *p;
+
+		if (btf_kind(t) != kind)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (deny_pattern && glob_matches(deny_pattern, name))
+			continue;
+		if (allow_pattern && !glob_matches(allow_pattern, name))
+			continue;
+
+		if (cnt == alloc) {
+			alloc = max(16, alloc * 3 / 2);
+			p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
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
+	return cnt;
+}
+
 static bool btf_is_modifiable(const struct btf *btf)
 {
 	return (void *)btf->hdr != btf->raw_data;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 5c73a5b0a044..408b8e6d913b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -572,6 +572,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.31.1

