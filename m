Return-Path: <bpf+bounces-74019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C983FC4466B
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 20:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42B34E3A2C
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BC23C39A;
	Sun,  9 Nov 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Frs51qwU"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDB1DF270
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717838; cv=none; b=ZlBG2JkvJAKiiCV9Ik6BTepDLY15jcF3lJPhLXa1TibN3qFQfo1nw2rFWEll39f5azYQNU/lvFoLH6vRXQzwe08C3Gm4i8fi2yutClVugvfV11iDHmzYW9ZBkvNSMLWo3XyYRSn1evv4yApbEUl1UYpIqDUcMSO7TF25zH59pPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717838; c=relaxed/simple;
	bh=zGSK2b2A+5WfxFnLEQOBOxJL+rPLbdEOyNtBK/Tnxis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDd+oI82D5f7nyA9t14rCb//gS1/dB+snxMfBitB4/dLp7pXMg+WijA5vukJp0x1zGRH3la/bezUcDlIWpzDwGm7/7Zel+u3XTne4U1iUdc3BuwGDOF7EXmuVGpWydD4a3aVoE3ftCT/v2SdUyfoOsOK1H+fyLhY9vLOtVMRqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Frs51qwU; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <893afb17-aac2-47d6-8651-e07ccc37995b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762717835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5wmH7YZFWEC4wfGTybhj2CoQ0yrkoJ7aJUyPCTIAsk=;
	b=Frs51qwUHTc3Z2BVRSF9UMnqzYpDyaUNLHbcnw2dAvarG4msJfTEccLXomD/5wy+/MdfFk
	fCtHcvlMwrO3GAINruwDyyYcJw1xOLQL5Tiwx9YALwUsmrewEEWcqFnR2JbZdXI2towiL3
	QGAA++Fb9P1x87Lw4rX7L06FS+hgCP8=
Date: Sun, 9 Nov 2025 11:50:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BPF selftests]:bpf_arena_common.h: error: conflicting types for
 'bpf_arena_alloc_pages'
Content-Language: en-GB
To: Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
Cc: ast <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>
References: <CAK3+h2yuppeOisqT+G6pf9zsP7sTbbbgKWpMe6s5TL6fZ-coWg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAK3+h2yuppeOisqT+G6pf9zsP7sTbbbgKWpMe6s5TL6fZ-coWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/9/25 9:09 AM, Vincent Li wrote:
> Hi,
>
> Sorry if this is a known issue,  but I could not find it.  my build environment:
>
> [root@fedora linux-loongson]# pahole --version
> v1.30
> [root@fedora linux-loongson]# clang --version
> clang version 21.1.5
> Target: loongarch64-redhat-linux
> Thread model: posix
> InstalledDir: /usr/bin
>
> [root@fedora linux-loongson]# bpftool version
> bpftool v7.6.0
> using libbpf v1.6
> features: llvm, skeletons
>
> I got errors below while building bpf selftests with bpf-next branch,
> I had to comment out the bpf_arena_alloc_pages,
> bpf_arena_reserve_pages, bpf_arena_free_pages in
> tools/include/vmlinux.h, then progs/stream.c build succeeded. It looks
> like these functions in tools/include/vmlinux.h generated by bpftool
> are not the same as in bpf_arena_common.h. is there something wrong in
> my build environment?

Could you try pahole master branch? See the conversion in
   https://lore.kernel.org/bpf/8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev/

>
>
> In file included from progs/stream.c:8:
> /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:47:15:
> error:
>        conflicting types for 'bpf_arena_alloc_pages'
>     47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
> *addr, __u32 page_cnt,
>        |               ^
> /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180401:14:
> note:
>        previous declaration is here
>   180401 | extern void *bpf_arena_alloc_pages(void *p__map, void
> *addr__ign, u32 page_cnt, int node_i...
>          |              ^
> In file included from progs/stream.c:8:
> /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:49:5:
> error:
>        conflicting types for 'bpf_arena_reserve_pages'
>     49 | int bpf_arena_reserve_pages(void *map, void __arena *addr,
> __u32 page_cnt) __ksym __weak;
>        |     ^
> /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180403:12:
> note:
>        previous declaration is here
>   180403 | extern int bpf_arena_reserve_pages(void *p__map, void
> *ptr__ign, u32 page_cnt) __weak __ksym;
>          |            ^
> In file included from progs/stream.c:8:
> /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:50:6:
> error:
>        conflicting types for 'bpf_arena_free_pages'
>     50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32
> page_cnt) __ksym __weak;
>        |      ^
> /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180402:13:
> note:
>        previous declaration is here
>   180402 | extern void bpf_arena_free_pages(void *p__map, void
> *ptr__ign, u32 page_cnt) __weak __ksym;
>          |             ^
> 3 errors generated.
>
> Vincent


