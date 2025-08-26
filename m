Return-Path: <bpf+bounces-66552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E42B36DAE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F63A1773B9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72484393DD1;
	Tue, 26 Aug 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7maWYtz"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260422727F9
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221907; cv=none; b=guRZpNRRhllmjHFKCNY0xHKtzdNCAJkDXkdF8Pi4tb4SZ/dhMj8p6CR+ukyK3Kusg1tgMA7jkOPdt9RRwtMU5rP4P9WXYzNOGb937k1/NdOe7JZAGvtbD3y+9tcDI4jdFZY9294sBs63aKRCdk7rAJ7vxYjKjz6bMPRcClkkzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221907; c=relaxed/simple;
	bh=xkvO5pEW2OMu8EnrbFU/CunlJcaGW2ymhEgVDzXw3v0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=XKZo0VAypcV/Ni2kQ5HU5kPzQIfQu2bge0KH+K+S6/4x2V62J4WFRv4WxtKjo4xEtmnY1hkTgM2fhIbq5Vgnc+0pkb3yS26hoxhKqF7QCPseDSwcCwesxykGQg5/Lnq0Vxii/wm58qm4Byo3No79yh+owB/JfoXrNChrtQvRMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7maWYtz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756221900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AL8E3uRzhisTP0Jtc993Z7VwXa8QOiT8PRTN9loSOO4=;
	b=T7maWYtzndCJaENx5/vAlGVj2ppJZuWdi1avNZQkcDjoaFG5nK6wysXfNwkOd1ocmAevDd
	AZNLtQvfu7qLWLs3EDU7sCOc6bbhQ3Ec2rK84gjXwAJIigZ3zQtECEwnrlEiO2CsncG0B7
	KnfdlAXR/H6bq/tVB0UplUXoGp7NuIY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 23:24:50 +0800
Message-Id: <DCCGPAPLTR3C.2CXCTTKA7W0A0@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Introduce internal check_map_flags
 helper function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <olsajiri@gmail.com>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
References: <20250821160817.70285-1-leon.hwang@linux.dev>
 <20250821160817.70285-2-leon.hwang@linux.dev>
 <CAEf4Bzbku_8oNkB5VmrNPNnWg6h5YVPTP2WTMgYcrbfwpzSUoA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbku_8oNkB5VmrNPNnWg6h5YVPTP2WTMgYcrbfwpzSUoA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Aug 23, 2025 at 6:14 AM +08, Andrii Nakryiko wrote:
> On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> It is to unify map flags checking for lookup, update, lookup_batch and
>> update_batch.
>>
>> Therefore, it will be convenient to check BPF_F_CPU flag in this helper
>> function for them in next patch.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/syscall.c | 45 ++++++++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0fbfa8532c392..19f7f5de5e7dc 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1654,6 +1654,17 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 k=
ey_size)
>>         return NULL;
>>  }
>>
>> +static int check_map_flags(struct bpf_map *map, u64 flags, bool check_f=
lag)
>
> "check_map_flags" is super generically named... (and actually
> misleading, it's not map flags you are checking), so I think it should
> be something along the lines of "check_map_op_flag", i.e. map
> *operation* flag?
>
> but also check_flag bool argument name for a function called "check
> flags" is so confusing... The idea here is whether we should enforce
> there is no *extra* flags beyond those common for all operations,
> right? So maybe call it "allow_extra_flags" or alternatively
> "strict_extra_flags", something suggesting that his is something in
> addition to common flags
>
> alternatively, and perhaps best of all, I'd move that particular check
> outside and just maintain something like ARRAY_CREATE_FLAG_MASK for
> each operation, checking it explicitly where appropriate. WDYT?
>

Ack.

Following this idea, the checking functions will be

static inline bool bpf_map_check_op_flags(struct bpf_map *map, u64 flags, b=
ool strict_extra_flags,
                                          u64 extra_flags_mask)
{
        if (strict_extra_flags && ((u32)flags & extra_flags_mask))
                return -EINVAL;

        if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_=
SPIN_LOCK))
                return -EINVAL;

        if (!(flags & BPF_F_CPU) && flags >> 32)
                return -EINVAL;

        if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_supports_cpu=
_flags(map->map_type))
                return -EINVAL;

        return 0;
}

#define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~(BPF_F_LOCK | BPF_F_CPU | BP=
F_F_ALL_CPUS))

static inline bool bpf_map_check_update_flags(struct bpf_map *map, u64 flag=
s)
{
        return bpf_map_check_op_flags(map, flags, false, 0);
}

static inline bool bpf_map_check_lookup_flags(struct bpf_map *map, u64 flag=
s)
{
        return bpf_map_check_op_flags(map, flags, true, BPF_MAP_LOOKUP_ELEM=
_EXTRA_FLAGS_MASK);
}

static inline bool bpf_map_check_batch_flags(struct bpf_map *map, u64 flags=
)
{
        return bpf_map_check_op_flags(map, flags, true, BPF_MAP_LOOKUP_ELEM=
_EXTRA_FLAGS_MASK);
}

These functions are better than check_map_flags().

Thanks,
Leon

> pw-bot: cr
>
> [...]

