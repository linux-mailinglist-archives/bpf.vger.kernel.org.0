Return-Path: <bpf+bounces-6495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008176A59C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF16E281746
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B9641;
	Tue,  1 Aug 2023 00:39:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49507E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:39:14 +0000 (UTC)
Received: from out-91.mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2BACA
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 17:39:12 -0700 (PDT)
Message-ID: <26837243-5266-0c67-f2d2-e149ea264bcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690850350; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3pHfnfUoVy8D9h+trcMaKDh6hWtvcfLqCWc0n5fhwg=;
	b=f58VmcdxJWY+WMQ+o0GW9ejKGkb2VnROk4bngiUBw2h5NxeVZK1lFzhTdCysIUmhEReLNe
	ubZZN25aZ/m+tADookD0EvHyvT/+CvRtabbcWV/yOVNUWUomfY+IJpyhaxWkaP18JZIRVg
	2Rgu2AucKE7rM/iSsgXdyOn/IK6lmC8=
Date: Mon, 31 Jul 2023 17:39:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] kernel/bpf: Fix an array-index-out-of-bounds
 issue in disasm.c
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com
References: <20230731204534.1975311-1-yonghong.song@linux.dev>
 <CAADnVQJOK-VF6-wMFVfvFJ8ZrkK_JUpTWojhHQgVy27Jj4K1eQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJOK-VF6-wMFVfvFJ8ZrkK_JUpTWojhHQgVy27Jj4K1eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 5:37 PM, Alexei Starovoitov wrote:
> On Mon, Jul 31, 2023 at 1:45 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> syzbot reported an array-index-out-of-bounds when printing out bpf
> 
> Applied and fixed subject.
> "kernel/bpf:" is an usual prefix. Not sure why you used it.
> Just "bpf:" is enough.

I am not sure either :-( Maybe sleepy at that moment :-)

