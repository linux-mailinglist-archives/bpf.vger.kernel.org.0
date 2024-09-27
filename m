Return-Path: <bpf+bounces-40385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7534987F29
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527221F24450
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AC17A5B4;
	Fri, 27 Sep 2024 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crL+Vxb6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AD6BFC0
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421154; cv=none; b=gPjc1xx2s9Hy0DMWkR9meJs9QdblIKqW8lwts0c3wB6kw3SB+ovgvwxlQoQP6qCDtGIJKyzvIGyXIHQ6UYrNKk5D/N3dfsAqTGQ3He85ClA09GHcfwJAJJriUQcN0Z1VydyrIHpmATUZgWf7rZJ/lGjY323sx6J+GGi/3m/McTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421154; c=relaxed/simple;
	bh=vlsM9SU4l1gcwSvQny+WQzdlT3+rWyeV8NTehmomImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6/saiHiK6nd35DYYmKtiquFSyXnD/H5RPqWoWJO3zeY4iZXP6X2YfjAzqG+VWem84pxop7QCoVDTMcKNCaE448tgDpatrzOCKEpiAJ30QRosNu0fi9HE2d76k0P3Hal8Y049w1yBVJ+a4xlGB/2cCppzQPPvQIRHH+7jLI4f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crL+Vxb6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727421152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnYyR4BdAlbUUBSm5F4TUqwv3JFBcLS0KXsy/c9+WG0=;
	b=crL+Vxb6QTdDsQKshE76iVx47Bb0lUvcIfyommcuuasud6faHrsUJkX1Lr5h4eN5d7IRTJ
	i+3X8Jmv9NZ8KguCBrjGRMrVVr7TBi75JBTvU0Het0DFhZysd3OA7o6xfy+B3t19Rnr4qy
	zTMKwOeSFOquX6mLqDKH5jbzwSMPa6g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-yWJ_O9YxN-qFtctxh_R1HQ-1; Fri, 27 Sep 2024 03:12:30 -0400
X-MC-Unique: yWJ_O9YxN-qFtctxh_R1HQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a80667ad8so113661566b.2
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 00:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421149; x=1728025949;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnYyR4BdAlbUUBSm5F4TUqwv3JFBcLS0KXsy/c9+WG0=;
        b=Ea5LDE243AYQP3K/75ONEiTAbQw6lv2GhJSBPIWF3CABxdNClLUYxV1L44g6MC7eYd
         dwlRexg1a7Ls0Z2GEfWEspxveQIBOhc87Pd6/32Yc6ddggybII0o2IhjoKaXiemygpSK
         8M9UhXvvdS6Vqesagxu0qYpjQ7IbSm9MS+rMA35FdveasNEAQekfCQuUZABLlu46C7ZP
         6BDvw7Pcg8nM128RNZ2zOjSgzf1mNdJU8WhKjtbXSAs1lfm5Z1mwYIamhnwWDXaUteQ4
         2wm0j3IIfi3d/pNR+6d+4l2wvTiWf+d5m5k0xi/VKTY+I0GqJh5VPTiekGsAzMyuX3QL
         kXrg==
X-Forwarded-Encrypted: i=1; AJvYcCXaGPm679ijZ+PwdjyIZX/8bkr04srWgvCaWrLne1ft56omA+RnMsAkX6DOvBy5Zo/aCJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwQ6kAbSIHr1adzbotEyW+aIBzuYXq/XE0H2ElxhTV6dn5Fh2
	37vjfek0rE2EXLwi/IE0UOJqN3osD8MufvT2m0X8Q90DuFT/8Q2l3iK+amOy/gu2ubIXZitTzo2
	kKskUx+3nxdNp3VVtnoC+ofnL1EjnBh4RZQoSoCHoYqyu0H2b
X-Received: by 2002:a17:907:9604:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a93c490e060mr199269366b.26.1727421149150;
        Fri, 27 Sep 2024 00:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhGtwO2HX4a64J2KSaRqV5LijBT9FMABJk20lRJK2wRQKEVsLgs6aodZwWF7DDddPYF0rMMw==
X-Received: by 2002:a17:907:9604:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a93c490e060mr199267266b.26.1727421148688;
        Fri, 27 Sep 2024 00:12:28 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948210sm91369466b.106.2024.09.27.00.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:12:28 -0700 (PDT)
Message-ID: <85a8ac47-c9b4-45ff-9905-8919316a365e@redhat.com>
Date: Fri, 27 Sep 2024 09:12:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add kfuncs for read-only string
 operations
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1727335530.git.vmalik@redhat.com>
 <efa0ba9ce828010cd6fea1efa45b17c1b0800ace.camel@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <efa0ba9ce828010cd6fea1efa45b17c1b0800ace.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/24 03:37, Eduard Zingerman wrote:
> On Thu, 2024-09-26 at 09:29 +0200, Viktor Malik wrote:
>> Kernel contains highly optimised implementation of traditional string
>> operations. Expose them as kfuncs to allow BPF programs leverage the
>> kernel implementation instead of needing to reimplement the operations.
>>
>> These will be very helpful to bpftrace as it now needs to implement all
>> the string operations in LLVM IR.
> 
> Note that existing string related helpers take a pointer to a string
> and it's maximal length, namely:
> - bpf_strtol
> - bpf_strtoul
> - bpf_snprintf_btf
> - bpf_strncmp
> 
> The unbounded variants that are being exposed in this patch-set
> (like strcmp) are only safe to use if string is guaranteed to be null terminated.
> Verifier does not check this property at the moment (idk how easy/hard
> such analysis might be).
> 
> I'd suggest not to expose unbounded variants of string functions.

That's a great point, thanks. Let me remove the unbounded variants for
now, until we add the null-byte check to the verifier. The bounded
variants will still be useful to bpftrace so I'd love to have them added.

Viktor

> 
> [...]
> 


