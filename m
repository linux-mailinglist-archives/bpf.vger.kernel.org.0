Return-Path: <bpf+bounces-6193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067C766C0C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 13:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E9280E69
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7312B78;
	Fri, 28 Jul 2023 11:48:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B3C8C9;
	Fri, 28 Jul 2023 11:48:40 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9D3C01;
	Fri, 28 Jul 2023 04:48:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so3482421e87.3;
        Fri, 28 Jul 2023 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690544917; x=1691149717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Doqj4gDdDMax3I9KTmVKAGl5S35O9n40i+nLylwwl1c=;
        b=cPqqNdnWtUGeVSveuUj0OylqzRXbgHchOpLRZQjmwCqJxEtxUQgfsBjntoSum6Itsl
         WzC1hHA68nOzYb92GhprV5hgxwJv6BsDlW0G7p+wQvBnKys5LVJhqddstNKm68wb3JMt
         44lptR+NW9msvWZsEMgSmE4hsjAU4soqee5WIF4f8kSc3xt8lrt6Pz2lJ0Y1rSp8+L5N
         HmrZmjqap/lFMZk2rxJ5N5nBxHMYhgmqg90wfe3FcDmLkPnklW+JkJ+A+FjA9rS6v9CE
         P91MXIoo3A9ZnJ4FvLtWpDkb13dq7Viod8mDoakUvY8bET26+vMipdKXxBCZjAGBZvCW
         Alig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544917; x=1691149717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Doqj4gDdDMax3I9KTmVKAGl5S35O9n40i+nLylwwl1c=;
        b=HaDR+yml06hGdzkwKm5sGXtLeDLqxso5Kaas5GiYraQwMYdUF/K9lqY4eB5tysbkAd
         6Z8odNzWH73HXkM9JUEBD8BPNl/SYHCVM3/QuId1Chb7Qx50ZZan0pgeaLKciBhGDOhI
         WDOPXuFDETc+8v7o15Zu72kskaXyUSSo7wi4aBFg3jwpiRhB3HHE3NLTdjXBf/shiNd/
         2K8Y6xtvhr3lCTi/1iNBazfUd571FuzoNsvaJ4hs+tCIbTtyjhBuwtQZC9HVjRxzcFHb
         MDBLmblhZVwNRW8xqI7LWL48CVx0Nfg1qhPE6/vug0Mwm/Ny3eRhJXKR/vrAPRX9BZxI
         OBWg==
X-Gm-Message-State: ABy/qLZQvjekAqiQAjq0MYgmSftoqYHP5wiMwrensU+Y6X6Iius9iqra
	hicYzjMrIKAJ8cJ2Pb73we8=
X-Google-Smtp-Source: APBJJlHmwo1+wc+ndPbxfHnXuEvhkgmwy6RaeECvnJmDu6kCaplIc1/jDHROO62mtl1zhywwtT22Vg==
X-Received: by 2002:a05:6512:1153:b0:4f8:5d2f:902a with SMTP id m19-20020a056512115300b004f85d2f902amr1893088lfg.60.1690544917140;
        Fri, 28 Jul 2023 04:48:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0051d9dbf5edfsm1714330edx.55.2023.07.28.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 04:48:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Jul 2023 13:48:34 +0200
To: tglozar@redhat.com
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
Message-ID: <ZMOrEi3cNWGXp9ZS@krava>
References: <20230728064411.305576-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728064411.305576-1-tglozar@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 08:44:11AM +0200, tglozar@redhat.com wrote:
> From: Tomas Glozar <tglozar@redhat.com>
> 
> Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
> patchset notes for details).
> 
> This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
> BUG (sleeping function called from invalid context) on RT kernels.
> 
> preempt_disable was introduced together with lock_sk and rcu_read_lock
> in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
> in parallel"), probably to match disabled migration of BPF programs, and
> is no longer necessary.
> 
> Remove preempt_disable to fix BUG in sock_map_update_common on RT.

FYI, I'm not sure it's related but I started to see following splat recently:

[  189.360689][  T658] =============================
[  189.361149][  T658] [ BUG: Invalid wait context ]
[  189.361588][  T658] 6.5.0-rc2+ #589 Tainted: G           OE     
[  189.362174][  T658] -----------------------------
[  189.362660][  T658] test_progs/658 is trying to lock:
[  189.363176][  T658] ffff8881702652b8 (&psock->link_lock){....}-{3:3}, at: sock_map_update_common+0x1c4/0x340
[  189.364152][  T658] other info that might help us debug this:
[  189.364689][  T658] context-{5:5}
[  189.365021][  T658] 3 locks held by test_progs/658:
[  189.365508][  T658]  #0: ffff888177611a80 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x82/0x260
[  189.366503][  T658]  #1: ffffffff835a3180 (rcu_read_lock){....}-{1:3}, at: sock_map_update_elem_sys+0x78/0x260
[  189.367470][  T658]  #2: ffff88816cf19240 (&stab->lock){+...}-{2:2}, at: sock_map_update_common+0x12a/0x340
[  189.368420][  T658] stack backtrace:
[  189.368806][  T658] CPU: 0 PID: 658 Comm: test_progs Tainted: G           OE      6.5.0-rc2+ #589 98af30b3c42d747b51da05f1d0e4899e394be6c9
[  189.369889][  T658] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  189.370736][  T658] Call Trace:
[  189.371063][  T658]  <TASK>
[  189.371365][  T658]  dump_stack_lvl+0xb2/0x120
[  189.371798][  T658]  __lock_acquire+0x9ad/0x2470
[  189.372243][  T658]  ? lock_acquire+0x104/0x350
[  189.372680][  T658]  lock_acquire+0x104/0x350
[  189.373104][  T658]  ? sock_map_update_common+0x1c4/0x340
[  189.373615][  T658]  ? find_held_lock+0x32/0x90
[  189.374074][  T658]  ? sock_map_update_common+0x12a/0x340
[  189.374587][  T658]  _raw_spin_lock_bh+0x38/0x80
[  189.375060][  T658]  ? sock_map_update_common+0x1c4/0x340
[  189.375571][  T658]  sock_map_update_common+0x1c4/0x340
[  189.376118][  T658]  sock_map_update_elem_sys+0x184/0x260
[  189.376704][  T658]  __sys_bpf+0x181f/0x2840
[  189.377147][  T658]  __x64_sys_bpf+0x1a/0x30
[  189.377556][  T658]  do_syscall_64+0x38/0x90
[  189.377980][  T658]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  189.378473][  T658] RIP: 0033:0x7fe52f47ab5d

the patch did not help with that

jirka

> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  net/core/sock_map.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 19538d628714..08ab108206bf 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -115,7 +115,6 @@ static void sock_map_sk_acquire(struct sock *sk)
>  	__acquires(&sk->sk_lock.slock)
>  {
>  	lock_sock(sk);
> -	preempt_disable();
>  	rcu_read_lock();
>  }
>  
> @@ -123,7 +122,6 @@ static void sock_map_sk_release(struct sock *sk)
>  	__releases(&sk->sk_lock.slock)
>  {
>  	rcu_read_unlock();
> -	preempt_enable();
>  	release_sock(sk);
>  }
>  
> -- 
> 2.39.3
> 
> 

