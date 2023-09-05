Return-Path: <bpf+bounces-9234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73027920AC
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4867C280EC4
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90204ECE;
	Tue,  5 Sep 2023 07:19:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B55EBC
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 07:19:26 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE6CC2
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 00:19:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a5be3166a2so295062366b.1
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693898363; x=1694503163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmPZ6MwhGsjqW+PqQ60aIxMny+s/DXkbn11tQsT0+h0=;
        b=PLJvF0YU/uAW7FdLGQzGdpwAsBa0gtrqiB7KqlG01MCpg9dce8mobzA+yEQ+WlGakf
         tDOp3CLJProVXqedSLRxx7baFKl8A7S6jsYTbN+J5TMnDk6oq6qQAjfl0I8e82ygWky1
         4NEmOBMsEVbUPhXewU6kkCWGg1uLEgh2LZUcvyNCVrQ1FP43xj2oZoIQoqcVY7sgsjkJ
         0oXQSkmzYfYUuUiIdZyJlVNC649X697KmRZNR2i/ebbV1LhdSF/nqRGYcpRBfb3KMYBz
         SOpPjMWCYN1Nj0niF2qGaJhfRjJocdJUTvC4RmZ0eICqrVTFlZgvP88Lca5GeVCbxCIy
         BURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898363; x=1694503163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmPZ6MwhGsjqW+PqQ60aIxMny+s/DXkbn11tQsT0+h0=;
        b=c9PZhZcHUz0/eMwlIMKVcRcD6rGv6XqBCckAsus7tWvus6GsLHektLB9sf6HG8Amyw
         wuNdr8AZKNGnJS9LPSSmbCD3AEhDYvy/Lid7N9dqzJNUeWUQ4yUl7u56GMCyk9HHgkkH
         ZeA5ol//vl9X5p06L+xvkhwHC55uCb79eUZB7VZhAPdFUrEoxilNsULIaEzrVQNOOTu8
         4PvG5zj0J2EaOdYc9oroSR7gbbPWBYtkPwSnEbIDNnDFVMZfeysVVxS9CQbzCIY508Hn
         SGmohlQSZG0AM8bcsjbRj55Eqhjv3awCagyydNfcXl9Dg9UduXTvt6oH+0Dqj8XIZXHt
         CTAQ==
X-Gm-Message-State: AOJu0YxaWtKn5lAtdB3o467GNVMB3y1aIBefSFSYXTNeVtzb46vgdA4P
	5BAyVZSg04qCb13f0OnXUzKuL+sRAFT0YQ==
X-Google-Smtp-Source: AGHT+IF2hqM+oUg+h8dp2cRre9tgP8L5WJ7ltcWqDy4g879oEBnrwSh5ad02MM4ZnwsdT24juUlEuw==
X-Received: by 2002:a17:906:1daa:b0:9a6:5696:3879 with SMTP id u10-20020a1709061daa00b009a656963879mr3135377ejh.65.1693898363020;
        Tue, 05 Sep 2023 00:19:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id kb3-20020a1709070f8300b009930c80b87csm7326719ejc.142.2023.09.05.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:19:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Sep 2023 09:19:20 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 08/12] bpf: Count run stats in bpf_prog_run_array
Message-ID: <ZPbWeHpb0SPDPkLq@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-9-jolsa@kernel.org>
 <7adba3b2-29de-4959-b99a-d1ce3f26f31a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7adba3b2-29de-4959-b99a-d1ce3f26f31a@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 10:40:01AM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> > Count runtime stats for bf programs executed through bpf_prog_run_array
> > function. That covers kprobe, perf event and trace syscall probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 478fdc4794c9..732253eea675 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2715,10 +2715,11 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
> >  		   const void *ctx, bpf_prog_run_fn run_prog)
> >  {
> >  	const struct bpf_prog_array_item *item;
> > -	const struct bpf_prog *prog;
> > +	struct bpf_prog *prog;
> >  	struct bpf_run_ctx *old_run_ctx;
> >  	struct bpf_trace_run_ctx run_ctx;
> >  	u32 ret = 1;
> > +	u64 start;
> >  
> >  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
> >  
> > @@ -2732,7 +2733,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
> >  	item = &array->items[0];
> >  	while ((prog = READ_ONCE(item->prog))) {
> >  		run_ctx.bpf_cookie = item->bpf_cookie;
> > +		start = bpf_prog_start_time();
> >  		ret &= run_prog(prog, ctx);
> > +		bpf_prog_update_prog_stats(prog, start);
> >  		item++;
> >  	}
> 
> bpf_prog_run() has already accounted the running count and the consumed
> time for the prog, so I think both previous patch and this patch are not
> needed.

ugh right, I missed that.. thanks

jirka

> 
> >  	bpf_reset_run_ctx(old_run_ctx);
> 

