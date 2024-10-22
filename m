Return-Path: <bpf+bounces-42798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18B9AB4F2
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D31F24657
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250B1BCA1B;
	Tue, 22 Oct 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBZTFKPU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC801A726D
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617836; cv=none; b=i+EC7YyDV+IFzmtqU7+SYNZvkhLYsPJcba9S3IfcKuxVVOKiiVon5o/n5pI30f9fwWrcdKPNtD907orEI/DiF2B5z9L+7oSsx8xXG5lFX2AJBfanSYBDsOjEoUyA694XSVtuGKYpMiAZz7gI2aFhZgYsMqQ0YoNAxjaDyf/3GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617836; c=relaxed/simple;
	bh=sY2vbTh/eZ9KnvBd5Lw6fPEODBWK6BLyWj3gbw/wgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJEAgPiHYny7Z3DF3XyTlEZrTTJSwAhdbNQ2aH8tInvrkcgXR1dhav4/FhFiZF/zKY9Gh9InlShJITgGcfE/OiE7b8SW08L39gsHQSglnASdSwuFp+i2lZM8uVYrRhJqHVwot390Cw06az5iwIihaadYaILlmwBKe9RpN9ub8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBZTFKPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729617833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cLZNgIcQoAI1N7/lb6Yy9l6fSFwjbIQtrNd/TiZvpeU=;
	b=NBZTFKPUqTzWTTDTZWGtk519Rfi5Ok3N3692U/SFjRIVeGmLrnhewz1Czw+iLkk4Oqp5/t
	Q9SDI+VWi1yRDRCtIgmnkhlO9Qt6oD8QShT99GGagadB962O6sU6PPOBuZm7Sb55TwOxMs
	hDLr2nkEKK2oqptReFvnrtX0tknjfX0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-INjmng9aPja70izeb94u2Q-1; Tue,
 22 Oct 2024 13:23:50 -0400
X-MC-Unique: INjmng9aPja70izeb94u2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F1661955EAA;
	Tue, 22 Oct 2024 17:23:47 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70E0E19560A2;
	Tue, 22 Oct 2024 17:23:42 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
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
	acme@redhat.com,
	vmalik@redhat.com,
	williams@redhat.com
Subject: [PATCH v2 0/3] Fix -Wmaybe-uninitialized warnings/errors
Date: Tue, 22 Oct 2024 19:23:26 +0200
Message-ID: <20241022172329.3871958-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello!

This v2 series initializes the variables 'set' and 'set8' in sets_patch to
NULL, along with the variables 'new_off' and 'pad_bits' and 'pad_type' in
btf_dump_emit_bit_padding to zero or NULL according to their types and the
variable 'o' in options__order to NULL to prevent compiler warnings/errors
which are observed when compiling with non-default compilation options, but
are not emitted by the compiler with the current default compilation
options.

- tools/bpf/resolve_btfids/main.c: Initialize the variables 'set' and
  'set8' in sets_patch to NULL.

- tools/lib/bpf/btf_dump.c: Initialize the variables 'new_off' and
  'pad_bits' and 'pad_type' in btf_dump_emit_bit_padding to zero/NULL

- tools/lib/subcmd/parse-options.c: Initialize the variable 'o' in
  options__order to NULL.
  Sam James mentioned that Michael Weiß had previously sent an alternative
  patch as
  https://lore.kernel.org/all/20240731085217.94928-1-michael.weiss@aisec.fraunhofer.de/

Tested on x86_64 with clang version 17.0.6 and gcc (GCC) 13.3.1.

  $ for c in gcc clang; do for o in fast g s z $(seq 0 3); do make -C \
  tools/bpf/resolve_btfids/ HOST_CC=${c} "HOSTCFLAGS=-O${o} -Wall" \
  clean all 2>&1 | tee ${c}-O${o}.out; done; done && \
  grep 'warning:\|error:' *.out

  [...]
  clang-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  clang-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
  clang-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
  clang-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
  clang-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
  clang-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
  gcc-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
  gcc-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
  gcc-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
  gcc-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
  gcc-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
  gcc-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]

The above warnings and/or errors are fixed. However, they are observed with
current default compilation options.

Updates since v1:

- Incorporate feedback from reviewers. Add a comment about an alternative
  patch for parse-options.c sent before (based on comments from Sam James.)
  Split in multiple patches creating this series and a typo was fixed
  "Initiazlide" -> "Initialize" (suggested by Viktor Malik). State more
  clearly that the -Wmaybe-uninitialized issues only happen when compiling
  with non-default compilation options (based on comments from Yonghong
  Song.)

Thanks,

Eder Zulian (3):
  resolve_btfids: Fix compiler warnings
  libbpf: Prevent compiler warnings/errors
  libsubcmd: Silence compiler warning

 tools/bpf/resolve_btfids/main.c  | 4 ++--
 tools/lib/bpf/btf_dump.c         | 4 ++--
 tools/lib/subcmd/parse-options.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.46.2


