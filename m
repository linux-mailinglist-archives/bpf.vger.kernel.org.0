Return-Path: <bpf+bounces-15713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E727F53BB
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905A52815B6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3461D52F;
	Wed, 22 Nov 2023 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QHIu78eq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028E92
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CWOQLuVDOvjEZTOm6Iwjk8kiQDnUdG2I08ZE5DN4K+U=; b=QHIu78eq0kcbJruViOjA1g9a7G
	qOW89TCgegEoBQV+bC2uehoJ7zoJ2cC1J9OlvtoB95ZaWy2DHmZhdM4AbHyj0T00bampJeGnG4YXy
	hQs/CVr2o88/qFVORifISUmKwxwoAWlqZhlnDvsjPRAu9RHoKGX/bcc6Zj5d8CkqxzLW8MfrzbGIp
	Drly69ySdhQ7T55NBwu5Mzae5uMnTOZbbGsGu34GhW/HPdYvsYecpPcx8bo41jpCpMwMDMEzvs1PV
	Sus8f74E5h6omOfii6p/nbWsYypJ9Q6sKJdp74+GLMSjnnMAzRLOu74ssObDzecjBZgP05Ip3PfsO
	lz+wDsng==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5w6e-000Dx0-Q8; Wed, 22 Nov 2023 23:54:04 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5w6e-000RzK-45; Wed, 22 Nov 2023 23:54:04 +0100
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from
 idr
To: Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20231114045453.1816995-1-sdf@google.com>
 <20231114045453.1816995-3-sdf@google.com>
 <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev>
 <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
 <ZV5C7099HylvusQO@google.com>
 <20c42052-8cb7-4b8b-a7f8-d9311e37479d@linux.dev>
 <CAKH8qBuk=+1Xr6wM3N50SJW5QS3Kv-Vnq2z1dncHoVqL9DvNVQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <634ca45b-b613-dff4-0cde-25d2610adf2f@iogearbox.net>
Date: Wed, 22 Nov 2023 23:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKH8qBuk=+1Xr6wM3N50SJW5QS3Kv-Vnq2z1dncHoVqL9DvNVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27101/Wed Nov 22 09:40:55 2023)

On 11/22/23 11:41 PM, Stanislav Fomichev wrote:
> On Wed, Nov 22, 2023 at 10:40 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 11/22/23 10:05 AM, Stanislav Fomichev wrote:
>>>>>> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
>>>>>> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
>>>>>> idr when the offloaded/bound netdev goes away. I was supposed to
>>>>>> take a look and check in [0], but apparently I did not.
>>>>>>
>>>>>> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
>>>>>> stale ids for the programs that have a dead netdev. This functionality
>>>>>
>>>>> What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
>>>>> e.g. If the prog is pinned somewhere, it may be useful to know a prog is still loaded in the system.
>>>
>>> bpftool is a bit spooked by those prog ids currently: calling GET_INFO_BY_ID
>>> on those programs returns ENODEV. So we can keep those ids around, but
>>> need some tweaks on the bpftool in this case. LMK if any of you prefer
>>> this option.
>>
>> I think it is in general useful to improve 'bpftool prog show' to keep going for
>> the next prog id if possible. May be print an error message after the prog id
>> and then keep going for the next prog id?
> 
> Replied with a v2 where I mark those progs as 'orphaned'!

Sg, we could perhaps do something similar for netdev detached links.

