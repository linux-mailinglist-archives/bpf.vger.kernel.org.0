Return-Path: <bpf+bounces-69025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D7B8BABC
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76447B726E
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649234D8CE;
	Sat, 20 Sep 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gy1/38pj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C52C859
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326883; cv=none; b=FlJ++1wQ5A17jvj3pQBAKdXOvLX6mdOd/bc+ybKedSh37N2W6Pzn5YVc9UE3yvYacl6NnSR4SuHGjY4agOWUt5+Qbr8wP+x68vJasRECi8OwmV/jta3p8XGPqjW2ZmaknldnIAPzpNNyyg21QQy2E2VZQR1VHCw5IlA9xYGnklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326883; c=relaxed/simple;
	bh=Ay99++iSG6JW89qTS429Fssp2ykGCxEJlA+Ie/nFGLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4AVENZpQblMsTO4zQUodYrYMwNSWdrPdW9IiYXAtfbJ3Q0mJXVLDxAjshrj4Lsni3iyk9gJ3jLY1hnB1GriY+Bx7VA3nl9jbqW72wy4+6bJRQVsP407O/hO2eScmlkJafrJIgdMTrxTIz0HkbqywIE0VhoRlLlKQUwNDVjqhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gy1/38pj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5509ed1854so1528974a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758326882; x=1758931682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WT2rfhV2St5qA3ITw/vp+HmNShlzVIkzjAz9va3CYzs=;
        b=Gy1/38pj9ym3FeFTouP7DJwqzrgLFRt5C6+uaRtIY7J24y9ooe4onwY3oSLtH2ecJ8
         aMXBdbspeai+ddbb2MJt8uJYVxYWWwAibvve8+oEWeJBJFD7x/JYEQa5X+NBfywtf/Dk
         +11lF8Mkn3cy/+3VIrxfbvhuYdhwAyMaC2A053hV+DoprGKHYhuKzMCvY9h52jeinACD
         9N4/VWu+albjxxwBfkDkk8UavrWvHI+PqLGDFUczOrAz34rPfMDBuZHw2g1LF8FoMNa1
         OI1S4T6a0zJf7HHprrXM73bZFCkI91cE5yBEqcJ6exIzTX6DV0Jqxcx+IoMDcvYxI075
         oceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326882; x=1758931682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT2rfhV2St5qA3ITw/vp+HmNShlzVIkzjAz9va3CYzs=;
        b=OUwJKSjDDSvR0bYtv30lVUqbcGc2Uo/ZRIypsK7UZp2+etrHErG2bNAXggkALLiVHP
         cX2rgnh0is4Az9GWnuu1TReracNnyqFBDAxV9GC90yV7NHJMAc78zN0jNEV7lufx+5au
         0T4IRWRmbcRJ5vIVbErNSD7RiDaP36z6l0Xx93YAV3xITz78qbafcP4FtoLhZFvZZqqp
         zuLwP8/f/rI6RZ7P5V+3GezjkalygN2bi1sBFQgPR11NwOSqyveouBvICOmslW8vKNE3
         6/5l10d1JGvX+a1ni7YEmuaPgq4q1ndM4+ebXICm77+yonGdumC1Hp6ZwJKD8IuqeV/U
         xAQw==
X-Forwarded-Encrypted: i=1; AJvYcCVF7ZTizFAPMfubZLXcr7MeNVU5wTByBBB6uwV62Hx/ugLfXAAv3ZhVWZQutpwoSwzZqEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHi+D4gCdat8r65qCWEyz8QAOOkQuWszxOfV3GtBOMCZNeuB8
	kwg9pg9sy0JBRCoh3owu06wHa1iq3Rw0UJwaIkRApTa94prM7EyUUlq4Np7sTdNWPyhV4n1eIQL
	75WPrjQ==
X-Google-Smtp-Source: AGHT+IGhTVkBhkZDGT2HjyLu516ntlLk3uLh7ZXzCxp8vwqJk3WVHO2ojAIOzBg5pZzQEFZ1P1ppYwWjEuU=
X-Received: from pjbsn16.prod.google.com ([2002:a17:90b:2e90:b0:32b:50cb:b92f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728e:b0:262:a640:68a0
 with SMTP id adf61e73a8af0-2926ec19b1amr7248956637.30.1758326881625; Fri, 19
 Sep 2025 17:08:01 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:07:18 +0000
In-Reply-To: <20250920000751.2091731-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920000751.2091731-5-kuniyu@google.com>
Subject: [PATCH v10 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will support flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt() at
the BPF_CGROUP_INET_SOCK_CREATE hook.

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Also, bpf_getsockopt() will be necessary for a cgroup with multiple
bpf progs running.

Let's add new bpf_setsockopt() and bpf_getsockopt() variants for
BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock() and has the same
semantics with bpf_lsm_unlocked_sockopt_hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5: Rename new variants to bpf_sock_create_{get,set}sockopt().
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..31b259f02ee9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
+	.func		= bpf_sock_create_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
+	.func		= bpf_sock_create_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -8051,6 +8085,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.470.ga7dc726c21-goog


