Return-Path: <bpf+bounces-58106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0FAB4D74
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D1161562
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7917B1F1909;
	Tue, 13 May 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp07Y/Sm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CCB1E2823
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123134; cv=none; b=jTw3Ro2b65KIJgLlTq9n8DO2dgEjQjfYB9zEnVCeEGBoU3dgJN+y45VCPf6q/beeEHRtMSu6H8NqKzRFAH1NL2Ah00DuUGB5yWiABqFRd9B6lokGMdv6uQ4gjOHuwZ8+GcUy5o5viz0r1QegNArlITHOLP2RVRiMHAE5VLy1F2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123134; c=relaxed/simple;
	bh=1iog8uUcAnOfDkstEzE9DVn8MDHx9VVuFKoQnmJOfJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf05sRqbjyhzzmP5VTRd2ZursjHREvlwURQKs3gPZwuW+WyOzgMUcJI2t/9ick1fqvj9tsFNrOJqhq+kmK2Y7/ymXP3F4kKERtjEuTYRKAbSyAIAag63SFZi/oUihn0fbtYdLGBqFsrREX+nNE4fxcc3nXeOOxu/TFt8a09hrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp07Y/Sm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747123131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cXE8wpyS1ZC3ompzzCB3dTE+GWoL3ZRRJxcsK+KblI=;
	b=Zp07Y/SmXiJKguA2avR5oXinKTOetUtL0OaLo5M7MU+vIaZTziDPAQqi8G+d9vgDqJ/0Bi
	7Wdrw7DGKEq8Jha4tNpOYHKJAzS8oQvgQCJokZr00O4DvwGncPF+UL7Gmh0yfDXWQ1MsvA
	o1e/wUI3Swz2EREFqp7N/PwyHQ1i+eg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-bs14UUsOOsStmSp3jApBOw-1; Tue, 13 May 2025 03:58:48 -0400
X-MC-Unique: bs14UUsOOsStmSp3jApBOw-1
X-Mimecast-MFC-AGG-ID: bs14UUsOOsStmSp3jApBOw_1747123127
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0bd786a53so2199606f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123127; x=1747727927;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cXE8wpyS1ZC3ompzzCB3dTE+GWoL3ZRRJxcsK+KblI=;
        b=xHgwko6TUQJzWDp6EGlwNg3GxxtR2R3XaXb9rn+52mhBcFMrjU3/JJOnTMZntC3xQm
         PZ0DtnpxWmp86JVnRdR+kIaEqKUAe2yU5M34GCMfSJe2/h4t1TVhzFUKdi8axuc1kjso
         SltJq0lB5jtfOISWovHlwtD+SdiNb6K/nYLJWRF6gTi9Bh6LwtCJzXZQRQX/XwzMR7i8
         Q5TTB7zgpdrJd47lQkaJ60exzfiFKA2SjLRORi0fcCDVrzaFVNmO1UFWMOrOqDTZi8eZ
         Ifm3R/942qrkDSZNOxYiNFTX7ZOAzpPs8CJSU3pc+esU1IEjcqVy4dnXRzH1CwVsiZwo
         BDzQ==
X-Gm-Message-State: AOJu0YwH+ruvh6A9SHJbGmw/cmfKS2YZTciDyiZRBix4E5uuURX5z93U
	76IXChA/OC45dz6Hpxgo2mZbJt5YaAmvQSWSJS5eYA+W/XqEdgXDr2wRelCEYQI7vsDyqXnTDeX
	MqPcpth4lCquVyIRB5g7GXE91MMFYmbNoPOtw0Mxe/XGnKUFP
X-Gm-Gg: ASbGncvDkUejKWsZ8u3F+755zGgnoZCS/+fpFURBdvlvAdF2OedJUzRfdYhx+0YDZVQ
	Aobc8jTVadfR1qSee0tJcpDvVt3NsqX9PB2Z/P6UKAoYB61LaO60lLY0QW5Ldsg6WvuQxYH0pZL
	8ZUFRMuZi40A7G4Q8jN81Zbl8EP2er/+dt6sFbxReAMN7oMc1uI6ALyTds8iINB43PFO2mfIcSO
	T/VpeNOxo9sfdMMVdRx4S1rg4mUghOD09YSIn2AE0eTJ21Q+cxd1+UHhNMEUAr5AB94rxfP6D6Z
	fYDwBXo=
