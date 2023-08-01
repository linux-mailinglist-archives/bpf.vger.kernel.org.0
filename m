Return-Path: <bpf+bounces-6519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1B76A7B1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 05:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AA28187F
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC691FCF;
	Tue,  1 Aug 2023 03:59:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055407E;
	Tue,  1 Aug 2023 03:59:00 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D299173F;
	Mon, 31 Jul 2023 20:58:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f0d66652so4963006b3a.2;
        Mon, 31 Jul 2023 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690862335; x=1691467135;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am6kUc1gFEEL40tXojHcI3O9SLUldvAEmwslcqO3ZMY=;
        b=RxgbSzYibpT3RWg1jhG3KETydqYw/5JtWpI4tu1YKbB2Kp0I3liS7rF4kEbelG2LiY
         NwyBQOioD2j0VAcRYep61Jtblhp1WpP+r+A8hbJgWKnQZ7CfzpQ/KPcugFIb79+SsxXq
         tBfzFBO5zJuva4FTVNFjO7Pn4AY1Zp39msFIDm2hdTi1u6YOPjZIrduytsOQdIThOLHz
         EsoZyK7xE7Ve5ENs7XKAn3ci8pobH3lp40257pkiwHWbwCyjMWnuKkM01dWGFqEkXNnm
         1+bfLJzgk5K1a5QLeBs27GO1u9NEM1MPsO7U6m0p9IdZ6rWgAuDF19sDh48WhR8Gxlcb
         jAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690862335; x=1691467135;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Am6kUc1gFEEL40tXojHcI3O9SLUldvAEmwslcqO3ZMY=;
        b=bYsxS99kU04bWQrH6BFFEQfplXbppf1rN2fqch0grvZnCn6Qs4lcDBAW/jKyojuqUr
         Q0IEymJTy2oxfLWnDD23GpGJezelZDg7cX9uo4TKswxIS0mlR03ysW/Fsgf4KB25FEJO
         pGTJiJ42mX9zQOwd0GDcA+ryVK58RIbf7wOuekwGwVJgDK45SpXKikmrfueRu3dprGgy
         WISEnU/tmncaRJZtqyZqmaYZUxvXqjFdTdEZBLDXM19JKLeyUIm2lSYrdtV9fsuFDrat
         vEjz1zXjf6H3ZUuVieo0MyRl5GtgE8MUv9HNnIHcB315qZA2/SOodwCQor8h7oA8CuVE
         h5Vg==
X-Gm-Message-State: ABy/qLZYumibl41S1Dpks4iKb/Vz7TnHgbt1qmgxw+UxZ6Nf2XRBkfe2
	NFW0KVHh8/l+kwufu1NVMXQ=
X-Google-Smtp-Source: APBJJlGyJou8AYk5Y33j8CcQLh9C2/sy8vLy8kISy+DYape3NAmn0QQw2hLBApQlEOtkOSz0fVyzHg==
X-Received: by 2002:a05:6a20:9150:b0:138:64d4:b040 with SMTP id x16-20020a056a20915000b0013864d4b040mr14767219pzc.54.1690862335303;
        Mon, 31 Jul 2023 20:58:55 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79255000000b00686bb3acfc2sm8299822pfp.181.2023.07.31.20.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 20:58:54 -0700 (PDT)
Date: Mon, 31 Jul 2023 20:58:53 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 tglozar@redhat.com
Cc: linux-kernel@vger.kernel.org, 
 john.fastabend@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <64c882fd8c200_a427920843@john.notmuch>
In-Reply-To: <87ila0fn01.fsf@cloudflare.com>
References: <20230728064411.305576-1-tglozar@redhat.com>
 <87ila0fn01.fsf@cloudflare.com>
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

Jakub Sitnicki wrote:
> 
> On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
> > From: Tomas Glozar <tglozar@redhat.com>
> >
> > Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> > allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> > GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
> > patchset notes for details).
> >
> > This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
> > BUG (sleeping function called from invalid context) on RT kernels.
> >
> > preempt_disable was introduced together with lock_sk and rcu_read_lock
> > in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
> > in parallel"), probably to match disabled migration of BPF programs, and
> > is no longer necessary.
> >
> > Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> >
> > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > ---
> 
> We disable softirq and hold a spin lock when modifying the map/hash in
> sock_{map,hash}_update_common so this LGTM:
> 

Agree.

> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

> 
> You might want some extra tags:
> 
> Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
> Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and update in parallel")



