Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B25EB571
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIZXTS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiIZXSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63EB3B33
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:18:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v17-20020a259d91000000b006b4c31c0640so7059691ybp.18
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=qYUtbvLwl6swUO4hiS1oZSstWOFuOepYRxZkpZ1kfLs=;
        b=QAl5gMZ5lQEKrESQ6jWH98yw4KTtq0tGTjXXQeVj0ewtzidIWSgsl7rU4HLZd2LKSD
         0bHBIwLrqNvpXMJeccATvuLpBYxAfEHQqiywa9TxD1jVin+Oc+IZjGlz1oDXFe3wASbV
         3bugHwwyoW+CZmxia551z3VE1h+37eUAb+1mSkU5ENP26OohnCGnsaIhmgnDBkIi7osy
         NkEhfmcfel4lnh2SCrDApyUHNf7L3qumisQaEy8Z+VoC19x4IHl4ADnh7KHOGMp2iq3o
         +H6/pSVsQ4aMcuYQ1KC7YvLpCR0wrmnUz5F0TqZPqECiC5T6gf+Tqx+OapL6GecynrcA
         Tp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=qYUtbvLwl6swUO4hiS1oZSstWOFuOepYRxZkpZ1kfLs=;
        b=bdM8qRzw4BSOX+1KBuRJaUTIZnImpewv9q9HUGUGHyH55vwUEf+qmjCNNYcQ5A1NNx
         a/nvjIG8P6P8Kf7jsJkiFhLYGCSLI84PJDbKUEy+Jq979UZxmRyVo/S20FqXI5EWpYGC
         ZSifx1wGj9KH1e53pD4LpWBnKDWON1siIXKaXKwjUiTSyyaXNXc597zPhVnQB6UVpIQm
         BYeyt1sE2Fkmucp6Ip9s/mL+VxPnmnUnFo5MDph9kY8XNOes0oQwsDLydDbM0oekf3TQ
         uZteTdEmtv4lJjMU0z1p9uL4gW5tu6sKuB9z7+7zp4Dft2NaB6wVRwou0VlIefxel6O5
         qS5A==
X-Gm-Message-State: ACrzQf2FfuGy2XyGRin15ZjYUzSNRfF3go2AtL4KkE5PXtFPrhb4m+i6
        nqEY88DavHZ6gDLgsDY6cnOJjgnubO0=
X-Google-Smtp-Source: AMsMyM5K/9sGBw/frw91uQfR+I9ZQ4Q/SrmJEv/FiSInEBM+D5awUrUn9RU7H0V04IGCygyZf5E9jfZ/sI4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr22170393ywc.316.1664234325229; Mon, 26
 Sep 2022 16:18:45 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:02 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-7-drosen@google.com>
Subject: [PATCH 06/26] bpf: Export bpf_prog_fops
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fuse-bpf requires access tp bpf_prog_f_ops to confirm the fd it was
given is in fact a bpf program.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 27760627370d..2000b6029e6a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2160,6 +2160,7 @@ const struct file_operations bpf_prog_fops = {
 	.read		= bpf_dummy_read,
 	.write		= bpf_dummy_write,
 };
+EXPORT_SYMBOL_GPL(bpf_prog_fops);
 
 int bpf_prog_new_fd(struct bpf_prog *prog)
 {
-- 
2.37.3.998.g577e59143f-goog

