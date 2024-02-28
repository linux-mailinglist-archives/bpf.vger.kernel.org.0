Return-Path: <bpf+bounces-22833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C771D86A65A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829DB2838FE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F679E5;
	Wed, 28 Feb 2024 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rknj/sva"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C64A23
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086275; cv=none; b=WlSIfPUfZnNzUaAm44bUo6HmwC4EQzOIL55TAcLxdzNO+jKFx7uXwhXJjG52cqEEivAkETtXP5bTbrB/xvCIzGFA71Vw1C6HDTi656fyxqgQRYh4qxWSrHPBkJ/6nxZkvmQ10scPXhadL/g2PwwmG7kJxyLQDqou4Yoifpb/KmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086275; c=relaxed/simple;
	bh=Zru9MPOmWqtzAYtZv3kgU63ha8BwYTDjUKer1aWG3OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDnG8dXufJY00mG7x2iQOhN8v4aJ83NXa99YkJRFXOEU29mAgW0Z6vDYlv3PgINrhxlYyqSloBQYW0+bUSEaZmXqo6ALqIkIR1T+Mp/0UfD+gOnEwUH8ikRMV0hLBzuaZSuOGLg7uplTQZWKb0DGyrYoXpivX80UcCrTFSf5Dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rknj/sva; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709086271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIfDwSgj+uWuIZkdU49mRIeje6XVPgsLsLIu9U+HoUA=;
	b=Rknj/svaQVCT718/RieDKsqGNWWt80b/8VV7NUkt17GrZfibZZHp3OGy7ZaWK5ndbaJdgA
	9zsBKtSGpjavFFxWDL+u1tjT22Rc4gXBBbRhNz6KdDeZX07yerzSmGoXtIGqywG0U3H4Am
	mbLnxF1VHFbqpaguI6YH1XEylxIjPuI=
Date: Tue, 27 Feb 2024 18:10:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240227204556.17524-8-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/24 12:45 PM, Eduard Zingerman wrote:
> Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
> state for referenced programs.
> 
> E.g. for the BPF code below:
> 
>      SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
>      SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
> 
>      SEC(".struct_ops.link")
>      struct test_ops___v1 A = {
>          .foo = (void *)foo
>      };
> 
>      SEC(".struct_ops.link")
>      struct test_ops___v2 B = {
>          .foo = (void *)foo,
>          .bar = (void *)bar,
>      };
> 
> And the following libbpf API calls:
> 
>      bpf_map__set_autocreate(skel->maps.A, true);
>      bpf_map__set_autocreate(skel->maps.B, false);
> 
> The autoload would be enabled for program 'foo' and disabled for
> program 'bar'.
> 
> Do not apply such toggling if program autoload state is set by a call
> to bpf_program__set_autoload().
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b39d3f2898a1..1ea3046724f8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -446,13 +446,18 @@ struct bpf_program {
>   	struct bpf_object *obj;
>   
>   	int fd;
> -	bool autoload;
> +	bool autoload:1;
> +	bool autoload_user_set:1;
>   	bool autoattach;
>   	bool sym_global;
>   	bool mark_btf_static;
>   	enum bpf_prog_type type;
>   	enum bpf_attach_type expected_attach_type;
>   	int exception_cb_idx;
> +	/* total number of struct_ops maps with autocreate == true
> +	 * that reference this program
> +	 */
> +	__u32 struct_ops_refs;

Instead of adding struct_ops_refs and autoload_user_set,

for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by checking 
prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now decided at 
load time and is only set if it is used by at least one autocreate map, if I 
read patch 2 & 3 correctly.

Meaning ignore prog->autoload*. Load the struct_ops prog as long as it is used 
by one struct_ops map with autocreate == true.

If the struct_ops prog is not used in any struct_ops map, the bpf prog cannot be 
loaded even the autoload is set. If bpf prog is used in a struct_ops map and its 
autoload is set to false, the struct_ops map will be in broken state. Thus, 
prog->autoload does not fit very well with struct_ops prog and may as well 
depend on whether the struct_ops prog is used by a struct_ops map alone?


