Return-Path: <bpf+bounces-10301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE407A4DC8
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0978D281C8B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E221358;
	Mon, 18 Sep 2023 15:57:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED845210FE
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:57:35 +0000 (UTC)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFDCFE
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:56:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso74336221fa.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052356; x=1695657156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Naoc4gG2mkQtePsEFFN2S+1KQG8MR2mniab1JfQY8=;
        b=Fw1MxHRBkKJkn49R8RH/rNdsfLedph0ccvFhQObxQFFTcGtd8qwWgjzDi6MAlzoRmf
         BqQm+iuW3y1mDZzNkxoWFD67s2ztIqa1W2wXhFb8xVcQzrbXRAp8nUXpqJ4pOhivf5iA
         DYixf+G7iLmqP9Q2MJMer5VT+v2yk5QtqY/SMYU/lR9jL1OSjjjW/FM0aZZzvDXL3koy
         MHGgQqGHXK4mzo5F4OU0CI4DJHfywHAlRUVp8HXG9PNOXqBm7d3/nYDoOJVzSVtQupIz
         01gfiq1IGRsYOO1zToaYL1eH23dTQ6yOLJwmUrkcDjf2vOp+9Om7jrqvlpQKcYF/Us4+
         jahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052356; x=1695657156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Naoc4gG2mkQtePsEFFN2S+1KQG8MR2mniab1JfQY8=;
        b=DyCxBPcShzIztOUE5IPVbGg+WiU7tsMPjlqsctvKIuM9KHiuPJcgzSTv3mxM7baB77
         sVqWoJfeiUt84/fbJPSAnJSrk6krLbEgZw4QzsD1mhYY6HzKghXwQX4zF9M9ZvDnrOMz
         PisqwXhpUkhtCEw3QC5pe1ah1ap6nzkCZOHBS9lgmETZ2z3asz0nA+iYmlFiLDPQ7eDQ
         55JI/muQwo7pdMaJRB3XuJNmK8LOMSUJemMg102fK2FO2J+aAg8eNf/2TITX49atVwX5
         gUSIDD56iqA629Pu5IwJl4v3Thf0vaup3ctRbCxn93Q3SzcnyEivVtfv5XBDHXknXevF
         KFgA==
X-Gm-Message-State: AOJu0YwbCC7CzaS6OL7rD8iodCbwqn4MGk0jqQKI1X+/Kx5EmBQKwOOB
	zDy3yQEubXmzA+YRzRs0qglx0M3oG3SWBA==
X-Google-Smtp-Source: AGHT+IHEu4b5ilDrB4Wp4Zb94qoobwGh+3gjWyR5Vsg0C2KUdWJXzB3lWzI9xKmoLjTGAb2m5yyvGA==
X-Received: by 2002:a2e:8699:0:b0:2bd:124a:23d5 with SMTP id l25-20020a2e8699000000b002bd124a23d5mr8364620lji.11.1695052356274;
        Mon, 18 Sep 2023 08:52:36 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id cw17-20020a170906c79100b009a1a5a7ebacsm6562382ejb.201.2023.09.18.08.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:52:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH bpf-next v2 2/3] bpf: Fix bpf_throw warning on 32-bit arch
Date: Mon, 18 Sep 2023 17:52:32 +0200
Message-ID: <20230918155233.297024-3-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918155233.297024-1-memxor@gmail.com>
References: <20230918155233.297024-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=memxor@gmail.com; h=from:subject; bh=ZOTWQIcL62XArqSGkyZTul7LUdFIfys+cfEYyQUk+J0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCHIaNFkPeR7f1jtQEtzuoZ6FDD6EEp2fT9oP7 fA8CdQa9qiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhyGgAKCRBM4MiGSL8R ymTiD/4+XQAID0U0/VEaVYzF27fHunGa+xd78zxWBh4U4FL+bYJsuEhpdh4sELa5wVPPlFbZ2fo zRjlYA/JoH9w04QLBZoxxDwUIxGbqepd6mW6BT0Tc/1I+xa6H8L0dfg8Cd5aRRD8lkf4O5LCrus J84jJsJzo2nxJf4teHDbJGW/Wala4zXZG+y3675Lox3EuqP0/xdjwcKZCzfPXqgB4JrpDpiqtcg c9cNccxQdvneCYtv3C2Esi9gQE+yU5ghiVxOAR/JV2Gsq1HC96mNoSd8Z21YoXU6/LbQAnFZUsG +tTIscwsNTBVT970fPK6EdejA+DKoSTLG1YDdlhA540Ge+WQZq+hXFmws2iLC8V72V4aC+pizDm siWPpTfEC1dj58Xziu4JZt6DjjvDOrM+xdp9qxF8kJPqsEyRgTu272d0Fw3n0Rd0r2yI4CgPOjo fjzl34e6n4utaAYnnNcAdaN7WiRecqhmONn9Aga8rEHZG2UoKK2Z97RZiBwufTO4E8Y1XLTP/l/ pbLb6tHtxcfMBk02KxnllapmX5Rr1lOaQMlAqGI91V0dHlb0byQY/Gj1J/WasEhx0WTYmalENcJ L5i1H9MCPPBLbGGa5PQ9pPiujMrxgepLXUgjBONMeg/cwvYsPe8Sboco5+NHFV75d5ZBiX9WXKn fagwd/IEij2HzFA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 32-bit architectures, the pointer width is 32-bit, while we try to
cast from a u64 down to it, the compiler complains on mismatch in
integer size. Fix this by first casting to long which should match
the pointer width on targets supported by Linux.

Fixes: ec5290a178b7 ("bpf: Prevent KASAN false positive with bpf_throw")
Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ff2a42f1996..dd1c69ee3375 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2488,7 +2488,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
 	 * which skips compiler generated instrumentation to do the same.
 	 */
-	kasan_unpoison_task_stack_below((void *)ctx.sp);
+	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
-- 
2.41.0


