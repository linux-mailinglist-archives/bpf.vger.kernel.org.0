Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7B6F7151
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEDRmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEDRmY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 13:42:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5703184;
        Thu,  4 May 2023 10:42:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a5197f00e9so5776225ad.1;
        Thu, 04 May 2023 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683222138; x=1685814138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNxJTAZ9EL5DyV4TZNe9sWIgjQiMpe3voif3uF3Kb8s=;
        b=j0YC9s8cJTnrodP5ECk0vMrFo1TNNCOBRDETiPoe5V3Iw3sBEXWrr+2t8TX235YrAp
         EkfVAHTt8eXoJy8V8OFmlttmZZtSoCCK4qjWpjiwZCiCn7zOSSJlJkohLNGiWWgOz6P8
         k+zxou9B9u1SfeR6rQxVGGqnJ/mREXUhASBsMPv9f6lps6gxBxLIOT8zzG+87FZ2Sjge
         FRZLsomaSZWt/aOziZVwMvWZQWOrlwfDCVZcnoyBgTZNN7ZLzF946YrA6m/gQbnP9laF
         nVcFN/NEh16huBlgxc0lROt8bjJ0V8XcrOMLqkVxnRila1v9iIppiYinriFclCkek0kg
         x0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222138; x=1685814138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNxJTAZ9EL5DyV4TZNe9sWIgjQiMpe3voif3uF3Kb8s=;
        b=HgC7yfzB7JyJBO7+c2bavKieWGbbx6DzKJrukMzoUtzl2gontbH9ixfrkQprD369D9
         ItNz3Kg3yBr0Cxcj8/q6dOk2jxV/0kbQNnSiALJ7v1uySxQdteDunDW9yTltlNSJjHSJ
         TVFTrDn6UBCbUNd5hiP6QL8HmuDChMplxIJ+jz37BaPatFJJZrorjV6tfmn7LiKzlBOs
         GOJSWOlTZMDF1hmJXPkI28vsbd6OBnzQiYB0pc7bWXhTddHVi0VaJ7m5yHmaX2wTNEXx
         Ixtv8Uk5K0LIEZwRp92yZDvMThVO69uANCj4v/V3KB693XKOR9odcDG/FEhE4X2/7HqA
         dTSw==
X-Gm-Message-State: AC+VfDyCRSg25hYYTKP0/8KMj+SaxlcsarkB4TrEVgeZ2IBl++P8kF4I
        XV7dHAeLOQ8VffgrsEW2jXs=
X-Google-Smtp-Source: ACHHUZ6nuXnR8evkU736fKFCrEJMP9eUD+Rzrgin33+YiPGnovA4BO+FewTUW2UmbgEeJOsWnDQgSw==
X-Received: by 2002:a17:902:c389:b0:1a9:5e33:72db with SMTP id g9-20020a170902c38900b001a95e3372dbmr4338562plg.28.1683222138274;
        Thu, 04 May 2023 10:42:18 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:c043:6b84:c4e4:75dd])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902e9cb00b001aaf92130afsm7471835plk.116.2023.05.04.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:42:17 -0700 (PDT)
Date:   Thu, 04 May 2023 10:42:16 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, will@isovalent.com
Message-ID: <6453ee784285e_51c92085e@john.notmuch>
In-Reply-To: <877cto2fr2.fsf@cloudflare.com>
References: <20230502155159.305437-1-john.fastabend@gmail.com>
 <20230502155159.305437-5-john.fastabend@gmail.com>
 <877cto2fr2.fsf@cloudflare.com>
Subject: Re: [PATCH bpf v7 04/13] bpf: sockmap, improved check for empty queue
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Sitnicki wrote:
> On Tue, May 02, 2023 at 08:51 AM -07, John Fastabend wrote:
> > We noticed some rare sk_buffs were stepping past the queue when system was
> > under memory pressure. The general theory is to skip enqueueing
> > sk_buffs when its not necessary which is the normal case with a system
> > that is properly provisioned for the task, no memory pressure and enough
> > cpu assigned.
> >
> > But, if we can't allocate memory due to an ENOMEM error when enqueueing
> > the sk_buff into the sockmap receive queue we push it onto a delayed
> > workqueue to retry later. When a new sk_buff is received we then check
> > if that queue is empty. However, there is a problem with simply checking
> > the queue length. When a sk_buff is being processed from the ingress queue
> > but not yet on the sockmap msg receive queue its possible to also recv
> > a sk_buff through normal path. It will check the ingress queue which is
> > zero and then skip ahead of the pkt being processed.
> >
> > Previously we used sock lock from both contexts which made the problem
> > harder to hit, but not impossible.
> >
> > To fix instead of popping the skb from the queue entirely we peek the
> > skb from the queue and do the copy there. This ensures checks to the
> > queue length are non-zero while skb is being processed. Then finally
> > when the entire skb has been copied to user space queue or another
> > socket we pop it off the queue. This way the queue length check allows
> > bypassing the queue only after the list has been completely processed.
> >
> > To reproduce issue we run NGINX compliance test with sockmap running and
> > observe some flakes in our testing that we attributed to this issue.
> >
> > Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> > Tested-by: William Findlay <will@isovalent.com>
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---

[...]

> > @@ -677,8 +666,7 @@ static void sk_psock_backlog(struct work_struct *work)
> >  							  len, ingress);
> >  			if (ret <= 0) {
> >  				if (ret == -EAGAIN) {
> > -					sk_psock_skb_state(psock, state, skb,
> > -							   len, off);
> > +					sk_psock_skb_state(psock, state, len, off);
> >  
> >  					/* Delay slightly to prioritize any
> >  					 * other work that might be here.
> 
> I've been staring at this bit and I think it doesn't matter if we update
> psock->work_state when SK_PSOCK_TX_ENABLED has been cleared.
> 
> But what I think we shouldn't be doing here is scheduling
> sk_psock_backlog again if SK_PSOCK_TX_ENABLED got cleared by
> sk_psock_stop.

Yeah I agree we shouldn't be scheduling with TX_ENABLED cleared. Otherwise
while we cancle and sync the worker from the destroy path we could queue
up more work here.

Also spotted another case of this where its not wrapped in a check. I guess
we should fix it. Nice catch.

v8 it is I guess thanks.
