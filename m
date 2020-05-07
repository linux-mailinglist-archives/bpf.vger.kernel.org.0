Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B927E1C835B
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGHYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 03:24:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:49708 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGHYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 03:24:20 -0400
IronPort-SDR: SrHE1OjEBk5Cq6XpPlvGbBPHqAyaycjBVyR1OE7mgzcEoE6E3mnKH1HLNQ2sEAQR6Fh/o1RKbb
 Z7hYL28bz5Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 00:24:19 -0700
IronPort-SDR: waf4mIazFQxt3LHU1hcNng7o3oXZj9BZRbPP5nO6+FhDEAuBSPZRNALAIhCb3CpN4YM6TalFjO
 9vxzbw4OfmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="370030154"
Received: from mstoisox-wtg9.ger.corp.intel.com (HELO [10.252.41.26]) ([10.252.41.26])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 00:24:18 -0700
Subject: Re: -EBUSY with some selftests on 5.7-rcX
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <e5ec787d-2fca-4701-ca2e-2b590a59fb6f@linux.intel.com>
 <CAEf4BzYHuJi5BE6=jYXuKynK8ViRfNjxSgkTiixp+ZQX9TyjAA@mail.gmail.com>
 <2408eda9-b001-3c34-d037-f7b5762bf7d7@linux.intel.com>
 <CAEf4Bzasmc4zvAyWJPPaWcu95CZ0DSuZC7vjZnpjNfw6T1TLJg@mail.gmail.com>
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
Message-ID: <a0ffa0bb-883c-41a6-f86c-8ea320fe798b@linux.intel.com>
Date:   Thu, 7 May 2020 10:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzasmc4zvAyWJPPaWcu95CZ0DSuZC7vjZnpjNfw6T1TLJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 06/05/2020 23:18, Andrii Nakryiko wrote:
> On Wed, May 6, 2020 at 12:28 PM Mikko Ylinen
> <mikko.ylinen@linux.intel.com> wrote:
>> The error seems to come from register_fentry() but I don't yet have
>> good logs what goes wrong.
> 
> Ok, this is actually useful. It's still few possibilities, but most
> seem to be related to ftrace subsystem. So here's portion of my
> Kconfig with FTRACE settings, see if you have some of those disabled
> and try to enable them, it might help. For instance, if you don't have
> a 5-byte preample in kernel functions (not sure which setting turns
> this on), bpf_arch_text_poke would also return EBUSY. Some of
> ftrace-specific code returns EBUSY in multiple places as well. So I'd
> start with trying to enable a lot of FTRACE stuff first:

With the following config changes:

-# CONFIG_FUNCTION_TRACER is not set
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FUNCTION_GRAPH_TRACER=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
+CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
+# CONFIG_FUNCTION_PROFILER is not set

# ./test_progs -t fentry_fexit
#13 fentry_fexit:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
# ./test_progs -t test_lsm
#70 test_lsm:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Thanks!

Perhaps there could be a check whether the operation
is supported and if not,-ENOTSUPP is returned?

-- Mikko
