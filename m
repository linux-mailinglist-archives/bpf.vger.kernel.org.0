Return-Path: <bpf+bounces-64693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E08B15E7C
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C9A7AF7B7
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADECC27C158;
	Wed, 30 Jul 2025 10:50:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117841D799D;
	Wed, 30 Jul 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872635; cv=none; b=PF0+NrUDXvC3vz1QUNJNNSUPkblK742GPFrMxy7fq+spyfnR2e59XL+dq6tLlFTP+mkDpsw0GxNaHDj+JOB+kMeHzNomzd+PxlGLrnD9rnzJsnciyjBN4f5K9qQ1EaVbiw2x0YLa+A9Sgg4rR/q+2woAXbvLux5h1qOqV0At3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872635; c=relaxed/simple;
	bh=D80lUy/9HvFywqntd3LTcqDg8aPeGpQEZAR5pbToRSU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=e5y4vRucyOpenu10+lMgUT3NTf5Z2ShvOY2rFBHKqYnk9fCq7uf+7uaumMmc012cwAqOk6g2rW9Zlf40QA9KlnRIheXfGGofdiM+1aTxWPznqxVfUC9f+Mgs3hYhkX0xdNVL+v9UWVyIhLHZ296VltSlNBh/otUHBRksyR5liEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fe5e3d566d3211f0b29709d653e92f7d-20250730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9647400b-9f75-44da-bf56-f4dc43cf20c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:0945f5ac18ab22ef7777a604eb59f05d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe5e3d566d3211f0b29709d653e92f7d-20250730
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1971685612; Wed, 30 Jul 2025 18:50:23 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: bpf: Fix kernel coding style
Date: Wed, 30 Jul 2025 18:50:19 +0800
Message-Id: <20250730105019.436235-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'noinlne' after 'int' cause
"ERROR: inline keyword should sit between storage class and type"
by checkpatch.pl

- Standardize function declaration style by moving 'noinline' modifier
- Fix asm volatile statement formatting

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 net/bpf/test_run.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 9728dbd4c66c..4a862d605386 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -524,27 +524,27 @@ __bpf_kfunc int bpf_fentry_test1(int a)
 }
 EXPORT_SYMBOL_GPL(bpf_fentry_test1);
 
-int noinline bpf_fentry_test2(int a, u64 b)
+noinline int bpf_fentry_test2(int a, u64 b)
 {
 	return a + b;
 }
 
-int noinline bpf_fentry_test3(char a, int b, u64 c)
+noinline int bpf_fentry_test3(char a, int b, u64 c)
 {
 	return a + b + c;
 }
 
-int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
+noinline int bpf_fentry_test4(void *a, char b, int c, u64 d)
 {
 	return (long)a + b + c + d;
 }
 
-int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
+noinline int bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
 {
 	return a + (long)b + c + d + e;
 }
 
-int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
+noinline int bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
 {
 	return a + (long)b + c + d + (long)e + f;
 }
@@ -553,13 +553,13 @@ struct bpf_fentry_test_t {
 	struct bpf_fentry_test_t *a;
 };
 
-int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
+noinline int bpf_fentry_test7(struct bpf_fentry_test_t *arg)
 {
-	asm volatile ("": "+r"(arg));
+	asm volatile ("" : "+r"(arg));
 	return (long)arg;
 }
 
-int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
+noinline int bpf_fentry_test8(struct bpf_fentry_test_t *arg)
 {
 	return (long)arg->a;
 }
@@ -569,12 +569,12 @@ __bpf_kfunc u32 bpf_fentry_test9(u32 *a)
 	return *a;
 }
 
-int noinline bpf_fentry_test10(const void *a)
+noinline int bpf_fentry_test10(const void *a)
 {
 	return (long)a;
 }
 
-void noinline bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
+noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
 
@@ -598,7 +598,7 @@ __bpf_kfunc int bpf_modify_return_test_tp(int nonce)
 	return nonce;
 }
 
-int noinline bpf_fentry_shadow_test(int a)
+noinline int bpf_fentry_shadow_test(int a)
 {
 	return a + 1;
 }
-- 
2.25.1


