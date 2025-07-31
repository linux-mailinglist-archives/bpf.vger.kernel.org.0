Return-Path: <bpf+bounces-64816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FACB17462
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54301188BB9C
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156620C00D;
	Thu, 31 Jul 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQCpaCeu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B231E7C32
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977465; cv=none; b=teWVlGqbqzTyE1JMZI4WArfHADxsTRLbXhvX1zelFgGlqejLLr0msvgpZH1LQGConzZMWtXVP1zWvU/H5mIphsGqUTbInfSV1Mf1xY2WTaCqHKkqp4Qh4CuFtr6QQADG7ZZEcp0xNdcPueVW5EBx3UbH5hK5r3iATCK4tuIkiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977465; c=relaxed/simple;
	bh=zXqYwYUo5V5xtf38XeLw47tBDZGEMXc9yoHG17JPGAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pishGBiuXrX9ZmVMhK4hDjc+cAGWGajU3Zxk10EOZyWV0E/4FFdYajwWIhAkvjOmhCD4amWPONOeHleBWc5LLepZdMXOGKktf0lEGL0rsbf1CXT8l/WdpptdXUOqDXDvlMs81UNICdxr5QaNxU3cGGPHHRadAkR6O9rrEY0Z6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQCpaCeu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so482686f8f.3
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977462; x=1754582262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwEehyIvfFZxsxz6xG2f5ye6bcAONjKwPvSd6npT8hI=;
        b=uQCpaCeu488YzeJaqdtnpSe9JwJPNqEpBRpSw7umCywMzJkQaArjkMboySJ+37y7eX
         3l74AeaBFzWbTS8Q3oiaVX6FqmIypchnDkF5Tza5s+9z+BKDqvBDfSLAkTKDswMi2EHh
         rVOnMimM1pTDg20/rFX/WPG+s+cUQJ2vi8hksg7plziau4Ln+DkmVqtC1thMLLlXM/5d
         LQel6Op+cTuent21fKW7sWRUzh8Szmy40ynmhaBlseV9aJvcpbgx+Re+eYmpFc7lt/D2
         AyHDLvb+V1NE+SmqriJFPWVtEZ8c5gHGvGWBz/V9CJVCSCLsD+RlLGxUMqFV7Jp/+T1M
         YEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977462; x=1754582262;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwEehyIvfFZxsxz6xG2f5ye6bcAONjKwPvSd6npT8hI=;
        b=qi4fhPK3ScQ71YcnIQUWj6c2CGh7RDlI3kJ6NbOy8imH0FJZR81V+eqkYah6JAppNo
         a6VkE7dr0+6XhtgFt3nZDRwyTPoU199owFK09o7GYwbL5Fhz8ksKbu2WYAjW8Cms102F
         sNGNbYpO+jzhYe2XeADzkFZsiSQ8dhtUUc4irFy/sb6l/SAtLomk577xP1S0hbpCyjx8
         Kwzu4aCxI40mspoAmIUd+PhO0sb0VIGqL3pJwxzAwwcsGZy1eCVBAn1EzDlvwEbUJs+h
         jodGwKCGajpSuGWu9rblzlvZsiIYdz4QHcHGB9sPDduWRidFZMWGDGm8n9wjxVTx1d60
         kggw==
X-Forwarded-Encrypted: i=1; AJvYcCUYfQP1VNsyfCFNLdOHg3cz0tVh+PbGLfsCORaiku/Qh0g+V8g11jVN5FWJZ9a/menqqMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9ASoV8rImUb5xDbtbnfmQhfSEhc/TiC0Yj7AchTmoMLLdjFE
	c28sizO8Y39Tx+OGHfc4vVZZJYd25sQK+jYzr69ufNC1L4wcJFRuP2UG7xsmsW552TI=
