Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA171478B24
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 13:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhLQMMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhLQMMs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 07:12:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDAC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 04:12:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i22so3581847wrb.13
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dEIJSN31E2W6iR/NUCOGbDLcMpZ+tGwEkjESqopsyYs=;
        b=7SPfih9YuSWkT1yoYBhUbYw9YXI471b6e2Pay6fAH44bu5N0GXxQHIJOYjOYrVB/0M
         E6pjfPiMCVvtqNi60B7GABXL5bZRYQTD20BlgaRRsjo+KuH4nUYeL78/Cx9StEDTrHHf
         UoJMCErAM46hqNxCmGeuwMMRSH61Oeub7X0RDwWDOIphAJI1UlMu9uxXEJWZuUjyAbAy
         BeBgWaGvzTXVhXUKBqkonnFiP8rCKi5XvC37DVak381T3iXULJutHBezXAgbGMqki5mF
         YfUpSXjrKi7TEqfPJopHeS6a7bM0H/beq6smMyiqLFJjvfaV+JtudEoXMkqs+N82QvHZ
         ZURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dEIJSN31E2W6iR/NUCOGbDLcMpZ+tGwEkjESqopsyYs=;
        b=xw9wDc4LA4eGK3YF8d7BWyr7LskiwrU9VaAl6QwjC5jmcrkAArVPOhpSj0AZKp5mLw
         XIzH+uPddmGDILqGjEian5wuA9uaHY694evDQ79ewNIUm9ag/4xlH3RZtq/5VpumUn9h
         31Ml8+vHiD6wA1siULpqzbi5bi2anNOvBekWnTRRkQobwiZzA4KfzoRkDnF5S/MPYFah
         G0jbvJxvOIBaJE/c+pPkhe6uVa6PMYSzZdGu5/kDfj6n4d6aMR7wGFFXEI2F0KwAtrIO
         6UMBVVtYmPTi2XfCwUgfkPjqrfsdIZuZ1wj7rT1VdUA8bdqqzQzUovafDO6/RGOUBbR1
         KkKw==
X-Gm-Message-State: AOAM532S+jUL5/A4btYLxd7NZR5jS+j7grdcKe923w0Oxn+l9RPu6Izk
        BL/p+lGsOoE4siB3FFGDYr8Q
X-Google-Smtp-Source: ABdhPJyqYinrDr4r4HgR+AiBT2LDYWpYoStrVQOa5ss5bhT1js6nCe/m6wZDJzGaBBMTTm5wvVB3sg==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr2425987wrr.492.1639743166236;
        Fri, 17 Dec 2021 04:12:46 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id c8sm8375847wmq.34.2021.12.17.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 04:12:45 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:12:44 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/2] bpftool: Probe for bounded loop support
Message-ID: <CAHMuVOAjrhuQWe1P4edNfDoik8ieHEugmMdJ6uXe9OzBT2OMjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch probes for bounded loop support and displays the results as
part of the miscellaneous section, as shown below.

  $ bpftool feature probe | grep loops
  Bounded loop support is available
  $ bpftool feature probe macro | grep LOOPS
  #define HAVE_BOUNDED_LOOPS
  $ bpftool feature probe -j | jq .misc
  {
    "have_large_insn_limit": true,
    "have_bounded_loops": true
  }

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 5397077d0d9e..7aee920162e5 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -654,6 +654,18 @@ probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
                           res, define_prefix);
 }

+static void
+probe_bounded_loops(const char *define_prefix, __u32 ifindex)
+{
+       bool res;
+
+       res = bpf_probe_bounded_loops(ifindex);
+       print_bool_feature("have_bounded_loops",
+                          "Bounded loop support",
+                          "BOUNDED_LOOPS",
+                          res, define_prefix);
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -768,6 +780,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
                            "/*** eBPF misc features ***/",
                            define_prefix);
        probe_large_insn_limit(define_prefix, ifindex);
+       probe_bounded_loops(define_prefix, ifindex);
        print_end_section();
 }

--
2.25.1
