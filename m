Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3E1DC8EC
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgEUImj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 May 2020 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgEUImj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 04:42:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2BC061A0F
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 01:42:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j21so7873900ejy.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khKa3VospsGF/zZX2jqzC6B0pFc8OmygKNEDOR+IIDs=;
        b=Wm8lXXMowUblSGIk6/pirZc6GcIOfnLyEBXmgX4cZtvkuC21pO/JvKHEK/tsjsBynd
         qMtn41/nHj55SyL4CM4D0LMOMrOCZ4dHNppjKdKjOw1VOMHAjdaKI06vUEGJlEJ85Oj+
         XVuH8U2sNqYhVGlRE/RsuXUIaB9auvZ1dey7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khKa3VospsGF/zZX2jqzC6B0pFc8OmygKNEDOR+IIDs=;
        b=d26rqKjOzq239RzbQHWBf9wwLeYGqyLc7zu1EJF5xDpdO0aCifilr6ahxsaVm9+sPC
         v3aQwuTED24Hg+6G3cF9YJW+vDAJP8GEVhWA5/vWGJcLMY7zbE3CSn+PJ2wXxJjXW7d9
         gcRQZgCEPf5LZxDo9Rhler3ruff+N6L2tl7ZqBlkZMn30nFeaX8YqYDPcdvqzZf0o6zw
         29zXDj70S+8bqOXcKnbskl1kbSMmnNqEutvg22FYuVH2PG2cAsgAoceOlpZAw6xE5566
         G/UFgW4hQ53+QNbCg1U4KjMmlfx7jlUNX2XxjC1yI2xD6uIn29VCZAHUD8OgftH1mjpc
         /6Tw==
X-Gm-Message-State: AOAM532sgnfy1EDn4ZzbGCXY2l+Z9gAftH08qWJ7FAULiH+L/f9Bwfm/
        FpkLAMDqigunxI08WTpD99u/8A==
X-Google-Smtp-Source: ABdhPJx+XOrTFqKgizJY4KIkfc8KjvyzF63/6kJQz1+A7w5KHL1aNfOwXBebe+U2tody6dumUg2S4w==
X-Received: by 2002:a17:906:fa84:: with SMTP id lt4mr2681695ejb.318.1590050557722;
        Thu, 21 May 2020 01:42:37 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id nj6sm4149437ejb.99.2020.05.21.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 01:42:37 -0700 (PDT)
Date:   Thu, 21 May 2020 10:42:14 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Petar Penkov <ppenkov@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf] flow_dissector: Drop BPF flow dissector prog ref on
 netns cleanup
Message-ID: <20200521104214.6a1a4f9c@toad>
In-Reply-To: <20200520174000.GA49942@google.com>
References: <20200520172258.551075-1-jakub@cloudflare.com>
        <20200520174000.GA49942@google.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 May 2020 10:40:00 -0700
sdf@google.com wrote:

> > +static void __net_exit flow_dissector_pernet_pre_exit(struct net *net)
> > +{
> > +	struct bpf_prog *attached;
> > +
> > +	/* We don't lock the update-side because there are no
> > +	 * references left to this netns when we get called. Hence
> > +	 * there can be no attach/detach in progress.
> > +	 */
> > +	rcu_read_lock();
> > +	attached = rcu_dereference(net->flow_dissector_prog);
> > +	if (attached) {
> > +		RCU_INIT_POINTER(net->flow_dissector_prog, NULL);
> > +		bpf_prog_put(attached);
> > +	}
> > +	rcu_read_unlock();
> > +}  
> I wonder, should we instead refactor existing
> skb_flow_dissector_bpf_prog_detach to accept netns (instead of attr)
> can call that here? Instead of reimplementing it (I don't think we
> care about mutex lock/unlock efficiency here?). Thoughts?

I wanted to be nice to container-heavy workloads where network
namespaces get torn down frequently and in parallel and avoid
locking a global mutex. OTOH we already do it today, for instance in
devlink pre_exit callback.

In our case I think there is a way to have the cake and it eat too:

https://lore.kernel.org/bpf/20200521083435.560256-1-jakub@cloudflare.com/

Thanks for reviewing it,
-jkbs
