Return-Path: <bpf+bounces-8153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D478261E
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 11:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DE1C2048D
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C346AC;
	Mon, 21 Aug 2023 09:15:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3A1C39;
	Mon, 21 Aug 2023 09:14:59 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8444C4;
	Mon, 21 Aug 2023 02:14:58 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so417813466b.2;
        Mon, 21 Aug 2023 02:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692609297; x=1693214097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpG3bxwS+S9drLhaB5/FobyEs+sUxj7iEfo0y874pXk=;
        b=a8j096j1+xDQ1WsG1Fk8KGbcijGj8MCLho+lN2F68bByzv40lzTx3uQfzNA064cdOV
         co2XmofkYCB25He3PPjyAWbdSkxLGv8tLKN5wkNARjb4O4fdHCIv1huHGZ5JCAfIKGTM
         Cx58R14mvjOKu0wqG/rJOmWY4qKfymzNx+1VS+9HP/mCapf9mnVMVhJWDBnY6VMwC32l
         LUQ25OdLCY0NBNfqSr/X7lZh6tfPAmXV2/I9nz0t7sJHao2sUQvpARNHiWAzgH5gYeu3
         xdAuHNlKK87G30Wi5/ySts/nojrhGbMdVvezoAwctMBnOJjHmgrzZjc1IA+aAt9AC1F5
         I8/g==
X-Gm-Message-State: AOJu0YxTrQGTgHI5hbFTFheik0/PmecmrI75kTp+CzdrrwBvqVL2yQd7
	rZ17WVYgV9kU9Bgn5BRSnfA=
X-Google-Smtp-Source: AGHT+IGFic37eOYov7SsTkxzJmjYislTT3nebBTbCkzivHmNuaErR7LQXe3TwD4/wsDnov6EXzZ1sA==
X-Received: by 2002:a17:907:778d:b0:99e:1265:5463 with SMTP id ky13-20020a170907778d00b0099e12655463mr4836781ejc.46.1692609297146;
        Mon, 21 Aug 2023 02:14:57 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id s16-20020a1709067b9000b009932337747esm6170342ejo.86.2023.08.21.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 02:14:56 -0700 (PDT)
Date: Mon, 21 Aug 2023 02:14:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com, martin.lau@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, io-uring@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v3 8/9] io_uring/cmd: BPF hook for getsockopt cmd
Message-ID: <ZOMrD1DHeys0nFwt@gmail.com>
References: <20230817145554.892543-1-leitao@debian.org>
 <20230817145554.892543-9-leitao@debian.org>
 <87pm3l32rk.fsf@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm3l32rk.fsf@suse.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:08:47PM -0400, Gabriel Krisman Bertazi wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Add BPF hook support for getsockopts io_uring command. So, BPF cgroups
> > programs can run when SOCKET_URING_OP_GETSOCKOPT command is executed
> > through io_uring.
> >
> > This implementation follows a similar approach to what
> > __sys_getsockopt() does, but, using USER_SOCKPTR() for optval instead of
> > kernel pointer.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  io_uring/uring_cmd.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index a567dd32df00..9e08a14760c3 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -5,6 +5,8 @@
> >  #include <linux/io_uring.h>
> >  #include <linux/security.h>
> >  #include <linux/nospec.h>
> > +#include <linux/compat.h>
> > +#include <linux/bpf-cgroup.h>
> >  
> >  #include <uapi/linux/io_uring.h>
> >  #include <uapi/asm-generic/ioctls.h>
> > @@ -184,17 +186,23 @@ static inline int io_uring_cmd_getsockopt(struct socket *sock,
> >  	if (err)
> >  		return err;
> >  
> > -	if (level == SOL_SOCKET) {
> > +	err = -EOPNOTSUPP;
> > +	if (level == SOL_SOCKET)
> >  		err = sk_getsockopt(sock->sk, level, optname,
> >  				    USER_SOCKPTR(optval),
> >  				    KERNEL_SOCKPTR(&optlen));
> > -		if (err)
> > -			return err;
> >  
> > +	if (!(issue_flags & IO_URING_F_COMPAT))
> > +		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level,
> > +						     optname,
> > +						     USER_SOCKPTR(optval),
> > +						     KERNEL_SOCKPTR(&optlen),
> > +						     optlen, err);
> > +
> > +	if (!err)
> >  		return optlen;
> > -	}
> 
> Shouldn't you call sock->ops->getsockopt for level!=SOL_SOCKET prior to
> running the hook?
> Before this patch, it would bail out with EOPNOTSUPP,
> but now the bpf hook gets called even for level!=SOL_SOCKET, which
> doesn't fit __sys_getsockopt. Am I misreading the code?

Not really, sock->ops->getsockopt() does not suport sockptr_t, but
__user addresses, differently from setsockopt()

          int             (*setsockopt)(struct socket *sock, int level,
                                        int optname, sockptr_t optval,
                                        unsigned int optlen);
          int             (*getsockopt)(struct socket *sock, int level,
                                        int optname, char __user *optval, int __user *optlen);

In order to be able to call sock->ops->getsockopt(), the callback
function will need to accepted sockptr.


