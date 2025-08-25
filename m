Return-Path: <bpf+bounces-66452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E1FB34C37
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AB57B6357
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3652EBDD6;
	Mon, 25 Aug 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+qz9KxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E329AB03
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154528; cv=none; b=QHjx4IsDmBrj89rpCQGzfymz307wmJGTqLYNzRwhfpuHW16yZZL+8givfkO6eu4iQuYg3xFRojGMjgDGq9IDydInqrTJX1cEkSHYoSJ7el0ZDUfivzSHu0tKzX/uZfNRSo69CN36pyXdmzwI2ZNSVouLkOIdMLtzOwEADL4OUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154528; c=relaxed/simple;
	bh=LS671NhhQdD8carTwkBj4ybZXZ/YovJU9pOCUsy5dgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ENfm/bQqb6PhqjpMl6ptgNRqn1BXO7OJO5R/sr5Zx6gSw2o32EAjW0RSfIEYNWRMq59U8AA1ZFgqH0ojUhvJnJwUmzYztc/EAJM38DMrOzqko1Elo2ZFsB1/1uaDr2CaaXElwetjm1OBjkITl2i8vRXTHOmV4n5uCOlA2EalVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+qz9KxU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3250e3b161bso4220564a91.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154527; x=1756759327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMygPmSM6dCzNwKSL7a/sRqPm0XfUojhTDtJh8dGVo=;
        b=O+qz9KxUIiTdXT7fk+yD1xMhS1kJYVDohUVqQ205MTuPT/AN2YCAriXL8ki3mdOyDt
         aX3Vt9zHXRehnhGOr+c9fN2RReHTwt2O8u1UPctiEkSvsmlEN4ouU6e21Nx+Qpre4UhU
         4lZLGCuCMAIDOxEa45XYOHFs5RTqRFw/aJat9SRaCbOHN+0/2i9yU3of9NmEDgZzkpAH
         a1KosLST1WZUbk5GzZGpZii8pOpN9LDrujYKsIPmBGRnhG+PGADSonItcIvbMJ2TcQzR
         cKOgrTVRrxOoLJ3ws5qN98PReOkc0XCyI69vP3JRIGMhBhfmamjCihcWr6ise8E6Cawm
         a0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154527; x=1756759327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMygPmSM6dCzNwKSL7a/sRqPm0XfUojhTDtJh8dGVo=;
        b=bJutr/G7WUWcL6FS+dl8mSmSQeYnZSYf1tm1LqdV7XKSjctjzj3XKLi0mOeSEkpQFZ
         6bodXMOTmv9AiH2SpqLVRy/Co/Tmz+sfP87HGbOswuUS+pNww2noUwwqnWfxWs0oQaZx
         X0l7+bL4ajq5BT31E5Wx3ZHFLEsxBpCI3rRUP/HgdjAeVAJa+sVZDPbwO7cyzf0RkI4Z
         c7ogi03kesblAt+1q0W82hwb3pmYL7hjOSZYlOTX3f8VD8jcCaUP+WT0ZupgdEdir2dL
         86WOI5ezYyxoiCO4/G1fj1SwrX+qCTBWf+VGL8BKcbw5oIfsYRJqjTUXLfJ52EBqH2DI
         Pphg==
X-Forwarded-Encrypted: i=1; AJvYcCXsNo8ziK8MfzEmD451SeeQU6yxIKOl/A6BF1Ns6ZsTgziIFYenmjAv+Js9PKT9JILolLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/Ypg3S4KwIVgO6H8drT6FCqAX3AwDPDnBBjdm4RynQ5R0jGA
	jCIGx1sKIbijmHQW+b2h3eiOXXT3pj1YkRwX3PpDq53vhDRPMm52csj5/h5BTIFBO+ZjzpMQyi0
	QVopO3Q==
X-Google-Smtp-Source: AGHT+IFD/FRGMPp/I7HaEhHJuo7Brtmh1xzlKhB4uWOGVmrBs3e9LUIXIMVuyKYEXZQfTl5Y8mnc1DtPKgc=
X-Received: from pjur3.prod.google.com ([2002:a17:90a:d403:b0:325:74fd:b81])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b47:b0:246:9a64:8cbe
 with SMTP id d9443c01a7336-2469a648de7mr89403205ad.36.1756154526828; Mon, 25
 Aug 2025 13:42:06 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:27 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 4/8] bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
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

Let's support the new attach_type for cgroup prog to
hook in __inet_accept().

Now we can specify BPF_CGROUP_INET_SOCK_ACCEPT as
cgroup_inet_sock_accept:

  # bpftool cgroup attach /sys/fs/cgroup/test \
      cgroup_inet_sock_accept pinned /sys/fs/bpf/sk_memcg_accept

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/bpf/bpftool/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 944ebe21a216..593dabcf1578 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -48,7 +48,8 @@ static const int cgroup_attach_types[] = {
 	BPF_CGROUP_SYSCTL,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
-	BPF_LSM_CGROUP
+	BPF_LSM_CGROUP,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 };
 
 #define HELP_SPEC_ATTACH_FLAGS						\
@@ -68,7 +69,8 @@ static const int cgroup_attach_types[] = {
 	"                        cgroup_unix_sendmsg | cgroup_udp4_recvmsg |\n" \
 	"                        cgroup_udp6_recvmsg | cgroup_unix_recvmsg |\n" \
 	"                        cgroup_sysctl | cgroup_getsockopt |\n" \
-	"                        cgroup_setsockopt | cgroup_inet_sock_release }"
+	"                        cgroup_setsockopt | cgroup_inet_sock_release |\n" \
+	"                        cgroup_inet_sock_accept }"
 
 static unsigned int query_flags;
 static struct btf *btf_vmlinux;
-- 
2.51.0.261.g7ce5a0a67e-goog


