Return-Path: <bpf+bounces-46208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757309E61F6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F8C1885625
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2E1DFED;
	Fri,  6 Dec 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLKBztUR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21D1AAD7;
	Fri,  6 Dec 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443934; cv=none; b=J6D8vEOqEnbbu+gJA8sFzKXO8iNRWi44Dcu3gLhrhvlQV5e3Qtjevb3viyM+7uUMlEMF3LjGTBkpz/Hjhd5vnCOsoHTDWOI2qU3RUMBog6R8+htFrjbtxwDRtZtrrlm1hosnAHfQ54UMHQOdpYEg9LxKgScG3B3b76XcUW/9fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443934; c=relaxed/simple;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCsmbkNQWBioGRS7L957P35CTI/UoGFjfthnV/cYK7CshJxVE4PeN5pT8W3UC4V4mF7X+smk6QhCUOL2YPOc+9qtxSQJ4dzlU61QY4g5ygFs8/l202nXZm5sK8FnFC86gJuto5L7PHrSLKul5tZfuO04UNZmQZdm9t99zU7UJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLKBztUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A254C4CED1;
	Fri,  6 Dec 2024 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443934;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLKBztURGtFYdapGvnDL9RItJN7RS+mDgROM0nGR+p7owECtH9jtGaETtiAbAky7A
	 L334JPHJGBCkmheDKcLurWETEOcWGfK250h4EEEfEn49MfDEl6U2IyAhcUXSN+yoNe
	 FaWYrElkFH9aGZhgosX/xGxkQzIkQfYNnKil0Tc84i9LiFUKwhIxzTvOKZcAlRiSs+
	 yav92o1xJINMs8IBSdAp5BFumU5+mh4q0NChmdlDaYjBCJKJlZx/79uJEP3Hk+nebA
	 Jnp0LxAk5ivWWDZJOjGBQ0/xjP04r+fY9jFSmD7IDMgdcgYJFw73v7UvididqUS/0O
	 ckN0T+AvQlh/Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v20 15/19] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Fri,  6 Dec 2024 09:12:09 +0900
Message-ID: <173344392903.50709.11550896255946412357.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173344373580.50709.5332611753907139634.stgit@devnote2>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
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

Since the fprobe event does not support maxactive anymore, stop
testing the maxactive syntax error checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 61877d166451..c9425a34fae3 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -16,9 +16,7 @@ aarch64)
   REG=%r0 ;;
 esac
 
-check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
-check_error 'f^1a111 vfs_read'		# BAD_MAXACT
-check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+check_error 'f^100 vfs_read'		# BAD_MAXACT
 
 check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
 check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR


