Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F22646601
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 01:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLHAhv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 19:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLHAht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 19:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A7C24BF6
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 16:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670459809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/LS2JrAUMlpE3Jgn68BrphN30+PYNiy0lfzD4KeoPIY=;
        b=bblhM3/VJBhSURfntR+B9aUvByNY0Ob9x2Y6HN95qkfpZ+rFg/urumPv37MK57hCjPBz8p
        oJW0HJngd8WZ/uN3ZqqXUxZ3sh6PwzkwrpaDxZ8a1tYEthw3pPRk7aKWdvoMcAprWZsAGG
        pUDfZhbM93R8+0C+gWxGV6FCaWQNgT4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-y_rVUNlpOGWrTnVHf8neiA-1; Wed, 07 Dec 2022 19:36:48 -0500
X-MC-Unique: y_rVUNlpOGWrTnVHf8neiA-1
Received: by mail-ej1-f71.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so35635ejb.19
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 16:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LS2JrAUMlpE3Jgn68BrphN30+PYNiy0lfzD4KeoPIY=;
        b=7vWNr97zBy87AzioLfU7Sga3/gjI1XDWGuNtjVFV1AD0rGIVCXDzr1G+cAFDowa0W6
         wN+XZfR2npvRTl4xpI2eD9rfoDK9+CQU+AH1Yz04pHs0JAXcgYfTi6lU7W+McEFq9ljL
         1MgPeFlpociEVg5qZcTbu/FCPADVjKiXDdVStJV60WT4y2zz711yNXrbcNLsw0qTKJSP
         i2pboLw4xYLlxd/Nb6ch+Sa+LAh6X74cC8mFuJ3GBXAf21jqp8SEwjTGjP9GETofzUQ+
         XKkPRWnF0GWaKQekgvm+FlzmZ13AWgvizCN4dbMeUY97+6/MXoagvHq5SVf77/wVyvVn
         d3rw==
X-Gm-Message-State: ANoB5pnnMsFYokWD2oLIlaDPRusOl/VwcbekUuydMN7yonpO8IgmLsC2
        bzf59Rmob/kTbfPLnjeezpQuHxLJEdBVmPAMh+kLPhxx7HFseukDffT5H+OF1W0IUaBUn4vVkd/
        bx11uZN0A2y4w
X-Received: by 2002:a17:906:d922:b0:7c1:31c:e884 with SMTP id rn2-20020a170906d92200b007c1031ce884mr802000ejb.17.1670459805069;
        Wed, 07 Dec 2022 16:36:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4gO/PCXlDmKCQRkLYk3qkK1PALIUxH5oyKGV6g9WLpYd/3ZiNG0OLfhBdow1Oh/3ChUBh+5Q==
X-Received: by 2002:a17:906:d922:b0:7c1:31c:e884 with SMTP id rn2-20020a170906d92200b007c1031ce884mr801980ejb.17.1670459804044;
        Wed, 07 Dec 2022 16:36:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b007ad94422cf6sm8964312eje.198.2022.12.07.16.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:36:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 07E4C82E7F9; Thu,  8 Dec 2022 01:36:41 +0100 (CET)
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
Subject: [PATCH bpf] bpf: Resolve fext program type when checking map compatibility
Date:   Thu,  8 Dec 2022 01:35:46 +0100
Message-Id: <20221208003546.14873-1-toke@redhat.com>
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

Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
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

