Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4F6A0A60
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjBWNUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 08:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjBWNU3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 08:20:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54F56537
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677158429; x=1708694429;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=l0GHKh5IMDUCkMZUPMVxjbBCs3eUpcaooaPM/UdCVgg=;
  b=UlWYXj8//7zS59sgsToThTg/QtTbg3NBJIUT2AMtJCLrWODEnAL5EYhn
   Qc32AqM3YVhQ0YRoz94+JYE4u0qlO5YF4sAMWxS/3bnJMzWef+t56wlpG
   pk/g1guhiqYhcTigfaluMarMZYrLr7T67jsnA78o0IqP2Wq7NoSE73AhN
   732koWWnGWWn/oqe8LaDQ9E18wy3GYNygJcL0pbz5P6x8ZTXjDN2Rn6Ad
   wf1+Lm9Omz+JbtgpcjBjFMj85otCA0J+9Oznma01eAwhHdUP4QPHDHylT
   LyjPZKTMyScdTJJ44LfOPCux6ohj5yQixlmMGjtiNHpVprOjciwz55oGI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312837394"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="312837394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 05:20:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736354084"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="736354084"
Received: from arechkov-mobl.ger.corp.intel.com (HELO [10.249.39.184]) ([10.249.39.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 05:20:26 -0800
Message-ID: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
Date:   Thu, 23 Feb 2023 15:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     bpf@vger.kernel.org
From:   Tero Kristo <tero.kristo@linux.intel.com>
Subject: bpf: RFC for platform specific BPF helper addition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,LOCALPART_IN_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Some background first; on x86 platforms there is a free running TSC 
counter which can be used to generate extremely accurate profiling time 
stamps. Currently this can be used by BPF programs via hooking into perf 
subsystem and reading the value there; however this reduces the accuracy 
due to latency + jitter involved with long execution chain, and also the 
timebase gets converted into relative from the start of the execution of 
the program, instead of getting an absolute system level value.

Now, I do have a pretty trivial patch (under internal review atm. at 
Intel) that adds an x86 platform specific bpf helper that can directly 
read this timestamp counter without relying to perf subsystem hooks.

Do people have any feedback / insights on this list about addition of 
such platform specific BPF helper, basically thumbs up/down for adding 
such a thing? Currently I don't think there are any platform specific 
helpers in the kernel.

-Tero

