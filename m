Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A385AFEA7
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIGINa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIGIN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 04:13:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748AAAB064;
        Wed,  7 Sep 2022 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662538404; x=1694074404;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3tY7+UxsQtJxsn+pHqJlmXnkE7m3zYrQ42nl+LWECsg=;
  b=fwGw0aBvB8E3X52pT1E+L6kk/Ej/kpnCSNJOqrFt33m6EKlIjeEzgIH+
   6yQHMvkOMvtSEEb5z2JF+/UGPikYMGRHKkwiNBsgECNLbV63MHSx5eiFC
   0EQZb+hiBuwYGTFvY39Wgh7ziz6Q0iLxIVZsKph5d+x4HEM8+JKll5cJk
   m+zUmk7r1BUBHk9B0IT1RbCfm85Tjvp03rBd5Pgb/OG1jBHczXGWkVJ6z
   xZzHK0ykjjxuhUV9vFmy4nkmvPZfCTIbV8QdhQSl2hXehfckRjgwWikrx
   et497IRafEMeycBnOcGklQu2PW97zwDcxzvH6hlRyiMNjU+cDRqd6ILjA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277204804"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="277204804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 01:13:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644521099"
Received: from bpawlows-mobl.ger.corp.intel.com (HELO localhost) ([10.252.45.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 01:13:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <m2zgfc4ejp.fsf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-3-donald.hunter@gmail.com>
 <87h71kadjh.fsf@intel.com> <m2zgfc4ejp.fsf@gmail.com>
Date:   Wed, 07 Sep 2022 11:13:04 +0300
Message-ID: <87fsh38uwf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 06 Sep 2022, Donald Hunter <donald.hunter@gmail.com> wrote:
> Jani Nikula <jani.nikula@linux.intel.com> writes:
>
>>> +
>>> +.. csv-table:: Program Types and Their ELF Section Names
>>> +   :file: ../../output/program_types.csv
>>
>> Oh. You should probably test this with out-of-tree builds.
>
> By out of tree, do you mean make htmldocs O=... or something else?

Yeah, O= is what I mean.

BR,
Jani.

>
> I have tested with O=... whih works for the kernel docs, but I think I
> will need to rework the location to support the libbpf doc build which
> has different directory layout.
>
> Thanks,
> Donald.

-- 
Jani Nikula, Intel Open Source Graphics Center
