Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DE44EB8C
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 17:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhKLQr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 11:47:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42AC061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 08:44:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso15202703ybr.19
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=twivPmHGmtG8iF2Iqs4VmwFt4m0EiD82k/Wb4RTz6Kc=;
        b=OyXHubVFMlweTuLfR3lTaZWi9qarwXv7g9No6exsAdlMdf4WR6hKnPWRGAfL3W6705
         R2VAB05Eq+ZLlGCKQX+egZMf8paMfj8KeIJcZY7xxCW2AYOUWi2GaFCdGWD64BC6CAaD
         hONobq8B4xju5OZ7g/81d6TrdkeYwmWETgh373uAoAVO9qkEOuQFKzXiJaJC58nAuy0/
         g4K9ka0AtZ7h5VzMRaStCzfm57+sy+1+DIE2BhJ4IOexlRg4WliOrUEJAbogzklMsjQf
         RybvvnSK+NYOYM/vhvDdxdeuW4awgkVY9XO5miuLlOeLuxgSfJcBMG6jdKn6tF5qh3cP
         WRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=twivPmHGmtG8iF2Iqs4VmwFt4m0EiD82k/Wb4RTz6Kc=;
        b=BJEXi1ETnslvzpTzDgU+kVG4zD/Gsx0YPMu4rnzYD+MwurV0U0U1d9EQouxgyRahs3
         oork+boKzyK0c9L9/6YI70a9lxASi6mkOZaFbTLTXDbJNzVX2JEdX0vuUO8HH8/uipoJ
         7KRG9Qw8FpxY6hXF/n6ukxgaOf7JVDlmgcofSPROs71Cms+wxsmOdsj6UJHtMubV5rrn
         VgewJAKx2E769nLKykLOGRX5V1vd+ZM4UBKljBiNeqOBvBEYemxBt+fCFHFu4rfLp3GR
         q8nM7jW9w2jk2lqevJ5htgMQpOEw/pR++hT5hJY49bHX7DzPZs6Rf+wW2Y0ECoIILkES
         DR+A==
X-Gm-Message-State: AOAM5321PIETJ0xYA3VOp5zUkJKTjJblCobUXBFR/L4qUovx6mUrJDEX
        HSeaZ7yuORhZHo8/y1V2wrXptCA=
X-Google-Smtp-Source: ABdhPJzSvSx0imV1lHXiXXkyhTthLeS1VldJBYkhV1Ktp5Agm1ClZh9ThPLr7JcTgABL0preLTPi4LM=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a840:6f02:587a:91e6])
 (user=sdf job=sendgmr) by 2002:a25:ae07:: with SMTP id a7mr18348527ybj.364.1636735474266;
 Fri, 12 Nov 2021 08:44:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 08:44:32 -0800
Message-Id: <20211112164432.3138956-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH bpf-next] bpftool: add current libbpf_strict mode to version output
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ bpftool --legacy version
bpftool v5.15.0
features: libbfd, skeletons
+ bpftool version
bpftool v5.15.0
features: libbfd, libbpf_strict, skeletons
+ bpftool --json --legacy version
{"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":false,"skeletons":true}}
+ bpftool --json version
{"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":true,"skeletons":true}}

Suggested-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 473791e87f7d..edbb146287ee 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -93,6 +93,7 @@ static int do_version(int argc, char **argv)
 		jsonw_name(json_wtr, "features");
 		jsonw_start_object(json_wtr);	/* features */
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 		jsonw_end_object(json_wtr);	/* features */
 
@@ -106,6 +107,10 @@ static int do_version(int argc, char **argv)
 			printf(" libbfd");
 			nb_features++;
 		}
+		if (!legacy_libbpf) {
+			printf("%s libbpf_strict", nb_features++ ? "," : "");
+			nb_features++;
+		}
 		if (has_skeletons)
 			printf("%s skeletons", nb_features++ ? "," : "");
 		printf("\n");
-- 
2.34.0.rc1.387.gb447b232ab-goog

