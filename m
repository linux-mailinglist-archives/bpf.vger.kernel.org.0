Return-Path: <bpf+bounces-54448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB8A6A52E
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4CC982308
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B93221564;
	Thu, 20 Mar 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOu0iDNi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8C27701;
	Thu, 20 Mar 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471005; cv=none; b=qwyxM2/dYxiiUumMYgGcQoy5banAR015bv8WX/Nvmwg2DSerpVN7rx1A+HZi/PyPHRO/4uDvVHExtdzvlpcD8xsuq81MI1G/I55kgIkHpWBeLv10mpK2R7pxrHwuEHjwiQV+ym+id5ARDgy362DzuwJ7CKzTjjnl6RbFkeuYnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471005; c=relaxed/simple;
	bh=8tgY3iiqVGGlyXrYjjjnWOUtDPaeVsmcbE4Vgixh/jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzXAdr90L3U6LC0NGgpKmB65hsS6nVVb5j6uFTJgntcLk55UgH8VLNR7bM7Y6OeLzauFzCpCKLyKESdxbuoDynPZygrACjaPUc7dVEMGc/dDAuOIRB7keBHPzALwhwabFs8Ka9mwUJ5QEgVwpj/C3RyHGouvrV9N1OUQUk5KrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOu0iDNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A780C4CEDD;
	Thu, 20 Mar 2025 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471004;
	bh=8tgY3iiqVGGlyXrYjjjnWOUtDPaeVsmcbE4Vgixh/jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOu0iDNiaxsDGrouCf0jgu5zBEk/p3rBjLdUiSrOghETLGrAHWU1B9vVRBUN84GMe
	 vvWqtMXc0e/SqBo4N7o6/HKTODDjxoWu6jzZ+UTFdy0lXQaDACusaqYGXUOEh0fLyk
	 Jg0bcn88Pu60ANU8JNUcuRokY5WYlMujWCRfBcdcQBBatK/wN1YJAkHpp84uKaqhB/
	 1yTW/0STkm2lviqF70Cokb6k3YTtLlkfRFUAkmZKykU1/3YbHE7f8Iu9oCbo97gHZC
	 i5nOEbWsw/EgS4/11d+K6lPL5aOiUVbXLCT1VUpclWiRUvXc3SU/PnBUFQ+jN3SxQ2
	 jqgP2CECYMJXg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 07/23] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Thu, 20 Mar 2025 12:41:42 +0100
Message-ID: <20250320114200.14377-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction,
so it probably go away with that, but with the upcoming changes
that use multiple instructions on the probed address we need to
ensure that any update to mm's pages is exclusive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 92fed5e50ec1..bd4bc62f80d7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1465,7 +1465,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	int err = 0;
 
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
@@ -1482,7 +1482,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, mm, vaddr);
 	}
-	mmap_read_unlock(mm);
+	mmap_write_unlock(mm);
 
 	return err;
 }
-- 
2.49.0


