Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4590738012D
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhENAhq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhENAhq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC29C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h20so15258192plr.4
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KgdUnT+4qRwNP8gechxQyYHrwC5jzSNniz7ok2Bf28=;
        b=r4IT0gFw5JoCLPgePcs1vMocpEmYfLMncyxvGzEsa6feCFWgWNq6UoXdpJBeXLmysu
         +6R9P1Rx/mKNvjE2AhIXwJGnKqU7V1uKyt3eog9uplOAmqwybmgU8nT0Pu49IrJd9EKj
         tbJdWvIi8ZJhwxyJ6qgs1xF5Qp45+0xjBgJK5tsT7/OoaDVlGcQn0jjqmVRUjKWMGcIO
         pUFAsjA5MXbNN4Yn5vo9bxHhJcVLflnWI5hSIyaaDmN0ftfvE7ao4XKrlsqxvShxoc83
         oFQ7DP8nUC+GDkdVIEGMdJ0qHEdEvRUbV6ej1BPbJ6H8FL+d4X3BYX0V2EnCGVR5BVWO
         RoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KgdUnT+4qRwNP8gechxQyYHrwC5jzSNniz7ok2Bf28=;
        b=qbrfqp5ygz+p/loVYM1Xyiyv9R+Q/Otd7sJK/dZ7e5DwO54IP+rKijmYGQ2ZEeBRiG
         viaWeAqQ1JcS6hmHvg0c1P0b3LeiDI2yPI6GcBFkbf9kYBTifYeZitYfYI1NPMpFOQFY
         fqG7bJbBFayfQFL4jG0cXihPRXN+JpLoMQgKTPNtuO9AThPxkXZzaMdA9GlO0WeTRIU+
         Abm0KV+Ts73tTExAp2Tgv/TzDvuSX7gvYApesnWBI3Rr3qHeByEr+7MeCZlcFAeLVUrc
         2cyxkYxoQFugr9tI11oH2sBTT9QbyK9NW/sOS6kAh4hpJkjDlWk5l4vvp1v4SZc0qbhU
         sGcA==
X-Gm-Message-State: AOAM532YA6tAzXCFK6BO/au5WfAkOt8HFmUEQqC+ClEejXLUjgtWIHX8
        K5jTxsR4f5TUi7tBbA8UB44=
X-Google-Smtp-Source: ABdhPJwgjX4cGlF2rsJyR1ujxIBKwsWVjTFj+EaCzprOKNK7sRpUDmDWXX6rtVid2nY0cjLsmbfg2Q==
X-Received: by 2002:a17:90a:5881:: with SMTP id j1mr21103651pji.122.1620952595687;
        Thu, 13 May 2021 17:36:35 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 04/21] libbpf: Support for syscall program type
Date:   Thu, 13 May 2021 17:36:06 -0700
Message-Id: <20210514003623.28033-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Trivial support for syscall program type.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 182bd3d3f728..c6be3477494b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8899,6 +8899,8 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_ITER,
 		.is_attach_btf = true,
 		.attach_fn = attach_iter),
+	SEC_DEF("syscall", SYSCALL,
+		.is_sleepable = true),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
 	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
-- 
2.30.2

