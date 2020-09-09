Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6482633FF
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgIIRM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIIRMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB4C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so3156719wmm.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6+cahR1pl5c+cWIi0jixd4vtzACtZ6gKOl+XQd5lYg=;
        b=q97D02KHi9y3QOwAYdbMT6fdudPj4WHp/VXhIAKHZB/4HnHx9GjbvNi26p1d15Q7a7
         edr4+LRzdYETfeyvvdN7DjpjY8362a/7GEsse98N2mkMh/1l3WnvLseBBfP2ov14vwcM
         Iha6rk0ypiGqbB0P9pKTljvMzXhDYsJY4Sy1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6+cahR1pl5c+cWIi0jixd4vtzACtZ6gKOl+XQd5lYg=;
        b=BT5ZugjkRQZmR/b/3BIbI+sWU/8/iv5aYCb6wc3kIJwTPnQdiQrKn9/UPHsPQ5F1Td
         JkePGiDVjNzXveKbwGPGYlbdoRGLWdaKkMAEjP9m+1yU2nrOgDxeRv2gwiytl7qWkX25
         QTEqqZ98j3pbGE9S+xHBqrcT8F/pQ3ohksJ70ikqcZKG575Ih9gUBEFjaqYQg+cOUkfG
         /LQ9w1gMl44viZD/bIQlHIGxOWDU6Ty6UtLprEjmd/fvg40fAvWl4GU/plPkAK8Rtd00
         P6WLfl/2I4fzK69GNyPhfvvKoKDip+j+tvHnw1CaoUCL/xbiKm4u0Gr2XRSgdnjw/K9U
         4HPw==
X-Gm-Message-State: AOAM532hB+B3fvdST2zunkaR+3bL0OSKk+Yu/L5ZLL2D4eTH5A69U0L6
        WySELNmmahma0k2BEk1WEpDU0A==
X-Google-Smtp-Source: ABdhPJwmIfhR2/ZVqaZtXcnTZ1KaXmiZTzYU5BwvAh6dog5KodfxRCgilpfWwu73h8t5w0plqJ6MIw==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr4832611wmd.154.1599671521287;
        Wed, 09 Sep 2020 10:12:01 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:00 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 01/11] btf: make btf_set_contains take a const pointer
Date:   Wed,  9 Sep 2020 18:11:45 +0100
Message-Id: <20200909171155.256601-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
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

