Return-Path: <bpf+bounces-58105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A2AB4D5D
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873151B42274
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7F1F2BAE;
	Tue, 13 May 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bM+Q24ar"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2221F1524
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122871; cv=none; b=L6gGJnezlSLuic7Px9xzjjHtuCzhrzaTNJekPZxo5e2HIG1fIxUcm8b2seDv87v/81XYEhTn+zJOeN8JigH4cA1umB9P3N48rsqgYBFU1tO3J4hMlHjzQqcSCrsVvr3F1UJr8JMElVi1cf6eSLD43SpbSnMp+IuWRRWfAW/wyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122871; c=relaxed/simple;
	bh=g+7M1hDUx2vvDFtAKiy56+/XkrrZ808Bqy6mLcvpuk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfHmUUTI9UOQd4o8TsokW17h/z9W0X5ULhl7aFQ0o8ItPA3p85cNbU1VgomCAPnM558hHinSj/FM8UjaHeClD9ryGyeDfXc3Z0rNxKwvI3XbX7Ew0hUv2ooL82k5vWsnUn0zVuY3lDDBlxqAWjYsKzNkJ6LOFiBKqVU3U7f/t+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bM+Q24ar; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747122868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H/VZ8/Jsgo/a7nI3QOIUYQgdbCZzTaMgVgRyxnnptE=;
	b=bM+Q24arlCmRezAMZ0WEa5d3Qc/Vlqmz2KTttWw5+UP7qd0SkmlMG93eUDDOMahNjY/ozX
	HZWyZkKXrz+2R4/cUrPrGZ7BOswwmkq0RmMOfoPEBF6SlmXfNM29TvWxfNE7ebC7yuCSR2
	S+mXhMYOcJqID35lwEyHdWxcC/FfI00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-5BfQT5NeMSyg9qc-OOhCkg-1; Tue, 13 May 2025 03:54:27 -0400
X-MC-Unique: 5BfQT5NeMSyg9qc-OOhCkg-1
X-Mimecast-MFC-AGG-ID: 5BfQT5NeMSyg9qc-OOhCkg_1747122866
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1f6c5f54cso1482871f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122866; x=1747727666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1H/VZ8/Jsgo/a7nI3QOIUYQgdbCZzTaMgVgRyxnnptE=;
        b=p7LFRGwtRmBhDzuBkRx7mIAifW0PgvRQaIoopUkDsGrpuL4j1VYMwOedjIzr0JdBVi
         ooOeBXqs6O3sz0BYfFBII9YGL7Glp6BfQnOQwRVoWVjClwyNMqr68VnAtBCQJN6tJhwc
         K8AVntx/RN5UhRKMq+57/F0LLjC+6CHjXIRSeJibrAhV9IudwclvLhCrgQWrXgOa1VtB
         9b4d92iKzLlV8BXAslkZXBGVW9fu6+R/ixCUsjylx9W27cPtZjSV0N7vGIIy9w1lcadf
         SFqhy1AbzWG5wqbGouFZsOFW6hAj3JjrX7aCO3pK2pt5LOXcWXfIA5oNZGBaOnPfddPm
         /Ofw==
X-Gm-Message-State: AOJu0Yz+4kF6njvuZe517qJ0jJ2b+637VDTLKmLaYpngC8dWuGTlsnf4
	PXchFPxTPKOQ4WFGdtkLxdgtadwsVGr/ZkwAcX8K/ztlgl0uHZjQg/jsKuHoIweJBtXW54mK+4I
	0LP8pAD3FZXGVVQ5AZN18nB3PrpPz2aE9bLQNNTkZDuhrNTkc
X-Gm-Gg: ASbGncutUhaKELbdjdZRhozAe+D7N6Z0WsOQ4trVDH6FXCpL6pZGxp0z2eIk9fjoP3h
	aSOAZbulToKQJg8RIoR4hUchu9G9Rco/k2QRS9e/m+VTaf4OPTIQgLMJh8YCgrVkuPLgfi9pfuc
	+s63IvRXw/uuoiolpb+NHV231GFvYkFEkagQkDicKg8a1vQ9wnePx/ndrMdo5ArXQtDqUbEYKbd
	KUQlWq5W7oISBkzQEj91jUMXZlc17U6Z4ZPRa0CHgCTgkKEB0NVyIrnWrXGf0Wxo4RMFoCgcFtb
	UmNy6F8=
X-Received: by 2002:a5d:64cd:0:b0:3a0:b550:ded4 with SMTP id ffacd0b85a97d-3a1f6437188mr12754710f8f.13.1747122865869;
        Tue, 13 May 2025 00:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYMWoF7I7NcmP/gEgCRnYoGtbbevj7NIu5dTei2SET8TPMeayTDgw/TgjxYmS3X++I5dBavw==
X-Received: by 2002:a5d:64cd:0:b0:3a0:b550:ded4 with SMTP id ffacd0b85a97d-3a1f6437188mr12754687f8f.13.1747122865531;
        Tue, 13 May 2025 00:54:25 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ca31sm15324324f8f.65.2025.05.13.00.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:54:25 -0700 (PDT)
Message-ID: <e6b8ebc8-7b55-4bbf-a5ac-04445b46325d@redhat.com>
Date: Tue, 13 May 2025 09:54:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs as
 args to kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
 <CAADnVQJD3dQfuT2ExXL5iGeVj0TJ9L5KWGovmsSz5giKft4ryQ@mail.gmail.com>
 <aCLrK_QBMVWCy4bo@google.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <aCLrK_QBMVWCy4bo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/25 08:48, Matt Bobrowski wrote:
> On Fri, May 09, 2025 at 09:20:53AM -0700, Alexei Starovoitov wrote:
>> On Thu, May 8, 2025 at 2:09 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
>>>
>>>>
>>>>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>>>> -                      u32 regno, u32 mem_size)
>>>> +                      u32 regno, u32 mem_size, bool read_only)
>>>
>>> Maybe s/read_only/write_mem_access?
>>
>> 'bool' arguments are not readable at the callsite.
>> Let's use enum bpf_access_type BPF_READ|WRITE here
>> or introduce another enum ?
> 
> Yes, I agree, and using enum bpf_access_type is also something that
> had crossed my mind. I think that's what should be used here in favour
> of the boolean.

Reusing bpf_access_type feels like the right thing here, however, it is
missing an option for read/write access. Should we introduce a new
BPF_READ_WRITE enum value? Or assume that BPF_WRITE should also perform
the BPF_READ check? Or make this argument an int and pass
`BPF_READ | BPF_WRITE`?


