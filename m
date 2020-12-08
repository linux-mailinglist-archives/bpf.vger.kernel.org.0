Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28A32D344E
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgLHUgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbgLHUgE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:36:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82DC0613D6;
        Tue,  8 Dec 2020 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IxUjidxYoQWIWw+OSbuqWgs3S+ci7dg8LpOu70b8znU=; b=sjnn01VEYfQi5OpNsK+GClHuGB
        mcfYSiXC/rOeuiwzGaglu2Q15aEl8wzoVAhdgo26Fgp/zpq30S3IcVl9Q1F+vT5MEQeHbzo14i8X6
        wxFPOEDsIRmTaAZAEbtPnRVatVWkSnVagsS2+VoBH677rytezzLFubXxFwNe3oXN9CYi1O9ZAETQ+
        hCEvvAaYxja1IOfoebLGeAtCBXZ8OulMlIThPumQ3RiolNlI+Ui2+6oGcn1k4qUdaSiRM2+cvdP1x
        4TNC5ri1hJvAAe7MwQrHcZSxcX9BoqMjpv+VfVU4rLEuVj8Jh9/BsWkCrjYn4xIFpCr4+KGwbJGy7
        JtJQP/2w==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmjFe-0001sP-B7; Tue, 08 Dec 2020 20:06:22 +0000
Subject: Re: [PATCH bpf-next v3] bpf: Only provide bpf_sock_from_file with
 CONFIG_NET
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20201208173623.1136863-1-revest@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c8dd9a41-3e45-fb32-1074-e23ebe3cb2e5@infradead.org>
Date:   Tue, 8 Dec 2020 12:06:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208173623.1136863-1-revest@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/8/20 9:36 AM, Florent Revest wrote:
> This moves the bpf_sock_from_file definition into net/core/filter.c
> which only gets compiled with CONFIG_NET and also moves the helper proto
> usage next to other tracing helpers that are conditional on CONFIG_NET.
> 
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

I would say that I didn't ack this version of the patch (hey,
it's 3x the size of the v1/v2 patches), but I have just
rebuilt with v3, so the Ack is OK.  :)


> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/trace/bpf_trace.c | 22 ++--------------------
>  net/core/filter.c        | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 20 deletions(-)


-- 
~Randy

