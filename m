Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBBF4C5229
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiBYXod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiBYXoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74B1A275C
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s133-20020a252c8b000000b0062112290d0bso4893583ybs.23
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CSyFxfUZpUzPLuCXdgJGZClgw+3AJRlfu/i2BCEdHwc=;
        b=WeGdlmUqXHjVbARfDifYeaq/dMDQCvyVTPwaPTxPW4KG8eTZQDll26EEGndOpSiHKE
         O2oyDy8pB8fJFLNeMvX+/y3ET9UeDjH3dyk8YZnyif9DxqF40ioemsVYcnVfVmwlljlZ
         TI1yWSmE3ArYWQEuNs8XIqXbRgNntoqP8ZQc8cTYFn+rXTN9mKIAGs+ODtdY2/7/dpF1
         Mlx2LIVyU+OWV8LptNe5GGrjvcRVEqgm+i9y4DmgSkq3eGyIdnTmcWSA6dmVKtf1Bow+
         wCwfJyzUhGMPRZmVKFgs/mCIVO36zfE1LI32FpabZPaXDSuiHPNgUPnHVdWzjEAMKIL5
         zhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CSyFxfUZpUzPLuCXdgJGZClgw+3AJRlfu/i2BCEdHwc=;
        b=maahD+ZBufI70FYVlEUWFcDrN7VvvCOUtDKhYWOxUZxnTmAqWoXnjEj/u1EFFwNG1s
         OA4s3FYCb+SbCaEfntP0qD2AW5qOAlzlL9yPgb/4OPL1+qlUHTKV/xSW2hSFDsSj8wmK
         UR32/oExxj/+lLk2fSMnsRduTzP4zWFE8mz+CeuOmP8ihr7S4NXXg+ILZNrHPo2KBiuf
         dKOuBPtLpGM8z7z+b11stnn9qlfa73/Zky900mghIXFoYoU0AwRtNP3e8k8o2XPVlz3F
         DoDhiX32/5XxVZGrM2OaGh5XyR80Xa/R+POoyD1f3FalzTRqtL1Q0TUvK75OZWcztai8
         +ajQ==
X-Gm-Message-State: AOAM530/1xLgr/neViSckey51qcvzl0KMwV5cuIe0qCu81mxKvsKVKFg
        WEfwFu3YmlWxr/wqXzEae12f6uvTUIA=
X-Google-Smtp-Source: ABdhPJyRV+FC7RXrcuAS+KiM2C2hXhTqFOLuXMoFojAkUbWorNMJ49eKnvj8E76UedfW3Xoi/Qwx2zKOnLU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:25c8:0:b0:622:82ce:ec7a with SMTP id
 l191-20020a2525c8000000b0062282ceec7amr9568082ybl.66.1645832638179; Fri, 25
 Feb 2022 15:43:58 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:36 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-7-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 6/9] libbpf: Add sleepable tp_btf
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the previous patches, we have introduced sleepable tracepoints in the
kernel and listed a couple of cgroup tracepoints as sleepable. This
patch introduces a sleepable version of tp_btf. Sleepable tp_btf progs
can only attach to sleepable tracepoints.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 776b8e034d62..910682357390 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8619,6 +8619,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fexit/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("tp_btf.s/",            TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fentry.s/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
-- 
2.35.1.574.g5d30c73bfb-goog

