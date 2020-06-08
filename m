Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015D1F15B3
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFHJnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgFHJnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 05:43:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D177C08C5C3
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 02:43:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so16608600wrw.9
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBOzkuj3WaDvQhWGfrOv45jIFvmUW2vuFAYUss6HLWU=;
        b=jquz+S78EEYw8es0c8TY5MpWtSOHPuc3HjORFlXcnf3jYImjBfqKwVGDM5LZvehNl9
         T6mjbLZcbfz5YyBNVfSOEzD8VgBD1ScAQet/ahi4cOkyZ46k+J4glnl7rYH0+xZ7XlFl
         DcYX97+oAQxo8Mxs3p8/FgUd3pi9qhcEC43Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBOzkuj3WaDvQhWGfrOv45jIFvmUW2vuFAYUss6HLWU=;
        b=tfb4gJh/SHWNDhQt53CW4OTG55l3fwkdee4Igsr18ltJ3CYgb83tfyMGbVs7qdesgT
         w4UdfdjpilqedxD170U9TZCxICSsA4rHw4yAgRYKUIFPImyzCl7s0eCZwtEBApCSg+Fx
         V5Z3ktk7MvgIRQTIVH7badW6AsTYcbOhIVUZvFlj/rMj1qjc4On0KbS1YVTOE/j/O1BI
         b+fSzxFwCddOryo3eg2ep71FHGVkWUhXTasYuboyrWY1ZIdLzK0zWJBZXUx7wQF9SAEr
         rbO/pHYhRNScIZcRyLAjE63M+5oyZ/+d90lpZUAEfezQj1uWGmVw32LHDZ0ZtplhjlGV
         Dq+A==
X-Gm-Message-State: AOAM531bOqKIfbAjaE+V6/A/xA8XfQx3YOdFhXrKbmH2D8M4c/Wov4eX
        PrMi20vxwvbbO1k+vpdD5MDiZw==
X-Google-Smtp-Source: ABdhPJxN0rk75wDEQQF5Sj/M3KHgZ/LvtrJPWFJdt0nBFozlfyUtF3VJRw2GG4Zfr67eAJA4geebxg==
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr24417133wrs.371.1591609390868;
        Mon, 08 Jun 2020 02:43:10 -0700 (PDT)
Received: from antares.lan (f.7.9.4.f.9.a.d.f.4.a.3.6.5.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:156:3a4f:da9f:497f])
        by smtp.gmail.com with ESMTPSA id l17sm21993124wmi.16.2020.06.08.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:43:10 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     daniel@iogearbox.com, ast@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Ivan Babrou <ivan@cloudflare.com>
Subject: [PATCH bpf] scripts: require pahole v1.16 when generating BTF
Date:   Mon,  8 Jun 2020 10:42:57 +0100
Message-Id: <20200608094257.47366-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_iter requires the kernel BTF to be generated with
pahole >= 1.16, since otherwise the function definitions
that the iterator attaches to are not included.
This failure mode is indistiguishable from trying to attach
to an iterator that really doesn't exist.

Since it's really easy to miss this requirement, bump the
pahole version check used at build time to at least 1.16.

Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Suggested-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 scripts/link-vmlinux.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3adef49250af..a37875904ca6 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -143,8 +143,8 @@ gen_btf()
 	fi
 
 	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
-	if [ "${pahole_ver}" -lt "113" ]; then
-		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
+	if [ "${pahole_ver}" -lt "116" ]; then
+		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
 		return 1
 	fi
 
-- 
2.25.1

