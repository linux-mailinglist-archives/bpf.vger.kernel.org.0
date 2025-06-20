Return-Path: <bpf+bounces-61163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D7AE1A48
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3C31BC4A91
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EF28A1FE;
	Fri, 20 Jun 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx1jrqaU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC825F984
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420377; cv=none; b=P6DdbyvVlCJuDNTydBqFqsydLs+/9khvAJuu0J06EEZRSWz2B9RXH+GSyr+fiEsa7DuWe7kzvqp2jEaMpp4WFgPz3mcSxD4bJFKTWe2j+c2MAUr+hYKglTAOoSOW96FbjZVqAfI9fQyrzHUVC9+q3UlU4tgZwIXuaL2Vq/7k59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420377; c=relaxed/simple;
	bh=r93OQAL+O+DGIdysH+atzMrXTR4OgqwgoeNHguqSrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtdMC2ihXnsJqLc/VvMG/MDLgH/+Tm8UojKHTNiE1eUTDlz4qIq6iMifqT3gj2/ayZW0l4lqyTbCIzXNgmn/TD4QwfuDp7GcdH8WR58o3QEE5hjBhTZdc9LQkPQ7+r2886/PoeMRr6f2j9E8SdR8BHBOeqSG5vIxCo+tewkabsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx1jrqaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750420374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq9GfmifFmUJTHzOzR3uh/CPBzOh0qHNI3h7c2rC8V0=;
	b=Kx1jrqaUuzTZtATqVabFz86ENmf4pWiLuilbQWMCAweHOQMjPqWH3GWR0NIOBU/WiiZ1cE
	ZiWysT76XRQxwzSvX4ud6EcqS2gbNYDEWDbKW/HSAyAaIuNkaa8FsetVnxRkApmZBjQpeC
	GUB4TdhT6Ez4SvX3/tdss6KjapyFGyE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-WccyDccqPoGEAKIJCbQdcw-1; Fri,
 20 Jun 2025 07:52:51 -0400
X-MC-Unique: WccyDccqPoGEAKIJCbQdcw-1
X-Mimecast-MFC-AGG-ID: WccyDccqPoGEAKIJCbQdcw_1750420369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0049195608E;
	Fri, 20 Jun 2025 11:52:48 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.34.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4791819560AB;
	Fri, 20 Jun 2025 11:52:43 +0000 (UTC)
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
Subject: [PATCH bpf-next v6 1/4] uaccess: Define pagefault lock guard
Date: Fri, 20 Jun 2025 13:52:28 +0200
Message-ID: <50ef2ee55009540d2e9bf434005b3324731c53ee.1750402154.git.vmalik@redhat.com>
In-Reply-To: <cover.1750402154.git.vmalik@redhat.com>
References: <cover.1750402154.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


