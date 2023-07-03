Return-Path: <bpf+bounces-3867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8D745A1C
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8481C20846
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 10:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14860525B;
	Mon,  3 Jul 2023 10:24:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F773D9E;
	Mon,  3 Jul 2023 10:24:30 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F389B;
	Mon,  3 Jul 2023 03:24:29 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-5e5b5da22b8so8701986d6.0;
        Mon, 03 Jul 2023 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688379868; x=1690971868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cki6QWqpAbrbrnV4IjvHuqleiOcUiHi1jJzvSuXEVw=;
        b=ewRqGNVScCYnU8Aq/g7Pf95eMJJMf4qDBGh2SlMsVy35KnB1RqZnhdJIYM0uWJlKXm
         kS1YSOZ0dhNQmueHhhPInOWzPXUhmA0AYbCX4a4Z+VpdktFABcdQwnammCTvSl7x6ZbQ
         ICXaQhwpCuWOOQhkeDh8LIJL/2iaji3HwvS25m1874X8xcr1AXcFjB1U8bIr+HQ/Y1lG
         WzV0HW/coIqGvYlBhRgSXvKb/Mg7WAec0k2/JGPqP6OBbQ2YY4l0LyouQTiki4II4ZU0
         mRbOSf22GQfz0NJ1z469El+CsLAw71O0m9G2xKxBRRSSMIJssa+fvy2aGSCpgr1gp0dZ
         uGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379868; x=1690971868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cki6QWqpAbrbrnV4IjvHuqleiOcUiHi1jJzvSuXEVw=;
        b=HNp3xVyNv0tv2QGpYOebSUZrSmZ9b1GR4zq30xHWN4MHO/Ap4GeHRck/NY6eYeasS9
         g4Ne+O3jdslEOdwi5zZQ0rmwTl79cBSbN+mXQPRH4PW+WjC62UTIQP9wfV8fXH1W2zYg
         CmdPln1PHprETfrtwp3x1LpvqzrXifNWUGL9aX81s5RBiBHXoRmV3fSPG6rxz8IW1zsm
         0CiR9m2Qsu1FaBe0xN2qrsLrJnab4KoSuAjSzkK8ZKNsNIpiTWOcWOmzbhqxDkdH8IgC
         qvVP/ztuquxULhDZ9m9vBA2DXZuLqLlylsCfxcXzEs+grHJ9RIIH+LJEIu8pnWZbtKma
         2xpA==
X-Gm-Message-State: ABy/qLakDKYdRxgIkLgMdumgwAPC8Xfs6WItD7rxDufju/3Fq7dTzLMR
	gARBk/gCX6v0iNA4EsDsAA+eeWMhFlflpXaPEEHr79anvc+ThtpH
X-Google-Smtp-Source: APBJJlGNpOiEwgHJlSYT0hkdI6b1Ql5FVBXYyJMiRNknYcWYjbwzIugXlOG2zzqxCT9KNu+erkXgb+x7iwWXBUMVrMQ=
X-Received: by 2002:a05:6214:410d:b0:625:aa49:c182 with SMTP id
 kc13-20020a056214410d00b00625aa49c182mr12130438qvb.6.1688379868039; Mon, 03
 Jul 2023 03:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630145831.2988845-1-i.maximets@ovn.org> <CAJ8uoz1TGjWuJKkZ8C9ZrQB0CDasik3A=qJs=xwdQP8cbn97VQ@mail.gmail.com>
 <04ed302e-067e-d372-370b-3fef1cf8c7f2@ovn.org> <c6944b25-7ac4-0b75-75b1-465c8a705d02@ovn.org>
In-Reply-To: <c6944b25-7ac4-0b75-75b1-465c8a705d02@ovn.org>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 3 Jul 2023 12:24:17 +0200
Message-ID: <CAJ8uoz0ChXfavPKAkjsj8URKp3sJPPcd_dqiHsxP0iG6NjiVzg@mail.gmail.com>
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

