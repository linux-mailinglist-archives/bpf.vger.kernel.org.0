Return-Path: <bpf+bounces-35173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73689381BE
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19CF281CDF
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255F13AA35;
	Sat, 20 Jul 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/cTzZ0h"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FE1EB30
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721486714; cv=none; b=gpFzie3VJ9hwG/hRZPn4V22Ny/2u0LAw9vhC3wgj4LxrjjQ+T2gEGhz/h/0qrb8d2ciNI4Lb3ayxQeUfF2sn6qnn9IhQmbRhJeqp9gW4nVOXZRyNGnt1ZPYgZaIRdXdaaESChLvvcickiKAfaQ/lmccsa8N4vX0IXQycOpaPldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721486714; c=relaxed/simple;
	bh=ka60obSHmYAb+MOLAIDEFfu6NXtecVV/oPdQM23bBvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+sRHMXpkle95sqe0YEkbXRktnapzNd79NDZYqazkUoAr7TN+LMS8mbn+elHA6IwXFz1KiG/skDFxW1XODWAlVVn+XtOYW251MuTJl7KKBDG8Iz3vVzjDzS7CgeRIilBLDQNeiqeEQtivByuYyzHlv6F4g0oT0AI21E2BhxhCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/cTzZ0h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721486713; x=1753022713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ka60obSHmYAb+MOLAIDEFfu6NXtecVV/oPdQM23bBvQ=;
  b=S/cTzZ0hk9QVJFAM/9va2JBTdkhuyzF+TRKindmiqG0liuPgg5G1hKSk
   WpgqABSBz0IUTycC8NgwTtd0VTgcluwEYSIMvZRtw9a9ZBO1rWD3Z+rfZ
   PWOb/QwqPCZLj8IjfSd2SEXvjt6IoJ3KVBgVPZAt9vQQ9kHWkyA+fWKlK
   jPxnZu/BtxGLPYQsgY7842+JuARUx+3cSp7kJtVhbj2b26+HgdEI4sop2
   5mVQYqAdWMkZ6lL8qChWZ3455p6U1KHbrV5fkBaEGxliTYdXsBuZLl8B0
   VQ3c3oEhgoNZrQsNopK10E/5PRw5ETCYpNYVbJZhLuR/WJzittsIBONZc
   g==;
X-CSE-ConnectionGUID: 2cHF4DQoQsKb3LCvSY+XYg==
X-CSE-MsgGUID: kiYYgFvKRpK8gFTJ4zR7cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="36633823"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="36633823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 07:45:12 -0700
X-CSE-ConnectionGUID: LfqKUgekS5SiZr74GqZHDg==
X-CSE-MsgGUID: L/HbtSB0TSOobgQ/ghOEeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="55575269"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Jul 2024 07:45:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVBKe-000jIA-02;
	Sat, 20 Jul 2024 14:45:08 +0000
Date: Sat, 20 Jul 2024 22:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
	Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the
 bpf_struct_ops's cfi_stubs
Message-ID: <202407202244.HvnUVyjM-lkp@intel.com>
References: <20240720062233.2319723-2-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720062233.2319723-2-martin.lau@linux.dev>

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-KaFai-Lau/bpf-Check-unsupported-ops-from-the-bpf_struct_ops-s-cfi_stubs/20240720-144313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240720062233.2319723-2-martin.lau%40linux.dev
patch subject: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
config: i386-randconfig-001-20240720 (https://download.01.org/0day-ci/archive/20240720/202407202244.HvnUVyjM-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407202244.HvnUVyjM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407202244.HvnUVyjM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/bpf_struct_ops.c: In function 'bpf_struct_ops_supported':
>> kernel/bpf/bpf_struct_ops.c:1045:48: warning: dereferencing 'void *' pointer
     void *func_ptr = *(void **)(&st_ops->cfi_stubs[moff]);
                                                   ^


vim +1045 kernel/bpf/bpf_struct_ops.c

  1042	
  1043	int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
  1044	{
> 1045		void *func_ptr = *(void **)(&st_ops->cfi_stubs[moff]);
  1046	
  1047		return func_ptr ? 0 : -ENOTSUPP;
  1048	}
  1049	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