X-Received: by 2002:a5d:64ae:0:b0:3a0:b294:ccc8 with SMTP id ffacd0b85a97d-3a1f64b43d9mr11561519f8f.59.1747123127124;
        Tue, 13 May 2025 00:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDw83IBy2aXEGjILBXG7nLSTIpKVnrJIPQAltoBRpc1okW6OLS5A/k5+oqvuCHFaga6vOZuw==
X-Received: by 2002:a5d:64ae:0:b0:3a0:b294:ccc8 with SMTP id ffacd0b85a97d-3a1f64b43d9mr11561492f8f.59.1747123126750;
        Tue, 13 May 2025 00:58:46 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ee95asm15356312f8f.11.2025.05.13.00.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:58:46 -0700 (PDT)
Message-ID: <ac10c2c6-c8e5-40ae-b932-f647ca54a855@redhat.com>
Date: Tue, 13 May 2025 09:58:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs as
 args to kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1746598898.git.vmalik@redhat.com>
 <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
 <aBx0qmVvL84Jb3rf@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <aBx0qmVvL84Jb3rf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 11:08, Matt Bobrowski wrote:
> On Wed, May 07, 2025 at 08:40:36AM +0200, Viktor Malik wrote:
>> When a kfunc takes a const pointer as an argument, the verifier should
>> not check that the memory can be accessed for writing as that may lead
>> to rejecting safe programs. Extend the verifier to detect such arguments
>> and skip the write access check for them.
>>
>> The use-case for this change is passing string literals (i.e. read-only
>> maps) to read-only string kfuncs.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  include/linux/btf.h   |  5 +++++
>>  kernel/bpf/verifier.c | 10 ++++++----
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index ebc0c0c9b944..5cb06c65d91f 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -391,6 +391,11 @@ static inline bool btf_type_is_type_tag(const struct btf_type *t)
>>  	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPE_TAG;
>>  }
>>  
>> +static inline bool btf_type_is_const(const struct btf_type *t)
>> +{
>> +	return BTF_INFO_KIND(t->info) == BTF_KIND_CONST;
>> +}
> 
> I've seen btf_type_is_* related helpers lean on btf_kind() instead
> here, which ultimately just wraps BTF_INFO_KIND() macro.

This function is using the same style as 7 btf_type_is_* helpers
directly above it so I don't think that it'd be doing something
non-standard here.

>>  /* union is only a special case of struct:
>>   * all its offsetof(member) == 0
>>   */
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 54c6953a8b84..e2d74c4d44c1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8186,7 +8186,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>>  }
>>  
>>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>> -			 u32 regno, u32 mem_size)
>> +			 u32 regno, u32 mem_size, bool read_only)
> 
> Maybe s/read_only/write_mem_access?
> 
>>  {
>>  	bool may_be_null = type_may_be_null(reg->type);
>>  	struct bpf_reg_state saved_reg;
>> @@ -8205,7 +8205,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>>  	}
>>  
>>  	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
>> -	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
>> +	if (!read_only)
>> +		err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
> 
> For clarity, I'd completely get rid of the ternary operator usage
> here. You can short circuit the call to check_helper_mem_access() w/
> BPF_WRITE by simply checking the error code value from the preceding
> call to check_helper_mem_access() w/ BPF_READ in the branch condition
> i.e.
> 
> ```
> err = check_helper_mem_access(..., BPF_READ, ...);
> if (!err && write_mem_access)
>    err = check_helper_mem_acces(..., BPF_WRITE, ...);
> ```

That's a nice idea, thanks! I'll definitely use it in some form
(depending on how we end up representing the access type param).

> 
>>  	if (may_be_null)
>>  		*reg = saved_reg;
>> @@ -10361,7 +10362,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>>  			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
>>  			if (ret < 0)
>>  				return ret;
>> -			if (check_mem_reg(env, reg, regno, arg->mem_size))
>> +			if (check_mem_reg(env, reg, regno, arg->mem_size, false))
> 
> For clarity, I'd add: /*write_mem_access=*/false). Same with the below
> call to check_mem_reg().
> 
>>  				return -EINVAL;
>>  			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
>>  				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
>> @@ -13252,7 +13253,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
>>  				return -EINVAL;
>>  			}
>> -			ret = check_mem_reg(env, reg, regno, type_size);
>> +			ret = check_mem_reg(env, reg, regno, type_size,
>> +					    btf_type_is_const(btf_type_by_id(btf, t->type)));
>>  			if (ret < 0)
>>  				return ret;
>>  			break;
>> -- 
>> 2.49.0
>>
> 


