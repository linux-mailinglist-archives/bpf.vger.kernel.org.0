Return-Path: <bpf+bounces-49970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBFA20D13
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35197A204E
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1C1D5AC0;
	Tue, 28 Jan 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wscfs6p1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC51A8F61;
	Tue, 28 Jan 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078195; cv=none; b=j/YtMATzRkwRwyRRQeWWnRsgNn8YQEsnPO5As3ivh3bCe551JSJefyfDo6ihFBMisdIK0w1BaP/SeRbtiMCbGmru3rXR6VxWp7Ej6MG1mhcCpd2J+4taeK6a0d6SZ586xgzBQxQk6nVF9Vf8VNQms+vg+tx94KqvtAGaHX/nz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078195; c=relaxed/simple;
	bh=0c2LE7rOoVqLrtfbqVXdQvbhQkkgLhZuKApxToWAa1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAnCvRV3Ea2bol7HB4UhmCqHuvjvZuwePyarXL9GzGL7tiryJ+s0jNH5zpEo0n+PTFWt0TsAg5uLG1hm/ZTwTLRfc4EY2WIYyVLL3QH0fZOescJneOqnEgcqR8wTomCOcGim4xp+1QCZX3JL/kEWU7vzdlQZEl809dZvNou8icY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wscfs6p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C0C4CED3;
	Tue, 28 Jan 2025 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078194;
	bh=0c2LE7rOoVqLrtfbqVXdQvbhQkkgLhZuKApxToWAa1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wscfs6p1WhOpKKpZKZr+MJ+8jx7Acvu4RDw4jCVYS0srs+X5s9we617IxhFMyr1qu
	 6eTOEH7yqGvtxGzYVA40D0aMIgyTgBIbWSyiQgzTtsi7cvQMnTmVz5enE8rat3yYpp
	 IOvJOzZk/yGg5zF3m7UqEEdJWLu9ZqMlNuSxJei3o3htTm/YCbt22m87IoeCLf/OVJ
	 4CyjUn0wHRZ7iPsmAER9zaQ/Ibti2SJB2F0xK2t2+ZzYmZ7sTizWFRvGLhSGnQVAOS
	 Pym7Pn4f4sKv4tDsHW4etW9HWPKf9ODYbdy3AyJmx+o444c1160ABg9pLL11q6sIiN
	 yLzC6xg63fCmQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH 2/2] s390: tracing: Define ftrace_get_symaddr() for s390
Date: Wed, 29 Jan 2025 00:29:48 +0900
Message-ID: <173807818869.1854334.15474589105952793986.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173807816551.1854334.146350914633413330.stgit@devnote2>
References: <173807816551.1854334.146350914633413330.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add ftrace_get_symaddr() for s390, which returns the symbol address
from ftrace's 'ip' parameter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/s390/include/asm/ftrace.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index a3b73a4f626e..185331e91f83 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -51,6 +51,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
 }
+#define ftrace_get_symaddr(fentry_ip) ((unsigned long)(fentry_ip))
 
 #include <linux/ftrace_regs.h>
 


