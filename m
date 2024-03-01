Return-Path: <bpf+bounces-23189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94B86E9F2
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1911F23DEF
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E233B783;
	Fri,  1 Mar 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/Oq/kzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039777EC
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322462; cv=none; b=KBbPRWBBAYZHWNH7+wIklQv7Y+s4taCJ+iBGxd+N0tF6ebNx8tMJdeT9WQScHgef+TCfq93CaGgFbzdVTT4j5UdT9Q5RitGhUhu2wbRnrMsmwNSc98ANaS/v92GJ4YEIZO8jYwU5+5i4ilKeY4ZyAT3cHRT2i9LFv1FPeyH+Tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322462; c=relaxed/simple;
	bh=B3xf1vFEEs+t5SxuqdbgiTFNF6D9hYmKJpC9hZNFHdw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jXAYzo+EACrnerEnG9p78mzObjU6rtfYnGjYaAJuUC48mpsbTw1wUhmboLJPOomEEUva1x6GyhSuanFAGySmNHoRKWxGljlkcAdhrnlue4v9aqHxZ6T4n8mNcDbNTprkEoPo/xekQUmQa2xrxwsCIeTrDeox45ZjTWzvmxA0PRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/Oq/kzi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc139ed11fso29808765ad.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322460; x=1709927260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6b3xgzQwNjIdIP1elSCdUplXM4VOPCQD4/5Ok1QcfA=;
        b=U/Oq/kzi4r9S5Ccp9zjGJ0y0eQ26XFztHB2yJJlG18mdMNn3s5PaaUQ0jnHC/sLjUI
         Cq+Cw+YEpGwQShOWmSW6DImvM2LZRgnfJfnm3/0I5D8Xc8/TeA/42Tzb+zkL4hK8XRoi
         ZcdBL8HhsG/e9LVKQ6yhuJRDcsM0zYSp0OJTN6qWrmuRfUdo4XqKH80nWavABOVsv1+L
         wEhEHzAo3fRv+0Gvo6A3nkH1VqS8P3vtWpaP9FF9lboryqubLNXE8in5ACRFLsfgWn9D
         KSDF+Mfp0glqz5FzBhV7nMNG01XjV6xqVhqvvymkFfJRbxCavqeXGx+s8B24nfghBswJ
         q2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322460; x=1709927260;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B6b3xgzQwNjIdIP1elSCdUplXM4VOPCQD4/5Ok1QcfA=;
        b=WqffsJQPX+WTktSybLCdh62sVjd8h8dPmBpyyTl+I1gRexYkHcCaIi5P3N51UNagj7
         nQer7XJINk5f3NH3Cn793dud/uKbxwshR8Vw9FeJp6tx1yvc/ukOZisevJUcNTZed7Dp
         ZWTgWlVMlG1rV6ZV+Ogz5NRIRcwfJUI3w1Rk7ojdzkEtj/eAmdRcTISykHp07Cv8fBVW
         IG2p2d3ojDrPTD+RtERIbG/GYmUbWYpbq/BsAMmCjVgP+IvyQ24MW80dx9OP8RMZe/1H
         8tj1RHGlMZOtyfJJRDGr93gh8YureRLmZSof7yeCc5BJyyYR4WRogZmP/TyN3Bqd9rEY
         rbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtPLCkPzpGyMpNpU2JFfWMhOVLrkP2FRsSsW1an6salF0vSChdGPHQWqwx4GSnIRugfO7B6mdqROpBIe4Gx3wg/oFa
X-Gm-Message-State: AOJu0YxL4b6aRbxpiTipreg8odjTTzFswdyiL95OV0O8PCSDxXYUffqj
	9DaK5djcz3b4/PcOJH0kXmplQRk+xsfoH2Fa05CsKU9cAGR210wl
X-Google-Smtp-Source: AGHT+IHG5tsEcGxdFBGjaKE3EoeD1gK+g+WpGFycHB1c7r8SjqmDVioUW9++DgmcbKmKS4CW5lVlag==
X-Received: by 2002:a17:902:d5cb:b0:1db:ccd7:5249 with SMTP id g11-20020a170902d5cb00b001dbccd75249mr2966562plh.34.1709322460105;
        Fri, 01 Mar 2024 11:47:40 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id mn14-20020a1709030a4e00b001dcada71593sm3857152plb.273.2024.03.01.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:47:39 -0800 (PST)
