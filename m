Return-Path: <bpf+bounces-47723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6F9FEC17
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F30C1620BB
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E89F507;
	Tue, 31 Dec 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOyoeQ6Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397687FD
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735607751; cv=none; b=McOzZ5q96zqUh1DujCoLF1gUcfB8gg4B/KwJb1HO8rsoE1gAkKorXRZk0qHg15hoI+BWbD7UGOVVL5UN8sB8freInqqlpnbegYwDT6kJyVc+VZe1zgNNEgUQ2ygJUu7qc+/fpmJWUINAtMUaubu966qvP66cA3ZLgFYO9Z4ILpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735607751; c=relaxed/simple;
	bh=sSY1XbF1oxRIXmmaijhJ4nXaZUQVUXWqa4rhwBiQB+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlZap2l64oyGt1yR9fYoqXv6r8WJtdTwwxlfEObRwMXBHaIQVMIGfGEo7Q8S631wy4piMYypKxc3vOl9cfuQJsjVjRtJKqHDrUCIOutUEE8HTeHfSQcATv/llCM4gtqxt/iDzzdZ6Nk/C9I8SkeFZzT7DqK9jKikClnwXiF691o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOyoeQ6Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21625b4f978so1101725ad.0
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735607749; x=1736212549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bU44DfVNFhZdddKP7sqRrnrWS7eQdXIUVL22LBgqP5Y=;
        b=cOyoeQ6QpLNtnknsdp4DTldlx7jR3QTOKnWNGv8mz82e65E5ve8MFcXSwdelpI6iyn
         YcH/lWD8heG9H4yG6S9Achbsg1sqO0OC9WUp/AaLautg+BiPImpw7xJK1AtqgoI69Aso
         VvLzvKueQDDQSBTBjJYcwt4sk2XLFKJdkh0XT9Du/9A+KpIJiLXMOYezcTmRR7pFyEeY
         6KkCweXAguoa/ZNdZXaagBKLZb7QBre9o/buCzjTdgc0pQFhd2cQhvPof2fc0Jg/gROJ
         NkqGFTJor6Na/00XRmpMgcS/+prVHR/R7tlHZGM3H9uSs8RfqxsolZMQxlsmYeODHT8b
         dYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735607749; x=1736212549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU44DfVNFhZdddKP7sqRrnrWS7eQdXIUVL22LBgqP5Y=;
        b=EExwE+eb+SzZ8orMDjycbovdfraCtNnAbhGIphOFTleKGhkGeHAYCb3TFbEbkgMJRb
         hXSKe8y/KWu4uNr9Jk8Ba9b7TogcUZ2qS4IWMC0oBV5cfqLrwHSKQsH/cd4AdFIZ7Q6I
         J/i1ED2epXsbzcErNKqwBYiK8ByVkE+hrTYSr+Cdb995pTfwMyYhznqeTCJe9ZzioGRy
         mwElel0u2wvLG52i+IFYW9CaMdjSqjwhq+xR/X9yAQZHV2FRqyMbr2ez8rRYvV9quH36
         7esNYGZNfShjQ0HInHpIW2+dErU4q1JYl0jkaD5kd9jdvNh49B1Crv1t8oaIW0qi6m7B
         42pw==
X-Gm-Message-State: AOJu0YwNSu8Ar7quf6i1Lg2jKAY99ai2g4iU8uqG2qiscq09Bj6emeju
	v9Ny0WyHAmuR4jeGsdu1w2tGbmszVNMnOPtdgq5MXd7MK7wjmaet/ylvjY5W73p55iDZMD6Dk5O
	FIxrR
