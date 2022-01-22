Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675C34969F2
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 04:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiAVD45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 22:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAVD45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 22:56:57 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF81C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:56:57 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso15351746pjh.0
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ad1JKMu2lqygC/ALepI/EKZbee98pAx1t3pJ3YT+wI=;
        b=fQebTkBhxlsQRKMQg95Rq4TJwXPCUxbRgaoBkDaCvhHqFfg4+gPoMJz0IfR94W5vFt
         WY59zQ9cYnSRZ0NEdzTWSvDIxEEWH+rbP/3xjvmdg3okqNFV0SAAZrEiRGHXm2vbf+E6
         aRloOWCOGgdHEpnLB7KQKd+p8PwspaKv4pv+fXnOG2Mry2299QYN/35I/OmZerBZsb2b
         Ns1xbT1l/PW2SyG0fRkdm7M5qq1vPVv7c+sb6KOmec+Qw0upHBk64KMNv/YAYg4PW14Q
         PNiwGENT7GtfzTFZ9/v7Siy3vfl3ZWXCLmieIeV8fwReYjibRFerBGWBLcYK9V2IG8Bu
         S7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ad1JKMu2lqygC/ALepI/EKZbee98pAx1t3pJ3YT+wI=;
        b=7GmLBauzAmzBUh65PKsZH0JpV7ok278We3WyzLomG/rNXHiLC9JmugpvosojsFe/Bg
         qlrtIzIqUHtb+urr7zjHfgb2cWMVyDFf06IOqVYd/KpR+gN5DFYE2Dzlmaq0jIKfHBtN
         doXhEHN/cTRwxlUPfZ2jvq3Dbtc9vIGcX49lWw2nVnQRFnebXBFZ5dt+Fu+AgiNW6xGG
         wAl4AGmEM5WIRtMTitNV+hFM4glv2oU1cp3LhZE2XOL/b1TQ3Xj/Nbabn5ylb0dAUbk/
         6mh18ouby6w98geFc1cyWNNpxSefd1Y7u95xDMmMgFtb4VbGtpMg5eb3am6m6MsqjxFg
         BPOw==
X-Gm-Message-State: AOAM53000OhyftvkWkgEi+BDKFHSSZ8tczenpvoxvSASipG3iNR+ORbd
        OT6n98npk6AgqIXqgtl4g2Q=
X-Google-Smtp-Source: ABdhPJzV5zTQjwmsetCpQhReabE/ARlxZ9omekQcjCJWDEF9jpNWyYEoz2YTlL4fEncMGJ5E+0sI3w==
X-Received: by 2002:a17:90b:3892:: with SMTP id mu18mr3587631pjb.51.1642823816532;
        Fri, 21 Jan 2022 19:56:56 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:1fb1:21a:3dae:742c])
        by smtp.gmail.com with ESMTPSA id x17sm7944242pfj.117.2022.01.21.19.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:56:56 -0800 (PST)
Date:   Sat, 22 Jan 2022 09:26:42 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
Subject: Re: [RFC bpf-next 2/3] bpf: add support for module helpers in
 verifier
Message-ID: <20220122035642.7cax2eoz5xqaycq3@thp>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121193956.198120-3-usama.arif@bytedance.com>
 <20220122033133.ph4wrxcorl5uvspy@thp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122033133.ph4wrxcorl5uvspy@thp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 22, 2022 at 09:01:33AM IST, Kumar Kartikeya Dwivedi wrote:
