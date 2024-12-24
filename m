Return-Path: <bpf+bounces-47580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9329FBA56
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022121885616
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79D1917F0;
	Tue, 24 Dec 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mynL8RFA"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57C18E379;
	Tue, 24 Dec 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735027333; cv=none; b=DMC9gjViEmMaZ/stvlJJQx/B9dYUNbQK/lUlL5NwcNjdREMKUbaX/UFEL5PC+eUaX9V2yfd4xlhVrczBeJZ+I51Ukf7tjXg+C15Rg2uonEgtB7tsAwD17dpNE+NbbDzun2PU/8xe0Oh4VuC2VSLQABCbRrR/xfzazO3/gVn0Tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735027333; c=relaxed/simple;
	bh=EE/5fetqis1+Ma7btLqM8PKE8Xe5oBOSPU9HPbdb3Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=my2ITDk1OvA/c/0UO4vqFAnYY1QctJgHBcEHiz14m9OS3t0ckNDl4jXmpW2pSnTQr8nvsWxkOzJWkMKf0ZgpfHt+a8M6LbItZ+PtvGcXEePG/fy5f1f19zP4/fpnU2ReeirZbzCX2PnePIplr3eWkiUcweaVw+4gpRgsBiseiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mynL8RFA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7xgQW
	V5KxLITGtOiXRnUQXHTggVR2ZIWhCCtxigiM8k=; b=mynL8RFAwzaAGFU0CiwH9
	oFryxKUKK/9WsANpzA7vZRUBK+Zj6HIM292gXdWuNh4t4kY+QHifeRtynhWBkRat
	YZ/FCh+gP9Ara6Frp+OyCzVNK2IxT+SrVZcQDp6pUIMjomLLVU1u/K2VMbDGb6gb
	9fuCnxpWrckbgie2wyeuTI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33ycfampnlaNnBQ--.34714S2;
	Tue, 24 Dec 2024 16:00:41 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	pulehui@huawei.com,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v2] selftests/bpf: avoid generating untracked files when running bpf selftests
Date: Tue, 24 Dec 2024 15:59:57 +0800
Message-ID: <20241224075957.288018-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33ycfampnlaNnBQ--.34714S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Cry7Xw47uF4fAF1fZwb_yoW8ur4Up3
	95Jw1YkrWSqFWUtF1kurWa9r15JrsxJay0va1UZayUZr17JFW8GF4IyFWUAry3urZIqryf
	A34IgFy3Aay8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_dgA7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwa-p2dqZm5iOgAAsM

Currently, when we run the BPF selftests with the following command:
'make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=""'

The command generates untracked files and directories with make version
less than 4.4:
'''
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	tools/testing/selftests/bpfFEATURE-DUMP.selftests
	tools/testing/selftests/bpffeature/
'''
We lost slash after word "bpf".

The reason is slash appending code is as follow:
'''
OUTPUT := $(OUTPUT)/
$(eval include ../../../build/Makefile.feature)
OUTPUT := $(patsubst %/,%,$(OUTPUT))
'''

This way of assigning values to OUTPUT will never be effective for the
variable OUTPUT provided via the command argument [1] and bpf makefile
is called from parent Makfile(tools/testing/selftests/Makefile) like:
'''
all:
  ...
	$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET
'''

According to GNU make, we can use override Directive to fix this issue [2].

[1]: https://www.gnu.org/software/make/manual/make.html#Overriding
[2]: https://www.gnu.org/software/make/manual/make.html#Override-Directive
Fixes: dc3a8804d790 ("selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make")

Signed-off-by: Jiayuan Chen <mrpre@163.com>

---
v1->v2: fix patchwork check fail.
---
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9e870e519c30..eb4d21651aa7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -202,9 +202,9 @@ ifeq ($(shell expr $(MAKE_VERSION) \>= 4.4), 1)
 $(let OUTPUT,$(OUTPUT)/,\
 	$(eval include ../../../build/Makefile.feature))
 else
-OUTPUT := $(OUTPUT)/
+override OUTPUT := $(OUTPUT)/
 $(eval include ../../../build/Makefile.feature)
-OUTPUT := $(patsubst %/,%,$(OUTPUT))
+override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 
-- 
2.43.5


