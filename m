Return-Path: <bpf+bounces-23053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA486CCD2
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D13B24A27
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC81419B5;
	Thu, 29 Feb 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SNwnv71h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59B13B7A0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220259; cv=none; b=oc9quX7IReryOoGAzNNZpQZ2PmTxcmlKXJl7qn8/OrKpm1aEY+kwjqtunneuC3lTuDgPF4RqTf1YFY3rWxaOaIzO3pPblF6/KCWRww6crAX7l8oj3gDj+AiVa/I9jgt3mrQtGahbG7ZmtSJmeRCKvrUkCVs1DQDz21LSMDM3vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220259; c=relaxed/simple;
	bh=LnR12CAU4GeadtW8nknlY1gk2nO4oKWuRJ1DQ/GXLa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLSCY/HFJxLy0CIkqe1HIWGREaxiDZJ7e3AGJhGhpXZBQzYcNMMWHFA0Ln/koqrmppbl1iQNjFyg6rzOI7YLtnhM819yCczbYLJQzpvgVEJ4bTFPUff2x9/ultYfs5gf08ZUIAp91R83rwV2J+l0wqt3646dYdX/pj2qflwM1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=SNwnv71h; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso6976215e9.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709220255; x=1709825055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6z/wIrNSg0f+IIdYJon9RhSlhQW4q1HTYqv2X0cHJ8=;
        b=SNwnv71hxk0UZ26hbRhGgvFYsZAv/xQOBirS32eWTS/aKIu0uM/VChtDzqeleICzEt
         Lvphq/XqKu9yTnrNyzwiBtxwlXUT/4MvpLsK40q3v0+tMiJjMnvqMOKJs1Nj4z/bjTFU
         uL2ewvxzBjXtw7V9zjySOQQnm1V+l1c7+ngD9x465hcFEBGB0UutPfc0NDNRU5prq9WQ
         VRy9JzVpOniifswV3klQHucbThE3J76kA8hdDvH50lZMkZg0/XmtNHQSU8pHc5/6vnph
         gi6c6bQEhG+eDdw/FB0apRuIfbM2S8LOm0WpXJTRWTGONgg+cEPPS2BPKfucgmfjnKnk
         B+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220255; x=1709825055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6z/wIrNSg0f+IIdYJon9RhSlhQW4q1HTYqv2X0cHJ8=;
        b=mbIeQrVmi7/H75c+YCh3PwbP80aqniakegMeEmqr9k5HDLAJzRH1a06X1YCG8dONox
         0fbroLydFGAM91gGPL7Bpdxyo+9rs26vnbq7jeQ5NL7dPnGCs1XbgHYmmz6o5S4i3jdx
         BlKiFpQBvCU+MDJJTk+0yTYTHVvXY7lFq4bKxujhI0XtywDeAHee8NaOeI8ahUZTbVLU
         ln5ha8Xgsjrs7WCuwmSA1/k3Xo8zKlLSOKyEiN1/3uvxEX3RLrVrAUMH/hXiZEcVI2MT
         v7bwkjqmF11TCiaacYFdwfd9OF47wImYnt16oVs55gdTJ/+mUvXuWUJ6zVXZ86pr+FSB
         gZKw==
X-Forwarded-Encrypted: i=1; AJvYcCXd2qX+KfUThpcP0wi3/znnFyGOqRxdsHAXLjjeuJ2upRiD5rZdB/gvoCSvnFZmxCf/LupDBswnrpTE4CjPa+sKd/Ls
X-Gm-Message-State: AOJu0YwgHBHxPQBpq12BmoR05ik1v1jT8AgD0OtSvupq2tVHrKUkxFxA
	V6h2gnxtMOcLp5QQq3XdF3/2p41NmmNJZ7ftbZ0T8icTm9r0ctGVUNFqrthS5a0=
X-Google-Smtp-Source: AGHT+IElGr+MSxlj0IEppct1psrxKnD9PnPnQ5PYmBZxBWYC1YYPaPJAbIqOV6f0/558Ml62biCujQ==
X-Received: by 2002:a05:600c:474e:b0:412:bfa1:fad with SMTP id w14-20020a05600c474e00b00412bfa10fadmr1231406wmo.6.1709220255577;
        Thu, 29 Feb 2024 07:24:15 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:b9bc:a5f9:b673:94cc? ([2a02:8011:e80c:0:b9bc:a5f9:b673:94cc])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b004122b7a680dsm2440923wmb.21.2024.02.29.07.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:24:15 -0800 (PST)
Message-ID: <11b5b6b1-a411-4671-aaed-bc0f6cc1be49@isovalent.com>
Date: Thu, 29 Feb 2024 15:24:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Bryce Kahle <bryce.kahle@datadoghq.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net
References: <20240130230510.791-1-git@brycekahle.com>
 <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
 <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib9iaYRkvy0YHpwv3yqx9tNuDbbLNAoeeOpfo_Fnw1bxdA@mail.gmail.com>
 <CAEf4BzZBGW5V2bv5LsUyBOS0500xeMwxVvtVpsuDk5uUCQZPVw@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzZBGW5V2bv5LsUyBOS0500xeMwxVvtVpsuDk5uUCQZPVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-02-29 00:59 UTC+0000 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, Feb 26, 2024 at 1:48 PM Bryce Kahle <bryce.kahle@datadoghq.com> wrote:
>>
>> On Fri, Feb 2, 2024, at 2:10 PM, Andrii Nakryiko wrote:
>>> But yes, you'd have to specify both vmlinux and all the module
>>> BTFs at the same time (which bpftool allows you to do easily with its
>>> CLI interface, so not really a problem)
>>
>> I didn't see a way to specify a directory for vmlinux and all the
>> modules BTFs. Are you suggesting I specify the path to each
>> individually? I didn't see a way to do that with the current CLI api.
>> It assumes that the input is only a single path.
> 
> so right now we have
> 
> bpftool min_core_btf <input-btf> <output-btf> <input1.bpf.o> ... <inputN.bpf.o>
> 
> so we'd have to either add a flag and do
> 
> bpftool min_core_btf <input-btf> -E <extra-btf1> -E <extra-btf2>
> <output-btf> ...
> 
> or define special key/value pair (we do that for other commands to
> specify extra options):
> 
> bpftool min_core_btf <input-btf> extra <extra-btf-1> extra
> <extra-btf-2> <output-btf> ....
> 
> This has a tiny chance that user used "extra" as a name of one of
> input object file (we can probably disregard).
> 
> Yet another option is to introduce new command, something like
> `bpftool min_core_btf_multi ...` and define new convention.
> 
> 
> OR. We can pivot and say that we do what you want as two steps:
> 
> 1) generate one large combined BTF from multiple BTFs, something along
> the lines of `bpftool btf merge <btf1> ... <btfN>`. We'd need to
> specify how split BTF should be handled.
> 
> 2) then use existing min_core_btf command with this merged BTF
> 
> I don't know what's best.

The two steps is maybe the cleanest option with regards to the command
line syntax, but it doesn't feel great to impose an additional step to
the user just because we don't want to rework the syntax, I suppose.

I'm not a fan of the multiple "-E" flags, it's not super consistent with
what we have for other commands. I'd probably go with the "extra"
keywords, or the new subcommand name (and mark the former as deprecated?).

Yet another option could be to support two alternatives syntaxes for the
existing subcommand if the first argument is, say, "input_btf" (and then
define this new syntax using keywords for all arguments).

