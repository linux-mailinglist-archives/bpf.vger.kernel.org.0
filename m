Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBD468F13
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 03:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhLFCYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Dec 2021 21:24:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:64204 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhLFCYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Dec 2021 21:24:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="235968995"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="235968995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:21:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="656846675"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:21:02 -0800
Message-ID: <576e09b1-eb25-955b-9a7c-53b1b56b8dbd@intel.com>
Date:   Mon, 6 Dec 2021 10:21:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: [PATCH bpf] treewide: add missing includes
 masked by cgroup -> bpf dependency
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, kbuild-all@lists.01.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com
References: <20211120035253.72074-1-kuba@kernel.org>
 <202111201602.tm0dlDfP-lkp@intel.com>
 <20211120073431.363c2819@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <20211120073431.363c2819@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/21 23:34, Jakub Kicinski wrote:
> On Sat, 20 Nov 2021 16:55:16 +0800 kernel test robot wrote:
>> Hi Jakub,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on bpf/master]
>>
>> url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
>> config: riscv-rv32_defconfig (attached as .config)
>> compiler: riscv32-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/e31b3bdd266ef8f63543f27cf7493e98112fd74a
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
>>          git checkout e31b3bdd266ef8f63543f27cf7493e98112fd74a
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
> False positive, riscv seems to have a broken module.h so including
> it in more places results in more of the same errors.

Hi Jakub,

Thanks for the feedback, the bot can't always find the first introduced 
commit with the bisection method,
we hope someone can fix the reported issues if interested.

Best Regards,
Rong Chen
