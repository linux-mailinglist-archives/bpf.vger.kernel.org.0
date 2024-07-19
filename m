Return-Path: <bpf+bounces-35056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582E9374CE
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D551028249D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5074079;
	Fri, 19 Jul 2024 08:13:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623028683;
	Fri, 19 Jul 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376810; cv=none; b=tisc7PjcZZTZPVZxDgpJwhdE3fDHohByj3QN628l3tc4FLKrWEqDJU8Gw7Mt1xwaMc99hJgrbBtbiUY9LqBOBIGJ/89sia1ap0+6WC0AiTLne9X89KSygl+Yr9iVn91HoSjZXKxVTuwxipg23dpc2S7J5CbXiB/WUMTwFAcoZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376810; c=relaxed/simple;
	bh=uNQ1z8kkfsI805d3NoXouSjAKTFZvbv6hUGSX4Zh/5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAq5RDiQo1Mja4OjjFF+il49conk5sj8hXkoCY+ByMiQ7Qqbr1EyHEdhknLI441FCp/32+2axALZPskZTRJbL+ZFV/J19xZKubLBM/o/BekBhNyjfE1jmE3++qDziBxgg5lVH2UdCRFzJxIbjaNlNrjJMrutjmxf8OM4sAEk1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQMqr5PZVz4f3jsG;
	Fri, 19 Jul 2024 16:13:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E227A1A016E;
	Fri, 19 Jul 2024 16:13:24 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S3;
	Fri, 19 Jul 2024 16:13:24 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v1 1/9] bpf, lsm: Add disabled BPF LSM hook list
Date: Fri, 19 Jul 2024 16:17:41 +0800
Message-Id: <20240719081749.769748-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719081749.769748-1-xukuohai@huaweicloud.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfWry7KF1fKF1DJF45Awb_yoW8tw4kpa
	1fJryYkw1rZw4a93W3tFs5ur98tr1FganFkrnrXw12kr48Zr1kJw1jyrnrury3WryUJrna
	grZF9F1Ygr12vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add a disabled hooks list for BPF LSM. progs being attached to the
listed hooks will be rejected by the verifier.

Suggested-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/bpf_lsm.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 08a338e1f231..1f596ad6257c 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -36,6 +36,24 @@ BTF_SET_START(bpf_lsm_hooks)
 #undef LSM_HOOK
 BTF_SET_END(bpf_lsm_hooks)
 
+BTF_SET_START(bpf_lsm_disabled_hooks)
+BTF_ID(func, bpf_lsm_vm_enough_memory)
+BTF_ID(func, bpf_lsm_inode_need_killpriv)
+BTF_ID(func, bpf_lsm_inode_getsecurity)
+BTF_ID(func, bpf_lsm_inode_listsecurity)
+BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
+BTF_ID(func, bpf_lsm_getselfattr)
+BTF_ID(func, bpf_lsm_getprocattr)
+BTF_ID(func, bpf_lsm_setprocattr)
+#ifdef CONFIG_KEYS
+BTF_ID(func, bpf_lsm_key_getsecurity)
+#endif
+#ifdef CONFIG_AUDIT
+BTF_ID(func, bpf_lsm_audit_rule_match)
+#endif
+BTF_ID(func, bpf_lsm_ismaclabel)
+BTF_SET_END(bpf_lsm_disabled_hooks)
+
 /* List of LSM hooks that should operate on 'current' cgroup regardless
  * of function signature.
  */
@@ -97,15 +115,24 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
 {
+	u32 btf_id = prog->aux->attach_btf_id;
+	const char *func_name = prog->aux->attach_func_name;
+
 	if (!prog->gpl_compatible) {
 		bpf_log(vlog,
 			"LSM programs must have a GPL compatible license\n");
 		return -EINVAL;
 	}
 
-	if (!btf_id_set_contains(&bpf_lsm_hooks, prog->aux->attach_btf_id)) {
+	if (btf_id_set_contains(&bpf_lsm_disabled_hooks, btf_id)) {
+		bpf_log(vlog, "attach_btf_id %u points to disabled hook %s\n",
+			btf_id, func_name);
+		return -EINVAL;
+	}
+
+	if (!btf_id_set_contains(&bpf_lsm_hooks, btf_id)) {
 		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
-			prog->aux->attach_btf_id, prog->aux->attach_func_name);
+			btf_id, func_name);
 		return -EINVAL;
 	}
 
-- 
2.30.2


