Return-Path: <bpf+bounces-61287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B8AE455B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11AA188C339
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1580253938;
	Mon, 23 Jun 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N02kKVIF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA424BBF0
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686511; cv=none; b=brIzdYNdDLeydvGE1q+VpVNHMvZAqfNN3jtH3tMeW3oPoN0oVne1k4Z7SFZJQmgvfwRrEtoDXYbHa5ZOQ0CShnQG6h1iH08vRY7J2bo4chwt2MOE80YRC1dp6RtlS5Sle/p0AjPpg5Ih2R2ZTzBH3965ihQ7/Ss2PhihYPT+bEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686511; c=relaxed/simple;
	bh=r93OQAL+O+DGIdysH+atzMrXTR4OgqwgoeNHguqSrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVPskSHnpz40Pnw0FAlsPlfZSeDa2OqVhKYbsh4Cqj/228l/vPcEwomY7c8QHy7t/NJFHSmFzBSU4ih+dYNcUbX4fs5iekyhdhL3+njDtcMi5ucOgGwnyKX/qseWJd1cAb/HMNW5B/zfv38fhyAlcawjpUGjLJsHtBbSsa49Aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N02kKVIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq9GfmifFmUJTHzOzR3uh/CPBzOh0qHNI3h7c2rC8V0=;
	b=N02kKVIFpijLNd/9kISI7jug6XMvYsqBEMYCv5fvKs25DyV31wzEVS2Jhr71fMRxt/jj/o
	4+2oW1GmiR9O6Af5L+PQeDvGiWgaKBMSxIOrWtXLcRsGJlujY7BXjnkepoqidsz+DwkX9g
	nTCI6ho5R2bfrr+VUnW/E9IBCh6Q1/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-lFtrF3UyOrGpLeA1vjHQfA-1; Mon,
 23 Jun 2025 09:48:23 -0400
X-MC-Unique: lFtrF3UyOrGpLeA1vjHQfA-1
X-Mimecast-MFC-AGG-ID: lFtrF3UyOrGpLeA1vjHQfA_1750686501
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7482B195608F;
	Mon, 23 Jun 2025 13:48:21 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.33.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33E8D1803AFF;
	Mon, 23 Jun 2025 13:48:14 +0000 (UTC)
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
Subject: [PATCH bpf-next v7 1/4] uaccess: Define pagefault lock guard
Date: Mon, 23 Jun 2025 15:48:00 +0200
Message-ID: <8a01beb0b671923976f08297d81242bb2129881d.1750681829.git.vmalik@redhat.com>
In-Reply-To: <cover.1750681829.git.vmalik@redhat.com>
References: <cover.1750681829.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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


