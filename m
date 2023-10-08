Return-Path: <bpf+bounces-11670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98C7BD03E
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CC41C209AB
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DD1A5AE;
	Sun,  8 Oct 2023 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnHq6+db"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70D156C6;
	Sun,  8 Oct 2023 21:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F12C433C8;
	Sun,  8 Oct 2023 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696800178;
	bh=YLh2pbaliXysNvN/gBrRbcl3kP9/FFsUFSe3vt7aOd8=;
	h=From:To:Cc:Subject:Date:From;
	b=YnHq6+db3qWKG0GFmcBdCZk4GoxjwbeDews/ndQw4TYeOTMGQ5TAwYxQMYoAc6U+N
	 0wplQRRNCeSVTD1TX7Rv1zhfVq+WC3pOG0GV4czQFDahAB7qx0arfOBpFHaq/l0NWB
	 OwGwKcVWNZptBA+ldp/wHf6wrYSkZgThLz0FzrICoEjVE+WWd++KRKsET3DUWUwyiS
	 0tJ2CBcdSj7sZ6SJUDzon7Qp0cZBUcV1cMG83NssIAuDLI5Jss1iXAznKFiJ9w0E2W
	 ENvBkQuhkApWKlU00yWaJjfaCamv0xNsODtFgBY1lKtUGdDfzK7T6FN1IrtySBqQJA
	 Vnjf5S1m03GWQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>
Cc: linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2 0/2] tools/build: Fix -s detection code for new make
Date: Sun,  8 Oct 2023 23:22:49 +0200
Message-ID: <20231008212251.236023-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this fixes the detection of silent flag for newer make.

It'd be better to re-use the code, but I don't see simple
way without more refactoring. I put that on my todo list.

v2 changes:
  - adding the change for tools/scripts/Makefile.include as well

thanks,
jirka


---
Jiri Olsa (2):
      tools/build: Fix -s detection code in tools/build/Makefile.build
      tools/build: Fix -s detection code in tools/scripts/Makefile.include

 tools/build/Makefile.build     | 10 +++++++++-
 tools/scripts/Makefile.include | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

