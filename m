Return-Path: <bpf+bounces-8818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3378A3D9
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 03:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4432B1C2074B
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E0643;
	Mon, 28 Aug 2023 01:18:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20736D
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 01:18:49 +0000 (UTC)
Received: from out-245.mta0.migadu.com (out-245.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B7116
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 18:18:47 -0700 (PDT)
Message-ID: <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693185525; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mo2UOSTv6RfgUNN7mSKjns1X/xd4nJrbRdVL6LXeMMw=;
	b=Ief2V5pbZdPnfYHKEiWq86bByybxNK3n6e+J0xWUaLpH7kvSHaW8Zg1M2xGBcmMzZFBj2n
	hf6iX35eEj2uIsrfDZxYVfONM0IaYFjsHaB4uEMz/vQJeqVPYZNFIi7BTfXlsqhFr1to9i
	bmh75VGWK3TRLVDRL9Di8Ds9As0jDkc=
Date: Sun, 27 Aug 2023 18:18:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com> <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230827201909.GC28645@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/27/23 1:19 PM, Oleg Nesterov wrote:
> On 08/25, Yonghong Song wrote:
>>
>> On 8/25/23 10:04 AM, Oleg Nesterov wrote:
>>> Forgot to mention in the changelog...
>>>
>>> In any case this doesn't look right. ->group_leader can exit before other
>>> threads, call exit_files(), and in this case task_group_seq_get_next() will
>>> check task->files == NULL.
>>
>> It is okay. This won't be affecting correctness. We will end with
>> calling bpf program for 'next_task'.
> 
> Well, I didn't mean it is necessarily wrong, I simply do not know.
> 
> But let's suppose that we have a thread group with the main thread M + 1000
> sub-threads. In the likely case they all have the same ->files, CLONE_THREAD
> without CLONE_FILES is not that common.
> 
> Let's assume the BPF_TASK_ITER_TGID case for simplicity.
> 
> Now lets look at task_file_seq_get_next() which passes skip_if_dup_files == 1
> to task_seq_get_next() and thus to task_group_seq_get_next().
> 
> Now, in this case task_seq_get_next() will return non-NULL only once (OK, unless
> task_file_seq_ops.stop() was called), it will return the group leader M first,
> then after task_file_seq_get_next() "reports" all the fd's of M and increments
> info->tid, the next task_seq_get_next(&info->tid, true) should return NULL because
> of the skip_if_dup_files check in task_group_seq_get_next().
> 
> Right?
> 
> But. if the group leader M exits then M->files == NULL. And in this case
> task_seq_get_next() will need to "inspect" all the sub-threads even if they all
> have the same ->files pointer.

That is correct. I do not have practical experience on how much
possibility this scenario may happen. I assume it should be very low.
If this is not the case, we might need to revisit.

> 
> No?
> 
> Again, I am not saying this is a bug and quite possibly I misread this code, but
> in any case the skip_if_dup_files logic looks sub-optimal and confusing to me.
> 
> Nevermind, please forget. This is minor even if I am right.
> 
> Thanks for rewiev!
> 
> Oleg.
> 

