Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11501621697
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiKHOaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiKHOaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:30:03 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F171099
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 06:28:28 -0800 (PST)
Date:   Tue, 08 Nov 2022 14:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667917707;
        x=1668176907; bh=ua0gwJ84ZgAM1z3Mv8rulZXwDGWQPOQguVjegqF+/U8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xDjP+gSzl+o3MnGzgaIFXK4wjJo23FH0zU8nlb2eTrsXFysBAEiubpMoGDywN1Yaz
         DLn3AxGj+qMoeScIYdoFjnfAi7B6By/XDf9R1B0qT/yxP7gY/sRSkIiTk/gTRlr/M3
         Bx0akmUfLeQhd8Xk8TE+rOIAOpxGDNHIcvzKeniGYL/OCKj5ovWAZjkcTYURnKdS/5
         OHFAxCDcn5hM2+OWVKhueTq2uulp6hdyinhr7MuRtn3TkD++H6fzl4nrzP3G4trrQD
         4+gp4d+qF0lQgIM61TeAoC7fFVLoL14s0QJC8o7tg/Ew6LItQ3b7rlRnSxZPCFbh75
         gYfLuWXUudL+Q==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH 3/4] bpftool: fix error message when function can't register struct_ops
Message-ID: <20221108142515.126199-4-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is expected that errno be passed to strerror().

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 tools/bpf/bpftool/struct_ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index 68281f9b7a0e..e0927dbb837b 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -513,8 +513,7 @@ static int do_register(int argc, char **argv)
 =09=09link =3D bpf_map__attach_struct_ops(map);
 =09=09if (libbpf_get_error(link)) {
 =09=09=09p_err("can't register struct_ops %s: %s",
-=09=09=09      bpf_map__name(map),
-=09=09=09      strerror(-PTR_ERR(link)));
+=09=09=09      bpf_map__name(map), strerror(errno));
 =09=09=09nr_errs++;
 =09=09=09continue;
 =09=09}
--
2.34.1


