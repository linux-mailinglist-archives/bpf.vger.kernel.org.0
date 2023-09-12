Return-Path: <bpf+bounces-9833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E079DCB1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A89D1C21427
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9D15482;
	Tue, 12 Sep 2023 23:32:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B761429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:25 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8910FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso7989079a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561543; x=1695166343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX5W3ta3gU0ie2rO52b7pq5F2OK5nUY1Jzz7hdFnd8g=;
        b=a/BTfN6kC/rS4GudjOtm+ikSjtZPfvmqQJhC9N0eqjgQGkzLblhvWsr3PVk2IDAIsY
         vgIjMMgUsX0NYjA1nHC+Aa1K0TkSmdJlMGGwsqjdiyp+heYoq1j9s5Jgje4S86I/R5Hs
         yvJLJDhGHHv5/sxbOmj8m0yNm1eh+rXCur5WI3UZRx/Ek6z9xyl4u4q95TmmBwzU+MH1
         GCYoPNmyCalx/vkQxPz6juKVWD3HQ3y9YNSzGveUVlPVoERVItoJ+OdFIxLX+okSs29R
         xVNYBGxUo2XwZmTQIVNuXgUTARoiQquBlOWit1lkRMXmzkv0KkL63SWB/0ZRf5AY43tC
         9lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561543; x=1695166343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX5W3ta3gU0ie2rO52b7pq5F2OK5nUY1Jzz7hdFnd8g=;
        b=w649VUthJH+5aOawFOvN5A1mziQUbdZxZsXWbg7em3JlVdH0nlBXRfeOOwmCpJKYNj
         PVphRmjERrzoslgrl6X1Qrld7rzunCQz50IhsXm0qoEZejmianvD0EJdXAl4f5rz8/4H
         GyOuIHylTIbWiZ6sEIlLHvaMl5sIr8kg8kDrPCyZi+AUydM673N5vp8jsSIfwUHUxz+K
         FrhJOv5os2nnbW7TqFB6LYGB2kBFYy1gUY+e+3EU9ovI4gWYJd+EVcvcfx83fCRCK7pb
         2vVU3Bq7UBeizhgvOAyJYN6xmIBNRiVMqEnqUFgJ7pdm/8rq2622PehGxhsI9GIhGygi
         4DSQ==
X-Gm-Message-State: AOJu0Ywo7U9waUz6EzfkQzqBGx3Td1YO+HBsV3bmx8DKISyX4vRODbMd
	+yzPz43g+snel8zf/sWuagfFeuit9mKmfw==
X-Google-Smtp-Source: AGHT+IFcAdOr+jGbCuOQfQY+xvaDT+sj3Shn01gwlyolFgLuNGnZeI/kYCR0zpF0D5HO0S+24/iwxw==
X-Received: by 2002:a05:6402:1841:b0:525:469a:fc38 with SMTP id v1-20020a056402184100b00525469afc38mr763072edy.31.1694561542991;
        Tue, 12 Sep 2023 16:32:22 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d0ce000000b0052c11951f4asm6470206edo.82.2023.09.12.16.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 09/17] mm: kasan: Declare kasan_unpoison_task_stack_below in kasan.h
Date: Wed, 13 Sep 2023 01:32:06 +0200
Message-ID: <20230912233214.1518551-10-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=memxor@gmail.com; h=from:subject; bh=1JLywslARl/eCQeLo0pwx6E32+AEHxgjPliJB0G1CfA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSt8vlk29yiHpA4r+PG7av/fkR4SzU6cnCaj 1nwE4VzaR6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R yi0rD/0Yi9KxY096Ymw+E/lHpO9JFxOcZh3SbVGRVUFU08+vUspEigPV5Yh0Vo3tVBSRxD8wcvS 5M12qjX9Fc0NlyePCzf822AUPXnkF1ZD3+5APSlo137jOjATg6eD28HIAUcS07LC2AUsgsL/EGk jo0Hv+PruQ9cWzVFdQChcMqTFSvtmmf3xeYtejc/aSyxbHPji12Pfw4TDOAcOpaN+R+LTM4c/MQ zK0IFsY1XjxOeSKqA/WBFaS86jBuQ6uTQsHQHrWmz6UK1ZY64onRxCqhmmzOYRrx7rp4/Hzg+Ee r2aecJ7salFv81wnWg3/jzUywFpxv/ZhBhsoerzDSxPwm+0Yz6nHKmdb2FsVI7dPIMmd12i8H/n K5Ynlacj9zoJTo5AXdYSzHTZCLjOw6m9+x//cqFVgF1fZooAIF7C5obZvZJPlm9L713oG09bZeF EUrEoGbvKulh6AUuzYJJr+O1FYrBkfddUc2DLstuPOUVzhau2ex/wRFORGTR2oDYbU6OEjkIxSY kf8Jj97SrnVLxR/Y3DVvpe2CSP8+/jHTYUQq3PtKSEUS2YQSS5rjdsoJbSB3tJB0iyovVHwvjZ5 CF3tiyIG/U+2Rt4fdKcaji6YKjrH8pn3tgsnzIoYRBkxdvSbI8x4cNBxIh5AAqWWnaMcJ13L0Vb Ake5738DWja6X0A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

We require access to this kasan helper in BPF code in the next patch
where we have to unpoison the task stack when we unwind and reset the
stack frame from bpf_throw, and it never really unpoisons the poisoned
stack slots on entry when compiler instrumentation is generated by
CONFIG_KASAN_STACK and inline instrumentation is supported.

Also, remove the declaration from mm/kasan/kasan.h as we put it in the
header file kasan.h.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/kasan.h | 2 ++
 mm/kasan/kasan.h      | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 819b6bc8ac08..7a463f814db2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -283,8 +283,10 @@ static inline bool kasan_check_byte(const void *address)
 
 #if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
 void kasan_unpoison_task_stack(struct task_struct *task);
+asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
 #else
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
+static inline void kasan_unpoison_task_stack_below(const void *watermark) {}
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 2e973b36fe07..5eefe202bb8f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -558,7 +558,6 @@ void kasan_restore_multi_shot(bool enabled);
  * code. Declared here to avoid warnings about missing declarations.
  */
 
-asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
 void __asan_register_globals(void *globals, ssize_t size);
 void __asan_unregister_globals(void *globals, ssize_t size);
 void __asan_handle_no_return(void);
-- 
2.41.0


