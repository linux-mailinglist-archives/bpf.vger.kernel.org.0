Return-Path: <bpf+bounces-30425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839C8CD9CB
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893EEB228A5
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E95A7FBD2;
	Thu, 23 May 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGiTk3c5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B2328B6
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488701; cv=none; b=MsfLrvLSaHJRiUn+C6Dy380DFLNXxFb1DtWUtTB6hlA1Jo/aTvylG04JnKGxMnjxTib+uP0bvnRaxCiZd7TLNR5MUtiTpbGuyHMHo0CrfACsIfghj6KdiCjfqhmYtHYM2ZN+yGngFn13RiM9H4YgE2bVGZWRMJ90Lm6bn7rIXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488701; c=relaxed/simple;
	bh=4mO/5JSKBB1QykKQFnmWpBkg3Wx629D2HB8aLtXHHDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDj7gQ97SHM/1m6K575EkBXF75vNsf/rcPITdsAVTj6pAGyVX0Z4e3A/DyMxf1yYMQmenIDZ21KgI+BJpsvYnDE9aCXhuxv4OZ+OdKTnuZvzbB4hLjg23d4B1ENCmE1UmvXI6sRubtxES4trAOdsIgVZMIH5OHqeCT7R52kvYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGiTk3c5; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-627f3265898so20352867b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716488699; x=1717093499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MavaYN+wgVQnz5bBbiEiWXy4Yy+PBUNCEjiOuOzhkCg=;
        b=kGiTk3c5Rb93uPhT9nHXkgRiYs6njS5SHGs5ruD5yiNQD5NS1mkapnuuCymAyJkIKT
         l1nFTNlDEdzptIWt/weJqnjgWj8A1ojJk5Khc3IK2qm4dRWNBQboChJr1hb/9ZTtvKWw
         cwyqGvMnek26THtkVEosGLOgMeiOxiqp5L1EkfD+ZWEUBH84rB/Yts9Fx2U4Z3356UQJ
         0xsB1Pm8zCFlbmTuJBJYljatVVJjB/OZ3hVuq46PNVJ8+O7SNKve/gTZ/sdTwrKnSftC
         9EV+G3zIUoGyNKnhJSd2bIl2mjPbXz8fi8mhUL9tZD3Kq318geMLHvvwgcvrXEJmsesF
         Ndtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488699; x=1717093499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MavaYN+wgVQnz5bBbiEiWXy4Yy+PBUNCEjiOuOzhkCg=;
        b=bVsfmmMXKLV+x/LY/9L2Nwiqn7ciEzNnAw94LXFkiyUaktwp/QkJ8s5NrgEAsofTwi
         J7TERr5h8aaYp2aMx3wqcUalUvY3EoyUa2Il26ff2z9PmTytBExnyAWF1weVQ5xQZQAB
         PtC8wN+/JOv/2opmeR/onD5uDH4Qo323/hoPOYpP7BPxEvisu2Y8QSNYC9CaUAYrZHUC
         hgC6I4CA7+jvPEaYgnXp0OvmJPMDTyoFPXJ17sbe0aMcxQAqkxy7UoFIPmB+lp4zs4Qd
         eBGpygVd+4XE8sQy3dy0hYVfXe4Wv6ltS4qnL8G4kOt+0jly8TEy+sCYp6tt3D5aman3
         NrSA==
X-Gm-Message-State: AOJu0YwSLM/vAe92VUzOn1Y/1IXAf0ejrGS1nZVMPsNU3jxs8NhxIAPA
	Xaq7PyWXRSsxZaJTvunwtgYu0FaEqwE1D3mzCR4sCccmVKNzRtKR
X-Google-Smtp-Source: AGHT+IEjjCrLrZCHQ+c4FE8FmKoETu2hlB2A79YpTkfhPazKJgwJREmMkoDJlBUcAOw1ck3cZGdQFw==
X-Received: by 2002:a05:690c:60c7:b0:61b:e693:d412 with SMTP id 00721157ae682-627e46ed73dmr69320897b3.20.1716488699081;
        Thu, 23 May 2024 11:24:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a2b5:fcfb:857c:2908? ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e3472c2sm62663467b3.81.2024.05.23.11.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:24:58 -0700 (PDT)
Message-ID: <787e0274-5592-4b74-8a7f-3d1962d41d35@gmail.com>
Date: Thu, 23 May 2024 11:24:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-4-thinker.li@gmail.com>
 <a04e275d-4b29-4a6a-b142-dec5b376f2b9@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a04e275d-4b29-4a6a-b142-dec5b376f2b9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/23/24 10:23, Martin KaFai Lau wrote:
> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>> +static __poll_t bpf_link_poll(struct file *file, struct 
>> poll_table_struct *pts)
>> +{
>> +    struct bpf_link *link = file->private_data;
>> +
>> +    if (link->ops->poll)
>> +        return link->ops->poll(file, pts);
>> +
>> +    return 0;
> 
> The current bpf_link_fops.poll is NULL before this patch. From vfs_poll, 
> it seems to be DEFAULT_POLLMASK for this case. Please double check.


Yes, it returns DEFAULT_POLLMASK if file->f_op->epoll is NULL. But,
before this patch, link can not be added to an epoll. See the
explanation below.

> 
>> +}
>> +
>>   static const struct file_operations bpf_link_fops = {
>>   #ifdef CONFIG_PROC_FS
>>       .show_fdinfo    = bpf_link_show_fdinfo,
>> @@ -3157,6 +3167,7 @@ static const struct file_operations 
>> bpf_link_fops = {
>>       .release    = bpf_link_release,
>>       .read        = bpf_dummy_read,
>>       .write        = bpf_dummy_write,
>> +    .poll        = bpf_link_poll,
> 
> Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect for 
> link (e.g. cgroup) that does not support poll?
> 

epoll_ctl() always returns -EPERM for files not supporting poll.
Should I add another instance of struct file_operations to keep the
consistency for other types of links?

>>   };
> 

