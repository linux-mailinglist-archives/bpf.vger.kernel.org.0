Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C61BD92
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfEMTEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 15:04:40 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:36848 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEMTEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 15:04:40 -0400
Received: by mail-ua1-f74.google.com with SMTP id a6so671064uah.3
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oR8zQU2Zd3bm0eoT1c69aX6y+IQJBeinTbkDZoPCRQo=;
        b=Yrcw+b/UvsPlCbLHRvvnToX6ehGI17r3/iVF3KBzx3OBXmQ5Od/l7/BXOgoUNauZb0
         y6qX/mGY6Owrf84S6ERE0ghXSLREDm7gLd3BrXZXFOowzkqOeu66irrHOtK6UJR60hDN
         FM/2Z8KoUs6T7wbK0BIFKQMEdNWlFMoFzHEPMCi1gYJAKxOSIndHRXZyGz4HzCo3SIRz
         vfI4vg1sPDH8dV7jFCvfAuXq3D5C0i5OB1DzhwZY4pB3rsPYsJKucSwVEC3v2F2bVQUY
         Gi741zmBOwDIaXBe4qE3jfZKaFZ86RKNFlMjoK2jpZBLc1l1mte7cFh+3VWA7lQa2t29
         ODIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oR8zQU2Zd3bm0eoT1c69aX6y+IQJBeinTbkDZoPCRQo=;
        b=nnyHbcG4cJOoOZ1Md2bEyNHigWYXgb3dg1SFr2kxSWKmSj5LAX/cZbLh43iFYF3ZRg
         iJBY2h8Fhfn48mgHaorFNguyVdttWTEZAPVT3wKeskXpm/FS/8JW4DWB/JgaPaUrrruk
         h1F61LGFwcr0V/LH7LYF26h/B62obgZ2rNFcZCENnR/MhUpZVOe7nRVXiVoCCqbU+Fv3
         DeMQAWAomyvZ936Hkww84yvLMIP1cSPMom1FT4uUkXtIeqM7ZD9t93NpBFAaF3V+b0gm
         XLKvubxJgNQdg319hiV4vw3JMsbFw0DlyE0Pmrwrx4Z+Y+oQuKZ67Y9zSZm2Mi8XOnNS
         JUmw==
X-Gm-Message-State: APjAAAWf5tmaqphbXB1RBRaP73SXAnixVcKHExnWfqdVaJz4rz+ZN7CQ
        ZEfhz577I9CnRhOiAbgnGaa9Pk4=
X-Google-Smtp-Source: APXvYqzImIva+4pxY72XI3JSo2VA+GQHezF49xYTfBBSO8PxBC+B3KDIhBUMCHs+Z3KnztBXZG+Hrlc=
X-Received: by 2002:a67:ff8b:: with SMTP id v11mr4306982vsq.88.1557774279361;
 Mon, 13 May 2019 12:04:39 -0700 (PDT)
Date:   Mon, 13 May 2019 12:04:36 -0700
Message-Id: <20190513190436.229860-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf] bpf: mark bpf_event_notify and bpf_event_init as static
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both of them are not declared in the headers and not used outside
of bpf_trace.c file.

Fixes: a38d1107f937c ("bpf: support raw tracepoints in modules")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/trace/bpf_trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b496ffdf5f36..f92d6ad5e080 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1297,7 +1297,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 }
 
 #ifdef CONFIG_MODULES
-int bpf_event_notify(struct notifier_block *nb, unsigned long op, void *module)
+static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
+			    void *module)
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
@@ -1336,7 +1337,7 @@ static struct notifier_block bpf_module_nb = {
 	.notifier_call = bpf_event_notify,
 };
 
-int __init bpf_event_init(void)
+static int __init bpf_event_init(void)
 {
 	register_module_notifier(&bpf_module_nb);
 	return 0;
-- 
2.21.0.1020.gf2820cf01a-goog

