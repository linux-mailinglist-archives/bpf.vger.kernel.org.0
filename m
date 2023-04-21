Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290FF6EAF26
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDUQb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjDUQb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010D146D3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so250914066b.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094683; x=1684686683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QawXbYm2BNNDAqvsFceWXopDWXSa/LpW2aGecG4oFF8=;
        b=VQSSMPB31S5PwRLjZaK4macUK4s0XdqmAT04f0dsnVQ4fe2sjtWwFjyjsHDfJYzGqS
         +eydFllMm4gxWFg48Yei8kfLV0ym/POAGOyOH1oCgDSwwo7HXAmVC5k+HZs+E+nNrAJf
         zJ4Qb2S/4LJ5b6F34tQwt6Dyrc78t2GYMoFJp0JHVP5HfbiFcBktq/12pU5O/G4U9vtS
         U8L9P8qrrTymIkXcadRypnjt5eu6OV2jkJOsDqWmm4ncaMnCh+PyF7Zh9SP68bZ/91Rv
         YeTlsv8JfVQiAGk6xJt6fIe9644vbhM/X7VyjU404heIvr7IGDe1H5HmTVdYCARmbtBi
         vTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094683; x=1684686683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QawXbYm2BNNDAqvsFceWXopDWXSa/LpW2aGecG4oFF8=;
        b=UYZb8vczLQ2hXhxb7qnR9Udtq8D46+ZPpxizWoSmTNpA2S/auuOc8hXILU7T40SqPK
         HTNmLzOpB0lM0ne1CknPdhfPjen37ln0DeWGXcTg9F9SkfjuRUQVUzDrNygUayvWG/+8
         IDw6ZVgrkflU/nVFUs60tkOTj6hqqtwgN02jTGL6/epZNtjcfpjKY7h79oTenzeOkI1O
         sr/komHIgcT1WBAlG1cZVOSI0+X8N6kP3q/7rcyDZN6K9SDwT0A3lluRilkJS705rHSl
         ubsLcyVTwKKYJ0rDXSabzV7FARjMquvnOrbdb6B0AxQXWtPKY79ttAP8ZIjc5pH4RJLH
         UDuA==
X-Gm-Message-State: AAQBX9cEtfYtHuchdkHG2/OxlYTjvlgKlpQTdQi9ZspsGKdRJDEIT4Bh
        LEBFkCgMgBLpRc0noOYopdBw3rDJQs0R0g==
X-Google-Smtp-Source: AKy350YOwFR7vgRr+oX0r8KrBLyYWUIR+HLZ0MMMYa6Ue/kGSd2KHJ8jnMGaIK/mqoXR0GFW2IEITw==
X-Received: by 2002:a17:906:3fc4:b0:94e:be0:97 with SMTP id k4-20020a1709063fc400b0094e0be00097mr2788263ejj.26.1682094682683;
        Fri, 21 Apr 2023 09:31:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:22 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/10] bpf: Add BTF_KFUNC_HOOK_SOCK_ADDR
Date:   Fri, 21 Apr 2023 18:27:12 +0200
Message-Id: <20230421162718.440230-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for adding a sock addr specific kfunc, let's add the
necessary hook for it.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a0887ee44e89..1ec9a8590c72 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -212,6 +212,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SK_SKB,
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
+	BTF_KFUNC_HOOK_SOCK_ADDR,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -7802,6 +7803,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_LWT_XMIT:
 	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
 		return BTF_KFUNC_HOOK_LWT;
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+		return BTF_KFUNC_HOOK_SOCK_ADDR;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
-- 
2.40.0

