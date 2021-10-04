Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE6421982
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJDV6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhJDV6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 17:58:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E5C061745
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 14:57:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q81so1229031qke.5
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Gzxz/yo5VCSNnHXrX+uh0b7z9266ZHugq7OPcVBQxQ=;
        b=PJ/U/VO64fFwD0R/fVswzWt6EhFfNXIf+SkJQttJ8O4X+c/Vg05NEuR1cxwctsKO5G
         /WtgeYJaw4KRkYRBQr4ote471nFrR+NuiNEYgd6d1li4ZJs3qadq8S6rVf0n1JaFbtFs
         l++NdEy0sJRd0g0DeZb7ylE6YwyaZaWCPoBFNutIyUYcPHMUe8mez9XO8NaIjezndWkC
         UBnZfZmXCt2iXiCwbG/k9rGsbHWIFG48i/GcKi9qougC8AxnQMaf7/hN6zic/brLhCHZ
         xMdnRez4J1AtYn9lwc8FXaok1QkdNxjZAZhtS/j0TGNwUnksli3YUmWpC4Vc9pOmY3W0
         +jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Gzxz/yo5VCSNnHXrX+uh0b7z9266ZHugq7OPcVBQxQ=;
        b=vRLzfoixcr3ADKj5Tmt6ee7cA5EptIvvO8EwSg3HhIMkUOzvGNW+aIKbLQgkzFLuBo
         nxrv6QF4EghYVCk0D3bKauYQlBKHVw2BkWp5YvDQWk7LhKhhfp8BiHQrNdCPw8fJu7uo
         SBXpxqSFBWDe1xEeZD58rXW64V7LvFcFB6m1uAknQbFX2/ap43Wp95QrY8DoEJr7641H
         1uaTSB2lAcAsAp8vYG8VItl78tvzDKPWri+S9nGtP4anQ6tDWZOaKXN2zDFuhaJWRK1x
         kyGDvRB/iUfci987xf5GX6YpbYjJ61sONxambPMg0EiSqeEfat1lqAYMHLv5dpEmHNDL
         IWng==
X-Gm-Message-State: AOAM5330n1whpz9AuA1zQuALuMcVQkcPTCdoT2H0JjhPlvjlyGhwV6+R
        w4DpHtjkrUn6b/eUAS7LXgU=
X-Google-Smtp-Source: ABdhPJx9DqpOE3V/W5PZ8NdB2Em5kjzVv0BezEli7Y+C5p3mo+VkSSnPZ8oMhKip1Qhm/vRMKhnpjg==
X-Received: by 2002:a37:9a89:: with SMTP id c131mr12864447qke.191.1633384621747;
        Mon, 04 Oct 2021 14:57:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id y6sm8217273qkj.26.2021.10.04.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:57:01 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add API documentation convention guidelines
Date:   Mon,  4 Oct 2021 17:56:44 -0400
Message-Id: <20211004215644.497327-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds a section to the documentation for libbpf
naming convention which describes how to document
API features in libbpf, specifically the format of
which API doc comments need to conform to.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 .../bpf/libbpf/libbpf_naming_convention.rst   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
index 9c68d5014ff1..5f42f172987a 100644
--- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
+++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
@@ -150,6 +150,46 @@ mirror of the mainline's version of libbpf for a stand-alone build.
 However, all changes to libbpf's code base must be upstreamed through
 the mainline kernel tree.
 
+
+API documentation convention
+============================
+
+The libbpf API is documented via comments above definitions in
+header files. These comments can be rendered by doxygen and sphinx
+for well organized html output. This section describes the
+convention in which these comments should be formated.
+
+Here is an example from btf.h:
+
+.. code-block:: c
+
+        /**
+        * @brief **btf__new()** creates a new instance of a BTF object from the raw
+        * bytes of an ELF's BTF section
+        * @param data raw bytes
+        * @param size number of bytes passed in `data`
+        * @return new BTF object instance which has to be eventually freed with
+        * **btf__free()**
+        *
+        * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
+        * error code from such a pointer `libbpf_get_error()` should be used. If
+        * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
+        * returned on error instead. In both cases thread-local `errno` variable is
+        * always set to error code as well.
+        */
+
+The comment must start with a block comment of the form '/**'.
+
+The documentation always starts with a @brief directive. This line is a short
+description about this API. It starts with the name of the API, denoted in bold
+like so: **api_name**. Please include an open and close parenthesis if this is a
+function. Follow with the short description of the API. A longer form description
+can be added below the last directive, at the bottom of the comment.
+
+Parameters are denoted with the @param directive, there should be one for each
+parameter. If this is a function with a non-void return, use the @return directive
+to document it.
+
 License
 -------------------
 
-- 
2.31.1

