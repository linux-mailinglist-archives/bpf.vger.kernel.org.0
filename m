Return-Path: <bpf+bounces-35517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC493B390
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5621F21611
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA315B13C;
	Wed, 24 Jul 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b="eC/wP3yL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpIyncxJ"
X-Original-To: bpf@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAC158D80;
	Wed, 24 Jul 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834729; cv=none; b=fkdPw4q+PeG9/iake0F1p3BF8PsW2FV7e6BUZDN/1S3KFd2W55ytyBGs2S6edadQPrLwEA8ug03zSRkSye59U/GNBs0DR7xYf5066Ua9EZbmWz9R2ozNMKQfyd+QWHub8XVzbuH85XTW0czLVC5PJMMHLlMfYMtHcR+HJL7hH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834729; c=relaxed/simple;
	bh=vNHrnBEWg1YJQunikSK4RAbSuBUyZ6jILUpzKHGT/0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RPCVKTURyH/ZnB/LyvsP0IvdudLn7i2+K/0HMwTCM9CifCh41VpOEydu98a+nMyG9z/YxDXnUwslIx8QfB2Xkprx8aq4hZURjfmQrt8H9WbEF+0i5TtmwzpbMfzIeYs2c1n9DVSpgRoZnQvNsvbyb5hYPdm8j3VpeCpqG4JDTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me; spf=pass smtp.mailfrom=manjusaka.me; dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b=eC/wP3yL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpIyncxJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjusaka.me
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id CE04C13801A9;
	Wed, 24 Jul 2024 11:25:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jul 2024 11:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1721834725; x=1721921125; bh=hloJRQmMLUqOdGZV4/2VJ
	5R5bliTna/7+7hQr8WgZlc=; b=eC/wP3yLSZ8ZoiPf3vmaEmgYaIIY4DKqkq3gG
	cQcmA1+88dARVX/vKsO+2BlqrU4DqbgxQhs57QgJiogkK0zpqwnqfHnS/Zfqb4qw
	9ZU2kMI5KXoVOfu6wwsSCdImppPe7K1Vj6Qx0T4ADfaPrWZIvoyRinWksB7zt50K
	nsduVLTa6ynKEWOF8UfNa8lL4suRsvzj8EYgoKmYlvMv5bOf9GBO0UHL8VGMqhBS
	SQgrRxWOcmVaHlW6xPmt8AUAA+5SZqhG5IKVbbaw/sb9dtGLjN85RhdN7qv2SNE0
	RWHwGG1izsVCkE48EvPDituJx/5Bt5W4fQa1QPpDMlgKOLN8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721834725; x=1721921125; bh=hloJRQmMLUqOdGZV4/2VJ5R5bliT
	na/7+7hQr8WgZlc=; b=jpIyncxJtiDzYpJZqgIno5+y0sC4vrXlzpfvpo/Wbxrn
	PMs8wYpYIcqepdTm8UnubHP/LD8r/6vgCNhE84ZgW84cTfA3qclxDERv+fJSup1u
	PB7Dm9Tn6rEaHOIoXu+0uASZ6gVLLZP2Y//SddB51R+22OaCnxbjZjmXulZGMVkA
	Mw2lZeEYBLgEQFD6dMM8Ec1tujzZzVGSSOaQ5RTkTO+y+nH4M5MrfJgX8eKQtv8l
	M6Z2Q3GawB50G9nBUY09IpWEwKyvWnI+Lb8CX5wuatj8z/q05ptGz7G6Uc8T9h72
	rrlLSAvSWcBhW4W5C+Lv3SHKrWZBZmX0kcRvCYkC1A==
X-ME-Sender: <xms:5RyhZhCxQOBYyI7fAJZBvwOyLr0IJadTAGZyhNSg_VtxuDDkr-m2NA>
    <xme:5RyhZvjfVf2YdXBRaa3bm-eGCcTCwyHJsuqEAI-l61PUMpXHvZhAxFqeRSJ9RQ6jI
    _3UISCYH4yBjt29sNg>
