Return-Path: <bpf+bounces-9103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1D78FADA
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF652819A5
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA03A936;
	Fri,  1 Sep 2023 09:32:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84F881F;
	Fri,  1 Sep 2023 09:32:32 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E214C0;
	Fri,  1 Sep 2023 02:32:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso204983066b.0;
        Fri, 01 Sep 2023 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560747; x=1694165547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crl5smfE8Cc1ZVUnJvSR8ItSRE/y+pm8xpACMYgbcN8=;
        b=ByxFoyCdmEuC/cs1sxXgyzNi0GgvGjjT9rq15+Z6C+btf5GZa8SxmqQLkt7I2zK1K4
         SFePT0I5Oao06UEMjtWs1BK7pWZBS9Fwrz3h4wL4v1UQdGpOyHG0AG2fbAB7vie68+WS
         biyXzKaImQyD8qW+HXqoY1DW9W16u5TrR9ejXDU0JKni6t/FDqJ8AyHBNb63Whjl3fw1
         QZPYsThHf67p5pYiGrJZIVZJi79PzGgp6dqpMM4VEFUk4xogbCLVNCQeFnVJgrQnCJiB
         HaNNERABQpxdzfJXWUlm4aZxQJ8NtGucnTZrIhE7zzkhA1hjlB+y+PZ4Ek3e2Iodh5CU
         cyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560747; x=1694165547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crl5smfE8Cc1ZVUnJvSR8ItSRE/y+pm8xpACMYgbcN8=;
        b=fFQGCrIWZhgq3xAG+KennkrQ+pm9M4+d32qPznb19HspgbbWxqnwrVNOWJgRZ5sH8O
         u23IGLHZnoh1E1uhi8IRlMzuQ325HbFS9xi0+AQyroJTaC7IWUtwM+GhrimWk8urfxG9
         /UimwDVT6YjRguQQnVwhH6rwSvEZnyancZNmFnKg6FWbEmoWoaLyhCFmFcBV6sPDTUh/
         J1Oct8Q4N19PMn46dpZzQMoVNa/RGoLIu2eXYaZRiqNaDWMFjFZO67pbGzXCcEqi4O7G
         NR2XZUfrj3XyTgBMO7PHw/dfZPMHPTHIdJS6d6f89+HGDu8srfcYFbiwtWE+2tC4Dcdt
         6oMg==
X-Gm-Message-State: AOJu0YzTZ0SDVSMxtq+DSDxrFp9ufjJbVJMGZqcKq4TGdj5G9S+tX/Wj
	LN0xZb+alcRYcFErp2Iw3bc=
X-Google-Smtp-Source: AGHT+IEACfLhGRzc8xztgx9R1xFnclZpuMIiUB7jLtYSOqLYHkLw9KsquAY2nw96EnrKiDSKfA5JNg==
X-Received: by 2002:a17:907:784e:b0:9a2:ecd:d963 with SMTP id lb14-20020a170907784e00b009a20ecdd963mr1158422ejc.44.1693560747232;
        Fri, 01 Sep 2023 02:32:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709062dc500b009a2235ed496sm1802249eji.141.2023.09.01.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:32:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Sep 2023 11:32:24 +0200
To: Xu Kuohai <xukuohai@huawei.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
Message-ID: <ZPGvqOQBwP7vPc+l@krava>
References: <ZO+RQwJhPhYcNGAi@krava>
 <ZO+vetPCpOOCGitL@krava>
 <23cd4ce0-0360-e3c6-6cc9-f597aefb2ab5@huawei.com>
 <1c533412-b192-3868-991a-d35587329803@huawei.com>
 <64f0e7ae869c9_d03ca20847@john.notmuch>
 <64f0f60b1417c_d45ab2086b@john.notmuch>
 <edeee369-974d-3676-cf53-a2ed8c52cea0@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edeee369-974d-3676-cf53-a2ed8c52cea0@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 05:10:43PM +0800, Xu Kuohai wrote:

SNIP

> > > Trying to come up with some nice fix now.
> > 
> > Something like this it fixes the splat, but need to think if it
> > introduces anything or some better way to do this. Basic idea
> > is to bump user->refcnt because we have two references to the
> > skb and want to ensure we really only kfree_skb() the skb
> > after both references are dropped.
> > 
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index a0659fc29bcc..6c31eefbd777 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
> >   static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
> >                                 u32 off, u32 len, bool ingress)
> >   {
> > +       int err = 0;
> > +
> >          if (!ingress) {
> >                  if (!sock_writeable(psock->sk))
> >                          return -EAGAIN;
> >                  return skb_send_sock(psock->sk, skb, off, len);
> >          }
> > -       return sk_psock_skb_ingress(psock, skb, off, len);
> > +       skb_get(skb);
> > +       err = sk_psock_skb_ingress(psock, skb, off, len);
> > +       if (err < 0)
> > +               kfree_skb(skb);
> > +       return err;
> >   }
> >   static void sk_psock_skb_state(struct sk_psock *psock,
> > @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
> >                  } while (len);
> >                  skb = skb_dequeue(&psock->ingress_skb);
> > -               if (!ingress) {
> > -                       kfree_skb(skb);
> > -               }
> > +               kfree_skb(skb);
> >          }
> >   end:
> >          mutex_unlock(&psock->work_mutex);
> > .
> 
> With this fix, the crash is gone.

+1, same on my setup

jirka

> 
> I am worried that the skb might be inserted into another skb list before
> skb_dequeue is called, but I can’t find such code, it seems this worry
> is unnecessary.

