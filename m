Return-Path: <bpf+bounces-65864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891AB29BDF
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2840C1732DF
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC192FF15D;
	Mon, 18 Aug 2025 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKNwP8rC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A929B214
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505176; cv=none; b=fRQNv8LlV1Ja+jGtnUT9STWk6azKcg0xpyxTEQPhi4Iw6crF3VXoE5K6ql3snqvWINJQS6Tr11tpcnGcfQl5gHYh9Z2T3AnifT77RXedwRh5LQK3xWwwnymMqTUnrXlEa8G0N4jvi5dXw8ij9db8jevfiZznoWV9S5Nr7VVW/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505176; c=relaxed/simple;
	bh=rN/UTNEkHE3uBRZLBThrHpULRHST6ls2EaemSZgDm2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyt0f9bd+26Ja2WeN3zNZrYF8tkz72rH3D1YtWb7oTR2EkfjNbN7aRYI4lvjzXXUcPJa6oTZJIvK8RyvX0CgdHKPxa5tFxEJ/OXF/vMHAoCAb92TzNrmHDkzLPE0IROfSZRUlF2vnRz8UeiYHOaS3WfWzLjny9RGodvsilJb9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKNwP8rC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so30155635e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505172; x=1756109972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeEY3uW9vGqD0NjAylwhSwOYu+Sb02hS8tqOcGAgYnw=;
        b=nKNwP8rCBSWRN6pKqQ7qBhMKKSXGBmYPBVAOA8XEPCzuReAAawBriD8HnZySvURNOy
         p2LgSA3bLC8qlX4Um4pUW8C0vLDO29sd+9syIiv8Y0fDzGspHxDNy/u8LgStUiOYbF7N
         STDwH4v11owPt8FpOynbij3ANjAKD8+vkfK1Ha/u+xDc7kkrkFdhjqRRqcXC5oJhQeA3
         HrUN1Rc054HrhbvPjryTHBDLh9WT8WoVXXuyLTTr8eAIdlDpM3KjwSuznDcEYD/XVSv5
         nVMI/7KVGUmG2IpbBSz31v/2t3d2Vvx709PVgIK3L/hvvVrf9ahX/BYPXehdZnkZgzWz
         kgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505172; x=1756109972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeEY3uW9vGqD0NjAylwhSwOYu+Sb02hS8tqOcGAgYnw=;
        b=LAxMJbtTWdnrRx8bPoL7Wf2pm0jkH0E2zp+g/jud2yjdhCthU5mtRjxv53sClcOCLQ
         j25uUoQzjQTQl7QUFvwHNaPr2g5lsbW8fmlLk5HIt6ys+gAKn8ujU4Cq1dnUbjnqKihz
         Hziuj3/vI8c5IWXB1K7sRiAi041mR5T7vK2dcPROx/Gp8yAaj0ucva8en23pknqZML15
         1jFFaiO/RblbUlUbvPBvMhxOO1BBeWaj4VvUTXKsxy/nuX62t68y0+83yTfveDVqFc2N
         I/+Ij68Gn5/lI/Uvictc8OYOjE8OdMo8NkgZ9EC9RHz6Lcd0/JpxrcsrHvXdhZg1CEwZ
         BUmA==
X-Gm-Message-State: AOJu0YwETAyIa+0w7XUjkeqmWHPAt1Qn2rx8ER8tMtruZta1krr8bVRz
	tNEKkbBZdM9KBLlwsxH2bLVgmuvVNHLDLTZfGMd/1pMm8mgX/s/nKln+
X-Gm-Gg: ASbGncs9xseCMeRYo1bIL1nKl0FyOgj5wfUE3ljwj40OnEvPqC4jS089bg1Mc3rhx1d
	eu5a17ET/vtaePg+58N1Fu+UCXg/OazD/pAc6wu2/uznQBkHDrVmcsNcHkkwf+znb7ZeVsYWSeI
	repvZ/6s5CV5AKiTUnS7/VI61yLrsSPmYZ0NwFfXpTN9MsHIUB4wasV8/fADHYRMNpMw4U8c8dt
	JVK4U7u/b6AoMCqN9wm/moufERlFVy7sMPcHv3iahdVqVYRvPr9S7mYdmT7wJiN4AaVJKtrzGzs
	jhMP6hPJ6vYW0hot3JcmO07phcATrHkHGS3aCfByl82RVR+R0ZzTmNvJMrpk5vxxiMZZpIjL4lg
	u/fbbndTtlEEy9A4F9afNTJR3irVk+eVvOw==
X-Google-Smtp-Source: AGHT+IE4/Ywx353cazJs7pIfC+EI2xfVHZUjR2nORVtwe0LInZT9u8RV5DJbXw9M+U8k4EAA8VWZXA==
X-Received: by 2002:a05:600c:4ed0:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45a1b6bde0bmr122268245e9.12.1755505172119;
        Mon, 18 Aug 2025 01:19:32 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a25c13696sm104998905e9.25.2025.08.18.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:19:31 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:24:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with
 constants blinding
Message-ID: <aKLjLFSXImtu89rT@mail.gmail.com>
References: <20250816180631.952085-6-a.s.protopopov@gmail.com>
 <202508171315.5y3oPyC2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508171315.5y3oPyC2-lkp@intel.com>

On 25/08/17 01:50PM, kernel test robot wrote:
> Hi Anton,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-fix-the-return-value-of-push_stack/20250817-020411
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20250816180631.952085-6-a.s.protopopov%40gmail.com
> patch subject: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with constants blinding
> config: sparc-randconfig-001-20250817 (https://download.01.org/0day-ci/archive/20250817/202508171315.5y3oPyC2-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250817/202508171315.5y3oPyC2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508171315.5y3oPyC2-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    sparc64-linux-ld: kernel/bpf/core.o: in function `bpf_jit_blind_constants':
> >> core.c:(.text+0x8064): undefined reference to `bpf_insn_array_adjust'

This is because the bpf_insn_array_adjust() is enabled with CONFIG_BPF_SYSCALL.
Will add the corresponding check in v2.

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

