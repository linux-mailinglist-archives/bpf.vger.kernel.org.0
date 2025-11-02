Return-Path: <bpf+bounces-73289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6BC297E4
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42C313472DF
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2E244668;
	Sun,  2 Nov 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EheY366Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEC225791
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120453; cv=none; b=IlAXgbmNehkIHC7c0Td/gLWSgQN787736s6mmgjC1+kmJb8Hx/mFW/HQHy5BBJ7LPpsUnrQxbnU9gyoYPC2M9SdsA3hacEDO7AEpmwG09Dwq5TXfwV4nKVFdn34aoGye64uksJNeZHrspYlLCsKjeLGUnPtYmiv6l4qLmEsGJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120453; c=relaxed/simple;
	bh=vU9XFuO+e6HrhEzWsGoS2K47dV9S06bxcHRTU9grwBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9i2Dyaei+HWRW5VyNLXT2KY9k8ZAmXQgl9Omg5CGwVXxog2AdHjUtZZ72dCTs1jMrQJ8cB6A/8029ZywCNoV1Ux0v71rmSbdSyOyt0mGxICZSaXuyp0yxaBKqczyAA4YF9tMyFNIknjUHjNaqfVp6K1JBmBUqZKNibx4thUL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EheY366Q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1331330a12.1
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762120450; x=1762725250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzITANV99Ajo036P3d0QNcgnWvusxtYCct97KMMKjnI=;
        b=EheY366QC+8pdotQoK1+LVKl5Uti9pLPpKJOSZE05knN+vd/AUty8UFD37Y8dJomP8
         xvyA2vR6Wa3M+IFcBrRVa9jJEtgr9olPgWGvx9fzOaciZ9+nfGFgI1idtz+rJ+ot7c1d
         gAmAjiJNbN4qEzD4YjO2oDVxQenhr99fBi/9LIt0qR+PuFlNAEOImXoBZjLADvFe6e8F
         Hlul5Z89UMv5u7vrORE6nHuxMczl4ntLlaBiGWaprGWJfbO5i2Dv4Hiu+B/6bGFgLhdW
         o/sk2eAWBiut6knN7YZOPPNMOCnNGpiMwGI6yMrBDpZKNlBVFF8PHQE4HxRX4ZLHJELt
         +EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762120450; x=1762725250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzITANV99Ajo036P3d0QNcgnWvusxtYCct97KMMKjnI=;
        b=Q71QVxUdoTZF08p9dR+dllksxKp9WZFXFA2XTq8RgTiMbbV5LzzCF+vMueZvHAWz9D
         9FCypEfDrB74IQ2d7zl5Doh67agOc01Uubc8MCGcoIUrbjwxlzNgBDbIvxrnBQYgWA8e
         Y0DjHTG1kqBAuowh/esjPlAZ6qBnJYLphz7ftMRodMjlcJ3TLKumEnR8fKu45KQJ6AZn
         19tIEep9rx3ZzL+5i4KkYjnCKu2saDMuC1B7dKi/tPih/948lmtL/u0W0CDWbW8C/bAB
         oFW/OVav/xNz+LYjV7knn1TVsx8ftPbj/OcWJEUgujBpHDP6LV7IT5wBsTnjTluZXI11
         rJtg==
X-Gm-Message-State: AOJu0YxQcXLqLaaXGgysdUTcL7Bh1PkYlWZGC5kZuGwkXEGHtkp02bZk
	w9bV5jjXkuxhApUetsuvl6VQPT4a1NUh4ZKSbI7FRfTdjtKfpTn7qGXT
X-Gm-Gg: ASbGncsHW1VeliPaeBEYfZM18dnV3YvI9Zfjak+GOuHZdLnh01laCbdVNn/gvrgJk1H
	324BgY+VMrd9tZUhrYu+RTO5wLZdWxZiwpm/YeIatcclhav5Yzvi55Mquv0x2JDJMjFT27H98rk
	AY5VoXI5sgDyZWTCpPHgCyZlAKCD5uNhNhk5Obzfh7cZ9F0UBJVo1T/iDmsRzhzKAFwiYrYKaH5
	JtP1Z6DSYS2SLPzx5Nz2A0/vz9lzVWxu87i9efahXAgFnF/gF1jB1UAgt95gLWO3oG+FfOIyzF8
	Q6u4pgro7na3Z+BWl+jg5iHeS7so0avlNAM0sYOH9WJ3L5I5Py/6i7pS+Oix2WVbhYYbtnv+aOn
	07l/Zc4m8tRXvDHKfGTahcSn1oYsd/qEALx2oCY+uWJjK8F5T1RcZFXMpepHJr633geKRvWYA1B
	FPqmSz51Jigw==
