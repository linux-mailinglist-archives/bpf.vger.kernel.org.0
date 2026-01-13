Return-Path: <bpf+bounces-78665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7FD16C4C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EEA3020CCB
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3536656A;
	Tue, 13 Jan 2026 06:10:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D487366DDA
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284637; cv=none; b=Ojh8Vfm5w7HjT7GCcBvustARTAIeRgp410q/5QgEzlSnKQKznqh+1QAyx0c64EZkLniSoxIWbNVYqLV5A1uTGe65ghMpk68OcxIg0BXiU1YpXCykNoMn50TNyRiwvKyKQQudyRVS4dExaoGRbGsf4OWb4t/AUPRe6NX1eIu3G6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284637; c=relaxed/simple;
	bh=zIqXCU23yyFgh6nxfs9EingDx5He8xEjte0JfRI+SiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBWnpYxY7TRVkQHZd7zkqVt7DN4IGPX4hWoqUFtXyJeIJJTJOP5vzppEiAzISYYJx/wRiZARJY1jtWQ3CC3FYuBQVZIXeg2Bx6abrV2XkvY0cWadkHqbbEPlsj9O9xUqZoezqxAriVRCMRqmE7ofdEkxAQxjkxg7iBQCbGmwA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7841A18C4C5FB; Mon, 12 Jan 2026 22:10:23 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
Date: Mon, 12 Jan 2026 22:10:23 -0800
Message-ID: <20260113061023.3798085-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113061018.3797051-1-yonghong.song@linux.dev>
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On arm64 with 64K page , I observed the following test failure:
  ...
  subtest_dmabuf_iter_check_lots_of_buffers:FAIL:total_bytes_read unexpec=
ted total_bytes_read:
      actual 4696 <=3D expected 65536
  #97/3    dmabuf_iter/lots_of_buffers:FAIL

With 4K page on x86, the total_bytes_read is 4593.
With 64K page on arm64, the total_byte_read is 4696.

In progs/dmabuf_iter.c, for each iteration, the output is
  BPF_SEQ_PRINTF(seq, "%lu\n%llu\n%s\n%s\n", inode, size, name, exporter)=
;

The only difference between 4K and 64K page is 'size' in
the above BPF_SEQ_PRINTF. The 4K page will output '4096' and
the 64K page will output '65536'. So the total_bytes_read with 64K page
is slighter greater than 4K page.

Adjusting the total_bytes_read from 65536 to 4096 fixed the issue.

Cc: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
index e442be9dde7e..fb2cea710db3 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -233,7 +233,7 @@ static void subtest_dmabuf_iter_check_lots_of_buffers=
(struct dmabuf_iter *skel)
 	while ((bytes_read =3D read(iter_fd, buf, sizeof(buf))) > 0)
 		total_bytes_read +=3D bytes_read;
=20
-	ASSERT_GT(total_bytes_read, getpagesize(), "total_bytes_read");
+	ASSERT_GT(total_bytes_read, 4096, "total_bytes_read");
=20
 	close(iter_fd);
 }
--=20
2.47.3


