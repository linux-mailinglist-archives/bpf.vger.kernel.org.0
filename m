Return-Path: <bpf+bounces-1078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6270D53B
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB9280FB2
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BC51D2DF;
	Tue, 23 May 2023 07:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A1D2D9
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 07:36:57 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55929133
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 00:36:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f7377c86aso795326166b.1
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684827415; x=1687419415;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=t59b5dObDa+SJIKgajgep5LVPEaYQ+q4ZH79RVF4PVM=;
        b=DLXJl66VC1/9BLZlVa1h7s99aBB4anQSbKyZ7VTzFsrTOtBGIHRLRuV+OcVOlkrJhm
         E0qGscSIVZjFwDD/YbPE9C6cQfyzuggRgXtYM8FIl5TG2EGq2bQhBSS404htbAX8MIC4
         PQvxl6Y1OVJB2mNGAuyb63/vK/NYHnFNTeMFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684827415; x=1687419415;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t59b5dObDa+SJIKgajgep5LVPEaYQ+q4ZH79RVF4PVM=;
        b=DqxsYZai6yi561yp7PAkh4oeYVb7b+nmxvPidQ13+WTJll4B/dXmlQ3d6PU/cuVHdd
         9N48NuWokjqVG1j7yKHVfi+N+YFYGPUnPu6VN77ZdfwBbdVHGqgtMLI22kurXMSUSfcF
         ZMvw6N1oXqzVibbiUwAxYFAcpLYJGayKfIlrwx7gpbppROjBrywDaFwKTFL3Zm/K3VGI
         jXUGyTbiN3XNUYL02ryvccY63eIVyyA3yXdxmBUmZfVQKdZjEU/O6XZ+zGJzuPrA9UE7
         WioCJ+UITK7j+Kt8fJRbpWHG810TI2nRwGWzT2qu/rWcF4NmlDJVLBHo2U0U4vUndFwE
         UkJQ==
X-Gm-Message-State: AC+VfDzcTHrMPf0awVu0HqtjHvQ+QIxHMK4836mjVYRnR013VXu3SaGl
	nzSnoJs1kTqOKVAy7wk0EG2+mQ==
X-Google-Smtp-Source: ACHHUZ6/lWowG6QRPF8M+CFtCnOmr1Od3qg12tfnXsmc9bIeXWRqYUtdJ7HahEkF69ndmNBW8iPumQ==
X-Received: by 2002:a17:907:3ea5:b0:950:e44:47ae with SMTP id hs37-20020a1709073ea500b009500e4447aemr14264658ejc.40.1684827414748;
        Tue, 23 May 2023 00:36:54 -0700 (PDT)
Received: from cloudflare.com (79.184.126.163.ipv4.supernova.orange.pl. [79.184.126.163])
        by smtp.gmail.com with ESMTPSA id gv18-20020a170906f11200b00965a4350411sm4008921ejb.9.2023.05.23.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:36:54 -0700 (PDT)
References: <20230523025618.113937-1-john.fastabend@gmail.com>
 <20230523025618.113937-5-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v10 04/14] bpf: sockmap, improved check for empty queue
Date: Tue, 23 May 2023 09:35:42 +0200
In-reply-to: <20230523025618.113937-5-john.fastabend@gmail.com>
Message-ID: <87h6s37b3f.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 07:56 PM -07, John Fastabend wrote:
> We noticed some rare sk_buffs were stepping past the queue when system was
> under memory pressure. The general theory is to skip enqueueing
> sk_buffs when its not necessary which is the normal case with a system
> that is properly provisioned for the task, no memory pressure and enough
> cpu assigned.
>
> But, if we can't allocate memory due to an ENOMEM error when enqueueing
> the sk_buff into the sockmap receive queue we push it onto a delayed
> workqueue to retry later. When a new sk_buff is received we then check
> if that queue is empty. However, there is a problem with simply checking
> the queue length. When a sk_buff is being processed from the ingress queue
> but not yet on the sockmap msg receive queue its possible to also recv
> a sk_buff through normal path. It will check the ingress queue which is
> zero and then skip ahead of the pkt being processed.
>
> Previously we used sock lock from both contexts which made the problem
> harder to hit, but not impossible.
>
> To fix instead of popping the skb from the queue entirely we peek the
> skb from the queue and do the copy there. This ensures checks to the
> queue length are non-zero while skb is being processed. Then finally
> when the entire skb has been copied to user space queue or another
> socket we pop it off the queue. This way the queue length check allows
> bypassing the queue only after the list has been completely processed.
>
> To reproduce issue we run NGINX compliance test with sockmap running and
> observe some flakes in our testing that we attributed to this issue.
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Tested-by: William Findlay <will@isovalent.com>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

