Return-Path: <bpf+bounces-39906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C91979175
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E351BB21B62
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713F1CFEDA;
	Sat, 14 Sep 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYa6sss7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C61DFFB;
	Sat, 14 Sep 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324172; cv=none; b=C+QTv86gPPBcaE3kkgelXvuTEBOibtSkWGmuXTpk4qXJEa0wiS5hV02Pa43nP6m03XBEfUXDI+CFpjUh82S7XTjv1fj57G5YtZ5Jv3U5mf9/PiRZqo4BawhsXf7kFnpatTUT9FLPXtzQ3yYOtxkqL/RQ31AqD3XGMRfPf0Vg1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324172; c=relaxed/simple;
	bh=bgCF+lluRA2WuiJqw0NHJOlFygDGRxtlmzNq2BPt9iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BohqXgmA6p9u3cfA0VDPl1sMeKTtbxgGTSAvAmw9UnWcvA2sBOZW+QJuTOgbuVfq6gsx9CqODLP7SW9UbEpJtKWbXebUZ5TIy8rNvEn4vKyN/4YJ7cxBc5Z9Q2DmRZnLBGbpJD4fH8dzowFYY9bzgvUo/v/Oy+mlu9Cyz5DEU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYa6sss7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068acc8a4fso17180995ad.1;
        Sat, 14 Sep 2024 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726324170; x=1726928970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSXSIcNr77WYcFIb8vJKuv8ioBiiEihzOOEaWLENPDg=;
        b=jYa6sss7maN2C87gO0juWrKE/ku/mblmj0O7NxRMH7Ie6DtEdmMod1Ek5YZpFTKijk
         sPzYyJWyd3W0si1UrsV+ZAe6/DtDC9k1VlYJtLI+50/A08WoIdUWhcq+zt5yuNt1F5Kt
         OiJWcQ3u/VsXgrLJ2WCb2leeqOKY+3VTlQHBnaBzf2dcjF8LkfPRgMF/DV6fbbYA5j3z
         nSLW+L1ISAMr/S+zhHtRu8RATIzzPVWR2t3JZLtUCuCvBDKl1lH3eui/mMuWNkUjCJLK
         EqmuUhZD84NBnLfp88fXpTi2QEuWE7Oq7+YdGUGuBuroGUMfJINRPFPkLwrOLeXwkKUq
         inzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726324170; x=1726928970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSXSIcNr77WYcFIb8vJKuv8ioBiiEihzOOEaWLENPDg=;
        b=eP2SwK5RhSLcPr/clTw0gPoTFw/o3dJqj36TEvZav5skS9ELphr022I7X3XNGSxfXq
         Lultzsapcp4URLeRLXpvMr6Eo/5VeXETaknM/dQ7WHoT5A1IcEA6Jhy6JGyjmp3FylQi
         +R3dHqPxfO4ix0Nbtim+yZ8rkiQaFr1NgCR1RaNy2V4VTlo5CLDNtBGuL4lzFOH7FrnU
         R9l0AaPqgt5LhIr+TF9u+QwWOiv09H62W13uAaTpJQc9RYumw5w+/W6Ao8IxL4Qbn5+W
         3oZPZZlzPDqfdAaQu1SartAv0G8swNc9nUaG3449Hl7f5l7wjUSBDIReooNF1Dvi2unT
         zmsA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfOjM23MqrGo4WLPK2Rp6ZwKFk8+9pU+Y2Lx0QM58YULL/tZycl8SwXELOpyPMnAuvrAgRMgSbe3AFS03@vger.kernel.org, AJvYcCUr3xILvUV5eCI605KJx6xXYqBsTB+Snllx2xowipgKfPZx6eExYZk2hQ/iI3TIVyhuOYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuxJIVA/2QLa6WZIk1NAnZ6Ha8ljjlUW9kJBYuwEhB+RFFChf
	+4JjmiApJnPDgZCa+TcpcSPxGZZ71Hzc24E8C+OTMdNrmtbZXGBY
X-Google-Smtp-Source: AGHT+IHJNlk3r95fZ3ZWtmd26uKc2mx4UxyrgLzt9r4BjOf09md6wjRevV9fucIZ5+GkW0untZqXYg==
X-Received: by 2002:a17:903:18f:b0:202:4640:cc68 with SMTP id d9443c01a7336-20782c16ca8mr93933565ad.59.1726324169705;
        Sat, 14 Sep 2024 07:29:29 -0700 (PDT)
Received: from [192.168.2.35] ([183.141.49.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1686sm10209695ad.165.2024.09.14.07.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 07:29:29 -0700 (PDT)
Message-ID: <159cbaff-e900-4565-a4a6-b59caa84a105@gmail.com>
Date: Sat, 14 Sep 2024 22:29:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next RESEND v2] libbpf: Fix expected_attach_type set
 when kernel not support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240913164355.176021-1-chen.dylane@gmail.com>
 <CAEf4BzZk4onktrnK-i7CQUrFAPEo24G9p5RZhpg0nrhYxU5EvA@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzZk4onktrnK-i7CQUrFAPEo24G9p5RZhpg0nrhYxU5EvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/14 04:46, Andrii Nakryiko 写道:
> On Fri, Sep 13, 2024 at 9:44 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> The commit "5902da6d8a52" set expected_attach_type again with
>> filed of bpf_program after libpf_prepare_prog_load, which makes
>> expected_attach_type = 0 no sense when kenrel not support the
>> attach_type feature, so fix it.
>>
>> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> Change list:
>> - v1 -> v2:
>>      - restore the original initialization way suggested by Jiri
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 219facd0e66e..df2244397ba1 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>
>>          /* special check for usdt to use uprobe_multi link */
>>          if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
>> -               prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>> +               opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>>
> 
> Ok, took me a bit to understand what the issue is. But the above is
> not quite correct, for the above case of setting
> BPF_TRACE_UPROBE_MULTI we do want to record BPF_TRACE_UPROBE_MULTI in
> prog->expected_attach_type, because user might want to query that
> later.
> 
> So I agree with the part of the fix below, but here I think we need
> *both* update opts' and prog's expected_attach_type, so we will have:
> 
>         prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>         opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> 
> pw-bot: cr
> 
>>          if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>>                  int btf_obj_fd = 0, btf_type_id = 0, err;
>> @@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>>          load_attr.attach_btf_id = prog->attach_btf_id;
>>          load_attr.kern_version = kern_version;
>>          load_attr.prog_ifindex = prog->prog_ifindex;
>> +       load_attr.expected_attach_type = prog->expected_attach_type;
>>
>>          /* specify func_info/line_info only if kernel supports them */
>>          if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
>> @@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>>                  insns_cnt = prog->insns_cnt;
>>          }
>>
>> -       /* allow prog_prepare_load_fn to change expected_attach_type */
>> -       load_attr.expected_attach_type = prog->expected_attach_type;
>> -
>>          if (obj->gen_loader) {
>>                  bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
>>                                     license, insns, insns_cnt, &load_attr,
>> --
>> 2.25.1
>>

Hi, Andrii, thank you for your reply. I will send v3 as you suggested.

-- 
Best Regards
Dylane Chen

