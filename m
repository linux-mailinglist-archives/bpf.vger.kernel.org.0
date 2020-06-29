Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B020E0D0
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgF2UuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbgF2TNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F8C008641
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so15509675wmh.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ezd/2IXdjOxStvjgMF+63V/b1SDKkPU4Fy4emi+6Po=;
        b=a9HyV1NqcPD44mghWsqkmTW0jESAan0i2QYGZnHpdVPG76PDTdkapDG2CbK1UU+EaZ
         EkQOFkK1TpUVrBWrM/vIrADnm2gTNaQFnOMKGpvk9zzeJHWhAUBqaKyZjiWaHcchhygN
         zHKoMuulJDYXyStK8fqym7lZWDT2GAeM4mJCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ezd/2IXdjOxStvjgMF+63V/b1SDKkPU4Fy4emi+6Po=;
        b=Xsctj9Z+JqNciO2GkXCFE3qHiRbu5pBbORRz55xEu1eyUlNFN71SWTJpAq0g/7sP0W
         jpOPxSh704PFbIR5dB9U5E4FcUxjyt3kavtTTSXR+02+ZB6ToJFTrOcRowlSjPfzQ/EP
         LQA/K1OaQmtROesork3KiFWpa+E4FzhrCVCbthHxizvH7WG1mRFIIy8GEsApL07jTswM
         eHsVqimEEgIUjSUEBN3yckRxiOyF9Us9flP6ADDuIzsVrPChdlkADV17uyenTwVe5BTX
         +5IFZHtr42vADwmFMH9UrL4Om+YkpW3yAQEAjnLpcvEPb9G3REdJHi9TdIG78pAYobel
         15cg==
X-Gm-Message-State: AOAM531YQR2mH4svASQiQLyoVIlXoshqcPsc8U5WQpzufpepXL47gmeY
        xH43g945PquVpVUIIcsw4j7gLA==
X-Google-Smtp-Source: ABdhPJw94I7O7Djc2oOg0o50JZav/e8+53MYw+OJUW1j603sj52s8bHnVBBUCJ4cqNn3Lt7Ljka9+Q==
X-Received: by 2002:a1c:8192:: with SMTP id c140mr15258763wmd.108.1593424784919;
        Mon, 29 Jun 2020 02:59:44 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:44 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 1/6] bpf: flow_dissector: check value of unused flags to BPF_PROG_ATTACH
Date:   Mon, 29 Jun 2020 10:56:25 +0100
Message-Id: <20200629095630.7933-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BPF_PROG_ATTACH on a flow dissector program supports neither
target_fd, attach_flags or replace_bpf_fd but accepts any value.

Enforce that all of them are zero. This is fine for replace_bpf_fd
since its presence is indicated by BPF_F_REPLACE. It's more
problematic for target_fd, since zero is a valid fd. Should we
want to use the flag later on we'd have to add an exception for
fd 0. The alternative is to force a value like -1. This requires
more changes to tests. There is also precedent for using 0,
since bpf_iter uses this for target_fd as well.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
---
 kernel/bpf/net_namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 3e89c7ad42cb..bf18eabeaea2 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -217,6 +217,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net *net;
 	int ret;
 
+	if (attr->target_fd || attr->attach_flags || attr->replace_bpf_fd)
+		return -EINVAL;
+
 	type = to_netns_bpf_attach_type(attr->attach_type);
 	if (type < 0)
 		return -EINVAL;
-- 
2.25.1

