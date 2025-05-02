Return-Path: <bpf+bounces-57211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB76AA6E7F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4278F1BC0217
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EC233149;
	Fri,  2 May 2025 09:53:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F31225A5B;
	Fri,  2 May 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179620; cv=none; b=JJ8odLwWneQWDQydK6zsvDCEdXX013lKDe+WITFwMFfcsWvf4j/lHb/IoobRHz97gKJf8GEQVtQuVJ/520ZLEN4C6BQJHAvNnMYVlzbdzPUsJl9+Q4ScQ++HQ4nplgzCi5VR4amp2R4GH3upZW29Dyo+vn3pFSyRnBEy7aXHnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179620; c=relaxed/simple;
	bh=JHMMMU1bX3h8bu/hi6tQeKJ8hxcjwpsysQUN8R7ylWc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZVn13RYlizyRVtaq+dBCOgJ2xud4/173Gp3ppwPd4BVeCb90JrzxRHij8m5V0OMRhDuxtNkLhc5uIKirWFaOnFHJimd7K2FiWHzKPYPQPej3iW1gaJEwX0ufapzWdGafhtOiOY0hLV71rM9/DrpHs3yK7EOlrlJjRwhzWT+kiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 909E8103765;
	Fri, 02 May 2025 11:53:35 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 61134601893B6;
	Fri, 02 May 2025 11:53:35 +0200 (CEST)
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
Date: Fri, 2 May 2025 11:53:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-05-02 11:26, Quentin Monnet wrote:
> On 02/05/2025 09:57, Holger Hoffstätte wrote:
>> A gcc-15-based bpf toolchain defaults to C23 and fails to compile various
>> kernel headers due to their use of a custom 'bool' type.
>> Explicitly using -std=gnu11 works with both clang and bpf-toolchain.
>>
>> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> 
> Thanks! I tested that it still works with clang.
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!

> I didn't manage to compile with gcc, though. I tried with gcc 15.1.1 but
> option '--target=bpf' is apparently unrecognised by the gcc version on
> my setup.
> 
> Out of curiosity, how did you build using gcc for the skeleton? Was it
> enough to run "CLANG=gcc make"? Does it pass the clang-bpf-co-re build
> probe successfully?

I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
which is just gcc configured & packaged for the bpf target.
Our bpftool package can be built with clang (default) or without, in
which case it depend on the bpf-toolchain. The idea is to gradually
allow bpf/xdp tooling to build/run without requiring clang.

The --target definition is conditional and removed when not using clang:
https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7.5.0.ebuild?id=bf70fbf7b0dc97fbc97af579954ea81a8df36113#n94

The bug for building with the new gcc-15 based toolchain where this
patch originated is here: https://bugs.gentoo.org/955156

Hope this helps!

cheers
Holger

