Return-Path: <bpf+bounces-61643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A0AE95AB
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130B9169A4A
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472F2264B8;
	Thu, 26 Jun 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeIr12IW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97835219A8B
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918136; cv=none; b=o0SRbbjKRj/R4mNQ2JYaWtq0+/yytTcFAYcMUtWYW5mVH41eJHj/y2YDzNfmOtUQnPPJRgeX29CVPTtWFEs60s97/6T3/uhuP1BH5XjvcR2JZQkA2SdU9jvHNwonTHCmt9su1U8rIU6vzEVd5QJEnsXZuR4cD8dcDyMyJaNUlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918136; c=relaxed/simple;
	bh=r93OQAL+O+DGIdysH+atzMrXTR4OgqwgoeNHguqSrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+TzNlIoQX7O5qSXuYoKi+gVkZ5WjvKRSNQc7F+uVtKRHvdpAS9Wrk5D0I9t4fgZeXyxxvEszLV3pFXOfLV1qxtvMjQh5iSfixXLDTWj/aZUtSVDR2tt5wT3VZlRlVae7D5rWfQGKw8Nwm+/F/dJl0Xu1juvJHedB+eiE9HM45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeIr12IW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750918133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq9GfmifFmUJTHzOzR3uh/CPBzOh0qHNI3h7c2rC8V0=;
	b=XeIr12IWvyedwSuZ/MJ/ch9GHxF0B8r5irU2nP7I5+3xIF1WrMjovmv+M51/2MzsH2PkLS
	EquOQVz5wMsHoYhftAXx27LxFpmAFRIsCZmZp9Sj3OtFfSaB3wOZpcyH0V+CgwANHZQq4a
	OJJJPqTGoBwEKs+tyIUiy0cim9Zg0ns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-q8cV0XtkMoSL30qGC5mQog-1; Thu,
 26 Jun 2025 02:08:47 -0400
X-MC-Unique: q8cV0XtkMoSL30qGC5mQog-1
X-Mimecast-MFC-AGG-ID: q8cV0XtkMoSL30qGC5mQog_1750918125
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2C7E180120E;
	Thu, 26 Jun 2025 06:08:44 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E31D195607A;
	Thu, 26 Jun 2025 06:08:39 +0000 (UTC)
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
Subject: [PATCH bpf-next v8 1/4] uaccess: Define pagefault lock guard
Date: Thu, 26 Jun 2025 08:08:28 +0200
Message-ID: <8a01beb0b671923976f08297d81242bb2129881d.1750917800.git.vmalik@redhat.com>
In-Reply-To: <cover.1750917800.git.vmalik@redhat.com>
References: <cover.1750917800.git.vmalik@redhat.com>
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


