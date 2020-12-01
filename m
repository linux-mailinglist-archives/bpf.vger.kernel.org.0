Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2632CA29C
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLAMXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLAMXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:23:18 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A6C0613D2
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:22:38 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so4543925wmb.2
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z2FwklLoMp7Egf9u8WP3hDx0fN64Q0x9HiJR3z7n6Kk=;
        b=b9Q5GXbd+nn4jqIxEBLDYv8yiSKV3SzTOVp/VrzFb4iZY4KGG2kVnLb3Y43a99RvBg
         RYJr9LClCcJ/aQhJQecTAh2E4rPBTAceytr4Jjln4ov9omDpfUy7hGhr/wR/Top2rySM
         hZXhX4jLqzLPvfpAc3c+p7cT+JgrDfhra9E3ZyzFXPArAWSlVg3wgOCHaGtNeJNDQAln
         RTPKxvvaYKRGoV14w4+T8rg28J5gXgs/fV4OwPBv8aV+ZHgtSGUAozQjiFLbKveCztB7
         quPjqjruHSBH1x3ZuGtTSoyucZA2O+ICFIqtphmd/t8iqOUlnbmBluuLUsMbpgYmIt2o
         C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2FwklLoMp7Egf9u8WP3hDx0fN64Q0x9HiJR3z7n6Kk=;
        b=PQJ1It2Vpwty0yhm1o0vmfIkPTLjZfg6GbMUZ4jz9uwdod2uYPajuWU/fw4RRuS6Ck
         y8CoRm80CAy2EmA6gRg8xbQub6TsaJ6ECtaWd/CnmKMMi3LG0IfU0ePlLuaw7KKlJVy5
         fbgoGLp1VFBXcMRN9RcWF0LO2dnsVoG2TTIo5yROfGgTvZk8V0sjQcE/Rl/8XbVGZ2dK
         O4eXmLevw0NLjCtOrHaz+IxzGsTQEfcd1ZlPwvNqZv6Wv+dbYu2grFiqZkpZPtu1GYSp
         LA50tV15+l+my6hDW3l0I2uq6jovR8js7KxNl6zmdWMuGVnVxxpSZeFgtYrIzZyLW8DD
         Rc2Q==
X-Gm-Message-State: AOAM530wVSNKlV26AVSP39c/M/pNEZ90ZldHjX6gcYA2ulYxAoDY8HQL
        xIbvC9UlLbD2+cMTajs2/qFfEg==
X-Google-Smtp-Source: ABdhPJzsqR8/wBjBasqdB1Oj1NQiAwf3//4uMqdIbXDhR0tCQeJH9AZQwz8DGxjYGNpAXP8nFlayNA==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr2395276wmb.3.1606825356890;
        Tue, 01 Dec 2020 04:22:36 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a14sm2678636wmj.40.2020.12.01.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:22:36 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:22:32 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 07/13] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
Message-ID: <20201201122232.GD2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-8-jackmanb@google.com>
 <d3a3c534-ae62-7703-9740-f3664c63459c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a3c534-ae62-7703-9740-f3664c63459c@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 08:15:49PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
[...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e8b41ccdfb90..cd4c03b25573 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3602,7 +3602,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   {
> >   	int err;
> > -	if (insn->imm != BPF_ADD) {
> > +	switch (insn->imm) {
> > +	case BPF_ADD:
> > +	case BPF_ADD | BPF_FETCH:
> > +		break;
> > +	default:
> >   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> >   		return -EINVAL;
> >   	}
> > @@ -3631,7 +3635,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   	    is_pkt_reg(env, insn->dst_reg) ||
> >   	    is_flow_key_reg(env, insn->dst_reg) ||
> >   	    is_sk_reg(env, insn->dst_reg)) {
> > -		verbose(env, "atomic stores into R%d %s is not allowed\n",
> > +		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
> >   			insn->dst_reg,
> >   			reg_type_str[reg_state(env, insn->dst_reg)->type]);
> >   		return -EACCES;
> > @@ -3644,8 +3648,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   		return err;
> >   	/* check whether we can write into the same memory */
> > -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> > -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> > +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> > +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!(insn->imm & BPF_FETCH))
> > +		return 0;
> > +
> > +	/* check and record load of old value into src reg  */
> > +	err = check_reg_arg(env, insn->src_reg, DST_OP);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> >   }
> >   static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
> > @@ -9501,12 +9517,6 @@ static int do_check(struct bpf_verifier_env *env)
> >   		} else if (class == BPF_STX) {
> >   			enum bpf_reg_type *prev_dst_type, dst_reg_type;
> > -			if (((BPF_MODE(insn->code) != BPF_MEM &&
> > -			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
> > -				verbose(env, "BPF_STX uses reserved fields\n");
> > -				return -EINVAL;
> > -			}
> > -
> >   			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
> >   				err = check_atomic(env, env->insn_idx, insn);
> >   				if (err)
> > @@ -9515,6 +9525,11 @@ static int do_check(struct bpf_verifier_env *env)
> >   				continue;
> >   			}
> > +			if (BPF_MODE(insn->code) != BPF_MEM && insn->imm != 0) {
> 
> "||" here instead of "&&"?

Right - thanks again!
