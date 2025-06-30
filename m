Return-Path: <bpf+bounces-61828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193EEAEDF3A
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F9D16FA71
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34628B4E2;
	Mon, 30 Jun 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXRKr1P6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1128A73C
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290547; cv=none; b=oKuVEV1zlx6K1Erc2ylbH8eC2FQNbRoMnYE1W9OAOjHKlOiOmyra2/329Ak3oQYNOCh0J+TRblZH4IoN7XnLaBXnmrHUDJej6crV2poYJN7FSE0XHhpdkHR+fwOCNWTmrfYBn2tt06hV7SokhNz8INkumyorKNhBrtLO9eenDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290547; c=relaxed/simple;
	bh=I4BVh2jJgSeCbGxd0AFiSobgYmGM/cPArZgyx8LH2j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7qUzymL8ZtENNXHIM5zPGpWc8QvU+/zAyN3xBGx2pVpw0l+U32mHeRwvb7G3PG065yyMwQMuACeqVKPpN64BOm6LqJQntkTLWeCcDwKhxQFkZOrwp2xhMJnLzIoDHKMQ4QVC12lZ7TekpGXb8MrFo6xChEPBMhPcW4ZJwJusFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXRKr1P6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751290544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/3RRoNkOVQN6TpJYq3En+WCVz9JU89wuTAMcgf1kyHE=;
	b=bXRKr1P6/9ZU+NImV/O844Qxse05+FKLHcid0oWE7ErlM055mRCNX4uyBHEWTSJaOzdW9a
	rCnoojFUrirB07s/ctKJrYqtCq4gsROOvr6V0mhtLD6H87Sr8G1B2wwGwNM9uYKmSAmhmG
	o/i7Ky0HtZ7p2SYVL+vBI5g2Y8BrXRE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-w_aTevF0NEiiIOL5zFnoSA-1; Mon,
 30 Jun 2025 09:35:39 -0400
X-MC-Unique: w_aTevF0NEiiIOL5zFnoSA-1
X-Mimecast-MFC-AGG-ID: w_aTevF0NEiiIOL5zFnoSA_1751290537
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B85A619560BE;
	Mon, 30 Jun 2025 13:35:36 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE3F418003FC;
	Mon, 30 Jun 2025 13:35:29 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
Date: Mon, 30 Jun 2025 15:35:24 +0200
Message-ID: <20250630133524.364236-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=n.
The reason is that qdisc-related kfuncs are included via vmlinux.h but
when qdisc is disabled, they are not defined and do not appear in
vmlinux.h.

Fix the issue by defining the kfunc prototypes explicitly in
bpf_qdisc_common.h. They were originally there but were removed by the
fixed commit mentioned below.

Fixes: 2f9838e25790 ("selftests/bpf: Cleanup bpf qdisc selftests")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 3754f581b328..7e7f2fe04f22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -14,6 +14,12 @@
 
 struct bpf_sk_buff_ptr;
 
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_kfree_skb(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym;
+
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
-- 
2.50.0


