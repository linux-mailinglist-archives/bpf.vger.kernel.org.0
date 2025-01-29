Return-Path: <bpf+bounces-50069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBAA2260C
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E3918848DE
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43E1E04BD;
	Wed, 29 Jan 2025 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXTAqgVW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0C1917C7
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188300; cv=none; b=ZYRDbAJ5iawOd0XnG7EJaXNiez3iBD1BeqBZG4KXthH2OGAIc7ZjB+l5WJ+viReWDmtmTxFZgP2tolsjlGadt4OXMwHyQvi1VeNMxMpFnrvy8ipLbH82wZ2KVCRsG0LBCpw8T2X9HaFvCbrXx+p01xzToBun3QLa81fINQeTTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188300; c=relaxed/simple;
	bh=pgVS+2RVqkeljPXKnoTpwi/V4xHl8AC4iRBb6CPFkMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPVZHnSwAoe0iYDRrIq1SL0SaQIVC/oQALASKe0sT9NfR6iK4IfLJdpoHiKCrfM64lI7yHCzxyWLAknHITa+tcIlVfz+cWfkbr2GNP9ln2a1tSpFHCuWFTUXQfqobxDjSrF6N2t1BgjNSv2qC+m7/736haF9xQyaPt7+TsELl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXTAqgVW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163affd184so16625ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738188298; x=1738793098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auSdm9fG6SQqLgOEHyJmhNe+uwxMyUkZzDF+skISzAg=;
        b=zXTAqgVWNa44rZhwIgk8k5TbKAsHhF7GEtLb9UK/bp26qFlK6Fw2FCPe/7vcodgB21
         MgjRlL1eFtE/3dmqUrxTiahewA2JNmKyFZjuM2tAWBtv3jSKNCC9eRb2JiyNIYrtK+8R
         3MrzU7upJ9ascKY8kxuBRrc8Y95+zw+iVHzKVs2t+65BHLXNZ3xKLFZvfP12EO/2faoB
         kXu5VOmyDBsjyGMj0mLmp75Ell4ab0fYpvCn9448DPwUa93qh0F5tU9VrGFJk0BORTFI
         CFVCm57ospMCaz+flDwA6FYzYcOKELtszGa/M5skEF9QZlL43O2HRR7/IJJgZvg9xZDt
         cLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738188298; x=1738793098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auSdm9fG6SQqLgOEHyJmhNe+uwxMyUkZzDF+skISzAg=;
        b=n51hnGp0pOmzphcjbXBgumuIJj7novZLI7DBPOy28fNlQCD9K6WIUdvZAuyiGvle8w
         mlH4QhEA9UvgqiYc+ZDa3U9lTaZIsS7dOuibPXL1hxRS0Bbd5IZ/KXZx8IKnJZq9v7c7
         mPuJwjlVo0AddhfRt8oZq5m6CS41IQCZ8UnJ3BWPcpB/JXqC4xCk97PvIoTGaBdr7mHi
         g/9eo81O6zSKxPyi6XQ14Zvg59yw3zMRMr/mop5+eGIEU+RyG6G/fTrZT1gRNZ4njEit
         RjN2lCb81s6HKPGqnkz+n5ACthaAUEYJycXILAonMzfAn1n676xNpaem6YKRVsEwvxg2
         4D7g==
X-Gm-Message-State: AOJu0YwBt/8joCptfv3Y52sPsmd3VPN1DAjkQS21YXkG2U22jDwi0YmZ
	6z+7QuWPncrhhV+omkonIQHXxXxSwFvFXCR92yqZ4mWhB0+Ns0kGtDmtV0Ay2w==
