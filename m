Return-Path: <bpf+bounces-6102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFE765D0C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B91C216F7
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17091CA04;
	Thu, 27 Jul 2023 20:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CF17AC1;
	Thu, 27 Jul 2023 20:15:26 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337C1FDD;
	Thu, 27 Jul 2023 13:15:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b9920362so1089764b3a.1;
        Thu, 27 Jul 2023 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488924; x=1691093724;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pjZ51xtViHPu61r/EFWrYe+qxWhroS6JQ+9gaxVDaQ=;
        b=AhyHSKUIkkgbZvtQQcyOKRC4C+sGBBU1rnW7UKRYJelhzH7/ZrA6+1Xg4/vOjR9OBb
         2LiXllBWDr3LkIBs0B/HpC95oZnJRCD0J4e6Qd/+w+xbPyfsCkd+ypfy8zlEEQg2Cs2l
         1bNXUidT+UahwU+1TAhT92SRQd4PrYR4jj1FwXZuZrdtDG/PyKSc/2Cj5pi/joFqabur
         JkmKOL1V/ewlylT3LCRSl78qgYZTBnWSXDg0te4dPPC4jPB3EFA+GB1EhGkQOlrFtEFQ
         b4MraEAS4OuOvFpd4YQIPbgaCFLUB+9vO60R9LnsWln7xCCnmoiYLosUxYKJ4hpTpGB3
         IMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488924; x=1691093724;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pjZ51xtViHPu61r/EFWrYe+qxWhroS6JQ+9gaxVDaQ=;
        b=gtaaOTcsrMrErlKyvsUhYNJ6UxEkH2T7pnO/ageJcMbL2aF+Ewt0k9LbF6STUwLvji
         SJiiGQtcDP81BtECOBlICJaP9dBa7Wkd76ztOkExyx7pM1Kosu2GyGdM+weeySeQG5Qc
         bank9xEjwwnEUnqCp0H4pgJzDbxhFQpk2ETt1X/xI6XhdQzp88xn7IJdNRmFro7npkfg
         4UDeETbg73Uuizjg0T5ymiXrtCKIJh6XgIhWTn9TWWwDtWhA70jTXXKWlru0uaeOJczq
         aKCwFmB2hZpcCM+qBVeqa0+VSXARwU6y4N1s44GzBjc/UothsnwfYy0b8QCTFFM8TuRM
         ohqQ==
X-Gm-Message-State: ABy/qLYz+eRBc5J7pvbmy2hRhOhWNdPbI/cBBqARlDTWSJWYNepniGyX
	KXUMwWw3yI0oq56EwXtK7aE=
X-Google-Smtp-Source: APBJJlE/vCxhHaS86mEOqx3kFx6vMxKfngxzPSkTcBkc7tZIAXfeUFlJDQsMA7TZxE9/hIrOlKW7eg==
X-Received: by 2002:a05:6a20:7351:b0:133:656e:fe1e with SMTP id v17-20020a056a20735100b00133656efe1emr128808pzc.47.1690488924247;
        Thu, 27 Jul 2023 13:15:24 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:705d:54ca:a48d:47da])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b0063afb08afeesm1862257pfa.67.2023.07.27.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:15:23 -0700 (PDT)
Date: Thu, 27 Jul 2023 13:15:22 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: tglozar@redhat.com, 
 linux-kernel@vger.kernel.org
Cc: john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Tomas Glozar <tglozar@redhat.com>
Message-ID: <64c2d05a894be_831d20896@john.notmuch>
In-Reply-To: <20230726085003.261112-1-tglozar@redhat.com>
References: <20230726085003.261112-1-tglozar@redhat.com>
Subject: RE: [PATCH RFC net] bpf: sockmap: Remove preempt_disable in
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

tglozar@ wrote:
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
> in parallel") with no comment on why it is necessary.
> 
> Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  net/core/sock_map.c | 2 --
>  1 file changed, 2 deletions(-)

Hi Thomas,

I looked at this and don't see the need for the preempt_disable there
at the moment. I believe it was there simply to match the BPF caller
case where it was preempt_disable at the time and now is migrate
disable. From the BPF side we don't want the migrate, but from the
syscall interface it should be OK.

Can you submit without RFC tag I think this should be OK.

Thanks,
John

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
> 
> base-commit: 22117b3ae6e37d07225653d9ae5ae86b3a54f99c
> -- 
> 2.39.3
> 



