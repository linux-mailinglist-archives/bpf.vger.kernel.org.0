Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28B86D8C0D
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjDFAkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjDFAku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E17A9A
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 17:40:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so37424548yba.14
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=McDcXFBeTpRROxQUqMA2pgjkFzg3DM0Jer8s1DpCFu0=;
        b=k6n8mW0A9t/ctuMHEzGCgb/5wxgpyQ5jaCdkYx8TZ1jyPWjcmMfd4/5a7xdPJ7enxv
         i6p2+isHp8Qg0KGWx3DnJa0nLQYm67mK4V+T+/O2O8Jw4X04X0osjYtQZhCU08gXjXCk
         rNfSEiCcH5hxmP3Okc/9TNGb7EbYdpnTgsgC8rOB5fsWJe86pmDimQ4/JHFfmt2JWfIT
         4+w0KwFg97MC7sTzOC2YFeE/SaejQBNBB5gDhyf0sIpuKngXGnqbp3Vms59AB6YDcSz7
         +bbmEnegVj8U592jfJ8TMuMw1MuZwJaGllugkf5y692Kw8YYrTXZJuDKUmdg9D9nBWcd
         0WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McDcXFBeTpRROxQUqMA2pgjkFzg3DM0Jer8s1DpCFu0=;
        b=w4JKA/iBDw4vUNY/ZSB+AWTOJqDUDfxbt1nxpZSATPtpchbVyrDlfBVPUZszvog+tq
         ijOMY26Bw7SK2zpzTO2yNqUpMp8eZ0WunqJdQh7z/Tw5DcYnKc+ajV1FNezWUmf96nmC
         WTCq9Klt/nDozYkW4nYkcIt7laJA+YVPnRHyG/4gwHaM0+nym1DmnkGz5Rv9kW4HcMIr
         DG5/plvenZCwZ3Me8Faju+TmS3YpVpawIjakUuVKvFZRfe5dMcI8trSnRZTgkcd44Cxb
         bPSMeJgwQU7CUFtrjufzAdo6TFRKD4J/0FW/ZWZSuJEJ0oPNoVngKbI+hZxtIhHEGJAR
         wf9A==
X-Gm-Message-State: AAQBX9dGHllC6gQ6a+yUuiq2QWT6Sp5WigMNqv6bxk6HHpgY2bdkayx+
        h0/FHWnatJEqtG0XsDEqhrKy+NLXD6BlGg+GHPhWtk09nGcsbIQAmS4pwap71QBfAHOMiXYMAou
        YJr9IjW/zswylTApxCo3NOwhDZjov5Dn16s1e/TvHa6cUnZp+WFcOhSDovg==
X-Google-Smtp-Source: AKy350bPNIOIE//zV7JizIt83+G0W/fEKuaqLntA2Yk+VZnnixxP6m5jp+KnUzV7Yr3N1wuiNhnbMicZVAs=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a81:b609:0:b0:541:8995:5334 with SMTP id
 u9-20020a81b609000000b0054189955334mr4835018ywh.3.1680741640430; Wed, 05 Apr
 2023 17:40:40 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:16 -0700
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
Mime-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-2-drosen@google.com>
Subject: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows using memory retrieved from dynptrs with helper functions
that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
can be passed along to bpf_strncmp.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f569811f70..20beab52812a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7164,12 +7164,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
 	 *
+	 * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged with a dynptr type.
+	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
 	if (arg_type & MEM_RDONLY)
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
+	if (base_type(arg_type) == ARG_PTR_TO_MEM)
+		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
 		type &= ~MEM_ALLOC;
-- 
2.40.0.577.gac1e443424-goog

