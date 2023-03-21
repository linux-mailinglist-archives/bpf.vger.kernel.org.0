Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E306C2CE3
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCUIsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCUIsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8249880
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 01:47:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so3856491wmq.4
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679388437;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HxwVXQPEIn9a9htoxd3he9RBAITKVC4CCupJgGf0ro=;
        b=l52xBY7srPPYOm4G7XGQOlYdpZyi9LfW/REo4wpzwFcvs9Eg1ovFp0CqUm15S62hiD
         ghE+2SIGvWGWxxqgtf3aLB62Qfgj0+1SYWbbycufWVa5ahFJBybMXsO0yFatrsin412W
         sWKeyZqKblPCxeGctrKaprgKEmALJvTnq7z1QUaT0lghhXZscsbVtIxbQG9nvdpPeqg3
         UspB7TAGkWi92wItgD1A3yt7NDpdApzIRKxQskFGONsdZ5cjkpZMYqA1MVQMd5f4vr5G
         ntnL4rLcicvHtF9IV6OAUUV0JW5t/RKMDH2XthQf5YcO2QXmUZ0HQaajRkFIgXytG+ay
         rJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388437;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HxwVXQPEIn9a9htoxd3he9RBAITKVC4CCupJgGf0ro=;
        b=mnOEXoEN1fvPj1o2pZh8lut+BW22i1sM9yFzkmnmAg4/Xs5jyzP5tVyMFBxK0jmsd5
         1zZhRYoANYWJEGXljMDQH8oPwqS8gUbA3UmJOIiAP9T0PtH+K/FrAN99dltlfffFxVnw
         EglI6Z+9BzGP6lnmBxQLt0It3J36BUa3xKY3r3wGYqYtyHunWI4rlmQFXBfVXnm71KRT
         MN7Z94IdNcmxFGZG7v7SRlt/suA20GHCiAMPgoCi2cr7RaCLoVx1PwqpTeihHXgk8C78
         Fk86KVG1BDSqkPgEP2dzRSDUior79wu+NCqK+ghstKcBMReeRP0nU57TUYamBfwFwJGg
         w+cw==
X-Gm-Message-State: AO0yUKUHP0aOA/DVlto+50aMS6WWThjJvVC2B6ZowNQIrKKfYE8QfwHk
        kQVhS49EQJv4AhGTsDFNEdg=
X-Google-Smtp-Source: AK7set9JQjaijXrQJ+VD3o3aX8AdJZXrw5kVzUrB12Hi6NYy1KkoWqG6NMqRJAV6hq6Q7keaXreO4A==
X-Received: by 2002:a05:600c:d4:b0:3ee:4531:8448 with SMTP id u20-20020a05600c00d400b003ee45318448mr57050wmm.39.1679388437487;
        Tue, 21 Mar 2023 01:47:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b003ee04190ddfsm4463801wmb.17.2023.03.21.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 01:47:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:47:12 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: add support for open-coded iterator loops
Message-ID: <176c368f-bcce-4779-8cc9-a8a46d9e517d@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrii Nakryiko,

The patch 06accc8779c1: "bpf: add support for open-coded iterator
loops" from Mar 8, 2023, leads to the following Smatch static checker
warning:

	kernel/bpf/verifier.c:6781 process_iter_arg()
	warn: assigning signed to unsigned: 'meta->iter.spi = spi' '(-34),0-268435454'

kernel/bpf/verifier.c
    6762 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
    6763                             struct bpf_kfunc_call_arg_meta *meta)
    6764 {
    6765         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
    6766         const struct btf_type *t;
    6767         const struct btf_param *arg;
    6768         int spi, err, i, nr_slots;
    6769         u32 btf_id;
    6770 
    6771         /* btf_check_iter_kfuncs() ensures we don't need to validate anything here */
    6772         arg = &btf_params(meta->func_proto)[0];
    6773         t = btf_type_skip_modifiers(meta->btf, arg->type, NULL);        /* PTR */
    6774         t = btf_type_skip_modifiers(meta->btf, t->type, &btf_id);        /* STRUCT */
    6775         nr_slots = t->size / BPF_REG_SIZE;
    6776 
    6777         spi = iter_get_spi(env, reg, nr_slots);
    6778         if (spi < 0 && spi != -ERANGE)
                                ^^^^^^^^^^^^^^
Assume iter_get_spi() returns -ERANGE

    6779                 return spi;
    6780 
--> 6781         meta->iter.spi = spi;

meta->iter.spi is a u8.  How is this going to work?  At the very least
it needs a comment.

    6782         meta->iter.frameno = reg->frameno;
    6783 
    6784         if (is_iter_new_kfunc(meta)) {
    6785                 /* bpf_iter_<type>_new() expects pointer to uninit iter state */
    6786                 if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
    6787                         verbose(env, "expected uninitialized iter_%s as arg #%d\n",
    6788                                 iter_type_str(meta->btf, btf_id), regno);
    6789                         return -EINVAL;
    6790                 }
    6791 
    6792                 for (i = 0; i < nr_slots * 8; i += BPF_REG_SIZE) {
    6793                         err = check_mem_access(env, insn_idx, regno,
    6794                                                i, BPF_DW, BPF_WRITE, -1, false);
    6795                         if (err)
    6796                                 return err;
    6797                 }
    6798 
    6799                 err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
    6800                 if (err)
    6801                         return err;
    6802         } else {
    6803                 /* iter_next() or iter_destroy() expect initialized iter state*/
    6804                 if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
    6805                         verbose(env, "expected an initialized iter_%s as arg #%d\n",
    6806                                 iter_type_str(meta->btf, btf_id), regno);
    6807                         return -EINVAL;
    6808                 }
    6809 
    6810                 err = mark_iter_read(env, reg, spi, nr_slots);

If spi is -ERANGE here then it leads to an array underflow.

    6811                 if (err)
    6812                         return err;
    6813 
    6814                 meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
    6815 
    6816                 if (is_iter_destroy_kfunc(meta)) {
    6817                         err = unmark_stack_slots_iter(env, reg, nr_slots);
    6818                         if (err)
    6819                                 return err;
    6820                 }
    6821         }
    6822 
    6823         return 0;
    6824 }

regards,
dan carpenter
