Return-Path: <bpf+bounces-67832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C87B49F33
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055A83B1947
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F392472A2;
	Tue,  9 Sep 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whySG11x"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4362BB1D
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384782; cv=none; b=Wh7sw6LICdveVQw/6/RdTWWI+0R4X8PLFjjKn/dah8nAxRXNNeU17s/cD8jvib1qUKt6qKmw4IGQuyrIaGTGXmZGbjyDyRHWWvndW5MRn1xfs4Qu4B3J+zJJoD+Sm+xAcp7KH6o5txlrZEyXucCIjotXk+HS7r6+r4EBV9aldAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384782; c=relaxed/simple;
	bh=7ceXi8e8xvm+rPcBXROXUk+f7eqQkXG3Aw43Am9Dtbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxFd9mcjln2MtXaiGdsq0DOoFGOH9Sem+4seX4MeSdKWicSOQY13WJzS/qj30ZofTw27754b9GzUaGlQU82fmuVg63rgDWRVjIaL1cgI0dgS+CUDgPAVS/srXGmu3P6Mt2BOy++aVN0bdKdmzsokeXV6a4TDIUP9W4NB8Di76bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whySG11x; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa3705fc-e7f2-403a-a969-30ae3e37b71d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757384777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQGcWX19S2zaromNcOoMBr7y/4pB/8gt6PElZLj1rAc=;
	b=whySG11xeD17aAQOQUlF03idoSHYwfPfzUX557ddlSDBBAQJ1cWPstEz/SIgdQk3Yxo5e8
	+FjWdSsZq4ha5CyUnts72IK7aeDgjwyPo1s8sBT/3ekwYkyxxQH2daRzbZF0nG0gdriWm7
	Xie0hsvlDmim1b13lqhngl9m9bM33KY=
Date: Tue, 9 Sep 2025 10:26:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Introduce internal
 bpf_map_check_op_flags helper function
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 kernel-patches-bot@fb.com
References: <20250908143644.30993-1-leon.hwang@linux.dev>
 <20250908143644.30993-3-leon.hwang@linux.dev>
 <CAADnVQ+iyKQAPAEAFhS-cgfRZyTorgiV57QTBdQiUengx2y2kA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+iyKQAPAEAFhS-cgfRZyTorgiV57QTBdQiUengx2y2kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/9/25 01:36, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> It is to unify map flags checking for lookup_elem, update_elem,
>> lookup_batch and update_batch APIs.
>>
>> Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
>> flags in it for these APIs in next patch.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h  | 31 +++++++++++++++++++++++++++++++
>>  kernel/bpf/syscall.c | 34 +++++++++++-----------------------
>>  2 files changed, 42 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ce523a49dc20c..55c98c7d52510 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3735,4 +3735,35 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
>>                            const char **linep, int *nump);
>>  struct bpf_prog *bpf_prog_find_from_stack(void);
>>
>> +static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
>> +{
>> +       if (flags & ~allowed_flags)
>> +               return -EINVAL;
>> +
>> +       if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 flags)
>> +{
>> +       return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
>> +}
>> +
>> +static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 flags)
>> +{
>> +       return bpf_map_check_op_flags(map, flags, ~0);
>> +}
>> +
>> +static inline int bpf_map_check_lookup_batch_flags(struct bpf_map *map, u64 flags)
>> +{
>> +       return bpf_map_check_lookup_flags(map, flags);
>> +}
>> +
>> +static inline int bpf_map_check_update_batch_flags(struct bpf_map *map, u64 flags)
>> +{
>> +       return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
>> +}
> 
> I don't like these pointless wrappers.
> They make the code less readable.

Thanks for the feedback.

My intent was to keep the helpers close in style to
bpf_map_check_op_flags(), so that lookup/update (single or batch) would
follow a consistent pattern. This way it’s easier to see the relation
between map ops and their corresponding flag checks.

That said, I understand your point about readability. I will drop these
wrappers and just call bpf_map_check_op_flags() directly at each site.

Thanks,
Leon


