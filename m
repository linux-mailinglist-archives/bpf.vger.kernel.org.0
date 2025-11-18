Return-Path: <bpf+bounces-74831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC3C66C28
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3211136656A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB53302CD9;
	Tue, 18 Nov 2025 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="DmPqphov"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC22F0681
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427198; cv=none; b=I4dPGTJZ2G3jJ0VH+X26m1ND36NCiw/FMHdZgsrbOrl+szbDInRHHdgUfHjSBUyr3FabjGLDwU93M7LhLlQyvWm3kZEG4TqrZrUAOvytFn8cGJ86jQcIEcJvMdZegwg2TUPSel+km7zm39CPEOo6MfYkWVHl+n518zV7ygdtwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427198; c=relaxed/simple;
	bh=g1uLFslNgKlYCLYRXudOesC52+em0G+2nP7Ib2wuDMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD4drQGLIcYo/Ums2WXthPQBnAbxIY+AoxBl8A2VfXmmA/u6o9wxFBCLHiCw9ItLIsB66hlqNS9n6JnMe6Ipg+oys1gauHeSXZkjEYAhI/LdjdYq8KIb4VsNxX5oUZ9qQnG0fDyjeHeu2ItMd+lUD02xnAx3NwK+Q6EvRz4vtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=DmPqphov; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-299e43c1adbso2068985ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427195; x=1764031995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqtHILsF2TAT2qFB8P2xd62Q4NmwrffJGJ2M75+ke/A=;
        b=DmPqphov3TUfikh4R0SllIXXtju4Nn/vldpfeWdy8mxa3UHcduxRHzs6TqZmXehQNO
         dA8qjPrMaz+viChicnH3HJ3/qSWmFHnckay5DUDEy3biJtqWVvZK98cOsEP6SDUUmfWI
         5XDv7CWjJNwVuaIKOnNdQMKdFrR05KOz9xsUJPAsDnF54bCQVfVpDOtbl9AsF2xbynBs
         O9zWBZZFnZHcPxxnmTyq+D4e0XiQCugV88e0eoaHw/AeFHjFKC4zgzBtVqP0PlaYvvLJ
         /VWVHUSTsEnpmV1Z1+6U9/V6KVO4q+iddjCgzEusAIVMO4LRPYHhOzMfRe5oazvsI5sz
         0zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427195; x=1764031995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqtHILsF2TAT2qFB8P2xd62Q4NmwrffJGJ2M75+ke/A=;
        b=VB4URvnHQGtAhdNdkr34hppVHsgQI/PR+aCyS9E6UZL/bzjwwnDZfIOnlyOIpUpPSN
         eiO3ZygEKHsWvpr7P3Kf5qfH24L3zNjxUAvB84NKaKktFsUrzAFz2HKU+XlcrPEKpo10
         b1Be2UQ6Ss+XXKya9VKzEwdnKLqlTL/y7NK9cT/8NilNo9/RGFzzlDOeHtKSlFkiFDbv
         xRAYBcaHnpIn2dJNOPFZJZOEV5EYEMjkD5AvbcbMABfYVw77340yQmZQvY9ePHgapB7E
         Xs9/OZBFGX/Lh+GN4VmBvqct4EyhBkDkXL8s7ZQQdp/ncR2NLiavlsltkjNz8683+v4w
         qxYg==
X-Gm-Message-State: AOJu0YyruTAjaRoeerlAUbk5BuohnnaQ0lhYzeeMApcjDwUrzFPOT3np
	f6SIwS80wuwU3uY/kEjpMjAFo/aTqp3R8+g0clDQU+u9FC2ZRSB4rThf8km/pkr/plqQCXgvwV4
	XkFMR
X-Gm-Gg: ASbGncvvK407DivTJ6fNujF9/utiQgI6vxOWLAkPDv9AIQv3vjTA+p7BK2yH0nPejxN
	jN5P26AiJKgQbMPImG0K4PeJY1hQ8jDi0FUMPtdUY73nPsQzfo74keBCb8WcrhUc2VWZjfSGN4j
	2K1owYFOdKz+94erSx9MaPiT1utUf6Mzd/xj2gZ/v9sA3qlFjwHjBHkiaQIwVtdfFYiWb47AmUu
	nJdW+GwchcdmMCiDk6NrY977+t7B8W3MxJKPf5BNMz6o+pHcr7fuXhP5j4IB4on1fAZrjbfgA9N
	aASIHfQJsMl3Lt/t2+kq6QbWfnDfna1Eiq/afcU0edvG7/m0GNouDv4xKMcxNGh6MWDeecXf8kw
	KxdZI5mWW3K5jbn+dTXK4sAFhaFjHXekp06SZbJ+PAzC5TmEa036jButWtWeGUAvUgv75vNjNxD
	g=
