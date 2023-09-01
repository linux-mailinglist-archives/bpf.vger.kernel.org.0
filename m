Return-Path: <bpf+bounces-9124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47B790342
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 00:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49055280FB4
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA80FBF4;
	Fri,  1 Sep 2023 22:00:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A27AD53
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 22:00:02 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A821FC7
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 15:00:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b5516104so23724545e9.2
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693605599; x=1694210399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPPUM8Z1RZMYw0OH3kAcvblL7syZuFHMosCIhddPDCM=;
        b=CGIKnsF07pcAs2pneZ4bPZLiKNzbVZukmiO1Sj2T19s+Q2DGNZ+kG4IBzObuKqZGbG
         +fPtHMbnWNDjHVv1bsK5I2yVecIHThTLJQUfMHwd9BgllbqhXgXazkF+0Y8rKJMbRyBq
         fcOiDIExi8YDoUm6xwvBYaggOfELbxam+hAuU1ieoDIpsKZzkLjLSoZ1klI3w6ph7aXU
         BWyalLH2yrwOux1SEyUZMxuCCmwQN/r5Sv6XxEyw1SIfqncURUEKanyxWmNLEZ8m6sWf
         pcYHrqO69sLv3/qi8DHBP2QpdzS0JKVG/PShKEvni5VqzajSgDSxeIk0e1IZUwRxK/OD
         aCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693605599; x=1694210399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPPUM8Z1RZMYw0OH3kAcvblL7syZuFHMosCIhddPDCM=;
        b=OOXsk1uyo4qT4Aklxb+HC66xmQdBnAExDMGsj/x5ONKc8hsDHdcoS9ICyOQphSHkyJ
         J6s9k4km2ykKojRzaxwf1pT2Xwg7JGKvz/SDm7Kfk0vHY6dTmMazw0a1UmEVEJSvCN9d
         oaqQiYNcX45EvZ5sRyeChRCnSsB/qEt7glJ8D3LekciH5C7hEo75LUoqynKqJnbu3JgV
         pxVaI8WyrTb/QC1PNr8899x/7FIvDwkeURcOVVrm2ERSW1SEaEWZzBMW8rvRFFbgePd+
         obkb2ogYIBdHu+xG1KywX7rfL4yS8/CAVC6XtOV+9yNfe+ulOLm9pM5Es7XNaOHIrl8O
         yp9g==
X-Gm-Message-State: AOJu0YyMSc0jzBP9ZDCUfFmt2KYtFqa6Po+MMs/REnyVmwL/8Xud11yd
	rQ3Tz19JaSV3NNickoazJHF+1LOx3l8=
X-Google-Smtp-Source: AGHT+IEB/3vdotQEP8YO1Qerr3hG5Yy5eUPozYwSTw3u2oqgv2ZiQ0tDH3YDyvflCFAD5EBSh2Ea0A==
X-Received: by 2002:a17:906:18:b0:9a1:8a39:c62d with SMTP id 24-20020a170906001800b009a18a39c62dmr2845135eja.38.1693603443084;
        Fri, 01 Sep 2023 14:24:03 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009a5f7fb51d1sm2464775ejw.40.2023.09.01.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 14:24:02 -0700 (PDT)
Message-ID: <d8ba77cfeff26a8d52ef05d1bae43b5ceffd1b83.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking
 changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>, John Fastabend <john.fastabend@gmail.com>
Cc: xukuohai@huawei.com, edumazet@google.com, cong.wang@bytedance.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Date: Sat, 02 Sep 2023 00:24:01 +0300
In-Reply-To: <ZPJVlLXB/mggaLh5@krava>
References: <20230901202137.214666-1-john.fastabend@gmail.com>
	 <ZPJVlLXB/mggaLh5@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-09-01 at 23:20 +0200, Jiri Olsa wrote:
