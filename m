Return-Path: <bpf+bounces-10144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2487A1BD8
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0E02817C0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36ECDF6E;
	Fri, 15 Sep 2023 10:14:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F517D50F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278EEC433C8;
	Fri, 15 Sep 2023 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694772866;
	bh=2HiTIMvFmxX6QXKl8DIPsptVBW1ePNNg6JTogcva0bs=;
	h=From:To:Cc:Subject:Date:From;
	b=tGO3LZ/Ymfl2bcpdAezKdyohiUqPqtEgk5SCZG3o7ftpw4idAzsj5JwYtuCD70IsN
	 V132wwvqUy5mTLOOWkrYXcUG8Ao6IY8mK3RGZLwXCJZxV9HjtT3RhIyFyZRAMBIijr
	 YgZfZwiOh8KPTawirNb5LKy9q4nFh6mUyWHDMYKANvMkHXEQCLZz0UaTnhCR7/iO1u
	 kcxYynjvRU6vQoxYObDcXE2wB8nwVjvFXMPmovnSG7amicRpMrihPBWNKFJYkgAU6W
	 gzFAZYn5kPnG4vmkE68j+SquQfoLAnH/xdkUzZ+6rw9Ud/01QCSnmsBDCtnVCpqGUl
	 ZOv4qmZByN2Kg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix uprobe_multi get_pid_task error path
Date: Fri, 15 Sep 2023 12:14:20 +0200
Message-ID: <20230915101420.1193800-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan reported Smatch static checker warning due to missing error
value set in uprobe multi link's get_pid_task error path.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@moroto.mountain/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c1c1af63ced2..868008f56fec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3223,8 +3223,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
 		rcu_read_unlock();
-		if (!task)
+		if (!task) {
+			err = -ESRCH;
 			goto error_path_put;
+		}
 	}
 
 	err = -ENOMEM;
-- 
2.41.0


