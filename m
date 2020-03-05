Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5961117B215
	for <lists+bpf@lfdr.de>; Fri,  6 Mar 2020 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 18:12:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEXMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 18:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=k34Jf9CwWQcBMtRBm/LyMJ1NsIiaNj1/P9aA0ygmbpE=; b=Pn9FOiOTq9I8lSUk8SMxNLpvDX
        ntEeZoHx/4KAbXCrRLRGixJqP+FEV7oZa68b/v3AO7BDcPSyDusNqbXTCDG1ZTjXgcc8TtxHaPlxh
        L0U8++hapYIH+CVFz+W4ZdEnSRsHLsjcOspneFpwAnU++p4B9XR3UcJTfPhKO3kdQkmNiDSvmMIZ1
        xoEbPFIxJpdY0YDjtRBgfWkPBFbs6V5hFn5FIJDtHp1uc2BocXZwtzmKq+Cubt6JTf4viE7gn+QF7
        lF2p1DTtubQLilOR2Ahw4mKsTZ21H08FSeGMHKBBZlb1HGvBdpUD6hL4wGcPXYyLDeXFh+GSP4j3a
        k4MooAtg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9zfa-0001f4-BJ; Thu, 05 Mar 2020 23:12:46 +0000
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for
 !CONFIG_NET
To:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org, linux-next@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20200305220127.29109-1-kpsingh@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92937298-69c1-be6f-3e40-75af1bc72d9e@infradead.org>
Date:   Thu, 5 Mar 2020 15:12:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305220127.29109-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/5/20 2:01 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> test_run.o is not built when CONFIG_NET is not set and
> bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
> linker error:
> 
> ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
>  `bpf_prog_test_run_tracing'
> 
> Add a __weak function in bpf_trace.c to handle this.
> 
> Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
> Signed-off-by: KP Singh <kpsingh@google.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  kernel/trace/bpf_trace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 363e0a2c75cf..6a490d8ce9de 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1252,6 +1252,13 @@ static bool tracing_prog_is_valid_access(int off, int size,
>  	return btf_ctx_access(off, size, type, prog, info);
>  }
>  
> +int __weak bpf_prog_test_run_tracing(struct bpf_prog *prog,
> +				     const union bpf_attr *kattr,
> +				     union bpf_attr __user *uattr)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  const struct bpf_verifier_ops raw_tracepoint_verifier_ops = {
>  	.get_func_proto  = raw_tp_prog_func_proto,
>  	.is_valid_access = raw_tp_prog_is_valid_access,
> 


-- 
~Randy
