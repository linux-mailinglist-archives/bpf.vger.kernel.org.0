Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080D54E6BA
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbiFPQMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378069AbiFPQMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 12:12:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC9222;
        Thu, 16 Jun 2022 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655395949; x=1686931949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9UssI0jjeOgubtdLVdnr3HWEhp3FQKF6wiN0xHRReqE=;
  b=AmFNPTjUoC/+s6Z2vl5sN/LrQqlvzJtYENA+8pplEoHFOnDdDHtjL0BX
   B0jHDIfcDHdnuf0ybydOMuFt1uRzIySmFTgvlRRwf341yFEDisjSvxyNh
   KwLL1QBtUhssv4dykhSbOaDyp5Pj100J2j4v7OWj9Yl2sHN9Z5bDAHwg3
   SEOW42mQyvxGn62oluqkCMREkSINi/bo5LEXGZtq63c2g/yg7QCmxEC8m
   353n4D5zcDRmfvgrH6q60A+OsYXSwfzGmbZlayxWbRWtYK0W9S51Y3yVS
   jO/OaBNezRiMNm8/d32JZTaaYWrLNyAYytxPuAh8+VqNsNWE0ImcqtUH5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279342002"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="279342002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:10:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="641609610"
Received: from rrmiller-mobl.amr.corp.intel.com (HELO [10.212.205.54]) ([10.212.205.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:10:06 -0700
Message-ID: <8ceff343-32fc-9131-1a37-44ca10a34723@intel.com>
Date:   Thu, 16 Jun 2022 09:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 bpf 3/4] module: introduce module_alloc_huge
Content-Language: en-US
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        akpm@linux-foundation.org, rick.p.edgecombe@intel.com,
        hch@infradead.org, imbrenda@linux.ibm.com, mcgrof@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <20220415164413.2727220-4-song@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220415164413.2727220-4-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/15/22 09:44, Song Liu wrote:
>  arch/x86/kernel/module.c     | 21 +++++++++++++++++++++
>  include/linux/moduleloader.h |  5 +++++
>  kernel/module.c              |  8 ++++++++

A cc of x86@kernel.org or better yet the "X86 MM" folks would be really
appreciated on future patches.  It sounds like these parts were pretty
lightly reviewed before.

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/MAINTAINERS#n21629

Feel free to cc the whole series, not _just_ the parts touching arch/x86/.
