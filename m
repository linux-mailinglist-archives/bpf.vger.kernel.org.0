Return-Path: <bpf+bounces-646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EF704F1C
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249B7281519
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA12771B;
	Tue, 16 May 2023 13:19:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FA34CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 13:19:59 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2F4C3C
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:19:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso11102737f8f.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684243192; x=1686835192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBxFEHMwnlIUgeyLrn1CSpPGSm9w4/l+SxcFsj7tBDk=;
        b=FRxHMgwgc8IHWlplp4mggqlh8VuAbCnt74IjwsjvtXcEFtLzexVJvnUuku+bbGKTJW
         GhMTY8FWjKeu4ea0Zc0n2AAHvyCh5MmE6tiW2JRASwu++aXfVwplRSXusMfpvJlzPIYs
         bSBX2WHHxBd48JRSYfHgAgv8KWq2rSI8NhWFEk9q3ZhbIPZHU2NJm9ADOz5iVyaixkaI
         1h/roQidE4QS9b9xwIf50Oxw36ybfZJupKos2B5pefdvZF1cd7qNSrlBzTQiCppk8CvK
         tugX2IZM1BKA2ZQ60kijLONG0LwNUAPMI47s77SCuE2n0rCVIv8TNt29yWy59PvsOHx+
         PMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684243192; x=1686835192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBxFEHMwnlIUgeyLrn1CSpPGSm9w4/l+SxcFsj7tBDk=;
        b=SkbmRT6UpWGwOgQTlVGcrQPKF5pvstJC5x31uMKMfV4ljNYNQgr349HZiAzNcHmnTg
         pKFedrchnS/bDwDYK/QQpeE3FnotKpvmV9dsPn/qu14iJH/nJhyAvZ1HbM6g2cIKPg16
         laKrbhn4wpgP68RBXFoyZ3giyeYJnyZONG3Ft6CCuE1W8Se8pLzC+uw3tnRcTNEvB3M8
         nazst3z3Yx1qyjqZPfjhywTv+SQcRZuL3KYNsIdf09BFAuE88t0ccIm3p7+2jTmO7Jk9
         zGK7LFYQk4tI+kM+tBJY/eN1Z6Lp3D5+TejHmraCscS7ggCi6j/s12nlcx1sbIWZ4AEi
         KDoA==
X-Gm-Message-State: AC+VfDyVzvdukmSdz84nJAV2t547ei7JIcCveu2sKstIcmXy2pKwptLZ
	wasCjOV/GFrbrUHVzaUGXUSG/w==
X-Google-Smtp-Source: ACHHUZ6RCbYd2kgDFsxk4FZmpVI7u6Qy+eMYYu7L36u6QlGmn0MmuHZysEbz81bvE04WWnISxNZQaA==
X-Received: by 2002:adf:f4ce:0:b0:309:3a60:d791 with SMTP id h14-20020adff4ce000000b003093a60d791mr596499wrp.54.1684243191660;
        Tue, 16 May 2023 06:19:51 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:8d0d:450e:a1d0:2661? ([2a02:8011:e80c:0:8d0d:450e:a1d0:2661])
        by smtp.gmail.com with ESMTPSA id u5-20020adfdd45000000b002fe13ec49fasm2666014wrm.98.2023.05.16.06.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:19:51 -0700 (PDT)
Message-ID: <d3b7480c-9d0f-04d1-85ad-d22fa064f259@isovalent.com>
Date: Tue, 16 May 2023 14:19:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next 2/2] bpftool: Show target_{obj,btf}_id in tracing
 link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20230516123926.57623-1-laoar.shao@gmail.com>
 <20230516123926.57623-3-laoar.shao@gmail.com>
 <5c8e5c0e-02a6-f043-7c22-add9d2996eec@isovalent.com>
 <CALOAHbD8jHVwC=oFPiEXQXO9Xzs_eF2+s=EbMxqBqVYEnQag2w@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CALOAHbD8jHVwC=oFPiEXQXO9Xzs_eF2+s=EbMxqBqVYEnQag2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-16 21:09 UTC+0800 ~ Yafang Shao <laoar.shao@gmail.com>
> On Tue, May 16, 2023 at 9:01 PM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2023-05-16 12:39 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
>>> The target_btf_id can help us understand which kernel function is
>>> linked by a tracing prog. The target_btf_id and target_obj_id have
>>> already been exposed to userspace, so we just need to show them.
>>>
>>> The result as follows,
>>>
>>> $ tools/bpf/bpftool/bpftool link show
>>> 2: tracing  prog 13
>>>         prog_type tracing  attach_type trace_fentry
>>>         target_obj_id 1  target_btf_id 13964
>>>         pids trace(10673)
>>>
>>> $ tools/bpf/bpftool/bpftool link show -j
>>> [{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":10673,"comm":"trace"}]}]
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> Acked-by: Song Liu <song@kernel.org>
>>> ---
>>>  tools/bpf/bpftool/link.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>>> index 243b74e..cfe896f 100644
>>> --- a/tools/bpf/bpftool/link.c
>>> +++ b/tools/bpf/bpftool/link.c
>>> @@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>>>
>>>               show_link_attach_type_json(info->tracing.attach_type,
>>>                                          json_wtr);
>>> +             jsonw_uint_field(json_wtr, "target_obj_id", info->tracing.target_obj_id);
>>> +             jsonw_uint_field(json_wtr, "target_btf_id", info->tracing.target_btf_id);
>>>               break;
>>>       case BPF_LINK_TYPE_CGROUP:
>>>               jsonw_lluint_field(json_wtr, "cgroup_id",
>>> @@ -375,6 +377,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>>>                       printf("\n\tprog_type %u  ", prog_info.type);
>>>
>>>               show_link_attach_type_plain(info->tracing.attach_type);
>>> +             printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
>>> +                        info->tracing.target_obj_id, info->tracing.target_btf_id);
>>
>> Older kernels won't share this info, so maybe we can skip this printf()
>> in plain output if the target object and BTF ids are 0?
>>
> 
> Good suggestion. Will change it in the next version.
> BTW, shouldn't we skip it in the json output as well ?

I'd keep it in JSON. Plain output is for reading in the console, we want
to make it easy for users to find the relevant info. JSON is for machine
consumption, it's OK to be more exhaustive and to leave it to the
consuming program to decide what's relevant and what's not.

Quentin

