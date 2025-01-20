Return-Path: <bpf+bounces-49286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7EA16875
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABAA1669D4
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0A196DB1;
	Mon, 20 Jan 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCrifiuM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E0194C92
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363170; cv=none; b=aCu8LCw1bDtT5P5/tDJ98WAg9seOnkvL3Es45olUVKuZjkYrKwFQmACv5o/RGjL/2hwtAdcDIm7/HiJL65Z2DyoXBKfG4EZCxLQ4/NngW3Cnd+VB//qu7X2GljV7XLafza0JgAZO1tIWKf13sSt7gSjl6ncpSD15Zwk96Ia7w7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363170; c=relaxed/simple;
	bh=hU5s+Arm7fbJH7RbRefc9VHIoxZB77Oh7XHJUy/TTFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTghuuxCH3ytVL3OX62VuTScIkR9TMYItHSEm58HM1LNJC/l+37qZ+/ecjRt382jwR9fF4s+4CGT9oUICpgVR8aAjUY3tdRwT+LrdQvFJpSA5lrU1xYkFod+AFPeXU7Nou+tfKbeQl8VnMr1GEX7p+zZ3LOFXMdv4eCRYONTGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCrifiuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418ACC4CEDD;
	Mon, 20 Jan 2025 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737363169;
	bh=hU5s+Arm7fbJH7RbRefc9VHIoxZB77Oh7XHJUy/TTFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eCrifiuMFifM96YjEHY4VXzoVzlqcDs+7nbeCuoLwZUoUblapDU3GJZ4FpMZoBZxh
	 dfdE4VtWqI4g2LIDH9b+CS26RTWn1Sk2pYXG8ti4JD2SYditwOCCCTMcWOPwkyN0eK
	 qBvez4f/q8pFs/bkLc/PSt4MKOHMY/hF1U4bpL/aDAafY5bs7Pknsch68ZRgNnB5Wq
	 S9EBXRxTt2E+cfghvtC/HaGGThCUMAT7K4XNmd6tjeEu14CdeQ0qhsWstlbFKokZxg
	 iLi9oWGqSy98WxCBNgv24w8LTss1B8FxX8FpWwuTiciQlpygzeznYeWSDUgDxcMTQg
	 nqq7SqXHgepzQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AB5FE17E7BA9; Mon, 20 Jan 2025 09:52:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Free element after unlock in
 __htab_map_lookup_and_delete_elem()
In-Reply-To: <96a1e15a-52d8-acee-aee8-f494f009d2d7@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-4-houtao@huaweicloud.com> <87o705oby2.fsf@toke.dk>
 <96a1e15a-52d8-acee-aee8-f494f009d2d7@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 20 Jan 2025 09:52:36 +0100
Message-ID: <87v7u9n9yj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> Hi,
>
> On 1/17/2025 8:35 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hou Tao <houtao@huaweicloud.com> writes:
>>
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> The freeing of special fields in map value may acquire a spin-lock
>>> (e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
>>> procedure has already held a raw-spin-lock, which violates the lockdep
>>> rule.
>> This implies that we're fixing a locking violation here? Does this need
>> a Fixes tag?
>>
>> -Toke
>
> Ah, the fix tag is a bit hard. The lockdep violation in the patch is
> also related with PREEMPT_RT, however, the lookup_and_delete_elem is
> introduced in v5.14. Also considering that patch #4 will also fix the
> lockdep violation in the case, I prefer to not add a fix tag in the
> patch. Instead I will update the commit message for the patch to state
> that it will reduce the lock scope of bucket lock. What do you think ?

Sure; and maybe put the same explanation for why there's no Fixes tag
into the commit message as well? :)

-Toke

