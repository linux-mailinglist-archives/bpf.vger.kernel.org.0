Return-Path: <bpf+bounces-53860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DBA5D147
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB7A17C56D
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DC264A88;
	Tue, 11 Mar 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAefXhOM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F826462C
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726777; cv=none; b=AK89sSik69e3+a5xZXknaASS+wNItz5WZP7m+eDzbf2iJ0/d99ktxyCmyZuLKJppF0m4D8QNd/FSw+AIpZ8nsilVLX6Ag2hwmnxvOuEIEhUobZu+WCYu7Wa9tbD/LncrjYBig4/Hd+VL3HNBFYdrhhDsoWAXxwOwN/uZH+V6tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726777; c=relaxed/simple;
	bh=SzzeK2NHDvckTYxfIjc9JKcX38gs6dHCiEaGdvgG56c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnXDKTaAsjIYULaFIUygR7JTFyo7w6jxyt9FmYhGN1wRysOuio0mew6tVAxOaLTzVm9/CZL2jc4nLDt5GThXw8SLeTIBOVU/KUGA+8x/fJ7XC+qret8B5oM8Leum3HznnKiGPVsiTq0Lq8j+d9Aslzexg22NcKEmGU57lQOjpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAefXhOM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so9749435e9.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741726774; x=1742331574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZnxQmkTArtGjnoYa4TWueByQQPM0oxUdmU88z3Jfmw=;
        b=CAefXhOM1qE7Walvi8TEirZjZfCZ+EhDSfw8iStf06NYBAqPZMiA8DCAeDxpwep6RV
         vn4CxWyys5KVJ84wMc6yYpLZ2ozPobSmTWy+vjvxYQz8MRZ02lZA+PSGn/HHQyCywmn9
         h+ePVYGSicIteOY0uIPlTk6wzZB3wiO271A/WcsMo4I+fNqIrIEccw1rAhlRWknJcxSl
         4VCzXqr2PBFX23lEyxfN1NMVUZlOED6WpT1vIAHFXE0Kj8A0LLKEzQr4RE+fH/hV0obY
         k3qTlRBhdNO2qM0rRvOYTzF+sVF5evNUKx4Cbw/d61XhaMu3ShCopaUQHEVBusg2JrvV
         pyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741726774; x=1742331574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZnxQmkTArtGjnoYa4TWueByQQPM0oxUdmU88z3Jfmw=;
        b=LhWhc8JUQj5i6qfHDJ4LEVVavlgPPNRbiamd6+/pEFvuvgz82wFUcj95w/0ec25ZST
         U1LOZ2DiYmSBu/YqzzyyUDjsZ4nm9ORzBnlRU+7maSqlXVh8jOqJRwR46k1RLdGpsMO0
         7Au7qfZtWhsAHEGk54oU5RJT7SgVpllWQtR7ernSHyum9NWiOX3VgvIOKwc6FOj/ZKVC
         x6BdS73/Ip6gzI7jX+gTjmEHqp61/9FTqOQzUgD4ix/kpcy1FZvf/UgcaZMtTuMCKVxo
         vkVoDqUL96zronX9aVlJmAW/YQkdhnnNKqdHHwpZveEZfPDjztvLOPXlmdyFFyfcgDdY
         leNw==
X-Gm-Message-State: AOJu0Yxka6GU05ix1W7TPDuHcB8x8RWWNhVglLKJ90RI0hi2Li1d7xuR
	uF/scyIBawnypJ/5jxusscz4M6UgturAr8ArjkhtNjc5aQ+0guDY
X-Gm-Gg: ASbGnctcDWe8Fx7XyYXY8xMWFqqj4OKob5HikZCVM9FiPgWpWlj7ci+ydkuGJPBFPnY
	EGnwTFy6KsplY0SDkXt15evXNpfnC9Zzw6aEfZEoqJMCY/rQwnYP2bekMv4E3HcWyjyv5GBYyDV
	U6zDyUcFl1eoSixDcpD7a6k2cnMuaLbEc6mkLznDfJxfs+EJ/otmLXzRLgRLdSps+W4Esn1C5X+
	A9R8oHu9L42+u0KXfwd4b73dKVrwyl7PyVgkrVrHH25XmfZQrEpY2SRO9NBMFXDms7r85GDXsXA
	bq0LmN9+6s+GvuYYDPfl1kSEdDvx8s92V1IbYczEFsY82wnVEjPy734duW1QjV6KTsSW4B0n9pF
	5BN99PNjnWOgkBLCq/G/tJpGKVGfhhxgbvkOPgx1X
