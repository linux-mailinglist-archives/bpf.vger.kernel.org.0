Return-Path: <bpf+bounces-27180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882C8AA578
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F091F21F0D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B931DA23;
	Thu, 18 Apr 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE648K1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC41EA6E
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479828; cv=none; b=aNXIPniv7ii001yMeI5ZgGe4PYQH4nF9uaqZgWlIRACJD8H0Zj+1q8WUOUOwr3mX0MfwKcl3NzEA7SJwAkLTXUQB17qaVJgrSaEP8fcRpokIyWyBwqyshjtpzZQvBUq7XSOasrQuigETOSochcmJ2JhPXoXtpB9VEJ+dy++Wm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479828; c=relaxed/simple;
	bh=CtNQYb8R0UxCJF905sAsKe3V79m/5pBSZ/sNENZhPoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWQMyaXGZBQzdy7RtXp+eMg30VwIhWj/UA3IJQ9qIDG0znRmFhF1qXLB+t2OZIuQDg49uqNVz3J0vomRsgRUKrvCK2aBw6ybkmHEKhHPWtYsJTA50zA4i4NdJ3WBordrVDoS2EPchk9I1X8cpTNKU6JBGHnqp7fJwmvI6avjTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE648K1M; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e86d56b3bcso13384785ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713479826; x=1714084626; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXipzStzvj9k7qXAwSKkhL65CDfUKsC08w/yPAuAqHM=;
        b=XE648K1MLJKRcbnsOYfPFG9fWSKscQwx8pViQUxKiN7kdBwEJcOiCNLxdqBX9x4QYH
         IoCDAY4ar+lRod4TTdQvPOF/a3WFiPSc2qjeHfV1Y1MFqYDd9XEDzcdiaLSucX597zho
         t/yUslGAp0j5GK9IdUgmKZGQxB7aONPcMxtHqR+07n5N3Mp0K71iWZLpn6Kcw/5FQL5U
         L72oWLcEo8ZAw04dn0fQ8CJ1vFnLPgOTovDXngQf3vh1YCRfLOdCcRN5WEf3EozG48Fy
         zXE27qjjXOPxK/gmKSATdZjzxwDSWAVdjVqOnai+y/hsy1I+1N0xQFg9/MzAhdcb8ToI
         uQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713479826; x=1714084626;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXipzStzvj9k7qXAwSKkhL65CDfUKsC08w/yPAuAqHM=;
        b=Pr+AdPOOX6tMaIhNiNDi2YonV4VQFjxT1WHJ2oweCvLQrNloHhgb3ekThB4bF4IEgr
         6kfcJAZBtXijfUurMcSV6uzCDXoh6z70ylPP8bTK/gPI/zOFuhmXLujnDxeurVF0BUAR
         Uy+6M9FIFg5vkSRPX7qqMCkVqrhbOHrEGdoCblhwMzsagbIwxYortmsoosIdgXlfHMkR
         yUbCrXUx0lJFxbLHkH/fu8no9oKv2++y4pEpuFL6AIOtYBliaeo6bClYfQHzY77uTCPa
         n7c1EQSaTT5S5+EuayIeiailiigzn3WR2IoGbebAxvnLxStWPu2ArBVowGgF091BTGAV
         CHOA==
X-Forwarded-Encrypted: i=1; AJvYcCX5YsyChK5/xuIqJ28rtxDJ+QYchgBiq27Dh+3KRzeXKGZG0NJVElMaHdVzHTaYiZgX+XLI1wR26xmMq57mMK4SnJzU
X-Gm-Message-State: AOJu0YxkWGdGYzkKJDrFdRCUejpGKWqzjxZlSs64t/th4rRNL33mqu9H
	wk1tupv/zce33MitYTGn95v0hAKVgwFB4wp36ttzSQwgOUUuleC3B0kCJ33AO1s=
X-Google-Smtp-Source: AGHT+IG+nG98FGLzEkuRl5ntqhLLEDPTJuKrQCbH3fPMpRKNitJIBUNjznOXHyWLnBtWRcctxiKvAg==
X-Received: by 2002:a17:902:bb98:b0:1e3:f6dd:b04b with SMTP id m24-20020a170902bb9800b001e3f6ddb04bmr455962pls.26.1713479826445;
        Thu, 18 Apr 2024 15:37:06 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:ad05:9ec6:fc65:cf63? ([2604:3d08:9880:5900:ad05:9ec6:fc65:cf63])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001e27c404922sm2038316pla.130.2024.04.18.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 15:37:06 -0700 (PDT)
Message-ID: <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Thu, 18 Apr 2024 15:37:05 -0700
In-Reply-To: <20240417122341.331524-2-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-2-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
[...]

> @@ -13406,53 +13490,19 @@ static int adjust_scalar_min_max_vals(struct bp=
f_verifier_env *env,

[...]

> -	if (!src_known &&
> -	    opcode !=3D BPF_ADD && opcode !=3D BPF_SUB && opcode !=3D BPF_AND) =
{
> +	int is_safe =3D is_safe_to_compute_dst_reg_range(insn, src_reg);
> +	switch (is_safe) {
> +	case UNCOMPUTABLE_RANGE:
>  		__mark_reg_unknown(env, dst_reg);
>  		return 0;
> +	case UNDEFINED_BEHAVIOUR:
> +		mark_reg_unknown(env, regs, insn->dst_reg);
> +		return 0;
> +	default:
> +		break;
>  	}

Nit: I know that the division between __mark_reg_unknown() and
mark_reg_unknown() was asked for directly, but tbh I don't think that
it adds any value here, here is how mark_reg_unknown() is implemented:

static void mark_reg_unknown(struct bpf_verifier_env *env,
			     struct bpf_reg_state *regs, u32 regno)
{
	if (WARN_ON(regno >=3D MAX_BPF_REG)) {
		... mark all regs not init ...
		return;
    }
	__mark_reg_unknown(env, regs + regno);
}

The 'regno >=3D MAX_BPF_REG' does not apply here, because
adjust_scalar_min_max_vals() is only called from the following stack:
- check_alu_op
  - adjust_reg_min_max_vals
    - adjust_scalar_min_max_vals

The check_alu_op() does check_reg_arg() which verifies that both src
and dst register numbers are within bounds.

I suggest to replace the enum with as boolean value.
Miranda, Yonhong, what do you think?

[...]

