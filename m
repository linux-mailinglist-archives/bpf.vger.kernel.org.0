Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0D5B4EBD
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIKMXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIKMXk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 08:23:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C5326F2
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so5235683wms.5
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M73OfkfFVV1eq7VuM0JYi91cTVYeC3EwNvXPK37OaiA=;
        b=HusSO3z7tLLMfP79uaebtzzHKhsho9kQ/AEpP4TOtTfXSiG3iSr/WZj/GaQuHnllZk
         4ONQKmSEiX1pavmevFS/TPsVYIbTseP8+wawb9ZuQmZJs4hZ4MHd1JL/hsDRxUVz1g3t
         uBmOdgqEzX+TDt4EGueu6vWZ8Llitw1wVznhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M73OfkfFVV1eq7VuM0JYi91cTVYeC3EwNvXPK37OaiA=;
        b=Enox7Ncrhw7UpXljA2wocX60oPo9lQFiS6Rv9BWEsdGHgntU1LMnNFW7fRiNI3ZhPw
         VuehmU4Oa/ak8GVQNkJHvzSeElSNTTIGpxS8KxCCx5vgkxOLHtSTrA1pox34jyfwyWX/
         5/7m3MhlCA+PqE/a1L9tfrYnjTdO0JNbN35n5laPayGcSzejcSlM7U7ZVPrnQuK90KoA
         4x9+9J18ci0E+ZhcgdawobfqGYekdbQnAUfODijMBiL958ceTBGo1Seex4gV1h7VfijW
         VzqpZwwxyOdrIMQgGZUY052r8/Ojl4Ivoo4oMNp0jwtr5jtR9cZcQEkp7eKfjkPoy4Tg
         23Gg==
X-Gm-Message-State: ACgBeo0jia48JfVtVO2HBp4EA/VfOSIZtpsOWMzcJDbqXyXWmyAVxJjV
        YemRWxhl5w/Je4nomyZVrJloly4CGp69+fUUDai+9x+kL3X69jGqE+JdLBpvFQOdcBflX3fjIoM
        gglyh8fFDA1cdf1580XqE4GeHFDpHOz5Nabj1823YQ95UlH4fENx6VFVj0LbTXz9xRu1411ihY3
        8=
X-Google-Smtp-Source: AA6agR6JL3hX8EXQ1ydJFw9MadWO0H+1BMgVYVs0ay/gSoTB4wVn+6UoLTqTQj/qlEjfF/WNyIuW3w==
X-Received: by 2002:a05:600c:5248:b0:3b3:24cb:fde with SMTP id fc8-20020a05600c524800b003b324cb0fdemr10626771wmb.80.1662899017734;
        Sun, 11 Sep 2022 05:23:37 -0700 (PDT)
Received: from blondie.home ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a4f08495b7sm6538346wmq.34.2022.09.11.05.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 05:23:36 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 bpf-next 1/4] bpf: Export 'bpf_dynptr_get_data, bpf_dynptr_get_size' helpers
Date:   Sun, 11 Sep 2022 15:23:25 +0300
Message-Id: <20220911122328.306188-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows kernel code dealing with dynptrs obtain dynptr's available
size and current (w. proper offset) data pointer.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>

---
v5:
- fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
  spotted by Joanne Koong <joannelkoong@gmail.com>

v6:
- Simplify bpf_dynptr_get_data's interface and make it inline
  suggested by John Fastabend <john.fastabend@gmail.com>

v7:
- Fix undefined reference to `bpf_dynptr_get_size' when CONFIG_BPF_SYSCALL
  is unset,
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/bpf.h  | 13 +++++++++++++
 kernel/bpf/helpers.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 48ae05099f36..a2f16e3cb0fa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2631,6 +2631,19 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
+#ifdef CONFIG_BPF_SYSCALL
+u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+#else
+static inline u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+{
+	return 0;
+}
+#endif
+
+static inline void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr)
+{
+	return ptr->data ? ptr->data + ptr->offset : NULL;
+}
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..824864ac82d1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
-- 
2.37.3

