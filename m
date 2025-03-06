Return-Path: <bpf+bounces-53454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1FA541EE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D16C7A7417
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 05:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2019D891;
	Thu,  6 Mar 2025 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="tBPd+AZy"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD319CC3A;
	Thu,  6 Mar 2025 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237738; cv=none; b=TLDHaDCdtVzO/IzC0YxZ+3eDbaPG8UuLR99pabONiDX7IT2mZWIMZf5tRqlnN3ksDhTx/3IVEMrDwnkdO0xU5vahoVx6YMEJlDeXrR+Fbtd2oGnMqGYq6t5mXsjoTUmQobCsNzXuPFAnfjUyWBKawyCtvegODg0ByxXP97eY+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237738; c=relaxed/simple;
	bh=r4cqq92u4QrOP26bPzQzQ44NQlShBXBS0KDKN4ZO3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKJW+AAadzgKDn3bnulHoIcucNe0GjEXLEKXKP8a9pfxUMtFMUl7DNdbqJr96MsoRylftaYsWcttLUNXZy+GBJWmDCAXXehn3JtsJiCaP0RTcv+vYabHP1aKaqrFslD/qhHrKsoChH1LFDQxEJMUvmhqfOgzzJALfjLH7A0S8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=tBPd+AZy; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741237663;
	bh=gXGZGJxxTGiGEquhpVC2RxsSuokp9eU5juqlOjiyPCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tBPd+AZy769/Tgtp3Ygvvq16i/fcX4cALb17vjbjcp6WO/1wxCa9uLkEzG405jlkp
	 ecn2MemzkdYlm5XRlCPQ9NYO87QHjqiEr3u3l05iiSokNg9yFJtliBipkn51O8bvCp
	 i4prHl49KT1Y7ebdDDGcK85twKwAy8RFdPczVJzI=
X-QQ-mid: bizesmtp88t1741237654ti749i3s
X-QQ-Originating-IP: eUplNXEW/+zR+b+IrjvomDkK5HrJhM4U3n06ZpEZ/So=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Mar 2025 13:07:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6009695757988680814
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Sasha Levin <sashal@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Thu,  6 Mar 2025 13:06:58 +0800
Message-ID: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: M+0YV038q5N1MIWhZIbdnp8w8lLWqZ5KrdpfI4F458ZrmhoYwgAnQbOR
	PKEJFC7xq+KJJWoWfmJn5KEmihDSWO4461R0WBwXI6lp0ZYwr7YfXFI+sKqzLY2Hhx2ysxo
	s0U1sqYsoK5iP3rRCxCrQRqUJN7iMUOavKLtxvFUQRA3qJ0xt/1RhhsIN1CNCYLOxgdXL2E
	hdtr4yda9Fa9ATI0rxojhEOXVp0V1G3ViukYllNhPkn3up9uctLoH4Ww08+27CYqpKrMO9M
	R+MSr4ZYe0Ay3Df1cJftMJYkyBty556aCPUk3+bpvISWLmDVejfENm0Q7OnueEUDy/ic8cH
	7JM2L+flfdiq/t4L5s9zanCuHLdK+hIJVQguWGQQo+MpksFJQpEf5oK6Pru6yTwgn+iF2qk
	XUpZUyJOgzJ+fuw7y6xvKQrxzZivR9GKlbyuMf9evMG7dEILFafuseprhWMqSVvwERj92vA
	MAA20dQbENRhN9YyV7xEWI0ejQ3IOHIsX61/x89PNDPMVj7OpPmdXcrne+Y5N9+yluoOAfQ
	mHEbxyxH2nyO3vNp9GVye+SKtdpIS6bt6qDPKIsJenBBF2FE9XRFLrA5Ryiz6D+3qbgl+W3
	1pBk4AUPaGMqXeKOtrdNXCKNpt+Wa0L8MJWcyr3hpzwexP0ambFf/mwmPsmr3NBdGTqqvL5
	MUltjNyuRGCmoaf2XlJtunU0a2423vWcwdEN66peBQLorfK3ShXvdn2AUX3MaJq0FXAyz7Z
	O8m7pzY/nDhnfErgJ1rqiemY7b+5jt31WY8eZfnZXmGz7MGYv+r09JN9kOoBCSPPJjcnPNr
	+hJuy6ACsicbM6mrRmN91AoDAzEFdNXck7C1nteCan/2rCMa7c73+A9kEuk4J3ucmzRABQ7
	dUu8EzNl3/QpT93ki5Nk4RPM/iSqH2lK9TSyvUpxgpbE7D1lHw4zngze14dptgiMDFxXNW/
	JsmZrazv99ykv38mZRhrBqrcAHt15XvqhSjO9iXYigB/qFA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
Handle memfd_secret() files in build_id_parse()") to address an issue
where accessing secret memfd contents through build_id_parse() would
trigger faults.

Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

This repro will cause BUG: unable to handle kernel paging request in
build_id_parse in 5.15/6.1/6.6.

Some other discussions can be found in [1].

  [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u

Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---
 lib/buildid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..b78d119ed1f7 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+		return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


