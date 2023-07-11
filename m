Return-Path: <bpf+bounces-4804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AC74F9F8
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292FE2816A0
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A41ED35;
	Tue, 11 Jul 2023 21:45:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62A1DDEE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 21:45:06 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856C10C7;
	Tue, 11 Jul 2023 14:45:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356fe4so34065335ad.2;
        Tue, 11 Jul 2023 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111904; x=1691703904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgtYI22NCwe9dx+Of1T/iE4i1/7dLMof/+iCsFkq1rs=;
        b=O7nGdWt5CZLCDIWmoNlNzyBNO2oiXqA+AoYOgty59JgmhaLp+WI7FZmqDrqOYrsPno
         wUkDh7CZ2gsrxvq+wDP8Tl9j3RPftB6TBpkpLiWUECFlJeV+qnKFDtrepyOk8ms28Jv2
         puqa8CMEbbdsL7sgzT2PYIX+m0KTnDiQ4Jk+Q7XaYnP6ST2p79x25yLIxyy43moyP/zr
         7rAgOAdwrSp1qs6zUj7vthz3IV42KdN8S/UNGyTt/QvQIhi2brWchIPL3cOc4aavKkcZ
         h005FkNhxVMx8XSZTlzhbXk0GZtM/LGFNUdeCOENv+G/J7V7nG1J3CLqqK47R0/UAoaj
         WSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111904; x=1691703904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgtYI22NCwe9dx+Of1T/iE4i1/7dLMof/+iCsFkq1rs=;
        b=dMwxAYWvtwVvS4VTJgVo0A2hex8Em+EC6RYEuhbUZ3fH33jRRIN9bS00mr6ctU7CEW
         4fzSqccYUhw+3VIeQIRYH2J9U/pGYfKX05lAJQsGFoW+JIci5uxVV5XujuwsMwRjkDdk
         pw0XDPFHPxIsPm7VwXPgAdTSAAUW777tMkpTxCRUsX8dvmpXmIhKe3cY5yl87BkDIyFP
         B71zaf/DD82N2bEmJ2RZtVYEpdOP0dLMMGlOitaJntBxb4Pnxp4tN2UQRsAuQ0e+UB2v
         I0/jyZ3Hqov61dz+vNpUdtmuwSI+kWfO0M3o6BHkFJcioS4lATshKbumUl9w7SSUfNCC
         cOKw==
X-Gm-Message-State: ABy/qLYDYbjiHPXt6ozXIaXlp+7L4eJ1+u52txIcbwak/rv5N6buWfn6
	XJpY9XuDKt3bZpxUzkgnnfs=
X-Google-Smtp-Source: APBJJlEDpmEKUfT11rMvOXkdzqveqwgVWu1FyToCJCqX4+ayDvDmicIYt53U0JjbmgG4PbVbvN3tZg==
X-Received: by 2002:a17:902:a60f:b0:1b9:cca6:551b with SMTP id u15-20020a170902a60f00b001b9cca6551bmr8700837plq.7.1689111904384;
        Tue, 11 Jul 2023 14:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001b9de2b905asm2397378plb.231.2023.07.11.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:45:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 11 Jul 2023 11:45:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
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
Message-ID: <ZK3NXp02NbnWe61q@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-13-tj@kernel.org>
 <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 11:21:48AM +0200, Andrea Righi wrote:
> On Mon, Jul 10, 2023 at 03:13:30PM -1000, Tejun Heo wrote:
> ...
> > +static void free_dsq_irq_workfn(struct irq_work *irq_work)
> > +{
> > +	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
> > +	struct scx_dispatch_q *dsq, *tmp_dsq;
> > +
> > +	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
> > +		kfree_rcu(dsq);
> 
> Maybe kfree_rcu(dsq, rcu)?
> 
> With 7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> we don't allow single argument kfree_rcu() anymore and I don't think we
> want to use kfree_rcu_mightsleep() here...

Oh, thanks for pointing that out. I'll update.

Thanks.

-- 
tejun

