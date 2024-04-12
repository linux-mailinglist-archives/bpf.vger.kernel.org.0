Return-Path: <bpf+bounces-26683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC78A37C4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE96C1F23DBD
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5F14F112;
	Fri, 12 Apr 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPDgtqj7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0214F9DA;
	Fri, 12 Apr 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956597; cv=none; b=HGlQfzNSOCxqR/e/euTNKGHHc8wPZHw1oSHaKsinJ482GBLucujR1kvrLBLScXSJa2sIX5eCjud5ycv2j6aroXLSwfKjRLxAoqspnP8gSB8rgcp9Jf/fuI5cyVv82u6rDBpMB8oGaIOzdF1vmA7NDaJXt0LancAj9RHSc3zf7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956597; c=relaxed/simple;
	bh=2fRaByBcu71Pu+J3uKplrEOFOlvvPf69p5YcpYqYZlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcEWm7lh2VLNnWTTJCEHCHnzotyiqUGE/VFWj4l/ToClTGY2AQZXY97tSNGfxSKeXzC7snkZxrS86al5SmGfQUYc5VYXJDHryDgX71pjjwgB9d9dlRZI9XQ0UdScko5OhzHF6lOI0KnYLLkGLyQBFyj3HxCLK5wv/nSOR361DwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPDgtqj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72FCC113CC;
	Fri, 12 Apr 2024 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956596;
	bh=2fRaByBcu71Pu+J3uKplrEOFOlvvPf69p5YcpYqYZlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPDgtqj7eGfVx2iiWv3ZhFaR1Io9CWEnfmoqnvbDX3HzFosRjklH8tNxI2x5TfCko
	 aO3VYsJYc0CuIocY9cwEQuzGovCvtLdb2LXi4jyPxFug7Cbw4iTe8054+5AxJ0QcO/
	 R6/JM0V3e76VfUTF/ZlH5XnW2jQt+/nrO6AoK6mYHFI8GUJ9fwfqafY35gH/PNo+ZH
	 OWRTklfD/y2m4+nYiPs35LCWXnqLtG7RCumW15MpowmH5XmVSr/A8r+abyYdfVVUiD
	 6CPTT5Wq1+ygcFRfNwLhOKDs8DEZfT7S/IjahQ2DqrcLc6uFKp3RZVrOFt0u/RdNH7
	 JZbQ8Zir4fH7g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 10/12] core/dwarf_loader: Add functions to set state of CU processing
Date: Fri, 12 Apr 2024 18:16:02 -0300
Message-ID: <20240412211604.789632-11-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When doing reproducible builds we'll process loaded CUs in
pahole_stealer in the same order as the CUs are in the DWARF file
(vmlinux), so sometimes when we may finish loading a CU out of order and
thus will have to either busy loop (to use a hot cache?) to way for its
turn or simply leave it in the ordered queue waiting its turn (may use
too much memory with a pile of CUs waiting to be processed (converted to
BTF)?), so we need to mark its state:

   unprocessed, loaded, processing

So when pahole has pahole_stealer called, it will not use necessarily
the handed cu, because it may be out of order, say if the first CU that
pahole gets in one of its threads is a big one and takes longer to
process than one of the other handed to the otherd DWARF loading
threads, then it will have to wait for the first one to be processed by
the, so far, non reproducible BTF encoder.

We will instead allow tools such as pahole to ask for the next CU do be
processed, i.e. in order, if the first one is still not loaded, then
it'll just return NULL and the encoder will return so that its DWARF
loading thread can go load one more CU and then ask pahole to encode one
more CU, rinse repeat.

We'll see if this ends up using too much memory due to unconstrained
loading of CUs that pile up waiting for BTF encoding.

At the end the tool will need to flush the queue.

When a CU is processed it gets deleted, which goes on freeing memory.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c |  8 +++++---
 dwarves.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 dwarves.h      | 11 +++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 3ef22aada6f46f13..b15cf543fa9d7471 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3016,13 +3016,15 @@ static void cu__sort_types_by_offset(struct cu *cu, struct conf_load *conf)
 	cu__for_all_tags(cu, type__sort_by_offset, conf);
 }
 
