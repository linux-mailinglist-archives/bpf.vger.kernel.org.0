Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3E6BE07A
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 06:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCQFIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCQFIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 01:08:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A234B810
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 22:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679029679; x=1710565679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJitu/MYQH5jonPEvDtzRMxAeAn8tKOpeFdj9UqgqmY=;
  b=NmzSG7UdaKajlIBsOjknfcWkWthyAnjxLgW2PA7BQNMSuDVRUZBHFLPf
   vnCly1ocVoNWAsyO6Ct26HbBDFtrWX3XBAf8BIdCFY3ee/Mu/8r7YoRgd
   ROPKuN27ZB3gTbQ6ouiryFbGFrNNM4OmSwaS0vuIbawKEz72OJQVJKeiA
   +404Z1+kH48y3wvPsCDQ5rW46aomBjJ61SuMXgG6vyKwZ3UiNLiK12wuE
   W2Czdg5sQngEoFuVU7Gnh/dWmIHQtallASkR5i5q2lH69AEfLhp0nT6j3
   4EUMtRFttCTwltB0nIDwj9D0aNbelqK/wRl2vcjsTGnOuDw/vy6P9175b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365878715"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="365878715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 22:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="790596787"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="790596787"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2023 22:07:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd2Jo-00096c-2Z;
        Fri, 17 Mar 2023 05:07:56 +0000
Date:   Fri, 17 Mar 2023 13:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
Message-ID: <202303171242.biyrTbVN-lkp@intel.com>
References: <20230316183013.2882810-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316183013.2882810-4-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-split-off-basic-BPF-verifier-log-into-separate-file/20230317-023431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230316183013.2882810-4-andrii%40kernel.org
patch subject: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a rotating log by default
config: i386-randconfig-a002-20230313 (https://download.01.org/0day-ci/archive/20230317/202303171242.biyrTbVN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f2876fe2427e5bdfbbb27980025b969c93f46c4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-split-off-basic-BPF-verifier-log-into-separate-file/20230317-023431
        git checkout f2876fe2427e5bdfbbb27980025b969c93f46c4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171242.biyrTbVN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/log.o: in function `bpf_verifier_vlog':
>> kernel/bpf/log.c:59: undefined reference to `__umoddi3'
>> ld: kernel/bpf/log.c:60: undefined reference to `__umoddi3'
   ld: kernel/bpf/log.o: in function `bpf_vlog_finalize':
   kernel/bpf/log.c:212: undefined reference to `__umoddi3'


vim +59 kernel/bpf/log.c

    17	
    18	void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
    19			       va_list args)
    20	{
    21		unsigned int n;
    22	
    23		n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
    24	
    25		WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
    26			  "verifier log line truncated - local buffer too short\n");
    27	
    28		if (log->level == BPF_LOG_KERNEL) {
    29			bool newline = n > 0 && log->kbuf[n - 1] == '\n';
    30	
    31			pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
    32			return;
    33		}
    34	
    35		if (log->level & BPF_LOG_FIXED) {
    36			n = min(log->len_total - bpf_log_used(log) - 1, n);
    37			log->kbuf[n] = '\0';
    38			n += 1;
    39	
    40			if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
    41				goto fail;
    42	
    43			log->end_pos += n - 1; /* don't count terminating '\0' */
    44		} else {
    45			u64 new_end, new_start, cur_pos;
    46			u32 buf_start, buf_end, new_n;
    47	
    48			log->kbuf[n] = '\0';
    49			n += 1;
    50	
    51			new_end = log->end_pos + n;
    52			if (new_end - log->start_pos >= log->len_total)
    53				new_start = new_end - log->len_total;
    54			else
    55				new_start = log->start_pos;
    56			new_n = min(n, log->len_total);
    57			cur_pos = new_end - new_n;
    58	
  > 59			buf_start = cur_pos % log->len_total;
  > 60			buf_end = new_end % log->len_total;
    61			/* new_end and buf_end are exclusive indices, so if buf_end is
    62			 * exactly zero, then it actually points right to the end of
    63			 * ubuf and there is no wrap around
    64			 */
    65			if (buf_end == 0)
    66				buf_end = log->len_total;
    67	
    68			/* if buf_start > buf_end, we wrapped around;
    69			 * if buf_start == buf_end, then we fill ubuf completely; we
    70			 * can't have buf_start == buf_end to mean that there is
    71			 * nothing to write, because we always write at least
    72			 * something, even if terminal '\0'
    73			 */
    74			if (buf_start < buf_end) {
    75				/* message fits within contiguous chunk of ubuf */
    76				if (copy_to_user(log->ubuf + buf_start,
    77						 log->kbuf + n - new_n,
    78						 buf_end - buf_start))
    79					goto fail;
    80			} else {
    81				/* message wraps around the end of ubuf, copy in two chunks */
    82				if (copy_to_user(log->ubuf + buf_start,
    83						 log->kbuf + n - new_n,
    84						 log->len_total - buf_start))
    85					goto fail;
    86				if (copy_to_user(log->ubuf,
    87						 log->kbuf + n - buf_end,
    88						 buf_end))
    89					goto fail;
    90			}
    91	
    92			log->start_pos = new_start;
    93			log->end_pos = new_end - 1; /* don't count terminating '\0' */
    94		}
    95	
    96		return;
    97	fail:
    98		log->ubuf = NULL;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
