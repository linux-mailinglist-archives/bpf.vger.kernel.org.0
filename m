Return-Path: <bpf+bounces-3861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A97458C6
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B771C2083F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC8441F;
	Mon,  3 Jul 2023 09:48:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D920F5;
	Mon,  3 Jul 2023 09:48:51 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5912C;
	Mon,  3 Jul 2023 02:48:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-636220ca533so5573086d6.0;
        Mon, 03 Jul 2023 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688377729; x=1690969729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Or8dFWcZaZQ+0fBVUWIhSbo2VVRVHtdq1po7KsbeTx0=;
        b=j89bmR0pEZdAh1wW0mtwaoyM9ZTL4bdljqEP1mBSHDe2uHocqrRTilD8XW5ziOwKWz
         hrPZP28u0sBWfIS9859Pvk9/JKqxoQe1taeAF27ItcbIK8njFTg4dL1b8+tj4yVnnVFL
         RMDgA0dgWjUu9gBAdFjAsdQoWGsnrAyzyUyLkwysrnp4AUMqNLSgzCb6LxHFb9Gd6huN
         F9FT8Wi3HUJcnguNRJdPA0LHGCAYhm3mQ+Y4C30Q4nyG8e4+nXGlxkGVKaLGb1tWkhLV
         shvBlXlVd4B1Se5f2fCmzjIIjVG00COmjnaQGfFwibQxKXQlg4rY5clf0bIdlHLA9mLO
         n7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377729; x=1690969729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or8dFWcZaZQ+0fBVUWIhSbo2VVRVHtdq1po7KsbeTx0=;
        b=Q6qMT0qcZUztVqEutltOmvCAbrf8Rsz1yK3Mum9qktoBiJW9jd5KRWQfk9xZL1RIAV
         8yDmvm+qyb9FRR/J3sSdkN9Ab8EBtCEtN9Btc5N2hc/weMRn7zFiUskVNhHj13vF3m8f
         JMv2iOsfVTeqx4Sdwakd+bkLzRpUcU8FPXdLgNrs5B+g5Chb3FUTrAXp0G1DIuUWHZwA
         Dij+2iCEkIJjJ/z19bBZlcEkdCDFkwknyzo61bKaaXGmYwc1Nr2jv26HdaqsqkSMWdB0
         fnoAMTGzdwW4pti5jt1Em2tCppqEPPV4kcfp8xKMuq2KRiukxMlfoZ0IsuNdxrUt4gXh
         UEGw==
X-Gm-Message-State: ABy/qLZRW9TrfKC2CrZnPZdIunbdKugAGnOdq6xvkrXzY2oQy7QrxwOU
	JiqUvJr8qVI2slDQoW7pUwnVMzkE6Pt0l2u0Is9mnrbkMLc=
X-Google-Smtp-Source: APBJJlHCHVbQdo+WqYTG17yAsz+Uxt6mkudWjoRztusl1dmRn2e+ADRNdeCGju1yyofs01i+BYhVnJamRuEwnxmaEe0=
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id
 gm5-20020a056214268500b00635d9d0cccfmr10789245qvb.4.1688377728977; Mon, 03
 Jul 2023 02:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630145831.2988845-1-i.maximets@ovn.org>
In-Reply-To: <20230630145831.2988845-1-i.maximets@ovn.org>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 3 Jul 2023 11:48:37 +0200
Message-ID: <CAJ8uoz1TGjWuJKkZ8C9ZrQB0CDasik3A=qJs=xwdQP8cbn97VQ@mail.gmail.com>
Subject: Re: [RFC bpf-next] xsk: honor SO_BINDTODEVICE on bind
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 30 Jun 2023 at 16:58, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
> A privileged process might create the socket and pass it to a
> non-privileged process for later use.  However, that process will be
> able to bind the socket to any network interface.  Even though it will
> not be able to receive any traffic without modification of the BPF map,
> the situation is not ideal.
>
> Sockets already have a mechanism that can be used to restrict what
> interface they can be attached to.  That is SO_BINDTODEVICE.
>
> To change the binding the process will need CAP_NET_RAW.
>
> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
> workflow when non-privileged process is using AF_XDP.

Rebinding an AF_XDP socket is not allowed today. Any such attempt will
return an error from bind. So if I understand the purpose of
SO_BINDTODEVICE correctly, you could say that this option is always
set for an AF_XDP socket and it is not possible to toggle it. The only
way to "rebind" an AF_XDP socket is to close it and open a new one.
This was a conscious design decision from day one as it would be very
hard to support this, especially in zero-copy mode.

> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>
> Posting as an RFC for now to probably get some feedback.
> Will re-post once the tree is open.
>
>  Documentation/networking/af_xdp.rst | 9 +++++++++
>  net/xdp/xsk.c                       | 6 ++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index 247c6c4127e9..1cc35de336a4 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
>  application to use. The final option is the flags field, but it will
>  be dealt with in separate sections for each UMEM flag.
>
> +SO_BINDTODEVICE setsockopt
> +--------------------------
> +
> +This is a generic SOL_SOCKET option that can be used to tie AF_XDP
> +socket to a particular network interface.  It is useful when a socket
> +is created by a privileged process and passed to a non-privileged one.
> +Once the option is set, kernel will refuse attempts to bind that socket
> +to a different interface.  Updating the value requires CAP_NET_RAW.
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5a8c0dd250af..386ff641db0f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>         struct sock *sk = sock->sk;
>         struct xdp_sock *xs = xdp_sk(sk);
>         struct net_device *dev;
> +       int bound_dev_if;
>         u32 flags, qid;
>         int err = 0;
>
> @@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>                       XDP_USE_NEED_WAKEUP))
>                 return -EINVAL;
>
> +       bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
> +
> +       if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
> +               return -EINVAL;
> +
>         rtnl_lock();
>         mutex_lock(&xs->mutex);
>         if (xs->state != XSK_READY) {
> --
> 2.40.1
>
>

