Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00D21A50D
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGIQqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 12:46:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AEFC08C5DC
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 09:46:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so3149856ljn.8
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsNWt03yJwDxgqEiluuHTjUcko/N47fgiVune7ahsmI=;
        b=NZ6EwJ5G1Kh3hCesuqRM8Wfewg39SZuNsnlO4wzwDamTOayKRMAVEC5Y6DKQLH43OH
         l4fYWbA8Sq6MSWkw/PXmkZvQ+hPfiTFLJnjhDtGX2LLqy7Nt/ZMPodaQyKoL+WSyqvdd
         uRryhPN8kZHcWZcfxGcbZ9AmejOG71A4oxnNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsNWt03yJwDxgqEiluuHTjUcko/N47fgiVune7ahsmI=;
        b=iY9dvv2pCr+LYF111mBLXY0U7IiIn2Zbyti5aLrbUxkLJz6MIu+KnYuWMro6rpDvdo
         QQkezVRS2yd3NEe0i5qV3YmQn5Ed4avgxGU8eZ5n33IYseEsv9DbQ6VhNHsC+axTAELH
         /sobt0KClkVGHiuq6hIUkCUTKyT7peVUBv+6sJnMuvimr9cjIJHI8zUgyKK+0eiIr8ad
         VhxCQ6Z4kGGWbje8UT9fhr4tox+z1W3YB+Ho6E4ciUGg5LkR98JoOre2uQofuNzBmsYp
         kZa32FccqlgUC0FchEEWzEgYdZ09kaQg2lZAN5tEqIDytOnqr0I0E9UxaQPn9k7eiR33
         b+7g==
X-Gm-Message-State: AOAM530Onaj1Rh2iWvJv7vlWPcoH7ekSreEz+G80L3VnZghC8SVrcN5n
        PBArGnBzEPwRduhXc6mYt5QMJw==
X-Google-Smtp-Source: ABdhPJwExpf84u+/tlg3znyLzqv5rc6XPOUbxxAFKhpqgDs9ap3nnkXnefnvqL9jQKlavC6k5U9L5w==
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr29409154ljk.335.1594313211493;
        Thu, 09 Jul 2020 09:46:51 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a23sm1116071lfb.10.2020.07.09.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:46:51 -0700 (PDT)
Date:   Thu, 9 Jul 2020 18:46:03 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf 1/2] bpf: net: Avoid copying sk_user_data of
 reuseport_array during sk_clone
Message-ID: <20200709184603.5afe6db2@toad>
In-Reply-To: <20200709061104.4018798-1-kafai@fb.com>
References: <20200709061057.4018499-1-kafai@fb.com>
        <20200709061104.4018798-1-kafai@fb.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 09 Jul 2020 06:11:04 +0000
Martin KaFai Lau <kafai@fb.com> wrote:

> It makes little sense for copying sk_user_data of reuseport_array during
> sk_clone_lock().  This patch reuses the SK_USER_DATA_NOCOPY bit introduced in
> commit f1ff5ce2cd5e ("net, sk_msg: Clear sk_user_data pointer on clone if tagged").
> It is used to mark the sk_user_data is not supposed to be copied to its clone.
> 
> Although the cloned sk's sk_user_data will not be used/freed in
> bpf_sk_reuseport_detach(), this change can still allow the cloned
> sk's sk_user_data to be used by some other means.
> 
> Freeing the reuseport_array's sk_user_data does not require a rcu grace
> period.  Thus, the existing rcu_assign_sk_user_data_nocopy() is not
> used.
> 
> Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  kernel/bpf/reuseport_array.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
> index 21cde24386db..a95bc8d7e812 100644
> --- a/kernel/bpf/reuseport_array.c
> +++ b/kernel/bpf/reuseport_array.c
> @@ -20,11 +20,14 @@ static struct reuseport_array *reuseport_array(struct bpf_map *map)
>  /* The caller must hold the reuseport_lock */
>  void bpf_sk_reuseport_detach(struct sock *sk)
>  {
> -	struct sock __rcu **socks;
> +	uintptr_t sk_user_data;
>  
>  	write_lock_bh(&sk->sk_callback_lock);
> -	socks = sk->sk_user_data;
> -	if (socks) {
> +	sk_user_data = (uintptr_t)sk->sk_user_data;
> +	if (sk_user_data) {
> +		struct sock __rcu **socks;
> +
> +		socks = (void *)(sk_user_data & SK_USER_DATA_PTRMASK);
>  		WRITE_ONCE(sk->sk_user_data, NULL);
>  		/*
>  		 * Do not move this NULL assignment outside of
> @@ -252,6 +255,7 @@ int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
>  	struct sock *free_osk = NULL, *osk, *nsk;
>  	struct sock_reuseport *reuse;
>  	u32 index = *(u32 *)key;
> +	uintptr_t sk_user_data;
>  	struct socket *socket;
>  	int err, fd;
>  
> @@ -305,7 +309,8 @@ int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
>  	if (err)
>  		goto put_file_unlock;
>  
> -	WRITE_ONCE(nsk->sk_user_data, &array->ptrs[index]);
> +	sk_user_data = (uintptr_t)&array->ptrs[index] | SK_USER_DATA_NOCOPY;
> +	WRITE_ONCE(nsk->sk_user_data, (void *)sk_user_data);
>  	rcu_assign_pointer(array->ptrs[index], nsk);
>  	free_osk = osk;
>  	err = 0;

Thanks for fixing this before I got around to it.
Now we can use reuseport with sockmap splicing :-)

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
