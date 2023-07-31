Return-Path: <bpf+bounces-6422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DB7691B3
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C443828160B
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7F1774F;
	Mon, 31 Jul 2023 09:28:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A11426B
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 09:28:51 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616111A
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:28:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so2213903a12.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690795728; x=1691400528;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=wtH3YJMD11ClFBOSnTSJccRhxUCi2rBb0qglhfD80e4=;
        b=hpEhwkYRUgPwcYiX5zoW238M0RpToVCkf2zw8CHjXVjUcpOhbFkx44f6DRF2fH3C/O
         kIL36gVAKuHoEpU24X+lAGQ3NWBEAKledAPHkMu3sx53L6rTxWDl+x8mnjdn0ZH7kSml
         s1ZDnBF/acdwWm6mCquKVy5KmvlDNEr+SnAjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795728; x=1691400528;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtH3YJMD11ClFBOSnTSJccRhxUCi2rBb0qglhfD80e4=;
        b=j5piyoZ4gUWJe0Uhv8KquexQkp3XHEC007rxBCg2kRMZIJi+BNtfN3YSfWKIG7L/h6
         4Ch7eUZNzA1JN9w95z55CvSEuGPW968go7J5UG6w8fS/IkMCKrXXqyhbU6mSGk8wEHT3
         Eu6gBqni3zmltaNpwRLXff1F1rlxFjH1yMwyzp0SuWbvLH1mojvPT970tfjTKnsaKQW5
         AYOKjAXfwKnOD3EvtLB1pGF7CqUQ7tgxGdgvv14rnMpfbWxh2IBQRZGtaYbblNOVnwK3
         iCmzoV6QojCUinqCjsv5SfoVPJ7mTSJr/BThl2dIKZy1oQgAhnbymQ14MZrRUmwQm9xz
         XaNQ==
X-Gm-Message-State: ABy/qLaIAahvhIsZ81AJqbSSt66WV2fh8gEZmWc9jOo5ACA48Ug42lKw
	SYzTEWEtL9Fl7GXcddmluiGu9bAn5lhPyETH/s8=
X-Google-Smtp-Source: APBJJlH5vz9bIOjc/NhazbMjjsF4NHsoCSJFQ/SXvy3HcL+W4PkPGZj3rOCrhgK6jwYyNkWtfd8x7A==
X-Received: by 2002:a17:906:1053:b0:99c:441:ffa with SMTP id j19-20020a170906105300b0099c04410ffamr5972053ejj.29.1690795728002;
        Mon, 31 Jul 2023 02:28:48 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090680cb00b009892cca8ae3sm5856176ejx.165.2023.07.31.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:28:47 -0700 (PDT)
References: <20230728064411.305576-1-tglozar@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: tglozar@redhat.com
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
Date: Mon, 31 Jul 2023 11:16:12 +0200
In-reply-to: <20230728064411.305576-1-tglozar@redhat.com>
Message-ID: <87ila0fn01.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
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
>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---

We disable softirq and hold a spin lock when modifying the map/hash in
sock_{map,hash}_update_common so this LGTM:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

You might want some extra tags:

Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and update in parallel")

