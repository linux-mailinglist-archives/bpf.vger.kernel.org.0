Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5015764C1A2
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 02:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiLNBGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 20:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiLNBGL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 20:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF9FCFB
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670979926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6MH72Wfu4odDI7DR27EaCIxLzF+Z90J2GkF6LgI966g=;
        b=Z2aLGWANgLh1ChEQPO9td7G3rfkQTPBiff2cjOx9tLhuH5QcDgw1b7QkbDV95o/ua8cyMp
        7aXNyNgKdUI0NCGFE7N16j60RSM/dNy3y2+OY3JMlcouTnn65fEpgMnGyBT45Bp3OWTZFQ
        J2tuql3uHatiSsFAwWmoFX33McmWIWw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-hghWeZ4YOvKfcpJk040-vg-1; Tue, 13 Dec 2022 20:05:25 -0500
X-MC-Unique: hghWeZ4YOvKfcpJk040-vg-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a05640234cf00b0046d32d7b153so8239756edc.0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MH72Wfu4odDI7DR27EaCIxLzF+Z90J2GkF6LgI966g=;
        b=2bQmXRCay1tsE5vEPDmhXpKbXdjfod6BhN6Vzqvi+2g/aSOuooyuEpegSrjs15HIDY
         7xfSu8oqC8gaFiU6PYWHLqOF4CDuMfcx34WepHgWrXGBcTqRGne65CQJtnYnlw9zt2S4
         QtRRipHUFYDQ14jdJBFknoys5mByN7jGPF2dFkIdhKgfS3C/EqLC09fTeBeC8HW7vRO2
         S03fRTrxR6Vdscu1VIpexNwq6rGTkAm1DmUITutsohMwSZ0q02qCP8bykqPikMdwjAly
         ZpXb7KULgr3xrcDxkZNR5ksd2eJOEZ1q11QdUPcIOfOaALZBdlqrdX9R+6xIUSCC1gwA
         QSPw==
X-Gm-Message-State: ANoB5pmt3jLYZHzCkC+6zVmq/CgeiNkSygxCqP1/Gi5bFuR+jpL/h6fF
        TXPGw0RFpMZfoiuaSJuKk5qIUS/Flexy1KMnP6HKTNynHSs12VejFPEuGRtYXwAQroY0GR/IN3P
        ZV0eydAUKlp2j
X-Received: by 2002:a17:906:a3c1:b0:7ad:a2ee:f8e6 with SMTP id ca1-20020a170906a3c100b007ada2eef8e6mr18591592ejb.15.1670979924408;
        Tue, 13 Dec 2022 17:05:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf75HGrz5Q7BZbdnfOulAwNHZ09tLEfL9LeBp5NmWt+u7btEjY4ENj7PRs9zCzl0uPM43e8yIw==
X-Received: by 2002:a17:906:a3c1:b0:7ad:a2ee:f8e6 with SMTP id ca1-20020a170906a3c100b007ada2eef8e6mr18591570ejb.15.1670979924084;
        Tue, 13 Dec 2022 17:05:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b0078db5bddd9csm5146198ejb.22.2022.12.13.17.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:05:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C7EF882F422; Wed, 14 Dec 2022 02:05:20 +0100 (CET)
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
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf v4 1/2] bpf: Resolve fext program type when checking map compatibility
Date:   Wed, 14 Dec 2022 02:05:15 +0100
Message-Id: <20221214010517.668943-1-toke@redhat.com>
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

