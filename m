Return-Path: <bpf+bounces-58014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD0AB3A04
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E963BB4EA
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D31E5206;
	Mon, 12 May 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhPiKvUP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AA1E1E00
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058691; cv=none; b=nfxFfGueGF/apbLN9XY8O4VAOPOf91nxlggGb0CwKdt5DNjYYScUEqEZ63xOQI7VGqZFSd3x/cZpjsXXVnvw8oWOcndjuR08kwIRcXMKmiJbhZzC5ZS0FPNhdGXnI7oW4g28eZ1XoASQ396q9Y05eIBvuhLciYiB3W/gRaM9p6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058691; c=relaxed/simple;
	bh=Po7k8c3qBm3odvZShMeotojddER0OCvBoRlB1bNV0Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxS/2IDRaAuY/ecbm+3p0Zsot6vdT58f4BC+qrViCEQQTmkImrhtcBYDg3x5BOZj0aYnJPiVskv86xwLlOC/gllRpPRfhPYUr54o3Mmks6s8++ir85fGvOIInBH0veyvBb3jbtdl1zvwB4ZJ9J6y/UKVqPkEdDZqoa230DlBm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhPiKvUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747058688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JFfYQtOcXc0vsIYvzoAQnBQ76q0OnVknV7mRy+HxJX4=;
	b=XhPiKvUPPwekI/Vb6iR6OnFerl8cEmWpopRFe6OxrXNuarSgGw9F8Y0W6+JRamL5Cweycy
	rV61DZV9FURIYVGq2Zb7o6VMFypfHF+zbib0Vufs2IIIWnB0xvdx2PYugFFGlDl1ZLsKHj
	OkN9+1jrVsIBDoyBJRB+l3Ue8glwfQg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-j3DSDEU6O0eoMig7_NVl6Q-1; Mon,
 12 May 2025 10:04:45 -0400
X-MC-Unique: j3DSDEU6O0eoMig7_NVl6Q-1
X-Mimecast-MFC-AGG-ID: j3DSDEU6O0eoMig7_NVl6Q_1747058683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229F41955D7F;
	Mon, 12 May 2025 14:04:42 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.193])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEDF5180087C;
	Mon, 12 May 2025 14:04:37 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 0/2] Fix verifier test failures in verbose mode
Date: Mon, 12 May 2025 10:04:11 -0400
Message-ID: <cover.1747058195.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch series fixes two issues that cause false failures in the
BPF verifier test suite when run with verbose output (`-v`).

The following tests fail only when running the test_verifier in
verbose.

#458/p ld_dw: xor semi-random 64 bit imms, test 5 FAIL
#494/p precise: test 1 FAIL
#495/p precise: test 2 FAIL
#497/p precise: ST zero to stack insn is supported FAIL
#498/p precise: STX insn causing spi > allocated_stack FAIL
#501/p scale: scale test 1 FAIL
#502/p scale: scale test 2 FAIL

This leads to inconsistent results across verbose and
non-verbose runs.

Patch 1 addresses an issue where the verbose flag (`-v`) unintentionally
overrides the `opts.log_level`, leading to incorrect contents when checking
bpf_vlog in tests with `expected_ret == VERBOSE_ACCEPT`. This occurs when
running verbose with `-v` but not `-vv`

Patch 2 increases the size of the `bpf_vlog[]` buffer to prevent truncation
of large verifier logs, which was causing failures in several scale and
64-bit immediate tests.


Before patches:
./test_verifier | grep FAIL
Summary: 790 PASSED, 0 SKIPPED, 0 FAILED

./test_verifier -v | grep FAIL
#115/p BPF_ST_MEM stack imm sign FAIL
#458/p ld_dw: xor semi-random 64 bit imms, test 5 FAIL
#494/p precise: test 1 FAIL
#495/p precise: test 2 FAIL
#497/p precise: ST zero to stack insn is supported FAIL
#498/p precise: STX insn causing spi > allocated_stack FAIL
#501/p scale: scale test 1 FAIL
#502/p scale: scale test 2 FAIL
Summary: 782 PASSED, 0 SKIPPED, 8 FAILED

./test_verifier -vv | grep FAIL
#458/p ld_dw: xor semi-random 64 bit imms, test 5 FAIL
#501/p scale: scale test 1 FAIL
#502/p scale: scale test 2 FAIL
Summary: 787 PASSED, 0 SKIPPED, 3 FAILED

After patches:
./test_verifier -v | grep FAIL
Summary: 790 PASSED, 0 SKIPPED, 0 FAILED
./test_verifier -vv | grep FAIL
Summary: 790 PASSED, 0 SKIPPED, 0 FAILED

These fixes improve test reliability and ensure consistent behavior across
verbose and non-verbose runs.

Gregory Bell (2):
  selftests/bpf: test_verifier verbose causes erroneous failures
  selftests/bpf: test_verifier verbose log overflows

 tools/testing/selftests/bpf/test_verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.49.0


