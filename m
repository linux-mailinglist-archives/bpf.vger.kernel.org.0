Return-Path: <bpf+bounces-31017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09C8D605E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C061C20AAE
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9257156F5F;
	Fri, 31 May 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DFgamvD7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30B156F46
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154025; cv=none; b=USgyFv9IMolRUtIvnPoLCRRKLO3Ej25tp6ntoY4a6x5wtZ3vesGQ2C8mrJskXX8YcFu9Bs1bTWvEp/1foThMxOcFl0FiOY8ofCsF2ZOwd7gPlPH854e5LhlgBO1GsLcmD8VQXTZ5LYHQr1hb2pEF1ikwiGDZJ2LSC2/sQHXhKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154025; c=relaxed/simple;
	bh=b3A47GKp3DVbDjtboyMRPNUCGOfNcSUH5VJJp458EUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT9uHyFYYFbbXotKyx8T1ItJRSgBGWlkWfRZucKtbSBqY0lefcsEZPNXr8CLXW+XOUMwR2oYU7P9uh7MDMpbe7DiFv0jZU71AolXqNahLFcfVbL92gDSPOyjLK8g+mLqUjwAJEfxlhTvbCuSGWFb40ZvkouiUqvP0IQEM8BMOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DFgamvD7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a635a74e0deso218376466b.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717154022; x=1717758822; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Skowyj1GrS+nqOzj9o4sPhgAkjxMx0n01JEJn6nXjeY=;
        b=DFgamvD7fWNZ3ekk7r3dttyp6qGzYlWvuonpHDwWdV7Q+lQAkLxVv2aXBedB4/gs4Y
         NtqSEizsJlZdAob+p53/h71nk2oYFr58gT8PWVtY4mwcRP2IBcLeyI0Zcr5x2qBg92KA
         V+McSmAMFibkYBkCCaGfNYSgLBEBWBGMG359uXBmQLXI32WNUKewnfEL6hRmn+yLyVjC
         6oEWHaViIpu1ECCyPbpVLGXgrpWgulySgknkhO1yp1SqN3YmEoAzk7qEBswDjvx8zlw6
         YJtTXtiP0GLyB4a8bHrHJC4JeIEH7lCclbbltcWxwSDD0CUnaCuh9sRVeC/WAiTjoAdW
         Wi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154022; x=1717758822;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skowyj1GrS+nqOzj9o4sPhgAkjxMx0n01JEJn6nXjeY=;
        b=ot0051hbCwt+rpMVFIUATpPDE1xRndD8CYRbddWisurFs+40uRDqtq65Y1QAkpIphh
         BYq13fx16u7u6D3gOII5nWpUf7uDHajbbQP4tyYwi6wCpwn6C+NXVxDc5NipS1X+zmCQ
         w7dB9dPgBOIPeLVdK79CwS55WA4kotq25SKiTz5L0s4IIG56GzHTsZLlMTZXG3ld2Ttn
         waZXgPwpyF5esrHczv2r8yfdgtzlE7RQ3kMWAl3HQqppDo9p3iTBXXVG26cJwj8c/9GK
         icUGm9zrW3Kxo7TNrwK40q4uyHvXUF11DyEVAIifIHNDtD9ni/qpWvl/lVzHYK6YrmmD
         9e+w==
X-Forwarded-Encrypted: i=1; AJvYcCWnHQXHo+nHuZylz6Vk83i71r85R3EMQyZ2ex2AOZJBFiqr51pO2tgytrIYDbp1cTfbq2FEzraHTh8kGcMQkJNpL45J
X-Gm-Message-State: AOJu0Yy1eC2i59pnDvKVRQs68SsplovMVOBC0/NIqzP0NCLmp1n1nGiN
	uXaM1Gx4jp3L8num4760qsUxpuBVsM5iHUIWs63xCXRmtgQPlT19uG9UE9DhcHY=
X-Google-Smtp-Source: AGHT+IGaxXHFTVRHEsvv6q9z+YGNFkpqNRVrzgFepTWblfIrwjh5IyPMmzwEBN+iYaMSGdvj8ETx6g==
X-Received: by 2002:a17:906:6046:b0:a64:3518:f904 with SMTP id a640c23a62f3a-a681fe4e25emr106111666b.7.1717154021966;
        Fri, 31 May 2024 04:13:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68519892c8sm49491166b.65.2024.05.31.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:13:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Geliang Tang
 <tanggeliang@kylinos.cn>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
In-Reply-To: <66590f821d120_e5072085a@john.notmuch> (John Fastabend's message
	of "Thu, 30 May 2024 16:45:06 -0700")
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
	<32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
	<6654beff96840_23de2086e@john.notmuch> <87wmnfujwg.fsf@cloudflare.com>
	<577531139c4db3cb35f3f40e23587bcb9815b0ba.camel@kernel.org>
	<66590f821d120_e5072085a@john.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 31 May 2024 13:13:39 +0200
Message-ID: <87wmnaw7x8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 30, 2024 at 04:45 PM -07, John Fastabend wrote:
> Geliang Tang wrote:
>> On Mon, 2024-05-27 at 21:36 +0200, Jakub Sitnicki wrote:
>> > On Mon, May 27, 2024 at 10:12 AM -07, John Fastabend wrote:
>> > > Geliang Tang wrote:

[...]

>> > > The one advantage of test_sockmap is we can have it run for longer
>> > > runs by pushing different options through so might be worth keeping
>> > > just for that.
>> > > 
>> > > If you really want links here I'm OK with that I guess just asking.
>> > 
>> > It was me who suggested the switch to bpf_link in reaction to a
>> > series
>> > of cleanups to prog_type and prog_attach_type submitted by Geliang.
>> 
>> Yes, patches 3-5 address Jakub's suggestion: switching attachments to
>> bpf_link.
>
> OK. Lets just take them the series lgtm. Jakub any other comments?

Gave it a run - all looks well. Thanks for the patches.

Geliang, is there some MPTCP+sockmap use-case you're working towards?

