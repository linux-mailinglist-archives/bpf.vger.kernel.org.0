Return-Path: <bpf+bounces-67361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C1B42D9D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB105436EF
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191812F3626;
	Wed,  3 Sep 2025 23:46:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268B2EDD7B;
	Wed,  3 Sep 2025 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943200; cv=none; b=jEqe2hiddju0oPnnfhK07zjdV9dTJ3WR8OHfmQ4+Q0MKSlqijimPTeujJQihsK8b6CScuFZtMZAef52dv5E8Fr/T8LpjBCqL/+wSkTsATnIT6ozXXb/8W5Ku9Eof7JL2wOtWqInd+Dduv3EXEmxfMSsTSfV1i1FB1US6GlYssq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943200; c=relaxed/simple;
	bh=PbiWrU9LSgDNN6hw78WuHZF57rYOoLXBXjOFZ60I3hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9aOF2OaJahc8f6WkmSqx4efiSaHnZCHsVKvotH4U2YxY/dMCf7OxGiABZXaR6OoZAyV56tA4oydEEXYqy3u0RAKHfvydF7LJUQbi4F8k6Am9oo2FTnkQv38dtSRt/xy6JNPumulYHz9G4Eynkwf41MSY83Yf9LgRfsgz/LEkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9] (unknown [IPv6:2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B201540A48;
	Wed,  3 Sep 2025 23:46:36 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <c685b0d4-e458-45d2-92e1-ac6286770427@arnaud-lcm.com>
Date: Thu, 4 Sep 2025 01:46:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20250903135222.97604-1-contact@arnaud-lcm.com>
 <CAADnVQLf0wj9hV=tAA=p_GXgpQ6DxtB4heoDqTmb5dEc5P6zfg@mail.gmail.com>
 <d6223a4c-3e24-464f-893b-6bef57b973b8@arnaud-lcm.com>
 <CAADnVQL5Ms+3N9CYK=YTCMfWYfd=BEzXNggB2Sg+i_obVfUb8g@mail.gmail.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAADnVQL5Ms+3N9CYK=YTCMfWYfd=BEzXNggB2Sg+i_obVfUb8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175694319738.13630.16050119855746174230@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 03/09/2025 18:22, Alexei Starovoitov wrote:
> On Wed, Sep 3, 2025 at 9:20 AM Lecomte, Arnaud <contact@arnaud-lcm.com> wrote:
>>
>> On 03/09/2025 18:12, Alexei Starovoitov wrote:
>>> On Wed, Sep 3, 2025 at 6:52 AM Arnaud Lecomte <contact@arnaud-lcm.com> wrote:
>>>> A new helper function stack_map_calculate_max_depth() that
>>>> computes the max depth for a stackmap.
>>>>
>>>> Changes in v2:
>>>>    - Removed the checking 'map_size % map_elem_size' from
>>>>      stack_map_calculate_max_depth
>>>>    - Changed stack_map_calculate_max_depth params name to be more generic
>>>>
>>>> Changes in v3:
>>>>    - Changed map size param to size in max depth helper
>>>>
>>>> Changes in v4:
>>>>    - Fixed indentation in max depth helper for args
>>>>
>>>> Changes in v5:
>>>>    - Bound back trace_nr to num_elem in __bpf_get_stack
>>>>    - Make a copy of sysctl_perf_event_max_stack
>>>>      in stack_map_calculate_max_depth
>>>>
>>>> Changes in v6:
>>>>    - Restrained max_depth computation only when required
>>>>    - Additional cleanup from Song in __bpf_get_stack
>>> This is not a refactor anymore.
>>> Pls don't squash different things into one patch.
>>> Keep refactor as patch 1, and another cleanup as patch 2.
>> The main problem is that patch 2 is not a cleanup too. It is a bug fix
>> so it doesn't really
>> fit either.
>> We could maybe split this patch into 2 new patches but I don't really
>> like this idea.
>> If we decide to stick to 2 patches format, I don't have any preference
>> which patch's scope
>> should be extended.
> I wasn't proposing to squash cleanup into patch 2.
> Make 3 patches where each one is doing one thing.
I've sent it: 
https://lore.kernel.org/all/20250903233910.29431-1-contact@arnaud-lcm.com/
Thanks !
Arnaud
>

