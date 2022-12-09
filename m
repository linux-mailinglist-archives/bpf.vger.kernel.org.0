Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5F6483BA
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLIO1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 09:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIO1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 09:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9529CAC
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670596004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NvT5twpyjg/6W4mHe3Hf2eoisCtYBKm26XzMySr7D1o=;
        b=d0mdbv354a9YvBRbnVoYaU971fM62O2SbEIAOutKJ+Ap1MkGWnt1fKAljj+8bgSIkPknl+
        atqp+DcDk4Ampg8sePwkFwuQFakRRQeq/WorIuFA9nWMw7H7ExKQTwhY7ppjM6ks8feiJC
        uFSIfT9rF8ulLGxJqneTvbI3+1ioYE0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147--KmwcqkPMEKNCZVfcwIhjw-1; Fri, 09 Dec 2022 09:26:42 -0500
X-MC-Unique: -KmwcqkPMEKNCZVfcwIhjw-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0046db14dc1c9so1482188edd.10
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 06:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvT5twpyjg/6W4mHe3Hf2eoisCtYBKm26XzMySr7D1o=;
        b=f2EWqPhgn9gyk3O89mPL2F96xxXHweLQTdksKh0uwMaiZDUeNi74tmHz2y5bmraKzg
         LBDnrIIvfCuLGE7FHcGr8kK/WMWQaPPz3mem8JsVNbm+4EG0IcnlUohZK/+z4EcKq9aK
         fOjbZGX9ImO58ou3ay3/QCghvi/DXj7VsusosXuFj89LkRQ3gtrfOfJW5yCTWcgTmZdO
         crNyOAl7YegsdYXuocdoK3OSEY7f6O5oMB51zbJsP64oxuZBo7Us0vzNJiKjBQpIalTA
         AI6hjoTKqyGkWsQVAtnCdAwsfueqvplZeWpzZKMwon70dKVlRaOdgkpW53oJ1I5zbx5l
         6/pA==
X-Gm-Message-State: ANoB5pmY8ypx2/ONeG/ex8gAKyR8lMVGGBGC3Z8zfDxDVOCczY/Ig192
        Iv7zANMqA0KLDpm6E9G3Kr2tTFq6nsiLOioXshiv9W2dfHXsH46vJorfT6ctGP/N8ncnSmoVFOO
        DATVBM8MpBmXn
X-Received: by 2002:a05:6402:2408:b0:461:f0a7:156 with SMTP id t8-20020a056402240800b00461f0a70156mr5442208eda.36.1670596001239;
        Fri, 09 Dec 2022 06:26:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71TsMbyE6U37uWmMB146F32fSXyxUUM3n7wettK9Jje1b2+8NBf4P/skcPWKjNf64KRBRrjw==
X-Received: by 2002:a05:6402:2408:b0:461:f0a7:156 with SMTP id t8-20020a056402240800b00461f0a70156mr5442173eda.36.1670596000804;
        Fri, 09 Dec 2022 06:26:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t4-20020aa7d704000000b00463bc1ddc76sm694300edq.28.2022.12.09.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:26:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4E2CE82EB33; Fri,  9 Dec 2022 15:26:38 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Toke Hoiland-Jorgensen <toke@redhat.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: Resolve fext program type when checking map compatibility
Date:   Fri,  9 Dec 2022 15:26:21 +0100
Message-Id: <20221209142622.154126-1-toke@redhat.com>
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
No changes since v1, this just adds a selftest (in patch 2).

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

