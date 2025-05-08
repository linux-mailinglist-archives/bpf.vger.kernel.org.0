Return-Path: <bpf+bounces-57802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3EAB0551
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688BB9E68E4
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEBE221FDB;
	Thu,  8 May 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXYBvAss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34E220F27
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739220; cv=none; b=jgRpayzOuxBmyiqCiogVmMNQGdpB/+4g/tL9tkGmcdgOKv181eq56TXOo8C9F1pCMJUK9gCjEWyxekruNyj/HfLYGy4DpweS6Vy/fJ30PqBWwYmX4aAcDegy9sfnbHO15pj2VOyeiantWNakMJSUTJ+A6HkSIX7OpKmKH4rGrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739220; c=relaxed/simple;
	bh=ZStPphUHaCgU4CDlkjymemhZsoJpy7lGxPROCv6S5iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoR4qmcMihH9mYrv53PllXSpIVOSLsC5ywu1DzYvU8QLCS7bsTSheb+XAgyRRTIConv4gax2QyiF6ZYaW8l9x/8PkdsOM3m6eqJkwl5x9qpdzUiuS1m1oTAgwWs1VNSPzEsixZ7apX6cikIbyB2dIbSUZ8Hmjz7sYcy8yi3+t4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXYBvAss; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so10850795e9.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746739217; x=1747344017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaSoiIxtkLdSqXJfDIvx7N8QIhCbJtqnm5M0cCF2LFA=;
        b=cXYBvAss9Qn5i+jxzVBkex99z5T8nB7nT8LWfwvl1H7dV/A7uOAHLReOTZvdCNIk1E
         mHHwXCbnDKOQ2GAdhibWdds8+QyfP9/O9iwr2LfXIonnzvejpE07SwsiPFUwM2EL0t9/
         danaHwpxsvzyZHoHQRgak6oEguW42+Pn9YO9y4LNfoHSGO1LOHAwH+MHni6oox1jU4ME
         dvglzJI67+Hhd0NpQxJFHs9udarKTEz2X+OtGzoBbgW79hqDKzXPCxc8/m+cH1If9uYn
         VkH4LmBncPMltTewGSehSfP3LxV7RQnQGMl7sN3bA1ELWXag7YqZzkWVeK55ENQZLf5B
         zQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746739217; x=1747344017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaSoiIxtkLdSqXJfDIvx7N8QIhCbJtqnm5M0cCF2LFA=;
        b=MYCrlj4uxtwPETNTz/WdRtS43TQjvYSG7KH4/SrL1HwdwE7SUjf+cPZ8lagUPOtKk3
         B61P8eFZTBaXljfh4aot635LMivpOouJ+kD6DhLFPdBVA/zr0MPi8JO2LkWWdsCAMGyt
         EREWHsetky3Xt/Ng1pMJx2cHZFLeTVy8BooVrpc76+HR751s6VnD7nxBaGYgzbYlV4GJ
         1lvyt2oI1b/Dqs7IMOAG2OBITFACdKQCa8BxlASZjyw+PoRfHHG6RkSugApaK2CaT8pk
         +tPeVOr7/GrY3Lnjiwuvik+8WSCoH8xJyfWZfZEJZK6InQnLvZnZgdG1l3+NhqDsBpdN
         wvxA==
X-Gm-Message-State: AOJu0Yzxb7tPXsnewpu/yyNmRiAC9g1bj8YYcnPQ9k7sPr3nUx6qBGiB
	Assc8obfADo5FxstsUk40LKxwvcka7emkzWyn4t9nE1IiHUolQ2lw3stag==
X-Gm-Gg: ASbGncs0H7cL64dP5+0ytUzexmo+87ckExWUfbyrfLhJGxYHauXAVnlzNsYCyw45I4e
	wu9e56mpTJBJOrVhYqG5lQLqZ7eeQCBTPF85+EjFFbRIcoSGhXznREDii+biXnt0C73Xmt1Shzj
	d0MTR1vNpYNAEG9wxXyryFWk4XS+KHlzrlg8Own+ESPmFFL+awtcJti0kfmlNMWwqDi+SXZUF2t
	z5iimQnbSCZ3AZKqUPKuIRlrO9QxBroL5+ZnTpnzrpebXpt9QAtKLR1x0qX2uDgyAiMuUxe5psK
	+/HZPwmOVJqDmW9W+RFfDSwg2FT1nIPicHT85xrwfvWI81XPKNKxdhGOkKjpeHjCCjQoPLJNZsi
	9bKmhCeRdNZG/ZD8X40kpew==
X-Google-Smtp-Source: AGHT+IH99JW8H+SInBq13OBrlV1A1yeehOZc0x6uG63LLHy0PfBe+Lg3Vv1ezSujbLOPB1ypepEYFw==
X-Received: by 2002:a05:600c:37c7:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-442d6d3e3cfmr6330415e9.9.1746739216751;
        Thu, 08 May 2025 14:20:16 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm7215555e9.19.2025.05.08.14.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:20:16 -0700 (PDT)
Message-ID: <1b99ae2f-9189-4089-8481-0496615aebcc@gmail.com>
Date: Thu, 8 May 2025 22:20:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
 <20250508172607.158382-4-mykyta.yatsenko5@gmail.com>
 <CAADnVQJxjji_3f6QiKiUwi2Rf96K9cU90kG81dv5nPvGK2VeRg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJxjji_3f6QiKiUwi2Rf96K9cU90kG81dv5nPvGK2VeRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/25 19:28, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 10:26 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int test_copy_from_user_dynptr(void *ctx)
>> +{
>> +       test_dynptr_probe(user_ptr, bpf_copy_from_user_dynptr);
>> +       return 0;
>> +}
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int test_copy_from_user_str_dynptr(void *ctx)
>> +{
>> +       test_dynptr_probe_str(user_ptr, bpf_copy_from_user_str_dynptr);
>> +       return 0;
>> +}
> ...
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int test_copy_from_user_task_dynptr(void *ctx)
>> +{
>> +       test_dynptr_probe(user_ptr, bpf_copy_data_from_user_task);
>> +       return 0;
>> +}
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int test_copy_from_user_task_str_dynptr(void *ctx)
>> +{
>> +       test_dynptr_probe_str(user_ptr, bpf_copy_data_from_user_task_str);
>> +       return 0;
>> +}
> you probably need pid filtering here.
> Otherwise in test_progs -j case these progs might trigger
> before test_progs had a chance to setup:
> +       skel->bss->user_ptr = user_data;
> +       skel->data->test_len[0] = sizeof(user_data);
>
> Or use syscall prog type instead.
Makes sense, thanks, I'll send next version with the pid filtering.
> pw-bot: cr



