Return-Path: <bpf+bounces-2238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7272A074
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E745928153C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097F19E70;
	Fri,  9 Jun 2023 16:44:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49A17750
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:44:55 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FCB3A97;
	Fri,  9 Jun 2023 09:44:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b23f04e333so7588725ad.3;
        Fri, 09 Jun 2023 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686329080; x=1688921080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EdaYmroOCsHHIxQ/Q7Hjtm846vg4ZSkKlVHycee4hiQ=;
        b=fGFbD5PSbYF99UQlwiVez/cMM9upAZnvHfzE4RaHFwWfjw17nkaOCvOZpLpPtoQAij
         xMoQyyojMpceSiBfMVxxKBtqFuAZ1bteNFeokFwvw4xdRiHFeo7p+uSe3Gvnf1zwTSZO
         yRqJvkSXFzHblv8HanMN2qCueh7KW0d/pggBUjK2bRaOJvPc7Aj/Los949p1Qf6IXibb
         4FMsBIqiYod1z7PxL/8aUilmdT8U4Lj57DDuYxgvKa7gZJ+6oISrKphYW46Nzxm5ZxXf
         5dHPIbUsnTcGkjUh7t6nz0IzqyzC0aC0CfANwexff4iDtKpGIVpuEnnY/Oz92YpvXCaR
         wLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329080; x=1688921080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdaYmroOCsHHIxQ/Q7Hjtm846vg4ZSkKlVHycee4hiQ=;
        b=A+0mdWmagCOoRyLCpJILbdCCDtWufsT6f6cCIxuIx4mGihhQPH5ifO+UpGDYc57sk2
         6n6fuu7+49Ow+NiRPTCBLhJCvEFyGxD6vop4QQwaOQKxTDV1s06s08UJE55v5LKwgnNm
         IKAQl/HRJQJJjyWQl+Pai6Lk8FGbNhgIiBxn6TxNlfbME2UF4CJxJ1M1zwK0CiEs+9a9
         4HrgcFM70BpbEPbiFYVjmspnHNpZCezNWPej9958NDmKl6FUERx+tj3cLskvdLYH0iMi
         VMYQcxFRaglTZ8Q+GI2ET+W3XvhkfpuZqB9v9Y5BM8FpTqPYaalmbYYQEfS+/bJqpF02
         jEEg==
X-Gm-Message-State: AC+VfDyWN+qo8iEizZJtU2zM7/q/hamEXTRhfADQdz0vZsjpYoTSS14W
	t6x31RQbohu7zjSb657Zi10=
X-Google-Smtp-Source: ACHHUZ6l2kj86foQyBHiwjzuw87gKyWlXzVwE8Z1dgEyeSxEIoWlyLrFxaHRW1b7uUEAzA082BypKQ==
X-Received: by 2002:a17:902:8b81:b0:1b1:9272:55f3 with SMTP id ay1-20020a1709028b8100b001b1927255f3mr1198845plb.66.1686329079895;
        Fri, 09 Jun 2023 09:44:39 -0700 (PDT)
Received: from krava (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b00186a2274382sm3514760pls.76.2023.06.09.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:44:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 Jun 2023 09:44:36 -0700
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <ZINW9FqIoja76DRa@krava>
References: <20230608212613.424070-1-jolsa@kernel.org>
 <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home>
 <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
 <ZILhqvrjeFIPHauy@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZILhqvrjeFIPHauy@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 09, 2023 at 09:24:10AM +0100, Mark Rutland wrote:
> On Thu, Jun 08, 2023 at 04:55:40PM -0700, Andrii Nakryiko wrote:
> > On Thu, Jun 8, 2023 at 4:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > On Thu, 8 Jun 2023 15:43:03 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > On Thu, Jun 8, 2023 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
>  
> > There are BPF tools that allow user to specify regex/glob of kernel
> > functions to attach to. This regex/glob is checked against
> > available_filter_functions to check which functions are traceable. All
> > good. But then also it's important to have corresponding memory
> > addresses for selected functions (for many reasons, e.g., to have
> > non-ambiguous and fast attachment by address instead of by name, or
> > for some post-processing based on captured IP addresses, etc). And
> > that means that now we need to also parse /proc/kallsyms and
> > cross-join it with data fetched from available_filter_functions.
> > 
> > All this is unnecessary if avalable_filter_functions would just
> > provide function address in the first place. It's a huge
> > simplification. And saves memory and CPU.
> 
> Do you need the address of the function entry-point or the address of the
> patch-site within the function? Those can differ, and the rec->ip address won't
> necessarily equal the address in /proc/kallsyms, so the pointer in
> /proc/kallsyms won't (always) match the address we could print for the ftrace site.
> 
> On arm64, today we can have offsets of +0, +4, and +8, and within a single
> kernel image different functions can have different offsets. I suspect in
> future that we may have more potential offsets (e.g. due to changes for HW/SW
> CFI).

so we need that for kprobe_multi bpf link, which is based on fprobe,
and that uses ftrace_set_filter_ips to setup the ftrace_ops filter

and ftrace_set_filter_ips works fine with ip address being the address
of the patched instruction (it's matched in ftrace_location)

but right, I did not realize this.. it might cause confusion if people
don't know it's patch-side addresses..  not sure if there's easy way to
get real function address out of rec->ip, but it will also get more
complicated on x86 when IBT is enabled, will check

or we could just use patch-side addresses and reflect that in the file's
name like 'available_filter_functions_patch_addrs' .. it's already long
name ;-)

jirka