X-Google-Smtp-Source: AGHT+IHibBLpP1+Y42YrUGIvjdHi7DP3xyyV94niDIU6iZi15kJXuGNewfImqsqEdJg12Smmvalllw==
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr137973955e9.0.1741726774073;
        Tue, 11 Mar 2025 13:59:34 -0700 (PDT)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5f48sm610275e9.28.2025.03.11.13.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 13:59:33 -0700 (PDT)
Message-ID: <9bffe513-9c0b-4d9a-9876-1d8620753b56@gmail.com>
Date: Tue, 11 Mar 2025 20:59:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, olsajiri@gmail.com, yonghong.song@linux.dev,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
 <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2025 15:57, Andrii Nakryiko wrote:
> On Sun, Mar 9, 2025 at 5:13 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
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
>>   include/uapi/linux/bpf.h                      |  1 +
>>   kernel/bpf/syscall.c                          | 21 ++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h                |  1 +
>>   .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
>>   4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>                  };
>>                  __u32           next_id;
>>                  __u32           open_flags;
>> +               __s32           token_fd;
>>          };
>>
>>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 57a438706215..eb3a31aefa70 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5137,17 +5137,32 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
>>          return btf_new_fd(attr, uattr, uattr_size);
>>   }
>>
>> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
>> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>>
>>   static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>>   {
>> +       struct bpf_token *token = NULL;
>> +
>>          if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>>                  return -EINVAL;
>>
>> -       if (!capable(CAP_SYS_ADMIN))
>> -               return -EPERM;
>> +       if (attr->open_flags & BPF_F_TOKEN_FD) {
>> +               token = bpf_token_get_from_fd(attr->token_fd);
>> +               if (IS_ERR(token))
>> +                       return PTR_ERR(token);
>> +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID))
>> +                       goto out;
> Look at map_create() and its handling of BPF token. If
> bpf_token_allow_cmd() returns false, we still perform
> bpf_token_capable(token, <cap>) check (where token will be NULL, so
> it's effectively just capable() check). While here you will just
> return -EPERM *even if the process actually has real CAP_SYS_ADMIN*
> capability.
>
> Instead, do:
>
> bpf_token_put(token);
> token = NULL;
>
> and carry on the rest of the logic
Got it, thanks.
> pw-bot: cr
>
>
>> +       }
>> +
>> +       if (!bpf_token_capable(token, CAP_SYS_ADMIN))
>> +               goto out;
>> +
>> +       bpf_token_put(token);
>>
>>          return btf_get_fd_by_id(attr->btf_id);
>> +out:
>> +       bpf_token_put(token);
>> +       return -EPERM;
>>   }
>>
>>   static int bpf_task_fd_query_copy(const union bpf_attr *attr,
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>                  };
>>                  __u32           next_id;
>>                  __u32           open_flags;
>> +               __s32           token_fd;
>>          };
>>
>>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> index a3f238f51d05..976ff38a6d43 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
>>          if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
>>                  goto close_prog;
>>
>> -       /* BTF get fd with opts set should not work (no kernel support). */
>>          ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
>> -       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
>> +       ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
> Why would your patch change this behavior? and if it does, should it?
> This looks fishy.
I agree this does not look right, I think the test itself is not ideal. 
The behavior this test checked for has changed,
  `btf_get_fd_by_id` was returning EINVAL from here:
```
if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
         return -EINVAL;

```

That no longer fails because I added new field (token_fd) to the attr 
structure.
Function now fails further down the road.//I'm on the fence whether 
delete this check at all or change to new error code.
>>   close_prog:
>>          if (fd >= 0)
>> --
>> 2.48.1
>>