> On Sat, Jan 22, 2022 at 01:09:55AM IST, Usama Arif wrote:
> > After the kernel module registers the helper, its BTF id
> > and func_proto are available during verification. During
> > verification, it is checked to see if insn->imm is available
> > in the list of module helper btf ids. If it is,
> > check_helper_call is called, otherwise check_kfunc_call.
> > The module helper function proto is obtained in check_helper_call
> > via get_mod_helper_proto function.
> >
> > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > ---
> >  kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 39 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8c5a46d41f28..bf7605664b95 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6532,19 +6532,39 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  	int insn_idx = *insn_idx_p;
> >  	bool changes_data;
> >  	int i, err, func_id;
> > +	const struct btf_type *func;
> > +	const char *func_name;
> > +	struct btf *desc_btf;
> >
> >  	/* find function prototype */
> >  	func_id = insn->imm;
> > -	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
> > -		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
> > -			func_id);
> > -		return -EINVAL;
> > -	}
> >
> >  	if (env->ops->get_func_proto)
> >  		fn = env->ops->get_func_proto(func_id, env->prog);
> > -	if (!fn) {
> > -		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
> > +
> > +	if (func_id >= __BPF_FUNC_MAX_ID) {
> > +		desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
>
> I am not sure this is right, even if we reached this point. add_kfunc_call would
> not be called for a helper call, which means the kfunc_btf_tab will not be
> populated. I think this code is not reachable from your test, which is why you
> didn't see this. More below.
>
> > +		if (IS_ERR(desc_btf))
> > +			return PTR_ERR(desc_btf);
> > +
> > +		fn = get_mod_helper_proto(desc_btf, func_id);
> > +		if (!fn) {
> > +			func = btf_type_by_id(desc_btf, func_id);
> > +			func_name = btf_name_by_offset(desc_btf, func->name_off);
> > +			verbose(env, "unknown module helper func %s#%d\n", func_name,
> > +				func_id);
> > +			return -EACCES;
> > +		}
> > +	} else if (func_id >= 0) {
> > +		if (env->ops->get_func_proto)
> > +			fn = env->ops->get_func_proto(func_id, env->prog);
> > +		if (!fn) {
> > +			verbose(env, "unknown in-kernel helper func %s#%d\n", func_id_name(func_id),
> > +				func_id);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
> >  			func_id);
> >  		return -EINVAL;
> >  	}
> > @@ -11351,6 +11371,7 @@ static int do_check(struct bpf_verifier_env *env)
> >  	int insn_cnt = env->prog->len;
> >  	bool do_print_state = false;
> >  	int prev_insn_idx = -1;
> > +	struct btf *desc_btf;
> >
> >  	for (;;) {
> >  		struct bpf_insn *insn;
> > @@ -11579,10 +11600,17 @@ static int do_check(struct bpf_verifier_env *env)
> >  				}
> >  				if (insn->src_reg == BPF_PSEUDO_CALL)
> >  					err = check_func_call(env, insn, &env->insn_idx);
> > -				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
> > -					err = check_kfunc_call(env, insn, &env->insn_idx);
> > -				else
> > -					err = check_helper_call(env, insn, &env->insn_idx);
> > +				else {
> > +					desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
> > +					if (IS_ERR(desc_btf))
> > +						return PTR_ERR(desc_btf);
> > +
>
> I didn't get this part at all.
>
> At this point src_reg can be BPF_PSEUDO_KFUNC_CALL, or 0 (for helper call). If
> it is a helper call, then find_kfunc_desc_btf using insn->imm and insn->off
> would be a bug.
>
> > +					if (insn->src_reg == BPF_K ||
>
> [...]
>

Ah, I think I see what you are doing: BPF_K is zero, so either when it is a
helper call or it is a module helper (which will be a kfunc), you call
check_helper_call. get_mod_helper_proto would return true in that case.

But if it is an in-kernel helper, calling find_kfunc_desc_btf would still be a
bug, since imm encodes func_id.

It's also a bit confusing that check_helper_call is called for a kfunc.

> > +					   get_mod_helper_proto(desc_btf, insn->imm))
> > +						err = check_helper_call(env, insn, &env->insn_idx);
> > +					else
> > +						err = check_kfunc_call(env, insn, &env->insn_idx);
> > +				}
> >  				if (err)
> >  					return err;
> >  			} else if (opcode == BPF_JA) {
> > --
> > 2.25.1
> >
