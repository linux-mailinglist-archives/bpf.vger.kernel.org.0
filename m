Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C516ECFEB
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjDXOH1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjDXOH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 10:07:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ECA49D1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:07:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63d4595d60fso28128815b3a.0
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682345245; x=1684937245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZyU9JOMXQEOSCpn+vhOsbvUb6J3MNwqDeTbvCBFgsY=;
        b=SL5aVoOYkL9p1It232dVUK9sJ2nBFnsZd59d0RPBsSV0IXG9wcs7f00eNXGTMh+/ar
         HedDx67i8imKkTX19kH6xOY2kplfRtaLnCq2EMVA1SNLkeNmCW+AHk1CFdk1NJCnq6GT
         rsPDiJdQplho9bx7C9UXhqQspgmNVYUk3gYe0Y3iVjI03S9gWEGO4m+d/w3JqPhgnxyq
         wySfe4fqemOPsowwBcmL9qgsgg+E52Q7FChTcB2Y8EriEY/xXeQwU1QTBw7Rrm/EZQ+W
         m4e6ofEJtYCvnLRo1CvTjd2jHcNDnhiQMOv7sXH7kay7thvZCeHWU7KPrZge6+GImzO/
         GA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345245; x=1684937245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZyU9JOMXQEOSCpn+vhOsbvUb6J3MNwqDeTbvCBFgsY=;
        b=HypDM/e4HUdiluOEiQFTzjhFhO0m+GhXfznvGIv+QJSYr3BE6vAbybWdRj7/ZtVQD7
         lP41S8MeEiV+Gmu/hwUgM44SWbQ1gI+4d83M8hbRNQqWJ3IEuPTeaDrCow1zzexMFXAf
         7Bk0iUOr+OBLW54a+i37svrQJBwbCqH4z1d3j5Uab1fC7aAsJIocMLq/JMh0Fr7pIAs9
         nKe1kTPC++liBmBjuagwqaODfosO1vpdbFE4JmChHfBoBry77QMoV0+6CF2OLfT2qNPR
         UUR2Q1V3neJ0aY+UF8OliiDQ5FU8SAXAazTB71EhLn1DCJ0i182vbbl7AjLWVVQvw93C
         hATw==
X-Gm-Message-State: AAQBX9f4HbwrYUH5xJfU/HUJ0uGWkwgtcumdM7zAzjSBDHwHS21RINAc
        wyu6mIbU6Es4CavuHKD7vkSkY3CL8STTCALT10g=
X-Google-Smtp-Source: AKy350bwFPrsz3PmdkesjJAYTepEJB3lD4bXKIocdzIf0Z3c+fLMs1V1j+JnhTsfNMklLRwcXm/w0iwKXgjA6cqFJQE=
X-Received: by 2002:a17:90b:1906:b0:23d:54e8:3bb7 with SMTP id
 mp6-20020a17090b190600b0023d54e83bb7mr16548341pjb.17.1682345244750; Mon, 24
 Apr 2023 07:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-6-daan.j.demeyer@gmail.com> <20230421210135.v4msbkuj433j75g4@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230421210135.v4msbkuj433j75g4@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Mon, 24 Apr 2023 16:07:13 +0200
Message-ID: <CAO8sHcnE6rBTdMJv7Z8oB81wJODH5+j8tKpYKrc8esxd8AMRsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_sock_addr_set
> On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> > As prep for adding unix socket support to the cgroup sockaddr hooks,
> > let's add a kfunc bpf_sock_addr_set() that allows modifying the
> > sockaddr length from bpf. This is required to allow modifying AF_UNIX
> > sockaddrs correctly.
> >
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 44fb997434ad..1c656e2d7b58 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -81,6 +81,7 @@
> >  #include <net/xdp.h>
> >  #include <net/mptcp.h>
> >  #include <net/netfilter/nf_conntrack_bpf.h>
> > +#include <linux/un.h>
> >
> >  static const struct bpf_func_proto *
> >  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> > @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> >
> >       return 0;
> >  }
> > +
> > +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> > +                               const void *addr, u32 addrlen__sz)
>
> I think the verifier doesn't check validity of void* pointer for kfuncs.
> Should it be 'struct sockaddr_un *' ?

