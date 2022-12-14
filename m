Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0964D2F9
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiLNXDw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNXDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D626555
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671058983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZHSXyh7zaj9r9sENIMQYkVDLO9dHghWoEQNR6Io1KOs=;
        b=QtAXSu6LNAj0zrIeMYVuiDyBTdw5zRtT6oyrxhMx+hgyUsDTolWzMw+6pA6udoI9TVf6fR
        DFIgkToE9cRs/GYLjmqqCIDUH449ujWbZ3FrXo3fcAOzL+nnHXvK8fPoA8LoBYOqyezqd9
        0roUQr0TXl2STdRn0JH86WScxkERqlM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-y3z3W3oTPCWqL7Ie3XFrBg-1; Wed, 14 Dec 2022 18:03:02 -0500
X-MC-Unique: y3z3W3oTPCWqL7Ie3XFrBg-1
Received: by mail-ej1-f70.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso12311840ejb.5
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHSXyh7zaj9r9sENIMQYkVDLO9dHghWoEQNR6Io1KOs=;
        b=zSc2Kv74T09OQp/NZoVMTM4nldoWGnjsPRL92wvJkIVX1N5a06yv+lrIf4N3qmtBtK
         zfz08ZdCE0Cb6xAc4ot3M64M8gAXIrX7M8nKgYlXBQO5MERlc6U/7USnQFk3rthgp1eP
         szMipYXcFbwqnO9kW6lUfbISHA5q1kkNIiecBFv+rVVGlq9BehBpO9a+Iu7h/UTwWqU3
         BAZlmPaq8rUohRgMj3T5LXtJ7eECOblfe6g2o/d7wfWYfsqTQgUZvvuPN7PKVZ79uaI1
         iacS4zo7OeMT5KjE6qSBGhjA9mENn+m4xIOoeLe6Hldv0Iz9/qH56acvyWmxCTWd/8EO
         u4lA==
X-Gm-Message-State: ANoB5pnP+oDI+gnyd7UGRsHFcJzqwyqwweUKMbE/ncx4K8kTlLDWLYTu
        +q+kqO/Lp2jJZAkf9wpnblAjkwtRq+KpF9S1KjPdmFhSOETxmeA5brhJnFMIpwPyq62XKAXIw2I
        ZwQEG/ke0I/1X
X-Received: by 2002:a17:906:5208:b0:7a5:e8d9:a305 with SMTP id g8-20020a170906520800b007a5e8d9a305mr21799653ejm.70.1671058979129;
        Wed, 14 Dec 2022 15:02:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ITvrOYSFal+EOeRIqt2beliVm1KmgTO7kn4NKAkbfxpnjXfRd4BaqlJq5JZlHHXgkcT/d4g==
X-Received: by 2002:a17:906:5208:b0:7a5:e8d9:a305 with SMTP id g8-20020a170906520800b007a5e8d9a305mr21799603ejm.70.1671058977567;
        Wed, 14 Dec 2022 15:02:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906328400b007aed2057ea1sm6339275ejw.167.2022.12.14.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:02:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 75D3182F657; Thu, 15 Dec 2022 00:02:56 +0100 (CET)
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
Subject: [PATCH bpf v5 1/2] bpf: Resolve fext program type when checking map compatibility
Date:   Thu, 15 Dec 2022 00:02:53 +0100
Message-Id: <20221214230254.790066-1-toke@redhat.com>
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
- Add Yonghong's ACK

Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7f98dec6e90f..b334f4ddc4d5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2092,6 +2092,7 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
 {
+	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
 
 	if (fp->kprobe_override)
@@ -2102,12 +2103,12 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
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

