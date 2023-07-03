Return-Path: <bpf+bounces-3917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5AF74633B
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E19C1C20A63
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22266111A5;
	Mon,  3 Jul 2023 19:17:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E311197
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 19:17:04 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26BE70
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 12:16:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3533285a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688411816; x=1691003816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmfYPyzMN3TrxeJJNRGqcc1V78+Dvq57QM07q24THxo=;
        b=cBXXw1BX/YQS5OhV4wyvCMLEJtw2faKDUqVuqbWKxU8/5yCELOp1tCfXiXtEv52L9k
         Yug4x5JvummwpTGtDjxJFlx12KJExacvZghztwNbjKCtREYW/fbFvq3eUtxNKLV+zRXg
         QTsAuM4NQEoG6QGtlMfRxMY7t78OQSQoth/0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411816; x=1691003816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmfYPyzMN3TrxeJJNRGqcc1V78+Dvq57QM07q24THxo=;
        b=RxMsbRlcaVNQDEjfv5FPl01b0LXzdywg1rWm8xPwR8QhqP0odp/BYFByNuZZFGjxRB
         9Y3WsXfh5jndsZuoFBf547YQ94ZQRYdyPlKcCyVeP0lJrUWM0KXlQRZtrZT3etcbH6iw
         srlj6KMeWBNFHPtwRpH28HNPSrugCunfkyzAjXAgNUGk5MrGNieeDWTTK4qIIvdG3PIr
         L9hMuANGVNZk9eEGGKnHyLzGGSikxN/2agf61EAV/psZN2nV+Mg44OcehVfeqm0pjC2P
         MdqDLVdReVbfGTSMXIyUKhXIgrfDS50Y7pHAVH5KKbJe2yWRbkKDjhYmPZl8fZsFAXRe
         8e/w==
X-Gm-Message-State: ABy/qLZQLAABVUFwNFcrMb+OzMYW5ArLTqiCI270zXAxKRVGVSQ48Tvo
	mkUBES+y4nvC+iP7t0JEY98gug==
X-Google-Smtp-Source: APBJJlHAwULPXSe6lmSlODSHADBgzpaDcCSBPzHCTRoQEzG85Wo3jO6XKklJK6hdUmff3Yl9O+EZ7g==
X-Received: by 2002:a05:6a20:2595:b0:126:3528:5a13 with SMTP id k21-20020a056a20259500b0012635285a13mr13907284pzd.53.1688411816317;
        Mon, 03 Jul 2023 12:16:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i11-20020aa78b4b000000b0066a6ba123eesm14325571pfd.51.2023.07.03.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:16:55 -0700 (PDT)
Date: Mon, 3 Jul 2023 12:16:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Andrei Vagin <avagin@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: next: perf: 32-bit: bench/sched-seccomp-notify.c:139:24: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2
 has type 'uint64_t'
Message-ID: <202307031216.171373CD3@keescook>
References: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 12:55:59PM +0530, Naresh Kamboju wrote:
> Following build regressions noticed on Linux next-20230703.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on i386:
> 
>   - build/gcc-11-lkftconfig-perf
> 
> Regressions found on arm:
> 
>   - build/gcc-10-lkftconfig-perf
>   - build/gcc-11-lkftconfig-perf
> 
> Build error:
> =======
> bench/sched-seccomp-notify.c: In function 'bench_sched_seccomp_notify':
> bench/sched-seccomp-notify.c:139:24: error: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
>   139 |   printf("# Executed %lu system calls\n\n",
>       |                      ~~^
>       |                        |
>       |                        long unsigned int
>       |                      %llu
>   140 |    loops);
>       |    ~~~~~
>       |    |
>       |    uint64_t {aka long long unsigned int}
> cc1: all warnings being treated as errors
> make[4]: *** [tools/build/Makefile.build:97:
> /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/sched-seccomp-notify.o]
> Error 1

Thanks! I've updated the format string to use "%"PRIu64 now.

-Kees

> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230703/testrun/18069798/suite/build/test/gcc-10-lkftconfig-perf/history/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Kees Cook

