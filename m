Return-Path: <bpf+bounces-60923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003EADEDDD
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F158A7AADBB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6852E9EAA;
	Wed, 18 Jun 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QopLhHX7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB62E4252
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253570; cv=none; b=sx6kbpJmcvxIl8608S6POA5ev3ixLDe9UzhVbdJRrkKELunYDbdNO3CpZpdx+04t7mcfmeFgvHryDTXbnD/ADyj4YuNHyIZ3npqImxMJ4QOdNeLLtR4oN/LDmQ19B0iJoQcM0o2wC5efgIe/tUPuDPBFhrbleEvOuWA5/dehqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253570; c=relaxed/simple;
	bh=r93OQAL+O+DGIdysH+atzMrXTR4OgqwgoeNHguqSrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEOl4ieUxYN7aPsZtHo/0CgVcu5vhfreyrf8qDEPQSi5jOL2Dv7W0ByYtltW7/okBW8GXciGKzr3KUor6FyUAYLriEW+tbdibIutZR54l/wVfJoDLDvDHtjYlTnlN/bFpNFIXXHUQIVqaOqQt1Zgw9Txkj7jsE70FrsKG8Tc3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QopLhHX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750253568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq9GfmifFmUJTHzOzR3uh/CPBzOh0qHNI3h7c2rC8V0=;
	b=QopLhHX72ywRleACOZ4S0ZOiXz1dk1DMZ9sznEEFQtAkCgeAwof2h2mYV27i+V7hUGWnre
	qtn7gLXCqaT2mSmzL6p9E2ZUu12Q6j0r05qJUTX0LwteLezOfLYKGMPl+D3QCfG0x6O/N8
	nji5zg4QMJQ3jlffTaKu70opnL1WpLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-VQKlC20JN5yPRjuWVVJ0PQ-1; Wed,
 18 Jun 2025 09:32:43 -0400
X-MC-Unique: VQKlC20JN5yPRjuWVVJ0PQ-1
X-Mimecast-MFC-AGG-ID: VQKlC20JN5yPRjuWVVJ0PQ_1750253560
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3AE51956096;
	Wed, 18 Jun 2025 13:32:39 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55364195607A;
	Wed, 18 Jun 2025 13:32:34 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v5 1/4] uaccess: Define pagefault lock guard
Date: Wed, 18 Jun 2025 15:32:19 +0200
Message-ID: <c7bd30ae99c1ecd3cb4c62f384a88a536e0d0b9e.1750252029.git.vmalik@redhat.com>
In-Reply-To: <cover.1750252029.git.vmalik@redhat.com>
References: <cover.1750252029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Define a pagefault lock guard which allows to simplify functions that
need to disable page faults.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7c06f4795670..1beb5b395d81 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -296,6 +296,8 @@ static inline bool pagefault_disabled(void)
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
+DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())
+
 #ifndef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
 
 /**
-- 
2.49.0


