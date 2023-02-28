Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2066A5AC7
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB1O0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 09:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1O0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 09:26:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F32D2CC49
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 06:26:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so40713846edz.10
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/3pYBNWncKm4wi9ktDpQiJKQCgxwXU1T+5mSzWrUiI=;
        b=JI+NWK0edDIngWi41nufR7MmMFHbWND2ljnzQ1jReclrGvtKVzBOlIY4UFkgIUlSh6
         p9R9cLNv/tUuVzcHMtGpjlSUL0T6LeaiRRS8elnkI8AjBzf9H3MWVTN0m6mSkua7eW2b
         16Lf3DOFb15oMLFjJNpPgP96Yx7mhTt81n5psiC82aYOPA8c77DLy5BQ/RPnz9iJOqcx
         mh7DRJr+hiNK7pSojSRwCFHP1eVdcloIg9RxZUWJ35cjHWwXkSPxi1Hb6CL9sP1tG1PB
         y+vNzGzy/BnXTutT+ZJSqXzmNTs9CWAaJp+6rpfA/v9uRTbhni+XuyXRi/4I//sKBtQ2
         /yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/3pYBNWncKm4wi9ktDpQiJKQCgxwXU1T+5mSzWrUiI=;
        b=5OVesHNIaylGl2rK9J18Ye1Cuer+LD40GD73XuzCbMg15yN5bnSp7vf/vnsS38MnE0
         qaYeOckNOhqReulA6tCH0nGmF0ansMvN2u3J5TpBudnx1Czf2liQO8dXK7c42oLsOH6N
         oEokK1nTQHFfDoA8r0/xatkJmjpL2oIZmCFM0cJXl/msslPw/Ak8SFwWRBx8ZWTQ/M+D
         PWVNL0C8tlN15y5UPSjBNp6Weuo+czTE1Mvkx4LMOZaXryQXFjyoXgmXU+GVIarpq6iP
         p8/BqW6iUzlkQ1SO4M3MeLC9BbDXyhs/m1uKtPaNX9bYLy39hAL0MXE7nNCekIVWSr1j
         SAIQ==
X-Gm-Message-State: AO0yUKW0t6aQ7qzIVbtj6oluQ+IORffZzorW2fqT1ItBkkbxsqt05yv0
        O2qe07l4n4sk1LPK8UPYn2UfTH+rb1I=
X-Google-Smtp-Source: AK7set/UAwZmxwHKufe3ODHakFjBE29+Juyqy/smC/SN+Lwhysejb+/2Yg8SbUEy8UYrq311GKbRGQ==
X-Received: by 2002:a05:6402:1851:b0:4ad:7055:3908 with SMTP id v17-20020a056402185100b004ad70553908mr4201998edy.21.1677594364935;
        Tue, 28 Feb 2023 06:26:04 -0800 (PST)
Received: from ddolgov.local (dslb-178-012-041-046.178.012.pools.vodafone-ip.de. [178.12.41.46])
        by smtp.gmail.com with ESMTPSA id cw11-20020a170906c78b00b008c1f68ba0e2sm4462932ejb.85.2023.02.28.06.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:26:04 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next] libbpf: Use text error for btf_custom_path failures
Date:   Tue, 28 Feb 2023 15:25:31 +0100
Message-Id: <20230228142531.439324-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use libbpf_strerror_r to expand the error when failed to parse the btf
file at btf_custom_path. It does not change a lot locally, but since the
error will bubble up through a few layers, it may become quite
confusing otherwise. As an example here is what happens when the file
indicated via btf_custom_path does not exist and the caller uses
strerror as well:

    libbpf: failed to parse target BTF: -2
    libbpf: failed to perform CO-RE relocations: -2
    libbpf: failed to load object 'bpf_probe'
    libbpf: failed to load BPF skeleton 'bpf_probe': -2
    [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)

In this context "No such file or directory" could be easily
misinterpreted as belonging to some other part of loading process, e.g.
the BPF object itself. With this change it would look a bit better:

    libbpf: failed to parse target BTF: No such file or directory
    libbpf: failed to perform CO-RE relocations: -2
    libbpf: failed to load object 'bpf_probe'
    libbpf: failed to load BPF skeleton 'bpf_probe': -2
    [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db355f28..02a47552ad14 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5683,7 +5683,10 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 		obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
 		err = libbpf_get_error(obj->btf_vmlinux_override);
 		if (err) {
-			pr_warn("failed to parse target BTF: %d\n", err);
+			char *cp, errmsg[STRERR_BUFSIZE];
+
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
+			pr_warn("failed to parse target BTF: %s\n", cp);
 			return err;
 		}
 	}
-- 
2.31.1

