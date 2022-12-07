Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FAE64518D
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLGBw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLGBwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:52:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B090653ECE
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:51:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so127807pjb.0
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 17:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5n8oE+5Di7ov3Kbgy/L3HLWOGbbbj5uogqmVzOe0g5o=;
        b=jMxFrbffgGLeJiFqQbtP2W0xHB7qh9wg7Veii0pkYGW9w/jN29fQjSERIoNl7SfMDE
         YyDxrDp6mVLbSJ+BAKKrMlNdff8FLCMLquRL21AvXIikV3QwxKvaK+9WpiCgg0sDsBuL
         mPY70fnXpkzAc2dR8tZ9P6yKqGx1mspYh7d81jiHZnDnGkYThAbkiac4v/vjupM2mlNg
         CLEkNu2Jc9Mufh064yAIlTB9cMdmn9z4qUi6RJ+ZkJ52xvKGn2RRYjmj+huldK1511rj
         rMCJdki9PrBb9UtrgglU4DePcA0hLWa5B7mBIyL2GnPqJOcCsLAGYvYbyJhTSkbinoSf
         v79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n8oE+5Di7ov3Kbgy/L3HLWOGbbbj5uogqmVzOe0g5o=;
        b=MemXcrxy/QF3pHLRnW8iU7iQLerEkGBmcYu2LZILVTYp8AvKllSgVLY/FV0wr/rfJT
         6tn5Mwgg6xBBWWCpkoD8eIMhm6KKWX6tGA2VZC3U6pEzCx844UPPWVti9vxYnYuOvF2q
         LPIcKg+CizwczqYLDDR4tI42KQo9ZeL2vh+EdCsm5h0BFiaZFOuBQullQ5LI/pyvLarJ
         qlV4mn/TErKzKsclGOQ4QTf61ViZ7+GgT9+J3q4bgN4z++JO6vcsawwHdf2J22XUA7Ub
         A0vB8tw1VN2xujOhSINjTsupWMCOGnRTJpuAfgozrbJV46QW9xcZi0b2UKkJvJqPSkd/
         vjYw==
X-Gm-Message-State: ANoB5plYVkl7O44dGlxG9eA6FH9x3hcUkv6twsp0BiItbJTYV1TRk0KJ
        qWu9YG+itDoZ8PABUaT+gLA=
X-Google-Smtp-Source: AA0mqf4z73S/H2YPL8VQhz7/tVcB61Cb0qQJuogbuo8qGD4/JxsKrkT4ydQzDmmTGMZOYHFf36QIPQ==
X-Received: by 2002:a17:902:d589:b0:189:f740:14e with SMTP id k9-20020a170902d58900b00189f740014emr93985plh.26.1670377892196;
        Tue, 06 Dec 2022 17:51:32 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id n6-20020a1709026a8600b00189618fc2d8sm13228768plk.242.2022.12.06.17.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:51:31 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:51:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 07/13] bpf: Add support for bpf_rb_root and
 bpf_rb_node in kfunc args
Message-ID: <Y4/xoOqc3DR+qSon@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-8-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-8-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:54PM -0800, Dave Marchevsky wrote:
>  
> -static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
> +static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> +{
> +	return btf_id == special_kfunc_list[KF_bpf_rbtree_add] ||
> +	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> +	       btf_id == special_kfunc_list[KF_bpf_rbtree_first];
> +}
> +
> +static bool is_bpf_datastructure_api_kfunc(u32 btf_id)
> +{
> +	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
> +}

static bool is_bpf_graph_api_kfunc(u32 btf_id)
{
	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
}

would read well here.
Much shorter too.
