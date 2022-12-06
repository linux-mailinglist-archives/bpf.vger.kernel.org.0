Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1620B644F96
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLFX1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLFX1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:27:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7762A734
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:27:41 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so13072726pgs.7
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XrN+7YM/6vfTT/O086SdkBaFbo4//UHiaXj1PeVn/c=;
        b=ebs/hvOUEFmkHhw0C+LCOLMb987kHxa7IpFiE/B8uU4Cou/8r+h9Z6PB5Ygt8jZrGk
         hUlQNxhCW+2ZxNh0pGEKxrTxamYEjaOpyz4SEUoy33w5SbmqymL4JYNAKUhsu3Wx6hUf
         GYU1vJjg46dUhbOtY6qahGpzsCmVqZzv+8+v2L78VJ+RXUgSTXjgRkoKWueZgm+rDAUf
         eYWoRUT/iKvHk3olsTsDCXr0bxu8rszlcGw3K/EdH09jVOCD6gHp87EgIhvSpzVrRvvj
         0rU28Y5vQaDy16MYz/yY4AUsDNkRlTAefi0Hwr/YxcvwDDfqCgiO+gH68kNYr18oBwNi
         f6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XrN+7YM/6vfTT/O086SdkBaFbo4//UHiaXj1PeVn/c=;
        b=euvYl+5YyecCAkYyGlCrAmZsRXKnCYyZI/wYkSrkHm6g+xUSD9CQfXnZGNqUqaatDE
         WfU9kntX4kJz4fnRFp8rfCqi3rFu76yvKQl5nrHxAN51C1bVnb3/AFJmS76CGF5NHEyO
         oMX+C0FelbCAYQjp+msRAJcmvTl/F7yMAc//Hu53klAkQsWHkclEmKDEt3OktdopmqCf
         8NupiIAyGxruJOmltWYuGaRvc3JMoqsig7rEjdhSqAZe8ZeHmBfUQCMsj9ilWuW3ZOJq
         VnpsXeV39gaC/q/MLeGLAhhqYKqlQ8xfqU8xzbJ9ZIv2ZT3q8f/tTXxSnt787eLoffhl
         Fl6Q==
X-Gm-Message-State: ANoB5pmNfrIx19pbF9CkmQ+9n/LQNqFLtTm2fznjNWk345ux5j79f4HS
        gg07D9vE3KeT64okDVCI8KR6zhSpUQnu5VNK/XoD0zIOY/KG89ivaHvdC0V0R9EtHHTjwadeHXb
        HQJUp04G6zWKMWx8e1LUDl8EixjPE5C/nVNhuknSeMKBTGFiB+A==
X-Google-Smtp-Source: AA0mqf7/ZUHtFcSjtQ4+zjkBUmw/6MY7q2swCFCqT8rpAahuBkD0sRI2RWF5z+fUbCnZrCCV9+9g/KQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:410b:b0:56d:91d1:a903 with SMTP id
 bu11-20020a056a00410b00b0056d91d1a903mr9240522pfb.61.1670369261366; Tue, 06
 Dec 2022 15:27:41 -0800 (PST)
Date:   Tue,  6 Dec 2022 15:27:39 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206232739.2504890-1-sdf@google.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Bring test_offload.py back to life
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool has new extra libbpf_det_bind probing map we need to exclude.
Also skip trying to load netdevsim modules if it's already loaded (builtin)=
.

v2:
- drop iproute2->bpftool changes (Toke)

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_offload.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/se=
lftests/bpf/test_offload.py
index 7fc15e0d24a9..7cb1bc05e5cf 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -769,12 +769,14 @@ skip(ret !=3D 0, "bpftool not installed")
 base_progs =3D progs
 _, base_maps =3D bpftool("map")
 base_map_names =3D [
-    'pid_iter.rodata' # created on each bpftool invocation
+    'pid_iter.rodata', # created on each bpftool invocation
+    'libbpf_det_bind', # created on each bpftool invocation
 ]
=20
 # Check netdevsim
-ret, out =3D cmd("modprobe netdevsim", fail=3DFalse)
-skip(ret !=3D 0, "netdevsim module could not be loaded")
+if not os.path.isdir("/sys/bus/netdevsim/"):
+    ret, out =3D cmd("modprobe netdevsim", fail=3DFalse)
+    skip(ret !=3D 0, "netdevsim module could not be loaded")
=20
 # Check debugfs
 _, out =3D cmd("mount")
--=20
2.39.0.rc0.267.gcb52ba06e7-goog

