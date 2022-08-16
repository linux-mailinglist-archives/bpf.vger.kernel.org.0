Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823485964EE
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiHPVuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiHPVtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:49:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85B6BCDA
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:49:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u2-20020a17090a2b8200b001f74f05c1a7so4598875pjd.2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=+IZonXkzDm1dEfVfdUlFehFeeEEGH9j0xN4V/zmAjFg=;
        b=hUfqzQwnfCoU3faaWeSpDvoPKyMwGRIv0zbWcQPBPXQ24yDBBkjm74Nz0VOOeLO+CW
         DQnhLkbbHAqAuPNnZ8ZtbPh035HjSDPyEi5noEEgV7u+tcLGcwURxBgJg7VqqUSRHlmR
         HAWZVgAq82DZvdMQp2ce627ee8ArThgBWJsad6S3suURK4sQI/WB4tazSFyvcNr0yWYl
         0Qr4rDYjMSir8BzoDnEv7qp82Oz7wGw3PA6zI5ZLen7qS/rR2nT8VZ3vOA9cuAVMWTgT
         1P38iZhZa4EAYba+VYn87vYfl6Fq7bPNTzwcMhM9+yMhwrOuwHcRbIrtlzPIsHCJUWOA
         cVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=+IZonXkzDm1dEfVfdUlFehFeeEEGH9j0xN4V/zmAjFg=;
        b=4cRWRE6CygeyXGp3Ke0mdmbS62JPytUQ/Qm5ANGmJLoJ0UZXLoRbitH26ehWdOyAwb
         YENAcfetDo7mzQdqvouQ2WMBpacud5p2xORq0RuAYtstqQy1nMaMLEhz2AKp8ItUiLUx
         5Ka/tVymmeNZulOsPICobU3ZIPfGnzgS4082Xtsvr2E4KxjIggXQ1/oHL77aUMYJRrwp
         pzB+x5vrd6xdbMjwW/L9Aqj9nJERqz4bTi05+jMkcOQxH7qlxh1JDlQdXR3Fev0sN1DU
         uDJ1NJNY51zQiKDuC31FVku4qEmduNMSc5o6jUfHyn483anDkJ0RUmBb74VjdRcLJFVZ
         6Fjw==
X-Gm-Message-State: ACgBeo37XMBmZU/9Eiwt4wLKfDM1w3kStQLkMZp5skf9r8VXbMZNsAri
        RujB53HSGQSn7nXceMeNwCgpzSoZZx4=
X-Google-Smtp-Source: AA6agR7XFdifIKPgmL8Q6duKo79x0wbP/flH2ziJSlt3d5V2GIzO+qdqLZLi2pBy8ZVqMFQxqftWFICxFMk=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7e6e:c287:3dc6:d4d8])
 (user=haoluo job=sendgmr) by 2002:a17:902:ef96:b0:170:d01d:df13 with SMTP id
 iz22-20020a170902ef9600b00170d01ddf13mr23999754plb.53.1660686590091; Tue, 16
 Aug 2022 14:49:50 -0700 (PDT)
Date:   Tue, 16 Aug 2022 14:49:45 -0700
Message-Id: <20220816214945.742924-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next] libbpf: allow disabling auto attach
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf APIs for disabling auto-attach for individual functions.
This is motivated by the use case of cgroup iter [1]. Some iter
types require their parameters to be non-zero, therefore applying
auto-attach on them will fail. With these two new APIs, Users who
want to use auto-attach and these types of iters can disable
auto-attach for them and perform manual attach.

[1] https://lore.kernel.org/bpf/CAEf4BzZ+a2uDo_t6kGBziqdz--m2gh2_EUwkGLDtMd65uwxUjA@mail.gmail.com/

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa05a99b913d..25f654d25b46 100644
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
@@ -12349,6 +12362,9 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		if (!prog->autoload)
 			continue;
 
+		if (!prog->autoattach)
+			continue;
+
 		/* auto-attaching not supported for this program */
 		if (!prog->sec_def || !prog->sec_def->prog_attach_fn)
 			continue;
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
 
-- 
2.37.1.595.g718a3a8f04-goog

