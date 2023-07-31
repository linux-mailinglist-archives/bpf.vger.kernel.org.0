Return-Path: <bpf+bounces-6440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F6769682
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032AA281709
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F117AB7;
	Mon, 31 Jul 2023 12:39:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BF4429;
	Mon, 31 Jul 2023 12:39:03 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521BBE;
	Mon, 31 Jul 2023 05:39:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686c06b806cso3051131b3a.2;
        Mon, 31 Jul 2023 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690807141; x=1691411941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NdBjknSuYCdIA7o+nHXDhfIAGLIzK4MLXsbrYki0JY=;
        b=jkV7Ee1kEYOlbpc8lA0nglpIRWvqaFw6PLV18U2xqWzjggIudqTjPJBnmo55NnoZxC
         e43VcJmBfO7t1Rld4jVt9yLVyfIiQvNuhe7u/ahsNXDniyb84agIFfIHYPTLrsZXQf6b
         mZw4we3tYdq+CEoPX0d74esz6DdoNJgzj5n7PSgY93PcKL7WtIL7qB+YhOK+fneI/4wh
         0SPjGvH4APNgT7mpvZd/M8j89tVhuNxIC1DXnxbP9kQBreLLp2ACojh8oj1Fes838Fm3
         Ha5hVPmihBt37ypOk3O+cxEwszDTUoZ5IFHCmtpXUL7XSYkcfHMvSGG7dfpe1C22RjbD
         i4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807141; x=1691411941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NdBjknSuYCdIA7o+nHXDhfIAGLIzK4MLXsbrYki0JY=;
        b=N0TZRmvtj7XV/6OsUxmqINhzqb7V7mdJ1g1wQXhsMLF/vjiuXFcBAqCYufMVjSqsi4
         cY90Whxtm4cqJ/9jDeAAyElmdCptf7slwtrd5p3+sOK8XjrN5fGi78g7t7xKxn9VHGhC
         E23p0WPuinzhFhRMr5TMzqwb+MrPPjCD7aCNl4vFfWu00zLvu02c7tPdc69kkeJOrXIR
         d2riuI5ZM9MknxbKK5y4IGJxEuJq7UiC+JPOT3Ht8GhsrvWA3PrDCWQW+TU2R/ytfaxM
         U+tC5k7WYTQBvQC3ufwdbUNRjcES9gavawnalw70EQ0hW8l03yinpYWm2sP7ITSQZhkC
         uS/g==
X-Gm-Message-State: ABy/qLbqDiAYCZlhRLHIqoTy28wiu0u+h1K4NWjyUkcCTPXsx1tV65bC
	AC3drWBPx3nJ38XNewtR70w=
X-Google-Smtp-Source: APBJJlEEHU57hychI0GDF4B7p2VLE3R3k67V3t9pCA7n48EeAfoQYQdom14VH9o21wZVfQmLXvkFGw==
X-Received: by 2002:a05:6a20:440d:b0:13d:c70d:de62 with SMTP id ce13-20020a056a20440d00b0013dc70dde62mr2629107pzb.22.1690807141577;
        Mon, 31 Jul 2023 05:39:01 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id i8-20020a63a848000000b0055bf96b11d9sm8074510pgp.89.2023.07.31.05.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:39:00 -0700 (PDT)
Message-ID: <5de2fdca-5f62-74db-afec-8cb54ccd026f@gmail.com>
Date: Mon, 31 Jul 2023 20:38:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v4 0/2] bpf, xdp: Add tracepoint to xdp attaching
 failure
Content-Language: en-US
To: Manjusaka <lizheao940510@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
 <CAFYRFEw98BhpcLyFdwivLcy5M6hk3fDRcWZVtUytSw7kNUQXRQ@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAFYRFEw98BhpcLyFdwivLcy5M6hk3fDRcWZVtUytSw7kNUQXRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/30 21:49, Manjusaka wrote:
> This patch is very important to help us to debug the xdp program. At
> the same time, we can make some monitoring tools to observe the kernel
> status by using this trace event
> 
> 李者璈 & Zheaoli
> 
> Email: lizheao940510@gmail.com
> Github: https://github.com/Zheaoli
> 

Thank you for your feedback.

I'm glad that it's helpful for you.

Thanks,
Leon