X-Gm-Gg: ASbGncsuXWMLjn9FBJ+3BcxAd03NXRobDQ7uCU1fLdEWtMN5wD4snCXs8lPgT8JuPWd
	OID2KQIGAenGVKioMxTdmuNCdJIK9G8kxZpOsRpHpfioFCmxVCsSAZQBS0OTZ4Ly73tTyKDBrkB
	fBRGX+im9KJumPwoSjTwONmkjE+W88MgfWsGwhjfFzP5TijFOoK3jhILHz2oBt80B1pivttRHAG
	rVMv3lb+BkMmTiZ3C0fPoDxEl0ys25BLar33mo8vBoqEfwT6KGBKrKFP+XhsglGM9G7wnYiSmKw
	ptJbhymR/r6vLS2ivCvYQVGgnjceloNMn3eGH3AtqHAWzq6gZBw=
X-Google-Smtp-Source: AGHT+IGAEupXKx0SgR80Zek2UaXseRz4OsaO8ZX/PoFVeYvwYFhxIx+geWC831A7hQ0syi8KM0YqQA==
X-Received: by 2002:a17:902:ef45:b0:216:33a:4b70 with SMTP id d9443c01a7336-21de23a413cmr760805ad.2.1738188297521;
        Wed, 29 Jan 2025 14:04:57 -0800 (PST)
Received: from google.com (55.131.16.34.bc.googleusercontent.com. [34.16.131.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a763468sm12006873b3a.106.2025.01.29.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 14:04:57 -0800 (PST)
Date: Wed, 29 Jan 2025 22:04:53 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z5qmBaGE4a7NtaFU@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
 <b7de0135f7dcca0485ce9dc853d6ca812c30244b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7de0135f7dcca0485ce9dc853d6ca812c30244b.camel@gmail.com>

On Tue, Jan 28, 2025 at 04:19:25PM -0800, Eduard Zingerman wrote:
> On Sat, 2025-01-25 at 02:18 +0000, Peilin Ye wrote:
> > Signed-off-by: Peilin Ye <yepeilin@google.com>
> > ---
> 
> I think bpf_jit_supports_insn() in arch/{x86,s390}/net/bpf_jit_comp.c
> need an update, as both would accept BPF_LOAD_ACQ/BPF_STORE_REL at the
> moment.

Got it - I will move is_atomic_load_store() into <linux/bpf.h> for that.

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks!

> > +static int check_atomic_load(struct bpf_verifier_env *env, int insn_idx,
> > +			     struct bpf_insn *insn)
> > +{
> > +	struct bpf_reg_state *regs = cur_regs(env);
> > +	int err;
> > +
> > +	err = check_reg_arg(env, insn->src_reg, SRC_OP);
> > +	if (err)
> > +		return err;
> > +
> > +	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
> > +		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
> > +			insn->src_reg,
> > +			reg_type_str(env, reg_state(env, insn->src_reg)->type));
> > +		return -EACCES;
> > +	}
> > +
> > +	if (is_arena_reg(env, insn->src_reg)) {
> > +		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
> > +		if (err)
> > +			return err;
> 
> Nit: this and the next function look very similar to processing of
>      generic load and store in do_check(). Maybe extract that code
>      as an auxiliary function and call it in both places?

Sure, I agree that they look a bit repetitive.

>      The only major difference is is_arena_reg() check guarding
>      save_aux_ptr_type(), but I think it is ok to do save_aux_ptr_type
>      unconditionally. Fwiw, the code would be a bit simpler,
>      just spent half an hour convincing myself that such conditional handling
>      is not an error. Wdyt?

:-O

Thanks a lot for that; would you mind sharing a bit more on how you
reasoned about it (i.e., why is it OK to save_aux_ptr_type()
unconditionally) ?

> > +	}
> > +
> > +	/* Check whether we can read the memory. */
> > +	err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
> > +			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
> > +			       true, false);
> > +	if (err)
> > +		return err;
> > +
> > +	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "atomic_load");
> > +	if (err)
> > +		return err;
> > +	return 0;
> > +}
> > +
> > +static int check_atomic_store(struct bpf_verifier_env *env, int insn_idx,
> > +			      struct bpf_insn *insn)

Thanks,
Peilin Ye


