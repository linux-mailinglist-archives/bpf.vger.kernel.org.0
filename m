Return-Path: <bpf+bounces-50012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2BA21611
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BE83A8AA2
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42518787F;
	Wed, 29 Jan 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLjjDHYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB8450FE;
	Wed, 29 Jan 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114227; cv=none; b=EJ99gK9qwsEh/F9cbIdv9F41OMyyZMAheR+CanQOtp4gBAMctm1BMcabL1AW0WBB8UivtY0Awqk7HcO3gLQ6jdGHLTEyXXEvqkr9XHXteez+njORbhon5A2E9qRySTNg5W9Qaw+dCtVNp5t2RtylkTzXlk8S/nM+p1tpebKhEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114227; c=relaxed/simple;
	bh=ZORdwnhaDZwjX18zxJXbz3HQfp28aRZ+LGjI/nzjt4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwIGRGZPVRGsq9QksgbyT2ifxhP4ZxHoaukmyMZouE/Ogg46O7nrZSit5EXNI7jNMHN4s5mxD9UgPvTqQZkFSDYQGtF/BB6MjTozZ1bls0S7zSYMgT6IBkeXa81wyZqW6N4NixWSoDQMdi6wIFmXCT+RNSHK53oJpYqF7myaDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLjjDHYp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so103347715ad.2;
        Tue, 28 Jan 2025 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738114225; x=1738719025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+YUGdY5jWBgxe0FsZCkWW45MEm3XX8PLaV8ZSxnL4E=;
        b=lLjjDHYpjCw8PTiUb/rrbG7oUCmOpn6UQNtORFQQizfXzT4tXC1vMWPiBfMueWLffl
         KaoFa6rSLWhQVvFAG68RoCf7monzikurB4grCcBgj1iwLgcI7/SfaF/Uckgw91dKrlCV
         QKBAAbGz5EQIlQzA3Kd+ZmI2nCHEe9HXzB3PwXnfbGLj3yb/LsHvuj1/nP8ZPOqcaVWW
         5WPN476z7LOD2BjBbZEceWD7Rq0TmjGXPFTy0F+S6wRCxdyzJleHtFTku64ks1DawC8i
         LgKTpo2kjSGHzbnja34CE+VzzzfsaF4OBEOO8NaVZ3IlXOPL4TsJiO4LDwu0cLQsRmtb
         Bmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738114225; x=1738719025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+YUGdY5jWBgxe0FsZCkWW45MEm3XX8PLaV8ZSxnL4E=;
        b=RMO1hCCox9+L43WJo/BpWYfY0YZreKSJtmfZH6Rv7y2rfqu5Yghb7H4/tVCozKtvRm
         1XacYjwIckH0OLHaxQJ/BTpKeHBoL+LuGLRo2BZ9oSasKUII04aHj8+m/rYkmyU5Fb5u
         wLBnkk3dRm94RBVxit+IV4AKRAzDciQbdaDd7Dv0IY0h1NSyzdhAaxMnbvpwfP/HBzFz
         oRBb1A9WZK7/PBI6f+17WroKTHpSP6Wbf2V1JOwjSkTnMaC+/posOHC/0kVf67Sw9gfe
         R8JN1q9/y7AZjKNGjmQaPA+HOP9UlQrwHU3BSITjJWiJj9cc1HJMfJqaaVPx5LcJYeTX
         LaHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+iuFtzjQBCvRs/riMOirr1vomrl0Em9UVWvu0GltgXoQ2Cq+WB2a9mZZdSgPKEwS6oHc=@vger.kernel.org, AJvYcCXp9BjMdfDw5UdiKAfm/q0of77nIyAjXUpxz97d/YrMHXwlJEEL+QTblCdUnbNoFFTlDbfTGIIJKg+FwAbD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bAjhCsvhzDhxxf3Z50NIhC++RfB9lkgL/Qgsqz3vNa3wl/9B
	P8kGQszH6SZKoSdv7TJZejR2TdBree32P0Rm86GA3LRqfaXsW1Nk
X-Gm-Gg: ASbGncsQxyt4b1ZclHY99aKQC21kE55ZqbMKGc3ySstgPz9p2tvRjG1TBnlomFz5dVB
	g8ngJm/HodlreWw58/8obwSpgqifRMIyXsDfrBYdk9mp1OIDVabpBJ/ApEQu/tCkwpMaGe8Uoww
	UuNnATGaqFLNx49Kw9qw0Jrwler/weAWdFzXhhP6kdKJSxU6NSSGZN/T+bSCqnDHLjmTRUA4EIb
	glMQAHVMmhQIkrJCgFlWXpa7/D7uCW0N+LxBAG+eJo/tdD5AApkxHBalAUQZtbPT9G4q+8DD/P9
	3tBxO6pNeSSd
X-Google-Smtp-Source: AGHT+IGnUafWCWy5Rdt7v6HiJycDshOAZRfUCy0joNOLt5a4ewiL6UscKqQLOC6qUSbz771m3JKYDg==
X-Received: by 2002:a17:902:d545:b0:216:3b31:56c2 with SMTP id d9443c01a7336-21dd7e0ac70mr24649555ad.53.1738114225184;
        Tue, 28 Jan 2025 17:30:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c983sm89368105ad.7.2025.01.28.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 17:30:24 -0800 (PST)
Message-ID: <f5b72fa9460e4eda6e6b36756db855bfec67744a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Jan 2025 17:30:19 -0800
In-Reply-To: <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
	 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-25 at 02:18 +0000, Peilin Ye wrote:

[...]

> +static int check_atomic_store(struct bpf_verifier_env *env, int insn_idx=
,
> +			      struct bpf_insn *insn)
> +{
> +	int err;
> +
> +	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	if (is_pointer_value(env, insn->src_reg)) {
> +		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
> +		return -EACCES;
> +	}

Nit: this check is done by check_mem_access(), albeit only for
     PTR_TO_MEM, I think it's better to be consistent with
     what happens for regular stores and avoid this check here.

> +
> +	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
> +		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
> +			insn->dst_reg,
> +			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
> +		return -EACCES;
> +	}
> +
> +	if (is_arena_reg(env, insn->dst_reg)) {
> +		err =3D save_aux_ptr_type(env, PTR_TO_ARENA, false);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Check whether we can write into the memory. */
> +	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
> +			       true, false);
> +	if (err)
> +		return err;
> +	return 0;
> +}

[...]


