Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA76288FD
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiKNTP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiKNTPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:15:55 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706B264B2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:15:54 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 130so11920136pfu.8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffBMRisH/b+vAP1Qh1wMiOBQlQqteRIJ6zyoQtDJas=;
        b=BIcghtqQ6Bqqzellu33lXldArNSxOrOeaTJE2+D4DyLvhq/f6s8twFmScsgkEw/5c+
         y6uwOlaj99lCoO327tx9k1ye08rp3MNduEBRbFGP52aGFpCZOXwLQN4NXsrNq31Gne2d
         /qmxv2nP6JPuJ6cg8S0Vjg+DqwZeMXAYOj9xpb8+q6zqqJDKwxlaP4hz8vHNsvM+AU3T
         pnaeYR8WI4mJ6a07SeT8a9+v9fcBCP+6VmqgeOPMjhwYRtYxVhdDRNONxuvlLvgsIljS
         TK00UwqOshCHpOTb4wu1aWo/2wflXrKJ5U0eFn6Zq6O5ABylMdgxSL4ruSbIk9/ARzpB
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffBMRisH/b+vAP1Qh1wMiOBQlQqteRIJ6zyoQtDJas=;
        b=X4DrE8Os8JjjIrtp4OHzAMDdQJFDpQADwOw8RYvnS7qNGs9rwuL0i/1hlxOWXv9U+4
         E+goTDr/g79DEjHUE+G7ZBXFA5geWxoY6nkJtueIVumfxZn7cQ4QEV9b45kJFwXC8o12
         xZr5IoGvCiTxMgU0srSpmBMxk502JgSxyqFfPqU6mFL8tYyCu9rUGsv4woZiSQeCKd5S
         46q70JwyjeWi1XHT/iOJyVBus+yFJJ198TmZpVG6EZKpQB7MxaUx/RHn9A5j7q2Wl/5T
         aMfIEAkgko6crVCPCZMC/JdwFd/WOoPtVpwExCyTItEc2gLsUIDkD1+NNr5HLrtqQCwl
         majg==
X-Gm-Message-State: ANoB5pmTMJ1SgJBhvosjK5/BBSBb4+Q98YeYLTusr3tV9wURwP3Rfi3K
        0zT7Ex/eHubtIXRR9pKdc+oTsOP2SAV3PA==
X-Google-Smtp-Source: AA0mqf6jc/MT6NHikxIrtCqMxh4l7zxTf2Kh6y97n34VzDE8GZ4hDSGjHXu4WgrqZ8WV3dQYZTmhbw==
X-Received: by 2002:aa7:9493:0:b0:56b:9ae8:ca05 with SMTP id z19-20020aa79493000000b0056b9ae8ca05mr15019543pfk.59.1668453354087;
        Mon, 14 Nov 2022 11:15:54 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id e22-20020a630f16000000b004769f0fd385sm1118541pgl.52.2022.11.14.11.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:15:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 01/26] bpf: Remove local kptr references in documentation
Date:   Tue, 15 Nov 2022 00:45:22 +0530
Message-Id: <20221114191547.1694267-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=memxor@gmail.com; h=from:subject; bh=TQdLtozHcFAX41FmGoXIb11rizNdf5YDECl5nuh1YTs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPIYkpbjgYlHHXeNDaXnxMAMbY+CWQTumnO8K0c JvRxkNiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8Ryo3+EA CqHhdioEZowD6lNpI58xjrfUACBlpTCyVzUX9lbNW5J5Bk6qCpvMKK4gj9Veg9EXSpYlg5fdK4kSqp bgi1HjfqSF5+MaH1GMswHmN17IRmYSZoRs0i8v7UWr0tsYFWnXP6gXpYGgfiI4ERDuJQ7vwvL7oWRt xmQpL3bsKJWXEAbsLTtmVJzNppyLW46LmpDT9SZsOFgrm5gF4DnStXDNaDMDuv01XqCI6n1tKunggj 4Etiscv82pqaQ8YaWz9d/JA0MJWJtc+EW2GJgzTbEMbOvVjrjg9C9uOsZI7u+8DBQFLf6++RHgFdfx guGVyUjK1xQTS9675Gv809l1GjOat2qfFnuGYCgqk4l7WyGvH9LWDXscjjjDqLywSQXsi9hACVCevR gboL0lCFhyGXoCLdDC2kQ3RmDKPEt0dM4zRf53HkgoWLot8kxPWhhJeHBn0W0Q91O2pig03jZQxZSQ g674bVRcxNnxgmNPL57O94Zjueo6juotymmATUsh2TR4Yudns/wlDyEjVm6N1wxOPZ085olNKW30bi QZeDyokRiSiIKvxEbtM7AOrww+2Eb14MnqKooRiMI6y5ymVP+Hy+4NP7U5COPgmcrCYJ5O6+exk9gu tYYtLWsjnxFd3Uv/ktgYaC+TM+gTAtM5z51HB5ma1STsOnBZ9YSPUDVJa6Fg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We don't want to commit to a specific name for these. Simply call them
allocated objects coming from bpf_obj_new, which is completely clear in
itself.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 17e774d96c5e..cec2371173d7 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -332,13 +332,14 @@ avoid defining types with 'bpf\_' prefix to not be broken in future releases.
 In other words, no backwards compatibility is guaranteed if one using a type
 in BTF with 'bpf\_' prefix.
 
-Q: What is the compatibility story for special BPF types in local kptrs?
-------------------------------------------------------------------------
-Q: Same as above, but for local kptrs (i.e. pointers to objects allocated using
-bpf_obj_new for user defined structures). Will the kernel preserve backwards
+Q: What is the compatibility story for special BPF types in allocated objects?
+------------------------------------------------------------------------------
+Q: Same as above, but for allocated objects (i.e. objects allocated using
+bpf_obj_new for user defined types). Will the kernel preserve backwards
 compatibility for these features?
 
 A: NO.
 
 Unlike map value types, there are no stability guarantees for this case. The
-whole local kptr API itself is unstable (since it is exposed through kfuncs).
+whole API to work with allocated objects and any support for special fields
+inside them is unstable (since it is exposed through kfuncs).
-- 
2.38.1