X-Google-Smtp-Source: AGHT+IGv+tpjtPBErIKv00MmljIJaBG2R9/jjL/+OoHPefPESmdRLoBxn1N63tqP7vWC8d4NBbtdgw==
X-Received: by 2002:a05:6402:90c:b0:640:96b8:2c36 with SMTP id 4fb4d7f45d1cf-64096b82e5bmr4702225a12.11.1762120450066;
        Sun, 02 Nov 2025 13:54:10 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640b1c61dd0sm3056663a12.26.2025.11.02.13.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 13:54:09 -0800 (PST)
Date: Sun, 2 Nov 2025 22:00:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v10 bpf-next 06/11] bpf, x86: add support for indirect
 jumps
Message-ID: <aQfUfiRbGb0UdLS0@mail.gmail.com>
References: <20251102205722.3266908-7-a.s.protopopov@gmail.com>
 <fff3a198c4d0f8abc33f6d1633585ccb13f1709786bb9f5080641631f69628df@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff3a198c4d0f8abc33f6d1633585ccb13f1709786bb9f5080641631f69628df@mail.kernel.org>

On 25/11/02 09:20PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 6cb8001495faae09541d55309638b3c1920bae06
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> bpf, x86: add support for indirect jumps
> 
> This patch adds support for indirect jumps in BPF through a new
> BPF_JMP|BPF_X|BPF_JA instruction. It introduces the PTR_TO_INSN register
> type for instruction pointers loaded from INSN_ARRAY maps, along with
> verifier support for tracking jump tables and x86 JIT implementation.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -21374,6 +21374,28 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
> >  	return 0;
> >  }
> >
> > +/*
> > + * Clean up dynamically allocated fields of aux data for instructions [start, ...]
> > + */
> > +static void clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
> > +{
> > +	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> > +	struct bpf_insn *insns = env->prog->insnsi;
> > +	int end = start + len;
> > +	int i;
> > +
> > +	for (i = start; i < end; i++) {
> > +		if (insn_is_gotox(&insns[i])) {
> > +			kvfree(aux_data[i].jt);
> > +			aux_data[i].jt = NULL;
> > +		}
> > +
> > +		if (bpf_is_ldimm64(&insns[i]))
> > +			i++;
> > +	}
> > +}
> > +
> >  static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
> >  {
> >  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> > @@ -21393,6 +21415,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt
> >
> >  	adjust_insn_arrays_after_remove(env, off, cnt);
> >
> > +	clear_insn_aux_data(env, off, cnt);
> > +
> >  	memmove(aux_data + off,	aux_data + off + cnt,
> >  		sizeof(*aux_data) * (orig_prog_len - off - cnt));
> 
> Can clear_insn_aux_data() correctly identify which aux_data entries need
> cleanup when it's called after bpf_remove_insns()? After instructions are
> removed, the insns[] array has been modified - insns[off] now contains what
> was previously insns[off+cnt]. But aux_data hasn't been shifted yet, so
> clear_insn_aux_data() checks the wrong instructions when deciding which
> aux_data entries to free.
> 
> For example, if instructions [1,2] are removed where insn 2 is a gotox:
> - bpf_remove_insns() removes insns[1] and insns[2], shifts later insns down
> - insns[1] now contains what was insns[3]
> - clear_insn_aux_data() checks insn_is_gotox(&insns[1]) (now insn 3!)
> - It might free aux_data[1].jt if insn 3 is a gotox, even though insn 3
>   isn't being removed
> - It never checks the original insns[2] which was the actual gotox that
>   needed cleanup
> 
> Should clear_insn_aux_data() be called before bpf_remove_insns() instead?

Looks plausible. I will move it upper and add a comment on the call order.

> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf, x86: add support for indirect jumps`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915


