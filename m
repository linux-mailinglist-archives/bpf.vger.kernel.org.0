Return-Path: <bpf+bounces-11580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230F7BC1FD
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAA2822DC
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D717450E5;
	Fri,  6 Oct 2023 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JY5fdzae"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD85450D0
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:09 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29466BE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Te9a6DGjsrbCHeFiuWsmLzlM5lIt/JC9VNLPcajb48Q=; b=JY5fdzaesqQ1XqUOqZFVqzy22U
	XrUfwrvQ9vCok+1QDXQ3K8tI2FklvRpw6TL7RDHID4lBKHQ8HPMTHeZ0V86ofRZc5pyOzqRlUaDsN
	Fl6/jgth0XSPqgnRz3hYsDaygmSDV2o7JnjQFvKHOvWz83cogMo80gSSuE+MYJHdA9L0/cs3ln91P
	p4jvlVw2S9lIcrVoqvlHiUMaWXcbIjLuH/9Ku/wu4ycAAVUIRp6WlqVOHSU8zHhm20ApnqVqsQ0rU
	7CnREPKdOrfZ15Bf0LztnJQ8FwBlDrCYF3TWg4rnp9GeqbGTziS2nYQbcqrloXoIdLoN1YDOchoWQ
	Va6/DKiA==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyO-0001jq-U5; Sat, 07 Oct 2023 00:07:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/7] bpf: Fix BPF_PROG_QUERY last field check
Date: Sat,  7 Oct 2023 00:06:49 +0200
Message-Id: <20231006220655.1653-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While working on the ebpf-go [0] library integration for bpf_mprog and tcx,
Lorenz noticed that two subsequent BPF_PROG_QUERY requests currently fail. A
typical workflow is to first gather the bpf_mprog count without passing program/
link arrays, followed by the second request which contains the actual array
pointers.

The initial call populates count and revision fields. The second call gets
rejected due to a BPF_PROG_QUERY_LAST_FIELD bug which should point to
query.revision instead of query.link_attach_flags since the former is really
the last member.

It was not noticed in libbpf as bpf_prog_query_opts() always calls bpf(2) with
an on-stack bpf_attr that is memset() each time (and therefore query.revision
was reset to zero).

  [0] https://ebpf-go.dev

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb01c31ed591..453a43695a23 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3913,7 +3913,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	return ret;
 }
 
-#define BPF_PROG_QUERY_LAST_FIELD query.link_attach_flags
+#define BPF_PROG_QUERY_LAST_FIELD query.revision
 
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
-- 
2.34.1


