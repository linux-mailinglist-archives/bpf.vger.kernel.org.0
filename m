Return-Path: <bpf+bounces-22343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4585C6AB
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762291F22DC5
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A09151CD0;
	Tue, 20 Feb 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIcjLfbS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1448151CD6
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463030; cv=none; b=gSEGG4M27lmp5xmgaH3Y6OCdlPyU0Rq5uF8MKbTFJPnn5eyQKt92wQydlcc4CwIuOFWo35zTI33lmt1Tw8TDDJY0vQ5Ut2ISiqGfpdHGrDwB4imzP12plwMMwzsLO8C21aYyai9dX7SOET3QsSQe3k0QqrNmG/AC6zfMpeLNdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463030; c=relaxed/simple;
	bh=yAN3xT8EUV0i2CJy6NqtWV8aa+YkCcxRteYAC+EhA2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSAZW/F5/8FJq0b6xadj3Z6ujNOI8UddC4R/HHlSpuj1iK8v11S9/18CIhDq5xs4i0z1VyOwFV1sVHhFZAoP8XGb2Ok5cogDLo4Ncd/ByeX5fwXTxZiwm4EIMh6JFI6AiQTHI/Ru0zMbL9U69VNja9EmdPCEu07CSsKaR4hV2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIcjLfbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HblB1EygQYmfDjQn4iPYkDY89+D2ws9zXge3PbtSVKM=;
	b=DIcjLfbSG1JMpU5AJhrejhxUgLTbm3uIBEpPmEGYG1zcQVyhAZqYNQ/LDhBWBUYgLmPspK
	2SgB/zBDj7Ev2XToJ3jQPOyrXWYoOACWGL34f2tGxIW+yRuBTVBJH584QVTmnnysWxzuRf
	/f4LxzUgkeB3iPXWlYUQOC+qvO/3mpA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-xhnUeGppPW-aaQttQNKQXA-1; Tue, 20 Feb 2024 16:03:46 -0500
X-MC-Unique: xhnUeGppPW-aaQttQNKQXA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a30f9374db7so706527866b.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 13:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463025; x=1709067825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HblB1EygQYmfDjQn4iPYkDY89+D2ws9zXge3PbtSVKM=;
        b=oSIhK/Js08bhP1Qg0ixpU8H8DfvFx/yBLMKMxiEWqZpw+ZSZn9yT3CE5JsY7fq/zSP
         STg8G2VLpVTNftJo5rW7on2ZZEJedAEHgve56Gg/iW4RadSrLq0wHTMSeY/Nbioy4Bha
         HmC2vuVk0BhchU+cGLiTuvYnctsVCI/1yrie8nNESPrqIG1CDBho1AxFEDgMcABR4Tdp
         yVm3pKfnxtDnUrF/gobKo+2leCMDW2hjJIhnNie6tQzUGnQpOFB4tVADBDUZjud+fKHK
         BDn/GYxANR9yAsqwu30WuVV4blsOoZhRYPG4/PEWlHwdJE+M86QbfC7QXC5gYTLgoal+
         hT3g==
X-Forwarded-Encrypted: i=1; AJvYcCVNbM4lxC7T+ASuZRXmK+IrDBOg3z1ycbYJMw9IDt+Xs99D66KzlePu3ksMei9vCqCIJr7ySDE3IiAndactBgFb5wjg
X-Gm-Message-State: AOJu0Yzo5AA/GQYlzWfPURtLs3dA1SZ1E4F2H6H7CnKChWFFu4YsUFbC
	0SWIx8dKGKciSW6gUZ4PHyQiuz74/+zP/r17PgjCKgUem/J8lSS/moEbIFJKx+WXBUjeHZ1Km+E
	i03JAe9B1tq0o4zqLIRC0Tk6oLif44R0uaTQ/ThDLq5t3D5JHtw==
X-Received: by 2002:a17:906:55cb:b0:a3e:c1ef:e1bd with SMTP id z11-20020a17090655cb00b00a3ec1efe1bdmr5405404ejp.16.1708463025095;
        Tue, 20 Feb 2024 13:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgY95QbMUU0W/c1OW5idiuPM81C8CWORiKLmjeUIN4cqSY7c62j8zMAVZY0yACe7u0MSZG+A==
X-Received: by 2002:a17:906:55cb:b0:a3e:c1ef:e1bd with SMTP id z11-20020a17090655cb00b00a3ec1efe1bdmr5405384ejp.16.1708463024774;
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bk10-20020a170906b0ca00b00a3ca744438csm4296469ejb.213.2024.02.20.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1BC1710F63EE; Tue, 20 Feb 2024 22:03:44 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: Register system page pool as an XDP memory model
Date: Tue, 20 Feb 2024 22:03:38 +0100
Message-ID: <20240220210342.40267-2-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220210342.40267-1-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To make the system page pool usable as a source for allocating XDP
frames, we need to register it with xdp_reg_mem_model(), so that page
return works correctly. This is done in preparation for using the system
page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
reason, make the per-cpu variable non-static so we can access it from
the test_run code as well.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c541550b0e6e..e1dfdf0c4075 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3345,6 +3345,7 @@ static inline void input_queue_tail_incr_save(struct softnet_data *sd,
 }
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DECLARE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 static inline int dev_recursion_level(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index d8dd293a7a27..cdb916a647e7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -428,7 +428,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 #ifdef CONFIG_LOCKDEP
 /*
@@ -11739,12 +11739,20 @@ static int net_page_pool_create(int cpuid)
 		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
 		.nid = NUMA_NO_NODE,
 	};
+	struct xdp_mem_info info;
 	struct page_pool *pp_ptr;
+	int err;
 
 	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
 	if (IS_ERR(pp_ptr))
 		return -ENOMEM;
 
+	err = xdp_reg_mem_model(&info, MEM_TYPE_PAGE_POOL, pp_ptr);
+	if (err) {
+		page_pool_destroy(pp_ptr);
+		return err;
+	}
+
 	per_cpu(system_page_pool, cpuid) = pp_ptr;
 #endif
 	return 0;
@@ -11834,12 +11842,15 @@ static int __init net_dev_init(void)
 out:
 	if (rc < 0) {
 		for_each_possible_cpu(i) {
+			struct xdp_mem_info mem = { .type = MEM_TYPE_PAGE_POOL };
 			struct page_pool *pp_ptr;
 
 			pp_ptr = per_cpu(system_page_pool, i);
 			if (!pp_ptr)
 				continue;
 
+			mem.id = pp_ptr->xdp_mem_id;
+			xdp_unreg_mem_model(&mem);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.43.0


