Return-Path: <bpf+bounces-7090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6C77124C
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7217281A43
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651EC8E8;
	Sat,  5 Aug 2023 21:11:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3F10EA
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 21:11:26 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67DEE7
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:11:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so4369548a12.0
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691269883; x=1691874683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsPcd4Joaekobm3FxFolqiEknVIiTl4y99DsrAr6GfQ=;
        b=Ki5GuR2b3s1lVquQA7uO9F54m83m2kyDiVMQgPuy4j6n1vKgh9ja8y87aA1E0T4q8R
         DMpcuoD++1+wSLnVqUcxQmJp5kU4HmOBsOoalmikdNnznITvD/YsNC1aH+EJ7/8LN43x
         NLJUQnhjPGr6qQMogsx8tAobuoPKQq0SZ1+AJLDSS+wMi68zAtlwgD+OUfXGO3q2xuTJ
         cZ+z/UYt7soSwO0pdmHWSfX3P4Egq57W0dsNwGPKdkPzQLcv/S756VUw8cYdgs5TW5IY
         F5dhvRAMHsEpG7c2vktARnJWaAgR1WL+JwM6gRsPXyFbyhz65VPh2Cd5Rz6+lXOQ48Z0
         H0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691269883; x=1691874683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsPcd4Joaekobm3FxFolqiEknVIiTl4y99DsrAr6GfQ=;
        b=XeU9oloICsLzPuSeutjIlqgRC6ywwzo1J89RJiH6+KV0npxmJat8zcNpUBnMR98b7y
         /7iQGzKEsBHipbzRG0oMSLtT3BaJL0kXmF0MuL5xLJuUxG3ppRtAabJxWqtXBzApaCtw
         zXxm+uQYSFV8G3bHPPepbYL7wQFU5lhNEDDO5IcVqINOlHSUp+hh6jCeQI/v6ZovC6Uo
         m6ic7fkinjvAogA/W5jfA1iuxQPelomyR+AAFpK58gAWFoqarD/UoTRgyH/b1qe/Dm+z
         KBWQwpp73VtyDup9y9pBsA9oj/7E5/7lB2di+LUEXpDsLkAojJY2KYstlarcM2srmszw
         sVMw==
X-Gm-Message-State: AOJu0Yy5a6TCvDXobB5keqbgz0SuwOyzE7K/Gn/REn9DD6Ljdr4h612I
	kuro0IR9mXlEd55nAiIsIQ+0pmzfqTRwBw==
X-Google-Smtp-Source: AGHT+IHteffZsqgAiwQKRa8DofuxRxtHLYlt2tfD3IrRb0PbEvu1PAjny0IDe7kmuzCth7pld9dB3Q==
X-Received: by 2002:a17:906:5db4:b0:99c:ae00:f869 with SMTP id n20-20020a1709065db400b0099cae00f869mr3430143ejv.41.1691269883172;
        Sat, 05 Aug 2023 14:11:23 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id lh7-20020a170906f8c700b00977ca5de275sm3182365ejb.13.2023.08.05.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 14:11:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 5 Aug 2023 23:11:20 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv6 bpf-next 03/28] bpf: Add multi uprobe link
Message-ID: <ZM66+KHkfhNE79Kj@krava>
References: <20230803073420.1558613-1-jolsa@kernel.org>
 <20230803073420.1558613-4-jolsa@kernel.org>
 <8f678d1a-d2c2-c979-f37e-db0f4bf6e933@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f678d1a-d2c2-c979-f37e-db0f4bf6e933@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 02:55:29PM -0700, Yonghong Song wrote:

SNIP

> > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > +			   unsigned long entry_ip,
> > +			   struct pt_regs *regs)
> > +{
> > +	struct bpf_uprobe_multi_link *link = uprobe->link;
> > +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> > +		.entry_ip = entry_ip,
> > +	};
> > +	struct bpf_prog *prog = link->link.prog;
> > +	bool sleepable = prog->aux->sleepable;
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	int err = 0;
> > +
> > +	might_fault();
> 
> Could you explain what you try to protect here
> with might_fault()?
> 
> In my opinion, might_fault() is unnecessary here
> since the calling context is process context and
> there is no mmap_lock held, so might_fault()
> won't capture anything.
> 
> might_fault() is used in iter.c and trampoline.c
> since their calling context is more complex
> than here and might_fault() may actually capture
> issues.

hum, I followed bpf_prog_run_array_sleepable, which is called
the same way.. will check

> 
> > +
> > +	migrate_disable();
> > +
> > +	if (sleepable)
> > +		rcu_read_lock_trace();
> > +	else
> > +		rcu_read_lock();
> 
> Looking at trampoline.c and iter.c, typical
> usage is
> 	rcu_read_lock_trace()/rcu_read_lock()
> 	migrate_disable()
> 
> Your above sequenence could be correct too. But it
> is great if we can keep consistency here.

ok, will switch that

SNIP

> > +	link->cnt = cnt;
> > +	link->uprobes = uprobes;
> > +	link->path = path;
> > +
> > +	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > +		      &bpf_uprobe_multi_link_lops, prog);
> > +
> > +	err = bpf_link_prime(&link->link, &link_primer);
> > +	if (err)
> > +		goto error_free;
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> > +					     uprobes[i].offset,
> > +					     ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
> > +					     &uprobes[i].consumer);
> > +		if (err) {
> > +			bpf_uprobe_unregister(&path, uprobes, i);
> > +			bpf_link_cleanup(&link_primer);
> > +			kvfree(ref_ctr_offsets);
> 
> Is it possible we may miss some of below 'error_free' cleanups?
> In my opinion, we should replace
> 			kvfree(ref_ctr_offsets);
> 			return err;
> with
> 			goto error_free;
> 
> Could you double check?

the problem here is that bpf_link_cleanup calls link's dealloc callback,
so it get's released in bpf_uprobe_multi_link_dealloc.. which is missing
task release :-\

I think we could init the link only after we create all the uprobes,
and have single release function dealloc callback and error path in here

thanks,
jirka

> 
> > +			return err;
> > +		}
> > +	}
> > +
> > +	kvfree(ref_ctr_offsets);
> > +	return bpf_link_settle(&link_primer);
> > +
> > +error_free:
> > +	kvfree(ref_ctr_offsets);
> > +	kvfree(uprobes);
> > +	kfree(link);
> > +error_path_put:
> > +	path_put(&path);
> > +	return err;
> > +}
> > +#else /* !CONFIG_UPROBES */
> > +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif /* CONFIG_UPROBES */
> [...]

