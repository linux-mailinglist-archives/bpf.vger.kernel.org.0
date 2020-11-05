Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F02A7D90
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgKELxP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgKELxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 06:53:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0612C0613D3
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 03:53:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g12so1409521wrp.10
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXF1SqOriWJ7aOraSXefzzIqR43tkx0ONzj50WfCuDg=;
        b=zGTLcxiZZV78qsG3GcPQhbs6hZm9UW+qwSl1J9Rc4mi0VpXJEpe9I/xGZ+PmvUDj1Q
         eHQEBduQhpnLeffenHiQUpr7Psk+RKNcSMVhvUv/VE2CgLiGsalgOjAVXwPl3lzVxLgk
         ysd/6nRrijW0em5Tj92Aku24eVxfTorX8oNkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXF1SqOriWJ7aOraSXefzzIqR43tkx0ONzj50WfCuDg=;
        b=DXCW9NfqzD0zqMISka0vEihHPP5uFtx17J5zhj82A9Edf5MHinn/OhuIr01qcaK04l
         ghQ3WHSI9n/QEgwa7xoHcVKuSbBHWAIgbpJYYmFrNGi+DWNCgs4EcOavb6Eig1wUvAU4
         J2ujrkx3K9gkaFTsqeivNVvyYqfE7Cp2Wsblyd3DP8xV+GgW9iwAH9lup/JwxFGIU5lG
         UDmP1lR6Jb4z+xSooxtG/ABJnMA/+ymc9Fhq9HYS1PobtO2CLrNN9h+ojKT2Sxf/wQ9s
         BiRZeBBkd44OA7rBShqv5jRnPo+cqMtaRYsHyDZyDPY4QPm3v1YY62NRGAWPDzezH6Yd
         c2Uw==
X-Gm-Message-State: AOAM532zzQdaO59xBi1d+qnRgUhqD2r510mlEvF7EodFpn8utoTGBP7S
        NCTlJp3uKlStzNuY/VMRiyMRZw==
X-Google-Smtp-Source: ABdhPJzzNkmxfb9gJuURyKkFNJ0rPyrbz1mHyaZcFFdgejmsCf3LvQME3YFn2QGfmCcxQxs7+t/AEg==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr2466805wrq.76.1604577189172;
        Thu, 05 Nov 2020 03:53:09 -0800 (PST)
Received: from antares.lan (b.f.7.4.3.0.f.a.d.b.3.c.e.c.d.3.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:3dce:c3bd:af03:47fb])
        by smtp.gmail.com with ESMTPSA id r10sm2264214wmg.16.2020.11.05.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:53:08 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Jiri Benc <jbenc@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] tools/bpftool: fix attaching flow dissector
Date:   Thu,  5 Nov 2020 11:52:30 +0000
Message-Id: <20201105115230.296657-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My earlier patch to reject non-zero arguments to flow dissector attach
broke attaching via bpftool. Instead of 0 it uses -1 for target_fd.
Fix this by passing a zero argument when attaching the flow dissector.

Fixes: 1b514239e859 ("bpf: flow_dissector: Check value of unused flags to BPF_PROG_ATTACH")
Reported-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d942c1e3372c..acdb2c245f0a 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -940,7 +940,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	}
 
 	if (*attach_type == BPF_FLOW_DISSECTOR) {
-		*mapfd = -1;
+		*mapfd = 0;
 		return 0;
 	}
 
-- 
2.25.1

