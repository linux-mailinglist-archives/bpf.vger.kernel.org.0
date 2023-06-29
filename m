Return-Path: <bpf+bounces-3733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35923742765
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFC1C209A1
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CD111BF;
	Thu, 29 Jun 2023 13:29:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36923B9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:29:21 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F5CA;
	Thu, 29 Jun 2023 06:29:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so804123a12.3;
        Thu, 29 Jun 2023 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688045358; x=1690637358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2itqLGizh3tF5cuip2yJLJb4xMID5GAfppBUpy2Xzpo=;
        b=bMM52s7jmj6HouVxnUc/dTGVxY7T+JPhz4uXSyXVwwAOyy72ZdU4c2q+yBqSgexNcq
         zVWiRldw0amYjiMVBj9Bv4h6AotTeYTqG5C+27wTd7Kax8hdyAw9aTrYUBSndvP0UYD/
         5fc0TQlZCsIdDqPy9WrTC9gT+fir0ibnPQ8NUbffDPc4m7GIFffxxbFuOThyazuaw5Cz
         7YK9W1epyhoiPNM3EsXtikeUJeRf6gE3zijDCxSojBgOwTgTnvZut+BIRCmeUKpuaXjd
         zMfijIeonY3SIzpOhMDDloIz3k7j3Jq/mLKnGZ5o8knEmIRA96RdWsB5h227uNQ4IKko
         oUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688045358; x=1690637358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2itqLGizh3tF5cuip2yJLJb4xMID5GAfppBUpy2Xzpo=;
        b=HHki9g1tVVD6AEzewEgypkNPWXpJznXrHIdPbpYkFPU6KrfWqpP+JBwgHjD/U+DTkF
         pVm6N7Rz3yjmYBIDi7QYctWRKxpyoHyL1fBAF4TJX58IyBPamTeF/iyiezTgNZ+OBLtP
         MU0IZ6QZPsiF2A/qt+8dXP4P43TjjstzOceChS7kgV/DfqwjxOq2ZTbJ1utO4OouZRWX
         /reWc1vA19fe25dTLE7K9yESRvsLD+ekE6OopqnIgYKKgsUl6vtcChmYkpqXJP2bJz/7
         exOWIRw1tHn3ChBWEzqiQwgy9nZMp1M24+WudkHK9Fo5EoaC2XsPsiGK2j3Qdt3Mv1bt
         yebA==
X-Gm-Message-State: AC+VfDwRuUL1eoXUSQmb7yigXetwbZGGpIUVmUlO8TIQ8lR1k+BFjx21
	JBCGoueY8lkvT6hCmDeoc3M=
X-Google-Smtp-Source: ACHHUZ5HlcPtG9BUj0FlQ6UH/5GwLq3zfBRGabGbZKmfXbNtBwYiMyoWyo19W1yVcBwjZ6JWFi12zQ==
X-Received: by 2002:aa7:db8d:0:b0:515:3103:631e with SMTP id u13-20020aa7db8d000000b005153103631emr24260014edt.25.1688045358323;
        Thu, 29 Jun 2023 06:29:18 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id b9-20020a05640202c900b0051de3e1323dsm405311edx.95.2023.06.29.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:29:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Jun 2023 15:29:14 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 00/11] bpf: Support ->fill_link_info for
 kprobe_multi and perf_event links
Message-ID: <ZJ2HKgg5jsLxiwX6@krava>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 11:53:18AM +0000, Yafang Shao wrote:
> This patchset enhances the usability of kprobe_multi program by introducing
> support for ->fill_link_info. This allows users to easily determine the
> probed functions associated with a kprobe_multi program. While
> `bpftool perf show` already provides information about functions probed by
> perf_event programs, supporting ->fill_link_info ensures consistent access
> to this information across all bpf links.
> 
> In addition, this patch extends support to generic perf events, which are
> currently not covered by `bpftool perf show`. While userspace is exposed to
> only the perf type and config, other attributes such as sample_period and
> sample_freq are disregarded.
> 
> To ensure accurate identification of probed functions, it is preferable to
> expose the address directly rather than relying solely on the symbol name.
> However, this implementation respects the kptr_restrict setting and avoids
> exposing the address if it is not permitted.
> 
> v5->v6:
> - From Andrii
>   - if ucount is too less, copy ucount items and return -E2BIG 
>   - zero out kmulti_link->cnt elements if it is not permitted by kptr
>   - avoid leaking information when ucount is greater than kmulti_link->cnt
>   - drop the flags, and add BPF_PERF_EVENT_[UK]RETPROBE 
> - From Quentin
>   - use jsonw_null instead when we have no module name
>   - add explanation on perf_type_name in the commit log
>   - avoid the unnecessary out lable 

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

