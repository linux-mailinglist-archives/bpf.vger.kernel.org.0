Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845F62F2B4
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 11:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiKRKhh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 05:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiKRKhg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 05:37:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106593CC8
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 02:37:35 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j12so4207913plj.5
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdC9OdXaf8rtCDJq2ZR+NC5bExkE/80g/hOu2ZJHyKI=;
        b=VxSlR5VvPichJB/NM/JV20xvWgEmzpGmVwyZvyODe2LZ1UQ3PYdbC/RtmcCxnIO5m2
         DHNEqc9JkWVfoPHny6syKlWQ7cQ5PCW9bjEbFgO54cBkqPoEdnxKh2w7ivJooebkGBGW
         6/FiCrNZ+8xPxB9CEl7vqeS16uvf2GrJ2cJBfoOyUEaHUX+L7PdszUSZnqGlSVkn0MFN
         GrLY3kvFU2bdXFq70PBlmA2zN+2Aa4DtumxH1BxpQdR47pmVT89Qm9PzDY12POciH5mb
         5YcQ+IKJmWSziRe0iDEeiuDvf5aTOCfs5eY3mVrdXR1++SG0W9lPx6HXnOFGs7G5wyFu
         q7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdC9OdXaf8rtCDJq2ZR+NC5bExkE/80g/hOu2ZJHyKI=;
        b=TQK9d/fTAalB8EFDFxphRkjhp+tUxdgjg/xZaZNyTd3iWqYTkRNW3fFaC6z+0ZWt3f
         J+fSfob7InClgkBPm5IEjLvN2VOMe0Kbx9XwXvA/NqbL8xDUAJpjnvjb5oIHWA8As14e
         SpJPHAaGfPwXH3Vqrdks1siySqLcfbSLoBSvcsHsWluBEDfQg510KWYvIsC5F5nApjrj
         tomsSNW+JVey+IdGDwWuIg66GeXaDdwTpjCVMtHLvNC0cdMZ8p33dNJMBKhzy+hXC1BV
         o3LonXyDpKddaW4ZIuKZeZU5E/a85QKh8DNw5S3kGK3Vg986mDZBrujOg0bMifQ0u4m1
         T7rA==
X-Gm-Message-State: ANoB5pkC7/nMZvesyfiSeFh6fTI/OTh7N7poiGotlQgyVUg1b78kuVVg
        Ug1lehG58lAboKnuid9R0hI=
X-Google-Smtp-Source: AA0mqf5dadbk0fof33CiunEdMw9Am0drVwB5WnsZKGZgOoXWIR5LgBkEV0vnOWTcZiqqIYXm3mZoDw==
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id t15-20020a17090aae0f00b0020db12433b1mr7005606pjq.202.1668767854746;
        Fri, 18 Nov 2022 02:37:34 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b001867fdec154sm3173674pld.224.2022.11.18.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:37:34 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:07:30 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
Message-ID: <20221118103730.nbai3gzifkjk45eo@apollo>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-12-memxor@gmail.com>
 <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 09:04:15AM IST, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  				    const struct btf *btf, u32 func_id,
> >  				    struct bpf_reg_state *regs,
> >  				    bool ptr_to_mem_ok,
> > -				    struct bpf_kfunc_arg_meta *kfunc_meta,
> >  				    bool processing_call)
>
> Something odd here.
> Benjamin added the processing_call flag in
> commit 95f2f26f3cac ("bpf: split btf_check_subprog_arg_match in two")
> and we discussed to remove it.
>
> >  		} else if (ptr_to_mem_ok && processing_call) {
>
> since kfunc bit is gone from here the processing_call can be removed.
> ptr_to_mem_ok and processing_call are two bool flags for the same thing, right?
>

I think so, I'll check it out and send a follow up patch.

> > +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
>
> I fixed this bit while applying.
>

Thanks.

> > +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>
> This function looks much better now.
> The split of kfunc vs helper was long overdue.
> Thank you for doing this.
>
> I'm not convinced that KF_ARG_* is necessary, but it's much better than before.
> So it's a step forward.
>

Yes. Eventually we should be merging checks for both helpers and kfuncs, but
that needs more work and would have been out of scope for this set. We can
probably synthesize a bpf_func_proto for the kfunc from BTF and then offload to
check_helper_call.

> Pls watch for CI errors and follow up when necessary.

Will do.

Thanks!
