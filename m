Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4C433CDA
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhJSRAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSRAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 13:00:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC9C06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 09:58:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q19so486349pfl.4
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5Qezf7c3TxeD08+tPhgqNRcXoDOexIcHhzpB9W1YFg=;
        b=piOkh/XzGfcPSctBg/vDT4mnaCk9Q/AinpSX9vKPaj/olJaMgK1jmzQQXXabxQ1LfV
         o31bBMVWbv1uLUzF6ayKC+PYXVvzIDeLmu2wcliUN8TvB/grksbGZjpJs5OObbGzzrjY
         xoHLXYOlk+VTwCTrcZmCWk+cNxDNFO45ipY8NdN9+zSYJvQ6Dwa8ospIx9fAgXFAxkYd
         H0A1X9bF1P1E0lwtWpdt3y9gzdaw2UijbodeSoAYTOjT9WBkC4GuvFz/iF7t+iUA6w/a
         9l/b8PuwkrDZno5hKL5JrNxeXzAXodmpWUbMpxzU5GjnJcSqz51SorrRMRuxYkaXI6WZ
         33LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5Qezf7c3TxeD08+tPhgqNRcXoDOexIcHhzpB9W1YFg=;
        b=efKSh+jCI1jY9rlMytf07bndS+XWnrmZUJe10xfQJzEhA7XZ8Ldkl9+Pi+X3Y6A7Sp
         lhgACA8lz8DnNbne+ynnFWIswRpN3pZFHSH3y8T2NvAuliC+TKhBkI8g1NWXeu7PlaJR
         GFXwyj5Jf2CIhs9lJE8/TJIQToJtkyKC7F+yumT686jpb8AqFPcqnhptlF8T5moaN96I
         d0WPwFyLjAMHra5jcDs9AsMQZPK49ZoE+ggxM2o7/eQ7P0O42VpMNJmTd6i+tgx/tNZM
         fJo7RFgiz+Hv4OJ2uG0NRZyUx5D83Sqw1rsuU97vG1L5aH5cN//L9f0Bu/GNqAC4PKpR
         +Seg==
X-Gm-Message-State: AOAM533fNW3nr5SAqMIH0W6H2r3RxYcBQ7lh0C9deOe2P/2n/HoF1/Q6
        hjG1H6idfztWru/X8+XTTkjzmKGXNYrfZA==
X-Google-Smtp-Source: ABdhPJzm6Tls0nIs6YPQnWDzgTY8HbSdjcn5DQMvS51nZzVmeKa52Hj3QjW8AegLeR8XzPIesLkP/w==
X-Received: by 2002:a63:384f:: with SMTP id h15mr16565121pgn.348.1634662689984;
        Tue, 19 Oct 2021 09:58:09 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::be8c])
        by smtp.gmail.com with ESMTPSA id v8sm3235964pjd.7.2021.10.19.09.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:58:09 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH bpf] libbpf: fix overflow in BTF sanity checks
Date:   Tue, 19 Oct 2021 09:58:01 -0700
Message-Id: <20211019165801.88714-1-andrii@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

btf_header's str_off+str_len or type_off+type_len can overflow as they
are u32s. This will lead to bypassing the sanity checks during BTF
parsing, resulting in crashes afterwards. Fix by using 64-bit signed
integers for comparison.

Fixes: d8123624506c ("libbpf: Fix BTF data layout checks and allow empty BTF")
Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1f6dea11f600..7ed117401e52 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -241,12 +241,12 @@ static int btf_parse_hdr(struct btf *btf)
 	}
 
 	meta_left = btf->raw_size - sizeof(*hdr);
-	if (meta_left < hdr->str_off + hdr->str_len) {
+	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
 		pr_debug("Invalid BTF total size:%u\n", btf->raw_size);
 		return -EINVAL;
 	}
 
-	if (hdr->type_off + hdr->type_len > hdr->str_off) {
+	if ((long long)hdr->type_off + hdr->type_len > hdr->str_off) {
 		pr_debug("Invalid BTF data sections layout: type data at %u + %u, strings data at %u + %u\n",
 			 hdr->type_off, hdr->type_len, hdr->str_off, hdr->str_len);
 		return -EINVAL;
-- 
2.30.2

