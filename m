Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2369692A54
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 23:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjBJWks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 17:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjBJWkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 17:40:46 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D621B55B
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 14:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=begXeBJVrFsDM6UJQj+6dtgHSFnqsNATuATmNODOfM0=; b=lcTqjLQkRp9PJcHkuKbY56OoSO
        K6NBcpgXOF623rWikfPOBJ7AxJptG8cG3MY2+CzjDBvwrvhvgwdWjdKJRIMJNU9VZKruA1tzyuflt
        HuLknn76Iv1ctO2lpNpCYmJRjS1p5xgSV9CevzbvbwYWJcNrSHhuZLbM5NBgmRzIEcf6Rxl+LruVk
        S1+x1CwgFXi9m0FPfjSHUikmYzJSK3Vysed1XZsSOUjQxyBj2PT+YNsWzfcuiLW+5eeojFvM/FkYk
        g4b48D+7gPiJLmuR/Oul+SXSZg4ixXhONOI+YRwsbpCy4Imi3k9fITDKOTn7x5rQfBHpO/+dAfqG3
        fn0xE4QQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pQc4Q-000NIh-35; Fri, 10 Feb 2023 23:40:42 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     bpf@ietf.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] docs, bpf: Ensure IETF's BPF mailing list gets copied for ISA doc changes
Date:   Fri, 10 Feb 2023 23:40:31 +0100
Message-Id: <57619c0dd8e354d82bf38745f99405e3babdc970.1676068387.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26808/Fri Feb 10 09:58:43 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given BPF is increasingly being used beyond just the Linux kernel, with
implementations in NICs and other hardware, Windows, etc, there is an
ongoing effort to document and standardize parts of the existing BPF
infrastructure such as its ISA. As "source of truth" we decided some
time ago to rely on the in-tree documentation, in particular, starting
out with the Documentation/bpf/instruction-set.rst as a base for later
RFC drafts on the ISA. Therefore, we want to ensure that changes to that
document have bpf@ietf.org in Cc, so add a MAINTAINERS file entry with
a section on documents related to standardization efforts. For now, this
only relates to instruction-set.rst, and later additional files will be
added.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dave Thaler <dthaler@microsoft.com>
Cc: bpf@ietf.org
Link: https://datatracker.ietf.org/doc/bofreq-thaler-bpf-ebpf/
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb30e6b85b57..4741063eaf52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4019,6 +4019,12 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/testing/selftests/bpf/
 
+BPF [DOCUMENTATION] (Related to Standardization)
+L:	bpf@vger.kernel.org
+L:	bpf@ietf.org
+S:	Maintained
+F:	Documentation/bpf/instruction-set.rst
+
 BPF [MISC]
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
-- 
2.21.0

