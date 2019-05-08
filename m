Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24281767D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEHLMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 07:12:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32936 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHLMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 07:12:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id s18so1686639wmh.0
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yq+etagCNVSVCw5p8c8MZYqUSrJv1k6ToHgQpJI1qU4=;
        b=mEn86jPwY/79Z9jIQnNc5wfVh87VTUvhWrjwrmPWzc82jBO2kbDyQ2LU+cZbRSGUoA
         Qq3cEPXRx5vsrYVeBH16Q9Ssxs68IxUvb8ozHRWAiZ8k9aaJm0u5g9VGL/CiKZ/UnW0T
         cQRTv96jpZdPIJDp2LMWzgnwQfNjqwWXa3dpSw5+AYcAllFVpY0NJoSSqqUqqdaln0nd
         WXzYuhwl43OlpCmWHcP0RueChc6DLLYNhu9YtuBelXgmgn2TPXLvzE6SsZQffmWH+B5E
         mj5IyY1i3EgZFKPWOYNiRz2PYqRSooyThdbrFgAMzEPM+L4ETCFsxdEgrQnmdnhzXKXW
         lG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=yq+etagCNVSVCw5p8c8MZYqUSrJv1k6ToHgQpJI1qU4=;
        b=BntHHwB47UkPYVAx6KsGk0RZAhSyamGexrNutXZm5PMNYjjCt8s6cOpG6jOUAuARkd
         4E5MuMCk4H3FRZwLnNbFNucJIV0E9eqRlU9QwdO5RhM9CzY1tvTcB8HJtKbu8NT0LMfp
         Wp2i0N5GxxMaSmDhvE2f3CEYLg3GEfd01tf3PpTL3EYjBg8AXQbIO3yeGn7ENZSgeutj
         q3dSm/KJzJClc0Lcl71EG299feyNMCGfB5chwN0YBVATYJfkGtCCwivLCnz5mlMh7/Md
         lt6MDRobtOpENg6AaW6WhctGpiK26iAsKppGP33ZPXe0UzW2VBuvTBa0F2IrD4W1bY71
         fOgg==
X-Gm-Message-State: APjAAAXK8zJJtb86gZPedb/QA/sW2bbXv3tc/i89dwTjVH8/pmzp38z7
        ZQ0gwuTv7CEWL3Vh+hqpJ+GX2w==
X-Google-Smtp-Source: APXvYqwXw8Kpi5ln2o51r89ANh81kO5r7d+zpyLvi/DLeWpKXFEIh1Vu5MuZsTTxFrAQWN5GXF3qSg==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr2657022wml.36.1557313931664;
        Wed, 08 May 2019 04:12:11 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a4sm2530011wmf.45.2019.05.08.04.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:12:10 -0700 (PDT)
References: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com> <1556880164-10689-2-git-send-email-jiong.wang@netronome.com> <2c83afa7-d3ba-0881-e98f-81a406367f93@iogearbox.net> <87k1f3usnr.fsf@netronome.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH v6 bpf-next 01/17] bpf: verifier: offer more accurate helper function arg and return type
In-reply-to: <87k1f3usnr.fsf@netronome.com>
Date:   Wed, 08 May 2019 12:12:06 +0100
Message-ID: <87o94d6vzt.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Jiong Wang writes:

> Daniel Borkmann writes:
>
>> On 05/03/2019 12:42 PM, Jiong Wang wrote:
>>> BPF helper call transfers execution from eBPF insns to native functions
>>> while verifier insn walker only walks eBPF insns. So, verifier can only
>>> knows argument and return value types from explicit helper function
>>> prototype descriptions.
>>> 
>>> For 32-bit optimization, it is important to know whether argument (register
>>> use from eBPF insn) and return value (register define from external
>>> function) is 32-bit or 64-bit, so corresponding registers could be
>>> zero-extended correctly.
>>> 
>>> For arguments, they are register uses, we conservatively treat all of them
>>> as 64-bit at default, while the following new bpf_arg_type are added so we
>>> could start to mark those frequently used helper functions with more
>>> accurate argument type.
>>> 
>>>   ARG_CONST_SIZE32
>>>   ARG_CONST_SIZE32_OR_ZERO
>>
>> For the above two, I was wondering is there a case where the passed size is
>> not used as 32 bit aka couldn't we generally assume 32 bit here w/o adding
>> these two extra arg types?
>
> Will give a detailed reply tomorrow. IIRC there was.

"bpf_perf_event_output" etc inside kernel/trace/bpf_trace.c. They are using
ARG_CONST_SIZE_OR_ZERO for "u64 size" which should have been a mistake,
because "size" parameter for bpf_perf_event_output is used to initialize
the same field inside struct perf_raw_record which is u32. This lead me
thinking people might use in-accurate arg type description.

Was keeping the original ARG_CONST_SIZE/OR_ZERO as 64-bit meaning at
default, mostly because I am thinking it is safer. If we assume 
ARG_CONST_SIZE/OR_ZERO are 32-bit at default, we must check all helper
functions to make sure their arg types are correct, and need to make sure
all future added helpers has correct arg types as well. Otherwise, if a
helper function has u64 arg and it comes from u32 zext, forget to use
new ARG_CONST_SIZE64 will cause "val" not zero extended, and it will be a
correctness issue.

  u32 val
  helper_call((u64)val)

Instead, if we assume existing ARG_CONST_SIZE/OR_ZERO are u64, it just
introduce redundant zext but not correctness issue.

Regards,
Jiong

>> For ARG_ANYTHING32 and RET_INTEGER64 definitely
>> makes sense (btw, opt-in value like RET_INTEGER32 might have been easier for
>> reviewing converted helpers

>>> A few helper functions shown up frequently inside Cilium bpf program are
>>> updated using these new types.
>>> 
>>> For return values, they are register defs, we need to know accurate width
>>> for correct zero extensions. Given most of the helper functions returning
>>> integers return 32-bit value, a new RET_INTEGER64 is added to make those
>>> functions return 64-bit value. All related helper functions are updated.
>>> 
>>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> [...]
>>
>>> @@ -2003,9 +2003,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
>>>  	.pkt_access	= true,
>>>  	.ret_type	= RET_INTEGER,
>>>  	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
>>> -	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
>>> +	.arg2_type	= ARG_CONST_SIZE32_OR_ZERO,
>>>  	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
>>> -	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
>>> +	.arg4_type	= ARG_CONST_SIZE32_OR_ZERO,
>>>  	.arg5_type	= ARG_ANYTHING,
>>>  };
>>
>> I noticed that the above and also bpf_csum_update() would need to be converted
>> to RET_INTEGER64 as they would break otherwise: it's returning error but also
>> u32 csum value, so use for error checking would be s64 ret =
>> bpf_csum_xyz(...).
>
> Ack.
>
> (I did searched ^u64 inside upai header, should also search ^s64, will
> double-check all changes)
>
>>
>> Thanks,
>> Daniel

