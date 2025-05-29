Return-Path: <bpf+bounces-59233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BFAC75EE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A6A22036
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89C245027;
	Thu, 29 May 2025 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KjBCH0K2"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C92036E9
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748486647; cv=none; b=WWmAqydX1Tx9TD0cjGgOiPWz9llb36pPqcoN5kx4TH84wZfYTSYLyffiPynh7Cb0jz91hMsjjuxFDpVZuGUmF+KJygUV3lExg5FIN6KWq1s90hyNioTs3nAA74tXoYXTzCIrdDry5uuyN+003jJIMH2nKYIykGffd9fYQ75YUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748486647; c=relaxed/simple;
	bh=8TkDTVNdaw0MkrAaLVwVsam8HXnsBb9uFOKt1LNnfds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFxWaO7RjVdv/X7cHX8SuW8qhCuCWgqwSwQx1urEkC/gabxAZpc+HedApyCkodcf2XfO+UclINjrfUUPif4m4es0jUUPRAUMiRr/7JbyOSIas5HQjMKKc+d4atA0+LobBqQnjRrgTXusY+d03xOMq9kvnEyJpn1gTUVanQOBgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KjBCH0K2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6f9ca33-977f-4486-9d62-8f497858764b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748486642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RovtsedpknBNUAkP4oL2A6H3JDKL8FQbb9lQWktcYfc=;
	b=KjBCH0K20kWk/VoIvwCCL+ospWVAqXYENHO79us9iyYuAeKP8KjXGKEeGvV63dvWdv2jJg
	rfPFgfuZVs3RY9ig8zge1/XHNbNPlwuGZ6SA3wK5fWEgNc3H9Y1vWKaOUZsKNsrdkxcFD0
	skUv/vYyElycTjLXrqSupWvLqe7rofQ=
Date: Thu, 29 May 2025 10:43:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
 <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
 <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
 <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 29/5/25 00:05, Andrii Nakryiko wrote:
> On Tue, May 27, 2025 at 7:35 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>

[...]

>>
>> I guess this can be a follow up.
>> With extra flag lookup/update/delete can look into a new field
>> in that anonymous struct:
>>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and
>> BPF_MAP_FREEZE commands */
>>                 __u32           map_fd;
>>                 __aligned_u64   key;
>>                 union {
>>                         __aligned_u64 value;
>>                         __aligned_u64 next_key;
>>                 };
>>                 __u64           flags;
>>         };
>>
> 
> Yep, we'd have two flags: one for "apply across all CPUs", and another
> meaning "apply for specified CPU" + new CPU number field. Or the same
> flag with a special CPU number value (0xffffffff?).
> 
>> There is also "batch" version of lookup/update/delete.
>> They probably will need to be extended as well for consistency ?
>> So I'd only go with the "use data to update all CPUs" flag for now.
> 
> Agreed. But also looking at generic_map_update_batch() it seems like
> it just routes everything through single-element updates, so it
> shouldn't be hard to add batch support for all this either.

Regarding BPF_MAP_UPDATE_{ELEM,BATCH} support for percpu_array maps —
would it make sense to split the flags field as [cpu | flags]?

When the BPF_F_PERCPU_DATA flag is set, the value could be applied
either across all CPUs if the cpu is 0xffffffff, or to a specific CPU
otherwise.

Thanks,
Leon



