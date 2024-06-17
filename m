Return-Path: <bpf+bounces-32323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A990B878
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A044D1C23556
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEC18EFF2;
	Mon, 17 Jun 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TX6hlqX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2231891D5
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646736; cv=none; b=TkLX+WQ4kDC7lGqRC5OUMRhdCJ77o6GBfnnus5OO5XNmZD47JhrkAWmbA3prCy4hXSa8yamnjD+J7O3TwuTkKxpjeAdfhPiwqlArMJHpPEYGB3FN83CQdwGWWNUP4E6xliG6BLIuBZsRvfR56Zfe+beUa5SqlAnCJY7P7A7asuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646736; c=relaxed/simple;
	bh=9lDOTb2f8AXuLs4cYviqenAg02dNFiSnK2IuaFOPCKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDpvemC2mQ0qaYQlGhj4gWNzDnzwo8lFNrEJm+Y4DQAp+HjkmdsAnFzAuf/PhWVkS8vTdqZ+teF9CkHrgU1ZjTn6epbC8cZ6Ab1g/Yv9CnwJ8GNL9Bkj7T1dhwd2+kfwYCakPLjmNyAc3Rh4tYaQVsepjcxDqGBIzfhPT9urUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TX6hlqX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-440f22526edso23930421cf.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718646733; x=1719251533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsBAa/ARwTg/K6LW9O8k5LJYdei5cbyw2AgqkJIax4U=;
        b=1TX6hlqXvEHE4svPpT2/x/kh9CN2Nhyl2GAjIvfU3lnU/hzhUIdO03whKoxh2HaVKe
         xQhucIzt1t9ivqAvVxZ6A8fhdbFVRf+/sTWt3jdSzb64oRGGM4OGCEed3qC7MaFGNFkw
         We7D5JDQoPEwMWWhLucABTuhX5zNxWGJh/KnGXRqEu8nvCqZ/pO6L1OA2Mt7jecv/fjQ
         v4vBXCBLqhFU8TKae5HKgYkTPY1JaDl1XzHKYwOjl6q7eGzmagM035bmWOaLqmaRklUi
         CfatPvCIyCTQhsYmmd4Z1MvfT8uwen0cBqYwQFBp8DHPF9GcJABPPfRdE1Bny8Rz9kWR
         tOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646733; x=1719251533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsBAa/ARwTg/K6LW9O8k5LJYdei5cbyw2AgqkJIax4U=;
        b=vYU87ukM5GBuBQidHkXljrcsSJC+wK0hXjFeqAYYU2rgungGcB9EFfIiRbdEd+AXz7
         k0fxilqFpLWyjeQY/RmabcTpMsYNE0VK3F3PAs60oJszH49uueiPRdY4rNtPLpYRebDM
         KSzeCblO2zkUjxPPkIFh7wvUkNxDqyMeOzEiX5zkroc3clQ5IAXj73ASghnFs1h/BjdA
         0Oe7f+P6SIOQMCajKKWfqB/l1t8EeEyJxZC1bIqQVg5ckO0kj7rxkV80GtPSJIasYKYX
         YguSNMOuN31qpDjD+psmQJp1aEUBRDUm8MwQli+0oqxHdowUKYBr8EWM9WxpukMe4qFp
         qQQQ==
X-Gm-Message-State: AOJu0Ywk2azzwf69iLAkDYHArrhfX9js/LoETq5qBoFTC4JxuIHLSbiC
	fP34om47+TBZxXqiyzZqR/yhwlrUGVjpNPDNQL1ehHgjRV1Gl6i4NY2loh47Uw==
X-Google-Smtp-Source: AGHT+IGwsp9Lj3aiDiuV0YplOl9vjDi1q8fn2CYMdUXKoxfEIVqWos4Ugg+TaTB/4FBy0ogcS3Odqg==
X-Received: by 2002:a05:622a:1392:b0:440:279c:f9f5 with SMTP id d75a77b69052e-44216b4c517mr137300101cf.66.1718646733147;
        Mon, 17 Jun 2024 10:52:13 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-147-142.nh.cpe.atlanticbb.net. [65.175.147.142])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-442140af54asm44347581cf.48.2024.06.17.10.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:52:12 -0700 (PDT)
Message-ID: <8a281b63-6596-4538-960d-7cd74df17d6b@google.com>
Date: Mon, 17 Jun 2024 13:52:10 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 pengfei.xu@intel.com, kernel-team@fb.com
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 13:18, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The bpf arena logic didn't account for mremap operation. Add a refcnt for
> multiple mmap events to prevent use-after-free in arena_vm_close.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Barret Rhoden <brho@google.com>




