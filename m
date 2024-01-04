Return-Path: <bpf+bounces-19002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933FD823AF8
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADF6288524
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A55221;
	Thu,  4 Jan 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYz965wE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3B1427B
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 03:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D0C433C8;
	Thu,  4 Jan 2024 03:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337461;
	bh=sAyrKHLVBjkWeFIXbnLiiUQGWhzywVhOLv2qjZUQpkM=;
	h=Date:From:To:Cc:Subject:From;
	b=qYz965wEKiEPv7hM0fI8CibF/WTuSU2fIsJJaNa0F4eCYouTCywmfYiax1QsBdrz4
	 2CRAJT1S9yTEQWZUsZi7nHq4u9af+fwLBgxdsbGKWltQUS7D0aQj8PLyGZ0c/ZSUDw
	 Fi3M+qBtUQQaHU4vdz/+TMEGUrq2j8PDKrw9cVqTjr2LpaF8w7v1PDb0W1uq5fYgzG
	 wJKww3ZnI5TFubl0ymcOqRxr+ku+38sIbUXE28iQfOpnJx9SiX1+TxnLCw4KKRyqd2
	 f6WTfSbXqA6sZx1I3iwdiZh0H0zdvzAeD72aeFA3LoLRwMuusT/7+K/rbtriFYW2ws
	 /gRO3LFpt8nuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0899F403EF; Thu,  4 Jan 2024 00:04:17 -0300 (-03)
Date: Thu, 4 Jan 2024 00:04:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZZYgMYmb_qE94PUB@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

The header with the prototype for basename() is missing in the gen.c
file, which breaks the build in distros where that header doesn't get
include by some of the other includes present in gen.c, by luck, fix it.

Noticed when build perf on the Alpine Linux edge.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b8000d75d2..0e50722588b48fa0 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -7,6 +7,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <linux/err.h>
 #include <stdbool.h>
 #include <stdio.h>