X-Google-Smtp-Source: AGHT+IFJPILg18zJQZC0TW4P7pXEkHzpuOhLWUEFhxqpAVjTKvXaGm1YV+XYqv2kf00AJGzo/HV8dA==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474689eec.2.1763427195139;
        Mon, 17 Nov 2025 16:53:15 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:14 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 3/7] bpf: Enable BPF_LINK_UPDATE for fentry/fexit/fmod_ret links
Date: Mon, 17 Nov 2025 16:52:55 -0800
Message-ID: <20251118005305.27058-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement program update for other link types supported by
bpf_tracing_link_lops (fentry, fexit, fmod_ret, ...). I wanted to make
the implementation generic so that no architecture-specific support
would be required, but couldn't think of a good way to do this:

* I considered updating link.prog before calling bpf_trampoline_update
  and reverting it back to the old prog if the update fails, but this
  could create inconsistencies with concurrent operations that read
  links where they see the uncommitted program associated with the link.
* I considered making a deep copy of the link whose program is being
  updated and putting a pointer to that copy into tlinks when calling
  bpf_trampoline_get_progs where the copy references the new program
  instead of the current program. This would avoid updating the original
  link.prog before the update was committed; however, this seemed
  slightly hacky and I wasn't sure if this was better than just making
  the architecture-specific layer aware of the intent to update one of
  the link programs.

This patch sets up the scaffolding for trampoline program updates while
subsequent patches enable this for various architectures. For now, only
x86, arm64, and s390 are implemented since that's what I could test in
CI.

Add update_link and update_prog to bpf_tramp_links. When these are
set, arch_bpf_trampoline_size() and arch_prepare_bpf_trampoline() use
update_prog in place of update_link->link.prog when calculating the
trampoline size and constructing a new trampoline image. link.prog is
only updated after the trampoline update is successfully committed. If
the current architecture does not support program updates (i.e.
bpf_trampoline_supports_update_prog() is not implemented) then the
BPF_LINK_UPDATE operation will return -ENOTSUPP.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/bpf.h     | 10 ++++++++++
 kernel/bpf/trampoline.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 23fcbcd26aa4..7daf40cbdd9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1215,6 +1215,8 @@ enum {
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
+	struct bpf_tramp_link *update_link;
+	struct bpf_prog *update_prog;
 	int nr_links;
 };
 
@@ -1245,6 +1247,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr);
+bool bpf_trampoline_supports_update_prog(void);
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
 int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
@@ -1840,6 +1843,13 @@ struct bpf_tramp_link {
 	u64 cookie;
 };
 
+static inline struct bpf_prog *
+bpf_tramp_links_prog(struct bpf_tramp_links *tl, int i)
+{
+	return tl->links[i] == tl->update_link ? tl->update_prog :
+						 tl->links[i]->link.prog;
+}
+
 struct bpf_shim_tramp_link {
 	struct bpf_tramp_link link;
 	struct bpf_trampoline *trampoline;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0b6a5433dd42..0c0373b76816 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -230,7 +230,10 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 }
 
 static struct bpf_tramp_links *
-bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr,
+			 struct bpf_tramp_link *update_link,
+			 struct bpf_prog *update_prog,
+			 int *total, bool *ip_arg)
 {
 	struct bpf_tramp_link *link;
 	struct bpf_tramp_links *tlinks;
@@ -250,6 +253,11 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
 			*ip_arg |= link->link.prog->call_get_func_ip;
 			*links++ = link;
+			if (link == update_link) {
+				*ip_arg |= update_prog->call_get_func_ip;
+				tlinks[kind].update_link = update_link;
+				tlinks[kind].update_prog = update_prog;
+			}
 		}
 	}
 	return tlinks;
@@ -395,7 +403,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int __bpf_trampoline_update(struct bpf_trampoline *tr,
+				   struct bpf_tramp_link *update_link,
+				   struct bpf_prog *update_prog,
+				   bool lock_direct_mutex)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -403,7 +414,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	bool ip_arg = false;
 	int err, total, size;
 
-	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	if (update_link && !bpf_trampoline_supports_update_prog())
+		return -ENOTSUPP;
+
+	tlinks = bpf_trampoline_get_progs(tr, update_link, update_prog,
+					  &total, &ip_arg);
 	if (IS_ERR(tlinks))
 		return PTR_ERR(tlinks);
 
@@ -506,6 +521,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	goto out;
 }
 
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+{
+	return __bpf_trampoline_update(tr, NULL, NULL, lock_direct_mutex);
+}
+
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
@@ -629,7 +649,7 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
 		return 0;
 	}
 
-	return -ENOTSUPP;
+	return __bpf_trampoline_update(tr, link, new_prog, true);
 }
 
 int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
@@ -1139,6 +1159,11 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
 	return -ENOTSUPP;
 }
 
+bool __weak bpf_trampoline_supports_update_prog(void)
+{
+	return false;
+}
+
 void * __weak arch_alloc_bpf_trampoline(unsigned int size)
 {
 	void *image;
-- 
2.43.0


