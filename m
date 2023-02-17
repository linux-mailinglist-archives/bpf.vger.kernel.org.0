Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFF169B261
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBQSdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 13:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQSdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 13:33:36 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC86242D
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 10:33:35 -0800 (PST)
Message-ID: <58374b80-34b6-4c4f-b7bd-9c2f6be3eba6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676658813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBrzUnhtrE6SbL73tcs5ktHIqhkF4qIy0Od4Q9hHGRI=;
        b=tzSWRx4431bb6c4b1J9oS+xlwmIyGznYMLqc16/fO8oRMMpz2JSPnuYvdqkbeWFbDLhYWL
        LIX0Fv9OVHNWL4MyCkS7oPRYKTowmu2IKQ3ZalvY71hcjsIr5NO8TdqM+4AiGgOS0XE3Yj
        eT5ONKvKXgRRkaaRYek6TpzQ7I+sQok=
Date:   Fri, 17 Feb 2023 10:33:30 -0800
MIME-Version: 1.0
Subject: Re: [linux-next:master 12987/13499] include/linux/build_bug.h:78:41:
 error: static assertion failed: "SKB_WITH_OVERHEAD(TEST_XDP_FRAME_SIZE -
 XDP_PACKET_HEADROOM) == TEST_MAX_PKT_SIZE"
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <202302172104.q3ddwzqu-lkp@intel.com>
 <50c35055-afa9-d01e-9a05-ea5351280e4f@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <50c35055-afa9-d01e-9a05-ea5351280e4f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/17/23 5:50 AM, Alexander Lobakin wrote:
> From: Kernel Test Robot <lkp@intel.com>
> Date: Fri, 17 Feb 2023 21:45:40 +0800
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> head:   c068f40300a0eaa34f7105d137a5560b86951aa9
>> commit: 6c20822fada1b8adb77fa450d03a0d449686a4a9 [12987/13499] bpf, test_run: fix &xdp_frame misplacement for LIVE_FRAMES
>> config: ia64-randconfig-r025-20230213 (https://download.01.org/0day-ci/archive/20230217/202302172104.q3ddwzqu-lkp@intel.com/config)
>> compiler: ia64-linux-gcc (GCC) 12.1.0
> 
> ia64 has 128-byte cacheline on some configs. While I can easily test it
> in the kernel, what do I do in the userspace test >_<
> Or just exclude non-{64,256} CLs from the assertion?

I would remove the static_assert from the kernel. Having a comment in the 
xdp_do_redirect.c selftest is good enough. Considering the bpf supported archs 
are more mainstream, it is easier for the xdp_do_redirect.c test to take care of it.
