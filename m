Return-Path: <bpf+bounces-8190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D294B783572
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090521C20A11
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C5182A9;
	Mon, 21 Aug 2023 22:13:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAD125D6
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:13:35 +0000 (UTC)
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E2E4
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:13:33 -0700 (PDT)
Message-ID: <9ae87beb-af3b-1b45-9027-e8a8e2399159@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692656011; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpAir/jTudrns/MaDAgAOVXXH6wj7VSVz+2KEDiXYL8=;
	b=Ou6DyJZuEIUVAwmCBGbXUAQbHdAV7BtwHG8qdwQwBiTL6Cx1JQHokD6HdfHwHSvLHoqt9P
	N6LRD7aTt7zD/P5iQCrNGa0ebkHIeTnGHP07hUaDQhFzlId62yq3MqPvYYzyrmNNzMGHKY
	hc/6FQp1QhYqU7UcvLkQKvrXIF6kSDI=
Date: Mon, 21 Aug 2023 15:13:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
 <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev>
 <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
 <CAADnVQL-795Wzhy7E3N5XgVT0OgL0eFMwXxsD1myBGRbUVwaEg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL-795Wzhy7E3N5XgVT0OgL0eFMwXxsD1myBGRbUVwaEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 12:44 PM, Alexei Starovoitov wrote:
> On Mon, Aug 21, 2023 at 9:03 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>>>
>>>> The fix on its own looks ok to me, but any reason you'd not like to
>>>> delegate to map_kptr_match_type?
>>>> Just to collect kptr related type matching logic in its own place.  It
>>>> doesn't matter too much though.
>>>
>>>   From comments from Alexei in
>>>
>>> https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>>>
>>> =====
>>> The map_kptr_match_type() should have been used for kptrs pointing to
>>> kernel objects only.
>>> But you're calling it for MEM_ALLOC object with prog's BTF...
>>> =====
>>>
>>> So looks like map_kptr_match_type() is for kptrs pointing to
>>> kernel objects only. So that is why I didn't use it.
>>>
>>
>> That function was added by me. Back then I added this check as we were
>> discussing possibly supporting such local kptr and more thought would
>> be needed about the design before just doing type matching. Also it
>> was using kernel_type_name which was later renamed as btf_type_name,
>> so as a precaution I added the btf_is_kernel check. Apart from that I
>> remember no other reason, so I think it should be ok to drop it now
>> and use it.
> 
> Agree with Kumar.
> When I said map_kptr_match_type() is only used with kernel BTF I meant
> that as code stands it was the intent of that helper.
> With MEM_ALLOC being kptr_xchg-ed it's better to share the code and
> map_kptr_match_type() should probably be adopted to work with both kernel
> and prog's BTFs.

Sounds good to me. Will use map_kptr_match_type() in v2.

> 
> And as Kumar noticed __check_ptr_off_reg() part of it is necessary for
> MEM_ALLOC too.

