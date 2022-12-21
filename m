Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAA653742
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLUTzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUTzj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:55:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08326AA4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:55:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d14so23450437edj.11
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDpY8eXQnR31vDv/hAEogmXTX86hvb4cFMl7BLiqYmU=;
        b=CdojP4kOwKnkm/3tJ0fwwgiSGm2ckaeouWf4meonSAZrsGDHoQIDukZhPd4hibbAeo
         DX8YE2PInUDbz8/HiRNou464YkTmN/upcjWmK0cwnnxP983cv4wBxY8LfEHOM7j91rC6
         in8oT77Q8VmARZ5yd+wCCP9ZQvJhlyqr0Msdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDpY8eXQnR31vDv/hAEogmXTX86hvb4cFMl7BLiqYmU=;
        b=31nCWIMNo/HJ6PQQSqdASKC3S4xmC/UHWIUpElJdwkBpGAZXYaMpcpUvC//D46Sz+M
         cACtJmLXUVSQPADKIpENLu6LkeA92e8I6bPuMtaURqCUQp8DvL9gDi1wy1P6NStYTfJL
         hVfcBaD3l7c4K20eQb9yjp5Fc6Um3tuY7TDszJQGNpQuF4zziVh7ekA6q+899ZyNCpR7
         EF4aB4VYAu4rus12rkeI2r6SSULUcNC9sLpHaVxItCt9/4AkO0qK5hPI8ZqP6FrzVTag
         QcGVCqdO0bAtRKY6YvjI0Gefj7FqlV0gYVVp72MN3GRHbmlknco3ojxCU70TOq9TrCcC
         ddGQ==
X-Gm-Message-State: AFqh2krRh/JuJNgzfQaQ7IBbgMdq38MmkkYn9G5JVXlgMO6zrsFx5gxY
        /c/D70JmDHkbag85YkF1eo4+8A==
X-Google-Smtp-Source: AMrXdXtbeSysvrQnX4J/n0BRL+ui9qtOJwAQQ8vqXyIVf/1zOytK3Pvkff/VAPOVp20LJDth2bpnZA==
X-Received: by 2002:a05:6402:558:b0:47e:5b70:de7b with SMTP id i24-20020a056402055800b0047e5b70de7bmr1961383edx.19.1671652535931;
        Wed, 21 Dec 2022 11:55:35 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090676d600b0080c433a9eeesm5586005ejn.182.2022.12.21.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:55:35 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 20:55:29 +0100
Subject: [PATCH] bpf: Remove unused field initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
To:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=oJ2oob+OSIF7kWeCn8kKWNN2TjOq3zxbD7ZuB1oIGg8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2Sz0BzcDBqxuAFxDAOjbqq++6jm3aPwxe7NWrxe
 4+2PVLiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NkswAKCRDRN9E+zzrEiOI2D/
 9AzaS8R53TwYp+QQybEExGc3dyoRGwGB4fBDXlti82+f7dTgL4K8OKqpu27Hmp6YEamzToSvtLUKt+
 Xf5DGm0ejHzPRyee3gq7KX4ZSKSZUacHBuBidhpuxYBwA/k1/SSYt0AVIzyKBD3l7eHN6rR1561yMr
 6Jfbo+WuFww2tksLHN6CnI1thn2xGGUYdo6XzdjTuG7F1BDP9sGDdsVdZQwTGZZpYWgoO9lOpwgq3d
 FWFYmZf9hNMuuTLk9CbpUUsf+1zaS4qzaCUwL9/0ak5YhZPyquE2xIqLUIWk99vzCcDmLyed5BKSd2
 xFMXjsjPyk1SDZgYIvkeznWa1SKGkAPPy9i8IyFSKVj4A2tO2wKLPdqfEHg5yhf8xuuTcSh3VIknnV
 PLGCB1oCQMPUJH8SzxRxhJ8OS+F+ZXc2zEmdRj+BIofYQs0kk/WccH59zj3JA2wmlaFPg+H8a+tImX
 1tvBc4I+WPb74PAbUJj/5CQjltv+iJk9GzHXIE7UH/vzoj7loGEHIdsY2cmuoPaAh9fBHyN24fCo+a
 LnjWut+09mykw2hRk02dDj/hXChQImXxZbTVhtoprhdNOy4DpgREOJDGvlVfWfo8kmf54qSe4e3uON
 lwQouHwYJjhYuCeycqW11pXWW9gleXMNUNVTiFmtoO/EtU00Nvb8tpyZHzTA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
case we have our own proc_handler. Remove the initialization.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
bpf: Trivial remove of unitialised field.

I have inspired myself in your code and heritaded this bug :). Fixing this
here so none else makes the same mistake.

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yhs@fb.com>
To: KP Singh <kpsingh@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
To: Hao Luo <haoluo@google.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..8e55456bd648 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
 	{
 		.procname	= "bpf_stats_enabled",
 		.data		= &bpf_stats_enabled_key.key,
-		.maxlen		= sizeof(bpf_stats_enabled_key),
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},

---
base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
change-id: 20221221-bpf-syscall-58d1ac3f817a

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
