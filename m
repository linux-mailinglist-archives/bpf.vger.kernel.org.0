Return-Path: <bpf+bounces-20508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007D83F2CE
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 03:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE811C2125C
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2C17F0;
	Sun, 28 Jan 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f000nPpY"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB515A7
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706407540; cv=none; b=Ms137MBYI9/72Xsh5CtvAv9Xce+mUOcKr0wbKgeFWKUndoy+18/DpIJAV0picdBCTql9n4oaTBcpE0W32cS4j9KxAJ4yHbAdD86J36WAyRwH+sKnjyRH+sEXMPK1PxspnBWG+zskz+A2sKARYM2+aqLfHN6LU3W3ZmBhslEeQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706407540; c=relaxed/simple;
	bh=KjSXljMu7HdemF4os90r/aeSzY/Pl2R+s8bw4cHXAPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIoaq+VbuENnte3LuZrQx8mdu0ge7m4Kmp+U7CqOIYfVqEdyb4bNsrJJDwSHJsbcC7H7/T34VNopcF45I2brR27ZDkIzLxODaGvPfS//N9XgdxGCvbHJvYH1WJN/zUCzKlcKGBi99vSRhrNRDIs+f48BHNzY6MNwHO1uBchccbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f000nPpY; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706407534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9TFVA9BiBMXnP+3StRo23gDSg13S04PXg03Gywosps=;
	b=f000nPpYHeiXwpOVhjF0B6LMbZbFRJiUCrN5obalhQ5kbHRaUnjU7KpTdx4xwzkdePiEge
	bu1uTOf9Fs5qfukrm8dl8Yy72s5DUwO597Q2c7aacBwyFZpV1+PaswVG54ttwzmn9va23f
	HneXs5r2fwmAnTynwbVUVnj1NQiXZpA=
Date: Sat, 27 Jan 2024 18:05:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF selftests and strict aliasing
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, david.faust@oracle.com,
 cupertino.miranda@oracle.com, Yonghong Song <yhs@meta.com>
References: <87plxmsg37.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87plxmsg37.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/27/24 11:59 AM, Jose E. Marchesi wrote:
> Hello.
> The following BPF selftests perform type-punning:
>
>    progs/bind4_prog.c
>    136 |         user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
>
>    progs/bind6_prog.c
>    149 |                 user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
>
>    progs/dynptr_fail.c
>    549 |         val = *(int *)&ptr;
>
>    progs/linked_list_fail.c
>    318 |         return *(int *)&f->head;
>    329 |         *(int *)&f->head = 0;
>    338 |         f = bpf_obj_new(typeof(*f));
>    341 |         return *(int *)&f->node2;
>    349 |         f = bpf_obj_new(typeof(*f));
>    352 |         *(int *)&f->node2 = 0;
>
>    progs/map_kptr_fail.c
>     34 |         *(u32 *)&v->unref_ptr = 0;
>
>    progs/syscall.c
>    172 |         attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
>
>    progs/test_pkt_md_access.c
>     13 |                 TYPE tmp = *(volatile TYPE *)&skb->FIELD;               \
>
>    progs/test_sk_lookup.c
>     31 |         (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
>    427 |         val_u32 = *(__u32 *)&ctx->remote_port;
>
>    progs/timer_crash.c
>     38 |         *(void **)&value = (void *)0xdeadcaf3;
>
> This results in GCC warnings with -Wall but violating strict aliasing
> may also result in the compiler incorrectly optimizing something.
>
> There are some alternatives to deal with this:
>
> a) To rewrite the tests to conform to strict aliasing rules.
>
> b) To build these tests using -fno-strict-aliasing to make sure the
>     compiler will not rely on strict aliasing while optimizing.
>
> c) To add pragmas to these test files to avoid the warning:
>     _Pragma("GCC diagnostic ignored \"-Wstrict-aliasing\"")
>
> I think b) is probably the best way to go, because it will avoid the
> warnings, will void potential problems with optimizations triggered by
> strict aliasing, and will not require to rewrite the tests.

I tried with latest clang with -fstrict-aliasing:

[~/work/bpf-next/tools/testing/selftests/bpf (master)]$ cat run.sh
clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
   -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include
   -idirafter /home/yhs/work/llvm-project/llvm/build.19/install/lib/clang/19/include
   -idirafter /usr/local/include -idirafter /usr/include   -Wno-compare-distinct-pointer-types
   -DENABLE_ATOMICS_TESTS -O2 -fstrict-aliasing --target=bpf -c progs/bind4_prog.c -mcpu=v3
   -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bind4_prog.bpf.o
[~/work/bpf-next/tools/testing/selftests/bpf (master)]$ ./run.sh
[~/work/bpf-next/tools/testing/selftests/bpf (master)]$

I does not have compilation failure. I am wondering why -fstrict-aliasing won't have warning in clang side
but have warning in gcc side.
Your suggestion 'b' seems okay or we could even add -fno-strict-aliasing into common compilation flags,
but I would like to understand more about -fstrict-aliasing difference between gcc and clang.

>
> Provided [1] gets applied, I can prepare a patch that adds the following
> to selftests/bpf/Makefile:
>
>    progs/bin4_prog.c-CFLAGS := -fno-strict-aliasing
>    progs/bind6_prog.c-CFLAGS := -fno-strict-aliasing
>    progs/dynptr_fail.cw-CFLAGS := -fno-strict-aliasing
>    progs/linked_list_fail.c-CFLAGS := -fno-strict-aliasing
>    progs/map_kptr_fail.c-CFLAGS := -fno-strict-aliasing
>    progs/syscall.c-CFLAGS := -fno-strict-aliasing
>    progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>    progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>    progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>
> [1] https://lore.kernel.org/bpf/20240127100702.21549-1-jose.marchesi@oracle.com/T/#u
>

