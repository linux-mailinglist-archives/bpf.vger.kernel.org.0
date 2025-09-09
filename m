Return-Path: <bpf+bounces-67941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 175EBB50761
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A618B4E3594
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16B36206A;
	Tue,  9 Sep 2025 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6cN5dmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C81362069
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450806; cv=none; b=ijeMUU+9rsA7Pjk1fbXRK/ZlgR9N9/e1LgTrUlJLE5cDh+MLGldQRlOmnmpw3hnysfvruCpCPIbCbJUOW/yz2+gqgADREufI2D8cRsNqjTDZ7j9AHo4CQB+FwDZ0Kca/0cMIs+EWWrHVEc+Rqv7HTcIUPAkg4uOmqFDNmJDBZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450806; c=relaxed/simple;
	bh=rGkoFu9nkoi5/nIXhQG8fsZVP8xpKsdD3ZK3Uhe0wtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4Nm0VKjt6xPyVCSVANhkumBWRFOnIY/8ZNVsugIcrQK3aBU9Cna5HFHxdmctHxvnSyxRuPWOYTF3HozqnrHiR1e67Q4u1QU+fcDTXC9D62X0+UPH48ZOEpOpEmygE9SQRZl87fehtqBZwa33/8VjwQPu+Fs+FN2reb6dPXZ3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6cN5dmH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77422201fd8so4473881b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450803; x=1758055603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=o6cN5dmHJiig9kGxXGluQl4A3Nh25HTFeyPKFlK6itAl84pLwGGDI67+wOo1ttKJlC
         wCHtHjBTqTRl0Rh7H643Ul51wwT1TYb+X3UJbSvIMzwjN6FqS1TDsqSXYgQ4lEwZRcKQ
         fKnQ9Kutp5mmMOAPuvsiqg4JK0/QykIV29N1es/Hjmxk9kOjGygMY/m9p/2VBg6Pjkv8
         wUl81ld6OT+C0VdKaDsAjaK6Amj7YEvZAkeJsEfltlunhg3ErLpC0lHvx8VTjNWACkpQ
         0N74SRhes2WSoj/e3Nsz1GZbEWvc0hWSUu8f7LN/5LV3HOuRf5D1ZFooTEW1VnRNoNp4
         3XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450803; x=1758055603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=q18fWdaBLSZRPMMJmbKQir4x+X54LuGThxk8bbOJjoPJ0sJ5A4P7MlSrvoEKNVpkuq
         QYtXCPGuQMsg/xJhCHfdCVTsFyKk5VVBWf5UpgUdOZcFWCWhxLixvT4oq8dlvJ1h+bLi
         Fkdn4qggbtu/zgo1V6YipCKnn0nc0eI2XtCzJr6VjsNGTyZGu7VRe+wl0JlO1Wv8ovKo
         lamIA8zIFcogzu+PLm1j6KNbMBCOIANpuZSuh669Oj5G9ahgMdNK86t6blgl/Cy+j7zu
         C4t0H+jC8SdnW1LoZgcIKSmA3PT5KmC3BcLzkYE6c7i1ECG04IEnE7oZcLTihJIloQu/
         Y8rA==
X-Forwarded-Encrypted: i=1; AJvYcCU7CBkCmtH8soPJVQ5nYsA1TqIde12Niy7YdsF5HUIPm+cKNtDHa8FQFjKsnxcv3feoWak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc68Z8QCYZbDKPPUeVtzG8lk3rrCtQPfEWEmvsp9t7YMYw7pRO
	o6fsqybZsP2g/qeMhW1lGudqWrP+LikXfoqhbJTJdYqQ89VpoBaTKmihQXDuiJYoEmGDqc2WPfc
	hySDp+A==
X-Google-Smtp-Source: AGHT+IEEYvGORu/7lz69y0lIWTuznEat8Ngj8+z/6ck8dr83dBDXqa09D5YJA8suClMe+OQvO6EZI4NzKoc=
X-Received: from pgiz3.prod.google.com ([2002:a63:c043:0:b0:b52:122c:6937])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:240:1ad8:1821
 with SMTP id adf61e73a8af0-2533e94d11bmr19780982637.19.1757450802646; Tue, 09
 Sep 2025 13:46:42 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:34 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-5-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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
2.51.0.384.g4c02a37b29-goog


