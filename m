Return-Path: <bpf+bounces-50098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A9A227CA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BD11886EC6
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3512C499;
	Thu, 30 Jan 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZBPADa/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DC374CB
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206620; cv=none; b=HMMGLZ99KPakV+M9aiysknuTEPUmHyesjHyBcAU/cmISnx5Z6v9Xa0nzf2owVGziO8clAuSWOsG6dJ66pm1uc7myY9GVyRbVY1UhSRewCRDN7F++zeVWAp6HeFuO1FShrJhlTusC/v8C/r58sLbrRx4PFQ3Wh8WsPcDP6xsn3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206620; c=relaxed/simple;
	bh=jq/WuP0FzAKKslGEtfWEkcSJQ5q1vzVdSJ1/IMOitTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGrSpu7dRYCYu5MDAI6zdcPi8EkPySR/VkdnarY1LgtSs+EOkWG2Zy29uqj590bENKigR8jaTLKKp0ZkdY6g2uiwWR2CPXCXTijlN3HcrbW1T4LGszX7RLhjwApRarhOja29LCSAaVGC7rNG7r57fecnEnrI6R6e9Obcj3HWX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZBPADa/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f6ca9a81so38525ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 19:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738206618; x=1738811418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iozZcyUUIkHDUlZTrg5vhL4fOr44L6T33XHkD2MasV4=;
        b=1ZBPADa/hl/9NCYyMdeQPgo1LANPTUdjtMLdCEWmcD20u7QTl13Bc+bCj28ZWqTTVa
         udgSsB0TZxPx/AVSRpa79McOvN3T3+Q1jCxMK5qEpZzlm1YyNa9/AzLuQx4CXWJP0VYi
         eeqKDmaznhptTOsGlNbEYTUPK0q4iLOuVsusUe2xjIr+ZEJFGf8XxD2gdpHij+Kp9t9j
         HejGJqVq+aughbwjXQ+2Y9xN0K+wZgFnx7b51KfM/IdaCbaoXDeCxJ+gF2QZHHl9FNJZ
         y1/VU9rLdn4KCvRBdNwVA1cUYNAohxVjzHh7NJi01rFc8nlSuapH/++r3OCDkd7m0LN8
         godQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738206618; x=1738811418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iozZcyUUIkHDUlZTrg5vhL4fOr44L6T33XHkD2MasV4=;
        b=MiHMhJkI5AB6JGPdQovYx7pF2Uh3lChmPULVrFFS2idHmLZkqUcE/dZlggWC2Wgsyj
         ZtmCAfSQhCY17G3D/vI+v8+AFDlwTRGwVbgP/pjCH9K6Af9euavNanhoBOm7aQJMLkP+
         Oo8/CH39LSCmMo1GjM4vQECwW6VfyDUcFTd/DxNYninZ8XauWXzEGYFBUptnhBHca5Oq
         git8DkP5/Q43kWEnf256G4X2Zl2Qk1IvkYrZ6QdnyfONDPxf6JLxKXC40sxk3E3fAEXR
         b06t1+h/hRalncPNrF1yCRlifA8otKGuvMvyFvGRtdSlOOJDN+i2bXeuM9ENi8p2CuNl
         OzWg==
X-Gm-Message-State: AOJu0YyM4MC8d92n+g0PaSU3yK1wgOf2H6tsqjUSNREIsmGVIk07I8fz
	mK4NxyW2ASwwqf8Qm04l8tVhKgKiNPVZ3myStyS79H4Yt7kLarc9l8VE6m/n5w==
