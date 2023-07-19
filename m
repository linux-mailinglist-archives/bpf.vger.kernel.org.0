Return-Path: <bpf+bounces-5382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B893175A07F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F23281A45
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC422EF5;
	Wed, 19 Jul 2023 21:21:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348C1BB20
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 21:21:28 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E01FC0
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 14:21:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9923833737eso20859866b.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689801685; x=1692393685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGumdjtQYncBwkP/Vpaklgl9kiG4V+5Kz+jGQzqSWEY=;
        b=ahae/T0sm4TzD1uy66wETIEQvN2jxrji7NkiA9PVGOF6tILs4wPD4C+SXXuEV01Sr1
         mUtjWyVNujtRmZKx+rah6ftIKRFFF91H3yQsgcCJoA7xaFDAlf9j4ZzaIEH8zjrUBjUn
         lHuzm7A44PgrN/vFYJONtNumvaHudboxbRfV7csoIGbqJycuOb7UOijWWOFKS0u9cpQK
         b50dD8B2EADdx96jJ12wODJUxpOtKjrofc0H1xQD1EpxIRr9T6HSauvsRG+UhMf0loHk
         rP2qpDzPTtNQccyeb6n/J/VQZken82RXbchdMv8P+0KybvB5SjHezF7sMwvrB4y5344L
         +4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801685; x=1692393685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGumdjtQYncBwkP/Vpaklgl9kiG4V+5Kz+jGQzqSWEY=;
        b=gOZOwiWWO7j1ELGsoGQ0b9dTM27wG3Qktzs50+ZuWIBvnqUxgExbPyE9EdH0CIPCDt
         TbNaOcYaZN7Wx3g10TG5Hm9DEVRqNp9VuJiWkqSWKjFyC9HdgjAPNIB4vrZ1rEqLsRq5
         Z27r8eeX7R42VDzKxuXiT1CmzNuyS+mpyBC1Q5yk43ab9QSuK4H5M3Y7CBjrx2lLxR3q
         OvUk7jenw+9xC9uUhi/UAzMnYJD9/0QrcAc/5JDPn4q6kgfJYjkGDNVXpJgFgChrZOnN
         4msT/FDU29JytwsChgU4IhubfFaE5s5ucE6OBaNz5He2OzRKaB5VWpntKaIbBcuO4LX3
         IjOg==
X-Gm-Message-State: ABy/qLaioBSS27tSlUoQ2pYTYbwUtI6Htf0yrjzoPBOzJwcxaWnGlc6w
	0RXiXuXTnRwBnuXdLcFT7+c=
X-Google-Smtp-Source: APBJJlFITiiYQE3CgiEIGzYdVnMzAEkhkQAaYRGlUjDE4gcaHm/EQWm9XLAX7VVujBjhOieS14xk1Q==
X-Received: by 2002:a17:906:105e:b0:992:7329:fe4f with SMTP id j30-20020a170906105e00b009927329fe4fmr3460590ejj.73.1689801685273;
        Wed, 19 Jul 2023 14:21:25 -0700 (PDT)
Received: from krava ([83.240.61.31])
        by smtp.gmail.com with ESMTPSA id lo15-20020a170906fa0f00b009927d4d7a6dsm2804223ejb.192.2023.07.19.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:21:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Jul 2023 23:21:22 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 1/2] bpf: Disable preemption in bpf_perf_event_output
Message-ID: <ZLhT0t+8LPplOo3Y@krava>
References: <20230717111742.183926-1-jolsa@kernel.org>
 <20230717111742.183926-2-jolsa@kernel.org>
 <CAADnVQJ=h3yg0u6qEOBV+XmAWOVg7W7rsW05dK_WuYBUnZZ7zg@mail.gmail.com>
 <ZLfuZuBiexGqRSfl@krava>
 <CAADnVQKvkGwpa46v80L4YFfJR-9CjYcUhhS84dGJqToSjbUipQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKvkGwpa46v80L4YFfJR-9CjYcUhhS84dGJqToSjbUipQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 11:45:26AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 19, 2023 at 7:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > now task-1 and task-2 share same bpf_trace_nest_level value and same
> > 'struct perf_sample_data' buffer on top of &sds->sds[1]
> >
> > I did not figure out yet the actual exact scenario/cause of the crash yet,
> > I suspect one of the tasks copies data over some boundary, but all the
> > ideas I had so far did not match the instructions from the crash
> >
> > anyway I thought that having 2 tasks sharing the same perf_sample_data
> > is bad enough to send the patch
> 
> It makes sense now. We forgot to update this part during
> transition from preempt_disable to migrate_disable.
> 
> But do you have PREEMPT_RCU in your kernel?

yes, I have that enabled and it's also enabled in the kernel
that originally hit this

> If not then the above race shouldn't be possible.
> Worth fixing anyway, of course.
> Can you repro with a crafted test?
> Multiple uprobes doing bpf_perf_event_output should be enough, right?
> For kprobes we're "lucky" due to bpf_prog_active.

right, I can reproduce it just with uprobe

I realized the changes are on top of bpf-next/master.. I'll rebase it
on top of bpf/master and send without RFC tag

thanks,
jirka

