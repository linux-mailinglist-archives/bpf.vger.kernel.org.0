Return-Path: <bpf+bounces-36248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF694564F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C377286401
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 02:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC81CA85;
	Fri,  2 Aug 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsoHoHoB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B411BC58
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565746; cv=none; b=FsqBQ0YPyFUjTFSLVOK5e9OVqmENA0PbaIVeLEmi+j1OnwhEQVoq3Ka0YZyFK61ZXgKyW3PWqv5XJxikhWn+835ybutYX0CDIslLjyZ55JNgRU7cagpDipvyA/ZULOSSiSjpxvI6fqFCfBVbJsAjGINi9e4PMuXjfo+JHOYP6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565746; c=relaxed/simple;
	bh=LvpBjr3roRtc0FBZwaU8CDGxZQ7LwWL27ZS0lbxZLRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KC8sKD95qqXett53arXWCxESfnfoSTM2umx3iJ6HJs264zzdBqcaTENZIB5RxYHFOuv0Vjr28wuq6PaGfCPHqe8RMUBu9ze8INw/ZAr8vQ8NHSl4LP8pn0lyYIRANhE/D1hM9Uvh3Ij+dRw2YPj7OZh+9B4jx5GFaUqyPoFA9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsoHoHoB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so4584754a91.1
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722565745; x=1723170545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpVuoQbVjToA7nUzOC4tkltrdd+lD23fM429/TlbAuU=;
        b=fsoHoHoBzNDuzgAu9NR3bXGhzIbhGdd+bnayXldWJabALa7zkJLBzLbQYvJA94oZlt
         UW2lPGVwX5U41QCaIfQS8tKc6ma2yeznBTHjgW7iIghVuyXa+rJQC8tRw0Zk6adp11vh
         fo6rxL4xMi3QXRlfzZE3pRQEuHszaBUgkdYCsoKcpMnVvzOyWxuFRYFb9nZ/MdSn4mDT
         V9B8HGksbzXmnaeZl/h7J/u1jRytcw3wv1IRr5VKNPwY1kJRZf4HSengVbf7WYHB0gPR
         bhI9Vi+DrsqkjlE200ta6VA477ZAPOlQ0oCKKqiaz69y6gxXhtSsB2G/LomQck/Dlc6e
         Nctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722565745; x=1723170545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpVuoQbVjToA7nUzOC4tkltrdd+lD23fM429/TlbAuU=;
        b=WEnJuzYbL01DLXVLgIbcIgQNzKn1azyipn5QcJshjVX3NqW1Fomxc9Ag5L6LmcYfSW
         s7ZpxKzoTCass0e4Ex3rN/93EAOVQDp88xt4AkyBvLK/Ed44kueV/O27wRiKWDI1QnhV
         kCaOb5LePvXCA5+YOKZQTx8mTFZPdH3Xp2m+5Y55YVsKdHqeAL4IFMPEV5dv1jHuBbPL
         371lBsQHrrtD7JTEVDuMcBVg7zgpwqxJQCmGctSgrYsGmmCtbz3pMb5NeY/uvR9FvakZ
         3wAOUY8Pzr/WcgvDuSB9/Ck1pGVVoE3533Ba/TzFr5d+Ob7HFIOpUJFZsy4mCDIZ7PAB
         I5vA==
X-Gm-Message-State: AOJu0Yzt7LslJJA4jloWUridRKVWNgzwnwcJfOoQBkaJRT+N3FKQcZbY
	z1tf5CB0yrc/UGY1AeA3Fb+RmB+wfFJNOV41P0kGrhdSAyE0W00TkFh7Zw==
X-Google-Smtp-Source: AGHT+IFy/+1klADUk9EORaDuCtFEHe2n7unaOBkJtDXvyxL0S/9LREGIscJHMCwK8CDRplpDibC8rw==
X-Received: by 2002:a17:90a:fe88:b0:2c9:7fba:d88b with SMTP id 98e67ed59e1d1-2cff9419943mr2781060a91.14.1722565744632;
        Thu, 01 Aug 2024 19:29:04 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0c681esm639285a91.25.2024.08.01.19.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 19:29:03 -0700 (PDT)
Message-ID: <4ee78b54-04c1-4c76-883c-8ddcbb7d2b3f@gmail.com>
Date: Fri, 2 Aug 2024 10:28:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question regarding "Add testcases for tailcall hierarchy fixing"
Content-Language: en-US
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 david.faust@oracle.com
References: <871q38gk6g.fsf@oracle.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <871q38gk6g.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/24 02:41, Cupertino Miranda wrote:
> 
> Hi Leon,
> 
> In the following commit:
> 
> commit b83b936f3e9a3c63896852198a1814e90e68eef5
> Author: Leon Hwang <hffilwlqm@gmail.com>
> 
>     selftests/bpf: Add testcases for tailcall hierarchy fixing
> 
> you created 2 tests files that contain the following inline assembly.
> 
>     asm volatile (""::"r+"(ret));
> 
> I presume the actual intent is to force the unused ret variable to
> exist as a register.
> 
> When compiling that line in GCC it produces the following error:
> 
> progs/tailcall_bpf2bpf_hierarchy2.c: In function 'tailcall_bpf2bpf_hierarchy_2':
> progs/tailcall_bpf2bpf_hierarchy2.c:66:9: error: input operand constraint contains '+'
>    66 |         asm volatile (""::"r+"(ret));
>       |         ^~~
> 
> After analysing the reasoning behind the error, the plausible solution
> is to change the constraint to "+r" and move it from the input operands
> list to output operands, i.e:
> 
>       asm volatile ("":"+r"(ret));
> 
> Can you please confirm that this change would be complient with the test
> semantics ?

Hi Cupertino,

The purpose of this "asm volatile" is to prevent that compiler optimizes
the return value of the function by returning 0 directly and maybe
eliminating bpf_tail_call_static().

Therefore, it's better to use "__sink()" defined in "bpf_misc.h":

/* make it look to compiler like value is read and written */
#define __sink(expr) asm volatile("" : "+g"(expr))

Here's the diff:

diff --git
a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index 37604b0b97af..72fd0d577506 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -58,12 +58,12 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
 {
-       volatile int ret = 0;
+       int ret = 0;

        subprog_tail0(skb);
        subprog_tail1(skb);

-       asm volatile (""::"r+"(ret));
+       __sink(ret);
        return (count1 << 16) | count0;
 }

diff --git
a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index 0cdbb781fcbc..a7fb91cb05b7 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -51,11 +51,11 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
 {
-       volatile int ret = 0;
+       int ret = 0;

        bpf_tail_call_static(skb, &jmp_table0, 0);

-       asm volatile (""::"r+"(ret));
+       __sink(ret);
        return ret;
 }

Thanks,
Leon

> 
> Regards,
> Cupertino

