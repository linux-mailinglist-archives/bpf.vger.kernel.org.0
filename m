Return-Path: <bpf+bounces-15547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6A7F33A3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6ACBB21E1F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A45A107;
	Tue, 21 Nov 2023 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Unf2m2JM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F13112
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a55302e0so8309547e87.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583972; x=1701188772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfoJK3t0qirvp99bVKRD0fAJIXYrt+1afHjvGKrRGXM=;
        b=Unf2m2JMmBtntMK3RYMHV++5xH6Ilu6BUSWpA1nw9Pegs0iaZyG5YjBcFlAp1Y5emE
         xtNcEqooTj3c3vMcN4OdhCo/RdKLzTt8KrpJ3tSndpSMEq6hEamKMGxPvm1sAx/RWWql
         MLM2/ZkwDLmVG3OmAoNnwpwXK1gkBFhkHUS/VrQypgwAdKDqkBWOxt5NxlEw8gS8qkgs
         Cv13hGFxZtfTZf+jlRoeApXmLWNhzQVham7LUoFTLooA3rmZA9i5spnAsOoMwNHvF0Xw
         Uy9lRIkkxF5zKlqvgZJcOcKLo24xW/jZ6PABvEIv1cC0r4jgBkcxetIWkIQNyV28Gkqa
         wofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583972; x=1701188772;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfoJK3t0qirvp99bVKRD0fAJIXYrt+1afHjvGKrRGXM=;
        b=Yh62THHCEIOdYxeReuAEzeEMUsOBZMV3EWVK581LozU1BHsLcIKqBUBXaqpU0ZlpPH
         hJDUaTt++E7FN2hi2Hj196tJLItlPobwprZ90gU4fEpfNYHtD3JE/lLcbkC021eIMmUS
         g/1BcSTyJ8v3q6WRsHurHUJBeDSaqGeKJvkw8dk5DYkr+N0ScSejt3wWcrA0+zlHZzcn
         u49uBE2onLkDks8gixDwiLA79Jb1SFruEhdEp5FxcoC0jxAnbmtui4PKYabXgK/9NBJG
         E57nMtXhlfi9vlUfqq1dpl5gFxo0Bj4WNpl9IysgL/0CJnsepLJjWdMqp4iPRv8xx87e
         brCQ==
X-Gm-Message-State: AOJu0YyI89F1C/svuw/UdPIL6zyjLhNpkQl1/T168dvkO7iwi92G34Cn
	ji+la4i+9cFBI6hAZF9DLPINsg==
X-Google-Smtp-Source: AGHT+IEoWtKfkKpBUYZHDVwblojRWdIB+SUaeENzNIfbdDs50m7szrmT9nEJjI3VKeBaepbl45tN1A==
X-Received: by 2002:ac2:4906:0:b0:503:221:6b1a with SMTP id n6-20020ac24906000000b0050302216b1amr7355443lfi.0.1700583971713;
        Tue, 21 Nov 2023 08:26:11 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:11 -0800 (PST)
Message-ID: <1369945a-9ecf-4b45-813a-96e609236d42@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 4/9] bpftool: Add test to verify that pids are
 associated to maps.
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-5-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231116194236.1345035-5-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

I'd keep at least the command to invoke the test in the commit
description, in case someone only looks at this commit log and wonders
how to launch the test.

Also this test is not supposed to succeed with all versions of bpftool
(we need support for skeletons in bpftool for dumping the PIDs). So I'd
like to have either 1) a check on "bpftool version" to make sure that
the required feature is present, and skip the test otherwise, or 2) an
option in the Cargo.toml to enforce or skip this test.

From what I understand, you're using this test to make sure that PIDs
are present, to avoid relying on the output from "bpftool version" only;
so maybe option 2 makes more sense, a parameter to tell cargo to run the
test and expect the PIDs to be present, whatever "bpftool version" says?

Quentin

