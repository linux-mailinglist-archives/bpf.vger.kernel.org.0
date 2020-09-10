Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1942653F9
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgIJVmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbgIJM5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:57:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B52C061756
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so5559004wmj.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6+cahR1pl5c+cWIi0jixd4vtzACtZ6gKOl+XQd5lYg=;
        b=IH/TigCyC2GWUaELrtaPENW8iif0sbEyA9pHs0ut1zpweJTYVDVV7pQa/USDs4ckS0
         HCiLVkr/t5vDdpKGCzk92M3+QRfIWjyP0KYRz+j+Uzw3nfcKj64v8tlnyFj7yKDk4x9d
         NP6Hradvv++F/C1lkbL6RnLjqWDBdqjJPe3Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6+cahR1pl5c+cWIi0jixd4vtzACtZ6gKOl+XQd5lYg=;
        b=cngzf1XK1dHlBJ0hUIN4Jo1523quy8ZdoH9lRc741se9alOcg+qMx7FuQ2w8RdkZe4
         XPANzYVqjDWiWsUUnQoatc9FxlcqvD9WkBP+VRJXgHsFsN9QGA7+pOJMRTCMnatCFnCY
         +CKOGXrJA/rCAMcuwuE2WuZnIZWvtqLkTktdafva3P1PZuZhzoGb6CUGZ4CmfQshEqsy
         evHhYT6mXtbOZgE43TzD7Gjii0EDrkcwFz0gv7Ap3pF7+oH5Ss2kBcsPpPTFnF240Xw5
         AQYCyWbG2gQkwqba/IirxK31KFbjyxUMsjkem286W9WiBautp5AyLBH7vf8OH3ctZtQK
         86sw==
X-Gm-Message-State: AOAM533tFFS/9/5ZcofDNqewD8hY2fp5grCILhfStCG4punCGF+4L9Ed
        QQilr7G+YYm88IQz7pAakRX9RQ==
X-Google-Smtp-Source: ABdhPJxwFXsApbfAzrKySZK1vPdz7KPda5XIzGO6ppo6RSnifHUKOxWpaHUVa2D0Bjibl7vuW+dWrw==
X-Received: by 2002:a1c:a5ca:: with SMTP id o193mr8392200wme.106.1599742641657;
        Thu, 10 Sep 2020 05:57:21 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:20 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 01/11] btf: make btf_set_contains take a const pointer
Date:   Thu, 10 Sep 2020 13:56:21 +0100
Message-Id: <20200910125631.225188-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bsearch doesn't modify the contents of the array, so we can take a const pointer.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c6d9f2c444f4..6b72cdf52ebc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1900,6 +1900,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
 struct btf_id_set;
-bool btf_id_set_contains(struct btf_id_set *set, u32 id);
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f9ac6935ab3c..a2330f6fe2e6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4772,7 +4772,7 @@ static int btf_id_cmp_func(const void *a, const void *b)
 	return *pa - *pb;
 }
 
-bool btf_id_set_contains(struct btf_id_set *set, u32 id)
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
-- 
2.25.1

