Return-Path: <bpf+bounces-8052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289287807E5
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9481C215DA
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A9182A1;
	Fri, 18 Aug 2023 09:02:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E017FE1;
	Fri, 18 Aug 2023 09:02:08 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9F420F;
	Fri, 18 Aug 2023 02:01:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso5139075ad.1;
        Fri, 18 Aug 2023 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349302; x=1692954102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryam0qmIG1JK+wGjTtb7t+L4bft6WGk56DbpSc7Jykc=;
        b=o9kGXmDMe8yOMoEjbALPHVuwTKxQHp0tCWWDf4k3g8AQNVHB1e+Yn2FqrBq2fNc4XV
         ESFsPSDxrjuyzGZtDRpWgPw4EO0svRq4wQD9yGR0qNkHpJ+mV7BO1RQ/X3tGBpg21cNN
         sKr9QuJescl2EBoZI1gA0K1lRMi91rg8uBygYaBjrWkF55qZr2oALisCDbtYDtkzvu3q
         qxLeDqvzk7bB+Gftj3WDORe5rIRJH1newVSlDQeNwXb5bmIGaYey3YP3VIIsoYw/GfC7
         SU0F6cc8gWIBsTOm7VFYfBFSc37Q1wBMjQZeJjO87vUkd3bVYNzRZZLDKfcINf/EAFBn
         JQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349302; x=1692954102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryam0qmIG1JK+wGjTtb7t+L4bft6WGk56DbpSc7Jykc=;
        b=RGfVRBwJEE78AS84+B0EJHWrIsM1PICQK0RmHIyI970kflPnBkXG1HDwZaY2uH+8Dh
         8s681C1rXEMdD4fbolidX2bYvzxDV9TTtqoSl3Pm3noEpHf7HlgDLe8iqnWFHVlHNHuR
         GZ0ftTtT/bCKdcbg5/8gf90A/y6nNYSMRCD+1dTlb6UDr0e2cxsztClwJHTTI7Uc3PRr
         IL96CV53tvOyE5HFDDN2jpWbc+QxHd1RUBJXrxGn18sGw47+kAc3j8lv0drWuyM2FUcU
         e00QfqSNVksWM6susUFa6JeAayG/buuw2Kjl1JjHBFLUqahLE5nkqHHq0dg4aZpuhe8M
         4Cyg==
X-Gm-Message-State: AOJu0Yw6pdEBKQL/EYSqXPqE1cMyInzzlu1RDb03tAeUUHGZSekhPFIO
	06yxjzJapkeNJsstu0qwJUuDQMrjQ8A/
X-Google-Smtp-Source: AGHT+IFza+NwL4iyK5tpVshvAq23JHXSQZ0E7v+gJK2uQDPegTurAoeGeePeieQfAIG72dIfH39a8A==
X-Received: by 2002:a17:902:d386:b0:1b6:bced:1dc2 with SMTP id e6-20020a170902d38600b001b6bced1dc2mr1660587pld.0.1692349302275;
        Fri, 18 Aug 2023 02:01:42 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:42 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 4/9] samples/bpf: fix symbol mismatch by compiler optimization
Date: Fri, 18 Aug 2023 18:01:14 +0900
Message-Id: <20230818090119.477441-5-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, multiple kprobe programs are suffering from symbol mismatch
due to compiler optimization. These optimizations might induce
additional suffix to the symbol name such as '.isra' or '.constprop'.

    # egrep ' finish_task_switch| __netif_receive_skb_core' /proc/kallsyms
    ffffffff81135e50 t finish_task_switch.isra.0
    ffffffff81dd36d0 t __netif_receive_skb_core.constprop.0
    ffffffff8205cc0e t finish_task_switch.isra.0.cold
    ffffffff820b1aba t __netif_receive_skb_core.constprop.0.cold

To avoid this, this commit replaces the original kprobe section to
kprobe.multi in order to match symbol with wildcard characters. Here,
asterisk is used for avoiding symbol mismatch.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/offwaketime.bpf.c | 2 +-
 samples/bpf/tracex1.bpf.c     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/offwaketime.bpf.c b/samples/bpf/offwaketime.bpf.c
index 8e5105811178..3200a0f44969 100644
--- a/samples/bpf/offwaketime.bpf.c
+++ b/samples/bpf/offwaketime.bpf.c
@@ -118,7 +118,7 @@ int oncpu(struct trace_event_raw_sched_switch *ctx)
 	/* record previous thread sleep time */
 	u32 pid = ctx->prev_pid;
 #else
-SEC("kprobe/finish_task_switch")
+SEC("kprobe.multi/finish_task_switch*")
 int oncpu(struct pt_regs *ctx)
 {
 	struct task_struct *p = (void *) PT_REGS_PARM1(ctx);
diff --git a/samples/bpf/tracex1.bpf.c b/samples/bpf/tracex1.bpf.c
index bb78bdbffa87..f3be14a03964 100644
--- a/samples/bpf/tracex1.bpf.c
+++ b/samples/bpf/tracex1.bpf.c
@@ -22,11 +22,12 @@
  * Number of arguments and their positions can change, etc.
  * In such case this bpf+kprobe example will no longer be meaningful
  */
-SEC("kprobe/__netif_receive_skb_core")
+SEC("kprobe.multi/__netif_receive_skb_core*")
 int bpf_prog1(struct pt_regs *ctx)
 {
 	/* attaches to kprobe __netif_receive_skb_core,
 	 * looks for packets on loobpack device and prints them
+	 * (wildcard is used for avoiding symbol mismatch due to optimization)
 	 */
 	char devname[IFNAMSIZ];
 	struct net_device *dev;
-- 
2.34.1


