Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA09444E7EC
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhKLNxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 08:53:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:15344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhKLNxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 08:53:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="220341996"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="220341996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 05:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="670657295"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2021 05:50:45 -0800
Received: from alobakin-mobl.ger.corp.intel.com (djachims-MOBL.ger.corp.intel.com [10.213.2.142])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1ACDohCU007515;
        Fri, 12 Nov 2021 13:50:43 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix incorrect use of strlen in xdp_redirect_cpu
Date:   Fri, 12 Nov 2021 14:50:31 +0100
Message-Id: <20211112135031.22167-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112020301.528357-1-memxor@gmail.com>
References: <20211112020301.528357-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 12 Nov 2021 07:33:01 +0530

> Commit b599015f044d tried to fix a bug where sizeof was incorrectly
> applied to a pointer instead of the array string was being copied to, to
> find the destination buffer size, but ended up using strlen, which is
> still incorrect. However, on closer look ifname_buf has no other use,
> hence directly use optarg.
> 
> Fixes: b599015f044d ("samples/bpf: Fix application of sizeof to pointer")
> Fixes: e531a220cc59 ("samples: bpf: Convert xdp_redirect_cpu to XDP samples helper")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Works, thanks!

Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Thanks,
Al
