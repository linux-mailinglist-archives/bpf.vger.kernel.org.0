Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAADB2842A3
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEWpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEWpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:45:36 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6AC0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 15:45:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y77so3015738qkb.8
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8BKhAkzDrkowGH3g/fxPwDUzO3fDD8T7y6zkrNKC+Ok=;
        b=X4bv+/PEuZ6mqeDRerTKhN7QEWlck1XKrErbm8VAk3LB9+hvJSVr0XCCVD/xplk/qP
         XKnFXGydFBrsQwpF1Bj0Qt47VnEms+QNvpmZQuR13tZdTrvkD0zM3MAr4mBjauacit0j
         2sUkrgkq57Pc9ys5qpk0CHi7WbBFe2aEFKhifHXCNie09kizNzkPssE3CKH4HWYZGGkD
         y5sO9G/c1B5ukJUqBRYNDVT9uC5VSnnzMTfK7GMeXLipgJxiTeM5eTrYyzNgsPWkWG8g
         u1reTVYIOd2QLn3PHf/bFOcmaToFyMaueCWKz0h0YgUWZwFa+obiGixPz32SskxYy55D
         wLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8BKhAkzDrkowGH3g/fxPwDUzO3fDD8T7y6zkrNKC+Ok=;
        b=RrjMn87QbobeASWo7ZW4We2SF0/edGX1FYsC3WhKZ0P2Zk5ySxCNCUnXoLRwmWYDQ+
         LjaKlGz3lwthSEIiL7LvQARTbwFZTmYR69RQWXh/fhOesj1pmf600B/oSL1iBXDMHCLk
         H5QR0DuyL8tnTIDly95DJTdGEa4t6n8NzTCm1r7ZN9lbVHr4sCMDnGssumlBvfFJIr8g
         zb2ERp/tDFQxOAB9SqeS3Bd326UxJvEPmlHCfstPiIDxyedwsrXFvRV8Tv86yPhQtC3R
         tC2PcTGUo5j2sz62/uLAaAF5uGa9J1l7+8+GuLUdDywIFqUXSxeVV5FBmhiNRPrYahcU
         2Zkg==
X-Gm-Message-State: AOAM530TWj2E+nnLT17fEpUkUvNtsE6lXQ+OFXW9XaZR5ErZ1G+RVI71
        VQD6AshdeSdY0k473OxaDrb/e1bOZl9XFWUfW0B9o0cGURaBHlf9ftRGe348HK0Mij/IhUdYPK5
        MQ9QDZ1c0VWS2qtUxhQuhRETsLLOiGHYdTk97FhO5u2IR8uUMrcXq1lz+Aw==
X-Google-Smtp-Source: ABdhPJw5TbsireMyRkoLBkqvTxu//Mh1ELm0jmOIo9VDP0zgEyRALhbtOJamHqL2QOHGepx9H+4+tAOz6sU=
Sender: "lrizzo via sendgmr" <lrizzo@lrizzo2.svl.corp.google.com>
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:7220:84ff:fe09:96d1])
 (user=lrizzo job=sendgmr) by 2002:ad4:58c7:: with SMTP id dh7mr2081173qvb.20.1601937934098;
 Mon, 05 Oct 2020 15:45:34 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:45:28 -0700
Message-Id: <20201005224528.389097-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3] bpf, libbpf: use valid btf in bpf_program__set_attach_target
From:   Luigi Rizzo <lrizzo@google.com>
To:     bpf@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, rizzo.unipi@gmail.com,
        Andrii Nakryiko <andriin@fb.com>
Cc:     ppenkov@google.com, tommaso.burlon@gmail.com,
        Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__set_attach_target(prog, fd, ...) will always fail when
fd = 0 (attach to a kernel symbol) because obj->btf_vmlinux is NULL
and there is no way to set it (at the moment btf_vmlinux is meant
to be temporary storage for use in bpf_object__load_xattr()).

Fix this by using libbpf_find_vmlinux_btf_id().

At some point we may want to opportunistically cache btf_vmlinux
so it can be reused with multiple programs.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 tools/lib/bpf/libbpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a4f55f8a460d..33bf102259dd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10353,9 +10353,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
 						 attach_prog_fd);
 	else
-		btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
-					       attach_func_name,
-					       prog->expected_attach_type);
+		btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,
+						    prog->expected_attach_type);
 
 	if (btf_id < 0)
 		return btf_id;
-- 
2.28.0.806.g8561365e88-goog

