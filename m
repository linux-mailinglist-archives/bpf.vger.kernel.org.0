Return-Path: <bpf+bounces-16105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053F7FCD09
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 03:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60695B21738
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45B3FDB;
	Wed, 29 Nov 2023 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqstxKz5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4F1707;
	Tue, 28 Nov 2023 18:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701225788; x=1732761788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XslR35BlM3Il/whuQ1UUnmJy8Unfm8S9xb1YMnw6Ni4=;
  b=UqstxKz5ihZPNY3qY2c4VDzwMTw4VmDbzILZWbSU+wOqfKzBaPAbc+/i
   f7YXWeX4CIo1/snoT0+mWefIDZ3dCQu1SOoBMQWxlj9pe/z9QE3+Acp0q
   obg3LdxwTo9Yx5gjb8zZvZhlRfcR81+u28v8BZ8yTwbgGzcyOsqWNz99X
   BBFm44f3jqFjg2kBaYIeARRXQUkEcFSumyzJQxEF/L3k283bfOVwrw1Ek
   g/7mCUeHkqdwmB/GygMceDmIK0dvzl9x+Fuo57m8AUo+1e1oWF31g7Rzn
   1qImWhkUWRDrnq44v0VSg4ZCiv1vLF0w6OMAQz2Ex8DNkLHiE39deU+hL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372449081"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372449081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="745107845"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="745107845"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2023 18:43:05 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8AXX-0008Sk-1D;
	Wed, 29 Nov 2023 02:43:03 +0000
Date: Wed, 29 Nov 2023 10:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: oe-kbuild-all@lists.linux.dev, john.fastabend@gmail.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] bpf: sockmap, add af_unix test with both
 sockets in map
Message-ID: <202311290745.tAZIyCyC-lkp@intel.com>
References: <20231128155515.9302-3-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128155515.9302-3-john.fastabend@gmail.com>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Fastabend/bpf-sockmap-af_unix-stream-sockets-need-to-hold-ref-for-pair-sock/20231128-235707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20231128155515.9302-3-john.fastabend%40gmail.com
patch subject: [PATCH bpf v3 2/2] bpf: sockmap, add af_unix test with both sockets in map
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290745.tAZIyCyC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290745.tAZIyCyC-lkp@intel.com/

All errors (new ones prefixed by >>):

   tools/testing/selftests/bpf/prog_tests/sockmap_listen.c: In function 'pairs_redir_to_connected':
>> tools/testing/selftests/bpf/prog_tests/sockmap_listen.c:1355:13: error: 'nop_madfd' undeclared (first use in this function); did you mean 'nop_mapfd'?
    1355 |         if (nop_madfd >= 0) {
         |             ^~~~~~~~~
         |             nop_mapfd
   tools/testing/selftests/bpf/prog_tests/sockmap_listen.c:1355:13: note: each undeclared identifier is reported only once for each function it appears in


vim +1355 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c

  1338	
  1339	static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
  1340					     int sock_mapfd, int nop_mapfd,
  1341					     int verd_mapfd, enum redir_mode mode)
  1342	{
  1343		const char *log_prefix = redir_mode_str(mode);
  1344		unsigned int pass;
  1345		int err, n;
  1346		u32 key;
  1347		char b;
  1348	
  1349		zero_verdict_count(verd_mapfd);
  1350	
  1351		err = add_to_sockmap(sock_mapfd, peer0, peer1);
  1352		if (err)
  1353			return;
  1354	
> 1355		if (nop_madfd >= 0) {
  1356			err = add_to_sockmap(nop_mapfd, cli0, cli1);
  1357			if (err)
  1358				return;
  1359		}
  1360	
  1361		n = write(cli1, "a", 1);
  1362		if (n < 0)
  1363			FAIL_ERRNO("%s: write", log_prefix);
  1364		if (n == 0)
  1365			FAIL("%s: incomplete write", log_prefix);
  1366		if (n < 1)
  1367			return;
  1368	
  1369		key = SK_PASS;
  1370		err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
  1371		if (err)
  1372			return;
  1373		if (pass != 1)
  1374			FAIL("%s: want pass count 1, have %d", log_prefix, pass);
  1375	
  1376		n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
  1377		if (n < 0)
  1378			FAIL_ERRNO("%s: recv_timeout", log_prefix);
  1379		if (n == 0)
  1380			FAIL("%s: incomplete recv", log_prefix);
  1381	}
  1382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

