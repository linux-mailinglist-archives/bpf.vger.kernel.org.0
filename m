Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C467478CD3
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhLQNwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhLQNwk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 08:52:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAFC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 05:52:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so3845622wrc.3
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hmYcL8ZBpuziqt1kJhEnz2Faitl0n8iiR6HII1rL+Y=;
        b=fMWZlIavO+dRbmRTwGFnxOdORj89uXfN0YghwhHOrUyv+zef1iTygBCzDHFA8LDBsO
         6N4QozKU0bvda+Eq5FqtdxM5eoArB4bSWf8en3JFvjXADmeBDBwIYStknqHiYP8XUDbu
         3ZKqxce/+a4FqW0oq8f+rMdf1+QcJUenEA++XHV0J6QwjqfiEUKlmJyE9UVvby9EcRx3
         BxARd29dVjwczlZ21M3nRdUaZFBk6FMsYJ4pR0MVHcMMMO9e5104mQ0ZYRNCVa/UIJdY
         +TjES5SY6jpldfj5w598lJrc71aZS0Pi98AuXM3TZitM6FoUpbaYc7XNqwLr77MYETih
         XgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hmYcL8ZBpuziqt1kJhEnz2Faitl0n8iiR6HII1rL+Y=;
        b=STPVudtF02ztQuY24er6UHXigI3AnMRSr3H0VTLRKT1N2KmOVtqisX1m9T1h+xj432
         IH0vnvSShjNcI6IgWUUotk1+6yn79aTAV5tNmrnwOCrg5whF0BGZjZDN+6ZC/aWjvufI
         Wdu2B7t5jr9XoVWU/hUxAbmh1UHO0o4nPV32pp8XVQ8LWTts1nAmumbqC0WwZZgK1ejL
         DVEXp8+C+k9pfh0YIeV10nwSHr0AK/j8fmH1aLQFIjw+bYrHkZtrBXi18bYevHI3nnqF
         iAyAkI13ttMBkhzct+51bwG8PGqhpOIO6L2wlvuxywF1YELyl93flto79lJWjn+ZNT0Y
         BsNQ==
X-Gm-Message-State: AOAM531/vmQ5HwHAH+tbVZr1Vk925FQR4zVXZCz77QRAcG7SuHZEyxos
        ge0lh45eoRlWZzEwakbYFfOW
X-Google-Smtp-Source: ABdhPJwA22eS32pDfRhs1YLM8PAM9oxL4+k7yWlMnZRiNQinPJgMQk2JMLRt8iCzmkjdLy20RhuESQ==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr2684911wrv.651.1639749158591;
        Fri, 17 Dec 2021 05:52:38 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id w17sm8142208wmc.14.2021.12.17.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:52:38 -0800 (PST)
Date:   Fri, 17 Dec 2021 14:52:37 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 2/2] bpftool: Probe for bounded loop support
Message-ID: <9ad43ccea2929be6e94f16f6ee7482ad89524531.1639748569.git.paul@isovalent.com>
References: <7dfdf3f93467c619c14c40e957c54b87bb734294.1639748569.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfdf3f93467c619c14c40e957c54b87bb734294.1639748569.git.paul@isovalent.com>
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
Changes in v2:
  - Resending to fix a format error.

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
+	bool res;
+
+	res = bpf_probe_bounded_loops(ifindex);
+	print_bool_feature("have_bounded_loops",
+			   "Bounded loop support",
+			   "BOUNDED_LOOPS",
+			   res, define_prefix);
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -768,6 +780,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
 			    "/*** eBPF misc features ***/",
 			    define_prefix);
 	probe_large_insn_limit(define_prefix, ifindex);
+	probe_bounded_loops(define_prefix, ifindex);
 	print_end_section();
 }
 
-- 
2.25.1

