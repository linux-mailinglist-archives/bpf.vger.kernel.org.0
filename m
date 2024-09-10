Return-Path: <bpf+bounces-39396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B24972744
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 04:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98139B23B3F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0F144D1A;
	Tue, 10 Sep 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfA4FAnd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A729A5;
	Tue, 10 Sep 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935762; cv=none; b=u3GKkhxAYUlPHJDlleTpeOObaj4BBuYlXnmdpoL0IEXCkEGI7TyEzXYQpu7AzgT1Vg2cc4ENdvhkdIyTE48uFmZPyeBU982hWlSKKvda2N097f0eav1Muk+x2BrZBWPPvxAl2PGKyh6tmLl7kb0IU/9fYCDn6mOcMveRFsPArVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935762; c=relaxed/simple;
	bh=Evrw4jPTb8sQKnWn1EeetFjxPJDGfxPzMtAUbGAPutI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb8c3Rs/H83AXRh/Xp6tBpMn8En1PSr1b+Nd0WYAlUUsq7Ykj+59xNGhrhrcAwb4ICHyTVWCu0ToAN5+hepUqCrUV08VSU0UEi6LG4tIqwm/P8C2wUdvIrB+uKsNzYpmk+R0/7XdpHflbdQyrGTTx8S6eZUjHiS9qRDob/s8MJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfA4FAnd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3602589a12.0;
        Mon, 09 Sep 2024 19:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935761; x=1726540561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE7gaUdr53L3Ek05TeiNCSgKORnvJlJCxbK/ufUljJI=;
        b=TfA4FAndxUsXcAIo81SWtMgXccxHcomusAjpIK1HN/GMJRl5bcFiAp5G9t87QDBkj2
         y/yUr/UjUiJzrd98SufVdnuCyD7HhLlSftTh0ZptVdMAGR4t8tty7khcuGe8DMchtviY
         JDcJUuM20N40dUOsp9NJdxENfOKd8EaSngMwAoNXb3PIKla1hzflRbcc/9d/YTrd6SQH
         o+jxOvOe1LQgK+MywJmBszkQODRleznR6YdoUyd4DY5WEa4TXscGu/PYetxpY1oZRpa/
         tM7zMFx+pxtsfw6HIRJqF+ydDo9I3TPEboq1lNWS9mlN0QTeDy64PUsmPtVk8vFkTOlK
         cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935761; x=1726540561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KE7gaUdr53L3Ek05TeiNCSgKORnvJlJCxbK/ufUljJI=;
        b=nvILRjpVby87OxdhKXPRR9jth93+38jSR17mHrc8GFKnp6lY2bpLjwufCPK0cZSp6g
         FXJCWAlAMliVleuzLnsMu8ABj+qrUiGK4tv9Qek2l1H0RvSZM2JrAZVumKKn7z7HqlgV
         lUhxfCrOdWq8mtcXe9iYbC6OzkBVqMYJ2U8XKuRhL+Wk7TcjjUppavTKWcsa9pG/j0DU
         K+TW2lSzyloaU1MH0VINDWAHO3jvmxSicPNNlhbQq3G0iViTQgEHZmILrTKxwOpOOFeV
         J35WmOYOLUgmkyqJn7/UyqWfqdK0XyrVVueUYPFflYnex0Mz1rvB7oCpxz352rqqqJI5
         pABg==
X-Forwarded-Encrypted: i=1; AJvYcCU96U7pFi1DtlCbEaBb6ShFJH5Axrr3TTtCIjLg/Fi+lYegy9+KcDi7k2U7Wd+vpzgNnT4=@vger.kernel.org, AJvYcCX+pN7TWtONnhf+z/S1xxKfHp0AI2ttmQgbGN3mpza/IAGvICGfBmj838bnQ4TxdLREIoiZ7MelEGkfsoS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLaSGzBWFnX+nQdTtXbFDeLXxj70/nYmij0K2gTNl8opwHquS
	moelpWok/V4t5NCwVDAIgytLrBupI/3PKba5s78UyfMy3qEyi8Cr
X-Google-Smtp-Source: AGHT+IGGDuBgh+TS1hY/fAwTnpxC3Kw2QtydmXz6gxJ8uIjXvwXZzVJU+o685Z5ZtifuYntuM3qD2A==
X-Received: by 2002:a05:6a21:4a41:b0:1c8:92ed:7c5e with SMTP id adf61e73a8af0-1cf2acabd28mr14573841637.23.1725935760620;
        Mon, 09 Sep 2024 19:36:00 -0700 (PDT)
Received: from [172.23.160.213] ([183.134.211.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d82373635esm4570811a12.13.2024.09.09.19.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:36:00 -0700 (PDT)
Message-ID: <a82347fb-717b-48d8-8b8f-c62ac6b95929@gmail.com>
Date: Tue, 10 Sep 2024 10:35:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH bpf-next 1/2] bpf: Check percpu map value size first
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jinke han <jinkehan@didiglobal.com>
References: <20240909071346.1300093-1-chen.dylane@gmail.com>
 <20240909071346.1300093-2-chen.dylane@gmail.com>
 <CAEf4BzacVxXwM7LaKu7Mj7toZuXc1+TF6-j-z+fZ85dXiUg0oA@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzacVxXwM7LaKu7Mj7toZuXc1+TF6-j-z+fZ85dXiUg0oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/10 04:17, Andrii Nakryiko 写道:
> On Mon, Sep 9, 2024 at 12:14 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> Percpu map is often used, but the map value size limit often ignored,
>> like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
>> percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
>> can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
>> like percpu map of local_storage. Maybe the error message seems clearer
>> compared with "cannot allocate memory".
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> Signed-off-by: jinke han <jinkehan@didiglobal.com>
> 
> names in SOB should be capitalized

Hi Andrii，thank you for your attention, i will change it.

> 
> the check is useful, so:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> ---
>>   kernel/bpf/arraymap.c | 3 +++
>>   kernel/bpf/hashtab.c  | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index a43e62e2a8bb..79660e3fca4c 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
>>          /* avoid overflow on round_up(map->value_size) */
>>          if (attr->value_size > INT_MAX)
>>                  return -E2BIG;
>> +       /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>> +       if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
>> +               return -E2BIG;
>>
>>          return 0;
>>   }
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 45c7195b65ba..b14b87463ee0 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>>                   * kmalloc-able later in htab_map_update_elem()
>>                   */
>>                  return -E2BIG;
>> +       /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>> +       if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
>> +               return -E2BIG;
>>
>>          return 0;
>>   }
>> --
>> 2.25.1
>>


-- 
Best Regards
Dylane Chen

