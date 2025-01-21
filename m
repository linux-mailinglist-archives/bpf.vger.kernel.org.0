Return-Path: <bpf+bounces-49361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC6A17C98
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1051884D85
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1531F1319;
	Tue, 21 Jan 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdICfmCo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2B1F130B
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457488; cv=none; b=qei/D3AxmYhvKi09mG6ZvivOzmyX9hJ0i04WhqDct/lXh3fFgRvFME9Rm+EpV4nY4WNa+JgignC0x/DB5/VRJyhrqDdqzZdZGXq5VkR0ftX228u1aPK23WsV2mwQZXuIMtU0XX4iz3d5UQGRui1Ymqv5DYXpTu4wKFdbPHinTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457488; c=relaxed/simple;
	bh=zaYI7jVZFfkK1htnddSzUP/aD0l1LWqbCgydYjLeAXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXI2v59936xA/5i+f5XEMWSNCIMZUlBaEh4owL0zmXZlkAKGCU6LblbwNmONqdo+46i8FlUgkaQwoSYTkL5Ax3rxclIQZMd6nA0PRlDJiKPAsd2x4F4mmeS2xQ8+FC5Fa65wjXe0H2OroRvTfOSor5l7qHWREmJQbpZAyNs1kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdICfmCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339DBC4CEDF;
	Tue, 21 Jan 2025 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737457487;
	bh=zaYI7jVZFfkK1htnddSzUP/aD0l1LWqbCgydYjLeAXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UdICfmCoiOzI1HKmwkxvlACAQlRAeoHWIGqqC9Cs7dG667C5sysvOId+L5a4IWzeo
	 Z9K+VOAkj2kTiYBPr/Kfpr86vTAKu2jR5VZHuVJIYvJ72jqYlgXUnxuOEvU0OhyMnM
	 Q7djKCd+ReEbqEybn/ui2ZH5AJhNw+g/JuSCHTIVL2uhiLbZ+Ag1gn9qzG01hOQr/P
	 FWeyBsVaUgTKhajw19HjDN5kZCOiz0jOsmxbEUdQzwHgcur+g7xvNRK2us8DiJrSXx
	 i9+xzOGQuWn8rf2wDk2Sq2zNNnxl8qQf+6Hz3SGficpuluW9wCq0pTfwvaImtjcVqL
	 pLPMUAQMhqGOQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2470A17E7DCA; Tue, 21 Jan 2025 12:04:33 +0100 (CET)
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
In-Reply-To: <cc432722-41e7-22a1-cb31-706e24164f5d@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-4-houtao@huaweicloud.com> <87o705oby2.fsf@toke.dk>
 <96a1e15a-52d8-acee-aee8-f494f009d2d7@huaweicloud.com>
 <87v7u9n9yj.fsf@toke.dk>
 <cc432722-41e7-22a1-cb31-706e24164f5d@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 21 Jan 2025 12:04:33 +0100
Message-ID: <87tt9sl96m.fsf@toke.dk>
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
> On 1/20/2025 4:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hou Tao <houtao@huaweicloud.com> writes:
>>
>>> Hi,
>>>
>>> On 1/17/2025 8:35 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> The freeing of special fields in map value may acquire a spin-lock
>>>>> (e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
>>>>> procedure has already held a raw-spin-lock, which violates the lockdep
>>>>> rule.
>>>> This implies that we're fixing a locking violation here? Does this need
>>>> a Fixes tag?
>>>>
>>>> -Toke
>>> Ah, the fix tag is a bit hard. The lockdep violation in the patch is
>>> also related with PREEMPT_RT, however, the lookup_and_delete_elem is
>>> introduced in v5.14. Also considering that patch #4 will also fix the
>>> lockdep violation in the case, I prefer to not add a fix tag in the
>>> patch. Instead I will update the commit message for the patch to state
>>> that it will reduce the lock scope of bucket lock. What do you think ?
>> Sure; and maybe put the same explanation for why there's no Fixes tag
>> into the commit message as well? :)
>
> I have rewritten the commit message for the patch and it is ready for
> resend. However it seems Alexei has already merged this patch set [1],
> therefore, I will keep it as is.

Ah well; thanks anyway! :)

-Toke

