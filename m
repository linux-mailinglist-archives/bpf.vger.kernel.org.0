Return-Path: <bpf+bounces-30083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E448CA60E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 04:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C261C20FE9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F290FC11;
	Tue, 21 May 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YW1nCIu3"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243B28FA;
	Tue, 21 May 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716257558; cv=none; b=PBQVSWgSz4NDABbcoDEjjMtaEPtPSmY87kkpOX0cC47w5ZOOhs3mTJtwM+WRAbmTCDPcyqthzMX2ykYuusDdv2pVLiYkNFdaSX0munexOQgpV7ZK77avP0jJIOcIBA50RIV7a6g1lpKPg2QjtCsIV1Yjr22IjKfZLnCFRmWi4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716257558; c=relaxed/simple;
	bh=V2BJLb8tR3YwIBkh3sbUIQ7yeb/oFg50OLQMB4UoXGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c98lhMSzvtDxXZIHTp4+ALLTWDWFXxf8iqXDx7CVcrk5/lA5qRHTUuuhB657qI0Saj26kN0jPiJDXrsMbOWWUjaNDWNdOt0wEK6L7UpOMh8iNdnFjUdGsasyde5oUSY34WHlPH5C3DMFXogqo6Zxvt9G0AskWl19BjUHdB9j6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YW1nCIu3; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ivan@cloudflare.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716257554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeOR0nXKja+YsNuSzWYUqCWPqH9qbcgn9VPIxCYo4x4=;
	b=YW1nCIu3jqV8jP3fq+3aOh5dqPFcuG0jCJy2RfbwgG/fdcpU5GTQ8g1jZmmCXjTGYd8kF9
	dnQMrz816HHVvosxFpzt1wGJebJcK0Qx6B9fIUhoRQg/0+/jlmJI1ajmfX/3Oi+TvblwIW
	ryWDozoo9WKcR3q35kVToyF5OpYTXZQ=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: quentin@isovalent.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: nathan@kernel.org
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: trix@redhat.com
X-Envelope-To: ramasha@fb.com
Message-ID: <92c38851-5435-4562-9dbc-4270d67af0bc@linux.dev>
Date: Mon, 20 May 2024 19:12:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: un-const bpf_func_info to fix it for llvm 17 and
 newer
Content-Language: en-GB
To: Ivan Babrou <ivan@cloudflare.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Raman Shukhau <ramasha@fb.com>
References: <20240520225149.5517-1-ivan@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240520225149.5517-1-ivan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/20/24 4:51 PM, Ivan Babrou wrote:
> LLVM 17 started treating const structs as constants:
>
> * https://github.com/llvm/llvm-project/commit/0b2d5b967d98
>
> Combined with pointer laundering via ptr_to_u64, which takes a const ptr,
> but in reality treats the underlying memory as mutable, this makes clang
> always pass zero to btf__type_by_id, which breaks full name resolution.
>
> Disassembly before (LLVM 16) and after (LLVM 17):
>
>      -    8b 75 cc                 mov    -0x34(%rbp),%esi
>      -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>      +    31 f6                    xor    %esi,%esi
>      +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>
> It's a bigger project to fix this properly (and a question whether LLVM
> itself should detect this), but for right now let's just fix bpftool.
>
> For more information, see this thread in bpf mailing list:
>
> * https://lore.kernel.org/bpf/CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com/T/
>
> Fixes: b662000aff84 ("bpftool: Adding support for BTF program names")
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


