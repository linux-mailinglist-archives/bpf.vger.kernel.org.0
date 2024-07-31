Return-Path: <bpf+bounces-36146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D6942FBC
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769DB1F228CC
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B21B0124;
	Wed, 31 Jul 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DaK8bdqR"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2044.outbound.protection.outlook.com [40.92.91.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8F1A7F73;
	Wed, 31 Jul 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431399; cv=fail; b=ohjGlV3z9dpVoDy5fsW9niD9CUfdEBA0cl75Zh30ri6EazAqMcEz2zD32ePn5dmnURgJQJrVo2VtQe2pdFuhdBGtbkgWS5VSRaUnzy6jEGUj+Eo9mVmdWpkIbZMbO8Y0q2Ej17jaKztRHxbcDWQ+MfAWe7X91k4CwhYjSrNqyvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431399; c=relaxed/simple;
	bh=FrqmvICJAYRL1u6r3VRFY3tatTT+PT77fp8hqRad4kw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPmDJm+S15C+zDH8TNq6qMYzzccDOBo7FLuTls0q7CgeWaV7f4Ot/OU6w1XtBa/xoIX934+4XCCOf5MK3Fv6hSZSbGmv8yDfD/aZ2mwX2IasfkSb2oXb6l9WVNIU2DQF+zNpUqwb/yiQ2t1MArKACKRnkYr37ocX/NJRWVIsFMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DaK8bdqR; arc=fail smtp.client-ip=40.92.91.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+xGKTVCuQsa4QFN6r3qhj0ipJ5fJWR9+TJoC46KE6BO2QVhOQpn9+OgjPo4FtiFDB3mhJ97KzABvE5oHP4YzTmH6x8JQL3DR+TYSxxjpwEn3sqtkAUvWOD9jhn3pChcuREBlOym33kIsYo/Rapt5qOF3z2iC2tfA/rYKEhtB+9F3zTSA7+Zdj4HVw3D522aS7BnWbjzLc8M1RzRT2n54o0twqC65EPxrOAilgGC2IcfqYN7tniKq+LRwKc4HVFcmgK9LMBHJQ7Duxj1Ymln9YNxlQwXhXkV3+i73+eJ76cL7u8btuEhnvBqOfHzaz51rQjojBmxYGr+G9PSdLegjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7k6x58HlQtTxnkXHpZvJhNcZG2zOcBTIeo04nfI180=;
 b=y113ERM/eaFLZk1IAYh8CyrMwmJ8dhPtE/73o0WiWVpIeJcEDOIBqlRTHOwkimc2drQMuHI8GMS3Ps8J9ca8jl4Ow/rPWAud+iB1ovJmDdSBZ2Idi8Vgc+FdTvqB4K9TGwb4IziFn3F2/g8hr1cB1w+YcVb7j58MEZ0vgvQiZgNXF1CEakNJbCgoXbB/oAxMFXOswFmN7JQRWz2Ugb7NmmlGhxu2I5aBL3HFqNB5ZlM6z2cGo6NU2MbtpvjFVZe26+6gPeOk4R4tYy1XX9n8D5Cqcm6FbWsp6J11Sj+Zm0lbvgbBNzVVjPPu6WCXReQaUoz6NbV78fqmpuNf/Rx99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7k6x58HlQtTxnkXHpZvJhNcZG2zOcBTIeo04nfI180=;
 b=DaK8bdqR1rONTkVo5T7LXQdcb4/Wiaz2bjprpegMeEBWmN6nTIxG8SgbEeGq0QWU2eNyTceVngmy80DWNjGUH/f97bzOZQ0Ef7a32X9yP34lXpU6vshpstZBQmnbzaFqzMUQDSmve/5EO2HjuSfymHJQ1pQR6hSiZXtZisTW+XiNMZkw2JRntTItX29ZTmbQ946jiFhWxjHXe7tZNr2Fq+Xh1NdkUvHYWnjx9TQitEYOo7fuLJwuwQys+8I7zV35otmeB/3uLBbgx+aphFAGdGTfmhv4curNXp+YOx5dPg6rXpebImBVbpfTM1svsygFkQoZmiJx5gcZNvL4GR9Y1Q==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAXPR03MB7531.eurprd03.prod.outlook.com (2603:10a6:102:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Wed, 31 Jul
 2024 13:09:54 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:09:54 +0000
Message-ID:
 <AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 31 Jul 2024 14:09:02 +0100
User-Agent: Mozilla Thunderbird
From: Juntong Deng <juntong.deng@outlook.com>
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF
 (CRIB)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com,
 snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
Content-Language: en-US
In-Reply-To: <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [+ml/5GABGJ6H/biiFv+286PCryDUafOQ]
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <21b665bf-f898-448d-8bae-89d3999f7bf4@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAXPR03MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df438fe-32eb-4d11-1f6f-08dcb16210e7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	kEWd46blC1Kw80bmZE+AhaBq2iu2iI/ES5EiHXZBcP71cjOGsqZXlC8i6o43GrckbGXHaxkSqUterOdDC4joDdeY8EEiOfKM2W94vbYFQOvsK7jRIQhP2LWYTGiLXVPGP/Me0sYcQoM8bbSKHBAoQdYiQOTS7jOawlc/9wPxT5XQKO7XyqPz2MPrn5gwrEFMpPy3Qag1s1eCQ/wxkab5VWC9LmNaxtC6Ecj4Db1d2eGMFVXuCtxLlJqUdn+d8vUlfA4t8/IdyRXfoKjh83Iiq/rxoT2JWG0kFYxshWPSjq4W3CoWfha5i9yyotmh/UAyPcbEaXjqtl2NJnayM+jAaZ0T9KSaJw49v2oj9mNjEzIuJ5G1wuwbkPNKt0zrTzkrJ0QBU2HIZjbKERwJoGLXgjPUfq5wqykZGP1Ifz2cSII96onT8gjnrZ0zxG/yL3sH6NGReAfb952jyw09kV7wNrlkVflNfaOJE6Qlf5BTUZe6ecBd4m0f9Axb7w93qSpKd1H/lLBxUJznfoa69EqdnjVU95rHeDeIMEIiyyPl6tWrLL1Qq12UhFuj/OCHjOBGqavgq+SDQ1SOYLqetis93RnjfIJxBVpWZa4JHCSbhYnlVMVhFKDGoC+YvkAr5UEZbLdBQs6G+Q7eyJOTTux4sVF8JKnS5EkQEAwMJ8fcJi4PHcibsLVwICChsMU+qf53
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RRK3JZakNhT2drc0JxMkluTzlIMWpsZTJSdTdzTnM5Ump4dzl0OHJHTGZB?=
 =?utf-8?B?bmxxbzlYbWhGK29meW1wZXZBb2hKU1p6WW9weFowQUhvc1psbFVGRnNhM2d2?=
 =?utf-8?B?cnpCbVRFSzljd2FieFhDd3NWVmN3ZlBsQXBHTHI4U3hMMHQrN0M3MGsrajUr?=
 =?utf-8?B?ZFBIekZMTWFoVmM4ZW1lYnZ2dWJyeGlIb3VLaGhZZStvS09jMzF6SWZEQ3A2?=
 =?utf-8?B?QksyM0kwRzY3YnF0czFTLzhZVW5aeXJiOEdtNzhPc0R3a0hna01OVjQ4b09N?=
 =?utf-8?B?SGVnN3FVQlFmT1RxdTdjYkdTNGtqby90M1k4enJmOUVSL2w4WGQ2aEFaQ1lu?=
 =?utf-8?B?Q1NBZk0rSnVoVWR0V0FlZkIxZVRPeXUyblZNUU1ra1JoL0ZPQUM3RlRzNTdT?=
 =?utf-8?B?MitYdTRKaHNjRExQZ1BGQ2hkb0NqTkNyZkgvRG9ibC9Xcm1jNCt0b0Y2Zkh4?=
 =?utf-8?B?R0plWGhyT1dEb2NxWXlvR0dkczFFdGlJUjNVOWVyeDJhWEMvc0FpMmlVRi9y?=
 =?utf-8?B?NWRVNzBHZ050SS91TndoNEtxSEc4Rmk5NTl1Uk1OV0NNNXFEdGFzaWV0cllq?=
 =?utf-8?B?b1BBZWlabDh0Nis0UUladldmbmhablRmRVhNU0lSQ3FUZXQ0bEMzeDZsaTJU?=
 =?utf-8?B?ajVKcmhOWHc5S1YxVk9Ud1pZQ0xMaTZKTFllWk82bjZUcURhL0RRemNFbjEr?=
 =?utf-8?B?bUlSQzRDOTA0WTNMdlVJdjYrbDJEbTlUV2NnSksvM0JMWWJhdU85UjI1TUZN?=
 =?utf-8?B?MFRMY01QalU4YVozL2ZrSEMvV2s1L0xreGRUcjd6N1RNelhuQnhqbE1vUTB3?=
 =?utf-8?B?TC9aUE9mWDJGNElBeFdBWW5VemNML2RWM0svN2pBbmh0MnVlNDVWNThlZFhq?=
 =?utf-8?B?NDRtRFFXb25MTy9xM3FNaHdnTXJJLzV6SmoyVzFyZmU1M09rdzlsWmt5c1VK?=
 =?utf-8?B?NVFTcHQ5K25GMTVTYUlKQ0w3RDBERVl0eHBzdlN3VTBQNGYybm9scFJHbGE1?=
 =?utf-8?B?Y1gzd2RQTFA0QTl3MHpxeUYwT2tUTTdCWnc5MWlGSCs5ZEhpcVE3UGZ1SDBm?=
 =?utf-8?B?cWJtdU5Zb001WUpiS1pNMEZ1ektKVERFMGlxRHQrVnVObEJrK1UzK3I5ZmVo?=
 =?utf-8?B?MWk4bGQvVDMxYVFVTHpweHVlYlNwN3dKbSt4Mm9oQ1owYnNPb0JDMTJtWjRR?=
 =?utf-8?B?MUtrVW9xZDZlMCtGNGJ4ZjYrUlVtU1NFQVd0VVEyWXFGTDJGS1VucmhJckxt?=
 =?utf-8?B?NFpHOHd4emFUR2ZxdzExRHdPa0dLWS9HcVk1SU1GK3BPdVBjNDFBMS9IZCtY?=
 =?utf-8?B?OXJRd3Z5MGU2UEloK1FJWTJHVHlRQWdDeUt6dzRpVy9yMmdwZkxPcEZsRzNh?=
 =?utf-8?B?bGJLaG00OFdVcGdJZVltSk9nZTlIWGNjWnhhaXNmY1hjdnpxdTN5emwzdVg0?=
 =?utf-8?B?d3pwM3gyRWlGMlo4UlR5OEdQQUNNdlJkZG0yaVBzZno5SnkvWTF2RDdsRjF3?=
 =?utf-8?B?RzEvSWJ3NVZzSGZ2TExURnNYNlVjWkNkL2RhbEd4MlVyRXlGd2pielVXOGY3?=
 =?utf-8?B?WkhnNmIvbmlYRUVFZXk0ZEVwOVBGL0xMd3hROExydkpuclJYaVY5SWdoakZN?=
 =?utf-8?B?UFFtWC9HR2kycmplcG9qY01JdTZER1hDU0h4RFVLZzRrQm1GYm1OZXZBdFBh?=
 =?utf-8?Q?XI5sBzXCMFnm2TByXe+0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df438fe-32eb-4d11-1f6f-08dcb16210e7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:09:53.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7531

On 2024/7/23 00:47, Alexei Starovoitov wrote:
> On Thu, Jul 11, 2024 at 12:10:17PM +0100, Juntong Deng wrote:
>>
>> In restore_udp_socket I had to add a struct bpf_crib_skb_info for
>> restoring packets, this is because there is currently no BPF_CORE_WRITE.
>>
>> I am not sure what the current attitude of the kernel community
>> towards BPF_CORE_WRITE is, personally I think it is well worth adding,
>> as we need a portable way to change the value in the kernel.
>>
>> This not only allows more complexity in the CRIB restoring part to
>> be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
>> ebpf to unlock more possible application scenarios.
> 
> There are lots of interesting ideas in this patch set, but it seems they are
> doing the 'C-checkpoint' part of CRIx and something like BPF_CORE_WRITE
> is necessary for 'R-restore'.
> I'm afraid BPF_CORE_WRITE cannot be introduced without breaking all safety nets.
> It will make bpf just as unsafe as any kernel module if bpf progs can start
> writing into arbitrary kernel data structures. So it's a show stopper.
> If you think there is a value in adding all these iterators for 'checkpoint'
> part alone we can discuss and generalize individual patches.
> 

Thanks for your review!

I agree, BPF_CORE_WRITE will compromise the safety of ebpf programs,
which may be a Pandora's box.

But without BPF_CORE_WRITE, CRIB cannot achieve portable restoration,
so the restoration part is put on hold for now.

In the next version of the patch set, I will focus on implementing
checkpointing (dumping) via CRIB for better dumping performance and more
extensibility (which still has a lot of benefits).

> High level feedback:
> 
> - no need for BPF_PROG_TYPE_CRIB program type. Existing syscall type should fit.
> 

- If we use BPF_PROG_TYPE_SYSCALL for CRIB programs, will it cause
confusion in the functionality of bpf program types?
(BPF_PROG_TYPE_SYSCALL was originally designed to execute syscalls)

- Is it good to expose all kfuncs needed for checkpointing to
BPF_PROG_TYPE_SYSCALL? (Maybe we need a separate ebpf program type to
restrict the kfuncs that can be used)

- Maybe CRIB needs more specific ebpf program running restrictions?
(for example, not allowed to modify the context, dumped data can only
be returned via ringbuf, context is only used to identify the process
that needs to dump and the part of the data that needs to be dumped)

The above three points were my considerations when I originally added
BPF_PROG_TYPE_CRIB, maybe we can have more discussion?

> - proposed file/socket iterators are somewhat unnecessary in this open coded form.
>    there is already file/socket iterator. From the selftests it looks like it
>    can be used to do 'checkpoint' part already.
> 

If you mean iterators like iter/task_file, iter/tcp, etc., then I think
that is not flexible enough for checkpointing.

This is because the context of bpf iterators is fixed and bpf iterators
cannot be nested. This means that a bpf iterator program can only
complete a specific small iterative dump task, and cannot dump
multi-level data.

An example, when we need to dump all the sockets of a process, we need
to iterate over all the files (sockets) of the process, and iterate over
the all packets in the queue of each socket, and iterate over all data
in each packet.

If we use bpf iterator, since the iterator can not be nested, we need to
use socket iterator program to get all the basic information of all
sockets (pass pid as filter), and then use packet iterator program to
get the basic information of all packets of a specific socket (pass pid,
fd as filter), and then use packet data iterator program to get all the
data of a specific packet (pass pid, fd, packet index as filter).

This would be complicated and require a lot of (each iteration)
bpf program startup and exit (leading to poor performance).

By comparison, open coded iterator is much more flexible, we can iterate
in any context, at any time, and iteration can be nested, so we can
achieve more flexible and more elegant dumping through open coded
iterators.

With open coded iterators, all of the above can be done in a single
bpf program, and with nested iterators, everything becomes compact
and simple.

Also, bpf iterators transmit data to user space through seq_file,
which involves a lot of open (bpf_iter_create), read, close syscalls,
context switching, memory copying, and cannot achieve the performance
of using ringbuf.

The bpf iterator is more like an advanced procfs, but still not CRIB.

> - KF_ITER_GETTER is a good addition, but we should be able to do it without these flags.
>    kfunc-s should be able to accept iterator as an argument. Some __suffix annotation
>    may be necessary to help verifier if BTF type alone of the argument won't be enough.
> 

I agree, kfuncs can accept iterators as arguments and we can
use __suffix.

But here is a question, should we consider these kfuncs as iter kfuncs?

That is, should we impose specific constraints on these functions?
For example, specific naming patterns (bpf_iter_<type>_ prefix),
GETTER methods cannot take extra arguments (like next methods), etc.

Currently the verifier applies these constraints based on flags.

> - KF_OBTAIN looks like a broken hammer to bypass safety. Like:
> 
>    > Currently we cannot pass the pointer returned by the iterator next
>    > method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
>    > returned by the iterator next method is not "valid".
> 
>    It's true, but should be fixable directly. Make return pointer of iter_next() to be trusted.
> 

I agree that KF_OBTAIN currently is not a good solution.

For case 1, I tried the ref_obj_id method mentioned by Kumar and
it worked, solving the ownership and lifetime problems. I will include
it in the next version of the patch.

For case 2, Kumar mentioned that it had been fixed by Matt, but I found
there are still some problems.

More details can be found in my reply to Kumar (in the same email thread)

For iter_next(), I currently have an idea to add new flags to allow
iter_next() to decide whether the return value is trusted or not,
such as KF_RET_TRUSTED.

What do you think?

Also, for these improvements to the chain of trust, do you think I
should send them out as separate patches? (rather than as part of
the CRIB patch set)

> - iterators for skb data don't feel right. bpf_dynptr_from_skb() should do the trick already.
> 

I agree that using bpf_dynptr would be better, but probably would
not change much...

This is because, we cannot guarantee that the user provided a large
enough buffer, the buffer provided by the user may not be able to hold
all the data of the packet (but we need to dump the whole packet, the
packet may be very large, which is different from the case of reading
only a fixed size protocol header for filtering), which means we need to
read the data in batches (iteratively), so we still need an iterator.

(Back to the BPF_PROG_TYPE_CRIB discussion, BPF_PROG_TYPE_SYSCALL cannot
use bpf_dynptr_from_skb, but should we expose bpf_dynptr_from_skb to
BPF_PROG_TYPE_SYSCALL? Maybe we need a separate program type...)

> - start with a small patch set.
>    30 files changed, 3080 insertions(+), 12 deletions(-)
>    isn't really reviewable.

Sorry, I will reduce the size of the patch set in the next version.

I will remove the proof of concept part, keep only the real tests,
and start trying to integrate CRIB with CRIU.

