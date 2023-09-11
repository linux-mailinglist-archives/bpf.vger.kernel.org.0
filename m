Return-Path: <bpf+bounces-9638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720879A848
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733021C208C1
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597911700;
	Mon, 11 Sep 2023 13:28:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67210C153
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 13:28:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 097AF12A
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694438921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gtlVWNxpce0i0IglaRI+hudygK2Rn/UhTsEIHKPXY4I=;
	b=SMT2V7xcPxtCxlWIYaRdmytcJm97VTLxxzjbAwv8aNGhhBotshP+y+isb4rscrKXBmQd4M
	gJWdXhmJBMED5Q70G6fbkznz3ZbBy0iDJ5XItuSNFAfyqCQhJJ2moCGJz3VolAUuTCOerx
	cCa2ig9PpG4nkedzRLjpO+UYzTzI4xg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-gE90XCNiOGmWzYnMs7hvKg-1; Mon, 11 Sep 2023 09:28:39 -0400
X-MC-Unique: gE90XCNiOGmWzYnMs7hvKg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50081b0dba6so4653787e87.0
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 06:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438918; x=1695043718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtlVWNxpce0i0IglaRI+hudygK2Rn/UhTsEIHKPXY4I=;
        b=isRej8lYsXfunaCSfpdi9lcSLlzmzg+SeDoC58BJyFARIY1yuUFuXC29neV5TmE/5w
         wdPKJUjXzInlMGIY8bz13Jzphj2p911uILZzUKdaZby2M99+xZzJiY4Vl/SQrmegt2r6
         s9sLOYrV7rTBkM/WCn0NkDYmqpzX81D0hXV3eYAhDFesDrG/Y0pOX7YSzNtAAWWCb4Z9
         /nmx+XUPLDk8V3tQQom0FQBEMkZ04ay1v6Iw7VcbywKUDzRz3BljkS8P6t0eFvIfk1RB
         5mPud0Bp3Oy3jp35OTI62Hu04R2oj2UxE7QnYEtZtTOE8dT58K0bPLuUMa0omBlRo6Kc
         dL3w==
X-Gm-Message-State: AOJu0Yw4bw1iDTah7iTF7EAPwFwRm8v6Rb/mCjwil7ZyvjVcNMDKELd/
	bfs5BHQMpZy8/R0JP4RsHBusMPuvVX/QAe64WevXCMebfe9cUcQgggOUoZY0APAeXljPKsz9TJr
	hoveZCRz0g+67
X-Received: by 2002:ac2:48b5:0:b0:4fb:91c5:fd38 with SMTP id u21-20020ac248b5000000b004fb91c5fd38mr7407353lfg.0.1694438917889;
        Mon, 11 Sep 2023 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBqMtDGn0pf99XADWB6tGgZF40Kd02qqzkH6QWq615qHUsC/OWdR39cBAauhrsaySiGTKsqw==
X-Received: by 2002:ac2:48b5:0:b0:4fb:91c5:fd38 with SMTP id u21-20020ac248b5000000b004fb91c5fd38mr7407324lfg.0.1694438917487;
        Mon, 11 Sep 2023 06:28:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bm5-20020a0564020b0500b0052e7e1931e2sm4606706edb.57.2023.09.11.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:28:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8D1F9DC70E7; Mon, 11 Sep 2023 15:28:36 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mauricio Vasquez B <mauricio.vasquez@polito.it>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: Avoid deadlock when using queue and stack maps from NMI
Date: Mon, 11 Sep 2023 15:28:14 +0200
Message-ID: <20230911132815.717240-1-toke@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sysbot discovered that the queue and stack maps can deadlock if they are
being used from a BPF program that can be called from NMI context (such as
one that is attached to a perf HW counter event). To fix this, add an
in_nmi() check and use raw_spin_trylock() in NMI context, erroring out if
grabbing the lock fails.

Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Co-developed-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/queue_stack_maps.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8d2ddcb7566b..d869f51ea93a 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -98,7 +98,12 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -128,7 +133,12 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -193,7 +203,12 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	}
 
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
-- 
2.42.0