> On Fri, Sep 01, 2023 at 01:21:37PM -0700, John Fastabend wrote:
> > There is a race where skb's from the sk_psock_backlog can be referenced
> > after userspace side has already skb_consumed() the sk_buff and its
> > refcnt dropped to zer0 causing use after free.
> >=20
> > The flow is the following,
> >=20
> >   while ((skb =3D skb_peek(&psock->ingress_skb))
> >     sk_psock_handle_Skb(psock, skb, ..., ingress)
> >     if (!ingress) ...
> >     sk_psock_skb_ingress
> >        sk_psock_skb_ingress_enqueue(skb)
> >           msg->skb =3D skb
> >           sk_psock_queue_msg(psock, msg)
> >     skb_dequeue(&psock->ingress_skb)
> >=20
> > The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
> > what the application reads when recvmsg() is called. An application can
> > read this anytime after the msg is placed on the queue. The recvmsg
> > hook will also read msg->skb and then after user space reads the msg
> > will call consume_skb(skb) on it effectively free'ing it.
> >=20
> > But, the race is in above where backlog queue still has a reference to
> > the skb and calls skb_dequeue(). If the skb_dequeue happens after the
> > user reads and free's the skb we have a use after free.
> >=20
> > The !ingress case does not suffer from this problem because it uses
> > sendmsg_*(sk, msg) which does not pass the sk_buff further down the
> > stack.
> >=20
> > The following splat was observed with 'test_progs -t sockmap_listen':
> >=20
> > [ 1022.710250][ T2556] general protection fault, ...
> >  ...
> > [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
> > [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
> > [ 1022.713653][ T2556] Code: ...
> >  ...
> > [ 1022.720699][ T2556] Call Trace:
> > [ 1022.720984][ T2556]  <TASK>
> > [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> > [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
> > [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
> > [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
> > [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
> > [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
> > [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
> > [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
> > [ 1022.724386][ T2556]  kthread+0xfd/0x130
> > [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
> > [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
> > [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
> > [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
> > [ 1022.726201][ T2556]  </TASK>
> >=20
> > To fix we add an skb_get() before passing the skb to be enqueued in
> > the engress queue. This bumps the skb->users refcnt so that consume_skb
> > and kfree_skb will not immediately free the sk_buff. With this we can
> > be sure the skb is still around when we do the dequeue. Then we just
> > need to decrement the refcnt or free the skb in the backlog case which
> > we do by calling kfree_skb() on the ingress case as well as the sendmsg
> > case.
> >=20
> > Before locking change from fixes tag we had the sock locked so we
> > couldn't race with user and there was no issue here.
> >=20
> > Fixes: 799aa7f98d53e (skmsg: Avoid lock_sock() in sk_psock_backlog())
> > Reported-by: Jiri Olsa  <jolsa@kernel.org>
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  net/core/skmsg.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index a0659fc29bcc..6c31eefbd777 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_ps=
ock *psock, struct sk_buff *skb
> >  static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff =
*skb,
> >  			       u32 off, u32 len, bool ingress)
> >  {
> > +	int err =3D 0;
> > +
> >  	if (!ingress) {
> >  		if (!sock_writeable(psock->sk))
> >  			return -EAGAIN;
> >  		return skb_send_sock(psock->sk, skb, off, len);
> >  	}
> > -	return sk_psock_skb_ingress(psock, skb, off, len);
> > +	skb_get(skb);
> > +	err =3D sk_psock_skb_ingress(psock, skb, off, len);
> > +	if (err < 0)
> > +		kfree_skb(skb);
> > +	return err;
> >  }
> > =20
> >  static void sk_psock_skb_state(struct sk_psock *psock,
> > @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *wo=
rk)
> >  		} while (len);
> > =20
> >  		skb =3D skb_dequeue(&psock->ingress_skb);
> > -		if (!ingress) {
> > -			kfree_skb(skb);
> > -		}
> > +		kfree_skb(skb);
> >  	}
> >  end:
> >  	mutex_unlock(&psock->work_mutex);
> > --=20
> > 2.33.0
> >=20
>=20
> there's no crash wit with fix, but I noticed I occasionally get FAIL
>=20

Please note this patch:
https://lore.kernel.org/bpf/20230901031037.3314007-1-xukuohai@huaweicloud.c=
om/
Which should fix the test in question.

> #212/78  sockmap_listen/sockmap Unix test_unix_redir:OK
> ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport=
 endpoint is not connected
> vsock_unix_redir_connectible:FAIL:1501
> ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport =
endpoint is not connected
> vsock_unix_redir_connectible:FAIL:1501
> #212/79  sockmap_listen/sockmap VSOCK test_vsock_redir:FAIL
> #212/80  sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK
>=20
> no idea if it's related
>=20
> jirka