X-ME-Received: <xmr:5RyhZsmEyYRaPFqmslrjbx31aFU24nDBBG4o6zJxSxpjXBvIDLNUhvDGzuBjim3AgFdArLNPnUQ7RKQFwwm84waFskndJS66lL_iB-y1xKp8wVbfiXey7bZ6iOtzPoxL3QVrXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghnjhhushgr
    khgruceomhgvsehmrghnjhhushgrkhgrrdhmvgeqnecuggftrfgrthhtvghrnhepkedvff
    fhgeffleejuddvvdejjedtiedtffefhfffhefhheettdeludeliefggffgnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmvgesmhgrnhhjuhhsrghkrgdrmhgvpdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:5RyhZryLSZP3zPZSw6IbpT3aBUSIZG5CYm3yYJuzLn6cE1LOdvR0Hw>
    <xmx:5RyhZmQrb9-X82nqXiTIb9NacYwCI7vU-TGk_-eQDp4w6toPiAkDaA>
    <xmx:5RyhZubtZzxsNAIehb1vignPlV1IItPkOcuwbYieRzUrpsnuUl5eEA>
    <xmx:5RyhZnSAok7gbKtVNDxaxS9teGrFP1rP5ZhkpfQBvKqldtnRiRgQDg>
    <xmx:5RyhZvDcQc4bPNwpzJw6ylvkDKbDl9lrIs8WT7OR3BxosxOSlih1nmX7>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 11:25:23 -0400 (EDT)
From: Manjusaka <me@manjusaka.me>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Manjusaka <me@manjusaka.me>,
	Leon Hwang <hffilwlqm@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Add bpf_check_attach_target_with_kernel_log method to output failure logs to kernel
Date: Wed, 24 Jul 2024 15:25:20 +0000
Message-Id: <20240724152521.20546-1-me@manjusaka.me>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attaching a freplace hook, failures can occur,
but currently, no output is provided to help developers diagnose the root cause.

This commit adds a new method, bpf_check_attach_target_with_kernel_log,
which outputs the verifier log to the kernel.
Developers can then use dmesg to obtain more detailed information about the failure.

For an example of eBPF code,
Link: https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace/main.go

Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Manjusaka <me@manjusaka.me>
---
 include/linux/bpf_verifier.h |  7 +++++++
 kernel/bpf/syscall.c         |  3 ++-
 kernel/bpf/trampoline.c      |  3 ++-
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6503c85b10a3..0ba119665410 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -830,11 +830,18 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
+int bpf_check_attach_target_with_kernel_log(const struct bpf_prog *prog,
+				const struct bpf_prog *tgt_prog,
+			    u32 btf_id,
+			    struct bpf_attach_target_info *tgt_info);
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
+
+
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0719192a3482..d6ae9e8c40b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target_with_kernel_log(prog, tgt_prog, btf_id,
 					      &tgt_info);
+
 		if (err)
 			goto out_unlock;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400..22dcc058e0d6 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -699,9 +699,10 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	u64 key;
 	int err;
 
-	err = bpf_check_attach_target(NULL, prog, NULL,
+	err = bpf_check_attach_target_with_kernel_log(prog, NULL,
 				      prog->aux->attach_btf_id,
 				      &tgt_info);
+
 	if (err)
 		return err;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cb5441ad75f..1d5dbbcac1bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21145,6 +21145,25 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+int bpf_check_attach_target_with_kernel_log(const struct bpf_prog *prog,
+				const struct bpf_prog *tgt_prog,
+			    u32 btf_id,
+			    struct bpf_attach_target_info *tgt_info)
+{
+	struct bpf_verifier_log *log;
+	int err;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
+	if (!log) {
+		err = -ENOMEM;
+		return err;
+	}
+	log->level = BPF_LOG_KERNEL;
+	err = bpf_check_attach_target(log, prog, tgt_prog, btf_id, tgt_info);
+	kfree(log);
+	return err;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
-- 
2.34.1


