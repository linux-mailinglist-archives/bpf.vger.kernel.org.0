Return-Path: <bpf+bounces-26334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97689E6E8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A6283E81
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FBE38D;
	Wed, 10 Apr 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JJ9fs9DU"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CA19F;
	Wed, 10 Apr 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709196; cv=none; b=IzL5oNua90ZBnsDd/WpqyqKO5euyN9D57Tgf8wlFvVagNehpyDJINW/zBBrehnSPhTCKUJwewRHKlTg1LOX+6efxYQ6TVzgvvvt65iu9qBlpSIFEQXLh6FmGtj+joFBb81rRATwDkuTMDjfH9z7JSZQ3j2sEOqAdkHI14BEGs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709196; c=relaxed/simple;
	bh=7B3abChn6QeywU4/KUOFAabRB16trDidpC3z9pyRZA0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gqko8LFB3XxizZM06sQAGLnisKdL4jfJ5zmLHiV931lTru09njNQ/MjubJERemGDTkZg6QYm5gqZhl+RovX3jvF/VUZriF5hAG7KyjinvqdlZbGltvti6ySpwv0fH97O2/EAJ/K5D7PMSeisQtaqPfvsqDCMU1vosMQbvpiBixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JJ9fs9DU; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712709191; bh=u0Mv4a49i+HjEHT0FFM4iQe2j30d3IX7Cki+XJXwmi4=;
	h=From:To:Cc:Subject:Date;
	b=JJ9fs9DUjalxgP6hoYOQJJ9Yls5P56D1c+QeQd7/oX5wL1g9HDK2tHLz4G6TOuqD+
	 /ui0OMkr2iFrCllzInGDWXZMgFFesmaW43d0YLvJ4Xg3auahw2anUwy9rF7ui5/6ih
	 Zrv3K2JXmFGiBHij2tfJmPrgilma/+qwksthERK0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 8473001E; Wed, 10 Apr 2024 08:33:07 +0800
X-QQ-mid: xmsmtpt1712709187tvku4af5a
Message-ID: <tencent_EC72CD3879FA6F102FC56E4495F0E822EC0A@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrMCJcWeDKI4Sr1b2eFxV1E7SSje18Q6CWk3Gxh2SfhZ9PSxAA7S
	 UkgZ27DzHwI/c9SWJX4xTYSlvQ9E2qIXUwE+/AlR2a02H9Gjl77/l/258nwyq5TMUpeadvHU9ywc
	 JBmKWDKzVDrCdLj9/MKGN7m8NJvkca9mFFSCuutDjDdrMvgtLEwSWSklPg5eZRmRC5u+Btt6GiPq
	 8T9xFnp86QRPjfmm5L+kVy7LNLLr8UpcvTjogzZXXHcGhk1GPlTb4LWp7s5NODWYZX2oysh2UiDO
	 P92iFOP6dHBxjtKGYiregsMZssZJZK4e03LOALSgptxd38xWCXGnciRzMRHYzPF0XIROz5Dt9okZ
	 gAS+wN33i6FydwdQErurCXjNnw8SvGnHyZhY6TUyWjQnnhyDdyPhuqoA00W61YS7O3Iy2jbWOVlE
	 aMIoqKRJM1Mq0yczEifyso0Q8K52YXRnG8dDrPXi1suyGH6LEH3garxNrSuLrDSes8+uqpMRgb3E
	 RC5zhGknEmV/yvLYnvDFpcl0TVx/xYbpJPq46GqyKgp5BlaEkcTePYBS3htQ/KocbSV6icVNPGUF
	 zxaL3MHcH9WcO60VnnCDwygsesh3515McMSBH+HwzfcJT/DJMt+l5NpEyC/EEOf/9F3XP2X6Dn6k
	 pI8PJTUE15+19o9dNxbkm+wvH0c22e4KrYWFXGrJ/sIPnLN18GuXxsMy5QkXJYms80lFVxjnuT0I
	 //7YldQYlPhYkbEziT7orMyGgnp2wSPbVYRh7D7KQ9zia67bWCYqhpwDpCME3ZS2Jc7D4BLf6hp5
	 eTGztIGLFukdlI2VlQqqoM+KIKbQuF1NW/5VrZk4P01jm6qbFEJ1PyvRPqtYE/qZ354G3UmLvqJV
	 MciLrqZ0X3fAvN5O+eQhRsr54MVQrC93f1+EPlTSeuBywbv6Alwwga4KHgsS/r7RaJURcInCZG70
	 I5JQRaET0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: strnchr not suitable for getting NUL-terminator
Date: Wed, 10 Apr 2024 08:33:08 +0800
X-OQ-MSGID: <20240410003307.181290-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strnchr() is not suitable for obtaining the end of a string with a length
exceeding 1 and ending with a NUL character.

Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 449b9a5d3fe3..07490eba24fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
-	fmt_end = strnchr(fmt, fmt_size, 0);
+	fmt_end = strnchrnul(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
-- 
2.43.0


