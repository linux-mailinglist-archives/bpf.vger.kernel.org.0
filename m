Return-Path: <bpf+bounces-9122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABB7902CB
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B84281968
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C780F9D7;
	Fri,  1 Sep 2023 20:22:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79CC136;
	Fri,  1 Sep 2023 20:22:27 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE3E66;
	Fri,  1 Sep 2023 13:22:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc83a96067so18715475ad.0;
        Fri, 01 Sep 2023 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693599746; x=1694204546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaD763ZtpqCjyX5Kt9ZHyZcT5Qifqz2EgCV742e6Gak=;
        b=CdFZBsmZGXuugQjwUUZidFJouh4Zo4GQTIFJnhtz3vQk8o0XUkx/ZTvlu1WtSzEwMn
         GIAZMruHlxlIAQQB2mbUKy2uGBIFDc3xUzB7RdjRYL9nW89LqQNavMyjeMYrguapbhBb
         jWdfL3nZ87HgK+1FAem1kMfCUXRn1WjjC9AAFnqYtK0I1p+oRjpDXJsfalm+p3/eLn8C
         WrMbl8gl3DoROjid3ImGzAn7X15J7/rVpGIG8ZNp/oT+WM+gxxdfAq4r6IgK8aOONfhr
         Zslmn7BuMTcTwhLA7/mjkzb5vNkhou9hRNqCt2LKadqXY6IYPLYwmlC3QF0Y6wGPef5f
         808w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693599746; x=1694204546;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CaD763ZtpqCjyX5Kt9ZHyZcT5Qifqz2EgCV742e6Gak=;
        b=jkXb1USmCPJURaIo9W+EeZjAzbKiIydnTVUAj0denDN8loZS/z5uJyt6VKHHjxidYk
         7jvOlqREDd2QaqWrFY7rHmfZ11Y0ZgdP+ezX4BY+/ZsZNqYkeOwGOOAmlq+mh0KwdQTe
         GrIdX7NiNfyrikoYaZrBNW+aXv7gt8089dDm1DOmdhH08Z9rija9tp/rvJ1NmGB8sAFJ
         rVlqQc1YsAhpbhn3/NkRTiyZIu1Hk/TitUPPM3/g7cjd55Ok6A7ry7u4N9TcexcmAcqq
         h7bN8yt1dFvXQbLFHcPoLU22A9/IrUrpOUd1fCCTAJ7YNmJ0jTIxehm+Jmj0JMrp/mfb
         IwQQ==
X-Gm-Message-State: AOJu0YxCnV0uV+vtB+k7fVXfym70ZPSxGusZgk+EKHtmT6iM08dXLGfR
	fJeP71KI8NrYvSo/4z71SSc=
X-Google-Smtp-Source: AGHT+IH0ZdSdp6Y8vLNLg1WSx+2EWoJqMEPiOnIB6qoFVQa6nhokWZc2hk23SgekL5JkgGHUMLDuMw==
X-Received: by 2002:a17:902:ec84:b0:1b9:d2fc:ba9f with SMTP id x4-20020a170902ec8400b001b9d2fcba9fmr4440316plg.11.1693599745774;
        Fri, 01 Sep 2023 13:22:25 -0700 (PDT)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bd28b9c3ddsm3356511plg.299.2023.09.01.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 13:22:25 -0700 (PDT)
Date: Fri, 01 Sep 2023 13:22:24 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Jiri Olsa <olsajiri@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Martin KaFai Lau <kafai@fb.com>, 
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, 
 KP Singh <kpsingh@chromium.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Hou Tao <houtao1@huawei.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Message-ID: <64f2480035813_346b0208f5@john.notmuch>
In-Reply-To: <ZPGvqOQBwP7vPc+l@krava>
References: <ZO+RQwJhPhYcNGAi@krava>
 <ZO+vetPCpOOCGitL@krava>
 <23cd4ce0-0360-e3c6-6cc9-f597aefb2ab5@huawei.com>
 <1c533412-b192-3868-991a-d35587329803@huawei.com>
 <64f0e7ae869c9_d03ca20847@john.notmuch>
 <64f0f60b1417c_d45ab2086b@john.notmuch>
 <edeee369-974d-3676-cf53-a2ed8c52cea0@huawei.com>
 <ZPGvqOQBwP7vPc+l@krava>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jiri Olsa wrote:
> On Fri, Sep 01, 2023 at 05:10:43PM +0800, Xu Kuohai wrote:
> 
> SNIP
> 
> > > > Trying to come up with some nice fix now.
> > > 
> > > Something like this it fixes the splat, but need to think if it
> > > introduces anything or some better way to do this. Basic idea
> > > is to bump user->refcnt because we have two references to the
> > > skb and want to ensure we really only kfree_skb() the skb
> > > after both references are dropped.
> > > 
> > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > index a0659fc29bcc..6c31eefbd777 100644
> > > --- a/net/core/skmsg.c
> > > +++ b/net/core/skmsg.c
> > > @@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
> > >   static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
> > >                                 u32 off, u32 len, bool ingress)
> > >   {
> > > +       int err = 0;
> > > +
> > >          if (!ingress) {
> > >                  if (!sock_writeable(psock->sk))
> > >                          return -EAGAIN;
> > >                  return skb_send_sock(psock->sk, skb, off, len);
> > >          }
> > > -       return sk_psock_skb_ingress(psock, skb, off, len);
> > > +       skb_get(skb);
> > > +       err = sk_psock_skb_ingress(psock, skb, off, len);
> > > +       if (err < 0)
> > > +               kfree_skb(skb);
> > > +       return err;
> > >   }
> > >   static void sk_psock_skb_state(struct sk_psock *psock,
> > > @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
> > >                  } while (len);
> > >                  skb = skb_dequeue(&psock->ingress_skb);
> > > -               if (!ingress) {
> > > -                       kfree_skb(skb);
> > > -               }
> > > +               kfree_skb(skb);
> > >          }
> > >   end:
> > >          mutex_unlock(&psock->work_mutex);
> > > .
> > 
> > With this fix, the crash is gone.
> 
> +1, same on my setup
> 
> jirka

Sent a patch. Add tested-by and acks if you have time. Thanks!

