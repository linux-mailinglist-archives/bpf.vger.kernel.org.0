Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C028B112
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgJLJDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJLJDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 05:03:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55351C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 02:03:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 13so16515167wmf.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=MpfpqjTR0AHrehJQA8eBI4YEh7awCKCyYyclE8s34PQ=;
        b=E95yvcfWq2F0DCa5hFZ+RFunw0JOpWh4YyMsRbNHSK2k8wFdvnKuqcX/LmrAyUQqlL
         zZkL7uuzD3T4GMMmHvRs2TuhbLPgcAGq6mzvPyClQeS5uJOqRT0OcoHSll+TYQgXwjWG
         MBRXuvXLUTTnNbz0LuIhpFxSF25Kc2opSZ7gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=MpfpqjTR0AHrehJQA8eBI4YEh7awCKCyYyclE8s34PQ=;
        b=f10arwzJsIg/fAJsH8oO4iU5wdvNQ7TEG4mTSGG0NUenrT70v5D3Yd5I0XbeUtX4SW
         I1x4JDGFnLpl8pQUXq4uz40mzNip1Bzo6RwzdHpCzy0ztDcYIdKIX7m2GSiI0s4yf/sc
         PXZ3hxxK7z6irYJkjWODsIdRke/Ith/Q2rtaf6SxIpcqSGQuMyma4gjCW8DT3/dAP8aC
         HJ6RZG+nIGzyDnmRxEHlQ1Y8a+2daxAFzGC5Ogt/KXFDO/C+zbRpxP9dspRs3GqTWC51
         Kz7MnY8av61tMZd2dTwuS70Fc3ao6BB1A0ovFYGtVcOqHW0tcTmm+xKqJfd1IvdIB27Q
         9xvw==
X-Gm-Message-State: AOAM530kwqVORFOIWzonaUeWBwAQ8+l6jUPluBA1hDasr+5WIQm0I/sS
        T4yVyU2JziyEkmnLhVqmtHaRGg==
X-Google-Smtp-Source: ABdhPJwPZE74VN630yOHt1NLVK1vJFR41AOgfuUCSsVTAQbfvr9Mkb3oARQWLBqAxBBG5JhDHItJRA==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr10335720wmk.91.1602493400803;
        Mon, 12 Oct 2020 02:03:20 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id z127sm22576344wmc.2.2020.10.12.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 02:03:20 -0700 (PDT)
References: <160226839426.5692.13107801574043388675.stgit@john-Precision-5820-Tower> <160226859704.5692.12929678876744977669.stgit@john-Precision-5820-Tower>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, lmb@cloudflare.com
Subject: Re: [bpf-next PATCH v3 2/6] bpf, sockmap: On receive programs try to fast track SK_PASS ingress
In-reply-to: <160226859704.5692.12929678876744977669.stgit@john-Precision-5820-Tower>
Date:   Mon, 12 Oct 2020 11:03:19 +0200
Message-ID: <87h7qzrf3c.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey John,

Exiting to see this work :-)

On Fri, Oct 09, 2020 at 08:36 PM CEST, John Fastabend wrote:
> When we receive an skb and the ingress skb verdict program returns
> SK_PASS we currently set the ingress flag and put it on the workqueue
> so it can be turned into a sk_msg and put on the sk_msg ingress queue.
> Then finally telling userspace with data_ready hook.
>
> Here we observe that if the workqueue is empty then we can try to
> convert into a sk_msg type and call data_ready directly without
> bouncing through a workqueue. Its a common pattern to have a recv
> verdict program for visibility that always returns SK_PASS. In this
> case unless there is an ENOMEM error or we overrun the socket we
> can avoid the workqueue completely only using it when we fall back
> to error cases caused by memory pressure.
>
> By doing this we eliminate another case where data may be dropped
> if errors occur on memory limits in workqueue.
>
> Fixes: 51199405f9672 ("bpf: skb_verdict, support SK_PASS on RX BPF path")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/skmsg.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 040ae1d75b65..4b160d97b7f9 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -773,6 +773,7 @@ static void sk_psock_verdict_apply(struct sk_psock *psock,
>  {
>  	struct tcp_skb_cb *tcp;
>  	struct sock *sk_other;
> +	int err = -EIO;
>
>  	switch (verdict) {
>  	case __SK_PASS:
> @@ -784,8 +785,20 @@ static void sk_psock_verdict_apply(struct sk_psock *psock,
>
>  		tcp = TCP_SKB_CB(skb);
>  		tcp->bpf.flags |= BPF_F_INGRESS;
> -		skb_queue_tail(&psock->ingress_skb, skb);
> -		schedule_work(&psock->work);
> +
> +		/* If the queue is empty then we can submit directly
> +		 * into the msg queue. If its not empty we have to
> +		 * queue work otherwise we may get OOO data. Otherwise,
> +		 * if sk_psock_skb_ingress errors will be handled by
> +		 * retrying later from workqueue.
> +		 */
> +		if (skb_queue_empty(&psock->ingress_skb)) {
> +			err = sk_psock_skb_ingress(psock, skb);

When going through the workqueue (sk_psock_backlog), we will also check
if socket didn't get detached from the process, that is if
psock->sk->sk_socket != NULL, before queueing into msg queue.

Do we need a similar check here?

> +		}
> +		if (err < 0) {
> +			skb_queue_tail(&psock->ingress_skb, skb);
> +			schedule_work(&psock->work);
> +		}
>  		break;
>  	case __SK_REDIRECT:
>  		sk_psock_skb_redirect(skb);
