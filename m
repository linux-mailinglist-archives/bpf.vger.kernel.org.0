Return-Path: <bpf+bounces-68680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E6B8111D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8415C5838CE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568192F9DA0;
	Wed, 17 Sep 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S98gnAsh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF702F9C3E
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127503; cv=none; b=CZr48Lc34cXmRYbjNXKswStgh+36Fg3z+LLShxjqolaU2OUeo+U5RKl+XyP6bozN4/9yoydpS3LWmTSX3gcjaGG9/NxHAVpn7VZ0qz0MaAwNOJ/XNH5E+K32z3gPUb/9UsFpUuWEuem2mQ4N50cgvnBiYI9G1N6wkPEChwcrS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127503; c=relaxed/simple;
	bh=xiGNoeoGw1ppMrBVyBBuJ8/sJRaBmeghEOdnbenPp1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIh7sAZGjCUJNnMlCroKfbndR3Xv6R5KmDiYhUWciVTYnvuEMvQsDN1T7Mxr0qx+2W8J9ucVw4NM98crM92as15vaAkQNKu+93Q60ROvL7xthGvTi4Ac4G+EZZSprrRPLllKNUMjvrx2TDuEznEC4arnlQEWK4jy5NWFZva6uAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S98gnAsh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0787fc3008so976614666b.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758127501; x=1758732301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIM82uHI5x+NUob9dbvCKnyDJdlEz7kaNiNPDbJGgBY=;
        b=S98gnAshWj9DYeqxuPbvacfHOeQobm1xYnuhLqc49feqWgk4fvYJ/mRocLnedYpGHK
         1DKmsNjdynpEl7kD2HWDy9kSfeS4I6WpnxlUCyIT2xC2mJ0FqeEQmM7hqziRKDKHCd4C
         3wjrolXZtWTgsYEe5ASG0Z4O19/43Kd/aJH2UxTi1TjkmQaL7X6IBgsB8aUsWgHor4zW
         yOEs6y+YYjprRhiTD9BSx3hEBshwqfBAW4lWpunYAybuM8WRFnFDDCd1xwYqeHvKrAt7
         K1BFmXYATVB97HRszTStzurowrQyCU6lXt8RUgqOuoR+OsQbFwqBsTe6B/qKmA5JkUrM
         +lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127501; x=1758732301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIM82uHI5x+NUob9dbvCKnyDJdlEz7kaNiNPDbJGgBY=;
        b=Y+tRZ+vOdH6/geVRuKd+cFeK9odZobYpcBQYkoELnQADdsut/Efum8zlYN1r8aQqaj
         u+/pAg77J5QbL6gL+lFI7GxNMGtqeJhx56UHIlW6CJ0S0U9V5E7GRQ3bB2cbbYpHraMn
         w1VmaMnsigSznKOOCBdpsY9AiOGWKlv8u+YvN8zHNY5A8mHgcFrfTjAKmomrVC4w7rof
         +97UKQSOAbbfD8gJ1ASCDrEZSxht3U+ZaogdfxjYjWTD9Dt28Zea859GH6B5ZCmP97VV
         /E2JG/8kK2QKuxYukMQVD6EvPt+E40dklzPjo3l2DIQZZxOMfPjwHu5kW9OBZwDoLkUQ
         ke6A==
X-Gm-Message-State: AOJu0YyjbloPcsF6lG6P7NwNXC1eK1o0a14AE9KE4hBQf6zcxE50FRS5
	IYKn/Qm8iYTdW28bm9qLTchMfD9H6An/coBuz3VypOEq3faAuLrK7BdZ
X-Gm-Gg: ASbGncvO5yrbTFXMistqc2WVotMedYBdJgY2N8mx1LjFC9jAKnBYPyGYtLxhfi2P8Nl
	1QjJOhRPX85gzeXtoIuMykd25ZIg5guHWOwQMg7IvE35N+54MLz5KIbsCzdPU2bMYqZS3F0FmDh
	C52W059B7Pn4Vp5zhAxgfwFV1fleCpkKNzU599U/8CrNJfqfRW8Oiegb+ycPqVRXVcvJXrEBFUc
	ze5JCNOfoSuxUl/Yk9qc223l8YgTm8qwQYnNd6VByXqDoC09FaGgf88nJG7VsciKoDKbC3zo1gj
	B0mqTNjkWXR7qZUL7gwRsEFlNh4A5P8vGUgnZ08akgZugaP715LCt5phafpCsLcJ3EB5kiFzNhB
	jbD7BjkOOsXoKrr8YLocaSaO8spCQLMWU+j1IwEx8vkV7XWO/k3Kf9L5kHNgNqnuLklYAN6F41a
	zBZbv/iQg=
X-Google-Smtp-Source: AGHT+IHtJ8dM+ve/2xY7QXxl44HejX1E0fJgARVF+Wogjz+Mpm0zjFBRPZ+MtA3NfOtSJFNw6cuuRA==
X-Received: by 2002:a17:907:3f20:b0:b04:6858:13ce with SMTP id a640c23a62f3a-b1bbd49ad36mr352202366b.38.1758127500520;
        Wed, 17 Sep 2025 09:45:00 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:f2f7:f955:bf36:2db2? ([2a02:8109:a307:d900:f2f7:f955:bf36:2db2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43879sm7291566b.7.2025.09.17.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:45:00 -0700 (PDT)
Message-ID: <ebfd9430-3c3f-440a-96ef-983433bddda7@gmail.com>
Date: Wed, 17 Sep 2025 17:44:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context
 execution
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
 <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
 <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com>
 <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/25 15:58, Alexei Starovoitov wrote:
> On Tue, Sep 16, 2025 at 9:51 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Tue, 2025-09-16 at 21:44 -0700, Eduard Zingerman wrote:
>>
>> [...]
>>
>>> In v4 the function invocation looked like:
>>>
>>>    err = check_map_field_pointer(env, regno, BPF_TIMER, map->record->timer_off, "bpf_timer");
>>>
>> One option is to pass an address:
>>
>>    err = check_map_field_pointer(env, regno, BPF_TIMER, &map->record->timer_off, "bpf_timer");
>>
>> But still looks a bit ugly.
> and then check that this pointer is > PAGE_SIZE and only then
> access it ?
> I guess that works, but why not something like:
> map->record ? map->record->timer_off : -1
I agree, let's go with the simplest/most readable solution, I'll send v6 
with:

u32 timer_off = IS_ERR_OR_NULL(map->record) ? -1 : map->record->timer_off;
...
check_map_field_pointer(...timer_off...);


