Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E936451E3
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLGCSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGCSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:18:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ACB50D49
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:18:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so15746298plr.10
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/srxnEl7ggusR7LUag+eU+rZ+XHpViMqA89xmTvNtlk=;
        b=dlYdGAI8x5WHr8Z3gsQMJb+njey3KsCwJi8CGrUuTdWvFZg20rjq9Wd2VygvATzmey
         1Vi2oTV3RZmHmgXsFUFXlodFLV0OMsy8e6cdrvMXT3jhKeqwXctrRFa/iV1UywqneBX8
         Jy+7NapWuahyT3EfmJkhJOKj3RS6PrqjfbbGav/gZyXjs1OyAihLKWS6deEg7lYpLWbY
         OOeR5IEclzazQriqVS5/mZxvZ/qXvD7SgnNUoSV93PxapuAKUzZX7xKNpThwtO1TE7fZ
         sIkND0g8RpSESxD2VXSZuqY69MSDBlZraETeg2rKq6gllC4Wo/2pVPTw48i0+KRZ2FdC
         tpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/srxnEl7ggusR7LUag+eU+rZ+XHpViMqA89xmTvNtlk=;
        b=DsS88YdlbVv0yAxGqaX8mRBNcd6ega25jQPMh2Es9+q01YhoevfiboAE0NiGx8hQ89
         ZkG1/xTTAGrudyuqgfJPzpgcN3TdhulecPfggx8dhny6D43WGbdHU1c5+FVam2SvagFJ
         WjAVlKPkyk0OaMdg7b/tFjLxeMPsuDWZ3WWbmjqGxePSH3yxv0KswhbanhG3dcNOj027
         p4w9HAeuI34AGykMKk04DR+DOTcrKr8gl1Qbslc1M1hhZh+RPnPRpI2HXZgc4R4tMq6y
         XUwzuEG7sP/pG8GBsiDx7AFlaNPQwoXG1xNRlJWAD8EP0CJ1dIOvxw55Di4+j9jqqpnf
         lQvA==
X-Gm-Message-State: ANoB5pkAGi24Ucbyxk70aDuWco9sQABVBe5GXhMJhOmb53q5Ql8h98sM
        Rx3GojmSSxF0kFSGSs8FHff7xEm6Bb0=
X-Google-Smtp-Source: AA0mqf4dwQaVkaQlXiylzTnUutHHijx+AMlHkOdHSaLDS+LIlConCPS0yk/gUfXTfpkIeUxcv/3qqA==
X-Received: by 2002:a17:902:f64d:b0:189:603d:ea71 with SMTP id m13-20020a170902f64d00b00189603dea71mr574323plg.58.1670379521690;
        Tue, 06 Dec 2022 18:18:41 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b00185402cfedesm13343173plx.246.2022.12.06.18.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:18:40 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:18:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 09/13] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <Y4/3/Y4gXAapWIzD@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-10-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-10-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:56PM -0800, Dave Marchevsky wrote:
> Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> that require handling in the verifier:
> 
>   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
>     the bpf_rb_node field, with the offset set to that field's offset,
>     instead of a struct bpf_rb_node *
>     * Generalized existing next-gen list verifier handling for this
>       as mark_reg_datastructure_node helper
> 
>   * Unlike other functions, which set release_on_unlock on one of their
>     args, bpf_rbtree_first takes no arguments, rather setting
>     release_on_unlock on its return value
> 
>   * bpf_rbtree_remove's node input is a node that's been inserted
>     in the tree. Only non-owning references (PTR_UNTRUSTED +
>     release_on_unlock) refer to such nodes, but kfuncs don't take
>     PTR_UNTRUSTED args
>     * Added special carveout for bpf_rbtree_remove to take PTR_UNTRUSTED
>     * Since node input already has release_on_unlock set, don't set
>       it again
> 
> This patch, along with the previous one, complete special verifier
> handling for all rbtree API functions added in this series.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/verifier.c | 89 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9ad8c0b264dc..29983e2c27df 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6122,6 +6122,23 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	return 0;
>  }
>  
> +static bool
> +func_arg_reg_rb_node_offset(const struct bpf_reg_state *reg, s32 off)
> +{
> +	struct btf_record *rec;
> +	struct btf_field *field;
> +
> +	rec = reg_btf_record(reg);
> +	if (!rec)
> +		return false;
> +
> +	field = btf_record_find(rec, off, BPF_RB_NODE);
> +	if (!field)
> +		return false;
> +
> +	return true;
> +}
> +
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
>  			   enum bpf_arg_type arg_type)
> @@ -6176,6 +6193,13 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  		 */
>  		fixed_off_ok = true;
>  		break;
> +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
> +		/* Currently only bpf_rbtree_remove accepts a PTR_UNTRUSTED
> +		 * bpf_rb_node. Fixed off of the node type is OK
> +		 */
> +		if (reg->off && func_arg_reg_rb_node_offset(reg, reg->off))
> +			fixed_off_ok = true;
> +		break;

This doesn't look safe.
We cannot pass generic PTR_UNTRUSTED to bpf_rbtree_remove.
bpf_rbtree_remove wouldn't be able to distinguish invalid pointer.

Considering the cover letter example:

 bpf_spin_lock(&glock);
 res = bpf_rbtree_first(&groot);
   // groot and res are both trusted, no?
 if (!res)
   /* skip */
 // res is acquired and !null here

 res = bpf_rbtree_remove(&groot, res); // both args are trusted

 // here old res becomes untrusted because it went through release kfunc
 // new res is untrusted
 if (!res)
   /* skip */
 bpf_spin_unlock(&glock);

what am I missing?

I thought
bpf_obj_new -> returns acq obj
bpf_rbtree_add -> releases that obj
same way bpf_rbtree_first/next/ -> return acq obj
that can be passed to both rbtree_add and rbtree_remove.
The former will be a nop in runtime, but release from the verifier pov.
Similar with rbtree_remove:
obj = bpf_obj_new
bpf_rbtree_remove(root, obj); will be equivalent to bpf_obj_drop at run-time
and release form the verifier pov.

Are you trying to return untrusted from bpf_rbtree_first?
But then how we can guarantee safety?
