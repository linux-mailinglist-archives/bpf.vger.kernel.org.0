Return-Path: <bpf+bounces-67314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E25B426BB
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF5A1BC194C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C2C11E7;
	Wed,  3 Sep 2025 16:20:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8F2C0F84;
	Wed,  3 Sep 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916452; cv=none; b=W+YauhkkzUcOcaMU9vfLSBlGtWT/2zQGuDhhPQGLrqukjUjDSBxA7I93qSFz8RGFWVXMA+8pLv6OOfiq/FADRDzxPd8YnpRlzuyykHbkvk5n4prEN+XCJMW1aZfYpIw6g2o6GXAyIVogFusOZgr8b/HtX/qWL05D3NkC36pT8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916452; c=relaxed/simple;
	bh=ZnRB4EwdJ/jWlEavv2nOKiEaG8gSjogEGr0gqtL1z6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1CbuPqvcaMiF5oJqfajCbovIVv/tHGQ4VMkFSzC62y7NugFRDooM/+Gq2kFsaXmSAopVQjUt6yGv1IpnMinx5yjtXy+DNmtocZL7h9WLkcXmJ13YQ1eDqTXmt918Z36SOGRj3CpieVVTx82/+TE5G3J4EOATY0JwEnZ3kKf5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4] (unknown [IPv6:2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id DEB72405ED;
	Wed,  3 Sep 2025 16:20:47 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <d6223a4c-3e24-464f-893b-6bef57b973b8@arnaud-lcm.com>
Date: Wed, 3 Sep 2025 18:20:43 +0200
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
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAADnVQLf0wj9hV=tAA=p_GXgpQ6DxtB4heoDqTmb5dEc5P6zfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175691644851.31690.7755485046338215656@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 03/09/2025 18:12, Alexei Starovoitov wrote:
> On Wed, Sep 3, 2025 at 6:52 AM Arnaud Lecomte <contact@arnaud-lcm.com> wrote:
>> A new helper function stack_map_calculate_max_depth() that
>> computes the max depth for a stackmap.
>>
>> Changes in v2:
>>   - Removed the checking 'map_size % map_elem_size' from
>>     stack_map_calculate_max_depth
>>   - Changed stack_map_calculate_max_depth params name to be more generic
>>
>> Changes in v3:
>>   - Changed map size param to size in max depth helper
>>
>> Changes in v4:
>>   - Fixed indentation in max depth helper for args
>>
>> Changes in v5:
>>   - Bound back trace_nr to num_elem in __bpf_get_stack
>>   - Make a copy of sysctl_perf_event_max_stack
>>     in stack_map_calculate_max_depth
>>
>> Changes in v6:
>>   - Restrained max_depth computation only when required
>>   - Additional cleanup from Song in __bpf_get_stack
> This is not a refactor anymore.
> Pls don't squash different things into one patch.
> Keep refactor as patch 1, and another cleanup as patch 2.

The main problem is that patch 2 is not a cleanup too. It is a bug fix 
so it doesn't really
fit either.
We could maybe split this patch into 2 new patches but I don't really 
like this idea.
If we decide to stick to 2 patches format, I don't have any preference 
which patch's scope
should be extended.

>
> pw-bot: cr
>

