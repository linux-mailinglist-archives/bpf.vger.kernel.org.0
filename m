Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722962E19E
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiKQQ0f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbiKQQ0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48277FF3A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c203so2230342pfc.11
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdGV3WLq9T0v9xO58ScVcH1xBLJnaoYl5zlkBFTuiek=;
        b=GZWDQFAzbkTgomFTa0W4Y7DVCu78Nzs6en2bOyhmWv1uEufljh2DOZU605oDnexm0M
         k5OCqsn1WaDw/f3kddMzOWPi8OizfWNGx9NAN1KP+yf4EMTg3IEp3pr40mz2XBW47uKi
         ZAlL3jHsdnRaj5C5JuOpVR5N2fh6qItRGQf89XsV19sAjxq1v0f3SC7aGIL7tzND1M6B
         vVMu/CfQDTYEFBctfLT8nllkdD8+JJLX9g09IbwuuBw/UbfIAh/+nRrCmiKo2P6QJTTc
         2IFUH/VShLVpvHE5YP4B3chGoU3eV1dt2NwLV3z1aI0Va8BfcsQXDwVWRZFQI+Y0Reab
         TFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdGV3WLq9T0v9xO58ScVcH1xBLJnaoYl5zlkBFTuiek=;
        b=SJ13bRZvNeNdPCpWUzLwsm2byc9KPIc+yNk8srNV/ofW49EejfSJk9WpCX3GOFu09g
         2dnWUqF5Ut7N20onaKHxF9q7vH/605EAyLi3WuY7V95sd8yLxWQV5avOk4wBMteWxvOV
         4zW21GZzhYnWsM1YPCjQaXqXUyIXt3vXykWyyVMSBiTwBDEmQot+ckPjkVZ2aCxhRsEB
         UvJDOnaUwaUJq3wonODYNy2bIV10MdTEv1aLup5lGMfjc+FY6GXEDDxHzX1nY9YpenyP
         T+FwSXFzPu29MeKT3/x4XfRT+SVvZgLZwe+eKydv/C9MJb+u+EfBI0IYzgBlqKly4yIm
         4lAw==
X-Gm-Message-State: ANoB5pmJY2D7cWQpwfcgqN67Muh4XTd8wgeES8pFhRk23rCcAlLOrtze
        LINaWvWf8N6Fx7h1G2CnuOn8sKG63m8=
X-Google-Smtp-Source: AA0mqf7CifeirkZCz3DZOqXlqzXMG3sx49S359bcrmFmrdOnDGwDdvi6mZZ/bG2W0Gn33cCoq+eDIA==
X-Received: by 2002:a63:1f65:0:b0:470:8e8d:44ae with SMTP id q37-20020a631f65000000b004708e8d44aemr2596766pgm.382.1668702292873;
        Thu, 17 Nov 2022 08:24:52 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b0018725c2fc46sm1460983pls.303.2022.11.17.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:24:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 03/22] bpf: Do btf_record_free for outer maps
Date:   Thu, 17 Nov 2022 21:54:11 +0530
Message-Id: <20221117162430.1213770-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=memxor@gmail.com; h=from:subject; bh=dOJ86OdnShZuSG5H02AhjavEwsfvY7ZpYKeWiUP407A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+5lBP/Liq78FQjY4ZV408BNTpOhGXjAOB6Hu7 pCciZsyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8RygwzEA CjDJHeV3ePI7cj/Yu8egU8oTtOZij1lc4l1HQXLKTp9L+zwUZ5ypNOC8PEfEngoBf+6N3BU1Ko7j/w RtkYAsT1Q6ORo6bgTZ3R2EqZyj5B1AL2cxdvuv40msnivtSslIJ8AkONoVIbpzBbADG8EKH9Hp2fIF u6+rgWZDCN4M5cwTNbJDpv9PaKPsbb7vdHzWuWK8NxhtiqZYtIx+u0tu9w9biNQp/0zMynuxSCVj43 y0Fy97DIdAg6yfKaX/ZureTyRpM00IIF2fNCiNzHa8UPBBi/muH7/UDt3A4W4fqCNGzEFaUb7f5tNy 5UxXs6aCUYAJtfHjv7dePgsevfWbylj9xwHPO+soBUQLHYyunANdOiTuyv5Fz/KT1qODAg0EYR2sjs /aRMw3hgGtUhG54noemW6ZzSzIdgy3Ba+KYWNJduUDOhgUpd6mZTYXvB3QipgSb2mIh521VneLkW3O f12WDNyNvypZDhsPU8DjO/sUxQlCsgNdCKiflL4Cbn8pQboFrW3iNSx6+d1rjoaZ/X2WMalaJgGDXQ nB56GTROaYD92641c6humcs2FPIxJLT9lAhkJTroWJGiOvl9ccKrOmXbvfx4kY/e3dCsuvzYt9sHX7 SMKBN3OOiTsZjcJwbK0Pdfba40pJMKwwbQhNu/KpP0xcYqjDHDW9GyGa4TIw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First of all, whenever btf_record_dup fails, we must free inner_map_meta
that was allocated before.

Secondly, outer maps are a bit different than normal maps, since they
don't have anything to free in the map values when being destructed. The
inner_map_meta that holds a duplicated btf_record (from the inner map fd
being used to parameterize the outer map) only exists to serve checks
during verification, which is why we never populate field_offs in
inner_map_meta. Hence, in this case, simply take ownership of the
duplicated btf_record and free it in bpf_map_meta_free.

This fixes both sources of leaks (in case of errors) during inner map
creation.

Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 4caf03eb51ab..74f91048eee3 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,13 +52,20 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->record = btf_record_dup(inner_map->record);
 	if (IS_ERR(inner_map_meta->record)) {
+		struct bpf_map *err_ptr = ERR_CAST(inner_map_meta->record);
 		/* btf_record_dup returns NULL or valid pointer in case of
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
+		kfree(inner_map_meta);
 		fdput(f);
-		return ERR_CAST(inner_map_meta->record);
+		return err_ptr;
 	}
+	/* It is critical that inner_map btf is set to inner_map_meta btf, as
+	 * the duplicated btf_record's list_head btf_field structs have
+	 * value_rec members which point into the btf_record populated for the
+	 * map btf.
+	 */
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
@@ -78,6 +85,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
+	btf_record_free(map_meta->record);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
 }
-- 
2.38.1

