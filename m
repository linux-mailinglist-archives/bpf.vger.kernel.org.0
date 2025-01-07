Return-Path: <bpf+bounces-48063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA78A03A8B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C248A188689A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9571E2615;
	Tue,  7 Jan 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CCAuGnVd"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CB15A86B;
	Tue,  7 Jan 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240616; cv=none; b=PcZeXI6Q3l7yZrf0EXwx/Rs2PhTZBnejN1ntjM7N6CC06lAlqGe6IIRZXbzLSTgBMsW5AwWYhbbnYJiixWwZTD5blYX0xQ8MjT9TD75MfmKZBDWk3XzSQ4Z82S4WNZtokwA8phG8o1TBF5QQW5rCbzgRdLe4hnpEqX+3kbK5Dpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240616; c=relaxed/simple;
	bh=Jk4yHLdBzhFjqVzD6NZ21sO6ZgwqnqoTflx+Wbr6xF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z48IDnGJJLEKu9TKgqlMJOQW1YagnE7uAtmZgnIbmKcbaGe534AE/MXkmo7QnUTGzidKY2Mir076DNMVcEQuRi/Rtld5ajy5ohBtQVCIvLk0PE7YbJDwtoQ7hSExq+3ucHwMfbDICFk+JrUPERPWd+fi7XygKC+n0rdHIdM2lCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CCAuGnVd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3n0fs
	75YyMNlTN3XLn4DxbuyJmmVOF3xYiJjL2ij3go=; b=CCAuGnVdfC8KIBM6QDXEn
	XiFDKPR7sSGqu29yfUJbwhHElmyxGpQxvlgL2WSRcH5yVqFFZaSuw8lj9/ez1rn2
	BH+qxGiILToFl0QQ5eUecHaFcG0gNaw1qJW/DTeFY+PnUHnmnnfoqA/+2Vsf860K
	l33raU3kk0LTUbwJkcdO7U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X+Kn7Xxndcz5EA--.21967S2;
	Tue, 07 Jan 2025 17:02:32 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Replace (arg_type & MEM_RDONLY) with type_is_rdonly_mem
Date: Tue,  7 Jan 2025 17:02:22 +0800
Message-Id: <20250107090222.310778-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+Kn7Xxndcz5EA--.21967S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47Zw1UuF47Ar4fZFy8AFb_yoW8WFWrpr
	48GrWvqFs5tFW7WFs7CF4rZr15J3yrK3yfCry8Z348tF95Xr1kXr4F9r15XF9YkF4xt3yF
	kw1YqrWYq347CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf5rxUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgzNeGd85zuYdQABsQ

From: Feng Yang <yangfeng@kylinos.cn>

The existing 'type_is_rdonly_mem' function is more formal in linux source

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca03..d1b6b587a146 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7779,7 +7779,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
 	} else /* MEM_RDONLY and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
-		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
+		if (reg->type == CONST_PTR_TO_DYNPTR && !type_is_rdonly_mem(arg_type)) {
 			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
 			return -EINVAL;
 		}
@@ -8324,7 +8324,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
-	if (arg_type & MEM_RDONLY)
+	if (type_is_rdonly_mem(arg_type))
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
@@ -8356,7 +8356,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		return 0;
 
 	if (compatible == &mem_types) {
-		if (!(arg_type & MEM_RDONLY)) {
+		if (!type_is_rdonly_mem(arg_type)) {
 			verbose(env,
 				"%s() may write into memory pointed by R%d type=%s\n",
 				func_id_name(meta->func_id),
-- 
2.27.0