X-Gm-Gg: ASbGncs2im6PQSEJkByOV0XVhIh9O4kCUZ5Uk+S4Z7IQf3HXAk1JiD2jWWQr5Vk/tFn
	ld5GrCeCPlLVTwtUyfISDscOolPjY0XB/JpJKR7ffd2Jb8/xYLjSu+FvcUkrjhjKmKy6Kr1DKDj
	POoIVj7iOk9qu2tDTXGaoNXpImDID5KCbzjlABxVilZ3eFqSD6ACZYLwQo06JwS2P2Ngc9YgM+p
	ycPi9QGLJbEBXcWBt+tdt+qpfOXaBDVMeK7n4HG61R7bx1M7fCHxSU85+RcvMd4mL2VOmUvNif+
	LfKoNSi4qz6oEakViGJGA311ZLFQHv/fabDPrIQaKda5Bs3bTUB1Auy6HtvcJ8a3sBkuHE93/Pd
	ezHjSpxYayALIPWTqLvD7oMKiuyU=
X-Google-Smtp-Source: AGHT+IEJypDs3Srfs5Ta2SryXW3PqrPZ2bjD8Bn1TfOmElhJKEUhoyptNdeCt1IpSC2bX7kUHiSQGg==
X-Received: by 2002:a05:6000:2f85:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b79501dd3fmr7085161f8f.59.1753977461645;
        Thu, 31 Jul 2025 08:57:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdf4sm32052495e9.11.2025.07.31.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:57:41 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:57:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	bboscaccy@linux.microsoft.com, paul@paul-moore.com,
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v2 08/13] bpf: Implement signature verification for BPF
 programs
Message-ID: <0b060832-4f55-486a-8994-f52d84c39e38@suswa.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721211958.1881379-9-kpsingh@kernel.org>

Hi KP,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Update-the-bpf_prog_calc_tag-to-use-SHA256/20250722-052316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250721211958.1881379-9-kpsingh%40kernel.org
patch subject: [PATCH v2 08/13] bpf: Implement signature verification for BPF programs
config: m68k-randconfig-r073-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231202.8rYZJ8D1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507231202.8rYZJ8D1-lkp@intel.com/

smatch warnings:
kernel/bpf/syscall.c:2797 bpf_prog_verify_signature() warn: 'sig' is an error pointer or valid

vim +/sig +2797 kernel/bpf/syscall.c

c83b0ba795b625 KP Singh           2025-07-21  2782  static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
c83b0ba795b625 KP Singh           2025-07-21  2783  					      union bpf_attr *attr,
c83b0ba795b625 KP Singh           2025-07-21  2784  					      bool is_kernel)
c83b0ba795b625 KP Singh           2025-07-21  2785  {
c83b0ba795b625 KP Singh           2025-07-21  2786  	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
c83b0ba795b625 KP Singh           2025-07-21  2787  	struct bpf_dynptr_kern sig_ptr, insns_ptr;
c83b0ba795b625 KP Singh           2025-07-21  2788  	struct bpf_key *key = NULL;
c83b0ba795b625 KP Singh           2025-07-21  2789  	void *sig;
c83b0ba795b625 KP Singh           2025-07-21  2790  	int err = 0;
c83b0ba795b625 KP Singh           2025-07-21  2791  
c83b0ba795b625 KP Singh           2025-07-21  2792  	key = bpf_lookup_user_key(attr->keyring_id, 0);
c83b0ba795b625 KP Singh           2025-07-21  2793  	if (!key)
c83b0ba795b625 KP Singh           2025-07-21  2794  		return -ENOKEY;
c83b0ba795b625 KP Singh           2025-07-21  2795  
c83b0ba795b625 KP Singh           2025-07-21  2796  	sig = kvmemdup_bpfptr(usig, attr->signature_size);
c83b0ba795b625 KP Singh           2025-07-21 @2797  	if (!sig) {

This should be an if (!IS_ERR(sig)) { check.

c83b0ba795b625 KP Singh           2025-07-21  2798  		bpf_key_put(key);
c83b0ba795b625 KP Singh           2025-07-21  2799  		return -ENOMEM;
c83b0ba795b625 KP Singh           2025-07-21  2800  	}
c83b0ba795b625 KP Singh           2025-07-21  2801  
c83b0ba795b625 KP Singh           2025-07-21  2802  	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
c83b0ba795b625 KP Singh           2025-07-21  2803  			attr->signature_size);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


