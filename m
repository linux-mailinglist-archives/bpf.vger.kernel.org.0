Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C93415465
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhIWAIW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 20:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhIWAIW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 20:08:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC56C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 17:06:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so12053366wri.1
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5ReMAbSeLYa7VjkmMVv35Cu6XMupo74SUOiXj8wpHI=;
        b=fA/LTyMJELdJNAVUFV2Pc86sOW0Ukt8shb2tTYtcP1XSgepneTsuRWf4o5oalEuiTK
         a/IQfmbzqAJD3UvupbiNOCAMzdPz5rz8ePmkE5JacjkdxN2tHMFkSs2QgQlAtG0fBYy1
         LGYb0BmKXiX8o1J3aD3ak6NuI3RGNYS0gZhK4U7FqLlwWjZBhYBIUG0kXm7X3NWa0bmP
         9KuMY4YOMFT79ByzQBUiRuwwoO1CPdsCx3lsthvRJw38cFaS9jKlMVur+NGm5bjo+kZE
         U6lhKPG7xtrN6lxrh9ABkM6s6UnyjiLeZRYmt8Ervs/miPcvnZcLVvj50b/j+JNmMGqM
         PzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5ReMAbSeLYa7VjkmMVv35Cu6XMupo74SUOiXj8wpHI=;
        b=uYhNICUx3QD2I+4iLrks11W8hIwfME6Ues/SYDOYs/GYUhd9LQ4AaUR0dTWm+oI8AP
         3zU4SwfBdPVO2ickjnOsqMjyQPPxPICBHxiPZxUzxYbec3sQDYISMVadgsCdB4tNL12d
         Szg5ZRxSS3IOWknk/1QovrzucfadDTjFPdbxKB1f94h9gOpIhpf7edKLwXs0pv4Cyfj7
         nCRaewcSSLWaU0bl8G1ULI7SqdbCZvScaNQCIUQhbiJGZTgm8vywWeQT0fkNlRtWOM/7
         W7ftJtNtDbXkXttfZyZ9Q7oNNw9tFhZhI8on1CDlM0WkmxZMPCx1UdcLG7SxXnTyhur/
         /aZA==
X-Gm-Message-State: AOAM530HUcGrkSBXmy0OaA+kJHGYoXrEQt/8sdMt+JdeMG//LaDU2wtA
        aWFrLVBVS09JDUxUl6SlsJO8jcp2EM4=
X-Google-Smtp-Source: ABdhPJyn4cynvVOMvzIlJU48NP3jR+tsrRgaT2YbN3pXICnS38JxV/FqcR1YLQVpuyEMK9lV8aXH8g==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1547631wmk.51.1632355609690;
        Wed, 22 Sep 2021 17:06:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id i9sm7754076wmi.44.2021.09.22.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 17:06:49 -0700 (PDT)
From:   luca.boccassi@gmail.com
To:     bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, jackmanb@google.com,
        jiong.wang@netronome.com, jakub.kicinski@netronome.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, daniel@zonque.org,
        fengc@google.com, joe@ovn.org, jbacik@fb.com,
        Luca Boccassi <bluca@debian.org>
Subject: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
Date:   Thu, 23 Sep 2021 01:05:40 +0100
Message-Id: <20210923000540.47344-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Luca Boccassi <bluca@debian.org>

libbpf and bpftool have been dual-licensed to facilitate inclusion in
software that is not compatible with GPL2-only (ie: Apache2), but the
samples are still GPL2-only.

Given these files are samples, they get naturally copied around. For example
it is the case for samples/bpf/bpf_insn.h which was copied into the systemd
tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h

Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
the same licensing used by libbpf and bpftool:

1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
907b22365115 ("tools: bpftool: dual license all files")

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
Most of systemd is (L)GPL2-or-later, which means there is no perceived
incompatibility with Apache2 softwares and can thus be linked with
OpenSSL 3.0. But given this GPL2-only header is included this is currently
not possible.
Dual-licensing this header solves this problem for us as we are scoping
moving to OpenSSL 3.0, see:

https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html

The authors of this file according to git log are:

Alexei Starovoitov <ast@kernel.org>
Björn Töpel <bjorn.topel@intel.com>
Brendan Jackman <jackmanb@google.com>
Chenbo Feng <fengc@google.com>
Daniel Borkmann <daniel@iogearbox.net>
Daniel Mack <daniel@zonque.org>
Jakub Kicinski <jakub.kicinski@netronome.com>
Jiong Wang <jiong.wang@netronome.com>
Joe Stringer <joe@ovn.org>
Josef Bacik <jbacik@fb.com>

(excludes a commit adding the SPDX header)

All authors and maintainers are CC'ed. An Acked-by from everyone in the
above list of authors will be necessary.

One could probably argue for relicensing all the samples/bpf/ files given both
libbpf and bpftool are, however the authors list would be much larger and thus
it would be much more difficult, so I'd really appreciate if this header could
be handled first by itself, as it solves a real license incompatibility issue
we are currently facing.

 samples/bpf/bpf_insn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
index aee04534483a..29c3bb6ad1cd 100644
--- a/samples/bpf/bpf_insn.h
+++ b/samples/bpf/bpf_insn.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /* eBPF instruction mini library */
 #ifndef __BPF_INSN_H
 #define __BPF_INSN_H
-- 
2.33.0

