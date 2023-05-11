Return-Path: <bpf+bounces-339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB55F6FF442
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4BB1C20F74
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26461D2AD;
	Thu, 11 May 2023 14:26:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C91D2AC
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:26:58 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1711568;
	Thu, 11 May 2023 07:26:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79896065a12.1;
        Thu, 11 May 2023 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815200; x=1686407200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omcL1tQTkN45wCKai+1Kbbd8238ac0Z+pI3Znyzufew=;
        b=rKqibNf1l2a12KI79rqt5KPK4zm1S3BNWMM35Ahix1Jc8c38zD5DWVJbqB66b+JtD3
         HDU694w3CQsEfsLkGWy0XOzhc04GoQn67u1tAxOkUHBAHSyWwR2C0rvfTjwL9x6lzlLs
         6Gma1AQHwBXhb9DLBkBYQivjRJN3QLF93mnwRSqrsxW7RtI0Tzqn0cYU2e/IlQacAzSQ
         THkQ3suYfAAtNs7YgMY3bW0jn9CjozSNmVMRZTbSompRGyVpVRWzGgDRvDMwQt/743i/
         Sl2JgX/H2nT3b/MUg4lk+1Pb5Q7m7krVG5qak/G1XHT47hcHnmrbGGUnc5Lus57t72sL
         6KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815200; x=1686407200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omcL1tQTkN45wCKai+1Kbbd8238ac0Z+pI3Znyzufew=;
        b=hpRoIZRMIPq8Awpp7AUQuW9wovA3V9TcS48ycEk9k0OPyrHV7XhkUkunQu5nJEbJjy
         Kcme4BMHJuD07XDHPLidTP06SBxWuCDm3UncRo24mhySO/IOrN7mLMI4UX1EzQ3Bk00z
         Kl/BGCf1n3HL/Fgii6RrKoJ9/4UV90xDiSW7H7guHOdN45ZYLL3W+ost1t0x60V3iBck
         VUdZunxQo8RqEXEUUgW3Hu7oZLRokaHboiVkgsZDgIDYX01KV9m9FRgFwwEkmKGAqlkB
         lEDqA9U6C2yfvoPuqS3vG5UX+MOnZ+PJstNmW9QLZZXxvLkxRA75Zjj9335hMr9O7ud/
         wM4g==
X-Gm-Message-State: AC+VfDzt7iHoeac/KnCF1s+y8IuAzfrpd4HUKKkD/9QEzf/Vfo3RAE27
	goam3nqTyM0u6otbzOHT58juKFO5IsVl8w==
X-Google-Smtp-Source: ACHHUZ47ZDUYzcnnTlMiXileQs6XajtPBEqjImbXXS/KqNT8pstu7ycYLXSHsE2eSNz9da5Qb+aZiQ==
X-Received: by 2002:a17:907:1690:b0:94f:6316:ce8d with SMTP id hc16-20020a170907169000b0094f6316ce8dmr21600343ejc.34.1683815200236;
        Thu, 11 May 2023 07:26:40 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:39 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrei Vagin <avagin@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 7/9] kernel: use new capable_any functionality
Date: Thu, 11 May 2023 16:25:30 +0200
Message-Id: <20230511142535.732324-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..6e00933e8ef4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2371,7 +2371,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		    !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.40.1


