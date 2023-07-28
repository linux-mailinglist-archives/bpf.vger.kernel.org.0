Return-Path: <bpf+bounces-6151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2276622A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998E01C21751
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023151FB6;
	Fri, 28 Jul 2023 03:01:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA92714A
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:01:31 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4112119
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 20:01:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-687087d8ddaso681004b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 20:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690513289; x=1691118089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjkE2QJp5YH+tCDyB0wLIw4y8EiW40HSc+cEgR5MCMk=;
        b=VvmisaMdxgMcf35NZKkxzBIEMm+XzGMyWPTURum1qlM6CdtFVFyFOTvgV8PL/UH4j4
         pYW/vUMdOu9tmmkIP9nurlgZFpmnV+Sf8Q+ZXrS9g5r/esBK2irTxDtUbssJ1kxqpSi7
         Z3Db1fyODX9ZfulI2m/gJ93B6U1o2WboemrLKTVm7MlPdhncKvuUdySAzvvX5VQDQ+OO
         lsz7Ak8PIVB0y4ziEEJB1WpjZ7pvN24rcU8Z9DvLL7QjoiFEFzdPP+Qk7NlKhOKSttEM
         OadyR10+iztUXbqtwZMeH654pslG5H9mofHiZUTTfW0BsB34JHkCJLqk3oCFzQC1fVtF
         p53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513289; x=1691118089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NjkE2QJp5YH+tCDyB0wLIw4y8EiW40HSc+cEgR5MCMk=;
        b=fXkZXnyJSvPrN3xd+tsrl+FqDBp0dR24V+o7sj/Iy+NbRzoVOq3xqxdTL9wKJJ41uS
         jGzqs6yDO4VfkKo8Zo9ffMHX+Za3BDlhGBsNzkcDorLVymD8AWO4ZpD10S6NDVXiRqeo
         oetwtaADjbrvlmMvR4yupwv73NLfCVV/X2KGuirgxbSmClzMhZKNgGa4KGzcGViWMsSW
         Z5CK2RQ7pQP3PQGHmVmSgfgDWDr+SRJdv06jDftY6PzGTf2Jl9CAG0i+COl1a63pVmrP
         8fwKM1mL4NOyNWBCmcf3CXyhnfOmKQChhdAZjyRVEGtCN+yiKkszSn+c/qW4yaIfm4v6
         rP+Q==
X-Gm-Message-State: ABy/qLaRQwk/CcG71ODMz+jzYD93ed+FTZF4F0StPquVoDuov7ILn95m
	CBRzdOBWNBn6ZoOpB7PU8qnE7g==
X-Google-Smtp-Source: APBJJlE05KfBrHKqDjjmITmxgRbYb1H+7HaT32afOJNe6AQWDwQnF+KrC+py8os6ykbDJb7DHE7RTA==
X-Received: by 2002:a05:6a00:2353:b0:668:79d6:34df with SMTP id j19-20020a056a00235300b0066879d634dfmr698433pfj.23.1690513289499;
        Thu, 27 Jul 2023 20:01:29 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm2130125pfo.126.2023.07.27.20.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 20:01:29 -0700 (PDT)
Message-ID: <16326cd3-376b-4d08-409e-e64f43f848af@bytedance.com>
Date: Fri, 28 Jul 2023 11:01:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
To: Quentin Monnet <quentin@isovalent.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <20230727073632.44983-4-zhouchuyi@bytedance.com>
 <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

在 2023/7/27 20:26, Quentin Monnet 写道:
> 2023-07-27 15:36 UTC+0800 ~ Chuyi Zhou <zhouchuyi@bytedance.com>
>> Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
>> we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   tools/bpf/bpftool/common.c     |  1 +
>>   tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>>   tools/lib/bpf/libbpf.c         |  3 +++
>>   tools/lib/bpf/libbpf_probes.c  |  2 ++
>>   4 files changed, 20 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index cc6e6aae2447..c5c311299c4a 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>>   	case BPF_TRACE_FENTRY:			return "fentry";
>>   	case BPF_TRACE_FEXIT:			return "fexit";
>>   	case BPF_MODIFY_RETURN:			return "mod_ret";
>> +	case BPF_OOM_POLICY:			return "oom_policy";
> 
> This case is not necessary. This block is here to keep legacy attach
> type strings supported by bpftool. In your case, the name is the same as
> the one provided by libbpf, so...
> 
>>   	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>>   	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>>   	default:	return libbpf_bpf_attach_type_str(t);
> 
> ... we just want to pick it up from libbpf directly, here.
> 
I see..

Thanks.

--
Chuyi Zhou
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 214f828ece6b..10496bb9b3bc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
>>   	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
>>   	[BPF_STRUCT_OPS]		= "struct_ops",
>>   	[BPF_NETFILTER]			= "netfilter",
>> +	[BPF_OOM_POLICY]		= "oom_policy",
>>   };
> 

