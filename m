Return-Path: <bpf+bounces-30132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DE8CB246
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD541F22524
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C173539;
	Tue, 21 May 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AWfr9MG7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E1147C6F
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309327; cv=none; b=GQ5plhutpy8vCuN+0f25ACbfkOVo65BkZgt3FL8YUABAmcudQZBzCh/SEhnQwsJNnoKJPaTnq23sGDDDFKfRtrSc9n8fYsJGhKcbozm8XOLfubF8/nwpqJ+KtVdA6Ss+nXuP29DuDSt3kRcg8BqF1LXqwZGkCzTFaAmge3MBYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309327; c=relaxed/simple;
	bh=TzhbxjT2ArdvIpXfLBKdAlsNwdS6WxVTuh9aPBFI9ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kOROnKQ0mB199ZjWmquUsq3m1AveLot3VdFWdRjxiF7hIKsQX2WhH56/gvei6W4rAnoiqJnnqm2pCI3M6tKtmkOkfrLfsR+p83ZeSywFFZq+ibcTor/12JhtoIm5HCuMuTN6YV4KI4uAovfyXnfCwcaNoJxtb/Bv4lJz9e1jBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AWfr9MG7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so909505966b.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716309324; x=1716914124; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfuAgFBtTDpOlwam0N4IvuREtSpDy15u8s72jLqSs6I=;
        b=AWfr9MG7YLaUfxOftxZYuGsIZwy3zVKP/G+++qEA8GCWKCI6E16JC/M5UdZBI5lyzO
         XY0vc0qSImoYxT1cBfMt5eCx8XbJoaH2jOtBEb/6EaBnnxncbHYyuNBfiK4fWbUP0AwF
         zkd1/8D3q7YqUxWUZieuARmzdiu6mLvcGzogy17bIKR3tRDoa8Zt7RJ3rbNibqLIkQla
         Ey3BOJ13Ko2lJ+HHVXaRpQ6GzZXG2M1f+opN+0+3w5zW/+Zz1Efn7M6Qyv7l1cse6wtf
         r+grsXMpRV5j9JTIPdgcVIkNC/FcvH17f3GsuSvlQo2IBk63XSDZlkmeP2h5YPizVZgV
         W37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309324; x=1716914124;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfuAgFBtTDpOlwam0N4IvuREtSpDy15u8s72jLqSs6I=;
        b=iR95GfEkq/JJSiY4OmCxHBS75eir7ZrctG22xlq2lLJ5G/V7cyQ1utFRjNE7q+nlGb
         w88BZuNCCU1V43Kp8Iq/z1ypEkYil0WhaKNcw6YmlSCHh+YgUJmEIiVr2uA47OGOUYvd
         LnypjGgvOc42hGUKO2pSs6gei5FRNirEbkM0ZYsThXg5hCgVot6xoawxCe5Kg0qYMbnj
         wTJtiWGMM8ScS1j8WNhv4LImtk4zVTqy1tfHEXc5c09W4JA2jpj5BT+bcF5t9M/BcAlS
         tkv6bZGeDQ28lbvsBhYbQS7uS5lQEQJFX901HRZkXV3rUxi6YtILaoLR7FRgGgvKtZ8Y
         vHGw==
X-Forwarded-Encrypted: i=1; AJvYcCVNlkNVdJK42TTDgqO5OzyAs+IrwZSDk98dEP+LzZyqo5O9Eq/c4KdUBq284jMEjYOXIUmLxYOOXMYJP14+WoC9r5BP
X-Gm-Message-State: AOJu0Yx4l0Btpo0sOUw2JZZoZMAlAZBFkkt8iPnZIs5pCk8WqNg9U/4E
	pRoqLJJ6Y6lmVJ6rysGdxGJVVB6kM1FeDQVH3Tnp8RtyN8o+yEhveYSaF9x9cITwvkT3ZBG9xe4
	W
X-Google-Smtp-Source: AGHT+IFzI1BEXmKk+UchCTrQEn5fWoUij7qbsBXTjK7v2jJxza6UZKJQBB4DiEPBrAKBLfd2pFUEKA==
X-Received: by 2002:a17:907:9405:b0:a5a:5b8b:d14 with SMTP id a640c23a62f3a-a5a5b8b0de6mr2012491266b.40.1716309323855;
        Tue, 21 May 2024 09:35:23 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894dc3sm1633471866b.86.2024.05.21.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:35:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  davem@davemloft.net,  edumazet@google.com,
  john.fastabend@gmail.com,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  pabeni@redhat.com,  syzkaller-bugs@googlegroups.com,
  xrivendell7@gmail.com
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in
 sock_hash_delete_elem (2)
In-Reply-To: <000000000000d0b87206170dd88f@google.com> (syzbot's message of
	"Fri, 26 Apr 2024 23:08:19 -0700")
References: <000000000000d0b87206170dd88f@google.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 21 May 2024 18:35:21 +0200
Message-ID: <87o78zxgvq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git main

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..f6e694457886 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8882,7 +8882,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -8988,7 +8989,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -8998,7 +8998,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&