-static int cu__finalize(struct cu *cu, struct conf_load *conf, void *thr_data)
+static int cu__finalize(struct cu *cu, struct cus *cus, struct conf_load *conf, void *thr_data)
 {
 	cu__for_all_tags(cu, class_member__cache_byte_size, conf);
 
 	if (cu__language_reorders_offsets(cu))
 		cu__sort_types_by_offset(cu, conf);
 
+	cus__set_cu_state(cus, cu, CU__LOADED);
+
 	if (conf && conf->steal) {
 		return conf->steal(cu, conf, thr_data);
 	}
@@ -3031,7 +3033,7 @@ static int cu__finalize(struct cu *cu, struct conf_load *conf, void *thr_data)
 
 static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_load *conf, void *thr_data)
 {
-	int lsk = cu__finalize(cu, conf, thr_data);
+	int lsk = cu__finalize(cu, cus, conf, thr_data);
 	switch (lsk) {
 	case LSK__DELETE:
 		cus__remove(cus, cu);
@@ -3508,7 +3510,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 	}
 
 	if (type_cu != NULL) {
-		type_lsk = cu__finalize(type_cu, conf, NULL);
+		type_lsk = cu__finalize(type_cu, cus, conf, NULL);
 		if (type_lsk == LSK__DELETE) {
 			cus__remove(cus, type_cu);
 		}
diff --git a/dwarves.c b/dwarves.c
index 3cd300db97973ce4..fbc8d8aa0060b7d0 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -469,6 +469,44 @@ void cus__unlock(struct cus *cus)
 	pthread_mutex_unlock(&cus->mutex);
 }
 
+void cus__set_cu_state(struct cus *cus, struct cu *cu, enum cu_state state)
+{
+	cus__lock(cus);
+	cu->state = state;
+	cus__unlock(cus);
+}
+
+// Used only when reproducible builds are desired
+struct cu *cus__get_next_processable_cu(struct cus *cus)
+{
+	struct cu *cu;
+
+	cus__lock(cus);
+
+	list_for_each_entry(cu, &cus->cus, node) {
+		switch (cu->state) {
+		case CU__LOADED:
+			cu->state = CU__PROCESSING;
+			goto found;
+		case CU__PROCESSING:
+			// This will only happen when we get to parallel
+			// reproducible BTF encoding, libbpf dedup work needed here.
+			continue;
+		case CU__UNPROCESSED:
+			// The first entry isn't loaded, signal the
+			// caller to return and try another day, as we
+			// need to respect the original DWARF CU ordering.
+			goto out;
+		}
+	}
+out:
+	cu = NULL;
+found:
+	cus__unlock(cus);
+
+	return cu;
+}
+
 bool cus__empty(const struct cus *cus)
 {
 	return list_empty(&cus->cus);
@@ -701,6 +739,8 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		cu->addr_size = addr_size;
 		cu->extra_dbg_info = 0;
 
+		cu->state = CU__UNPROCESSED;
+
 		cu->nr_inline_expansions   = 0;
 		cu->size_inline_expansions = 0;
 		cu->nr_structures_changed  = 0;
diff --git a/dwarves.h b/dwarves.h
index 9dc9cb4b074b5d33..dd35a4efd6e5decb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -43,6 +43,12 @@ enum load_steal_kind {
 	LSK__STOP_LOADING,
 };
 
+enum cu_state {
+	CU__UNPROCESSED,
+	CU__LOADED,
+	CU__PROCESSING,
+};
+
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
  * like a allyesconfig vmlinux kernel we can get over 65535 types.
@@ -177,6 +183,10 @@ void cus__add(struct cus *cus, struct cu *cu);
 void __cus__remove(struct cus *cus, struct cu *cu);
 void cus__remove(struct cus *cus, struct cu *cu);
 
+struct cu *cus__get_next_processable_cu(struct cus *cus);
+
+void cus__set_cu_state(struct cus *cus, struct cu *cu, enum cu_state state);
+
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
 struct cu *cus__find_pair(struct cus *cus, const char *name);
@@ -287,6 +297,7 @@ struct cu {
 	uint8_t		 little_endian:1;
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
+	enum cu_state	 state;
 	uint16_t	 language;
 	unsigned long	 nr_inline_expansions;
 	size_t		 size_inline_expansions;
-- 
2.44.0


