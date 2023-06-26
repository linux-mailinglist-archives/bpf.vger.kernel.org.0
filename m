Return-Path: <bpf+bounces-3443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799B373E0FA
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821FC1C20913
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86AA93D;
	Mon, 26 Jun 2023 13:47:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D870947A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:47:10 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF832E7A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:47:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8775126d3so4256065e87.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687787226; x=1690379226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ajgNyIwWVcjYzMwm3DqnghOvwsLRw6qD3CZhsNi77c=;
        b=V8u9lIovuozTtLYUjXpTS7ULYjyFXNNH91wqTcdZLzgyKyyep5wVeXZCMcMy8wX9jF
         bFZ7vDrmDSceVrr7oDg+wbgk4TKsV7sq+NHSWOwEYO8XTENMv4rFSFUjeszEYgm/3anL
         ZSY8rR3ZF6c6OtMdC6Y76w4uVX0QNMrVRBh6a+fCocx77Hp3Q8HyakiAKh5RM3dS9OUk
         rLbcsr43EA/DQGnVN8a7Zt7OWr5FFJAN/Eh3spRhI6dHfxdvS75vlizeP2assm03fNwm
         NjPnafyE7zUejngXe65jjCyijnu/+OiRggEdOwFtGL3Rlg8OPVf3m/wCIg0Ily+fDnBY
         ccuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787226; x=1690379226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ajgNyIwWVcjYzMwm3DqnghOvwsLRw6qD3CZhsNi77c=;
        b=k/i75upm42zlRSUYQYJXcdUzQzUK2WN2d2BKIbQziOp1nHcgQ2YZV5njsszIIqp+1L
         9Fyx2nwXvzJJcoRIAC+sMWg0H5TKz1UWlBGvGyRdmQkQxqvv8WmxO7S64mLVdXyToGpw
         S9v8WjBqQbH4IFX8eMrjW47gS3FNgnbsFQwrxT6zNNV1VeVB42UuvIaWvCeJR99Vvh1D
         6DTh0AXI3mgNPcqsuHpksmQyk4tU2oiXRQe8E/PYO/Bs54YxicKMtX90u+wLG9wybst0
         vrMlcmzXVkYGwH3Kinz1X5SqZ41uQLzDH0Uy6B4SxJkCR8zRQYmWd4HU/czAAy8RqLVR
         ACiw==
X-Gm-Message-State: AC+VfDybqfHGz3FWxulT5tReSNLpohgJJ3o/Hf1oEjOv4f5l7CL42fIG
	qSN2IZeTy98qJdP18tLD8Y/vvw==
X-Google-Smtp-Source: ACHHUZ49MM6SoxHOQwXx4/5NyeGysVk3STjfIfrbc8JWShz/Wbl953NReXc8cQftzBAW+LXumnPAvw==
X-Received: by 2002:a05:6512:31c8:b0:4f9:5d34:44b1 with SMTP id j8-20020a05651231c800b004f95d3444b1mr10794636lfe.2.1687787226112;
        Mon, 26 Jun 2023 06:47:06 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o16-20020a1c7510000000b003f9b155b148sm10720189wmc.34.2023.06.26.06.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:47:05 -0700 (PDT)
Message-ID: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
Date: Mon, 26 Jun 2023 15:47:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace
 tools
Content-Language: en-GB
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3065880.1687785614@warthog.procyon.org.uk>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3065880.1687785614@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,

Thank you for the patch!

On 26/06/2023 15:20, David Howells wrote:
> The following error is being seen the perf tools because they have their
> own copies of a lot of kernel headers:
> 
> In file included from builtin-trace.c:907:
> trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
> trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
>    28 |         if (flags & MSG_##n) { \
>       |                     ^~~~
> trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>    50 |         P_MSG_FLAG(SPLICE_PAGES);
>       |         ^~~~~~~~~~
> trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
>    28 |         if (flags & MSG_##n) { \
>       |                     ^~~~
> trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>    50 |         P_MSG_FLAG(SPLICE_PAGES);
>       |         ^~~~~~~~~~
> 
> Fix this by (1) adding MSG_SPLICE_PAGES to
> tools/perf/trace/beauty/include/linux/socket.h - which looks like it ought
> to work, but doesn't

Commit 58277f502f42 ("perf trace beauty: Add script to autogenerate
socket families table") seems to suggest this file is only used by
tools/perf/trace/beauty/socket.sh script (and later by sockaddr.sh) but
not by msg_flags.c.

If I'm not mistaken, it is then not required to modify this file to fix
the issue you mention.

But it is still needed to modify it to avoid another warning:

  Warning: Kernel ABI header at
'tools/perf/trace/beauty/include/linux/socket.h' differs from latest
version at 'include/linux/socket.h'
  diff -u tools/perf/trace/beauty/include/linux/socket.h
include/linux/socket.h
So another issue. When checking the differences between the two files, I
see there are still also other modifications to import, e.g. it looks
like you also added MSG_INTERNAL_SENDMSG_FLAGS macro in socket.h. Do you
plan to fix that too?
It might be clearer to have all these modifications of
tools/perf/trace/beauty/include/linux/socket.h in a separated commit as
it is fixing a different issue but that's a detail. As long as we can
have perf compiling without issues when using the net-next tree :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

