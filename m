Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CB6EF5D5
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbjDZNvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjDZNvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 09:51:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDF4EED
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 06:51:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51f3289d306so5473210a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682517105; x=1685109105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vWEEKljON2sGAw/7PC99Tu5OIzl1UtmmKYBcwZ0a++g=;
        b=a16/FoQYmGNP93enfHEveaapy6JmhGPBjwSQHuIwSXmWcztfkN3jZfn4euBabNotzF
         JfJvH+buqFj6v1oF725QTl3oIfmIx1rx/U3gsN/0hmdWdf92/99yW1EtOKPWmgNGAgio
         5+qG2ykl5GNQvQ06fiq7IMlZbmUXOWP5qUIe2io9OfAu3Y3hrWhHDmHkpzFqlcl4s07E
         0qRsm0UarxUlEhe2MTYNLGH0fel0WTCny4KHSUDZR3oD144uxr/yE7taeo4mdCbksTPw
         LL6/IozL1YOtc6LjT/IXvga6XQLJpIVWolQRBlrtdmPevcL9Fb85LVb8G5cRvqwH0FQ+
         iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517105; x=1685109105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWEEKljON2sGAw/7PC99Tu5OIzl1UtmmKYBcwZ0a++g=;
        b=H+zllMqPzDEYuv2yZk7yk4psZhxIS3OTOkYPwx91DX0+SSFyhRyaiA9J3LXf607ayy
         iH4P7B2k7Xf8SQFyXpyawF65SYZ0ej54mV6BCPY4dQXh7uwEvJqtl3DTol5fOmqQpLnw
         hLgNNYkTIjLFyAkLGASgwpiDyl+8/MsZ6oFeUAdlZpnclvYOt2Pwf8wTUZDvNKB8/nAW
         WxDYVlQlirQPUV15lKXi9F8JMgGid/tWoK90V5TSql/BFadCjLwZTEfVcLeI5+83KMlx
         912zseNHaLbeR8wsU9dE3jjNAPY3vZDTvzeJC/BG8SB7fHoN/nbUrkMb8lmDUw3tMWSU
         he9Q==
X-Gm-Message-State: AAQBX9e8oXLxb69K2gGuWmZGwEtzqmHIGXgVe7XR3eCgXrt2wLjd/Cqz
        jXpl3lHSZCZ44pV4XDBc/T4CneBcJgllmOAzP2w=
X-Google-Smtp-Source: AKy350Y6jSHNyCKWXu7FlonbjkXGDa3jio/Pqd6WcfMBFOFM+JLMPmutd/rxrp38hL6BKMPUxWWz7LuSGKLgn8Jw3yc=
X-Received: by 2002:a17:90b:344:b0:246:c097:6a17 with SMTP id
 fh4-20020a17090b034400b00246c0976a17mr21589015pjb.24.1682517105452; Wed, 26
 Apr 2023 06:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-6-daan.j.demeyer@gmail.com> <20230421210135.v4msbkuj433j75g4@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAO8sHcnE6rBTdMJv7Z8oB81wJODH5+j8tKpYKrc8esxd8AMRsA@mail.gmail.com> <20230426001004.nn6dyugtwsgn5e2c@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230426001004.nn6dyugtwsgn5e2c@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Wed, 26 Apr 2023 15:51:34 +0200
Message-ID: <CAO8sHcm8=VftqpGnLcZ-QoEu0m3xkeyhj6g5BkJ9bCvAxK_nRw@mail.gmail.com>
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

> On Mon, Apr 24, 2023 at 04:07:13PM +0200, Daan De Meyer wrote:
> > bpf_sock_addr_set
> > > On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> > > > As prep for adding unix socket support to the cgroup sockaddr hooks,
> > > > let's add a kfunc bpf_sock_addr_set() that allows modifying the
> > > > sockaddr length from bpf. This is required to allow modifying AF_UNIX
> > > > sockaddrs correctly.
> > > >
> > > > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > > > ---
> > > >  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 51 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 44fb997434ad..1c656e2d7b58 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -81,6 +81,7 @@
> > > >  #include <net/xdp.h>
> > > >  #include <net/mptcp.h>
> > > >  #include <net/netfilter/nf_conntrack_bpf.h>
> > > > +#include <linux/un.h>
> > > >
> > > >  static const struct bpf_func_proto *
> > > >  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> > > > @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> > > >
> > > >       return 0;
> > > >  }
> > > > +
> > > > +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> > > > +                               const void *addr, u32 addrlen__sz)
> > >
> > > I think the verifier doesn't check validity of void* pointer for kfuncs.
> > > Should it be 'struct sockaddr_un *' ?
> >
> > I had to make it 'void *' because the __sz tag only works on void
> > pointers.
>
> Why do you think so?
>
> __bpf_kfunc struct nf_conn___init *
> bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
>                  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
>                    enum hid_report_type rtype, enum hid_class_request reqtype)
> KF_TRUSTED_ARGS won't allow legacy and untrusted PTR_TO_BTF_ID to
> be passed into as 1st arg == struct bpf_sock_addr_kern *.

