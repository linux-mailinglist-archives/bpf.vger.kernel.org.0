Return-Path: <bpf+bounces-38814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35296A677
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB441C242A7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1319007E;
	Tue,  3 Sep 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="b0lVNKg8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6418FDD7
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388057; cv=none; b=q31QhG1BwgLhSeMt9H+wKQQaYMX/O5fnbO4OLzGTqNNgR/VGPkWkaXFc+eidnBtR0G6WbIefwlpfr6F+NW35PK4devCTjYk5K82rmnQBa/aDMOEfVyfHBWpLmY3mrJFB4Ps2S7acOZEGXjjq722ngg0U5voRzMk9dVubynQjMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388057; c=relaxed/simple;
	bh=NBM7PZil5KRew472tvQtI7KnH7V6tKEp8uC+RSJbVBk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UD1imIgYFx5XE0IVWF5lZaK7LQl37BkbaI9Le+n8BBREItUTEs9OLdPgmvk1CdG2SACxXSV+mcfBRob8myezSSzTBTVLZ8rGf6x2VqS7wteQK973XLfr6zu6/wAxGKvUK1G1wolcXWCz1ipljH3SgD07xZL8MFgi5IgPc/cBovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=b0lVNKg8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FCCkLjb1cCT5/ugFgoFdVZ4I9/h2EqV/qEepMCKNtnc=; b=b0lVNKg8PCZEx188LmhzfPG0rQ
	Rc+5ajXosZSnPIoUEflMzE9rWGA0VrtXm380ZY6w4bFCfDzRKu4unf2y80kqa7euwxxAKtttUEX1e
	U3i+JTirjr1ND85kXp046MImkMavwmuMPO8vGhL5N+q8onVeM8JJ3GRCghAna3dHL37pUigbYhb5z
	rPBPSfjNofigFq2/aEzedU8dWP4Mu1LuQgSauYdm0hEFXcASo0gQ49me2xi09WCjr3ol7HLg3zDGC
	tlZVGOWZOdRNgDCLtYlebMHWp8tu0bdfvpkeGZcvpjpDxXalZyJ5L2sVYOiVeUPZfJb4OYCUyMT7o
	Lwb6yjUA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1slYFS-000HZS-2x; Tue, 03 Sep 2024 20:27:25 +0200
Received: from [178.197.248.23] (helo=linux-2.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1slYFR-000IvJ-09;
	Tue, 03 Sep 2024 20:27:25 +0200
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, kafai@meta.com,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20240901213040.766724-1-yatsenko@meta.com>
 <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
 <CAEf4BzZ-_3AyvZN_0tbqYswax4Xx3fPrv_renMuxY_QLcNhcuQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e32f8b24-c7dd-9649-f92e-54d0b6453612@iogearbox.net>
Date: Tue, 3 Sep 2024 20:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ-_3AyvZN_0tbqYswax4Xx3fPrv_renMuxY_QLcNhcuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27387/Tue Sep  3 10:38:04 2024)

On 9/3/24 6:51 PM, Andrii Nakryiko wrote:
> On Mon, Sep 2, 2024 at 9:22 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 9/1/24 11:30 PM, "Mykyta Yatsenko mykyta.yatsenko5"@gmail.com wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Wrong function is used to access the first enum64 element.
>>> Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>    tools/bpf/bpftool/btf.c | 13 ++++++++++---
>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>>> index 6789c7a4d5ca..b0f12c511bb3 100644
>>> --- a/tools/bpf/bpftool/btf.c
>>> +++ b/tools/bpf/bpftool/btf.c
>>> @@ -557,16 +557,23 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>>>        const struct btf_type *t = btf__type_by_id(btf, index);
>>>
>>>        switch (btf_kind(t)) {
>>> -     case BTF_KIND_ENUM:
>>> -     case BTF_KIND_ENUM64: {
>>> +     case BTF_KIND_ENUM: {
>>>                int name_off = t->name_off;
>>>
>>>                /* Use name of the first element for anonymous enums if allowed */
>>> -             if (!from_ref && !t->name_off && btf_vlen(t))
>>> +             if (!from_ref && !name_off && btf_vlen(t))
>>>                        name_off = btf_enum(t)->name_off;
>>>
>>>                return btf__name_by_offset(btf, name_off);
>>>        }
>>
>> Small nit, could we consolidate the logic into the below? Still somewhat nicer
>> than duplicating all of the rest.
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 6789c7a4d5ca..aae6f5262c6a 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -562,8 +562,10 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>>                   int name_off = t->name_off;
>>
>>                   /* Use name of the first element for anonymous enums if allowed */
>> -               if (!from_ref && !t->name_off && btf_vlen(t))
>> -                       name_off = btf_enum(t)->name_off;
>> +               if (!from_ref && !name_off && btf_vlen(t))
>> +                       name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
> 
> Just fyi for the future (I don't think we need to fix this or anything
> like that), but using BTF_KIND_xxx constants in btf_kind(t)
> comparisons should be rare. Libbpf provides a full set of shorter
> btf_is_xxx(t) helpers for this. So this would be just
> `btf_is_enum64(t)`. What you did is not wrong, it's just more
> open-coded and verbose.

Noted, that would have been better agree.

Thanks,
Daniel

