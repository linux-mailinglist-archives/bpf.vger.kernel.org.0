Return-Path: <bpf+bounces-64871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C66B17F94
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8A94E1124
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49F231A41;
	Fri,  1 Aug 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPQXT++P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D81A76DE;
	Fri,  1 Aug 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041649; cv=none; b=hKJSanwTJG3y+z7QE8XPZtXIxr3AUT8Ci8V4FsmuTANda3DpvpeU7XUAbtGgBJAG4mttbWxnlLqf/Q6CsBmDRUBElY/Dc1OtV8Xw6ySsdcPzemwLuGjm1OkaWN+Z5IQAw96U4Pa+K7PoVGmiPgwQ0ThljNtlDnqqQqatXh3FoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041649; c=relaxed/simple;
	bh=r1pMrLldomt9JHqRjOaveCmyj6dc0kYUnuteVCNvQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANpqO9QAO6ctehNVOWxpwpBGsegbjmues0EVnF7KFsQ2xpCMB8WouAagSuzjTYdHqnprSN1K1LQmhZePPsB0MnOncLQHInrIs5+pKrZeJ8ehlTJeziTLV1dnXisH2p4r3zrFGi+jiN4oGTu6698NKOxUafcbqV2c543rHahy2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPQXT++P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so10507045e9.3;
        Fri, 01 Aug 2025 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754041646; x=1754646446; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIbNk0UR8USyx7AaW2z9Q//IszE22BuVGOChhgG4Jjo=;
        b=YPQXT++PJ+t5PrE+09BQ0SBN2wKtx+Zs19j3mSxKhUxq3sl0MCucdQpofrq/0KjLQZ
         IF1cDennDLT5M6tfpTxoxcec6JBSKCTaDAW9c5p1TZgo60Erph0SfluGvu1xidP2rtoe
         K2WPIXk4+gzqfW3nED2wBbVx0U7QWeosTLoZSB9xv5MKvMz0yEs8XKiNpEHGXz9831F5
         vJLANmFnWkOCoLeFaocBu1giwuESBCf4mz8IUXkwMu7waakCdVUrynC0MSdvjRpwUpQB
         fNZiVrqD5ecPQV/DGdgjwX3ac/IJGdaCWBXUjMsL5BbF7AVtB0wvoNKjpwY7leSXA1FZ
         hgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041646; x=1754646446;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIbNk0UR8USyx7AaW2z9Q//IszE22BuVGOChhgG4Jjo=;
        b=l0P8qNPY7RAAmVKn8F9oA6QJobQCbT06VIu2Rfm5Q+r95y8DN+96kOxbGDUixV36aW
         46RNim2+1jretyce28xzfLE5/R5RBI1e0uZvAv5+oR5Pcy+11V80sSZBaZcYqhZm3Ifi
         I0du8C0SEpJJMw/91rAXZXOQyVKF9mI75W+c0S4Llcz+FNB5DcFyfQW7V4Lr+oQQINlY
         WO22KX52KwwhCapHhGFVx5Nfzr52WDFhky8y38LC38cIDPeLK+vpoP4ennlh6/KN5P6j
         cltdoHJSXJyRqcVHUwlwOGLMUfNqVADJJ6WNid3I9JhKH6KftD1n0GPUs0H7d957wN2R
         yvnw==
X-Forwarded-Encrypted: i=1; AJvYcCX4A4T0kbyc7rJlCEuZHMFTuH6k8/Da2SwP2rJz9nCmu818fWFBb5s7YW7cSYuB7IGX+uIm6XnFqSNMiSqOP7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RXB7eJgy+vKGsB+PgM/rEr6OJbCs4xeh0rB3iHxDjtXs6VWw
	+58e03icpgaxgR8rOF3zKbG8x8O45h0B6HhFJ0BvFz9fdUzAoikMX+yuLIFnsUMI
X-Gm-Gg: ASbGncv0/f9U5YMLthHjafQJ9fogptGxBaaKv/qpMvk70ifoeUu8D8lQORz6vbJgyex
	BXYDaAkmN8HSqWw+VcuUm9BgX6OeLC9fiboQVn+FT7p0TaqB8rS43Kn5ugpUVx1FrtOQ8hy3T+i
	ln4fl3B3vL6MyB7oeEO35FnC4uqcd0AtPVCE3VYIfWMU2pMj6e4qL/QXkTwvjAH0ssHrdVUmrH8
	AtaZk9fmARanJidc4JmDYHvhUpWkRRUEV5dxD5miI//9B8Znfglu8ahwV27Wntn+0EYzArPNV1I
	AgE9YX1FJsOc+GrzoP+9c2utFpAUw666/WVqvm2lckwJ+rsDpSjDp6ZP1vw/iGnh97tWTWcV9Gg
	h/LsH6xWh5t5U/jOUWxrLCX5E8jKN8av3vy4lZGho8rMMlkZAwS+G072vJSPdDNrxXdryC3s8dl
	lTsKyHM1p+dg3ByX0zCys=
X-Google-Smtp-Source: AGHT+IFhBDvYJfQd7uDmWnpixaEOyqLzYhC8pWnAczy1MHPYI/Fkf3AgQd+j8BWjowrkMaJ65WsWag==
X-Received: by 2002:a05:600c:470e:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-458aa318403mr18279455e9.7.1754041646101;
        Fri, 01 Aug 2025 02:47:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000cb332f63428a027.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cb3:32f6:3428:a027])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a7c91c0esm36554445e9.11.2025.08.01.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:47:25 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:47:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Petar Penkov <ppenkov@google.com>, Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf 1/4] bpf: Check flow_dissector ctx accesses are aligned
Message-ID: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

flow_dissector_is_valid_access doesn't check that the context access is
aligned. As a consequence, an unaligned access within one of the exposed
field is considered valid and later rejected by
flow_dissector_convert_ctx_access when we try to convert it.

The later rejection is problematic because it's reported as a verifier
bug with a kernel warning and doesn't point to the right instruction in
verifier logs.

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index c09a85c17496..da391e2b0788 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9458,6 +9458,9 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	if (off < 0 || off >= sizeof(struct __sk_buff))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
-- 
2.43.0


