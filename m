Return-Path: <bpf+bounces-65839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C74B291B0
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 07:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B1196069A
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21531DEFE7;
	Sun, 17 Aug 2025 05:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gf3pWXDn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E11D86FF
	for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755409846; cv=none; b=izvpJQSRh2OMXJB9GYvGZu/rWu1XvOzo3e8lVjCjyF07TtFQWCSPuOqgL7GB2eR3W/tpOraB0JekYg/BbDijHC9lURGrnJxnhe1Ny4keSzVKfu+bSfxzBrFMmtf/tpSWtMIfwAbfyqEeEQzfqhqSr5qxDxvQrsikYKUtll+kPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755409846; c=relaxed/simple;
	bh=7E2RL4iIZK2j50YuRhdke3XCW8m8vWG0XAmz5wBmSLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUu2VteRyPu5XLtVNaHKwiSo4LDX6VAcH8ULxvVozTx9k7P1adSOZAlzyoa1sPQjRT/oCqNmWhWyco+fOJI1qW7BkPK780LO3zX/bhXbXro9YWnVFqoCsUyIemUQy/bhBdSheFlmNsF7NKNrB3E5QdudVXVRe2LTNBOLE3+zW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gf3pWXDn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755409843; x=1786945843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7E2RL4iIZK2j50YuRhdke3XCW8m8vWG0XAmz5wBmSLo=;
  b=gf3pWXDn/GgiSAqZ97iHZUJpcat53pDdckIMJ0sqUu02xvKdMeGZtruY
   og/1uv1XJ9f6au9oo88J9mtP6MzIX2XbFUOIG5Sr1cAH7Wwkei0j0vISb
   nUaWEpByPk5v1NyYftdJa+TFArn6NEjtuegPCe/T0eXJeaLXozHq3uqBA
   ygMTyttI66mx2EdZ329VofI+g4b/4VLwjrJNO4+BaDkJwbtbGJ8J+w1Mh
   KODZ1lyoxIgx5CVb4tZIPB+CBPxpQFnH8DY7fP+Ow7gunoZQ/tvCR7BBI
   LsCVCfy2crmsuMZBuunhQNvGoE8cW1UyQtGTnv877mWFag3jdDgx8gxLX
   w==;
X-CSE-ConnectionGUID: mdzgiIZDSKaxgaw66WFSoQ==
X-CSE-MsgGUID: LEbpHki4RoiQ22sE/LOtiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57739981"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57739981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 22:50:42 -0700
X-CSE-ConnectionGUID: pZ9vkEpzQne8JJwF78Qbpg==
X-CSE-MsgGUID: zTTf/7yAQDC4qZhcB8qkiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171757045"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Aug 2025 22:50:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unWHt-000DNb-2f;
	Sun, 17 Aug 2025 05:50:37 +0000
Date: Sun, 17 Aug 2025 13:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with
 constants blinding
Message-ID: <202508171315.5y3oPyC2-lkp@intel.com>
References: <20250816180631.952085-6-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816180631.952085-6-a.s.protopopov@gmail.com>

Hi Anton,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-fix-the-return-value-of-push_stack/20250817-020411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250816180631.952085-6-a.s.protopopov%40gmail.com
patch subject: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with constants blinding
config: sparc-randconfig-001-20250817 (https://download.01.org/0day-ci/archive/20250817/202508171315.5y3oPyC2-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250817/202508171315.5y3oPyC2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508171315.5y3oPyC2-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: kernel/bpf/core.o: in function `bpf_jit_blind_constants':
>> core.c:(.text+0x8064): undefined reference to `bpf_insn_array_adjust'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

