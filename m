Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033A6D7D9A
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbjDENVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjDENVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55626A4
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m8so9965828wmq.5
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1ibP54UBIFDrVN+8ZpyYzPy2B5kwF7GB0WoEFOJNkQ=;
        b=I7IsV/X31tR0Ira2FwARXcW5Yy4cOrX6CENASdwbcU+LAsHnf+1wZFV7iTWz9W6t4B
         TV760CvU5UUBTa8ZZTyK26RA7hBDUrP/TSw+WDsk51GDYkEr/eQMq1S97i/e0foBGrnL
         3TPLMd1sEGmDWQZDzKo9bB5jcajDaAQYOd1tOwvVoCQ3Qvwc5d9baUgYmBGdbPQm9OWg
         XPpAvbDUBBkyHV7dbyIQT+n13gX7p/ssKJ1pegGLQJpESfJTUleVl4EDqYN4zUEEZiHh
         j1YLMWLxRknyNtEak/aF6cHtbyajtbDcFKhBRExfhLqXLGiFZXTw0+VlQs7DHzP5QTDU
         dRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1ibP54UBIFDrVN+8ZpyYzPy2B5kwF7GB0WoEFOJNkQ=;
        b=46caajUYTlInqjyuJ7LHfuVr60tPecwbJ3ldf7BnCWk2KwKGGy4woeffJ6cVGq2WjO
         PjcK+ZPl5w+EERX0zcF1Nr7e+qzEttUrQRLX6Yze1CJNF/b2NFlDn5jgNOGiUxto0G13
         I6fjWcyCdx3aZ2D0NlUPdr6X74DcPCWeVPF24IiEm7tudiV9VI8siUmKLBA0gIa4xzgH
         SVVu1XvaEBSgjJSyosiPuKnVQsVxVuYrM1510gOANYEEzgWeQFhawJwlQiHWCdVH7lUa
         7Dv2zrF8GRK0G/RTKv2MrurrdA6Qb4najyzZ0seTJE6gE8T2/aDIhkSyWiOhyGze4djM
         xKDA==
X-Gm-Message-State: AAQBX9cF+5KVHJeCg0KEAMKphNUCT66G+phZIyuKR/8feM3R20d5sW43
        uIR+OthcY95a5UAGL16f82VM5Q==
X-Google-Smtp-Source: AKy350YDEAfZJOHHN580cBgXMrp6M1p+q9347mSFKNTLaLzsJwhCBNc+SXl+2p3MK5nHY+siYaFVdA==
X-Received: by 2002:a05:600c:b4f:b0:3ed:d64f:ec30 with SMTP id k15-20020a05600c0b4f00b003edd64fec30mr4516051wmr.33.1680700886823;
        Wed, 05 Apr 2023 06:21:26 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:26 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 4/7] bpftool: Return an error on prog dumps if both CFG and JSON are required
Date:   Wed,  5 Apr 2023 14:21:17 +0100
Message-Id: <20230405132120.59886-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
References: <20230405132120.59886-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We do not support JSON output for control flow graphs of programs with
bpftool. So far, requiring both the CFG and JSON output would result in
producing a null JSON object. It makes more sense to raise an error
directly when parsing command line arguments and options, so that users
know they won't get any output they might expect.

If JSON is required for the graph, we leave it to Graphviz instead:

    # bpftool prog dump xlated <REF> visual | dot -Tjson

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 9 ++++++---
 tools/bpf/bpftool/prog.c                  | 8 +++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 35f26f7c1124..a3cb07172789 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -255,16 +255,19 @@ _bpftool_map_update_get_name()
 
 _bpftool()
 {
-    local cur prev words objword
+    local cur prev words objword json=0
     _init_completion || return
 
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-	       --use-loader --base-btf'
+            --use-loader --base-btf'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
+    if _bpftool_search_list -j --json -p --pretty; then
+        json=1
+    fi
 
     # Deal with simplest keywords
     case $prev in
@@ -367,7 +370,7 @@ _bpftool()
                             ;;
                         *)
                             _bpftool_once_attr 'file'
-                            if _bpftool_search_list 'xlated'; then
+                            if _bpftool_search_list 'xlated' && [[ "$json" == 0 ]]; then
                                 COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
                                     "$cur" ) )
                             else
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d855118f0d96..736defc6e5d0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -849,9 +849,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
 
-		if (json_output && visual)
-			jsonw_null(json_wtr);
-		else if (json_output)
+		if (json_output)
 			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
 		else if (visual)
 			dump_xlated_cfg(&dd, buf, member_len);
@@ -940,6 +938,10 @@ static int do_dump(int argc, char **argv)
 		usage();
 		goto exit_close;
 	}
+	if (json_output && visual) {
+		p_err("'visual' is not compatible with JSON output");
+		goto exit_close;
+	}
 
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
-- 
2.34.1

