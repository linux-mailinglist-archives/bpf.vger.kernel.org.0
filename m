Return-Path: <bpf+bounces-9235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FF7920AD
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA02809AE
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98949ECE;
	Tue,  5 Sep 2023 07:19:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F6EA38
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 07:19:35 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27248CC2
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 00:19:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so267620966b.1
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693898372; x=1694503172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doAnPxCCxhRnfgdHjQ/vtZMCh1tyDiK9UCVyMDVbeac=;
        b=S7gjCFHPODBB8b3Ztji9aJWouaez010Ya0g1edp5ZNfuqS75AqruKM2AmC0r68BDlO
         v5RoUdOCMqvfXCarvr0Ue3QLwLR8cKlEuOTfnGP809blnAVv9DS6xgWTCcGTnXopzmcY
         /rydV2b8/LQyu71RkqHJT+tBG06yxmTLxTWV48/0kbtvSp1Gs4Lvx0H09O8+AdGCSNtc
         lAQOgRjSH6+LR1Y+V2fz3sdA0kq5T2B8GTsAKTcXSJjgCtL9FgVJNlO2PGpjbiYwRWOW
         1lnXEDqvn2FwF0cS22Yvbt4ei1XW0dFaVVIC0lPlheE/ud6VRt4MnX7LqJvjIWo3sGeS
         iHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898372; x=1694503172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doAnPxCCxhRnfgdHjQ/vtZMCh1tyDiK9UCVyMDVbeac=;
        b=YtSDYBqn7dBU1crCNfuwE8kC4x7tKGshlJ3UDRtWh7/qEvBluIoDCxbWjcgEZjih0X
         xlo9C+DRRTX009QE1lnrI0CfPzF/5MiTKL7+oj7RcWN9QO6d/IGoqDwDky+Sv57yPaBX
         y3U5puQXQmdO8cSS9UbfjvktsLh8BDHD74IhnB4uEq5Z24OvcN2gGtWPpWGrgp9xyTsY
         41ouATZkdLHrN4D2clONSJ1DVEW7V8uJjO3XQxDhaV3gFZGbtl/i+J15LqHJF7r3PtJj
         EM5uM38Lh0zgx+URDctVQqnDICrGwQi9JC0LJViDYXtb3SmADuUqxxkFmk5MUFX++uTq
         HGeA==
X-Gm-Message-State: AOJu0Yw978x/GVhNeczGOvj0MuyOhmXRU1FPuefw/tkKS1Q0o9aaM2ZL
	KMPVuqwuf00r/ydScawiGSs=
X-Google-Smtp-Source: AGHT+IGjaDOMRKMS4JfRUkxBtGDItFhbfWhUYV1qr32F9UvisUKARCfB5IIg6bKozx7yDATKZQmGuw==
X-Received: by 2002:a17:906:189:b0:9a4:dd49:da3e with SMTP id 9-20020a170906018900b009a4dd49da3emr8894916ejb.68.1693898372654;
        Tue, 05 Sep 2023 00:19:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id la20-20020a170906ad9400b0099caf5bed64sm7208468ejb.57.2023.09.05.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:19:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Sep 2023 09:19:30 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 03/12] bpf: Count stats for kprobe_multi programs
Message-ID: <ZPbWggSZ3x0G+bx4@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-4-jolsa@kernel.org>
 <6fcc4045-7a73-8ce9-0926-af5f2088d4eb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fcc4045-7a73-8ce9-0926-af5f2088d4eb@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 02:15:49PM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> > Adding support to gather stats for kprobe_multi programs.
> >
> > We now count:
> >   - missed stats due to bpf_prog_active protection (always)
> >   - cnt/nsec of the bpf program execution (if kernel.bpf_stats_enabled=1)
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a7264b2c17ad..0a8685fc1eee 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2706,18 +2706,24 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >  		.link = link,
> >  		.entry_ip = entry_ip,
> >  	};
> > +	struct bpf_prog *prog = link->link.prog;
> >  	struct bpf_run_ctx *old_run_ctx;
> > +	u64 start;
> >  	int err;
> >  
> >  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > +		bpf_prog_inc_misses_counter(prog);
> >  		err = 0;
> >  		goto out;
> >  	}
> >  
> > +
> >  	migrate_disable();
> >  	rcu_read_lock();
> >  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > -	err = bpf_prog_run(link->link.prog, regs);
> > +	start = bpf_prog_start_time();
> > +	err = bpf_prog_run(prog, regs);
> > +	bpf_prog_update_prog_stats(prog, start);
> 
> Oops, I missed the bpf_prog_run() here. It seems that bpf_prog_run() has
> already done the accounting thing, so there is no need for double
> accounting.

right, same as the other change, thanks

jirka

> >  	bpf_reset_run_ctx(old_run_ctx);
> >  	rcu_read_unlock();
> >  	migrate_enable();
> 

