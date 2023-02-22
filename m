Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E269F81E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 16:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjBVPe3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 10:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjBVPe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 10:34:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A63B852;
        Wed, 22 Feb 2023 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677080036; x=1708616036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+FuP9Tnn9stvSO6EVtOlDZOoca9s1FRRhxzWrUFgceE=;
  b=IdzvlGImJqcZHZRtp3I+Lxme9/LYjMezCjhz0gd4ARPF0C+V/rj/Ovuz
   Rwqq0LFUAGJyWB1UKdbRiQE15IZyzYQIcVYmYmCzJdyM+hh74Cgk3CVXa
   Tw7R/WUasVju+CnDl4Th07Gh/1Aa4yg7vp+OmLzlbu4M0lERq/67ihdDa
   yoH2Bm6r5JrxzPr/7I/wQOOHD9Iq/SGihfQ81QMU0iiTmMkP2s6/pKzPU
   1zb2vfoVWYbIFCVx/3PNMyB6L3rSxFRz2wbD+uRXB6TfiqvNLmWEdcuP6
   yR7UWiqnPPMGYChQPAroggbMTv0WIW1MA5uwAVA/THKUTwgZESVOg9jhi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="332954584"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="332954584"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 07:33:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="781478044"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="781478044"
Received: from tzinser-mobl.amr.corp.intel.com (HELO [10.209.49.182]) ([10.209.49.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 07:33:35 -0800
Message-ID: <7189da9a-f634-01ae-194d-a4d14a319a1c@intel.com>
Date:   Wed, 22 Feb 2023 07:33:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
 <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/22/23 07:03, Geert Uytterhoeven wrote:
> On Wed, Feb 22, 2023 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Add the missing header for architectures that don't define
>> the barrier_nospec() macro. The nospec.h header is added after the
>> inclusion of barrier.h to avoid redefining the macro for architectures
>> that already define barrier_nospec() in their respective barrier.h
>> headers.
>>
>> Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_user()")
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Linus's master branch fails currently to build for arm64 without this commit.
> Not just arm64 🙁
> http://kisskb.ellerman.id.au/kisskb/head/5b7c4cabbb65f5c469464da6c5f614cbd7f730f2

Thanks for the fix, and sorry for the breakage, folks!  Obviously:

Tested-by: Dave Hansen <dave.hansen@linux.intel.com>

Now time to go make sure I have bpf turned on in all my cross builds.


