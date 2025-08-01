Return-Path: <bpf+bounces-64872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCDB17F99
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD9C3AAF37
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25822FE10;
	Fri,  1 Aug 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJ7JVfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12629226D02;
	Fri,  1 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041702; cv=none; b=HYQqU8AI2sbzdfl4VtHvhnA1X0zQQUtIDpv5wrihOqwWpdmQ4hOZ26CXQ7PE11TgkcLrVRozEEokxNA0cZ9Wj2QZ6JzkvphmZIiOtJF41GDWqjhi/46RM1BLq35zLearFo1AKTavypmICPzd9oSi+y9QkomM0vBeclV417WVI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041702; c=relaxed/simple;
	bh=OgIy57EeRJhugCew7EbaHS6aH3IgiWSWm7yoxhl26Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCmROEzcpVKXvcTVR3dE1pw79InLSpZf2F9yu772oi5hnA2I9ejkETNmGpdrQPGqN7TSvSb9oTGIitNnybNGlBvNu4wSWh4SvU5dPpNaLjv5PsxHrwoGtXV3njjkgqfBPeUIvDdz83ZwqLGC1pV+HwVkMxefo4rZwliNOjhc2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsJ7JVfe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso19559615e9.2;
        Fri, 01 Aug 2025 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754041697; x=1754646497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtCetcbyciTV9aFI3DMfTrvCbh4SjwncQtalpU9bwZ0=;
        b=gsJ7JVfe70hie+gP7HpYfVjzW06pPUt8NQ2RHktU9U/VriJApjcwObOd6AEQyTuUWm
         6oFP/s+UnCv/DAp0Wl7fFUtYUgFT9w6xNBA5KjXygLOSAvpfIPDbrHUrXhJ68b3KUxgP
         LuNrmIpIdX66I8Kf6yMmPjCdpMAQNUK1y7Ac7Jhrpnj9dcDOr/2AvHh+wIKS0mGHX5as
         9agWpjjkRwFcskjFei2ni3XMSbAsdjF9WhGEWTZINDrYy6uUMXDuxIRAcPY2azEvNgzB
         Fe4Ea2sLGWtHpVm1CPbhkYTpiNrgF3HwKt2TfH35/ZT+ujqAq/BUKo16+5xcnjoShIM1
         MKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041697; x=1754646497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtCetcbyciTV9aFI3DMfTrvCbh4SjwncQtalpU9bwZ0=;
        b=Cs8ziPJ8tPT5rSEfY0Mti5yfDu/RWRdj1Z9UXVkqp3ZPv6064YCU0oMdLU/QIUwjZ0
         NONA42vxjeqqbnTRvSzB8uxYCAKqljeU7daszpDY2LktlEhs+ghETSIrzxW3npq0iMdC
         Hn0f4P0Kbcm16nEGjfsOrLAwQ2Uf69lzfWMvqEhxQmdLtVM/LVYGbc3K8+U0JlmRIR4T
         XZWhTD1H68gkEvMyy9SW9Tm/md0XJWQPyuc+viMB6hM81KBpe8FZGer1SteuZmwfPWcQ
         kMi6fqfC7InlBU1BVIGoBEnxrhfok2fwJxEzamZEPZR9GNUBhHlbbUvznm8eAtnqTh4b
         g7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaDqs9sdSmxlNqXrKmYIkVtdQ7jhoI9pnv0A80459/pumj6GJgR6MRkPTHM3noXvkJk5BEr90LvMuVRX4kIc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+0+oVZ9b+mfhPPhoCHX9sZ5K6utVenK6djqkboIL3BGtcNtn
	xGHn+amztGC/PTQ0LDXyfn6XYMwU3btZWUO2wf8NXrsDlpv8NlrArOw7EMtWCHzJ
X-Gm-Gg: ASbGncvZdP7TKas22TfRzDo45Kc5sv21NGxaq9C1Xobylp21vl10l+7VjAV4rwBAP4s
	bDjIGkCo8eL64o7u0DOReX5xEjzOvXUVKdObJpkfw4zXN1fHS+QtWEzH3MI55Dt2XG3Rzu92W4P
	MQGIc/51llC0poZUB79f3oe6L+BG5IUCiTszTlJLH+KJbdRVy4EY+J7YvXYOBovrpABahFGskYr
	SekNkVq68AYId7yBQnme+E0qRhiJQrVt/DdWL+LmX0Otf65InAx0DGw0j1OmrpJfdM1PHJ4DXzJ
	gL9yUXIheHchRT6DBz8NOMwKCXuCCWpkoUUR/5eI0i0MqkYXaV3zr1okCZ8MLeaL5ZMVGyDzifC
	g7DXH2POhNvXp27/jVV2zY7MTBjA4bqV59PQRTklsZX0TIBez0Nvoo5cgD+F+nJ9bFCZjt1Ohpg
	slfX4N3iU7ceIOF5NqCe0=
X-Google-Smtp-Source: AGHT+IF4L+w9RuSoC0W77/gBpjjwWM+aQK4ZkNAVfSlYDYj3tt1yF/eSG5hb2tEsGoibwKinveo71g==
X-Received: by 2002:a05:600c:1390:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-4589eaf227emr56872515e9.4.1754041697176;
        Fri, 01 Aug 2025 02:48:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000cb332f63428a027.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cb3:32f6:3428:a027])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377748sm97072655e9.9.2025.08.01.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:48:16 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:48:15 +0200
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
Subject: [PATCH bpf 2/4] bpf: Check netfilter ctx accesses are aligned
Message-ID: <853ae9ed5edaa5196e8472ff0f1bb1cc24059214.1754039605.git.paul.chaignon@gmail.com>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>

Similarly to the previous patch fixing the flow_dissector ctx accesses,
nf_is_valid_access also doesn't check that ctx accesses are aligned.
Contrary to flow_dissector programs, netfilter programs don't have
context conversion. The unaligned ctx accesses are therefore allowed by
the verifier.

Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfilter framework")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/netfilter/nf_bpf_link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 3e4fb9ddcd36..46e667a50d98 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -296,6 +296,9 @@ static bool nf_is_valid_access(int off, int size, enum bpf_access_type type,
 	if (off < 0 || off >= sizeof(struct bpf_nf_ctx))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
-- 
2.43.0


