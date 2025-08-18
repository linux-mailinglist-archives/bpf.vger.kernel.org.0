Return-Path: <bpf+bounces-65863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42581B29BE1
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1793AA4A2
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70672FE06E;
	Mon, 18 Aug 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcXjcSrI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE5283FC4
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505067; cv=none; b=g3O8UWL+Agsd+Dws6CiZeBwuA4cBgQe5GaKv8hW2fR4KnIO7xQuCl7VWzQ2RL1R6EfNUU2U+aIM4Px6qmbJQtaMrZhn7Ganwrgt7NKakUcmX1aEoDeHd1KthofUs71qbsivCdEq+alvvj2rReFF8t39X3KBqNteEXE6FAK+uOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505067; c=relaxed/simple;
	bh=9JGcY+0KyGyjTEiI5T8vpORcywSVro7t9EHHHh/kPzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9qCN36+b2+clih28MnAP5Zayxyic4PfTIknIfI6brJGbiPz8yBDUEM3kirCMF1tEYLFYcZrMr7k+KCUwkEft2Z4IGiEQyh75IP5GEJzjcWRSPBOKmES7Sl3qUIhQoNfAAvLbxLWUYMo2eL7hclKcGVMcQTMYEuStak7xazeA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcXjcSrI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so18215615e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505064; x=1756109864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ekE4nPja3ASUDhMh9k5/LZ4ut0A0tgRnQwCXeXPp50=;
        b=XcXjcSrIRpEUXy7VUr36bWNHWl9a0WXauJNGuEjTw6ym4NXv2riXc5+DjuAtU2cmW8
         rDfkHvEMhcI1mcXEytg/veYYCfNNzyc+1nupbAfnEFavLxDv0Jg9hBkKebArltYDGgdT
         LUDYIROE/HTnNH+MCHSGRORGm3IwrART3jHfeZ57XheZU4dNGdePZy1SBTs//j06x1FR
         L2o6LYGcD8T9obhpa+sjlLTMOLigIXY/Wd7sbwr6/ulqDaJy6e1a79IfSJsnnQlQV8GI
         moaqzJWkugLNByIobFvFRwNro7ZQsTu2C8X4G9CrXJraNlsV5vtMOmXFtn71tEMPUe5/
         yYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505064; x=1756109864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ekE4nPja3ASUDhMh9k5/LZ4ut0A0tgRnQwCXeXPp50=;
        b=UemZrGgWg6jV5z4/0BC/UGEnlOuLEntx7j5oaj1+L1UOlPYgwnKmPYkhOcf5jgCON5
         wUj4CGPIkua5GaYCXfEW0CZR06VWcB0EOqDgYQgKALy4HewAxKxZarlrQuOohV4vnWGu
         UKxCSPer+R6yprGIYzaFCumFx26II2TOMPVPMZAnUMnT/vOYXxZGgiGKBxdJAX5i32ai
         ue1SRqggFyMGUL5vT3RI2wJ0sImaHKKvAtBA3sNeBbbaYTn+4gDYJaOOY8+vTkTmP/Gc
         B7Wzu84a5CZY01jayCG585xGTnvYqPOLukfRvFZkMJWDkWVARJfv2oaCQLsUhNxqw1dN
         DXvw==
X-Forwarded-Encrypted: i=1; AJvYcCXrZX8jAQFfnZIz+1YwkoBAXu7o/DYP6eBq+CZMPVRQX0lQh9ciM0GqlmjkQAvvC19HPg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+tfAwIYOEWkoFDXq5mElf/GLElkPQQfKsITmUr8umonQNbp7
	pVNnp18E3zD/s68+goEdHIiECqh9gaXbbpnERrcO6lV0xEJGb+ynaPcI
X-Gm-Gg: ASbGnctV/gBIufsLYM5v9Ugwczgs42Z9/IVsyQE+yA/jW4p13mnIB99dGM0GLnC4lo0
	S5rblaArLm4daBOAIwn5yi8sGRoCmq8D6ki8r9hs+oxW7z+zh+T/kbuby8XKTPKp48N/VTpauk9
	CW6ADlbkpk586twHzP0fq8XyRrm0tkKfIZNNThajrLst3ddT9eLdNaMthrjcvOanuG1GPRZXXn6
	poypaEN9+1QlVzefzM/W+T839feo4TdGtWcBNDZ7sulD8x2/TfdzjH7Y1SIru+Q0X6Ec5E+bU/g
	51yohTM56AQJ31Yyy8OiWdcBGGcRvN8owYD5K7oxhR+ts/vqhcMYDnEL9G7wzMmzaR2QkG1x+I+
	hCHyTe1FVqM0ItSDvDZGIlS2StgzU99VgseEHim7s8Q+O
X-Google-Smtp-Source: AGHT+IHdkOU/yckvYyJTLfiij8WfT1dmp/CIFFww4DkTU6TlWAp7UgvkJLt3ORbMny7QTjBU+t6sFA==
X-Received: by 2002:a05:600c:5253:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45a26784347mr57370025e9.18.1755505063765;
        Mon, 18 Aug 2025 01:17:43 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2221136dsm123154315e9.5.2025.08.18.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:17:43 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:22:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
Message-ID: <aKLiwL5awqPcngf8@mail.gmail.com>
References: <20250816180631.952085-9-a.s.protopopov@gmail.com>
 <202508180805.aUCPtTuQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508180805.aUCPtTuQ-lkp@intel.com>

On 25/08/18 10:57AM, Dan Carpenter wrote:
> Hi Anton,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-fix-the-return-value-of-push_stack/20250817-020411
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20250816180631.952085-9-a.s.protopopov%40gmail.com
> patch subject: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect jumps
> config: x86_64-randconfig-161-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180805.aUCPtTuQ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508180805.aUCPtTuQ-lkp@intel.com/
> 
> smatch warnings:
> kernel/bpf/verifier.c:25013 compute_scc() warn: unsigned 'succ_cnt' is never less than zero.
> 
> vim +/w +25013 kernel/bpf/verifier.c
>  24891  static int compute_scc(struct bpf_verifier_env *env)
>  24892  {
>  24893          const u32 NOT_ON_STACK = U32_MAX;
>  24894  
>  24895          struct bpf_insn_aux_data *aux = env->insn_aux_data;
>  24896          const u32 insn_cnt = env->prog->len;
>  24897          int stack_sz, dfs_sz, err = 0;
>  24898          u32 *stack, *pre, *low, *dfs;
>  24899          u32 succ_cnt, i, j, t, w;
>                 ^^^^^^^^^^^^
> 
>  24900          u32 next_preorder_num;
>  24901          u32 next_scc_id;
>  24902          bool assign_scc;
>  24903  
>  24904          next_preorder_num = 1;
>  24905          next_scc_id = 1;
>  24906          /*
> 
> [ snip ]
> 
>  25008                                  next_preorder_num++;
>  25009                                  stack[stack_sz++] = w;
>  25010                          }
>  25011                          /* Visit 'w' successors */
>  25012                          succ_cnt = insn_successors(env, env->prog, w, &succ);
>  25013                          if (succ_cnt < 0) {
>                                     ^^^^^^^^^^^^
> unsigned can't be negative.

Thanks! Fixed, will squash into v2.

>  25014                                  err = succ_cnt;
>  25015                                  goto exit;
>  25016  
>  25017                          }
>  25018                          for (j = 0; j < succ_cnt; ++j) {
>  25019                                  if (pre[succ[j]]) {
>  25020                                          low[w] = min(low[w], low[succ[j]]);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

