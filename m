Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957F0455A27
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbhKRL3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343876AbhKRL2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzOB74CJjcZMNcmR7SkVFYkvFIHJ/t8Pjrq9GPHfvLc=;
        b=UIMDaqBFoibn4uEuxonn4hBfaGBAhMhf/JnzdJuDkmxe3AFXiY29jOgLEfVC16AXQAS5cD
        e75r8Yd7zcD0jJHiBKl5ox2Bt/q72DqGfNkhOqNjSAgzacZaawzxawBCfa3XtiOrcOa1gd
        uwWThM3rtCjqF73X+phYZBaWzvX+4Xw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-rgk32DY4NOivbHrx4pgVug-1; Thu, 18 Nov 2021 06:25:10 -0500
X-MC-Unique: rgk32DY4NOivbHrx4pgVug-1
Received: by mail-ed1-f71.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so4991800edv.10
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzOB74CJjcZMNcmR7SkVFYkvFIHJ/t8Pjrq9GPHfvLc=;
        b=s/IIVtKlYXWWBOCYcoG8s2z3n93SDw14oo5yG51KcZ0yB9lwyeMR8DrfS2lX8Gw18U
         pG9s+Xl2ALgCXe6GokG4A5YytlQUexgcWf7G6dOK8ULnbuqA/WafeHPj6OEpahqWzEAQ
         BfJYfDru+KCM+T6nVPYCledzCmA3rxfuJ3bnnKjzbHwsR2KkeAbI0tx8SS56wpXtqyYr
         cDm+biv8AXz3F/SrEk/56j62ZCOBOd3bI7GDfPoNRyXON4B8mE1DNgP0U20UKoiHU8bO
         NnND6QT3YJcwxisojrJVrGrs8s7YqIaQmP9l7YUFdMZjq76xQvhcZ1FeTp1Zf/4C1pS3
         FZ/g==
X-Gm-Message-State: AOAM531a1kVkKgPrDWRvQ5R+9rERO0vym64nqM54cVLGkIWDUz0K1H8/
        WmqmieuPXxECNJ7XBkCPYZx6cYr86WHmWCyKJc0C2xn34RLnINmgETz3itoRv3aM6fndYGKevIa
        hqoNHUAV0sSIg
X-Received: by 2002:a17:906:b254:: with SMTP id ce20mr33752026ejb.255.1637234709292;
        Thu, 18 Nov 2021 03:25:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVTHqHxq258/wo2aBL1NVcFRVlFTjKLdyUouotZrmXT5aXHOVSBzQF1U+lUYINEmKsPxwBLg==
X-Received: by 2002:a17:906:b254:: with SMTP id ce20mr33751990ejb.255.1637234709146;
        Thu, 18 Nov 2021 03:25:09 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hr17sm1185249ejc.57.2021.11.18.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:25:08 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Steven Rostedt <srostedt@vmware.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 02/29] ftrace: Add cleanup to unregister_ftrace_direct_multi
Date:   Thu, 18 Nov 2021 12:24:28 +0100
Message-Id: <20211118112455.475349-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding ops cleanup to unregister_ftrace_direct_multi,
so it can be reused in another register call.

Cc: Steven Rostedt <srostedt@vmware.com>
Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7f0594e28226..be5f6b32a012 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5542,6 +5542,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	err = unregister_ftrace_function(ops);
 	remove_direct_functions_hash(hash, addr);
 	mutex_unlock(&direct_mutex);
+
+	/* cleanup for possible another register call */
+	ops->func = NULL;
+	ops->trampoline = 0;
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
-- 
2.31.1