I had to make it 'void *' because the __sz tag only works on void
pointers. If it should be 'struct sockaddr_un *', how do I make the
addrlen__sz tag work properly?

> > +{
> > +     const struct sockaddr *sa = addr;
> > +
> > +     if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> > +             return -EINVAL;
> > +
> > +     if (addrlen__sz > sizeof(struct sockaddr_storage))
> > +             return -EINVAL;
> > +
> > +     if (sa->sa_family != sa_kern->uaddr->sa_family)
> > +             return -EINVAL;
> > +
> > +     switch (sa->sa_family) {
> > +     case AF_INET:
> > +             if (addrlen__sz < sizeof(struct sockaddr_in))
> > +                     return -EINVAL;
> > +             break;
> > +     case AF_INET6:
> > +             if (addrlen__sz < SIN6_LEN_RFC2133)
> > +                     return -EINVAL;
> > +             break;
> > +     case AF_UNIX:
> > +             if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> > +                 addrlen__sz > sizeof(struct sockaddr_un))
> > +                     return -EINVAL;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     memcpy(sa_kern->uaddr, sa, addrlen__sz);
> > +     sa_kern->uaddrlen = addrlen__sz;
> > +
> > +     return 0;
> > +}
> >  __diag_pop();
> >
> >  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> > @@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
> >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> >  BTF_SET8_END(bpf_kfunc_check_set_xdp)
> >
> > +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> > +BTF_ID_FLAGS(func, bpf_sock_addr_set)
>
> It probably needs KF_TRUSTED_ARGS.

If I understand the documentation of `KF_TRUSTED_ARGS` correctly, this
wouldn't allow me to pass arbitrary sockaddr structs into
bpf_sock_addr_set() anymore since those wouldn't be trusted?


On Fri, 21 Apr 2023 at 23:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> > As prep for adding unix socket support to the cgroup sockaddr hooks,
> > let's add a kfunc bpf_sock_addr_set() that allows modifying the
> > sockaddr length from bpf. This is required to allow modifying AF_UNIX
> > sockaddrs correctly.
> >
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 44fb997434ad..1c656e2d7b58 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -81,6 +81,7 @@
> >  #include <net/xdp.h>
> >  #include <net/mptcp.h>
> >  #include <net/netfilter/nf_conntrack_bpf.h>
> > +#include <linux/un.h>
> >
> >  static const struct bpf_func_proto *
> >  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> > @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> >
> >       return 0;
> >  }
> > +
> > +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> > +                               const void *addr, u32 addrlen__sz)
>
> I think the verifier doesn't check validity of void* pointer for kfuncs.
> Should it be 'struct sockaddr_un *' ?
>
> > +{
> > +     const struct sockaddr *sa = addr;
> > +
> > +     if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> > +             return -EINVAL;
> > +
> > +     if (addrlen__sz > sizeof(struct sockaddr_storage))
> > +             return -EINVAL;
> > +
> > +     if (sa->sa_family != sa_kern->uaddr->sa_family)
> > +             return -EINVAL;
> > +
> > +     switch (sa->sa_family) {
> > +     case AF_INET:
> > +             if (addrlen__sz < sizeof(struct sockaddr_in))
> > +                     return -EINVAL;
> > +             break;
> > +     case AF_INET6:
> > +             if (addrlen__sz < SIN6_LEN_RFC2133)
> > +                     return -EINVAL;
> > +             break;
> > +     case AF_UNIX:
> > +             if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> > +                 addrlen__sz > sizeof(struct sockaddr_un))
> > +                     return -EINVAL;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     memcpy(sa_kern->uaddr, sa, addrlen__sz);
> > +     sa_kern->uaddrlen = addrlen__sz;
> > +
> > +     return 0;
> > +}
> >  __diag_pop();
> >
> >  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> > @@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
> >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> >  BTF_SET8_END(bpf_kfunc_check_set_xdp)
> >
> > +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> > +BTF_ID_FLAGS(func, bpf_sock_addr_set)
>
> It probably needs KF_TRUSTED_ARGS.
