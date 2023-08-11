Return-Path: <bpf+bounces-7552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D61077924C
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D494282050
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA67929E03;
	Fri, 11 Aug 2023 14:57:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F225692
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:57:42 +0000 (UTC)
Received: from out-69.mta0.migadu.com (out-69.mta0.migadu.com [IPv6:2001:41d0:1004:224b::45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8210FE
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 07:57:40 -0700 (PDT)
Message-ID: <d000d817-54b9-f6b8-dcb3-d417ed2cbc97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691765857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEzs6sGzp2JnhCxfNH+eo4Joyo+OqLdOaWpoJ+RkqZA=;
	b=OW90yYMsDXRIuEi996Y95nAjPoEQ5dCqY7K8Ag5CV54WnZqS1s2tuGwu1prjd4Z9UdszWg
	HYJmK6DcH52cEetyweqNbnysXvcvmzW6wdlfhbubsswvcb+GaLvPlDrK4EdHIhniOnO88Q
	cklO2lYD7FPzKgGkOPXtmbzNGpWesUY=
Date: Fri, 11 Aug 2023 10:57:31 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce task_vma open-coded iterator
 kfuncs
To: Stanislav Fomichev <sdf@google.com>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Nathan Slingerland <slinger@meta.com>
References: <20230810183513.684836-1-davemarchevsky@fb.com>
 <20230810183513.684836-3-davemarchevsky@fb.com> <ZNVdP0mA9REeLQJj@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <ZNVdP0mA9REeLQJj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 5:57 PM, Stanislav Fomichev wrote:
> On 08/10, Dave Marchevsky wrote:
>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_task_vma in open-coded
>> iterator style. BPF programs can use these kfuncs directly or through
>> bpf_for_each macro for natural-looking iteration of all task vmas.
>>
>> The implementation borrows heavily from bpf_find_vma helper's locking -
>> differing only in that it holds the mmap_read lock for all iterations
>> while the helper only executes its provided callback on a maximum of 1
>> vma. Aside from locking, struct vma_iterator and vma_next do all the
>> heavy lifting.
>>
>> The newly-added struct bpf_iter_task_vma has a name collision with a
>> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
>> file is renamed in order to avoid the collision.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> Cc: Nathan Slingerland <slinger@meta.com>
>> ---
>>  include/uapi/linux/bpf.h                      |  5 ++
>>  kernel/bpf/helpers.c                          |  3 +
>>  kernel/bpf/task_iter.c                        | 56 +++++++++++++++++++
>>  tools/include/uapi/linux/bpf.h                |  5 ++
>>  tools/lib/bpf/bpf_helpers.h                   |  8 +++
>>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 ++++-----
>>  ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>>  7 files changed, 90 insertions(+), 13 deletions(-)
>>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index d21deb46f49f..c4a65968f9f5 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7291,4 +7291,9 @@ struct bpf_iter_num {
>>  	__u64 __opaque[1];
>>  } __attribute__((aligned(8)));
>>  
>> +struct bpf_iter_task_vma {
> 
> [..]
> 
>> +	__u64 __opaque[9]; /* See bpf_iter_num comment above */
>> +	char __opaque_c[3];
> 
> Everything in the series makes sense, but this part is a big confusing
> when reading without too much context. If you're gonna do a respin, maybe:
> 
> - __opaque_c[8*9+3] (or whatever the size is)? any reason for separate
>   __u64 + char?

IIUC this is because BTF generation doesn't pick up __attribute__((aligned(8))),
so if a vmlinux.h is generated via 'bpftool btf dump file vmlinux format c' and
this struct only contains chars, it won't have the correct alignment.

I'm not sure if the bitfield approach taken by bpf_{list,rb}_node similar has
the same effect. Some quick googling indicates that if it does, it's probably
not in the C standard.

But yeah, I agree that it's ugly. While we're on the topic, WDYT about my
comment in the cover letter about this struct (copied here for convenience):

  * The struct vma_iterator wrapped by struct bpf_iter_task_vma itself wraps
    struct ma_state. Because we need the entire struct, not a ptr, changes to
    either struct vma_iterator or struct ma_state will necessitate changing the
    opaque struct bpf_iter_task_vma to account for the new size. This feels a
    bit brittle. We could instead use bpf_mem_alloc to allocate a struct
    vma_iterator in bpf_iter_task_vma_new and have struct bpf_iter_task_vma
    point to that, but that's not quite equivalent as BPF progs will usually
    use the stack for this struct via bpf_for_each. Went with the simpler route
    for now.

> - maybe worth adding something like /* Opaque representation of
>   bpf_iter_task_vma_kern; see bpf_iter_num comment above */.
>   that bpf_iter_task_vma<>bpf_iter_task_vma_kern wasn't super apparent
>   until I got to the BUG_ON part

It feels weird to refer to the non-UAPI _kern struct in uapi header. Maybe
better to add a comment to the _kern struct referring to this one? I don't
feel strongly either way, though.

