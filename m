Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDF59D992
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiHWJ6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352410AbiHWJ4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 05:56:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8894A1A60
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 01:47:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so11842835wrr.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vbet5Ohrs21WQRpX3a/YnxTM9bbasQS+bUzE0rJqVg8=;
        b=JbR51pRZ5gtLNykEpK1/FfA45VpjlwUsDkGl3R22/qshoz0IsltZrNvd5LDlmHgt3e
         69GevPLqmA/vWTL9muHYcMeIztPxWxMRmLwn9PCpIe7Hyds4Fji0yUDRzB/047EcRpDW
         7Pco43xfYJACIg7YdVdKRei/Km07dfuzlsLVMP28GG/E6Vp+HBfZ+Vhop61u753mv88L
         wp/nPGgXdLdFP+CDohiDIzBwMGsV8qeFKQde840PjGWycds1dsHMz0xDtsdYJDD/Lv6A
         R1HcVlZMGWQzakab2g/FLx6OkpKt72tVyL+xorMYZzPEM05MY+IPP055KcBhJqlTe682
         ZQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vbet5Ohrs21WQRpX3a/YnxTM9bbasQS+bUzE0rJqVg8=;
        b=fvQMyvLDVuosALwDZ1b/uCfDmV378yhCeBYAWl6Fx/BD4WS1IR19vDfn3A7tR4V7Zl
         /P8iIhD6woyhXzaxOUhPh+xFKfLtvQ/obV2yvm/S77WK1HCJIz6IGhJq+AEGIWpu/bY+
         ZjfvR0QCjgqCiOgUDiEVE6lxKIVPjq2eSEAuf0e0plUGb+jRy63bzFGiBZls+tzq/tYu
         pWburNsrFP8SLqIY4IyFVHawZ1zBjGB2oDXHIfZGBZewjKX4YhXi4kGY5xQahJAa+e0b
         x4StY9eIZ2cgaIUCRGexrEmGQCQbdeU+gf891aq1rJe2VmcJKXe48FJ/yRYRoYi3szzE
         GRNA==
X-Gm-Message-State: ACgBeo2fxfsZTTzfbejaa8gulQG65DPaMbsxMM+cKLUSaWZH9uTRuJvi
        l6TQ4aTj1czK5JNMuGRhcZzChA==
X-Google-Smtp-Source: AA6agR4yx07/DoJgKX0tJcbR2yB83fYuvRxV+itbsv6mvexcVeAByenjtO6/U5bgjNFtWZVDx64kyw==
X-Received: by 2002:a5d:60c1:0:b0:225:3890:290b with SMTP id x1-20020a5d60c1000000b002253890290bmr10277766wrt.66.1661244453143;
        Tue, 23 Aug 2022 01:47:33 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4522000000b0022546ad3a77sm8783119wra.64.2022.08.23.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:47:32 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7) man page
Date:   Tue, 23 Aug 2022 09:47:19 +0100
Message-Id: <20220823084719.13613-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-helpers(7) manual page shipped in the man-pages project is
generated from the documentation contained in the BPF UAPI header, in
the Linux repository, parsed by script/bpf_doc.py and then fed to
rst2man.

After a recent update of that page [0], Alejandro reported that the
linter used to validate the man pages complains about the generated
document [1]. The header for the page is supposed to contain some
attributes that we do not set correctly with the script. This commit
updates some of them; please refer to the previous discussion for the
meaning of those fields and the value we use (tl;dr: setting "Version"
to "Linux" seems acceptable).

Before:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "" "" ""

After:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "" "Linux" "Linux Programmer's Manual"

Note that this commit does not update the date field. This date should
ideally be updated when generating the page to the date of the last edit
of the documentation (which we can maybe approximate to the last edit of
the BPF UAPI header). There is a --date option in rst2man; it does not
update that field, but Alejandro raised an issue about it [2] so it
might do in the future. Anyway, we just leave the date empty for now.

[0] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man7/bpf-helpers.7?id=19c7f78393f2b038e76099f87335ddf43a87f039
[1] https://lore.kernel.org/all/20220721110821.8240-1-alx.manpages@gmail.com/t/#m8e689a822e03f6e2530a0d6de9d128401916c5de
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1016527

Cc: Alejandro Colomar <alx.manpages@gmail.com>
Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/bpf_doc.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index dfb260de17a8..e66ef4f56e95 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -378,6 +378,8 @@ list of eBPF helper functions
 -------------------------------------------------------------------------------
 
 :Manual section: 7
+:Manual group: Linux Programmer's Manual
+:Version: Linux
 
 DESCRIPTION
 ===========
-- 
2.25.1

