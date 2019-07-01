Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122695C483
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGAUsq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 16:48:46 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50410 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfGAUsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:45 -0400
Received: by mail-vk1-f201.google.com with SMTP id p196so1739351vke.17
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bFfe9UYfTQADjR9AyiHnTtCwXNfUK/5CDZ1sDAGgDRw=;
        b=Q1fImz0yEfudVE17zVKhz9wdgOYxytn2+8LK7qGRJiNbhdyqAVsfRRzuoM6QyU+E8S
         lShWiLbSp6lVaqJ1Hz+9RNGc1utj3o6F3PYbbTJMCsn/jQCsRA9jXBIi6eQA5+kgtcDH
         XQJ73P1EM/T9N90qhoohyQK4jzjbioD5xZU4m42wBB4wbFAeiFqqnkrmXnfD+FZyqIEo
         X7KOoGv8nen3ACTEPe6SGV7IwrGz/RptDKL4yJONeYeRV0GTeoKFM9R7I3Wz8MBCw2bA
         n4RHzxgykpm2g3scQdfTm4T5G17WuzhWE/mcNQ7PVQKzRngpLx0uT59zjci63jOw5knN
         LVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFfe9UYfTQADjR9AyiHnTtCwXNfUK/5CDZ1sDAGgDRw=;
        b=DxhtXQh+Q1JtADzoGyZJhBmG8w7LgYagh1cObmIvDc3K7tb61damdbJ1ij3/ai7bpR
         UKpvEYtFWPDpU1mpVYkvmbmEOSTKrVHYIGaH6zkLxnJSLLZBUC76f0qgok7STU60gWJx
         kMrbR8q8yPoPreQuh6H//EhVDvI0F6gHeQ1iozMbRDJFC3ChpuaQg4VTGzabK+Mnfd9n
         ROIKJ9NpjsrvtGAT4Fc3GbZ05JfTdDiKI+3N0tbszkLcBe7xbP7teYvpSFHrxVkpOZ3F
         P4VMv0lSlxWkv+a1mke4tkTFLXAgtOdbU0jNEvdoimtCyi91MjgKJ1dWQc1D33lY9C41
         x69g==
X-Gm-Message-State: APjAAAVVsKu4204S0KlFa1t+/G3UWCd2hrT0A4/k07oEHy8ewZ57Wr1n
        N+JX6MZtLPwyf2wEbfriIJngXbY=
X-Google-Smtp-Source: APXvYqx3oet41HXYS45yolXBP3ohs5z/gCMJpvJVjsAvmH2hVBiJqmwzGUal011CmRM8CSi4VuDSivs=
X-Received: by 2002:a67:ce97:: with SMTP id c23mr15937336vse.78.1562014124757;
 Mon, 01 Jul 2019 13:48:44 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:48:21 -0700
In-Reply-To: <20190701204821.44230-1-sdf@google.com>
Message-Id: <20190701204821.44230-9-sdf@google.com>
Mime-Version: 1.0
References: <20190701204821.44230-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 8/8] samples/bpf: fix tcp_bpf.readme detach command
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Copy-paste, should be detach, not attach.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 samples/bpf/tcp_bpf.readme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/tcp_bpf.readme b/samples/bpf/tcp_bpf.readme
index fee746621aec..78e247f62108 100644
--- a/samples/bpf/tcp_bpf.readme
+++ b/samples/bpf/tcp_bpf.readme
@@ -25,4 +25,4 @@ attached to the cgroupv2).
 
 To remove (unattach) a socket_ops BPF program from a cgroupv2:
 
-  bpftool cgroup attach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
+  bpftool cgroup detach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
-- 
2.22.0.410.gd8fdbe21b5-goog

