Return-Path: <bpf+bounces-26642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8338A343D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B4E1F23129
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34F14D2A4;
	Fri, 12 Apr 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZBsr59j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2914BF8B
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941213; cv=none; b=L7hetmEnvnUV8+Nh/LbWZLj4x4+erL4ZlKsJUpbngyt+Gd7IAgg+/zNSDC2uyZHyGMX932jd6RmxEJyIp39fhSDJZGF006h4XZyaPF1DT3r8gLGzc4DThJr5c02Q3Nr0BlxgTPqHxuTYnU3Fxag7qq6Z3e/VXqpb5PstRRZwxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941213; c=relaxed/simple;
	bh=a2CRp9ShaR0Pyq935fA0cBxrmTGtYbJ+sLLbfJxBi9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCSZm6DWQRaPH/+SouR1oGM/t/SgEvTZ1SqwT0dOsQLoOUHv0lPLJPcte7GGcc8cJf9GNg94B49/NAcodDJZbfc3vqgKstSm+q4rvx+otrdhWrcVv1H0rsxZjAutvnuQOaIRBL2U7KeSmH/oAPzgp7Mvs5U1+0pJnfzf6LxjuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZBsr59j; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea2ef1c6b6so677078a34.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712941211; x=1713546011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8K8VL5kaOrNKoNoubr79DiNaQJxqZ+8ezqTyYw+vYXQ=;
        b=PZBsr59jAeXHWcgoWbF4+K07Am8FLQeSnPyUWwPF++FmWTRpczMIZ+Igh8Y+YTcbWy
         IshP5GAyWpkYw5Y51lYnJu9dioZ9pp0i5HjyFhnoKxsjYJQyGNO9yonIQ0gnrHoVeZQf
         vGqQ4y8+edHi2rtpnQDfuO3MU6Oc2Zr6q2PxiBQ13nAZXUKTNO9mn7uUFgEBWCYiGqeR
         XcW0iMBekYNv+xReT//EXrC2DbLdbOV8Oxn/iMI9lCmgWlXk2yIQp8sIo6g4aBkKTOWq
         vWuvFa28eFAjpWuBzj3aGgWVP7oE/vbfdeOTcFkmFTjbGGZZY46njfCK2P8zPDZ1UPbQ
         cPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941211; x=1713546011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K8VL5kaOrNKoNoubr79DiNaQJxqZ+8ezqTyYw+vYXQ=;
        b=lc6Q3cPTmYGM6AGrjXOfYMDqerxUpI2/IQ3fU37n4SYeR5pHT4wBvi/PWpZRUiYcm7
         wBAtrZ7suP6hOJ0aQu/r1Z9T9RLeEI3z8h+Onuv0zmZ/EbYsmuekKUk1n5tys3jQLEGK
         m21U+yxArIuOmvWgnE9i0QG1SJ7DCpNO+rC1HL8cLRY2iOfjL/6FoglgnciP0J5RuBNA
         ZQROC17i+Pizdq1s4hPrV+mjulMN0VwlV6OcyIUxV9VCS4yrjUvJRVYVx85WUHsYWPBh
         HZHmmC3zM6G5JGFE4Z0Hczag6jpwmUDbl8Eag8R6gVgQxaC6plLYWXJJ0AMUmfPM6vW0
         O6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0pNBNT3SFH6Yf5dtzD0sxSqnAd6hEnrjl0XrX4fCw8sr9tdYJcTx6CQIVeBUmIj+fSXToNdT5U9+b6A/Mo6ejCEmt
X-Gm-Message-State: AOJu0Yxveugk0w+8WU8BeMdflbMJx4cqe+zB/o/jcH4rVgmiCHCRs/5s
	x4aAkc+GIRLfcQJHpXRquJEXeRyPYBXWLvLsQKNkPEKGi06E29Cw
X-Google-Smtp-Source: AGHT+IEvgVlnrE+3b6J+KnSq+i1vdRL5C8zhMPqwiX5uQb/B9SG7s8tKU5d6vEuADpxiEaIIJKq3bQ==
X-Received: by 2002:a05:6830:1be1:b0:6ea:1dc5:514c with SMTP id k1-20020a0568301be100b006ea1dc5514cmr3591041otb.11.1712941211114;
        Fri, 12 Apr 2024 10:00:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id i16-20020a9d6250000000b006ea20712e66sm747091otk.17.2024.04.12.10.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:00:10 -0700 (PDT)
Message-ID: <004f7f72-6e2f-4040-8d2b-31353ddcfcc1@gmail.com>
Date: Fri, 12 Apr 2024 10:00:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/11] bpf: initialize/free array of
 btf_field(s).
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-6-thinker.li@gmail.com>
 <57d016ec8ccb9cbc454f318d74b6d657de59ffcd.camel@gmail.com>
 <f1957694-13c3-4b4f-96f1-451b8acedc4b@gmail.com>
 <8d12fcfe44693bf69382951c8b090b06df8fe912.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <8d12fcfe44693bf69382951c8b090b06df8fe912.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 08:32, Eduard Zingerman wrote:
> On Thu, 2024-04-11 at 20:56 -0700, Kui-Feng Lee wrote:
> [...]
> 
>> So, I decided not to support rbtree nodes and list nodes.
>>
>> However, there are a discussion about looking into fields of struct
>> types in an outer struct type. So, we will have another patchset to
>> implement it. Once we have it, we can support the case of gFoo and
>> all_nodes described earlier.
> 
> All this makes sense, but in such a case would it make sense to adjust
> btf_find_datasec_var() to avoid adding BPF_RB_NODE and BPF_LIST_NODE
> variables with nelem > 1? (Like it does for BPF_TIMER etc).

That make sense. I will change it.

