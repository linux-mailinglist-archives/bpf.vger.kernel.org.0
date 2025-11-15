Return-Path: <bpf+bounces-74600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056EAC5FBEB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D935FFED
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F730156F45;
	Sat, 15 Nov 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixd1urL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09940855
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763166570; cv=none; b=AVy28ej3elGuPNzIZvcLGUW3FrnXVdCLyAh6XdxI4PANme0DZjcK1xXoLrOCCDySiq/jRnaLYZ7Cj/CtT1ManZemzzyTvDFSGPlvX2dZRPFOcKV3kj7Rprf7s7I8WIVtRvImPMre2p9zrNmzBSfNLWGBkg1igXOgGvbgEp828nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763166570; c=relaxed/simple;
	bh=dbv7g4Ma0QXXFpXAOUjUVoiLQlUwzjpTSOT5z3HX3VY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjnWUwpSgcbmq5SWeBDGl9NxwqucF+XE+XRtGRn91Sx3X+dYEMoqT/ZqQynRuj4wSlSMzJQPHD4RN+69UYlrt6VpxwMRQH5irtjPqX3GeecQwDh0eX6Zur4+ZVV36bN7RTT/bNv5S/r4zRi5LDXp7xr7UYEnPaOaCtoWEQPVHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixd1urL/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ba92341f83so1691503b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 16:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763166568; x=1763771368; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBVOjiq9Z4VyQDGQgJlIYdfiFGyuYuC+brOdYg9wT64=;
        b=ixd1urL/1Du8yTUwNL9cyeC3Dr4Jxv8XiqElHEdDk7rXM3omuwtMrEXG5FDotEYNBU
         8yBWU5zE7DTctaPoRJ2Bc5QATrbkJk7IzwELrrG8sMUqT1ZXv6qBP1KyuvNXhIIyVc0o
         TrY7BbAqDK79wihIqDJAAkx5sTMFoZy2boA118J5a1fX4bLPBiPG+bHc2L4bhK72XEs1
         /bmA73XXbYzL/xO0mMX/kDPjP/wER39p/iLUp0xiamhhuIhvSDDuZkzleQj+A2cLZmuI
         m4XMOhuwgfpcjJ0WZ9lSH8LRovJNBBiqHqimCFZr8v4Z7wFa5N+jnP+zbITtlmeQ/jZH
         wifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763166568; x=1763771368;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBVOjiq9Z4VyQDGQgJlIYdfiFGyuYuC+brOdYg9wT64=;
        b=mMPdKbbGdL4wJ45pz4FimhEVkpHrTILYa3P80WbbyL83UH1ae3vx74tdDV4gX09MIG
         zU65eP8U6HPMTAzJBU6EXB/lBUj0fPNJHbvQrkMKpQJ1jGLbBYF0lWmzeiGoJyebcrnw
         EHBRb2CR/sUku4Eno47doGjQwTyxDhkjX7uFLXCXvDWGdg49Ib7LcscLvYA9jle/ptgY
         2ZKhqqesMdRqx8iTnaVKLGzSB+Dhz9JD7jjyxeNCl2NNNX6PmLeJs2C97SS/gLNbZVUE
         WV2dI4C3DB72nXSUyaatsUkbeN2rYRegVpuq86SAKe5rK3FNBvQsNbGc4hf3mTNHcits
         0XBw==
X-Forwarded-Encrypted: i=1; AJvYcCWOWPqguSnZZaGC3nSYiPG3THl16lUyd3m3V/OfOpvZdfLw7H4yYpClU9CvzEmfj2VnPTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlD4FMB1ZPy8/ApsW67HDRX/KFLKVz6BZRuIve1DWHHnX8qzER
	wNJbKzzpf0B7tXTSE668ZNaHZfSoIjONmCb1IGSdIcCCs+/C9AFuU0P3
X-Gm-Gg: ASbGncsPj6Y/fJVAVtO4Zje6exH7v055wofENb3xghb/IPgICcoXSwm1y4Dui8HrF4U
	MJKQb0OxIxzv+5IeEzwI10sbdigj13bHuWXwVMFJHL/KJ7zovuv4Lst7mHXnewKH7crw6iI7xub
	SMJIms4ihpoy421BlbV6z3xGWyVzfvT501ji6vkNu8QlgHWRoVbNwXeA81efjDOWZcWMvhdbq9w
	3dgaCnkHzaxMbtVZ0Zob+S08V8aeF6UPndOBE8OTWdzv6TxEPDoOJNhn0k395yrCJo9ebjxs5Y2
	1vz3S2JM76Mgh92J4/FJP9G7OPxmW/yfH5WeSoUpAMgOMNROyV16nAJ8M6OKkZ52F+G+AHV14xl
	+KYfvDa6bZe/DQ2dHEDjPRz1ON0PFz7R2prsADdJYoZSJCYMa+JkHMR5zmXin0oRgbW0TzeRKkQ
	==
X-Google-Smtp-Source: AGHT+IFS5jStsHYv+J9xekC62keLB6OAQElAsgdqjD2MUwFaaN+dRU9/gHSzeblhzshuvZKJwufMvw==
X-Received: by 2002:a05:6a20:a109:b0:34f:c83b:b3f6 with SMTP id adf61e73a8af0-35ba2598aebmr6670175637.43.1763166568266;
        Fri, 14 Nov 2025 16:29:28 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c22c5fsm6352723b3a.67.2025.11.14.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 16:29:27 -0800 (PST)
Message-ID: <7843b2f823e180f2641585f36dbef5f6a00766ff.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Fri, 14 Nov 2025 16:29:25 -0800
In-Reply-To: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:

[...]

> +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
> +			      struct bpf_reg_state *dst_reg)
> +{
> +	struct bpf_verifier_state *branch;
> +	struct bpf_reg_state *regs;
> +	bool alu32;
> +
> +	if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0)
> +		alu32 =3D false;
> +	else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_value =3D=
=3D 0)
> +		alu32 =3D true;
> +	else
> +		return 0;
> +
> +	branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +
> +	regs =3D branch->frame[branch->curframe]->regs;
> +	__mark_reg_known(&regs[insn->dst_reg], 0);

I was unable to prepare a working example for this, but consider the
following case:
- arsh operation is not 31 or 63,
- but it so happens that 32-bit range is [-1,0], while upper 4 bytes
  range is not.

Is it possible to get to such arrangement after arsh?
If it is, it looks like 0 case should follow same logic as -1 case and
conditionally do either __mark_reg32_known() or __mark_reg_known(),
wdyt?

> +	if (alu32)
> +		__mark_reg32_known(dst_reg, -1ull);
> +	else
> +		__mark_reg_known(dst_reg, -1ull);
> +	return 0;
> +}
> +

[...]

