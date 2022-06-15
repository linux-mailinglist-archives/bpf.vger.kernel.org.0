Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECF54C09C
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 06:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiFOEV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 00:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiFOEV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 00:21:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883A4A92C
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 21:21:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r5so3598089pgr.3
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvi0Pet38SQ8/+46IhE/cHlf27vOO2fZhDd7hKsF5AA=;
        b=ZBtKBC4Q21X2HH+eyWp801VF7NceOQQkxttgr2EgpHmk+jP8HIR3doYI46TpPLOuAK
         n5TxTy6RrH+OqGSXdEocPbP4sOnPXtsL6eVXSLhkpU2ff2vF3KCqByWRQBQlqH95MH2e
         rcxs54cGUhDnQzt6mBCaz1XfsA76GNs+5r3kSSwLqmZ41SRTE3JHmN972FqfXMhzLQOt
         1hYlu4utvpg+VbFbEDVHxkPtGk3a77Rbi9+DJ8auBvybHbxLJ+yifz83tSKFCJbfDkdY
         yYt72hb+eFQhC7tJkEqrav41KVJZhN4qw7VIN/UBycS4blsROUkF/gjsyGAVrlTh8M/j
         nHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvi0Pet38SQ8/+46IhE/cHlf27vOO2fZhDd7hKsF5AA=;
        b=nZOwUCqgWeUsT/60OAPXYe5XZOWZoFlGJ+SkVDGigda+4YIycf45LJmIYQiabDrrDt
         eJpCCV7zkXeIFErOOzXMd2kWfMYLYd1jIxUT/6Wb8uSJbtBJul8/Vh++HMeT0nEvlW4P
         45VddRMAYPv0h/jK8vTZhqLwjqOGaP5LoqBDa6XAybzHu3mWdKYZ35dHrGLXhkG2nUyo
         O3/lI6bXL6rMqy4Tsfcctlgzm4dJwpHgokBIlhqMv7AvSSZhfMCMQlhtZDjLWZi2mP/X
         TyRURNmpT3GmLkaJ/Wi8eYmIr5cGzdiNZ34kyIQXdBn7PUYclGpQO2z5ciZEuXxNPmv4
         XTnQ==
X-Gm-Message-State: AOAM530c1GASdYxP/83kZa3lluNK+krBB4MijrnJiobnibCwRg+slmKX
        L8T7UsED9KNeQ4xtf8W6y1Q6/kCKgWQ=
X-Google-Smtp-Source: ABdhPJxsgkwPnIQ81WOKbFFAWyqLF3HUZuI17ConKVEHsBYfeUBXn5DxotBLuyKvf0yQiUjkZppRzQ==
X-Received: by 2002:a63:2b87:0:b0:3fd:31d6:6a0e with SMTP id r129-20020a632b87000000b003fd31d66a0emr7308974pgr.488.1655266914242;
        Tue, 14 Jun 2022 21:21:54 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id 142-20020a621994000000b00518b4cfbbe0sm8458581pfz.203.2022.06.14.21.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:21:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: Limit maximum modifier chain length in btf_check_type_tags
Date:   Wed, 15 Jun 2022 09:51:51 +0530
Message-Id: <20220615042151.2266537-1-memxor@gmail.com>
X-Mailer: git-send-email 2.36.1
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

On processing a module BTF of module built for an older kernel, we might
sometimes find that some type points to itself forming a loop. If such a
type is a modifier, btf_check_type_tags's while loop following modifier
chain will be caught in an infinite loop.

Fix this by defining a maximum chain length and bailing out if we spin
any longer than that.

Fixes: eb596b090558 ("bpf: Ensure type tags precede modifiers in BTF")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 63d0ac7dfe2f..eb12d4f705cc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4815,6 +4815,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	n = btf_nr_types(btf);
 	for (i = start_id; i < n; i++) {
 		const struct btf_type *t;
+		int chain_limit = 32;
 		u32 cur_id = i;

 		t = btf_type_by_id(btf, i);
@@ -4827,6 +4828,10 @@ static int btf_check_type_tags(struct btf_verifier_env *env,

 		in_tags = btf_type_is_type_tag(t);
 		while (btf_type_is_modifier(t)) {
+			if (!chain_limit--) {
+				btf_verifier_log(env, "Max chain length or cycle detected");
+				return -ELOOP;
+			}
 			if (btf_type_is_type_tag(t)) {
 				if (!in_tags) {
 					btf_verifier_log(env, "Type tags don't precede modifiers");
--
2.36.1

