Return-Path: <bpf+bounces-65862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C7BB29B7A
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DE75E5C68
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073929B224;
	Mon, 18 Aug 2025 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlYOsViV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EE2C08AC
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503828; cv=none; b=koV6iDV92U3iiGeORaiG+YpKn7BP4RBFqnB9h/NCHuSEAuoAocdhG2D4JUjaFtuRXbepazRcUjSwTDloK++W+a8l6J2oBBhhbxmC5WMfgf+ltXheO6+n3ABo2ER+Ue2t9jeXqIskULNm69TjmdDPe9ItycqCwcWv2n4OOEP4ndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503828; c=relaxed/simple;
	bh=irkUYFM4/paMAk6Wy0dyId7dBz+H2TNcYXRcWrpe4Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KtfPogzuuJ1KfYTmUrbwIsRTZw1zDMXPyNc0m0KkFfZFpsfXmWVkOEG54N8nFvKdqo94RFECr1zlS18DsCWmvD8m3mSZSq4g/SHP7DW9fF746KClVxBpjuX4fAwmBNV8WDErMnOYJzCs8Md56OJRzddlXUVsTyFI303agisdm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wlYOsViV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so19022065e9.2
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755503825; x=1756108625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5JGOjRrEBDm9X/sEa4+YcCwfIvA42r2B08SfP6T1iQ=;
        b=wlYOsViV2ORNpBpHv2ONxb81HiaV6SCZ+eNjzZhLzMdLfxHmwHLX5DlEOQpUHRJHKP
         fEVYQG6oKaQSN6QfdbUxhUy+oYmCDdMrMTilHMIAKZcbhSblnDQy5mkpew0qvB0gZOjc
         pHd2feL91X17Ij7jAGr7gnpFd+Yqr/h1XjxU1m72j25IZ3bC8iOeLNCiqD5YTVKL24E7
         QRSQITKf0W4/oYs/iTnLRWicYJmeX7tvjUNeOu4M2wnUSn53Pr//lB5Vy8EucbAhg5ce
         HYXnYOKkGa+qYUAyIcFkT8AgNTSxA7lbUMANlwdoJNXrTdCsvzHVs2tMWC5Evj9XhOzY
         Pfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503825; x=1756108625;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5JGOjRrEBDm9X/sEa4+YcCwfIvA42r2B08SfP6T1iQ=;
        b=Q6jnpp1hV9Ap/Lkb7VR/WGnQ8fL2cZr7LYgjODT61h4mRkMfVWPqbjuq+2UOcocIeA
         93muL6J1c/bejGJhAxnr1+W8I0KOhSX3CSThV1vVR9mMEt+pozS89m7QcyrY9mD0FoNg
         aZddswPqdAdOVvbQ8KxNR7DAK2nc0kRP7DUHGQaAmP3Hiu3zQq4+zwMJeJ5xCfhO1r7Y
         km0kdXqzfrtFCMUaXQ9NNfj1LS0pkcMJ6XX8e8OR21+zigHEBomUVaoMOY4Fz40u3s8p
         D27fTOKhAeJDNcEL+CUQVa6JeSD6PZLZeqnJ9DZdSqofANFbyi+cK2YUCR+J3WpaPPEL
         cdKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXVku6NnjbYC8II+rE7ovC0JGNFTpiahiO9AqpvetgaP5vPWGd13gL8tnRhlS9eu5m0vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbgUH0Qq6IlOZeFlnx+a/pG5gic0eQaAUjCjHJURnCv3KYvnz
	SLojHwtoYz6kyRhbJWZxC7Dvy0igCer4d0Pn9Pd3rQjKFkUWzgrPJyf7HTLsxkZceOM=
X-Gm-Gg: ASbGnctQMEzDzwd8Hxfe7cfjOasosALd3ub2DRrxdqQtbKE+EmFylKg/S9gXjLVUink
	YuHXJJuK37xqOlv4QXNjthVn94+aXh9xt2qShZW73rfXseXljk0zXCQDGeVf5JiJBZuitoxPwBP
	yiXIKd/Fm14AjicbXE5tK51kg9YwGZ2rbARmXfY8H4VfiTi06FS7/8TRg+Y1CePVAAO7a2GYWJe
	oD8Q4mcbnWaUSYPxufuLzx7re+aKVPUDOgZq/SKc6egw2SwbJsU3apFzB5u8Ygp2rpyE4p3RIbq
	tnrtzMVS3K8qbxBzWMgq+E7cdKcEuPeSVUe0Q5AOtakoVY9okCtWPT2am9NcA8pCyAeSICa7iaa
	Rgt3KpqoakTA4OUgxwhJNSVJZj5U=
X-Google-Smtp-Source: AGHT+IHrJBk4bWXGj1nwyV4v635UJ8iUxXiG9MG7O5UHiJQO4NEljj+USKB+JTzmq9N/S2OxSSJhng==
X-Received: by 2002:a05:600c:19d2:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-45a218582f8mr64812345e9.28.1755503825202;
        Mon, 18 Aug 2025 00:57:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bc5aba02e2sm9484162f8f.3.2025.08.18.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:57:04 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:57:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anton Protopopov <a.s.protopopov@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
Message-ID: <202508180805.aUCPtTuQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816180631.952085-9-a.s.protopopov@gmail.com>

Hi Anton,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-fix-the-return-value-of-push_stack/20250817-020411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250816180631.952085-9-a.s.protopopov%40gmail.com
patch subject: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect jumps
config: x86_64-randconfig-161-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180805.aUCPtTuQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508180805.aUCPtTuQ-lkp@intel.com/

smatch warnings:
kernel/bpf/verifier.c:25013 compute_scc() warn: unsigned 'succ_cnt' is never less than zero.

vim +/w +25013 kernel/bpf/verifier.c
 24891  static int compute_scc(struct bpf_verifier_env *env)
 24892  {
 24893          const u32 NOT_ON_STACK = U32_MAX;
 24894  
 24895          struct bpf_insn_aux_data *aux = env->insn_aux_data;
 24896          const u32 insn_cnt = env->prog->len;
 24897          int stack_sz, dfs_sz, err = 0;
 24898          u32 *stack, *pre, *low, *dfs;
 24899          u32 succ_cnt, i, j, t, w;
                ^^^^^^^^^^^^

 24900          u32 next_preorder_num;
 24901          u32 next_scc_id;
 24902          bool assign_scc;
 24903  
 24904          next_preorder_num = 1;
 24905          next_scc_id = 1;
 24906          /*

[ snip ]

 25008                                  next_preorder_num++;
 25009                                  stack[stack_sz++] = w;
 25010                          }
 25011                          /* Visit 'w' successors */
 25012                          succ_cnt = insn_successors(env, env->prog, w, &succ);
 25013                          if (succ_cnt < 0) {
                                    ^^^^^^^^^^^^
unsigned can't be negative.

 25014                                  err = succ_cnt;
 25015                                  goto exit;
 25016  
 25017                          }
 25018                          for (j = 0; j < succ_cnt; ++j) {
 25019                                  if (pre[succ[j]]) {
 25020                                          low[w] = min(low[w], low[succ[j]]);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


