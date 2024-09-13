Return-Path: <bpf+bounces-39851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DD9788BF
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81684B24A9B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08D4146D6E;
	Fri, 13 Sep 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="faw8jARN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186414659D
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255088; cv=none; b=gQmqw+f6+p3CKzTaGzI+wCNHhxPaVD4bKNyH3RwwxLxhmef2wJP6IpaoS1AurK+e6e6Vy3m9SZOl+sc8KB5D19H5ngqQMRqJyXnq8+XBEcTAKSUb73Kv8W97krBXYOVPKUdxB1TB33nkTcSYQunoHi6vBK3gfo9qBCCNQGY9/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255088; c=relaxed/simple;
	bh=GkU/3wq0lI0FMDz0p3eQjWKnRYZeGNjVNQr/Po48UBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfHZZn73UPF3/Kj4xwXAjVYyhGr1D2mZCfQN0e0OT+IYotwp6P7bAfOCpv20CpHNLYV6uGKI15pSZ9GdmemRWOCj5riajKg/buwuX1zSHPlq0ISNVhJgk6OdsVMrpOotTMmxHU07IcNmmXDTmBU5MOkDsR8bqZ8D8iWfUy0yMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=faw8jARN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=UEZhs96GwHSzA8jZJd6eQCK5jEWwHxJpMnAA7q4zyIk=; b=faw8jARN/ceA9jw7hsWZskzTZf
	+CooljJjyoOjWRUJam+H99FMWbsO7xvm8E+XZ7CIx6VPs6CkseRlmxcQg+ry2uYh71oIozNBuhZM6
	UKbIQHhR2pXbdoCXV4V7BdBDClLNPKUFzvFm5m6qJFHbji4rCdiUTJvymKrTnF/sQf90DaDPs4FRP
	H2Sj3ByRfVfQs9nRnFQVLZk5JZ9Cp6QQxpO1cjLVqDa3vI3xLwof5FZCaszBkHtyyNEib+KgrTcFz
	W53EgWPhKkctS7eUtzJTndR8I0q7RCvEQ2fg2+lDNCBW2vipLGzXoDR0MI10YVLSbkSVO+wM+J1uM
	HfrWzbDA==;
Received: from 43.249.197.178.dynamic.cust.swisscom.net ([178.197.249.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spBno-000KsY-Gz; Fri, 13 Sep 2024 21:17:56 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 1/9] bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
Date: Fri, 13 Sep 2024 21:17:46 +0200
Message-Id: <20240913191754.13290-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

The bpf_strtol() and bpf_strtoul() helpers are currently broken on 32bit:

The argument type ARG_PTR_TO_LONG is BPF-side "long", not kernel-side "long"
and therefore always considered fixed 64bit no matter if 64 or 32bit underlying
architecture.

This contract breaks in case of the two mentioned helpers since their BPF_CALL
definition for the helpers was added with {unsigned,}long *res. Meaning, the
transition from BPF-side "long" (BPF program) to kernel-side "long" (BPF helper)
breaks here.

Both helpers call __bpf_strtoll() with "long long" correctly, but later assigning
the result into 32-bit "*(long *)" on 32bit architectures. From a BPF program
point of view, this means upper bits will be seen as uninitialised.

Therefore, fix both BPF_CALL signatures to {s,u}64 types to fix this situation.

Now, changing also uapi/bpf.h helper documentation which generates bpf_helper_defs.h
for BPF programs is tricky: Changing signatures there to __{s,u}64 would trigger
compiler warnings (incompatible pointer types passing 'long *' to parameter of type
'__s64 *' (aka 'long long *')) for existing BPF programs.

Leaving the signatures as-is would be fine as from BPF program point of view it is
still BPF-side "long" and thus equivalent to __{s,u}64 on 64 or 32bit underlying
architectures.

Note that bpf_strtol() and bpf_strtoul() are the only helpers with this issue.

Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/481fcec8-c12c-9abb-8ecb-76c71c009959@iogearbox.net
---
 v3 -> v4:
 - added patch

 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3956be5d6440..0cf42be52890 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -518,7 +518,7 @@ static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
 }
 
 BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
-	   long *, res)
+	   s64 *, res)
 {
 	long long _res;
 	int err;
@@ -543,7 +543,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
-	   unsigned long *, res)
+	   u64 *, res)
 {
 	unsigned long long _res;
 	bool is_negative;
-- 
2.43.0


