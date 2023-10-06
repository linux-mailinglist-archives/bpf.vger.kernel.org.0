Return-Path: <bpf+bounces-11582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C484A7BC1FF
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AE62820E6
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03755450F5;
	Fri,  6 Oct 2023 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f4rPY/lc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF0450D3
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B13BF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hFFPj11/eUigZF3tKi0fAcT7BstLfn6tyK9Sx07Oyiw=; b=f4rPY/lcHXFUvFSTF83xRsx6XB
	sHxnEsj/w88DB2LHY0uBThP67ozCStVnhoRyyx0QHpVA3nBEkIIpKG9iSfKGvBPtOPDnR4EP/a/eX
	GE6aXULId6TBfxFEclr04F+mPExi7qOtZIzs1Gy2FGtM1t5+MlVCMs585EUEh2xPeXy5P9EA7Z10R
	yYNbjRkY96FZCdmHYZChNX0sBTqOmq5XfbZ6CWE55p9EWRgJDNiw+tZEXaZze3WeDNXetvBQec3sB
	zDGPf8QdkDwa7de+dKaw6natAHmM6aM1vqk/zWclxsR96fyrbFvrEmd3mGzVN0+7zR5ysx1SRtpSf
	G3dPBqlg==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyP-0001k5-T2; Sat, 07 Oct 2023 00:07:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 3/7] bpf: Refuse unused attributes in bpf_prog_{attach,detach}
Date: Sat,  7 Oct 2023 00:06:51 +0200
Message-Id: <20231006220655.1653-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
References: <20231006220655.1653-1-daniel@iogearbox.net>
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

From: Lorenz Bauer <lmb@isovalent.com>

The recently added tcx attachment extended the BPF UAPI for attaching and
detaching by a couple of fields. Those fields are currently only supported
for tcx, other types like cgroups and flow dissector silently ignore the
new fields except for the new flags.

This is problematic once we extend bpf_mprog to older attachment types, since
it's hard to figure out whether the syscall really was successful if the
kernel silently ignores non-zero values.

Explicitly reject non-zero fields relevant to bpf_mprog for attachment types
which don't use the latter yet.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/syscall.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 453a43695a23..d77b2f8b9364 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3796,7 +3796,6 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 {
 	enum bpf_prog_type ptype;
 	struct bpf_prog *prog;
-	u32 mask;
 	int ret;
 
 	if (CHECK_ATTR(BPF_PROG_ATTACH))
@@ -3805,10 +3804,16 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	ptype = attach_type_to_prog_type(attr->attach_type);
 	if (ptype == BPF_PROG_TYPE_UNSPEC)
 		return -EINVAL;
-	mask = bpf_mprog_supported(ptype) ?
-	       BPF_F_ATTACH_MASK_MPROG : BPF_F_ATTACH_MASK_BASE;
-	if (attr->attach_flags & ~mask)
-		return -EINVAL;
+	if (bpf_mprog_supported(ptype)) {
+		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
+			return -EINVAL;
+	} else {
+		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
+			return -EINVAL;
+		if (attr->relative_fd ||
+		    attr->expected_revision)
+			return -EINVAL;
+	}
 
 	prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
 	if (IS_ERR(prog))
@@ -3878,6 +3883,10 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 			if (IS_ERR(prog))
 				return PTR_ERR(prog);
 		}
+	} else if (attr->attach_flags ||
+		   attr->relative_fd ||
+		   attr->expected_revision) {
+		return -EINVAL;
 	}
 
 	switch (ptype) {
-- 
2.34.1


