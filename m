Return-Path: <bpf+bounces-26680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636628A37C1
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA431B2216C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14E1514F8;
	Fri, 12 Apr 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Livt2O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634C14F13E;
	Fri, 12 Apr 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956589; cv=none; b=Z6UcmzRZudGTYD2toLsSZgizlOGTDiA6wckXogAY3TEdf844GPQeKePyxPsfBiYxGfZLPO00+AKPPxcFHJGER57gl3UAAcVj0HCZItRa5mrr+nxeKXfFXE2PFkrcia9Ztecew+J86bH9DNwu0J89I1hULA0gYoMOioZ41wkCp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956589; c=relaxed/simple;
	bh=QPCVECCkNP/mRX6k0IN6gRC2BYWoQ9twP/v6i1a73s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS2MXw+U6hW90wFsxF6pTtWbnh96m7DmWfiVemk+f/AzvmevrIx72nyGMEHHG6YYarXA2HuDd/H1SxBBILt2IlTOChCmdqjAfqeLv6QZFjc+CTQymZP965+cbQZ/aLZjp9NHraooDzjs6PH5CtqW3IGpExOSwGQgIHV8c6FRI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Livt2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09475C113CD;
	Fri, 12 Apr 2024 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956589;
	bh=QPCVECCkNP/mRX6k0IN6gRC2BYWoQ9twP/v6i1a73s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2Livt2OZIU3OAZ8UWJ+fU50KVvij17zdoAIvsYk/jMwUUGqXpiH6kDtI3y8EDM6w
	 dsWLss425CiBDNYuCNTVwrDKXgA5QWvKo1q+ui1tEWh3qat8VecTfyLiHZSdZ98XZs
	 JYSioGYjKcFsZwNsoFekBIyKjzO+D2BKos46mZWnIV3jPaL5Mb7TzQ3b9gP3h3W8hm
	 EHyozg4b2w1QLtAZI5v17zvSaOrHhCWHUO0JKo+EMsHuMviBR9iy0H7XH/22oWkXTs
	 BXneN/0xTvZdub7pUYhvk1LwhEXKfgiIoKpVKeF++YMCZyrltC0FRwLa9aTbemNIo4
	 5N7mQtSg7ELHA==
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
Subject: [PATCH 07/12] core: Add unlocked cus__add() variant
Date: Fri, 12 Apr 2024 18:15:59 -0300
Message-ID: <20240412211604.789632-8-acme@kernel.org>
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

As we'll use with the cus lock already held when getting the next CU
from vmlinux to keep the order in the original DWARF file.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 9 ++++++---
 dwarves.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 3b4be595aa59a856..654a8085e9252a21 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -479,13 +479,16 @@ uint32_t cus__nr_entries(const struct cus *cus)
 	return cus->nr_entries;
 }
 
-void cus__add(struct cus *cus, struct cu *cu)
+void __cus__add(struct cus *cus, struct cu *cu)
 {
-	cus__lock(cus);
-
 	cus->nr_entries++;
 	list_add_tail(&cu->node, &cus->cus);
+}
 
+void cus__add(struct cus *cus, struct cu *cu)
+{
+	cus__lock(cus);
+	__cus__add(cus, cu);
 	cus__unlock(cus);
 
 	cu__find_class_holes(cu);
diff --git a/dwarves.h b/dwarves.h
index 4dfaa01a00f782d9..42b00bc1341e66cb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -171,6 +171,7 @@ int cus__fprintf_load_files_err(struct cus *cus, const char *tool,
 int cus__load_dir(struct cus *cus, struct conf_load *conf,
 		  const char *dirname, const char *filename_mask,
 		  const int recursive);
+void __cus__add(struct cus *cus, struct cu *cu);
 void cus__add(struct cus *cus, struct cu *cu);
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
-- 
2.44.0


