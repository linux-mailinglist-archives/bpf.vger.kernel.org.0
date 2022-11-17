Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5B62E8C7
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQWz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKQWzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:24 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F676339
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:21 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id o7so2953204pjj.1
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQWfEZnU96xkexiHPMecwLZhhJHKeuuTJzPTTJL5+18=;
        b=QPKrhZKSwDbyfpEmbj5zZ+511U3cSlruOLf3EuDvPyj8snc6mMysgIeE/NSoTu2Ap4
         37qAScMYmiuHcu2+1JAR3syPLmotQ7VLpbzAtANcERf9wJm8iCS1YVug+YDFYRCmLTBF
         +jUPdyRoyNqtNWgW+6yFHqOfiE/1BZB6rZeB7e+N/Uxejd2Wix7Et/5c3k/Kr0Ws3MKJ
         Bg09S29XDWSMym/479DRkC9zj4nCAlZHUSsWcj3FbS0wye2CCkaq1NaIqMMr9oRWLFdy
         253RWVbR1YUz8GCcvhlCIq9QbBMgAmtm/rkU9oeZAoda7HLdBHEM8rGY4vkKL+ntVIsv
         5L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQWfEZnU96xkexiHPMecwLZhhJHKeuuTJzPTTJL5+18=;
        b=bkAUKMNZDCifWHmWWvow6vOXV7qPKhY3pTRdsOx78pMmSuWEBxtMajyi1lOl5SDAHX
         nKXSEgQyd2PfJJBOBbCW2DxUMncKjWV+WRHAO3kY1PB9jXZNAYoXr3ZIDRvmPQMgM3D6
         A2y0fugnUTzqnrwa30ZDtreDGnfTRATnZiTRIc5Txw9iAjJdZgFe9kOcuF2Nx770u5B/
         96Zr8iPIsF/gi/OEIYRucoaYXmjSfJTWIyRvf8ohbxSA61xYmep0/3VIT3BFZB+6yYrn
         dV6UFmJ/Gxygi/p0f7mk7fwWBSd0tETNSIVcu4SUFvfS+rQb0SypCSvG6ePGA1s+Eb2O
         O/uw==
X-Gm-Message-State: ANoB5plSWHQ5zP8vitnQc8I6nsgNfc170Aw7GtlS8GSk5JrRaBjOYUeN
        Mpd6ILvSKhUe5tRflLgFT4xWet8JF2I=
X-Google-Smtp-Source: AA0mqf7umPW870GywKl1JypWnjUyo2byNx2130CpgqJ8XVupy8iTQmztm7y7wA205wB0fWFWWBXc+w==
X-Received: by 2002:a17:90b:106:b0:213:4959:fb98 with SMTP id p6-20020a17090b010600b002134959fb98mr4931712pjz.4.1668725721056;
        Thu, 17 Nov 2022 14:55:21 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b00188767268ddsm1980325plx.151.2022.11.17.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 02/23] bpf: Do btf_record_free outside map_free callback
