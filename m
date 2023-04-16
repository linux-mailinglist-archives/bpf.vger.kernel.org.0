Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C806E34A4
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 03:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDPBLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 21:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDPBLN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 21:11:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923035BD
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 18:11:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k36-20020a17090a4ca700b0024770df9897so1330093pjh.4
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 18:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681607470; x=1684199470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DLMK54+jPg/DL8GQ35PsB2ZrawJ005AI1EvLQgF/i8=;
        b=TvC6fCDlTZ5SUAVxBNKP/53Rc4dxfR16bCxwOU/fWIu0LKMhAVTGuHqQoV+F6PoBSO
         xLXXGAivob9+iENtoysFZpAA9D5se86rJvjIhtaZIXntSSGODtMYOALHjHn5rGhI5b8j
         2xYHjep5/bvMJXGBSAO7D/fi0W6KLak9lqpHKe9CgAyGlP3lVHp7tw5HuDywbvtGJHY7
         APRLbm3bqYoBgyQ/pEkHflyqoWqF39i/XdgzO7q77aW6YuxIXc1GSthMIF+RID6FO/gq
         vjJddvkXJIUNhWgMHnYJs/Zjlf6OdWyimEZweUKwnVe+SgtvLOoiLVVd1K16kHIYSiaV
         s5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681607470; x=1684199470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DLMK54+jPg/DL8GQ35PsB2ZrawJ005AI1EvLQgF/i8=;
        b=f7ktovjOIa+cQ9PBZ3Ijes+9FZXxGrCL1ZnTgqRxxWCBTsak4+USERQ1oWTaooN3pB
         gEUB21gi0dRJwG+5OO3ATTbO/zWIfQbK/tL7R3KS4ERkanWqPZ7KOuZ7FH3BJkzbMjWu
         jzfzzi9+SUEd6Z4PHDD38tuW4yA45nYIsxhln9IXBJqDcz5gA/PNNcSgItbgxVZoi0CS
         W8QwAUlXO2xg+qaFBfUNmb/DKb/+V0zRNWXuQLdt1fjGP7NM5pb1JgMcPHmLPqdg9hl4
         HjeYadHyAoTEO/YgoyZontQI9LnQ10oIvOjbOL9YyV8dyvrqNpm7pbDhuzjAh0XZ/sW0
         oLBg==
X-Gm-Message-State: AAQBX9fC5XqgA2wuoJFZT6D82KUXiUwalDTAlpx3jFJ9OJOThK1rPLOD
        7rWJCAgVcniBjMHRxCjg6QDc9KTQ/YA=
X-Google-Smtp-Source: AKy350ZM2p9NClo5nukl/BojTHcuQrU9QjUjO1Cp+qPIcIP9LE8j0gykDJWGKb9q6yuQE0oZTwt3Gw==
X-Received: by 2002:a17:90a:f2c5:b0:247:3e0a:71cd with SMTP id gt5-20020a17090af2c500b002473e0a71cdmr7259865pjb.6.1681607470054;
        Sat, 15 Apr 2023 18:11:10 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:eeb9])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b001a260b5319bsm5154015plj.91.2023.04.15.18.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 18:11:09 -0700 (PDT)
Date:   Sat, 15 Apr 2023 18:11:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 5/9] bpf: Migrate bpf_rbtree_add and
 bpf_list_push_{front,back} to possibly fail
Message-ID: <20230416011106.hloajgkq5c7tctju@macbook-pro-6.dhcp.thefacebook.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-6-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415201811.343116-6-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 01:18:07PM -0700, Dave Marchevsky wrote:
> -extern void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
> -			   bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b)) __ksym;
> +extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
> +			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
> +			       void *meta, __u64 off) __ksym;
> +
> +/* Convenience macro to wrap over bpf_rbtree_add_impl */
> +#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)

Applied, but can we do better here?
It's not a new issue. We have the same inefficiency in bpf_obj_drop.
BPF program populates 1 or 2 extra registers, but the verifier patches the call insn
with necessary values for R4 and R5 for bpf_rbtree_add_impl or R2 for bpf_obj_drop_impl.
So one/two register assignments by bpf prog is a dead code.
Can we come up with a way to avoid this unnecessary register assignment in bpf prog?
Can we keep
extern void bpf_rbtree_add(root, node, less) __ksym; ?
Both in the kernel and in bpf_experimental.h so that libbpf's
bpf_object__resolve_ksym_func_btf_id() -> bpf_core_types_are_compat() check will succeed,
but the kernel bpf_rbtree_add will actually have 5 arguments?
Maybe always_inline or __attribute__((alias(..))) trick we can use?
Or define both and patch bpf code to use _impl later ?

@@ -2053,6 +2053,12 @@ __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node
        return __bpf_rbtree_add(root, node, (void *)less, meta ? meta->record : NULL, off);
 }

+__bpf_kfunc notrace int bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
+                                      bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
+{
+       return 0;
+}

Only wastes 3 bytes of .text on x86 and extra BTF_KIND_FUNC in vmlinux BTF,
but will save two registers assignment at run-time ?