On Mon, 3 Jul 2023 at 12:13, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 7/3/23 12:06, Ilya Maximets wrote:
> > On 7/3/23 11:48, Magnus Karlsson wrote:
> >> On Fri, 30 Jun 2023 at 16:58, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>
> >>> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
> >>> A privileged process might create the socket and pass it to a
> >>> non-privileged process for later use.  However, that process will be
> >>> able to bind the socket to any network interface.  Even though it will
> >>> not be able to receive any traffic without modification of the BPF map,
> >>> the situation is not ideal.
> >>>
> >>> Sockets already have a mechanism that can be used to restrict what
> >>> interface they can be attached to.  That is SO_BINDTODEVICE.
> >>>
> >>> To change the binding the process will need CAP_NET_RAW.
> >>>
> >>> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
> >>> workflow when non-privileged process is using AF_XDP.
> >>
> >> Rebinding an AF_XDP socket is not allowed today. Any such attempt will
> >> return an error from bind. So if I understand the purpose of
> >> SO_BINDTODEVICE correctly, you could say that this option is always
> >> set for an AF_XDP socket and it is not possible to toggle it. The only
> >> way to "rebind" an AF_XDP socket is to close it and open a new one.
> >> This was a conscious design decision from day one as it would be very
> >> hard to support this, especially in zero-copy mode.
> >
> > Hi, Magnus.
> >
> > The purpose of this patch is not to allow re-binding.  The use case is
> > following:
> >
> > 1. First process creates a bare socket with socket(AF_XDP, ...).
> > 2. First process loads the XSK program to the interface.
> > 3. First process adds the socket fd to a BPF map.
> > 4. First process sends socket fd to a second process.
> > 5. Second process allocates UMEM.
> > 6. Second process binds socket to the interface.
>
> 7. Second process sends/receives the traffic. :)
>
> >
> > The idea is that the first process will call SO_BINDTODEVICE before
> > sending socket fd to a second process, so the second process is limited
> > in to which interface it can bind the socket.
> >
> > Does that make sense?

Thanks for explaining this to me. Yes, that makes sense and seems
useful. Could you please send a v2 and include the flow (1-7) above in
your commit message? Would be good to add one step with the setsockopt
SO_BINDTODEVICE before step #4 just to be clear. With those changes
please feel free to include my ack:

 Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Thank you!

> > This workflow allows the second process to have no capabilities
> > as long as it has sufficient RLIMIT_MEMLOCK.
>
> Note that steps 1-7 are working just fine today.  i.e. the umem
> registration, bind, ring mapping and traffic send/receive do not
> require any extra capabilities.
>
> We may restrict the bind() call to require CAP_NET_RAW and then
> allow it for sockets that had SO_BINDTODEVICE as an alternative.
> But restriction will break the current uAPI.
>
> >
> > Best regards, Ilya Maximets.
> >
> >>
> >>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >>> ---
> >>>
> >>> Posting as an RFC for now to probably get some feedback.
> >>> Will re-post once the tree is open.
> >>>
> >>>  Documentation/networking/af_xdp.rst | 9 +++++++++
> >>>  net/xdp/xsk.c                       | 6 ++++++
> >>>  2 files changed, 15 insertions(+)
> >>>
> >>> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> >>> index 247c6c4127e9..1cc35de336a4 100644
> >>> --- a/Documentation/networking/af_xdp.rst
> >>> +++ b/Documentation/networking/af_xdp.rst
> >>> @@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
> >>>  application to use. The final option is the flags field, but it will
> >>>  be dealt with in separate sections for each UMEM flag.
> >>>
> >>> +SO_BINDTODEVICE setsockopt
> >>> +--------------------------
> >>> +
> >>> +This is a generic SOL_SOCKET option that can be used to tie AF_XDP
> >>> +socket to a particular network interface.  It is useful when a socket
> >>> +is created by a privileged process and passed to a non-privileged one.
> >>> +Once the option is set, kernel will refuse attempts to bind that socket
> >>> +to a different interface.  Updating the value requires CAP_NET_RAW.
> >>> +
> >>>  XDP_STATISTICS getsockopt
> >>>  -------------------------
> >>>
> >>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> >>> index 5a8c0dd250af..386ff641db0f 100644
> >>> --- a/net/xdp/xsk.c
> >>> +++ b/net/xdp/xsk.c
> >>> @@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> >>>         struct sock *sk = sock->sk;
> >>>         struct xdp_sock *xs = xdp_sk(sk);
> >>>         struct net_device *dev;
> >>> +       int bound_dev_if;
> >>>         u32 flags, qid;
> >>>         int err = 0;
> >>>
> >>> @@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> >>>                       XDP_USE_NEED_WAKEUP))
> >>>                 return -EINVAL;
> >>>
> >>> +       bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
> >>> +
> >>> +       if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
> >>> +               return -EINVAL;
> >>> +
> >>>         rtnl_lock();
> >>>         mutex_lock(&xs->mutex);
> >>>         if (xs->state != XSK_READY) {
> >>> --
> >>> 2.40.1
> >>>
> >>>
> >
>

