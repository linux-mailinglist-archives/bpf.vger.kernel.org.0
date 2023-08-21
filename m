Return-Path: <bpf+bounces-8148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946B7824F0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F33280EBE
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9371FB2;
	Mon, 21 Aug 2023 07:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02631C11
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 07:53:26 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2CBD
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 00:53:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99cdb0fd093so407996566b.1
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692604403; x=1693209203;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=y62hmR88pA4UtBccW8+hc1HjFNxlERoi2gFRG58Bjhg=;
        b=keHVNwAzoo2O5cW0dwMpaYHIxCoQzBVBie0Kf6ztRcRLG0V7GZmVAF+kOOplQLE2Oj
         J0coR4tCtvOowauZuHU7gV3zZcE2ft5dzT/j/qTW8c+bZfFaPTJpBWLnjwRVtlFpIje7
         LaX33AIS7xHEAVHAOgKnVLX4lTmQ4R/XjYHr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604403; x=1693209203;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y62hmR88pA4UtBccW8+hc1HjFNxlERoi2gFRG58Bjhg=;
        b=bIY147VGyn9gAqvE09hmRvJGdT0DsbDwM9W05wk9ZybK1Fra2ShhabwZlX6eNkoOFb
         sfQv81citWEqAMxl9eTBsNnNXlijZR6WlTxHeKVg8pRYormG4Xy2gaGdm2If5hf/FXTp
         td7x2hkGbGaFqcCJd1l8oMH0IDCHqYlQP+RNDc0bzjRHpOf1MogGzgNCEuzExcG70ZRP
         aX2mm7QnHKIF3U+ygeQJLzGmV10VZWVSFD01erMTgnflKsIuuSnkqDi0g+nzeQxsAB7N
         ETj4EYtKVZ0l5ghP+06JBJrl9WaDrxKvVMWT4po1hmih7B8L8ibPgYPwZGrep6QJGQNI
         auQg==
X-Gm-Message-State: AOJu0Ywu8Kxua7YJy+lnIyfbfvk5bDtmvG5aaHxci6RPwDacR/b5UYOz
	XneaQZLKaKKXattxoww3NDubLg==
X-Google-Smtp-Source: AGHT+IF8q7WBQx+MjQNIY8NaJ47ngN0QsagP+g4zPvfBnvOHiCIPVI55m+6w9wRePX8L/MGpe6e/gw==
X-Received: by 2002:a17:907:7897:b0:993:f15f:efb7 with SMTP id ku23-20020a170907789700b00993f15fefb7mr4514534ejc.8.1692604403208;
        Mon, 21 Aug 2023 00:53:23 -0700 (PDT)
Received: from cloudflare.com (79.184.134.65.ipv4.supernova.orange.pl. [79.184.134.65])
        by smtp.gmail.com with ESMTPSA id t3-20020a170906a10300b00993860a6d37sm6051184ejy.40.2023.08.21.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:53:22 -0700 (PDT)
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY
 flag for skmsg redirect
Date: Mon, 21 Aug 2023 09:40:45 +0200
In-reply-to: <20230811093237.3024459-2-liujian56@huawei.com>
Message-ID: <87v8d86dce.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 05:32 PM +08, Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward packets
> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only needs to
> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.
>
> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
>
> Test results using netperf  TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> done
>
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  include/linux/skmsg.h          |  1 +
>  include/uapi/linux/bpf.h       |  7 +++++--
>  net/core/skmsg.c               |  1 +
>  net/core/sock_map.c            |  4 ++--
>  net/ipv4/tcp_bpf.c             | 21 +++++++++++++++------
>  tools/include/uapi/linux/bpf.h |  7 +++++--
>  6 files changed, 29 insertions(+), 12 deletions(-)
>

[...]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 81f0dff69e0b..36cf2b0fa6f8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -419,8 +419,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  		if (!psock->apply_bytes) {
>  			/* Clean up before releasing the sock lock. */
>  			eval = psock->eval;
> -			psock->eval = __SK_NONE;
> -			psock->sk_redir = NULL;
> +			if (!psock->eval_permanently) {
> +				psock->eval = __SK_NONE;
> +				psock->sk_redir = NULL;
> +			}
>  		}
>  		if (psock->cork) {
>  			cork = true;
> @@ -433,9 +435,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>  					    msg, tosend, flags);
>  		sent = origsize - msg->sg.size;
> +		/* disable the ability when something wrong */
> +		if (unlikely(ret < 0))
> +			psock->eval_permanently = 0;
>  
> -		if (eval == __SK_REDIRECT)
> +		if (!psock->eval_permanently && eval == __SK_REDIRECT) {
>  			sock_put(sk_redir);
> +			psock->sk_redir = NULL;
> +			psock->eval = __SK_NONE;
> +		}
>  
>  		lock_sock(sk);
>  		if (unlikely(ret < 0)) {

Looking at the above changes, I'm wondering - have you considered
introducing a dedicated a __sk_action for this? Like
__SK_REDIRECT_PERMANENT?

Just a gut feeling. Maybe it would make the code easier to ready if we
don't have to have another flag remember about.

Also, eval_permenently is not a great name, IMHO, because eval can be
also PASS or NONE, to which this flag does not apply. If the flag needs
to stay, it could be named something like redir_permanent so it's
obvious that it applies just to REDIRECT action.

[...]