Date: Fri, 01 Mar 2024 11:47:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 bpf@vger.kernel.org
Cc: daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@kernel.org, 
 memxor@gmail.com, 
 eddyz87@gmail.com, 
 kernel-team@fb.com
Message-ID: <65e230d4670d9_5dcfe20885@john.notmuch>
In-Reply-To: <20240301033734.95939-5-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
 <20240301033734.95939-5-alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add tests for may_goto instruction via cond_break macro.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../bpf/progs/verifier_iterating_callbacks.c  | 72 ++++++++++++++++++-
>  2 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 1a63996c0304..c6c31b960810 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -3,3 +3,4 @@
>  exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
>  get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
>  stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
> +verifier_iter/cond_break
> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index 5905e036e0ea..8476dc47623f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#include <linux/bpf.h>
> -#include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> +#include "bpf_experimental.h"
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARRAY);
> @@ -239,4 +237,72 @@ int bpf_loop_iter_limit_nested(void *unused)
>  	return 1000 * a + b + c;
>  }
>  
> +#define ARR_SZ 1000000
> +int zero;
> +char arr[ARR_SZ];
> +
> +SEC("socket")
> +__success __retval(0xd495cdc0)
> +int cond_break1(const void *ctx)
> +{
> +	unsigned int i;
> +	unsigned int sum = 0;
> +
> +	for (i = zero; i < ARR_SZ; cond_break, i++)
> +		sum += i;
> +	for (i = zero; i < ARR_SZ; i++) {
> +		barrier_var(i);
> +		sum += i + arr[i];
> +		cond_break;
> +	}
> +
> +	return sum;
> +}
> +
> +SEC("socket")
> +__success __retval(999000000)
> +int cond_break2(const void *ctx)
> +{
> +	int i, j;
> +	int sum = 0;
> +
> +	for (i = zero; i < 1000; cond_break, i++)
> +		for (j = zero; j < 1000; j++) {
> +			sum += i + j;
> +			cond_break;
> +		}
> +
> +	return sum;
> +}
> +
> +static __noinline int loop(void)
> +{
> +	int i, sum = 0;
> +
> +	for (i = zero; i <= 1000000; i++, cond_break)
> +		sum += i;
> +
> +	return sum;
> +}
> +
> +SEC("socket")
> +__success __retval(0x6a5a2920)
> +int cond_break3(const void *ctx)
> +{
> +	return loop();
> +}
> +
> +SEC("socket")
> +__success __retval(0x800000) /* BPF_MAX_LOOPS */
> +int cond_break4(const void *ctx)
> +{
> +	int cnt = 0;
> +
> +	for (;;) {
> +		cond_break;
> +		cnt++;
> +	}
> +	return cnt;
> +}

I found this test illustrative to show how the cond_break which
is to me "feels" like a global hidden iterator appears to not
be reinitialized across calls?

 static __noinline int full_loop(void)
 {
         int cnt = 0;
 
         for (;;) {
                 cond_break;
                 cnt++;
         }
 
         for (;;) {
                 cond_break;
                 cnt++;
         }
 
         bpf_printk("cnt==%d\n", cnt);
         return cnt;
 }

 SEC("socket")
 __success __retval(16777216)
 int cond_break5(const void *ctx)
 {
         int cnt = 0;
  
         for (;;) {
                 cond_break;
                 cnt++;
         }
  
         cnt += full_loop();
  
         for (;;) {
                 cond_break;
                 cnt++;
         }
         return cnt;
 }
  
This fails with,

do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
run_subtest:FAIL:654 Unexpected retval: 8388608 != 16777216
#430/15  verifier_iterating_callbacks/cond_break5:FAIL
#430     verifier_iterating_callbacks:FAIL

;       cnt += full_loop();                                         
     118:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
     120:       b4 02 00 00 0d 00 00 00 w2 = 13
     121:       bc 73 00 00 00 00 00 00 w3 = w7
     122:       85 00 00 00 06 00 00 00 call 6
;                                                            

I guess this is by design but I sort of expected each
call to have its own context. It does make some sense to
limit main and all calls to a max loop count so not
complaining. Maybe consider adding the test? I at least
thought it helped.

> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.34.1
> 
> 



