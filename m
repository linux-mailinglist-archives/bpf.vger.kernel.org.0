Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611102D1A39
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgLGUFT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 15:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgLGUFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 15:05:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E809C061794
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 12:04:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ga15so21316108ejb.4
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1fLpHyStJBLv4aqDCL/7SVHpDLwiRrQzoRyrVsNBNNw=;
        b=jNsLsfeV2FkguEwqHIJLI4rYmYRF1wgUtiYqQqIWfatqST5/EFGHOcLs+JlHGF1sLJ
         4JBP6HOQLZw7L8sCJYntHm+guWJwv5ev6HKQvgfw8ahmy27wZXtrUH6qjosvnA/oRqih
         CWOov84H1+Ujj81/cwqrSte8yOSjXq5VxD3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1fLpHyStJBLv4aqDCL/7SVHpDLwiRrQzoRyrVsNBNNw=;
        b=Q1TXXF29N6q402HCBMmBNGgHYo20Hu032UeokuyV3Dh53RsrOyyYn0yFnME0j4VsAY
         r/oYgxVr889f1xvk8zCyl52uM++HKIEXb2nR9d/z1SE0355NKNffhyJUNMEVWydAMDu3
         0s7ZFVwrO8GP9EVgsXegUGaalwFm8mzYZSRkQCvuip7zhv1pPhChq3e5voM8ENbSOsSM
         78oiBeInpiVPOF4y/SEXIe2NVaehYMDT8hokC/xIhyTFtnOdEoaM+wcInm5jn/uXQjqE
         u1DzLgDu/Si1bQooMB+Q+1WYdQsVxumFjfbKSoGonQdXIMUo/fLSggGt03VvODSidTH3
         C6nQ==
X-Gm-Message-State: AOAM533hL4IvvWoToysOx0UtVDQ5Mepmptrvh1cTdWucEckojy1B1Tde
        h+ZQQ+KogSgnvbD2P2y3i6jfgvbyw2hpvg==
X-Google-Smtp-Source: ABdhPJzC2Cp/8Sf+L1ff7VBAIICLIXnXpNa/LfTinUDha9V4CAAhbm1VDVmv3BRLiyb0CFIZG9yfDw==
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr20120451ejb.499.1607371477671;
        Mon, 07 Dec 2020 12:04:37 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id e10sm13809540ejl.70.2020.12.07.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 12:04:37 -0800 (PST)
Message-ID: <aeeb146ca7b4194e23e99fc3cd0fa0dcdc951651.camel@chromium.org>
Subject: Re: [PATCH bpf-next] bpf: Only call sock_from_file with CONFIG_NET
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, rdunlap@infradead.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Dec 2020 21:04:36 +0100
In-Reply-To: <20201207195539.609787-1-revest@chromium.org>
References: <20201207195539.609787-1-revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-07 at 20:55 +0100, Florent Revest wrote:
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0cf0a6331482..877123bae71f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1272,7 +1272,11 @@ const struct bpf_func_proto
> bpf_snprintf_btf_proto = {
>  
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> +#ifdef CONFIG_NET
>  	return (unsigned long) sock_from_file(file);
> +#else
> +	return NULL;

Ugh, and of course I messed up my fix... :) Now this causes a:

./include/linux/stddef.h:8:14: warning: returning ‘void *’ from a
function with return type ‘u64’ {aka ‘long long unsigned int’} makes
integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^
kernel/trace/bpf_trace.c:1278:9: note: in expansion of macro ‘NULL’
 1278 |  return NULL;

So I'm sending a v2!

