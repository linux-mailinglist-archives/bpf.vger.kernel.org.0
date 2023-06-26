Return-Path: <bpf+bounces-3478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A773E722
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31E91C2087C
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A2134BD;
	Mon, 26 Jun 2023 18:01:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F98125B1;
	Mon, 26 Jun 2023 18:01:52 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526B130;
	Mon, 26 Jun 2023 11:01:51 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-766fd5f9536so31860485a.3;
        Mon, 26 Jun 2023 11:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802510; x=1690394510;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvBYGplSZo80VAKDv1ZaHbBK2eJL9wJMY7wzGahPL1A=;
        b=fXMLcchsbD72bn+p3JeByBxugzx65P7nEVOilvuLjt9ejq2X/KXnlQci+B1py+lm81
         g5KIwSF/giJbBp6r9ul8Rdpktn3KVJKyOlLLiMmaGXj3oReihAWAPcHE9R8PMAX1UMoO
         KZyPxAhnOm+pEfXz7Ru6U8d47STYFpNgvLz3QNegWrHFhStqUh0C7QEUWBuWpv3SEb0e
         WgK1/aCzKYNJ4RhfavDdQ3RLQ8v8g9j0FqmzmPY54zBmMX/F3mUsDUQyf2YjE2A+0bzn
         x0QN6xWDU4b1xg2wtHuJR1zCvBUucyALV106s4Snm8vvdmi42G0StFMXsyTNlwgdSCVt
         VFWg==
X-Gm-Message-State: AC+VfDzfuEmgFpWp75Xyv9XilacZU24YhAAAGuxK0KZK4dM6UCR9ejHM
	faCfNB/ENsbTOF5eVVPSUoU=
X-Google-Smtp-Source: ACHHUZ4e4ADw4v9jj7Mhy7HkoaYVYjfr8RQ3Y03fwaUYJ27P4vKT2vFASqtCvYIJ0IbDSauE92jcdQ==
X-Received: by 2002:a05:620a:269b:b0:765:84bf:3cbc with SMTP id c27-20020a05620a269b00b0076584bf3cbcmr4496617qkp.36.1687802510408;
        Mon, 26 Jun 2023 11:01:50 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:58aa])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a13d200b007606a26988dsm1037101qkl.73.2023.06.26.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:01:49 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:01:47 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to
 bpf_mem_cache_free_rcu.
Message-ID: <20230626180147.GB6750@maniforge>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-14-alexei.starovoitov@gmail.com>
 <20230626154228.GA6798@maniforge>
 <CAADnVQK7rgcSevdyrG8t-rPqg-n8=Eic8K63q-q3SPtOR0VP2Q@mail.gmail.com>
 <20230626175538.GA6750@maniforge>
 <CAADnVQ+vBRZ3ySX-YOVQnfL-J4UV1pJymXxee-AqjGGAHtv2Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+vBRZ3ySX-YOVQnfL-J4UV1pJymXxee-AqjGGAHtv2Jg@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 10:59:40AM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 26, 2023 at 10:55 AM David Vernet <void@manifault.com> wrote:
> >
> > > > > +
> > > > > +     migrate_disable();
> > > > > +     bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
> > > > > +     migrate_enable();
> > > >
> > > > The fact that callers have to disable migration like this in order to
> > > > safely free the memory feels a bit leaky. Is there any reason we can't
> > > > move this into bpf_mem_{cache_}free_rcu()?
> > >
> > > migrate_disable/enable() are actually not necessary here.
> > > We can call bpf_mem_cache_free_rcu() directly from any kfunc.
> >
> > Could you please clarify why? Can't we migrate if the kfunc is called
> > from a sleepable struct_ops callback?
> 
> migration is disabled for all bpf progs including sleepable.

Fair enough :-) Then yep, let's remove these. Feel free to do so when
you send v2, and keep my Ack. Otherwise I'm happy to send a follow-on
patch after this series is merged.

