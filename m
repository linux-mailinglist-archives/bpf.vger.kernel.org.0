Return-Path: <bpf+bounces-9457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC2D797D6B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1768E1C20BC7
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B613AEA;
	Thu,  7 Sep 2023 20:33:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502C63A3
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 20:33:10 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF371BD0
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 13:33:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500b0f06136so2348231e87.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694118783; x=1694723583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1ER09Tm8HaXNHr1o16m8HylrPTLTZyqmFLjhfBRzpU=;
        b=EJFKOobQLJ677XPM622YNjVQZH/nmJCSvc4beYcxAUg/Lu6ar1PD8Z5y00Oze4PO89
         GqrL42QUPREdNGT0nIBbkZhITtF+KM4LEsxoK+me63Wv8WYz4Os8nunRqMkecfSlGHP+
         5qRizcGwIEOhq6rHnqNX+NBF/IaqsJlFVXShau8RTf8iRdUIQz/HlVePcxomYc8yUyFa
         /FWfY1ARhViqNfDzeKaazPGbdMKBpJBu/DMXAkmigTF/8beoEmegnpwUTDUA2+ycJP+1
         7s/wflOnQ5sXEYxamCHxmRSTdGAwf1PdE8bIBx8XZempHb3tmVan65t7xSvoV7MOD9f2
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118783; x=1694723583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1ER09Tm8HaXNHr1o16m8HylrPTLTZyqmFLjhfBRzpU=;
        b=o+Rr9YqIAHe1ZMKBWlR5ZNZr4LYjQ4hlbhGLTeWi50eO/AUEOTa9EuwWV+oxBdtqJc
         9blLoEraE0+S4tdYBVQfzGWOdJfJPnqgNfjXVGFDRzeQN9t/g+Cn8D8kvb1YOQTa2wvD
         132+sTSfto/Xczr47ObcIsWjBtYKHMKBpshK3dvlAGxti7wrbUHYMEAozEpD/SxbDgG8
         sfY/OIsFneZhwwVTrBGW9QgHv0Ite9Kdm+3ZCBTb5Mk1Fnp6ixgWZH05pYBqTkZFlZ/U
         rl8QyXMiiIaDwor+sGXg03mBfmKnizQpmWx6pGG1Wl4CwYevvi7qWckGqBvialHHipN7
         4yXQ==
X-Gm-Message-State: AOJu0YzL0aXXTmuQgNTMOfVjcVp8zr9ITDO84YV5WK9VN9IMiau58lwi
	xZu+lufbqiEp9o7cqYqp2WU=
X-Google-Smtp-Source: AGHT+IEJqWm7XFYDSsaDXikPhTvM/sDF/Xu0+O/i8o48lFmyFtw0x1kW+/KSE806D7cGxOLldeOGLQ==
X-Received: by 2002:a05:6512:3d09:b0:4fe:3a57:7c90 with SMTP id d9-20020a0565123d0900b004fe3a577c90mr493422lfv.19.1694118782847;
        Thu, 07 Sep 2023 13:33:02 -0700 (PDT)
Received: from krava ([83.240.60.60])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090635c900b0099bccb03eadsm80068ejb.205.2023.09.07.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 13:33:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Sep 2023 22:33:00 +0200
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZPozfCEF9SV2ADQ5@krava>
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> So we've got a curious report recently:
> https://github.com/ClangBuiltLinux/linux/issues/1913
> 
> ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> '__BTF_ID__struct__cgroup__624' is already defined
> __BTF_ID__struct__cgroup__624:
> ^
> 
> It's been hard to pin down a SHA and .config to reproduce this, but
> looking at the definition of BTF_ID's usage of __ID's usage of
> __COUNTER__, and the two statements:
> 
> kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> 
> Is it possible that __COUNTER__ could evaluate to the same value
> across 2 different translation units, leading to a name collision like
> the above?

hum, that probably the case, I see same counter values at different
__BTF_ID_ symbols:

ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
ffffffff833fe578 r __BTF_ID__struct__cgroup__380

perhaps we were just lucky not to hit that :-\

> 
> looking at another usage of BTF_ID other than struct
> cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
> is only defined in one translation unit
> 
> Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
> some other way we can avoid these collisions in the future?

need to find some way to make the symbol unique, will check

> 
> Was this a previously observed/fixed issue?

first time I see that

thanks,
jirka

