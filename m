Return-Path: <bpf+bounces-4749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69B74EA36
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829A28123C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64981775F;
	Tue, 11 Jul 2023 09:21:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A217FE0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:21:54 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E01FEC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:21:52 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1DF53F737
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689067310;
	bh=OJ/UfvjsgxXJVj9cI8O8ORaFeewJGYP94m+QX22LbOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=BbEE/AZBh6K1akTHp9yqgV5tCvgyzQJZknWoOu2u+FuGPIXk5BYixNjpiqfeSURO9
	 iRXuPinIWZBcC21EGGpdYEnUV9K2ZfvHSUjlThK2qM0we9zh6CtAeWKWjkMsirTB5b
	 hFikvpZJAISs9uj8/hSdfHYnm5Tbqv192K5MrGZzsC4DJ2ppdkN2h3qDjxCNvPTevM
	 E1q5HUtOAZtCKkfw+Dr1CrXpaIoT9UrJ2XIZ94EXIC+SmMwEs6Epq0j++NVP2W0xsI
	 o9L3pwQzvwt+fi9WAjgMQiHx8mBBVgDmSgtC3qZLm65cvb+OzQOyuYbM2BBc5P+y0T
	 O3+P3PjzPVh7A==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97542592eb9so318955466b.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067309; x=1691659309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ/UfvjsgxXJVj9cI8O8ORaFeewJGYP94m+QX22LbOU=;
        b=jsqX4sYh01mejdKsqrhYCDsLS52fQdLxxks9o7tWE7FoXEDals2LS6+GrIARl+rtha
         ABx882miHOpCiHBOYeNEAwT9EIVZY0tqs8Wm6itpEqtPOGSPz9lOPHTZLww9AhJi5uQv
         AtmvqWPKccGuop5Rc3f/y6w8iRS2oyog3F0Tn9f6GEEfLlxZfjQRwCd1w7sM6Kkjf0+l
         Fz5NU3sQcdGASwTTRTLXKeBFlYM3SGvVkYApONy+wtyupJytVpHedIJh9Dtqud5ugpTr
         dGsDKjaYbFAjcAcA0EWaEx1Ipu/TtjFTIB0UWLZjSsJDxMK8WTppr3dHO5a2VGN+C9DL
         QS2w==
X-Gm-Message-State: ABy/qLYFjm25ihEzu6333fpelLLFrnHe4SpRa0h2oJHXRJZfpv4loytb
	QW8H/hOTbBT+A5uxRb/W5TpPBrmdbrf+W1m7sy8W/JiOlLcIt61JV6Cg/f+iXYqlUf+/z5TG/LW
	miFkyrRXBI+4nt615qzuz/ixH6mSw+w==
X-Received: by 2002:a17:906:914c:b0:992:13c7:563 with SMTP id y12-20020a170906914c00b0099213c70563mr16737353ejw.75.1689067309612;
        Tue, 11 Jul 2023 02:21:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpMr0HuT9jbNM4jFYWwm/n67RIaIchwui/AhY3jPzD6rrXDz3TR9tPvLS84M605b1mpWVltA==
X-Received: by 2002:a17:906:914c:b0:992:13c7:563 with SMTP id y12-20020a170906914c00b0099213c70563mr16737307ejw.75.1689067309194;
        Tue, 11 Jul 2023 02:21:49 -0700 (PDT)
Received: from localhost (host-95-234-206-203.retail.telecomitalia.it. [95.234.206.203])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b0098df7d0e096sm907161eje.54.2023.07.11.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:21:48 -0700 (PDT)
Date: Tue, 11 Jul 2023 11:21:48 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/34] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711011412.100319-13-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 03:13:30PM -1000, Tejun Heo wrote:
...
> +static void free_dsq_irq_workfn(struct irq_work *irq_work)
> +{
> +	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
> +	struct scx_dispatch_q *dsq, *tmp_dsq;
> +
> +	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
> +		kfree_rcu(dsq);

Maybe kfree_rcu(dsq, rcu)?

With 7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
we don't allow single argument kfree_rcu() anymore and I don't think we
want to use kfree_rcu_mightsleep() here...

-Andrea

