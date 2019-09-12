Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE728B12BF
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbfILQ1T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Sep 2019 12:27:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:18344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbfILQ1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 12:27:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 09:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,497,1559545200"; 
   d="scan'208";a="184847227"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2019 09:27:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Sep 2019 09:27:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Sep 2019 09:27:08 -0700
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82]) by
 fmsmsx602.amr.corp.intel.com ([10.18.126.82]) with mapi id 15.01.1713.004;
 Thu, 12 Sep 2019 09:27:08 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
 calculations
Thread-Topic: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
 calculations
Thread-Index: AQHVaMwxyccHFlLbo0SZGzRXyf0nSqcoPAdg
Date:   Thu, 12 Sep 2019 16:27:08 +0000
Message-ID: <0c1b13d4fba947a1a99dac9ebef2635d@intel.com>
References: <20190911172435.21042-1-ciara.loftus@intel.com>
In-Reply-To: <20190911172435.21042-1-ciara.loftus@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzFiNTFjYTItYTZiOS00N2YwLWIxYjctMDc5YzFkNzVkOTZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN2Z2SnRJXC9ueGp3aTlvaDBmd3lyaTNSU2ZORjJrU29ONzVqK1lVMUNlb2UySHR4c0Q0YnBkSE9lVE54bVN5TjUifQ==
dlp-reaction: no-action
dlp-version: 11.0.400.15
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Ciara Loftus
> Sent: Wednesday, September 11, 2019 10:25 AM
> To: netdev@vger.kernel.org; ast@kernel.org; daniel@iogearbox.net; Topel,
> Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; bpf@vger.kernel.org;
> intel-wired-lan@lists.osuosl.org; Loftus, Ciara <ciara.loftus@intel.com>;
> Laatz, Kevin <kevin.laatz@intel.com>
> Subject: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
> calculations
> 
> Commit 4c5d9a7fa149 ("i40e: fix xdp handle calculations") reintroduced the
> addition of the umem headroom to the xdp handle in the i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc functions. However, the
> headroom is already added to the handle in the function i40_run_xdp_zc.
> This commit removes the latter addition and fixes the case where the
> headroom is non-zero.
> 
> Fixes: 4c5d9a7fa149 ("i40e: fix xdp handle calculations")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


