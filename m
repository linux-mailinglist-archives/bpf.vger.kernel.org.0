Return-Path: <bpf+bounces-1081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97970D87A
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358C91C20B97
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62531E50F;
	Tue, 23 May 2023 09:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536291E502
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:10:21 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9430133
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 02:10:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso1126369a12.1
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684833017; x=1687425017;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=1QOnhmhQcfsGx+rArW9ldjesvXZrSKQ2VpK+ZIwxpGQ=;
        b=N8Je+71DSj8Jzkye46bzqtl4EXzbcA+jIYFi8TH9lWIHOGU/Jb/p83pK3GpemrQ6N8
         sweJnFR957ztbpYV38jU7DZKVnt0JeLrWwZFgoiReLEfHtEgFMdVpWF6LMBDoVLOX4kP
         W8UTLPmouJl7bxWNURReA3+Rm8GyfeQd51ga8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833017; x=1687425017;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QOnhmhQcfsGx+rArW9ldjesvXZrSKQ2VpK+ZIwxpGQ=;
        b=RfFmXZYrFhFrVmIDeYh7VNWRVx8g5AQBCd97kHzS7yS4D+OP+0huGcqFi6ekwuCQ04
         O6NVop2xsHfsKZO1qpmYkJkjDATurxzC+eqsx1k/kpPzIuUrxiQZd8LlCv3kFb8JwMx8
         ornSHwtOOUKjIk/1XOAZ9OgN2PMIBJfvmkqu62LZWjABxJ9KDrZqMw0edtDfv+iMi36m
         oT0Ac7n5f+bDxgvdCrEWOBsJnYTGNVuSfUutNXEhXZHZf/q28rILZrFnm+Q3x+YfEY/k
         ViMO6KQDQmHr7xO+uDvqvm8D9nY7SC3F5k7t16CjGMTGEyiZBmbH1TlevTMvjGzyLXeK
         WnGg==
X-Gm-Message-State: AC+VfDwlVdaMShEeG/NJevg/6Yu5KwVncrOnn31XGUXvnr674rhiyDsK
	yML3xVSJSOesdRywxNJcoRX3mw==
X-Google-Smtp-Source: ACHHUZ5UXmvy7gfzTPYOt2eEb/kPO1NasqlXNCU8bkwus+kRSGI3vzcRNDKpljHcrrvqa5RkylS3mw==
X-Received: by 2002:a17:907:3686:b0:96f:1f79:c0a6 with SMTP id bi6-20020a170907368600b0096f1f79c0a6mr11111181ejc.70.1684833017363;
        Tue, 23 May 2023 02:10:17 -0700 (PDT)
Received: from cloudflare.com (79.184.126.163.ipv4.supernova.orange.pl. [79.184.126.163])
        by smtp.gmail.com with ESMTPSA id qx15-20020a170906fccf00b00965f98eefc1sm4190433ejb.116.2023.05.23.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:10:16 -0700 (PDT)
References: <20230523025618.113937-1-john.fastabend@gmail.com>
 <20230523025618.113937-9-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v10 08/14] bpf: sockmap, incorrectly handling
 copied_seq
Date: Tue, 23 May 2023 11:09:45 +0200
In-reply-to: <20230523025618.113937-9-john.fastabend@gmail.com>
Message-ID: <87cz2r76rs.fsf@cloudflare.com>
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
> The read_skb() logic is incrementing the tcp->copied_seq which is used for
> among other things calculating how many outstanding bytes can be read by
> the application. This results in application errors, if the application
> does an ioctl(FIONREAD) we return zero because this is calculated from
> the copied_seq value.
>
> To fix this we move tcp->copied_seq accounting into the recv handler so
> that we update these when the recvmsg() hook is called and data is in
> fact copied into user buffers. This gives an accurate FIONREAD value
> as expected and improves ACK handling. Before we were calling the
> tcp_rcv_space_adjust() which would update 'number of bytes copied to
> user in last RTT' which is wrong for programs returning SK_PASS. The
> bytes are only copied to the user when recvmsg is handled.
>
> Doing the fix for recvmsg is straightforward, but fixing redirect and
> SK_DROP pkts is a bit tricker. Build a tcp_psock_eat() helper and then
> call this from skmsg handlers. This fixes another issue where a broken
> socket with a BPF program doing a resubmit could hang the receiver. This
> happened because although read_skb() consumed the skb through sock_drop()
> it did not update the copied_seq. Now if a single reccv socket is
> redirecting to many sockets (for example for lb) the receiver sk will be
> hung even though we might expect it to continue. The hang comes from
> not updating the copied_seq numbers and memory pressure resulting from
> that.
>
> We have a slight layer problem of calling tcp_eat_skb even if its not
> a TCP socket. To fix we could refactor and create per type receiver
> handlers. I decided this is more work than we want in the fix and we
> already have some small tweaks depending on caller that use the
> helper skb_bpf_strparser(). So we extend that a bit and always set
> the strparser bit when it is in use and then we can gate the
> seq_copied updates on this.
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

