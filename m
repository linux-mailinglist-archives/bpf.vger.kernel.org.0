Return-Path: <bpf+bounces-13074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCD7D433D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 01:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61B7281785
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECD24216;
	Mon, 23 Oct 2023 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfZoPO1+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269432420D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 23:32:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163CCC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698103946; x=1729639946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPABUbbCuZ9PFo1SgZF2n9YSEhD6yThsfdtfsjgSxK0=;
  b=kfZoPO1+MUQaLWMFfJxZZjcsWg2noOIFYlaRqRezBj1eZWmR+ph8InXU
   a3SQ9ZlNsBzBfCgmCnEBw+H1ynWWVsO+qjGES5OrJ1T+yxiEFjI7lMiFu
   5ZNE7KWZUpHeetFSluwh7XOSWA3bXd7wQOnGGX2xd7/cxkiXUHKWUIJ9B
   bqgp7jqFASxIGURlJb/uU/WgmNqwkHGvFEECXroBI+NlP1isIgS4K0PTo
   ocXAVFx9S53Dbuc8xg2qTqHO+sJPSdDITi+c56k7fcmz3XavfgBW/OfgK
   ZvnJ/nJfYP1yXKGFmpYuup9He1vocaOyM4dTGFTsW5aBITnuy0ct6u3WV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377325338"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="377325338"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005479575"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1005479575"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2023 16:32:24 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qv4PF-0007N5-2h;
	Mon, 23 Oct 2023 23:32:21 +0000
Date: Tue, 24 Oct 2023 07:32:06 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 bpf-next 4/4] selftests/bpf: Add tests exercising
 aggregate type BTF field search
Message-ID: <202310240704.3BxYlwQh-lkp@intel.com>
References: <20231023220030.2556229-5-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023220030.2556229-5-davemarchevsky@fb.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Fix-btf_get_field_type-to-fail-for-multiple-bpf_refcount-fields/20231024-060227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231023220030.2556229-5-davemarchevsky%40fb.com
patch subject: [PATCH v1 bpf-next 4/4] selftests/bpf: Add tests exercising aggregate type BTF field search
reproduce: (https://download.01.org/0day-ci/archive/20231024/202310240704.3BxYlwQh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240704.3BxYlwQh-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#65: FILE: tools/testing/selftests/bpf/progs/array_kptr.c:12:
+	struct prog_test_ref_kfunc __kptr *ref_ptr;
 	                                  ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

