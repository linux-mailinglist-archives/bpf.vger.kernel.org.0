Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFC376F33
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhEHDtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:49:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B16C061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:48:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so6532214pju.2
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rltzKfGuTM0FZ3M77es8qWnUbcE1pdywuZVdQaq1mmQ=;
        b=H30M3Dz+iwSyykTrWji2NXgIHayC1yCLXqHUytrw0zhkTuiI2NOsgeaetzWxsvim5c
         gDRiO13T50I7/jkC7Rlxy5pBgFterCFis07zxMVPquqQn4287+7z8sZk7wVaaS51qE1d
         ob7cai+g3C+s+imFi3QwppOkafFqUBlUtoessWGJTr8AntB1mnf5QS7d6oovtAZGunCb
         dG4BReETsmqA/JOD5xMFotlivgWitFk8hXJ8qlCYWifCRBOJQvb9lQQ/Rxx1/SxksYnQ
         nMb7bnc47MOnVcmyh+tvefc7oTKiHw4ynNBcz0txSVyGR+nfHfYQfsKKjHkKxGmGNjxI
         zCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rltzKfGuTM0FZ3M77es8qWnUbcE1pdywuZVdQaq1mmQ=;
        b=kY4AwSNOtRAEUKvZSS+E7ZfeQ7BKJzV3q9vAxtAYy4ek25zelyxkpmHXZGZc4t/rXO
         d99yfFqfTiuyWc916iH9X+InhN+sUgFhNpBI7byTWpd7suAAoTndYSxwt6XME2jcus2A
         3io1PeLYvutUpMBPUORAWqRG5C51DfhxZg9zxaAo5X5MzeJHf2VqWDlTFJC6NiNtcFmD
         +bACjr5RZFNY3TSzq1xIpbnAedE0Q5UaOqmtq5abM4xi2gQ/kv77T//2trnRD0JxgpK7
         gxOCRgfG/TbM6jIuSrXJPSZqpqI+SKl28huMcTnh6NQPuxdkQZ/N8peeOi49xx0Zo3Sy
         VEFA==
X-Gm-Message-State: AOAM532gsqrQWxuCTI6DK8PwohsxS451L9k0WUTb3RejBIbghFdyo+WX
        bHkklx3gLB5bnwqfOmCWigg=
X-Google-Smtp-Source: ABdhPJwO9o7JNzwhARRQXoGiGKxUwUA/VjzCpzKO1zOKM2c7hG+8iviiRwOREBimR8rLIXKrqXV4kw==
X-Received: by 2002:a17:902:8205:b029:ee:aa49:489b with SMTP id x5-20020a1709028205b02900eeaa49489bmr13874849pln.5.1620445728474;
        Fri, 07 May 2021 20:48:48 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:48:47 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 04/22] libbpf: Support for syscall program type
Date:   Fri,  7 May 2021 20:48:19 -0700
Message-Id: <20210508034837.64585-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
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
index e2a3cf437814..491349a31a06 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8884,6 +8884,8 @@ static const struct bpf_sec_def section_defs[] = {
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

