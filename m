Return-Path: <bpf+bounces-3390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDA73CDFB
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9CF1C2085B
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99F63A;
	Sun, 25 Jun 2023 02:18:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF977F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 02:18:49 +0000 (UTC)
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686BDA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 19:18:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1687659526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z8frAR5aHPap5K4KH+vyjHokYZZLb1qCkhHjmKu7OeM=;
	b=jUTTTBslpueDRwtih7B22zYguJiVaLAfJnCThYFeUyIMfdyiCCLt+isXUs/E2hGqD/y3ky
	PJ5vY86ogS0M6MTPhw1Cqeg1dil7znxoPry1nLIJGEZ721C/5gr6tj6n6j1iF/TP9zY4Xl
	BCeX6vZZweRFZ0mrMOzPaPRXW57E+90=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH] libbpf: kprobe.multi: feedback function counts by kernel traced
Date: Sun, 25 Jun 2023 10:18:16 +0800
Message-Id: <20230625021816.1734617-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jackie Liu <liuyun01@kylinos.cn>

When tracking functions through kprobe.multi, the number of tracked
functions cannot be directly obtained. Sometimes in order to calculate
this value, it is necessary to recalculate according to the pattern in
the program. This is unnecessary. It is calculated by libbpf feedback
through opts.cnt value, which can save resources. Example at [1].

[1] https://github.com/JackieLiu1/ketones/blob/master/src/funccount/funccount.c#L317

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 tools/lib/bpf/libbpf.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fca5d2e412c5..ed3f1202c570 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10506,7 +10506,7 @@ static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res)
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
-				      const struct bpf_kprobe_multi_opts *opts)
+				      struct bpf_kprobe_multi_opts *opts)
 {
 	LIBBPF_OPTS(bpf_link_create_opts, lopts);
 	struct kprobe_multi_resolve res = {
@@ -10582,6 +10582,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	}
 	link->fd = link_fd;
 	free(res.addrs);
+	OPTS_SET(opts, cnt, res.cnt);
 	return link;
 
 error:
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0b7362397ea3..f860dacc6add 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -527,7 +527,7 @@ struct bpf_kprobe_multi_opts {
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
-				      const struct bpf_kprobe_multi_opts *opts);
+				      struct bpf_kprobe_multi_opts *opts);
 
 struct bpf_ksyscall_opts {
 	/* size of this struct, for forward/backward compatibility */
-- 
2.25.1


