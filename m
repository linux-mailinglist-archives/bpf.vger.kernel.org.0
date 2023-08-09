Return-Path: <bpf+bounces-7379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EF776507
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737BD281CDE
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DE1CA15;
	Wed,  9 Aug 2023 16:29:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635F18AE1
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:29:50 +0000 (UTC)
Received: from out-76.mta0.migadu.com (out-76.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CA1999
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:29:44 -0700 (PDT)
Message-ID: <ae10962c-0bd4-35a3-6b62-72c4aa92d54b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691598583; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPuadtQNOw6GQkXPSHnqSbBpnh/W9+fI3N17ZZNDNV4=;
	b=BT1+CmCaede/GU7t9hrVXkbZdINBKlyi5YNBG+2ob6C58MLvp8/nAJPIZkZ0U2+/numitP
	L6G2Sy0/FcCRG8vVu3tI5KFD9HWuA+5BCRqMlWWnntIWWLcomBvcMtw6htSR2VJHI6rQat
	ckhW9DCLbLZkUGZIc6jZJOpUOQhOVb8=
Date: Wed, 9 Aug 2023 09:29:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 03/28] bpf: Add multi uprobe link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-4-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230809083440.3209381-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/23 1:34 AM, Jiri Olsa wrote:
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
> 
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
> 
>    struct {
>      __aligned_u64   path;
>      __aligned_u64   offsets;
>      __aligned_u64   ref_ctr_offsets;
>      __u32           cnt;
>      __u32           flags;
>    } uprobe_multi;
> 
> Uprobes are defined for single binary specified in path and multiple
> calling sites specified in offsets array with optional reference
> counters specified in ref_ctr_offsets array. All specified arrays
> have length of 'cnt'.
> 
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

