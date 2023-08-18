Return-Path: <bpf+bounces-8095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F378117B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 19:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582211C2119C
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B763A5;
	Fri, 18 Aug 2023 17:17:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6763A1
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 17:17:20 +0000 (UTC)
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F773AB9
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 10:17:18 -0700 (PDT)
Message-ID: <0d56dd23-9911-0d4f-7e0c-ade572768c26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692379036; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rL+JILHogOJeVAZ3sQOM+wFCYtMR6Az0elD6x+XFJMI=;
	b=aWGxFIIdv2sABzkWgXpoOZF2unNZTWDhFGLroDm0vyYUtYiIPfxJ1Pup1TiuckC3CUpKk8
	IYZb8PAhj6Kw36eqF3mf8DlUnTR1NwjoL7KV2A8bPGI3+rh43XNsE/+oF3OnEDWXAxMD2Z
	XfDY1L51RvSOqlwvT8dAMAoAznvr0Fs=
Date: Fri, 18 Aug 2023 10:17:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 15/15] bpf: Mark
 BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172928.1373311-1-yonghong.song@linux.dev>
 <3adfd28e-f4ba-cab5-2204-fa0342a53de9@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3adfd28e-f4ba-cab5-2204-fa0342a53de9@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 8:54 AM, Daniel Borkmann wrote:
> On 8/14/23 7:29 PM, Yonghong Song wrote:
>> Now 'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE + local percpu ptr'
>> can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
>> and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/uapi/linux/bpf.h       | 9 ++++++++-
>>   tools/include/uapi/linux/bpf.h | 9 ++++++++-
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index d21deb46f49f..5d1bb6b42ea2 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -932,7 +932,14 @@ enum bpf_map_type {
>>        */
>>       BPF_MAP_TYPE_CGROUP_STORAGE = 
>> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>       BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>> -    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>> +    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> +    /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
>> +     * attaching to a cgroup. The new mechanism 
>> (BPF_MAP_TYPE_CGRP_STORAGE +
>> +     * local percpu kptr) supports all 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> +     * functionality and more. So mark * 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> +     * deprecated.
>> +     */
>> +    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>>       BPF_MAP_TYPE_QUEUE,
>>       BPF_MAP_TYPE_STACK,
>>       BPF_MAP_TYPE_SK_STORAGE,
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index d21deb46f49f..5d1bb6b42ea2 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -932,7 +932,14 @@ enum bpf_map_type {
>>        */
>>       BPF_MAP_TYPE_CGROUP_STORAGE = 
>> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>       BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>> -    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>> +    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> +    /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
>> +     * attaching to a cgroup. The new mechanism 
>> (BPF_MAP_TYPE_CGRP_STORAGE +
>> +     * local percpu kptr) supports all 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> +     * functionality and more. So mark * 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> +     * deprecated.
>> +     */
>> +    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = 
>> BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
> 
> This breaks bpftool tests in BPF CI, presumably it thinks doc is missing 
> here:
> 
>    [...]
>    bpftool_checks - Running bpftool checks...
>    Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h 
> (bpf_map_type) and /tmp/work/bpf/bpf/tools/bpf/bpftool/map.c (do_help() 
> TYPE): {'percpu_cgroup_storage_deprecated', 'percpu_cgroup_storage'}
>    Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h 
> (bpf_map_type) and 
> /tmp/work/bpf/bpf/tools/bpf/bpftool/Documentation/bpftool-map.rst 
> (TYPE): {'percpu_cgroup_storage_deprecated', 'percpu_cgroup_storage'}
>    bpftool checks returned 1.
>    [...]

Thanks, Daniel. Will take a look!

