Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35A374E0F
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEFDqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhEFDqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9734C061761
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c21so3803264pgg.3
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSG1Hq3x/TJj1qqxtVLugWySGIwwBLZf4h25dA2lve8=;
        b=LJlMVNQLPQnh9ziMPWBQEmuoEpRAvpwrgPUCJlj+W6C6Z1jZ3IsIcwn4hDBfjdvqKd
         BtaD3DG+7nk+W4GAftEV3BEOMYPN7MFRCKOHOPzelC+ZvYL7FY+w5KswkeYgAsChaaFy
         0oB91k9rwtlQw3wZQXAMnsFOFov1oJe57IJntyFVtdcuV+1rR09hvLpsfcMJZh5kzW7q
         SGU2nDjmS01kOxtknmMJagPdN/TIdNazYWAp2pRjC/GpV78G8ZumtSS4C1YqPa7WHve7
         RJuE3BVXuDGxnPYXwUL7jy7suX3L0xcmVebp3sXrJCHQ3GUXeyY9ZGPUkPoWiRMrhK5M
         +6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSG1Hq3x/TJj1qqxtVLugWySGIwwBLZf4h25dA2lve8=;
        b=T/vcedxEe2hTT2S6CoLQqurZFVELn7In/0BOiNmGtSC5ESmq26rMAZIdDX8sH76Wf7
         hpeTHQ/WmPcVoQZVfMGwMzkZqNFhqs5zueDV/WF6fEm/fZrqOcpqjr7iZrJZ0ENe+C5K
         FPHL/+/I1YeV0Dv6cff0dkHxeXLrr5/NbxXRoVgu5LwaBmMGG+meqjGdTZJsCfJcgAan
         aAsYAiLcSPGImjIP2LN08T3sX5Oh/nYzORx0I49zfkVGq8khm2u3EVHZgkxyn/MgSb0q
         WV0bLWzyUIizZR/jfc/hTjiUwCa0P9/xNW/Czuh0asd7K6ldsNQtBGflQMv75ZoUbPrk
         fAYg==
X-Gm-Message-State: AOAM532XN5IpoxQq/a8zH51J5p+r8al69QJ7LHVXXNqImxw8wlJfiDN4
        jLjHYihMP3Pj0wy/CSMV23F5Rx8Atq0=
X-Google-Smtp-Source: ABdhPJxMQt4ldFPfDRikxnGBT9o72NbExVbIQxVCfG1Q4K+kSHXQ1/2mwnpmNii4sS9450oG/I3VFw==
X-Received: by 2002:a62:7648:0:b029:28e:db2a:9f14 with SMTP id r69-20020a6276480000b029028edb2a9f14mr2467366pfc.6.1620272713080;
        Wed, 05 May 2021 20:45:13 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:12 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 04/17] libbpf: Support for syscall program type
Date:   Wed,  5 May 2021 20:44:52 -0700
Message-Id: <20210506034505.25979-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Trivial support for syscall program type.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a3cf437814..5790166eee9b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8958,6 +8958,7 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
 	BPF_EAPROG_SEC("sk_lookup/",		BPF_PROG_TYPE_SK_LOOKUP,
 						BPF_SK_LOOKUP),
+	BPF_PROG_SEC("syscall",			BPF_PROG_TYPE_SYSCALL),
 };
 
 #undef BPF_PROG_SEC_IMPL
-- 
2.30.2

