Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837C55AE83B
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiIFMc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiIFMcc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 08:32:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DB11155;
        Tue,  6 Sep 2022 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662467516; x=1694003516;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=M0QrYYCZHzwfHM3DeFebGMHRf+P97fADvrUnnioFUDQ=;
  b=MlHH/gyFw9oGSOQ2bD6Pfit2OawrHB6scVpZ80hclpkI6ntR27Wlcv+D
   KV3kpzNwpE9fui4HCPIIfBsub2n5LC8stYVtLdVUVo4EeAlCfLXbtz9uK
   O+C7x7K5LO7M9V33kAbV+OTVXRWlx6y6wFnuLE+Y43khR05Xe4sLKeT2f
   eu/R/NW83tLyUrCAfU6x9PrHpgjJ/OueSP6LzK8/FsLA350dmA0U21h39
   sLfAfZb1w97VG5DYbTEuPJG0RaMZLHWrfn+tLDU0prgs/5Ufnc88FXXay
   o5ZOHfl9RIW8FBmnMDe7yV0dEe2BNOCgMK543N612wRW4thKgcDIGy2Hj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283574889"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283574889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:31:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="644152857"
Received: from reichelh-mobl.ger.corp.intel.com (HELO localhost) ([10.252.45.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:31:53 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <m2czc86ami.fsf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-3-donald.hunter@gmail.com>
 <875yi5dbpw.fsf@intel.com> <m2czc86ami.fsf@gmail.com>
Date:   Tue, 06 Sep 2022 15:31:36 +0300
Message-ID: <87k06gadlj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 06 Sep 2022, Donald Hunter <donald.hunter@gmail.com> wrote:
> Jani Nikula <jani.nikula@linux.intel.com> writes:
>
>> On Mon, 29 Aug 2022, Donald Hunter <donald.hunter@gmail.com> wrote:
>>> Extend the libbpf documentation with a table of program types,
>>> attach points and ELF section names. This table uses data from
>>> program_types.csv which is generated from tools/lib/bpf/libbpf.c
>>> during the documentation build.
>>
>> Oh, would be nice to turn all of these into proper but simple Sphinx
>> extensions that take the deps into account in the Sphinx build
>> process. And, of course, would be pure python instead of a combo of
>> Make, shell, and awk.
>>
>> That's one of the reasons we chose Sphinx originally, to be able to
>> write Sphinx extensions and avoid complicated pipelines.
>
> I could look at this as a followup patch since I would need to learn how
> to write Sphinx extensions first. It seems that it will require a new
> reST directive, is that right?

Correct. It's not very complicated. The extension that handles
kernel-doc is under 200 lines, Documentation/sphinx/kerneldoc.py. And a
lot of that is just translating directive options to kernel-doc the perl
script options.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
