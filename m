Return-Path: <bpf+bounces-71891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E6C00888
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E163A12F7
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C483019D6;
	Thu, 23 Oct 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VuJOZN5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED284B2E
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215897; cv=none; b=l4EHJdduJPtkbi7vfRAy6nCm5n5GMvAjhiUiYk80G+YE/DH93PXCJ3dI8Pb8FUpP2vWUVll8NOqKNjY1b2zFqU/1hA90A7hdG+e+3tg8qgYbq7XHJ6QqD7YcoSD6knztzqYRQRX70jKabFdhT9WfYJTkJy8MVynt0YJzhCp14g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215897; c=relaxed/simple;
	bh=ccdCev9OwccTpNYLoGiC1pNhqFL2qTVhyY6JIskzqAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jl2sHKCDJZuGMdOYzY6iLNWr8jC1OYm2JgAyW/t1pbSKINAHNLPgcNDun8HcCj5DaInp15MpODQQLPjDfefPMDzpkbLTyUX68y0pzzvQdp8jzSlEQncXTJncH3LIYGnnMfSkjlGTdZ8YN35GF9mrhmn140WDdJ1xqejAYE+p1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VuJOZN5I; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso147559966b.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761215894; x=1761820694; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RylQUWzAmqfhDIejJ1iRcquHT8WCtD5O6366ofaSbxs=;
        b=VuJOZN5Iqy7V1ApYMPTPpbzykCFm0DZRWV02blFa7kcPYlfnwnJPvTMpRNRXXp7aI0
         xxi1mxaFD/MEDA8VdOJ8nyN8HoxLklqI7RI9ReyjXnfv/cxfWQ6liw2KBNmJx6JvJPLI
         9XxoEcRF4aeSl2L/zPmaz5edN1pHrjwPnjBaGqz9Pm2FUVxCtXe4uUxmc6sMfJuaRUlF
         YrybBkyf/1QbxRhxiXIa9SBVgDstp9XWTQk09yN6n0FQn9AQz2LCt/m6j5Tnr/zIVym4
         GS3lt3grZPdOCL4OBa2CwHeHEbnsMP/8TiS1kZA4Mk5LlKQajopttUfy2iiNooml1CCP
         /Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215894; x=1761820694;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RylQUWzAmqfhDIejJ1iRcquHT8WCtD5O6366ofaSbxs=;
        b=p9Ikm9+oY5gwk5Owlcw2Hdz+x6DT4+y337ahhqLWo6afO+F63zs7abfGxhXSjVMIh+
         lHxVYFK0jU0Il0FSchfLMvMNtnBUtbSJTtzix+K9+z7qyPIYASYrOBcLgH/VwvDhrdgT
         IIiRILHLD82CZMA7lWwyVhJyr5U1ECTSCMXbVbYgaJ23TvczO1bhR3BmDhQLjSskW0Dn
         1cMocyC52Ub/MukQGEjNqBJbDUTF/OEdN+LyUFw+VrzetMD6z3Lt0Dp51gNFszbmH1+u
         F+Kfp/7ZgL4ALf8NRfnUIuYjSVdg29GLy20a4HQMn0Gpm9oMFaQeEy6IZoe5K/6cytxm
         csxA==
X-Forwarded-Encrypted: i=1; AJvYcCWEu/WRlzG9yXa3kWSdWOe6hZOFy8elJGBBQ06nkJCr1IT1k9MCtgtF8YLKbHxx0MEmMCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc5upN1QyOSshex6ultp7PlkTuCXWkiLXlNFZMBceUH2LRKkZ
	1lkl3bS3qB1zlMwlUJdPBlgMPkt6glm/mAuWl3+R3RWJ1slHVPdJPx5sELeqxVlfWFc=
X-Gm-Gg: ASbGncu4llEHInHMxdzsv+CSRx2HfiFZP33mzMdX+ZSslWq/J40U8Q6WQBUZjwOxzDq
	njitDOUMEC5GVJ2uBMIoqA4f0HHcbAwn5tTvvt6aFphcukmo/6s8CaoL6vTLwrtHWeACPuOQ9h0
	RtRbTP55eE924tSUOqp0U21sHDCaZfIwbjUzBsV4Gi2cjMV5Y6Ex837mGpiqtwCBkaWk+tZOLcr
	vad/at5w2F5HyHSvM+l8JR371RlnxIpTpgJQeyszeRzG/ZBzydmDq/kVKX6JL/X+UGqMQaoZKS7
	nug9E8Fn5+Q3A+PXWllNYJd8awbw4SE+iawiNAOUwvBrcRg9b3gh8uK0QdqTU9e0dOL955OgSnJ
	9TfRwkyGLd0oWyvHk4zVmi3ly9Ia6FoB0hogdiWcpQPDrroQF6RIeN6T89ME6beHHt0hl
X-Google-Smtp-Source: AGHT+IF428fk5zCyubVuxvZcr7q4Ofz9JQRJVsHMbH8NbdatQl5oxi0RuwvpRKUYA6Xr+4lyQ7bfjA==
X-Received: by 2002:a17:907:7204:b0:b6d:505e:3d99 with SMTP id a640c23a62f3a-b6d51aefb81mr220073366b.12.1761215893431;
        Thu, 23 Oct 2025 03:38:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:7f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f7027sm191761066b.25.2025.10.23.03.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:38:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Stanislav Fomichev <sdf@fomichev.me>,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 10/15] selftests/bpf: Dump skb metadata on
 verification failure
In-Reply-To: <7956ac25-f0ba-4d29-a07f-d1eaafb84acc@linux.dev> (Martin KaFai
	Lau's message of "Wed, 22 Oct 2025 16:30:09 -0700")
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
	<20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
	<7956ac25-f0ba-4d29-a07f-d1eaafb84acc@linux.dev>
Date: Thu, 23 Oct 2025 12:38:12 +0200
Message-ID: <87qzutvr6z.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22, 2025 at 04:30 PM -07, Martin KaFai Lau wrote:
> On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> index 93a1fbe6a4fd..a3de37942fa4 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> @@ -171,6 +171,25 @@ static int write_test_packet(int tap_fd)
>>   	return 0;
>>   }
>>   +enum {
>> +	BPF_STDOUT = 1,
>> +	BPF_STDERR = 2,
>
> There is BPF_STREAM_STDERR in uapi/bpf.h

How did I miss that? Thanks.

