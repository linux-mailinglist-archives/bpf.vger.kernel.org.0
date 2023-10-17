Return-Path: <bpf+bounces-12453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B367CC8D1
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21965281AE5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D679CA48;
	Tue, 17 Oct 2023 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2CXNNm/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469255380
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:29:25 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDC100
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:29:23 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a82f176860so50733077b3.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560163; x=1698164963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SN6vITd1+O4UwNoJXfas5jEDggR3WXnacdwRB91/MAY=;
        b=O2CXNNm/7LD933F9uUHXf6pXRZwaNZ8wXPc/9oHiQmdSKmq67y6QgxDLyDIKnwLUQh
         GL0Nkw1Er1vesfW7e23D0kQ9wvfUfdf1r0GjSdQxfIJOTxZ1EcoevxEf3bTLD0QwFzcX
         deUruzNs5rl6z0t/N62MmQaIijjpa+YKl8q6G7WdsYHNBpV1x5LbwILf2LJyBqROmhNW
         t5RkVp1IDbdIqbUxcdXWCJhF5QV2n79RXYM9W7/sJ0B3Liv036SiwkcYIzoHBgYx+VKL
         35pPUbYDmZfCjd5JWidYBuGX0hKDgnXzOsx+SFR757ociKy+SPGMslkcAbruOf2/maMf
         D6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560163; x=1698164963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN6vITd1+O4UwNoJXfas5jEDggR3WXnacdwRB91/MAY=;
        b=SqkxkNhxiuv1k4O65zMH6aHPLI6KmCX6XhOh4RjT3etYdwNDyi+z+jQoQIiw+uvK/T
         pA4QS8FccxrnqBf0Wzr6Q7ufZs/eWQJh2nee5uDUm5nnnC+5QKj35bkixWvqBcfQlMgO
         x6oRu9BO3dcOJd9FS1yH218oauCQyUT9PxMvlA3rB7HC3VzdGyCLYReeuJ8PG8OIIQ3d
         9Hk0PGiABU2NItKSZhHeKdKSORPmSMHCTvbcx6wCGxExhvhmjYvafxlDJgEW/CMsMNA3
         00DI3QVd8uKNDD+jaByW76aual9hqguPlwwkGw1EGx67f5VNfs7UKjG7WxVzP3fFYzW4
         V/RQ==
X-Gm-Message-State: AOJu0YzRQQhbdMWqQ0uLkuayyGceh5o4WNC4q31Fb4Sj48TpT/OscR8e
	eVASU6WepIq7MNwCOymUhi+XrQW8CnE=
X-Google-Smtp-Source: AGHT+IEg4ZMUkn1hX4+OQ1njqgma/9JoahaLQYFUnWQcdaLVj/8ED72zAZuNREm6ozGrvdWd/5LqFQ==
X-Received: by 2002:a0d:c101:0:b0:59b:1f6d:1958 with SMTP id c1-20020a0dc101000000b0059b1f6d1958mr2955126ywd.46.1697560162972;
        Tue, 17 Oct 2023 09:29:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ed01:b54a:4364:93cc? ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id o187-20020a8173c4000000b0057085b18cddsm736598ywc.54.2023.10.17.09.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:29:22 -0700 (PDT)
Message-ID: <139165a8-fb5e-4d2d-ab2f-846127c02cdd@gmail.com>
Date: Tue, 17 Oct 2023 09:29:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/9] Registrating struct_ops types from
 modules
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231013224304.187218-1-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Just fixed a building dependency issue and sent v5.
Please check v5.

On 10/13/23 15:42, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Given the current constraints of the current implementation,
> struct_ops cannot be registered dynamically. This presents a
> significant limitation for modules like coming fuse-bpf, which seeks
> to implement a new struct_ops type. To address this issue, a new API
> is introduced that allows the registration of new struct_ops types
> from modules.

