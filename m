Return-Path: <bpf+bounces-56479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CFA97D24
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C593BDC93
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF4264624;
	Wed, 23 Apr 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="A9uLzmLD"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503712627EC;
	Wed, 23 Apr 2025 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377653; cv=none; b=i99ujQUxLb98NnKXde2OD0TF/a9NSywie7LankKx8fZg8aCUlUEzBgsV9jx/bFmwC9232IbGLTbREkXtr0qCqQAivYsLY/TkPGaV0NJE1PFR51v7k2g+a0cxNCQUbA8aX3ggOeYitlwp1OHljWkGENL02kIrz59tFodVlDDRfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377653; c=relaxed/simple;
	bh=hA90ZuESohqk54ATH6Bc81QbVyOvEr18HVCgZ1JaJS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhsFN3jqIgSLnxuzZ2gGTHh6w22aXPt1oY7Rhjmm3Aqw+zYZqE6eyCxbFXimpJrk8/PImOCAxvRqFeWj4gxLPo3Isno5ZeTJB4h1uqNfffXyKK2xJSVJsMxmPdZqrVeYGzImSeDiE1IngF6k/+FWOPV9VqpOZgwJhdln5M0aPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=A9uLzmLD; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745377613;
	bh=YlbavwK4ijk6OQzwlNHVeqYb/SvZ1tfITRJFThEGh80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=A9uLzmLD+SLBSGe22+Gtf/RISftzJNC1lHj0l6vleVjV+CnxuDV41OCIB/Wp4GAjc
	 mXq/Do+SlI0iL1ZSFAyk2qJFqDEQXY2wxV/Crcmiqsizxiri1KLaXDp827ojpBcfPx
	 yPfLTk5OnrIqQidGwqzIP4Q/g29cPPaOQUIfSXUI=
X-QQ-mid: zesmtpip3t1745377600tadf8fc5c
X-QQ-Originating-IP: X5Aw6R2DDq/YO33JgpDlNDuCWKFjBcQ+z/6flHw0eNo=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Apr 2025 11:06:37 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16401725662011210989
EX-QQ-RecipientCnt: 24
From: WangYuli <wangyuli@uniontech.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	void@manifault.com,
	psreep@gmail.com,
	yhs@fb.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Subject: [PATCH] bpf, docs: iterator: Rectify non-standard line break
Date: Wed, 23 Apr 2025 11:06:32 +0800
Message-ID: <DB66473733449DB0+20250423030632.17626-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ORfZ13EUooM/eCcKeC1dM/vs289RsBJavTcKc7grA4nkbIYZZcJAimOk
	h7lvcr0fqTNfjE4ozS2J7oOBdgY6SImH6+jW0XyhoH+h8ttu9VjZBdrF/flT4OTc4M00nIE
	kUkBBWmaWt6NTTIO2rOf1v16m7mzLsE7Q6c44oEyvjIFVBRriAWdmMQAnzDjMk+t21PvZA1
	mBVdhumNXUW1/WuBiu04gjWuGbA2K3yAePwHvWybrbBcTONfsURE9i5+IImo/bzKzrvj3BW
	EBDJySRxWs1dQkoTP7WGYjEMj/EY+pHiGfpCRSeZ3LNe/dfE5FAeb81Hu3GSBG+i2xo1e2j
	G1IjBQiyKdfUb2NlbGFVhqYIdxiRadzyIpBEKrA2vSbP7SVJ6ErAkV21u1knsD1JR/n2kiz
	1Xz5HHaun0wOxHRK9sahxEjC+D19kwetV2rs4eGXK91Ocu7ToB4JG4m/uRd19Ok76Au7TGv
	DS3YXha3FoW61sg16rrmt6+7sEnPulu6GtZIsF7a4U2nUzDqQtodVXvlFTttUtUMttcMPRV
	qQFj5rGB8jUFI+PSWjBT6Gx1cW36oihAHoAoAwttNzlV6sEeWngM2t4FtAnubeAHmpQUVbK
	+9yiyvSsFbuVC2lhAuok15+o2fJIme7x/f8mRzTL1DIQZyLm6D5ZMdF0CTRrTjaWTPxnsvI
	4OIdFtuJO1dUT6OC6u8lxHQeNTQlJVa9LsCWNlStclxLsONNdKJ2R0qnB6yp2mvtsDkh853
	91IsB0Rc8C/MSCGtfW0WEfZpegwJK99KMeO2mIO2q73EV1RcWJEgmobgmaFECeCGzzSxyi+
	DIoFyenp4Y5S+QQ4asfYbLHd6OUP2DFRsoT/EFkWzb6vsnFTpawnMPx9BPmXoYkSwdgAylK
	UajsxPKCW+R1S9nyGQlE3CDmmywkquKPZ+9+OZt7psrCxoLVa/skr2QbVNk1Os/yNSRy8Ci
	C2nh2Sit3hj+SC1U8/zPLIHgN4BQ1rveo6TbxbpUaIbUPHuPuZDDLb7gRvQmP4yytvcVjz7
	K5PeqEChK7uHqDEsXsiccLMh+DP+U=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Even though the kernel's coding-style document does not explicitly
state this, we generally put a newline after the semicolon of every
C language statement to enhance code readability.

Adjust the placement of newlines to adhere to this convention.

Reported-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 Documentation/bpf/bpf_iterators.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 7f514cb6b052..385cd05aabf5 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -323,8 +323,8 @@ Now, in the userspace program, pass the pointer of struct to the
 
 ::
 
-  link = bpf_program__attach_iter(prog, &opts); iter_fd =
-  bpf_iter_create(bpf_link__fd(link));
+  link = bpf_program__attach_iter(prog, &opts);
+  iter_fd = bpf_iter_create(bpf_link__fd(link));
 
 If both *tid* and *pid* are zero, an iterator created from this struct
 ``bpf_iter_attach_opts`` will include every opened file of every task in the
-- 
2.49.0


