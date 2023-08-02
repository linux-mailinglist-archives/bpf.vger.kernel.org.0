Return-Path: <bpf+bounces-6685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553376C63D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C9281A57
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7ED2113;
	Wed,  2 Aug 2023 07:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C391FB3
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:15:25 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914141FCB
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 00:15:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so68328905e9.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690960522; x=1691565322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHt29U0ByY0ouBchPP0iuCkhjeXlhPj04+f7v0U23V4=;
        b=dyV+y2pmU7/jt6Wbs2JJjJMM1ie+GB2TyNsp4OXvpnkf2XIZYegokyL1Z3XopjHk3I
         rPmPQBuhipVFfkofpucvHYnyTat3dN3rqd7+zpi0/lpY7sEimJY9g6N+AjpWKeNxnBHQ
         1aaOgsjBohdiyEqPVkmx8xfw03OkojhviH5SCDARfcQOqxfcUR+8CmJES0Zz8ZjG8ObF
         pnmZz1952+RP5Z/CrhcjyV+1EvUmlEyc6d8kFmyhQN0TB7/buUY0iwXktT7q8nYaodye
         49xD6QH7Ftz90K8sPiyRBS3LGcxS9dMSJszRWQTjceEsfLnE2xTgC7BIgO5VyRuyrZop
         7C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960522; x=1691565322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHt29U0ByY0ouBchPP0iuCkhjeXlhPj04+f7v0U23V4=;
        b=PPn+bp+3c/9Cei24Jnj5w8gnpiLTn4Kh8k604g3j0httKAQjkDbF/gfkO5IPxUagU8
         Q9x9YGAxEvK0YYOXElfjhFJmLLD2HAtTkKNpUIHtyieoUp5ZGBXm0sNkvyzhdT6OztAN
         3L5eFHcilELVaptfpHcx71FWfG/rTqsbf+PHEPFG35DCRmCHc9QaFe8/al/yugWIIp4X
         nnyW8IzAm6Cwt01Wbd/moFpPhHJdYvn9w/Mk2Aat2UhQ47WWJ8MvHEpEp8E7w4yTU0nS
         aDIJmxaJ+ZeP/Pthkz/28YJf1J19KdH/8hxYfivhyboXLKsA+J/y625PQpRygTbxpHut
         tu2w==
X-Gm-Message-State: ABy/qLYcuXlvvEY12CVFgSK3WkX8jdH6RQ5mh54s7ClWcE4lv469p7Qa
	s7IcgG8sSItV2NUsGUHMcxA=
X-Google-Smtp-Source: APBJJlGzAVq3iHdI6eUfVYMPZAj9gN0kmSLkx3jrV7wjMSP8FwhugFL+Zn8oYqWrh8tq8fM19yMbVA==
X-Received: by 2002:a1c:f211:0:b0:3f4:d18f:b2fb with SMTP id s17-20020a1cf211000000b003f4d18fb2fbmr4252901wmc.8.1690960521623;
        Wed, 02 Aug 2023 00:15:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fe0a0e03fcsm908241wmk.12.2023.08.02.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:15:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Aug 2023 09:15:18 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
Message-ID: <ZMoChnLuNsKzp82w@krava>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-2-jolsa@kernel.org>
 <CALOAHbDdurfzh7jRfqWVVS5RFRT44fx3zjQRNN8B66HJDNogAQ@mail.gmail.com>
 <20f1cf2e-6145-000a-0344-4c03c7b54e28@linux.dev>
 <10d4b655-6232-efbd-9b5f-7d4637ef197d@linux.dev>
 <CAADnVQKmSbcYG75=jkhsvekaOkrz26+eO0gSrcbimCD_a-OBoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKmSbcYG75=jkhsvekaOkrz26+eO0gSrcbimCD_a-OBoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 01:43:53PM -0700, Alexei Starovoitov wrote:
> On Tue, Aug 1, 2023 at 1:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> > On 8/1/23 12:44 PM, Yonghong Song wrote:
> > >
> > >
> > > On 8/1/23 4:53 AM, Yafang Shao wrote:
> > >> On Tue, Aug 1, 2023 at 3:30 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >>>
> > >>> Adding support for bpf_get_func_ip helper for uprobe program to return
> > >>> probed address for both uprobe and return uprobe.
> > >>>
> > >>> We discussed this in [1] and agreed that uprobe can have special use
> > >>> of bpf_get_func_ip helper that differs from kprobe.
> > >>>
> > >>> The kprobe bpf_get_func_ip returns:
> > >>>    - address of the function if probe is attach on function entry
> > >>>      for both kprobe and return kprobe
> > >>>    - 0 if the probe is not attach on function entry
> > >>>
> > >>> The uprobe bpf_get_func_ip returns:
> > >>>    - address of the probe for both uprobe and return uprobe
> > >>>
> > >>> The reason for this semantic change is that kernel can't really tell
> > >>> if the probe user space address is function entry.
> > >>>
> > >>> The uprobe program is actually kprobe type program attached as uprobe.
> > >>> One of the consequences of this design is that uprobes do not have its
> > >>> own set of helpers, but share them with kprobes.
> > >>>
> > >>> As we need different functionality for bpf_get_func_ip helper for
> > >>> uprobe,
> > >>> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> > >>> detect that it's executed in uprobe context and call specific code.
> > >>>
> > >>> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable which
> > >>> is currently used only for executing bpf programs in uprobe.
> > >>
> > >> That is error-prone.  If we don't intend to rename
> > >> bpf_prog_run_array_sleepable() to bpf_prog_run_array_uprobe(), I think
> > >> we'd better introduce a new parameter 'bool is_uprobe' into it.
> > >
> > > Agree that renaming bpf_prog_run_array_sleepable() to
> > > bpf_prog_run_array_uprobe() probably better. This way, it is
> > > self-explainable for `run_ctx.is_uprobe = true`.
> > >
> > > If unlikely case in the future, another sleepable run prog array
> > > is needed. They can have their own bpf_prog_run_array_<..>
> > > and underlying bpf_prog_run_array_sleepable() can be factored out.
> >
> > Or if want to avoid unnecessary code churn, at least add
> > a comment in bpf_prog_run_array_sleepable() to explain
> > that why it is safe to do `run_ctx.is_uprobe = true;`.
> 
> I think renaming to _uprobe() is a good idea.
> I would prefer if we can remove the bool is_uprobe run-time check,
> but don't see a way to do it cleanly.

ok, I'll rename it

thanks,
jirka

