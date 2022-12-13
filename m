Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3327D64C08F
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiLMXZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbiLMXZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9B26AD1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670973891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6MH72Wfu4odDI7DR27EaCIxLzF+Z90J2GkF6LgI966g=;
        b=JK0srtsxMz4Zk+tipTxbOBosPZA2ic9wJYSkMYhRIeCgC7vWJnrnJsepleptJeNI+sBS57
        aOtIocjZ32oAfHcaE4DIq+W7FmrBoIJM8qMODQDBGYxJ/d62PqGdbiWOkCd3HJLZcxigp0
        b8U3TO5uyHdoMcU30W8OtlSaxog85eE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-3xT5REwDMqawt-lSychaxw-1; Tue, 13 Dec 2022 18:24:50 -0500
X-MC-Unique: 3xT5REwDMqawt-lSychaxw-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso8200012edd.14
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MH72Wfu4odDI7DR27EaCIxLzF+Z90J2GkF6LgI966g=;
        b=3YTffuIyxXpv0YRFnDmLedPLSFoF301x2POzLZktx+nnPCrBiXWwQUqaFguPA4eNcy
         Eh5bcZdRU2Fkoo2SeHaSONtje14FxpP0wQQLu8StjdGHsDKk1jLnfZnNEHdIWgaiv3fW
         04lzp1a4P3RWmowZNf/Do9Csk2g81hYVb2EVTF5j/SmOBsTK3Tqdp/BqqqCbTQD00oP1
         ez7zxvW7ELL+0lceum1pOD/oLEwbu4Bqn9GnjGmv8bkd0BSFhXjPw2A8yNe8ST9XN1ee
         MhZ0ZCkVYRDtSTMEBPtX3EhCkax0pC3KrVPL/IlP2mMO7ro248wQtoSft7i6s+WFdgsg
         SVHQ==
X-Gm-Message-State: ANoB5pmm5CWkyKj7vhCAv+tKIg36pH9oqKpdIj/W8w/MMAF8Cof52pye
        WQctFWcXJ+GrMGhr5gPg9dwFkYk94lEADmU7YW0q/SScsZu4CkauRohPeQGDGhHdND/kJ2E8EVO
        7XTwfne64Arf/
X-Received: by 2002:a17:906:2bd7:b0:7c1:4c46:30a0 with SMTP id n23-20020a1709062bd700b007c14c4630a0mr14389801ejg.65.1670973888531;
        Tue, 13 Dec 2022 15:24:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4w8RWo8/QGSUQWUf/XKBf3HpQOIdTl9c8cI09hMSNYYMpXjN1W8uLnCkeePADoRfFVXbzFtQ==
X-Received: by 2002:a17:906:2bd7:b0:7c1:4c46:30a0 with SMTP id n23-20020a1709062bd700b007c14c4630a0mr14389709ejg.65.1670973885576;
        Tue, 13 Dec 2022 15:24:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906480600b007c0baedc9d0sm5168999ejq.95.2022.12.13.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:24:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6F08982F3F8; Wed, 14 Dec 2022 00:24:44 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Toke Hoiland-Jorgensen <toke@redhat.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf: Resolve fext program type when checking map compatibility
Date:   Wed, 14 Dec 2022 00:24:39 +0100
Message-Id: <20221213232441.652313-1-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_prog_map_compatible() check makes sure that BPF program types are
not mixed inside BPF map types that can contain programs (tail call maps,
cpumaps and devmaps). It does this by setting the fields of the map->owner
struct to the values of the first program being checked against, and
rejecting any subsequent programs if the values don't match.

One of the values being set in the map owner struct is the program type,
and since the code did not resolve the prog type for fext programs, the map
owner type would be set to PROG_TYPE_EXT and subsequent loading of programs
of the target type into the map would fail.

This bug is seen in particular for XDP programs that are loaded as
PROG_TYPE_EXT using libxdp; these cannot insert programs into devmaps and
cpumaps because the check fails as described above.

Fix the bug by resolving the fext program type to its target program type
as elsewhere in the verifier. This requires constifying the parameter of
resolve_prog_type() to avoid a compiler warning from the new call site.

v3:
- Add Yonghong's ACk

Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf_verifier.h | 2 +-
 kernel/bpf/core.c            | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9e1e6965f407..0eb8f035b3d9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -642,7 +642,7 @@ static inline u32 type_flag(u32 type)
 }
 
 /* only use after check_attach_btf_id() */
-static inline enum bpf_prog_type resolve_prog_type(struct bpf_prog *prog)
+static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
 	return prog->type == BPF_PROG_TYPE_EXT ?
 		prog->aux->dst_prog->type : prog->type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 25a54e04560e..17ab3e15ac25 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2088,6 +2088,7 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
 {
+	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
 
 	if (fp->kprobe_override)
@@ -2098,12 +2099,12 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 		/* There's no owner yet where we could check for
 		 * compatibility.
 		 */
-		map->owner.type  = fp->type;
+		map->owner.type  = prog_type;
 		map->owner.jited = fp->jited;
 		map->owner.xdp_has_frags = fp->aux->xdp_has_frags;
 		ret = true;
 	} else {
-		ret = map->owner.type  == fp->type &&
+		ret = map->owner.type  == prog_type &&
 		      map->owner.jited == fp->jited &&
 		      map->owner.xdp_has_frags == fp->aux->xdp_has_frags;
 	}
-- 
2.38.1

