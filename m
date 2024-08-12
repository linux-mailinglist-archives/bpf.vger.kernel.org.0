Return-Path: <bpf+bounces-36911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDAB94F5B7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07622825C7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8E188007;
	Mon, 12 Aug 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxPRfqsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F92187FEE
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482911; cv=none; b=balbfEnX7g4peLJHQ9MlqLfC+AbnAunW7FV+7O6x5hrm4Fms2cQhJ5MPRN1/a0QMvW3zTePXMdrs1ggzKx5UZOWoinCEoGRKqFYwv+/v0wF5ehuV255VgDXW00RDuTa4arZG4Dh62IUQ/05//MnuCw+70n1Ljpwkh1Y4kK1+ycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482911; c=relaxed/simple;
	bh=AdQlTl3zx3Mz9EEZUfqs9I7uVkXhzkPIm1duAJAacbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSUmbBAV1Zm8WDrKAX6qG3l/25a65WFTW+flMIpLNGZwyJxPxKCjiR08ywTVrKw6oxyfnDrVwPpJMrnTLYTAbyWHjusUxgHlOMjNJmZ2tpnLukg7dT4p5IxM2k+BhdNuvMd6DCrUvK9m7kEQceDL/aieNy0+7CCpBAMck5SdORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxPRfqsj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-691bb56eb65so43155007b3.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482909; x=1724087709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIzALBc/ArO5S62QxFzByc8PlT/szn2bzbUKaoyLbt4=;
        b=MxPRfqsj0XhWET8gZKCZB48SUjBuyVdQ8+fhrbTXQ+tT17VNVzjy+euTup6aqiteVF
         kfR5JnoYMlrPcZ9ixaOs47hgtYy1EyJobDgenNSbOVI/gKX62s9d26gnLqA8iHqq8BOn
         fQiGy3ChOAujEmosDBlbFR1IXs9jPYKwunCFgnJAIPgrzsjGkR0fZNfOxMnrD2QMn67T
         FwrcHxbCiK33Xnq9gs9nY9XzIDYADPmFQtwZcPlIF89C55aRvzlvm4J99FsDOQd7O04F
         d8/Tqkc2lpEqYI2UqURXWVwiP0ivtprX2tBaqqNIw3cUO8g7kcMnbEOpEARG0yXzosKv
         nePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482909; x=1724087709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIzALBc/ArO5S62QxFzByc8PlT/szn2bzbUKaoyLbt4=;
        b=hIYP5vbB/apsDi26+JioMHJ6HgE8cND8cb9cUFDIyeIgs4io3qyzCrTlSchEPIhduN
         LiQ5/wC3ReeHVa8+P/Fq2G6p28E5Q7I1B2Q1T9v1FTjEj3Bj9OP91p1Ui1HD7DsrJXVL
         45ESBhOOArFwnoOuz4G+663P2KiWwznQHcCCajoaWJZyhy6B7XzFpQlxbjOs+uHucvfV
         6irkmIdOGOwtCs2IBZXbJv+V8t15sQF2lx9t62WmmgO4V1rqtNk+8n7nnyhCDsXoBKgs
         cDiK7DN9AgxDjGAfbEFRYmNdeACapBXqgMQtYiIYVi/222jwNWNCaH4v6uJbVbgyNvv8
         9DVA==
X-Gm-Message-State: AOJu0YzgF3SjkQ4CGUGNNzTIujvtGgTFsVLOUcDzgpFc4gZSxgacqvC0
	06f0BbkX/+lBbbwddxg4t1O/e42PCIwHPIGkvF/3EXphaaRLPG3b
X-Google-Smtp-Source: AGHT+IEUm/E68HA9nqD5oGXbHbVTb5C236eUlbIt676g5OZyZr4e2qfE52fs9PE0X1cXn6Fk750ByQ==
X-Received: by 2002:a05:690c:2890:b0:664:cc54:2f63 with SMTP id 00721157ae682-6a9754e6e74mr10641517b3.36.1723482908870;
        Mon, 12 Aug 2024 10:15:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd? ([2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a09fbe88d0sm9568157b3.9.2024.08.12.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:15:08 -0700 (PDT)
Message-ID: <e136e024-8949-4836-be02-fb1a1ca75f16@gmail.com>
Date: Mon, 12 Aug 2024 10:15:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 5/5] selftests/bpf: test __kptr_user on the value
 of a task storage map.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-6-thinker.li@gmail.com>
 <CAADnVQ+B1oB2Ct+n0PrWnb5zJ2SEBS1ZmREqR_sK=tQys6y3zQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+B1oB2Ct+n0PrWnb5zJ2SEBS1ZmREqR_sK=tQys6y3zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/24 09:58, Alexei Starovoitov wrote:
> On Wed, Aug 7, 2024 at 4:58 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>> +
>> +       user_data_mmap = mmap(NULL, sizeof(*user_data_mmap), PROT_READ | PROT_WRITE,
>> +                             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +       if (!ASSERT_NEQ(user_data_mmap, MAP_FAILED, "mmap"))
>> +               return;
>> +
>> +       memcpy(user_data_mmap, &user_data_mmap_v, sizeof(*user_data_mmap));
>> +       value.udata_mmap = user_data_mmap;
>> +       value.udata = &user_data;
> 
> There shouldn't be a need to do mmap(). It's too much memory overhead.
> The user should be able to write:
> static __thread struct user_data udata;
> value.udata = &udata;
> bpf_map_update_elem(map_fd, my_task_fd, &value)
> and do it once.
> Later multi thread user code will just access "udata".
> No map lookups.

mmap() is not necessary here. There are two pointers here.
udata_mmap one is used to test the case crossing page boundary although
in the current RFC it fails to do it. It will be fixed later.
udata one works just like what you have described, except user_data is a
local variable.

> 
> If sizeof(udata) is small enough the kernel will pin either
> one or two pages (if udata crosses page boundary).
> 
> So no extra memory consumption by the user process while the kernel
> pins a page or two.
> In a good case it's one page and no extra vmap.
> I wonder whether we should enforce that one page case.
> It's not hard for users to write:
> static __thread struct user_data udata __attribute__((aligned(sizeof(udata))));

With one page restriction, the implementation would be much simpler. If 
you think it is a reasonable restriction, I would enforce this rule.


