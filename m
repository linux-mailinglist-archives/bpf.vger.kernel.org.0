Return-Path: <bpf+bounces-40340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1F986D9D
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 09:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE128355A
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9625A7B8;
	Thu, 26 Sep 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuTV96XX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC90158535
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335786; cv=none; b=l2lG0Vn2cl2b0KLBwWjz//QILQxwRydN//Hxs40BUuridfKzQK/TMNxPsJyKieloqBflSFIuM5dDDJEnVeKjiTrxnkj1UX1QVeujWrlb52z+OEsHuWATnFrs3tnxOLI3I90lDQBCmm88DjZ5fZhT8XonWZXBJQzjR49QCNRTqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335786; c=relaxed/simple;
	bh=zn5g9MIgcYykAgQHD4JnAjkhT2JLFn02nWKhaGowwZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1Bg7OZc5Ch69/onXwstn7Lczv6w70EYy9pnAKlCCELaZM1wWtOY/byU9GY0e5VaTYOxPNhTRgBhriWpHao15fwh/u/sTf2Cz+yNxSEymalidSru7iAhOam0rnxjBFv4LDeT/P71JjI/wlHplCnosDMQSxDvtpzlHhG8zmPOKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuTV96XX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727335784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wxk39PxFa4eU6wm/J3cZoDodEHV4SxvVyGkj7eE+68g=;
	b=VuTV96XXemjoOt/js+I49KcsGBMqj4a8ENGczrs8yUikeF8a7dOfCBO/qJKC2FbOvgHh6l
	Buijv33WzNCySEKbX+R0puKhg8zbTfVTc4d2jSalKrVAOJeCQUUdHnCXhhVHee/SR5Xm2l
	kFbIjO2l9Xg4KOhrTe9zhhnAkGVm610=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-tm_g7GtAMLquzquSYrpVDA-1; Thu,
 26 Sep 2024 03:29:41 -0400
X-MC-Unique: tm_g7GtAMLquzquSYrpVDA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B76651943CD9;
	Thu, 26 Sep 2024 07:29:39 +0000 (UTC)
Received: from vmalik-fedora.fit.vutbr.cz (unknown [10.45.225.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0EA1954B0E;
	Thu, 26 Sep 2024 07:29:35 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Add kfuncs for read-only string operations
Date: Thu, 26 Sep 2024 09:29:28 +0200
Message-ID: <cover.1727335530.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Kernel contains highly optimised implementation of traditional string
operations. Expose them as kfuncs to allow BPF programs leverage the
kernel implementation instead of needing to reimplement the operations.

These will be very helpful to bpftrace as it now needs to implement all
the string operations in LLVM IR.

v1 -> v2:
- use bpf_probe_read_kernel_str instead of bpf_probe_read_str in
  selftests as the latter cannot be used on some arches (s390x)

Viktor Malik (2):
  bpf: Add kfuncs for read-only string operations
  selftests/bpf: Add tests for string kfuncs

 kernel/bpf/helpers.c                          |  66 ++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  37 +++
 .../selftests/bpf/progs/test_string_kfuncs.c  | 215 ++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_string_kfuncs.c

-- 
2.46.0


