Return-Path: <bpf+bounces-22823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E4D86A3DE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1501C22DAA
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8B56473;
	Tue, 27 Feb 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNUgVcwa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751856461
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077261; cv=none; b=DewZu/UqM1InfzTxUWe4g7C0M+Ej/4vCEWI7M5d4ZGhs5CPT3GDNjyL9S5XjDdS5bQz8ZAMFUq/GSqWiOr9+TQE/ndbyhxCyHPJR/uHDqSSsnsDsaI8O4S7cxHKo4zOQGk4vY4B9vbEKJvcYGD7m39/2CYeg7DuVrcqO95dsV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077261; c=relaxed/simple;
	bh=4UBrosC7UEWCWl/tc376ZqDrCw1stN5zA2XqNZ/WLzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peXiytme2hrRIxl9lq/5CsdxQdQLLtyqNSTSfrSlL6EsbMvuGpRBD0jDw0h84GJUgCukGFqykKhn6UgzREJzyr+GhQJ+KtfAS32hIhBBjm2LAk5DbYLSPjhgCVxTVCzE8sbdSwnKqcHRbLyDUKYXncmRv5ChJhGF/qqRE33kfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNUgVcwa; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60915328139so24370247b3.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709077258; x=1709682058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AXqqAvsOHgFYmoHEmCHvxJ02DogPGV4fzQPoyThAl8=;
        b=TNUgVcwaSnfkE75KxV4CdMIhQU8TimtSm9mORJBWgsdK0tEbgnifUnvqp1FnsPp+Ku
         aHqIYsbbbLNAVw7xV9jbhE+L5AndTESaNbc70WTHg22e1D0IWQVoba0RWdcmYkn5tqjK
         EgztBg/B6IJL8sEM7Xl94STUzbDUErj4Bu3J5VsIjR5MN8mIRN8KnwLBWi1PQ6AQOyFC
         eLv1zr+tuCalUOyrRq+eBonTSEO1NGqMh3YZcGIlbDce0uctU/BOlwafqRDUUvj8359j
         ZmFwGvaUi9r2dh6Z0sUPZLdxmmQm207usYqK6FDTwxO6F46dTld5SSo/UFriYm4vLi3K
         gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077258; x=1709682058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AXqqAvsOHgFYmoHEmCHvxJ02DogPGV4fzQPoyThAl8=;
        b=EItKEPAErUst2SFnmEo+3TqhHv0cDUWnw9QQVkdAlqJacx6Z/cVh/lfvFQoQaUcXaB
         XtbXX1rMt/fZ9fuqXGuyjWrOGXwITjc3ozMAdhOM3AiYgrHGfrHYb8O7Raq7QHkvXkBc
         D2gwe1qsJfOsiHVGHn01Kpa5Z0ws7++nFtUpKC/l+gh/Sdt5TEbMmTg29oPw3Rr7GP4y
         PSzSqD6XX6LAwQlLWfyxp2tw+DUABaBWX/gQ5lI49cAA/v7vQwklGaPJbjZOTERjA12P
         XmhXYNqn9j/fKSrXQF6/BMbWn3irQJfDN15EmVRyXNcB2OTcR4TpLHJAJs9fMT9OD/ZY
         mP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0QnA9JsElcjImj9H1sl5jIhavmVHvt7f4goVe2zjZ8C177/pLhpes8hG6Ci5z0jqba9OBbOOeWc16UClVkeUixQMj
X-Gm-Message-State: AOJu0Yzjg+JH2z/ILH8XolPnJOXObgw5l9qzgmcLDKXTzZ40cjPn50og
	ANNWlph5fjBwXn7ckB9mWrQrIoDK7hxGpgCdR94rHEC/66DOSxp+
X-Google-Smtp-Source: AGHT+IFyDrD8t9QrZZiKcEQn3KzbNi1c4ok7kT20hggeyE1RFrEB94RB64YumjF6lcMylvfeqQYRHQ==
X-Received: by 2002:a0d:d7c1:0:b0:608:7524:1506 with SMTP id z184-20020a0dd7c1000000b0060875241506mr3920504ywd.7.1709077258245;
        Tue, 27 Feb 2024 15:40:58 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:76a2:1c3:c564:933e? ([2600:1700:6cf8:1240:76a2:1c3:c564:933e])
        by smtp.gmail.com with ESMTPSA id b64-20020a0dd943000000b006093a26d5a8sm127542ywe.72.2024.02.27.15.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:40:57 -0800 (PST)
Message-ID: <ee2d5820-c250-4526-826d-49fcd3391e1e@gmail.com>
Date: Tue, 27 Feb 2024 15:40:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
 <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
 <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 15:30, Eduard Zingerman wrote:
> On Tue, 2024-02-27 at 15:16 -0800, Kui-Feng Lee wrote:
> [...]
> 
>>> So, it appears that with shadow types users would have more or less
>>> convenient way to disable / enable related BPF programs
>>> (the references to programs are available, but reference counting
>>>    would have to be implemented by user using some additional data
>>>    structure, if needed).
>>>
>>> I don't see a way to reconcile shadow types with this autoload/autocreate toggling
>>> => my last two patches would have to be dropped.
>>
>> How about to update autoload according to the value of autocreate of
>> maps before loading the programs? For example, update autoload in
>> bpf_map__init_kern_struct_ops()?
> 
> This can be done, but it would have to be a separate pass:
> first scanning all maps and setting up reference counters for programs,
> then scanning all programs and disabling those unused.
> I can do that in v2, thank you for the suggestion.
> 
> Still, this overlaps a bit with shadow types.
> Do you have an idea if such auto-toggling would be helpful from libbpf
> users point of view?

For me, it is useful. For minor adjustments, shadow types is easier and
simpler; for example, change a flag or a function.  But, the features
presented here are useful when a user want to switch between several
very different configurations. They may not want to change a large
number of fields.

