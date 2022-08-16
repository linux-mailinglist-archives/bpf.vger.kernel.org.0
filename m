Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20384596613
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiHPXkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 19:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiHPXkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 19:40:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66072EFE
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 16:40:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334d894afd8so10630817b3.19
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=UNi3nY4e74LKnS5YZ6ZQXRLBLNXdoKR2Gl4hi8aAWbs=;
        b=Xmee1qyOOONHqAhhrJGYFvgUBhm3gCjCEV5vgj3L9ZM1NyG4ELIV/0YWtfNoQzJc3k
         nzNypeYlgJGUpxYl2Q1stqtMwxIcN3nPj7v3JW2cDRnTceyzza8Dc+yR+jO4KkeXIF6V
         WW/PSazQCY8bbJFqkbz0KS4Sg2sL25EuTtyPvwXEyVneM1LNiQSPoxgmJLVu7l7BzQeg
         RARedZ7NT8BDlr54gOToUf0PPTCSqAmELKUlN2kX6NcpgOjpjZh1fHH5Ho9FzS9VEHTs
         HVkUYOlO2zrgg6y69bWlOhXswdGeYdm6wR1CJL/+gG//5JqiIJKrnBTiqkaIK46Uc5Oz
         AhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=UNi3nY4e74LKnS5YZ6ZQXRLBLNXdoKR2Gl4hi8aAWbs=;
        b=MtjkMz0D120my0YCjyC7YwsunqW1o1W7m5G1kvZ0qA1riUjbCjSLoR0Smo9zcZzRJ3
         aW105mn2Rz/XUatf/WCc0upRlkUcB7fKVmGf5YJJ87Sjo7sKr6NCik/kkISuQaa0hFGu
         cjFyYzv8u6axLxpdjhyRxyrgI29qhtREmaUxjQmnJWFIpMQbRa6XDknuqMGDsgIW55mj
         7cfp5gN5gdXUmL2igRDCePbn7jLAREdYfGRFMRvAa0vrLZVcOTw+t71qBt3U1D2wMyvJ
         BDd+7w5hikM4NfrCsPhV4HosFsMhqODp2WQLBHR+aDZ17JSzNglZHl4csTFvE3OVqhMI
         1RYQ==
X-Gm-Message-State: ACgBeo1pVgGGL3Oi/XYab0eOfO1dIr+qllwk63OrGQ0nAriHrgcVQ+N1
        S/1s9pwzQS0Gy3sPYoiW+KotEuob8kU=
X-Google-Smtp-Source: AA6agR7nLWQJjytbdBXE8SR1wADUvUrjNlZbAQtIn1LNmfCYCa89XbJSlbCkY6bFv4sjNu0fO32SQfPBdMo=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7e6e:c287:3dc6:d4d8])
 (user=haoluo job=sendgmr) by 2002:a25:404c:0:b0:68f:d76a:4a59 with SMTP id
 n73-20020a25404c000000b0068fd76a4a59mr1256750yba.410.1660693215606; Tue, 16
 Aug 2022 16:40:15 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:40:11 -0700
Message-Id: <20220816234012.910255-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 1/2] libbpf: Allows disabling auto attach
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
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

Adds libbpf APIs for disabling auto-attach for individual functions.
This is motivated by the use case of cgroup iter [1]. Some iter
types require their parameters to be non-zero, therefore applying
auto-attach on them will fail. With these two new APIs, users who
want to use auto-attach and these types of iters can disable
auto-attach on the program and perform manual attach.

[1] https://lore.kernel.org/bpf/CAEf4BzZ+a2uDo_t6kGBziqdz--m2gh2_EUwkGLDtMd65uwxUjA@mail.gmail.com/

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c   | 15 ++++++++++++++-
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa05a99b913d..0159a43c7efd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -417,6 +417,7 @@ struct bpf_program {
 
 	int fd;
 	bool autoload;
+	bool autoattach;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
@@ -755,6 +756,8 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		prog->autoload = true;
 	}
 
+	prog->autoattach = true;
+
 	/* inherit object's log_level */
 	prog->log_level = obj->log_level;
 
@@ -8314,6 +8317,16 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 	return 0;
 }
 
+bool bpf_program__autoattach(const struct bpf_program *prog)
+{
+	return prog->autoattach;
+}
+
+void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
+{
+	prog->autoattach = autoattach;
+}
+
 const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
 {
 	return prog->insns;
@@ -12346,7 +12359,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *s->progs[i].prog;
 		struct bpf_link **link = s->progs[i].link;
 
-		if (!prog->autoload)
+		if (!prog->autoload || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 61493c4cddac..88a1ac34b12a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -260,6 +260,8 @@ LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
+LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
+LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
 
 struct bpf_insn;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 119e6e1ea7f1..2b928dc21af0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -358,6 +358,8 @@ LIBBPF_1.0.0 {
 		bpf_obj_get_opts;
 		bpf_prog_query_opts;
 		bpf_program__attach_ksyscall;
+		bpf_program__autoattach;
+		bpf_program__set_autoattach;
 		btf__add_enum64;
 		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
-- 
2.37.1.595.g718a3a8f04-goog

