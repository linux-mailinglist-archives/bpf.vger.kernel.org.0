Return-Path: <bpf+bounces-10306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4157A4E25
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED17B2829C4
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB4224EE;
	Mon, 18 Sep 2023 16:06:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966231D686
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:06:51 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8E19A2
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:06:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-50098cc8967so7528000e87.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053203; x=1695658003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YiCPcSujgZLNKIlHUVm+vvy2lgJ4MowgcIqAbJ/rmc=;
        b=gYEMA+NhTkr/hNqwQMjplCRSMuOO4nfMYQnMaNGWetrENvqzp4005/OGHhYJj9G825
         TVO/WU1zXRKwLiSn6gy5gTJJG48CZWevnYUTw4iBwIeoA/BDLROC7M3rurC89ozSR5uu
         bS+bxnAO56uAemegFqqLcnxOpGMriFuYoYHAY/TdkN3VZeK2cmvy2BhDVmKlUTA+psD1
         mVVzfJcARsBxRjY77GttkctD9Z+5F1KpCUsAN9/YkOs4iekjK2ojljyEOBqHebXh3rPo
         sFg2w2ryR+1dQnlyjA1kLsXDPrPHRF4X9SAnVbnbctYQbWQTOvhdzG2jH6HozPMnjyuJ
         Id0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053203; x=1695658003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YiCPcSujgZLNKIlHUVm+vvy2lgJ4MowgcIqAbJ/rmc=;
        b=GnL4xT3LXsnDB/nPXJE+zQMzc4ZsFXaKMSN/aGwB/KJecQDfugZcme0usvuBjbhiQL
         SppJYHr8PPR4ZWCZ29ZIwnmbTN0bmPqoRSoXEFHBEgpBmPBnUWswF7LelErwxwQpzDHA
         vhxeDWbSI6kyADF7+AXqR/rIfN5NOfdbbeIQP1TDbL2VrVk5zHXodDKguqXcvmPH84Xi
         0rnHUwqzjn85Uq4BEkBEKsTbfwEzBEn1OFO+nILyvkWfZVpa9iUvPVu1MPhNxJr0AfFa
         OHE4QakSlqsYivcHbG19e1edOjBm0ZIKf+uuQbLSYVsGKwy6oz72T87x8xK/gfupTiOE
         5AlQ==
X-Gm-Message-State: AOJu0Ywr5dLtwav8q/fxwUoIWYZ4ITnQdL5tlW+HJDQgKfCGrXcj0ihK
	60+rEO5gB9HFm0ZlMGr5InU0OWdx0oVYSw==
X-Google-Smtp-Source: AGHT+IGZ63uHr7xb+6+yIjHbZC6RnPGYoW5v5vZwhjSkYEJqnXZD6U3bLZ0wZTJ7ipA+egYhhP5fUg==
X-Received: by 2002:a17:907:a07a:b0:99e:5d8:a6f9 with SMTP id ia26-20020a170907a07a00b0099e05d8a6f9mr7350590ejc.66.1695052357492;
        Mon, 18 Sep 2023 08:52:37 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b00991d54db2acsm6661187ejb.44.2023.09.18.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:52:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Subject: [PATCH bpf-next v2 3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
Date: Mon, 18 Sep 2023 17:52:33 +0200
Message-ID: <20230918155233.297024-4-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918155233.297024-1-memxor@gmail.com>
References: <20230918155233.297024-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=memxor@gmail.com; h=from:subject; bh=znk/eRrHas+L6qZGPKLxKYJFS9c8+0jZu8DHA5j7bn8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCHIalXKT6QxLcISac8/HqhxMxlkR+GK7znj4E +bFGXLmgz+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhyGgAKCRBM4MiGSL8R ysPHD/4gckACQnt9mvKkYiRgnhJmWOPQxGufX4JBHc53OR+Z0aMe6D4ZBzuD7KWw9DKeGUENSej qHEqEjqb8eB4DBR7aOYQIyCmb1cA4F34x6jPKo0D5OB8xdslShwaiY5YL41+qLw4wNfr+eDuzwQ a9FWtK5l/Yz+r0cJHulHzv2TIXexpUDGPj8Z2UsrjI2pnsKCjcTZXyQtFZzF4kPUH279nHLX6Y5 T9ANfkl4mUalEyiOjpbRXs8SbDHlDDCZIlzuJbgEDGY4dDdKgnP0uV+Yc7+wY5Ll3ZCFcNOZnXt OWRnphkJ0JnZjSlygCtPP7jcWyJ/8f4mbl3q7MNjVRlhHTXP7O2Q6kcIKOA44P90MCk9/lA8TX5 er7vFMqWUt8CrSeN7l+6VIcPGkuY1zGZtbdWHwgncNgr8v7FdtUhk/AI6rpG7XZA96FkhNYvzX9 7e7HWHE/3SHjtfui0l97flCl3pQIyPTQg7x2xO9GW1fvaIUonAmPdY1u+Xwr8Hd4iMiay+tJSuA JvXoNFkxh7YUIwQjjCp3uP1d+b+r4UCcWH0CVXlZyb/0uFGJgcmZkA5fqAWbJhH/xXx/mykEbtJ vL3kLa2uzTOZ8dpk0tFYfQXHfvpP0Hj4X4C58hp5bYkoTkBrbbCYVhZ8yPXDrvKAhYJhDj2R+K0 o/twVQ07Fd+3f9Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The build with CONFIG_UNWINDER_FRAME_POINTER=y is broken for
current exceptions feature as it assumes ORC unwinder specific fields in
the unwind_state. Disable exceptions when frame_pointer unwinder is
enabled for now.

Fixes: fd5d27b70188 ("arch/x86: Implement arch_bpf_stack_walk")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 84005f2114e0..8c10d9abc239 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3003,16 +3003,15 @@ void bpf_jit_free(struct bpf_prog *prog)
 bool bpf_jit_supports_exceptions(void)
 {
 	/* We unwind through both kernel frames (starting from within bpf_throw
-	 * call) and BPF frames. Therefore we require one of ORC or FP unwinder
-	 * to be enabled to walk kernel frames and reach BPF frames in the stack
-	 * trace.
+	 * call) and BPF frames. Therefore we require ORC unwinder to be enabled
+	 * to walk kernel frames and reach BPF frames in the stack trace.
 	 */
-	return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER);
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
 
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
-#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
+#if defined(CONFIG_UNWINDER_ORC)
 	struct unwind_state state;
 	unsigned long addr;
 
-- 
2.41.0