Date:   Fri, 18 Nov 2022 04:24:49 +0530
Message-Id: <20221117225510.1676785-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312; i=memxor@gmail.com; h=from:subject; bh=5PZ4QRQvYOcWzKDR5LxcVFsRltruQteYwu7du7JUqDk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkaSvKXZ89jWdGw5U7Y5qB+JVaf8OZrycuT+vY5 wHUBAheJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GgAKCRBM4MiGSL8RymmxEA DAhXmNuvF9lzb6aw4hCJ89jUp9oTCP07hl9paa1HFUGulpmCdSHi1eCpOxlSABrVSYUHa8l0PhPCjs yGHswCLFp7dpxz3NPupQsgc9+uwDJm9pBGcXberJvmuReNrmucnMfHLXHvjpsPZvc6k6Eo02rEmbto GzPTFTOd7q5Q+g0GFJU+4AqrDnCFxGUmbptkJi+ce6HgxIz5E+YA5fzf9fmaF/r1jVGlUPApzN7j7H bSzIO72G6C7kJNFpxR3TD9+bKgwCiMnJKaU2HAk8gGFdQeHpx1UAVdCPXQVPXXzlK8+mqCj25bzKbJ zqL03AKGcGnYbi5z5BcyxpK5So4g6gsI3Qqfpok456g+eadhekJp7wPcrTQ6itvfthMpL8lzg+f/Lq 18NWdmGB1BWdIfk+7eKs5ijy2BwUNVDxP3L7EbgilRdshIvHonnyOAmyrsXLv3k1Sg3Bd/bmKPIFQt Pcx6QgrFrQEhkg90BvZerHzQLUo9n19r2L7NMp+UzQquWXdyMav44GgxWYv3TIs4EDjByZMRaOITxI HI+IH7xRxTTsCTrmAkBUd/aGr7NIGmRRxe4Fkx81cvdUmaj3t94mT14oxkF2FCRw+jjMayKdH89EUg yUoUyhcc1w30IxQKVmQ8vNRfuCqPRpq4PqbehwlpyYynVKyljVHfR5RetqGA==
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

Since the commit being fixed, we now miss freeing btf_record for local
storage maps which will have a btf_record populated in case they have
bpf_spin_lock element.

This was missed because I made the choice of offloading the job to free
kptr_off_tab (now btf_record) to the map_free callback when adding
support for kptrs.

Revisiting the reason for this decision, there is the possibility that
the btf_record gets used inside map_free callback (e.g. in case of maps
embedding kptrs) to iterate over them and free them, hence doing it
before the map_free callback would be leaking special field memory, and
do invalid memory access. The btf_record keeps module references which
is critical to ensure the dtor call made for referenced kptr is safe to
do.

If doing it after map_free callback, the map area is already freed, so
we cannot access bpf_map structure anymore.

To fix this and prevent such lapses in future, move bpf_map_free_record
out of the map_free callback, and do it after map_free by remembering
the btf_record pointer. There is no need to access bpf_map structure in
that case, and we can avoid missing this case when support for new map
types is added for other special fields.

Since a btf_record and its btf_field_offs are used together, for
consistency delay freeing of field_offs as well. While not a problem
right now, a lot of code assumes that either both record and field_offs
are set or none at once.

Note that in case of map of maps (outer maps), inner_map_meta->record is
only used during verification, not to free fields in map value, hence we
simply keep the bpf_map_free_record call as is in bpf_map_meta_free and
never touch map->inner_map_meta in bpf_map_free_deferred.

Add a comment making note of these details.

Fixes: db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arraymap.c |  1 -
 kernel/bpf/hashtab.c  |  1 -
 kernel/bpf/syscall.c  | 18 ++++++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 672eb17ac421..484706959556 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -430,7 +430,6 @@ static void array_map_free(struct bpf_map *map)
 			for (i = 0; i < array->map.max_entries; i++)
 				bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
 		}
-		bpf_map_free_record(map);
 	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 50d254cd0709..5aa2b5525f79 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1511,7 +1511,6 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
-	bpf_map_free_record(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8eff51a63af6..4c20dcbc6526 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -659,14 +659,24 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	struct btf_field_offs *foffs = map->field_offs;
+	struct btf_record *rec = map->record;
 
 	security_bpf_map_free(map);
-	kfree(map->field_offs);
 	bpf_map_release_memcg(map);
-	/* implementation dependent freeing, map_free callback also does
-	 * bpf_map_free_record, if needed.
-	 */
+	/* implementation dependent freeing */
 	map->ops->map_free(map);
+	/* Delay freeing of field_offs and btf_record for maps, as map_free
+	 * callback usually needs access to them. It is better to do it here
+	 * than require each callback to do the free itself manually.
+	 *
+	 * Note that the btf_record stashed in map->inner_map_meta->record was
+	 * already freed using the map_free callback for map in map case which
+	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
+	 * template bpf_map struct used during verification.
+	 */
+	kfree(foffs);
+	btf_record_free(rec);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
-- 
2.38.1

