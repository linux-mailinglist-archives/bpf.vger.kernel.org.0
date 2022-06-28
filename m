Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8455E9D6
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiF1Qex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiF1QeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DA9227FFF
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O71u5Z4n1+6VmrW6FVYVpeAXxKNx4FehGEWC9dC5Edw=;
        b=YL0fbAOEA6bkRf3iF9TyQR8HF68Mp+K0apjFCFT2BkJwU9oZ1NDP2MmN3Rx3KZuYIBVtqu
        S8eOzpgN5/KD1eySZO/h2oLjCvvjQaCFcf5swk08pBZHy4y5sWEyty5up6mWTzmaUYEb70
        9wBkiN8hmLnf6/9fI5UO5VGWwMagq2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-1rwQv03uNnyps4i_8sklxQ-1; Tue, 28 Jun 2022 12:30:45 -0400
X-MC-Unique: 1rwQv03uNnyps4i_8sklxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC57385A580;
        Tue, 28 Jun 2022 16:30:44 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED0E415F5E;
        Tue, 28 Jun 2022 16:30:44 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id B911430736C72;
        Tue, 28 Jun 2022 18:30:43 +0200 (CEST)
Subject: [PATCH RFC bpf-next 2/9] bpf: export btf functions for modules
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:43 +0200
Message-ID: <165643384372.449467.131935445575415818.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows modules to lookup their own module BTF info.

These are get and set operations that bump the refcount.
Thus, modules can use this to control the lifetime.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/linux/btf.h |    2 ++
 kernel/bpf/btf.c    |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa0428..df9776018059 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -126,6 +126,8 @@ u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
+struct btf *btf_get_module_btf(const struct module *module);
+void btf_put_module_btf(struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2e2066d6af94..96fd5e469b42 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -534,6 +534,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
 
 static s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
@@ -1674,6 +1675,15 @@ void btf_put(struct btf *btf)
 	}
 }
 
+void btf_put_module_btf(struct btf *btf)
+{
+	if (!btf_is_module(btf))
+		return;
+
+	btf_put(btf);
+}
+EXPORT_SYMBOL_GPL(btf_put_module_btf);
+
 static int env_resolve_init(struct btf_verifier_env *env)
 {
 	struct btf *btf = env->btf;
@@ -7022,7 +7032,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
@@ -7051,6 +7061,7 @@ static struct btf *btf_get_module_btf(const struct module *module)
 
 	return btf;
 }
+EXPORT_SYMBOL_GPL(btf_get_module_btf);
 
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {


