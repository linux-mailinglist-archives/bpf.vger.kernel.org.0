Return-Path: <bpf+bounces-29918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3A8C81E0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C69E1C21203
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BADC17BD5;
	Fri, 17 May 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiATHhCx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379A20312
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932628; cv=none; b=HE4eQPhJkHt6BmYdX9Hin4be28uF6BMda4ucT+UVf5wsrdIv4YSahlYexp6YUUa4Z9aFzNXPvBNXo23X3QDgOOWIk7EgCMnnni7R+R7cQjAuiN76/tWlCi7CoQcXvqNleFaSoNMk4OAeaaKb1JzTK5PZClnQorZHNQ+z/nCLuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932628; c=relaxed/simple;
	bh=9avGdIlGtkZAGVzBwd2BMqnvGgEnWpUrqWA8fO7+YJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ks1ah8OJzhp5aKtOsjkBW3FfsyeOuqkk5mu/dX75iexPTsEy+t43RIiKuym0DbUTwEHUms9kh3y2+2i6u8XdIxQ7vRw5o8K+l+RzOO2amCWiX5GCSztln6MldSK6Vxu0TG3DAnM6ApFxw5Xa+5fOHTddDrpLQh7ly5fpupPa7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiATHhCx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z28RdGIa/jW2W1Epz9g0bmIp4vT2NvFeG3FHmL5nW28=;
	b=FiATHhCxa6kE5FKqUIOhisCyZavQpFjv+y7w3QT+3uL15Uxiq4n4uiNeIbdPXwhQqNAU8U
	j/xH+CQCDnMpjIY/WjISNjjDELUUx8V+loDFnBYsKmXlEZhL8Ci2A0KDxxaOlAA/lL8Sg0
	HZV2XGUudiSjDawSANHW/eOi5e+j+7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-QBvbkxxENZiprvS6x8DnGQ-1; Fri, 17 May 2024 03:56:57 -0400
X-MC-Unique: QBvbkxxENZiprvS6x8DnGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D06F101A525;
	Fri, 17 May 2024 07:56:57 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52D6F51BF;
	Fri, 17 May 2024 07:56:55 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 0/5] powerpc64/bpf: jit support for cpuv4 instructions
Date: Fri, 17 May 2024 09:56:45 +0200
Message-ID: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add support for recently added cpuv4 instructions fixing test_bpf module
failures. This is mostly based on 8ecf3c1dab1c6 (powerpc/bpf/32: Fix
failing test_bpf tests, 2024-03-05)

Artem Savkov (5):
  powerpc64/bpf: jit support for 32bit offset jmp instruction
  powerpc64/bpf: jit support for unconditional byte swap
  powerpc64/bpf: jit support for sign extended load
  powerpc64/bpf: jit support for sign extended mov
  powerpc64/bpf: jit support for signed division and modulo

 arch/powerpc/include/asm/ppc-opcode.h |   2 +
 arch/powerpc/net/bpf_jit_comp64.c     | 118 +++++++++++++++++++-------
 2 files changed, 90 insertions(+), 30 deletions(-)

--
2.45.0


