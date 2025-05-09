Return-Path: <bpf+bounces-57854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A4AB16F7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0D7B7861
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACD295DAB;
	Fri,  9 May 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaxgZiqX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890572957C4;
	Fri,  9 May 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800010; cv=none; b=M0m8PRjn+tS0rkH8FapOsYtaipM7dDXxXhA2qUVExfUelO7jv46cG3BObE5ndXfJ00TaszGhwiuHm5xIH6UvTLHV5pPLLTc1D6JZskXHR3mQaBkLfz601YamjYuCRg/qUCRol2VLAQAKRlQqtwbiL68q9k0K2WVkI694fKMruZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800010; c=relaxed/simple;
	bh=w1jQYPE2Doi+HHs3NZANXjINKX3NsvtO8bwrPT1Ogwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iof5POOZm8SPNQIpwOf7wii5RjmM//lS7tJp1qARIOvs17vjAo3RBAU4D9KAg2wp7wnouswcbVCcUyI8QWyXr8EobRI2YUcIHij7SC2bxWkMjZRbts/B5FuWLpAF9mnjukMwTabZLJJNwXJrWXXMecY4C+F8e93w8USZN6annx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaxgZiqX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746800009; x=1778336009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w1jQYPE2Doi+HHs3NZANXjINKX3NsvtO8bwrPT1Ogwo=;
  b=IaxgZiqXtczP6oa1xAMwFafTDs9ceLBgDpkyC8Lc80oe0flODb+kZojm
   6PrsVFHhwKJ7tKW3nxv4gJagXZSvEQSffDHhNZVGfsqAH+faLKiwpyrWx
   nOWMdllsQL8v1bchT09LN1lGaesL5PqFa1Qcv+FXmjcMu2s6Hf5W0aFiN
   XBlAsIt+GxObaLu+ndqZOSGawWknprUMY6e0Gm+3KMqkui5MbQXX/9Xds
   i4v5pqXP3M4FOm3RDDMRf9i7TYkmhJrkJKGzCkP9W1nyL3loWq01KDj+M
   BEH+5jm5PuyYnzurzEmN9YpvXRjWAixSjfE0IFi6I6K9oiCPftt0pSPbM
   w==;
X-CSE-ConnectionGUID: 5tWshLTSR4ezUMFPgI5/Fw==
X-CSE-MsgGUID: B1/Si58qT7awUICXkT64Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48782042"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48782042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 07:13:28 -0700
X-CSE-ConnectionGUID: +RFxhdCnQSasT+lMFMYEAg==
X-CSE-MsgGUID: a91sjI53QdSfDx+i2iJY1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141580846"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2025 07:13:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDOTW-000C9L-2i;
	Fri, 09 May 2025 14:13:18 +0000
Date: Fri, 9 May 2025 22:13:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/5] af_unix: Remove redundant scm->fp check
 in __scm_destroy().
Message-ID: <202505092103.UWs7ZtbF-lkp@intel.com>
References: <20250505215802.48449-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505215802.48449-4-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Call-security_unix_may_send-in-sendmsg-for-all-socket-types/20250506-060219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250505215802.48449-4-kuniyu%40amazon.com
patch subject: [PATCH v1 bpf-next 3/5] af_unix: Remove redundant scm->fp check in __scm_destroy().
config: i386-randconfig-054-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092103.UWs7ZtbF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092103.UWs7ZtbF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092103.UWs7ZtbF-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "scm_fp_destroy" [net/bluetooth/bluetooth.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

