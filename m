Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43959679E3C
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjAXQJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjAXQJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:09:30 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8D4A1EB;
        Tue, 24 Jan 2023 08:09:29 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id s4so13435257qtx.6;
        Tue, 24 Jan 2023 08:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fu5eVF7dMpmGGWY5c48C3xPPttDeaZkjkMTCdf0Gr0=;
        b=1wI9tfI1qOh+StW0HIzmBcpQjt4X50Bwe8clhM5U0u8nmVfAdPnn9E2PBVeEiyYn5V
         BICYZwGISQaVg/IrkkkohvPSreQJ3uvYNFw4zA7sud5zFpMwbrwnO2oeb0grRsr6Z1Gd
         PKAV6IzWT1TyOs+cHPlVqm1oPNsFEsaUzbfsMIlEqHe4OP4pTKv7Z2aAKjMjmsf97PBO
         5n4L0MepveEDjuprFgEvSIiIfedtwi9yVEgZxluibXfoAUZ23qhsCpY2f1TJL9opVvV3
         le7e1K86UIb0OlN4L6nKOvxAs80NHBScyISAGzEeSd1VKMbLMIoUjEYEJT5ze+SzmTKN
         QbFg==
X-Gm-Message-State: AFqh2kpQgjrBdMrQE2CgiiTJZLTrooguv4VHuMnRHXUkQTgHsKgtFOaW
        vOY9KQwLHIuU9ySfs+IZwW0SNsN0sPHGViAA
X-Google-Smtp-Source: AMrXdXstmPyLF8ifNZMu8dqpsJIgCJ9ltPDbY3mn+tbvD/YHQzBbdSd2G5QJmUJylCwFjw2iRfFLbg==
X-Received: by 2002:ac8:4c84:0:b0:3b6:31e2:f537 with SMTP id j4-20020ac84c84000000b003b631e2f537mr37609803qtv.8.1674576567725;
        Tue, 24 Jan 2023 08:09:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id m15-20020aed27cf000000b003afbf704c7csm1492934qtg.24.2023.01.24.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:09:27 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v2 2/4] libbpf: Support sleepable struct_ops.s section
Date:   Tue, 24 Jan 2023 10:08:00 -0600
Message-Id: <20230124160802.1122124-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124160802.1122124-1-void@manifault.com>
References: <20230124160802.1122124-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a prior change, the verifier was updated to support sleepable
BPF_PROG_TYPE_STRUCT_OPS programs. A caller could set the program as
sleepable with bpf_program__set_flags(), but it would be more ergonomic
and more in-line with other sleepable program types if we supported
suffixing a struct_ops section name with .s to indicate that it's
sleepable.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 27d9faa80471..eed5cec6f510 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8605,6 +8605,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
+	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 };
 
-- 
2.39.0

