Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962FF1D06AF
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgEMFz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 01:55:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:38475 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEMFz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 01:55:57 -0400
IronPort-SDR: AaUH9ttiXQ5udoOayukJM9ebDVdkze0p6HwbKzUZudM/xbhullrQTs3wlRQLAQGcwuAtrXpDV6
 aBffgSGL99aQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:55:57 -0700
IronPort-SDR: YB0uMt0MnjvtgMjzed/ejgxny2lVeOlbBPoLN0fM3fSqNgl4X1qyyn4ltqrPyhlacGA3p3o11O
 /wHvzrTzioNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="463809969"
Received: from hxu31-mobl2.ccr.corp.intel.com (HELO [10.255.28.224]) ([10.255.28.224])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2020 22:55:55 -0700
Subject: Re: bprm_count and stack_mprotect error when testing BPF LSM on
 v5.7-rc3
To:     KP Singh <kpsingh@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
 <CAEf4BzZXA3pDwqLGTnrDAn7cH67Ei6tp8PRZwVAmsT-nTMA0gA@mail.gmail.com>
 <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
 <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
 <65526c26-c94b-d5dd-7143-b1af7071dbf9@intel.com>
 <CAFLU3KsDXDXqqhOUTx6jij7p3tgirNtDH-619z9mvgafFYN=jA@mail.gmail.com>
 <b3991caf-9e04-b6f4-aee5-86191a0fc3df@intel.com>
 <CAFLU3Ku=+VQ5KYXfwSqRknuYsz9nMV7-oj1Z1BNL4jiwVXPOOQ@mail.gmail.com>
From:   Ma Xinjian <max.xinjian@intel.com>
Message-ID: <1cd50917-17a5-1806-07ce-ee7b91ec61ef@intel.com>
Date:   Wed, 13 May 2020 13:55:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFLU3Ku=+VQ5KYXfwSqRknuYsz9nMV7-oj1Z1BNL4jiwVXPOOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 5/9/20 9:28 PM, KP Singh wrote:
> On Sat, May 9, 2020 at 11:59 AM Ma Xinjian <max.xinjian@intel.com> wrote:
>>
>> On 5/9/20 5:26 PM, KP Singh wrote:
>>> Do you have bpf in your CONFIG_LSM string?
>> That's the point!
>>
>> I remove bpf from  since I can't boot if bpf in it.
> That does indicate a problem which needs to be fixed.
>
>> seems bpf in CONFIG_LSM conflict with CONFIG_BPF_LSM
>>
>> Here is boot error:
>>
>> "Cannot determine cgroup we are running in: No data available
>> Failed to allocate manager object: No data available
>> [!!!!!!] Failed to allocate manager object, freezing.
> I found some references to these error messages and they seem
> to be coming from systemd but I am not sure.
>
>     https://github.com/lxc/lxc/issues/1669
>     https://github.com/containers/libpod/issues/1226
>
>> Freezing execution.
>> [   35.773797] random: fast init done
>> [  130.560629] random: crng init done"
>>
>>> Also, can you share your Kconfig please?
>> refer to attackment.
>>
>> I doubt sth was wrong with my kconfig, maybe me some suggestion
> I am not saying something is wrong with your Kconfig :)
> I just want to make sure we eliminate as many
> variables as possible.
>
> I was able to boot this successfully using QEMU
> (after I enabled SCSI and VIRTIO). So it's likely
> dependent on some user-space configuration
> (again, I am not saying your config is wrong). But
> I will need more information to reproduce and debug this.
>
> Can you try providing a reliable reproduction with a list
> of steps? e.g.
>
> 1. Download the vanilla image here.
> 2. Compile the kernel with defonconfig and kvmconfig
>     (or your own config)
> 3. Boot the kernel in QEMU with the cmdline (...) and the
>    QEMU args (...)
>
> Thanks!
> - KP

Thank you very much for your kind and quick reply.

I tested on LKP cluster of Intel. Everything works automatically.

https://github.com/intel/lkp-tests

---------------------

And I have found the cause.

It can't boot due to comfliction between cgroup configuration for 
CONFIG_BPF_LSM

and systemd.

similar to https://github.com/elogind/elogind/issues/18

we have decided to skip this test.

Thanks again.

- Ma

>
>> Besides, I tested on both physical machine and vm
> [...]
>
-- 
Best Regards.
Ma Xinjian

