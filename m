Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B0451D82
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbhKPAaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhKOTaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 14:30:00 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3EC061220
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:53 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so81202pju.3
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7MZPPjPZFUBNCsMLqWiJT2pCHT/Qm/4xh1xJ07l2ke0=;
        b=g8KmNU4GQ1ZHepyPOgz6HjVSZBogZcQ1byVNuYL0qw/hxgDMkho8cRajdxE25Fb+JB
         elEWHDXKOsE0w4E7dLI2CaiXLeEv9FOsn5BmcquDQKE4EER4aBtWmTbQaHSopkgSusIx
         Ts6R/duXs6mNC0A5InHGSYj4hGuKGE8MjrFXCpns8UcW6zqyQEGvykQQvICxK9qw6R9A
         gLC6Ec7zmKu2zj/YzcmF/Kfu/ID+z8JBMdwH2DkRNqR3admBfbVW7Nwazz2z6LCoLvDd
         S09Z09DcWSCYLMHiUIpNE9tAvhA6RKB+wLYst664NWID1H/KYa1tsXMCFR7GZ9qn6wps
         dAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MZPPjPZFUBNCsMLqWiJT2pCHT/Qm/4xh1xJ07l2ke0=;
        b=4mc40AjOJXlS/xt7dd21z7tfZQ89XR1Bf/Xb0hck7fHfDqd+G+8yyB1GjlD08hq8ri
         UNbseJJssxerQ+xx0ihi0KXqqqBz8u10kiMsQJRZfe6jzKzTGce2Mx1EHGklFIqYXNaC
         edaHHh85/3y15RV1WnZArClGPNfwQdE3A7nKDJSdraUOCqJKim3FaZ7LzBbBozHXoxzi
         /rDG3INzrDmadYcit257RMUXR53a4dL1JZp1twG9lHn1twbiwZrjCDB82kN5JOReZ3wD
         q0hEJEcVM+FPsNOim7l3mTdBxGIrZPhgM5RgsF3PvI4Oknz1h0Hcci7i2tEc3h0CUfXu
         nWVA==
X-Gm-Message-State: AOAM531rpnqnrGT+7L8Lt8Z5Teg6tp12DOOPPlGai6LPVKzWhLld+Qo/
        4IQrGp3YEJMKNBbUSAO+pOClkPZOodY=
X-Google-Smtp-Source: ABdhPJxDOp5eUd8vtUHlgZnlADyYZ6uVYh0k6Zqs0CPQ+9WAzz4/3EEVo2QQM0Gh5uUCoTgWcs93CA==
X-Received: by 2002:a17:903:120c:b0:143:a512:e608 with SMTP id l12-20020a170903120c00b00143a512e608mr36039224plh.21.1637003932430;
        Mon, 15 Nov 2021 11:18:52 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id na15sm122726pjb.31.2021.11.15.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:18:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 2/3] bpf: Fix bpf_check_mod_kfunc_call for built-in modules
Date:   Tue, 16 Nov 2021 00:48:39 +0530
Message-Id: <20211115191840.496263-3-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115191840.496263-1-memxor@gmail.com>
References: <20211115191840.496263-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; h=from:subject; bh=vmL3kw2QHlmGaggy5v7m3WRcFMAkoH2EedmKHt88Lq4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhkrI2N+aovIoBzw3zhKxZVtlRIgIMoqf8TXl7YuA0 ieisSliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZKyNgAKCRBM4MiGSL8RyhzaD/ wLo57MXBQ2jfzrKZGMhyN/rumbPBdpIYu8Z8+QgQa3+KoHhYX5injN7smArEa2M3K1EjYimwUByO5Q 7bMbg+IDOKd8wkxXu4CSvW+8IWCLz6SDjx7ZDtH5SxRURIzEyiqfke8eU2wiyz2WHx/IbG11VYdvki 10RN+UT9XYyM7tQBWBuZHUUXegs67sYR+PIMwB70o85kJWINLN/G1XjQ/fQgJS2eHpYmxaEg14K4dI iI1GZNMic4D6U1qIvgSoecOlmCxdFfLNjgd4SJB9M6JsUAv3UhCQThF/DRFbwh/m/IY4Yy/kHpGURD qOnTZMQcAQTFwKYdUY6CD5VtYGuwmF4yx280K88MTn1agXxH2SQFpvoTV9RvrlqY1wXq4VIsqM3/A5 1O2azPlWTT9OctQFnBVBfhiB0wjjV6oHcJwaSGi8AtEYcz7UOOYmfN9+hwHyewQwQado6ZXMLT/it7 mvSodo19TvbyYrAXMGBWgzCe0BBtBtdU7Pyy1zlbWX+DsZGuH04b+WNdY5SkUfA0kesaAC4kwxOUqk nnZCWv2g5wzn5blDNf69VFAm7i5jdO32jwNVesONYdBxxTg3SYsa6vRiFWlYN906NqYZPer9Ukd1Zt 2ZC72E5cqIzl6YsXcVASlPuqeHqErvix7L4XqU54j/DaEo7zv5KDA8Txuw3Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When module registering its set is built-in, THIS_MODULE will be NULL,
hence we cannot return early in case owner is NULL.

Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3ace85d496ae..48cdf5b425a7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6386,8 +6386,6 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 {
 	struct kfunc_btf_id_set *s;
 
-	if (!owner)
-		return false;
 	mutex_lock(&klist->mutex);
 	list_for_each_entry(s, &klist->list, list) {
 		if (s->owner == owner && btf_id_set_contains(s->set, kfunc_id)) {
-- 
2.33.1

