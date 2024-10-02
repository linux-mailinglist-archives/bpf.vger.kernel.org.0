Return-Path: <bpf+bounces-40738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC898CD1F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888A21C21AC4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA412FF70;
	Wed,  2 Oct 2024 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVLKlXY9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B2126BE5;
	Wed,  2 Oct 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850310; cv=none; b=Wchow5sjJTqAup1yX58yhcNQbNwk8JKjiP7lsep0zL1w15sl5nyWne9AKhCKIE3oR28jxwX10EuslGsFNF3fyRo350UzUWnq0luzDGQ78edbJov+Xbxc/+lyVuDNofAL8UqqY44rsEkXpLxbdbpj9pptNKw1aPXERX91gL44pUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850310; c=relaxed/simple;
	bh=CxzhPjjhwSG/Nan8D08Fjfj1sfEsKjnAW/3CCKodaCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUXxC+SaYaRXKikbVbAuFFiNhkw4ujzfwsg9vFuLuCbSvToWJORgYBoWi9pzKFicYO4TdDgebEKw2K2NB8CPriE2FqnCprDMwvR1aQzq1qN+BcrYkJEaW27/S/iiS8Sbp597B0fEQ2/PitwPvKN8SC4KdEV3hGdqJ4+7ZwrEsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVLKlXY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00D13C4CECE;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727850310;
	bh=CxzhPjjhwSG/Nan8D08Fjfj1sfEsKjnAW/3CCKodaCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NVLKlXY9QTsB8XUS2pwqq/oxI3TR52Y6HF5QWP0jgXeBUAPGUlNf7txmJg5SsIk93
	 FQcTghRZVsPVpAsV8zaUyidBZz+YSVm2i+1R2srYbW8pmAr9ftMsLXQXNE/ExgKEaA
	 1M5T3TOLFp6v8ddeyJ545Dk+kGXSOVyvigmA60e6DfFKrS1Z9HUKTiPFND6TmkwGrz
	 8KAhFm3GA9yzJrqKYq+8WZl76FA25L8/3wMM4t2u3no+BKUsN6iqY6o2ZH77PSsG26
	 cKjnE2EVOfYgfYG2h+XTL45MvCbQb6X7C/mq8waVDIF0qrjPT4feNKAYEoAMfX2WY3
	 gxq+qZXa0cHwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3932CF319B;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Wed, 02 Oct 2024 14:25:07 +0800
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: test linking with duplicate
 extern functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-libbpf-dup-extern-funcs-v4-2-560eb460ff90@hack3r.moe>
References: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
In-Reply-To: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=eZzHlRs/qzyTmhLjl1HP9TOQSbvTRsCUeiiuNq2bdvg=;
 b=kA0DAAoWWD+rQAXGUr4ByyZiAGb850TI71YPK2BMRwLyO0afbgs8EE5nBLBdrC2+CLLgYBfZo
 Ih1BAAWCgAdFiEEtMP8JmAvi7KkC5x3WD+rQAXGUr4FAmb850QACgkQWD+rQAXGUr5JigD9FHEU
 HTOhPt1Ytjv+bQsvzADTfJoBgAADvkzRu5RP7eEBAJtugW6Mg1bqPPjiQetdDE+0pfaigQlQVIe
 +jPILQ1IO
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

From: Eric Long <i@hack3r.moe>

Previously when multiple BPF object files referencing the same extern
function (usually kfunc) are statically linked using `bpftool gen
object`, libbpf tries to get the nonexistent size of BTF_KIND_FUNC_PROTO
and fails. This test ensures it is fixed.

Signed-off-by: Eric Long <i@hack3r.moe>
---
 tools/testing/selftests/bpf/progs/linked_funcs1.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/linked_funcs2.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index cc79dddac182c20da69a1a57fa39bc81004184f1..049a1f78de3f835e7658dde6f2d03161b6a5a07f 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -63,6 +63,8 @@ extern int set_output_val2(int x);
 /* here we'll force set_output_ctx2() to be __hidden in the final obj file */
 __hidden extern void set_output_ctx2(__u64 *ctx);
 
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
 SEC("?raw_tp/sys_enter")
 int BPF_PROG(handler1, struct pt_regs *regs, long id)
 {
@@ -86,4 +88,10 @@ int BPF_PROG(handler1, struct pt_regs *regs, long id)
 	return 0;
 }
 
+/* Generate BTF FUNC record and test linking with duplicate extern functions */
+void kfunc_gen1(void)
+{
+	bpf_cast_to_kern_ctx(0);
+}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index 942cc5526ddf02004bf82d1f72c74cfba6eaf486..96850759fd8d0074249bbf1f743aab08e20de0fc 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -63,6 +63,8 @@ extern int set_output_val1(int x);
 /* here we'll force set_output_ctx1() to be __hidden in the final obj file */
 __hidden extern void set_output_ctx1(__u64 *ctx);
 
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
 SEC("?raw_tp/sys_enter")
 int BPF_PROG(handler2, struct pt_regs *regs, long id)
 {
@@ -86,4 +88,10 @@ int BPF_PROG(handler2, struct pt_regs *regs, long id)
 	return 0;
 }
 
+/* Generate BTF FUNC record and test linking with duplicate extern functions */
+void kfunc_gen2(void)
+{
+	bpf_cast_to_kern_ctx(0);
+}
+
 char LICENSE[] SEC("license") = "GPL";

-- 
2.46.2



