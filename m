Return-Path: <bpf+bounces-16925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F366680793F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FF41F21237
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7096F60D;
	Wed,  6 Dec 2023 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="seUOAm2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6CBD1
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 12:16:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce3efb78e2so208394b3a.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701893800; x=1702498600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHDdFruPzZ1Pb4ZidhpAKqlDu1RUv7Xj40kMDRXWKOw=;
        b=seUOAm2EBwc/WuIGST4vJT01SqITGy+RszSSQlP4KcbRIiehIyjU/Nal2SAsPI7KN7
         1h26ZqnBXZyIPFAjkPLag2VLXOhVqf5K+7onpVUjH9ShcM0kShN+Iuu2tP+dhV9C3BN7
         zdhd6ynJxvxUtFI/I6s7erTPndlmgkBd9nyhYP8SEvwT7OyMlAp2ha+zfRfgddO/L5cA
         hvi0AMOnvPM3Ws2zgbQjSAVnLWO8g8tKkP9nUd+9kH/lX039CJvuEH25QOl1AIvnLfgt
         ddY9DsFYaDMTROMVIiPcnCcKltKA41a5HXIX03CxnWb8jGQjZVhskeIlVjQW/P0MGNVb
         C6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893800; x=1702498600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHDdFruPzZ1Pb4ZidhpAKqlDu1RUv7Xj40kMDRXWKOw=;
        b=tFYmBl9+kBKukgMxNrKmu5TlmiLb8ZqzmcsRRUw3H+IF202tstzm4BhvCxNXhywOg1
         /qF/nn2vDZYTgjCkWKGTvDc7JNZjAPuwF62QrhQFHBaCKW7RCqPIQsV9ic2PEO3P5oe7
         uQaajLDq5dGueTDKkxA5IWH3cbYHhjdAGccbXH6QQU1arTKdsI+mdqff0H1QwuImez//
         XUHgw/vQjesGJBkx41tJjUje/oC45o92Iu5ZZ76n3t4rAQ7TLBSxWfWPyidyDJuvYBxs
         OId3bnSb8Y+OchgPNUShgL0M8qW7XMSNxvyzJiUUoqR41qr9DDSHWIcu515B2sVpWSQM
         KP8g==
X-Gm-Message-State: AOJu0YxNTvwDrDjfeit+pjU3HslBH69CNx4BbeA0efQ35TAugef8NK0U
	GFEGYbqH4BUtYmtG6RD7UGvIUg==
X-Google-Smtp-Source: AGHT+IEJjGg7cjU8bDiExvmdFdxPzabdESP6PC+IZS/5jqk/UWm39U57AGakQVtdh8kYN2CMcrru8A==
X-Received: by 2002:a05:6a00:430f:b0:6ce:7631:8d7f with SMTP id cb15-20020a056a00430f00b006ce76318d7fmr1579922pfb.51.1701893799957;
        Wed, 06 Dec 2023 12:16:39 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78ec3000000b006cb60b188bdsm348444pfr.196.2023.12.06.12.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 12:16:39 -0800 (PST)
Message-ID: <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
Date: Wed, 6 Dec 2023 17:16:28 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Petr Pavlu <ppavlu@suse.cz>,
 Michal Kubecek <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
References: <20231206192752.18989-1-mkoutny@suse.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231206192752.18989-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/12/2023 16:27, Michal Koutný wrote:
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)
> 
> Original module names remain unchanged.
> 

Can't you just keep the sch-, cls-, act- prefixes for the aliases?
They look odd in the current patchset TBH


