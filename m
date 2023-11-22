Return-Path: <bpf+bounces-15656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E688E7F49DD
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE472816ED
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDE4F1F0;
	Wed, 22 Nov 2023 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ggbTFtNX"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465119D
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I5BWnSUkW9fyrxM8pjZTp4+ROeNTIbCuYeIeGxRxe4o=; b=ggbTFtNXx3I3uTQJh84lfanK6I
	6gxazLjBhwtT5vGs9BAIQDhhTJMW0Z3XHxSPrT5dMxJieiOXZZHWOZ9/7TZ8+wOGKOPelZIkLX/KL
	FNSV8eQlG7tMtc1CTuqNLTY61/squKsctKs/Bn6Li96iKMlZMKHZfNx/R5wOK5noYcY/Tv5GbBz0/
	lWtqWSKDmPb4wKkRMSWx85w5jZ6KjsQJR20dUe8aHb1uT/TtezMAuJNTd9Wu2L0hj40Rv9p72JpTo
	UWpA/WMUm97bq6iceJhvWkvSW8ujjsNkP9t/1CA+JlkuCsQcJf/HsDkIbvPPjWBeOMlxqMNWEYTeA
	Pcjrk7wQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5oow-000A2t-K6; Wed, 22 Nov 2023 16:07:18 +0100
Received: from [178.197.248.19] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5oow-000SFq-0Q; Wed, 22 Nov 2023 16:07:18 +0100
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from
 idr
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20231114045453.1816995-1-sdf@google.com>
 <20231114045453.1816995-3-sdf@google.com>
 <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
Date: Wed, 22 Nov 2023 16:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27101/Wed Nov 22 09:40:55 2023)

On 11/21/23 10:03 PM, Martin KaFai Lau wrote:
> On 11/13/23 8:54 PM, Stanislav Fomichev wrote:
>> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
>> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
>> idr when the offloaded/bound netdev goes away. I was supposed to
>> take a look and check in [0], but apparently I did not.
>>
>> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
>> stale ids for the programs that have a dead netdev. This functionality
> 
> What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
> e.g. If the prog is pinned somewhere, it may be useful to know a prog is still loaded in the system.

Wouldn't this strictly speaking provide an invalid id (== 0) upon unload
back to audit - see the bpf_audit_prog(prog, BPF_AUDIT_UNLOAD) call location?

> Does the fixes mean to be for the bpf tree instead?

+1 given syzbot report, I'll take the first one in for now.

>> is verified by test_offload.py, but we don't run this test in the CI.
>>
>> Introduce new bpf_prog_remove_from_idr which takes care of correctly
>> dealing with potential double idr_remove() via separate skip_idr_remove
>> flag in the aux.
>>
>> Verified by running the test manually:
>> test_offload.py: OK
>>
>> 0: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
>>
>> Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> ---
>>   include/linux/bpf.h  |  2 ++
>>   kernel/bpf/offload.c |  3 +++
>>   kernel/bpf/syscall.c | 15 +++++++++++----
>>   3 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4001d11be151..d2aa4b59bf1e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>>       bool xdp_has_frags;
>>       bool exception_cb;
>>       bool exception_boundary;
>> +    bool skip_idr_remove;
>>       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>>       const struct btf_type *attach_func_proto;
>>       /* function name for valid attach_btf_id */
>> @@ -2049,6 +2050,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
>>   struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>>   void bpf_prog_put(struct bpf_prog *prog);
>> +void bpf_prog_remove_from_idr(struct bpf_prog *prog);
>>   void bpf_prog_free_id(struct bpf_prog *prog);
>>   void bpf_map_free_id(struct bpf_map *map);
> 
> 