X-Gm-Gg: ASbGncu/Jq20zXCviqYV6sZAxCpJytX1qdtcvXJGEA3RM6Tb3gipUpbNGM6XDEcSXKR
	l+LVW5S8yALxoBM1gufQumtsSL1CW9Z/SV8xVGfvr+WYIxgmUnrE1WP0W7rHmUAdHPsS8FeHxNt
	H/xPkbYeZbh2AECjLo/huFQ7MVQZex6ABq1wqDcxM1TnSCDq5akBfSn6JXfgRzdi/ArMY8ghSfM
	7kOXxGrhV/yt6tdHvwauM3EEXMlOJuzJoeo5OBXN9SjdIpI5pzVcFb5k5qSDu+PMMcrrttiwnSB
	bxHTUqn+mJ2s+Yx1qW8OZNRPLMUN1LtawhIJnRkyyuG0lAWTg/c=
X-Google-Smtp-Source: AGHT+IEEKyHbZCP0iiK15ABPuaXmbOXW1jxN8hiCr6k8KYnVexFhjDvy8HwRqZberwcgcNwTXgzgng==
X-Received: by 2002:a17:902:aa09:b0:216:21cb:2e06 with SMTP id d9443c01a7336-21de36959b5mr855465ad.19.1738206617674;
        Wed, 29 Jan 2025 19:10:17 -0800 (PST)
Received: from google.com (55.131.16.34.bc.googleusercontent.com. [34.16.131.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce51dsm263323b3a.134.2025.01.29.19.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 19:10:17 -0800 (PST)
Date: Thu, 30 Jan 2025 03:10:13 +0000
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
Message-ID: <Z5rtlTv2pz9H-smw@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
 <b7de0135f7dcca0485ce9dc853d6ca812c30244b.camel@gmail.com>
 <Z5qmBaGE4a7NtaFU@google.com>
 <da01f44bb1f3463515574796c3ac139bbbf7b4dc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da01f44bb1f3463515574796c3ac139bbbf7b4dc.camel@gmail.com>

On Wed, Jan 29, 2025 at 02:42:41PM -0800, Eduard Zingerman wrote:
> On Wed, 2025-01-29 at 22:04 +0000, Peilin Ye wrote:
> > Thanks a lot for that; would you mind sharing a bit more on how you
> > reasoned about it (i.e., why is it OK to save_aux_ptr_type()
> > unconditionally) ?
> 
> Well, save_aux_ptr_type() does two things:
> - if there is no env->insn_aux_data[env->insn_idx].ptr_type associated
>   with the instruction it saves one;
> - if there is .ptr_type, it checks if a new one is compatible and
>   errors out if it's not.
> 
> The .ptr_type is used in convert_ctx_accesses() to rewrite access
> instruction (STX/LDX, atomic or not) in a way specific to pointer
> type.
> 
> So, doing save_aux_ptr_type() conditionally is already sketchy,
> as there is a risk to miss if some instruction is used in a context
> where pointer type requires different rewrites.
> 
> convert_ctx_accesses() rewrites instruction for pointer following
> types:
> - PTR_TO_CTX
> - PTR_TO_SOCKET
> - PTR_TO_SOCK_COMMON
> - PTR_TO_TCP_SOCK
> - PTR_TO_XDP_SOCK
> - PTR_TO_BTF_ID
> - PTR_TO_ARENA
> 
> atomic_ptr_type_ok() allows the following pointer types:
> - CONST_PTR_TO_MAP
> - PTR_TO_MAP_VALUE
> - PTR_TO_MAP_KEY
> - PTR_TO_STACK
> - PTR_TO_BTF_ID
> - PTR_TO_MEM
> - PTR_TO_ARENA
> - PTR_TO_BUF
> - PTR_TO_FUNC
> - CONST_PTR_TO_DYNPTR
> 
> One has to check rewrites applied by convert_ctx_accesses() to atomic
> instructions to reason about correctness of the conditional
> save_aux_ptr_type() call.
>
> If is_arena_reg() guard is removed from save_aux_ptr_type() we risk to
> reject programs that do atomic load/store where same instruction is
> used to modify a pointer that can be either of the above types.
> I speculate that this is not the problem, as do_check() processing for
> BPF_STX/BPF_LDX already calls save_aux_ptr_type() unconditionally.

I see, thanks for the explanation!

Peilin Ye


