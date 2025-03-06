Return-Path: <bpf+bounces-53469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4ADA54A32
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 12:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40657A456E
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61A201260;
	Thu,  6 Mar 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7YJRm0V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FCD1EE03B
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262286; cv=none; b=Qj6AIi/T+Xb6R90cO3MiAUK21/OrLhi4qeF1uQawbD7BSBIFeJyvBfhe4AVynBmL3YREQ9wgL3WQUcSu5pa+90hnNShnXz5X3IsOPtJmWMBPv1OO7pshXoPSOwhMBAf0Fyyr/sKrI7f8tb68PO9Ckh4hsZpmqC+ZL9d2/bKT8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262286; c=relaxed/simple;
	bh=WfE4YPSimMu2i90k7oF22gQzwNOG7KK49pRw73hO6Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIklaWeubij6HzpQdKmoQ2SPT58W+jnvGIibkz+BuFMgtK3+NMnUpCBcx3gMBnuA12hbPwok/uqg+kCNdw7Djrp64Pn0blJ8woZ70nTCwJUAeWbPtnJ8NNpk0B2qHRnql0D6xIuEcjxaAIZIGJbGYKez3OSB3Or4vuVYd2Y8YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7YJRm0V; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso302356f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 03:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741262283; x=1741867083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvO4FjvGo6c5HlhJo92YiJw35qbJ48ROkn2wr7M2keo=;
        b=F7YJRm0VL9C+0rBIdALRLSiq+GQxYgtY1f4A81/UpzEZmU7GdpYZgprcTinqLtMxVF
         JHLZEJ9IwR2xw/nHQO5jPVtIJg+IpluS1XbrG5veJi8xfeBWjlO4xMq7KHqi0eJ3ZQGm
         2enWCh5JtetXbmh6Xk88gDMwB9bcRD4be3R+JCW7X3F7LmHHC3OOqwl55mLjRWch9tCP
         xniAFjaSvAuAuvuaJbAs/fIui8GCX2jLFSx7niY32CL6GGzav3cfxQ9Gxz9AGRp168I+
         LxlqK1xGLClte7IOGkOP6ePnyAonzBWyUhaR7i6zeVn60kXtNwP4yeqQDtbxOAu7ZyrU
         k9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262283; x=1741867083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvO4FjvGo6c5HlhJo92YiJw35qbJ48ROkn2wr7M2keo=;
        b=ug+XonE2NsKbhcIGS38eN56KR0XCqbZM+UtN/w3md6EX6XhkttXgoGd2grRI5Mk6CE
         BkrmM+ZGM3JO3jRTaQugWQh0VcTj8eTywbs6liLO8TtteUFCJykzJ8nMBK1B3UcW4MVa
         eD0sgUzxA1PdH6R0hVTwJK0cCi+7I2FRCIqOT0mZzCfLI/5Nxfg77tHKuSuJjT9YW4pZ
         skanIJ6RyGfcTWBSuxVB9KbFEe9ppwaJnl0+kueAWgSvk0zGjH1Vu8iqyNJWqoEsW0/Q
         M2toHIGvGDsshzS4e80zHhZhbk3RGCDrVd9NG16jk5W/Ja5LSr2cOmv3TCDAOnyXLv46
         U/rg==
X-Gm-Message-State: AOJu0YzLhCcHNDSsmUE3a+1n4qYg9uNEeRgpJblsw3vOvIs0s0AF+18h
	t5xD0dNUFWICh3Rfdq0CZw12+zHE5WUM7z0HPHDktiyXhtvs1poW
X-Gm-Gg: ASbGnctW+IesWsup6CzR1/ZQO6eWcepVNro3NpLN4xxcVxqVUffym9IxjWMayE4q/jv
	DGOTE6STuy28vHfcuJsSVhRQCi6xw+CUVgdy6o0VuZAmyWO1LYxqtOSiYeOMDM+Nr9I2nfOlLiu
	kaQ6SzwjQ7HbXUJbbDvOYBahHlWyUZEfVxe6CcKy7nDXwlAbiSHDkboQoL6MmsQYXkI2TWx2E+k
	TEE9mu3qGPrjary17xg+eE+30xtxcJyyLFg8UvPaHDWqYtf01o8lx6FTWoDslKWLGpUBbk8LdJO
	8VRI6w3yFlo2LrSQA6eXBuVG/Zd6M1h7u49YK1naaq0ozPOl3JPQr9YHTfhAtyo20olosca8eAe
	wfmtaCZ/JwcTstg8pc9eomcMLHifhahdQu0Ntt0qg
X-Google-Smtp-Source: AGHT+IE/DfwIYvNlPM03vT/4RqWoFJa6fvTx+G7Wri7NSyTFnKE9zbyovnzCntjivRK45HjTjyWFdA==
X-Received: by 2002:a05:6000:1acc:b0:38f:4b15:32f1 with SMTP id ffacd0b85a97d-3911f7d0b6bmr5757868f8f.54.1741262283176;
        Thu, 06 Mar 2025 03:58:03 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e308dsm1865765f8f.67.2025.03.06.03.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 03:58:02 -0800 (PST)
Message-ID: <20d8eea1-9e32-4a81-acae-dd837e4f78c6@gmail.com>
Date: Thu, 6 Mar 2025 11:58:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
 <20250305194942.123191-2-mykyta.yatsenko5@gmail.com> <Z8lpv0deXTc3J7QN@krava>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <Z8lpv0deXTc3J7QN@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 09:24, Jiri Olsa wrote:
> On Wed, Mar 05, 2025 at 07:49:39PM +0000, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
>> allow running it from user namespace. This creates a problem when
>> freplace program running from user namespace needs to query target
>> program BTF.
>> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
>> support for BPF token that can be passed in attributes to syscall.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/uapi/linux/bpf.h                                 | 1 +
>>   kernel/bpf/syscall.c                                     | 9 +++++++--
>>   tools/include/uapi/linux/bpf.h                           | 1 +
>>   .../selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c  | 3 +--
>>   4 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>   		};
>>   		__u32		next_id;
>>   		__u32		open_flags;
>> +		__s32		token_fd;
>>   	};
>>   
>>   	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 57a438706215..6975d391bb05 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5137,14 +5137,19 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
>>   	return btf_new_fd(attr, uattr, uattr_size);
>>   }
>>   
>> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
>> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>>   
>>   static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>>   {
>> +	struct bpf_token *token = NULL;
>> +
>>   	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>>   		return -EINVAL;
>>   
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (attr->open_flags & BPF_F_TOKEN_FD)
>> +		token = bpf_token_get_from_fd(attr->token_fd);
> hi,
> I think you need to check token in here with IS_ERR(token)
> and call bpf_token_allow_cmd
>
>> +
>> +	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
> and bpf_token_put in here
>
> jirka
Hey, thanks, I'll do this in v3.
>>   		return -EPERM;
>>   
>>   	return btf_get_fd_by_id(attr->btf_id);
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>   		};
>>   		__u32		next_id;
>>   		__u32		open_flags;
>> +		__s32		token_fd;
>>   	};
>>   
>>   	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> index a3f238f51d05..976ff38a6d43 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
>>   	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
>>   		goto close_prog;
>>   
>> -	/* BTF get fd with opts set should not work (no kernel support). */
>>   	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
>> -	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
>> +	ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
>>   
>>   close_prog:
>>   	if (fd >= 0)
>> -- 
>> 2.48.1
>>
>>


