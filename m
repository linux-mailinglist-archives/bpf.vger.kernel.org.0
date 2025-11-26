Return-Path: <bpf+bounces-75602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC7C8B6BA
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3A9D4E2D32
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEE31283D;
	Wed, 26 Nov 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBLIQ2D9"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C631282A
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181365; cv=none; b=ILbDlo2zA9QgBNyL4xcoRfQoSqGFFInw/YdbMQfcLOO4YQjCIkiQMo2cw5gINpLpt2SNtgWx1GwxdtRiFLcB6++8fl9sG4glc/2cM7RVCTJWVlZMHQBBSa8oYD3kF770+7RFkuJuuCoaL+emOqhyU6e+I9AAjysD+LghRQS0bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181365; c=relaxed/simple;
	bh=11+n6ED0oj4GlVfro7776FjNWhcM74GpNCK3Tx4RzU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtmZG77nciG9fGw10TVJhW7pajAHr15MBtOkS2Oi7qsej5ZheVWmvnbksdO0+83pWktSWm5Jxro2g8scR2kxhFPJ4mKI5/fNFkWQWyigitL7TiJK5WbIMb3LwdzAfK9QhKzlUUWSiJvxisYzT0sFJxEWnwnlQwI6gTYnTeBMWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBLIQ2D9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <102a3220-2490-4c81-b2c9-6b107d6e4aff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764181351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5lnVEmMjTQunScWht2/TigkN5EtXsb7CslpuxT4iIY=;
	b=kBLIQ2D9+46RfxQscZxA2XbmkNw2KlF45o/VXrEzwlTmpM/33kdUcRiUsJBdDj4WKBihIA
	5060+ffqWI7XBRJMtqScZzGWXxvPTLBi0saW50GcRGyBtl4CVkGy8IZij/jN1OID6IS8WJ
	lg1zYeyciryXqWZaKfJnBXABvuxWlXI=
Date: Wed, 26 Nov 2025 10:22:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
 <20251126012656.3546071-5-ihor.solodrai@linux.dev>
 <CAErzpmvaHxLdooTsHt=YKbz9NDw+LXB8462kRrkzbdp-zJ-=2Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmvaHxLdooTsHt=YKbz9NDw+LXB8462kRrkzbdp-zJ-=2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/25/25 8:46 PM, Donglin Peng wrote:
> On Wed, Nov 26, 2025 at 9:29 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>> +
>> +gen_btf_data()
>> +{
>> +       info BTF "${ELF_FILE}"
>> +       btf1="${ELF_FILE}.btf.1"
>> +       ${PAHOLE} -J ${PAHOLE_FLAGS}                    \
>> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
>> +               --btf_encode_detached=${btf1}           \
>> +               "${ELF_FILE}"
>> +
>> +       info BTFIDS "${ELF_FILE}"
>> +       RESOLVE_BTFIDS_OPTS=""
>> +       if is_enabled CONFIG_WERROR; then
>> +               RESOLVE_BTFIDS_OPTS+=" --fatal_warnings "
> 
> In POSIX sh, +=is undefined[1], and I encountered the following error:
> 
> ./scripts/gen-btf.sh: 90: RESOLVE_BTFIDS_OPTS+= --fatal_warnings : not found
> 
> We should use the following syntax instead:
> 
> RESOLVE_BTFIDS_OPTS="${RESOLVE_BTFIDS_OPTS} --fatal_warnings "

Hi Donglin, thanks for taking a look.

These and a couple of other bugs have been caught by CI [1].
I am working on v2.

I changed the script to #!/bin/bash and will run the shellcheck 
before submitting the next revision [2], when it's ready.

[1] https://github.com/kernel-patches/bpf/actions/runs/19689674975
[2] https://github.com/kernel-patches/bpf/pull/10370

> 
> [1] https://www.shellcheck.net/wiki/SC3024
> 
> Thanks,
> Donglin
>> [...]