Because of the following check in get_kfunc_ptr_arg_type():

if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env,
meta->btf, ref_t, 0) &&
(arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
        verbose(env, "arg#%d pointer type %s %s must point to
%sscalar, or struct with scalar\n",
        argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
        return -EINVAL;
}

I was hitting this error when addr was sockaddr_un * instead of void
*. Will KF_TRUSTED_ARGS
bypass that check?


On Wed, 26 Apr 2023 at 02:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 24, 2023 at 04:07:13PM +0200, Daan De Meyer wrote:
> > bpf_sock_addr_set
> > > On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> > > > As prep for adding unix socket support to the cgroup sockaddr hooks,
> > > > let's add a kfunc bpf_sock_addr_set() that allows modifying the
> > > > sockaddr length from bpf. This is required to allow modifying AF_UNIX
> > > > sockaddrs correctly.
> > > >
> > > > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > > > ---
> > > >  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 51 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 44fb997434ad..1c656e2d7b58 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -81,6 +81,7 @@
> > > >  #include <net/xdp.h>
> > > >  #include <net/mptcp.h>
> > > >  #include <net/netfilter/nf_conntrack_bpf.h>
> > > > +#include <linux/un.h>
> > > >
> > > >  static const struct bpf_func_proto *
> > > >  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> > > > @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> > > >
> > > >       return 0;
> > > >  }
> > > > +
> > > > +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> > > > +                               const void *addr, u32 addrlen__sz)
> > >
> > > I think the verifier doesn't check validity of void* pointer for kfuncs.
> > > Should it be 'struct sockaddr_un *' ?
> >
> > I had to make it 'void *' because the __sz tag only works on void
> > pointers.
>
> Why do you think so?
>
> __bpf_kfunc struct nf_conn___init *
> bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
>                  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
>                    enum hid_report_type rtype, enum hid_class_request reqtype)
>
> > If it should be 'struct sockaddr_un *', how do I make the
> > addrlen__sz tag work properly?
> >
> > > > +{
> > > > +     const struct sockaddr *sa = addr;
> > > > +
> > > > +     if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (addrlen__sz > sizeof(struct sockaddr_storage))
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (sa->sa_family != sa_kern->uaddr->sa_family)
> > > > +             return -EINVAL;
> > > > +
> > > > +     switch (sa->sa_family) {
> > > > +     case AF_INET:
> > > > +             if (addrlen__sz < sizeof(struct sockaddr_in))
> > > > +                     return -EINVAL;
> > > > +             break;
> > > > +     case AF_INET6:
> > > > +             if (addrlen__sz < SIN6_LEN_RFC2133)
> > > > +                     return -EINVAL;
> > > > +             break;
> > > > +     case AF_UNIX:
> > > > +             if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> > > > +                 addrlen__sz > sizeof(struct sockaddr_un))
> > > > +                     return -EINVAL;
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     memcpy(sa_kern->uaddr, sa, addrlen__sz);
> > > > +     sa_kern->uaddrlen = addrlen__sz;
> > > > +
> > > > +     return 0;
> > > > +}
> > > >  __diag_pop();
> > > >
> > > >  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> > > > @@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
> > > >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> > > >  BTF_SET8_END(bpf_kfunc_check_set_xdp)
> > > >
> > > > +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> > > > +BTF_ID_FLAGS(func, bpf_sock_addr_set)
> > >
> > > It probably needs KF_TRUSTED_ARGS.
> >
> > If I understand the documentation of `KF_TRUSTED_ARGS` correctly, this
> > wouldn't allow me to pass arbitrary sockaddr structs into
> > bpf_sock_addr_set() anymore since those wouldn't be trusted?
>
> KF_TRUSTED_ARGS won't allow legacy and untrusted PTR_TO_BTF_ID to
> be passed into as 1st arg == struct bpf_sock_addr_kern *.
