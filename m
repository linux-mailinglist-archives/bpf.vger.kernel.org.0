Return-Path: <bpf+bounces-12291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528687CA8D3
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713F01C20A7E
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36AB27724;
	Mon, 16 Oct 2023 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="O80akG8H"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9D273FE
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:08:28 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D5B4
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:08:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca74e77aecso7352015ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697461706; x=1698066506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfy1ziPitTIKCgP7hgWatYcJeB1MWA1vHtQFUnRwmZU=;
        b=O80akG8HMtlEwCSfu7ToJqjUfOBwqyuB/N+7UgY2tM3TzKU7F6JMqdayHK08mRe1rJ
         ZqykConvOfOciejVhe/MZC35rkgQglss+K+TZ+9Q0wejP2hmeOqWxhOyNu/Bm7HLNt2V
         8JbCWQ1waGDllker+kN9OIaTzuy/WmHtUgZnNEunIiZrYsD1YwO6d1BpOPddFcNDyJHC
         ANjTrg9cc8Zyi3QF4klfPamU0rvLrTxDLAiJKXa1OiYdjaGwFsY7YTLcLKYGaEF1x4A6
         h7CBSD4vG/YN5WGOQTqxkjfW2lhj5QQ2Phux001IEBE0+xMfD56ym/mljoVRpijgfpQc
         W7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461706; x=1698066506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfy1ziPitTIKCgP7hgWatYcJeB1MWA1vHtQFUnRwmZU=;
        b=wWeZs29VHrvpsvK6CDpnXokO9FgOrcuBDpu045WDbDU1qQ1Ew+f8/kEsn2XygqJ4WP
         ldEgsq9BD1SYkawTs7CqVWA5pNniOCDtQi+GJWj1WjjTZkuU/6edSYjexavNHF1lFMTs
         sXj/HWwoCZPe6fmt0YOKPW8W/IiQgmxuSMYfGgJLes+j1wfDsa4ydTGOoysKVYipKf/R
         OQA0NMGyONcEnaWEKnhPiM1MYGox73mBo2QdtNT0q5ntjYrHNytzMAM9/xpFZ/i8hXAj
         be5oMfDSw+X3bpzBvAGrW0k+/TMp5NAEL8Y2uiduWqPd8Ei3pTfYLWpf0asWLFfebvXc
         vY6Q==
X-Gm-Message-State: AOJu0Yy2RWEJq2JYSwBizNwkZ5D0WpeiU8G8tHfdeGLjgz91NSuXYb0d
	7C0BcD6tnTCdX7ZXp4efhZZYcQ==
X-Google-Smtp-Source: AGHT+IEFoc6AGYZwR5/ObdpuzM9hbI7UWGokG/QIvGghVbavGZhqHMPuFgH+U+30ml7a/ChTLmr1wA==
X-Received: by 2002:a17:903:1ce:b0:1c7:27a1:a9e5 with SMTP id e14-20020a17090301ce00b001c727a1a9e5mr10234801plh.33.1697461706303;
        Mon, 16 Oct 2023 06:08:26 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001b890009634sm8420579plb.139.2023.10.16.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:08:26 -0700 (PDT)
Message-ID: <ecb37173-4b49-466b-b92d-4ff710eee998@daynix.com>
Date: Mon, 16 Oct 2023 22:08:21 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Use pkg-config to determine ld
 flags
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016124313.60220-1-akihiko.odaki@daynix.com>
 <f44993c9-1934-746f-aa3a-a1005459320a@iogearbox.net>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f44993c9-1934-746f-aa3a-a1005459320a@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/16 21:52, Daniel Borkmann wrote:
> On 10/16/23 2:43 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V2 -> V3: Added missing "echo".
>> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
> 
> Same issue in v3. Please don't resend your patches too quickly, but 
> properly set up an
> environment where you can test that this fallback works first :
> 
> https://github.com/kernel-patches/bpf/actions/runs/6533309175/job/17738285759

I think you are looking at a wrong run. The run checks out:
https://github.com/kernel-patches/bpf/commit/0c184cb0b561d2fb60b2dc79c2917cd7ff8cd8a2

This is v2. I think the correct one is:
https://github.com/kernel-patches/bpf/actions/runs/6533797864

That said, I found spurious error messages with the run. I tested it by 
setting PKG_CONFIG=false, but I should have tested it with 
PKG_CONFIG=a-command-that-does-not-exist. Now I sent v4, which does no 
longer emit noisy error messages and is properly tested.

