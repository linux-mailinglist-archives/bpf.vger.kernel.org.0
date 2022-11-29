Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14E63C346
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 16:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiK2PCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 10:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B67D2E7
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669734080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ok6rOtLKTaQ5bjBu8C4p2m8WzlSyX99g/UvI26/Gww=;
        b=E9mPked2fNUI2Xo16vaNn8p1+FY55yx2Vs5vJx4FT3/iy3gI798TVx2lMTAL7mD390Ml79
        p8WeSwaUOEmm09q29RXO9yI/63SOTgfkbjG19G6E7SZhxgoTmJlId5juWWtKu0M3/KTGUC
        GrDoU2JN7TdhA5waGuHBtOXvFQDrmCs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-fDyWO7snMq2w5Gr4_NZYPw-1; Tue, 29 Nov 2022 10:01:08 -0500
X-MC-Unique: fDyWO7snMq2w5Gr4_NZYPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D62D3C01D84;
        Tue, 29 Nov 2022 15:00:54 +0000 (UTC)
Received: from wtfbox.lan (ovpn-193-43.brq.redhat.com [10.40.193.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D142024CBE;
        Tue, 29 Nov 2022 15:00:52 +0000 (UTC)
Date:   Tue, 29 Nov 2022 16:00:50 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
Message-ID: <Y4Yeom8vSZtBM3o2@wtfbox.lan>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yfiwx1g.fsf@toke.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 13, 2022 at 07:04:43PM +0100, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 
> >>
> >> Hi everyone
> >>
> >> There seems to be some issue with BTF mismatch when trying to run the
> >> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
> >> that this is supposed to work, so is there some kind of BTF dedup issue
> >> here or something?
> >>
> >> Steps to reproduce:
> >>
> >> 1. Compile kernel with nf_conntrack built-in and run selftests;
> >>    './test_progs -a bpf_nf' works
> >>
> >> 2. Change the kernel config so nf_conntrack is build as a module
> >>
> >> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
> >>
> >> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
> >>
> >> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
> >
> > This week Kumar and I took a look at this issue and we ended up
> > identifying a duplication of nf_conn___init structure. In particular:
> >
> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> > net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
> > [110941] STRUCT 'nf_conn___init' size=248 vlen=1
> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> > net/netfilter/nf_nat.ko format raw | grep nf_conn__
> > [107488] STRUCT 'nf_conn___init' size=248 vlen=1
> >
> > Is it the root cause of the problem?
> 
> It certainly seems to be related to it, at least. Amending the log
> message to include the BTF object IDs of the two versions shows that the
> register has a reference to nf_conn__init in nf_conntrack.ko, while the kernel
> expects it to point to nf_nat.ko.
> 
> Not sure what's the right fix for this? Should libbpf be smart enough to
> pull the kfunc arg ID from the same BTF ID as the function itself? Or

Verifier chose the ID based on where the variable was allocated, which
is bpf_(skb|xdp)_ct_alloc() from nf_conntrack.ko. Assuming btf id based
on usage location might be error prone.

> should the kernel compare structs and allow things if they're identical?
> Andrii, WDYT?

This works but might make verifier slower.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 195d24316750..562d2c15906d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
+#include "../tools/lib/bpf/relo_core.h"

 #include "disasm.h"

@@ -8236,7 +8237,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,

        reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
        reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
-       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
+       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match) && \
+                       !__bpf_core_types_match(reg_btf, reg_ref_id, meta->btf, ref_id, false, 10)) {
                verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
                        meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
                        btf_type_str(reg_ref_t), reg_ref_tname);

-- 
Regards,
  Artem