X-Gm-Gg: ASbGncs9hyohqjHKL70PUi+DH/51h5OpN7lIaSb4mZ2LXPutEefM3T2wQSfbvH/swly
	57X4u8kZ6rOBGss1bTD5veGdcw1LjTUgXo8+TNjpQpKCT0ceP1l4L583uCP7PiFt22Far3Ndk7G
	wCZrsVuo76RrAPxz2Knuq2NYHn5sWCxFaasValbO/rW+hig6kw8a6UGf8VLInaNH4sUPRTYalCH
	yOmPwo2kXlAwDhj+ivKyp5DAnyJi+ezb2UxLsggB8KnDuXvL1gSRnLu4OjaTnoRAgtYbG06SDfo
	zIwa5y9AokkYPIeEXtQ=
X-Google-Smtp-Source: AGHT+IG9vVXq0bODcOzVtZg8nKb4yp7ntyqpp3MtBhtWHUC+tXvqnTJ2k0jASUWKN9LVZAYRo5ShmQ==
X-Received: by 2002:a17:902:ea05:b0:216:201e:1b63 with SMTP id d9443c01a7336-219e770bffcmr15717445ad.11.1735607749360;
        Mon, 30 Dec 2024 17:15:49 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815835sm20584170b3a.27.2024.12.30.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 17:15:48 -0800 (PST)
Date: Tue, 31 Dec 2024 01:15:44 +0000
From: Peilin Ye <yepeilin@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z3NFwKf1FrCk2mWx@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
 <Z23hntYzWuZOnScP@google.com>
 <4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaweicloud.com>

On Mon, Dec 30, 2024 at 04:27:21PM +0800, Xu Kuohai wrote:
> > > As explained above, RS and RT2 fields should be fixed to 1s.
> > 
> > I'm already setting Rs and Rt2 to all 1's here, as AARCH64_INSN_REG_ZR
> > is defined as 31 (0b11111):
> > 
> > 	AARCH64_INSN_REG_ZR = 31,
> 
> I see, but the setting of fixed bits is smomewhat of a waste of jit time.

Fair point, I'll instead make load_acq/store_rel's MASK/VALUE include
those (1) bits.

> > On a related note, I simply grabbed {load,store}_ex's MASK and VALUE,
> > then set their 15th and 23rd bits to make them load-acquire and
> > store-release:
> > 
> >    +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
> >    +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
> >     __AARCH64_INSN_FUNCS(load_ex,   0x3F400000, 0x08400000)
> >     __AARCH64_INSN_FUNCS(store_ex,  0x3F400000, 0x08000000)
> > 
> > My question is, should we extend {load,store}_ex's MASK to make them
> > contain BIT(15) and BIT(23) as well?  As-is, aarch64_insn_is_load_ex()
> > would return true for a load-acquire.
> > 
> > The only user of aarch64_insn_is_load_ex() seems to be this
> > arm64-specific kprobe code in arch/arm64/kernel/probes/decode-insn.c:
> > 
> >    #ifdef CONFIG_KPROBES
> >    static bool __kprobes
> >    is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
> >    {
> >            while (scan_start >= scan_end) {
> >                    /*
> >                     * atomic region starts from exclusive load and ends with
> >                     * exclusive store.
> >                     */
> >                    if (aarch64_insn_is_store_ex(le32_to_cpu(*scan_start)))
> >                            return false;
> >                    else if (aarch64_insn_is_load_ex(le32_to_cpu(*scan_start)))
> >                            return true;
> > 
> > But I'm not sure yet if changing {load,store}_ex's MASK would affect the
> > above code.  Do you happen to know the context?
> 
> IIUC, this code prevents kprobe from interrupting the LL-SC loop constructed
> by LDXR/STXR pair, as the kprobe trap causes unexpected memory access that
> prevents the exclusive memory access loop from exiting.
>
> Since load-acquire/store-release instructions are not used to construct LL-SC
> loop, I think it is safe to exclude them from {load,store}_ex.

Ah, I see, thanks!  I'll extend {load,store}_ex's MASK to prevent
aarch64_insn_is_{load,store}_ex() from returning false-positives for
load-acquire/store-release.

Thanks,
Peilin Ye


