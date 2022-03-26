Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E24E8291
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiCZRGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Mar 2022 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiCZRGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 13:06:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5B4506A
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:05:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 9so9183312iou.5
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZJU8une40WGO2R7CknHWq+PlrxhGgwYNjPLugaOjZE=;
        b=LQ2aLb4mewEDcfWxNUUoCi33fj420yZU8xzpFEGm1k1jrq9oTPVsBsxz//RtNdU4Xh
         07CHAr/t0q1nH7UHHqcd+pUKPO/JtWz7iu7scNJzV7LmIru4oFG1RQhMBxnxLuWMP4vg
         CxZx4VwpK0VR/Mq9gF9iLre0rOv+1gMcONW6iJLxWnmP9ikYm+lAZKGgSia2xlyHS81M
         GktQuXhryfO8Ocvul4bxdT7Is3QklCY1L16hKcqj2hC0N+NqJY+24VUjulY3RiA15sLb
         AaVtF28/kg2ZIG3XBj9h5eHwM4QbrMpHxBsOAlsq82d7W1eCqdjiyShW3yjflpGriQHb
         CD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZJU8une40WGO2R7CknHWq+PlrxhGgwYNjPLugaOjZE=;
        b=aSmV+Scy6ZOQ24d+Zorw6TvBOm2B7JmhW3YdWEe/EZaWnqrj6zG8KdRtms3boVmVDx
         SUnMqLQqaPcW8/W6d/xeQ1fZEsU9Fque0MOZEY0EydNGvszWt/z/LyXtP9eGoy7+WZ65
         WTCMjjzydf3yg6RMnoxB6b7TMkHD6H8+tvjAWsRfHVr2lA+28owXRidCGPY0A1JIAZuQ
         c6BbAbdqdOl9ZnsFGMgLk8s6gJ/1xS9C5CRQ4EWMPI3WgJdYnnsbg4x7nTdY8CaDzGCK
         mGB9HNeoqLhJlP8LY4XRlm5NOOxbwql5VwCbtS27ZxnNXATLW35/JQJjsjDh6Rq/pw67
         fgIQ==
X-Gm-Message-State: AOAM533JZrTI4LA58D135CZSTENMAYBrvwWg+Bc8sXIxE1whp7ItKTXG
        tGsFPaFy9ALMYkA+6nmRJHLvAy9tjsB+Fn+dm9JBZaxXyre5l/Bp
X-Google-Smtp-Source: ABdhPJzjY6UlpbmTfsV8NzrV/fJwZwbnbkCo+TNPlCpK4iKikshhitush76l9ULiYmUzgiPpiqqDhoD1/Xk9FgiU5EM=
X-Received: by 2002:a05:6638:25c2:b0:321:6c85:ffe4 with SMTP id
 u2-20020a05663825c200b003216c85ffe4mr8232534jat.275.1648314309962; Sat, 26
 Mar 2022 10:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-3-fankaixi.li@bytedance.com> <1e206112-c610-d4e5-1ab6-e78ea3e2dcea@fb.com>
In-Reply-To: <1e206112-c610-d4e5-1ab6-e78ea3e2dcea@fb.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Sun, 27 Mar 2022 01:04:58 +0800
Message-ID: <CAEEdnKEF=EfiXsQX7HgPbj2Fz2Un2km1nb=SgK8uNNYxsP05cw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 2/3] selftests/bpf: add ipv4 vxlan
 tunnel source testcase
To:     Yonghong Song <yhs@fb.com>
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8826=E6=97=A5=E5=
=91=A8=E5=85=AD 00:41=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> > From: "kaixi.fan" <fankaixi.li@bytedance.com>
> >
> > Vxlan tunnel is chosen to test bpf code could configure tunnel
> > source ipv4 address.
>
> The added test configures tunnel source ipv4 address.
>
>  >It's sufficient to prove that other types
> > tunnels could also do it.
>
> Could you be more specific what other types will also use source ipv4
> address. It is too vague to claim "it's sufficient to prove ...".
>

Is it better to add more test cases for other types of ip tunnels ? It woul=
d
introduce more duplicate codes.

In the kernel, this is referred to as collect metadata mode as follows:
https://man7.org/linux/man-pages/man8/ip-link.8.html
Kernel use "struct ip_tunnel_info" to save tunnel parameters, and use
it for tunnel encapsulation. The process is similar for vxlan, gre,/gretap,
geneve, ipip and erspan tunnels.
The previous test cases in "test_tunnel.sh" test this mechanism for bpf
program code already.  Based on this mechanism, I just use vxlan tunnel
to test tunnel source ip configuration.

>
> > In the vxlan tunnel testcase, two underlay ipv4 addresses
> > are configured on veth device in root namespace. Test bpf kernel
> > code would configure the secondary ipv4 address as the tunnel
> > source ip.
> >
> > Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
>
> Again, please use proper name in Signed-off-by tag.

Thanks. I will fix it.

>
> > ---
> >   .../selftests/bpf/progs/test_tunnel_kern.c    | 64 ++++++++++++++++++=
+
> >   tools/testing/selftests/bpf/test_tunnel.sh    | 37 ++++++++++-
> >   2 files changed, 99 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/too=
ls/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index ef0dde83b85a..ab635c55ae9b 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -676,4 +676,68 @@ int _xfrm_get_state(struct __sk_buff *skb)
> >       return TC_ACT_OK;
> >   }
> >
> > +SEC("vxlan_set_tunnel_src")
> > +int _vxlan_set_tunnel_src(struct __sk_buff *skb)
> > +{
> > +     int ret;
> > +     struct bpf_tunnel_key key;
> > +     struct vxlan_metadata md;
> > +
> > +     __builtin_memset(&key, 0x0, sizeof(key));
> > +     key.local_ipv4 =3D 0xac100114; /* 172.16.1.20 */
> > +     key.remote_ipv4 =3D 0xac100164; /* 172.16.1.100 */
> > +     key.tunnel_id =3D 2;
> > +     key.tunnel_tos =3D 0;
> > +     key.tunnel_ttl =3D 64;
> > +
> > +     ret =3D bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> > +                                  BPF_F_ZERO_CSUM_TX);
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     md.gbp =3D 0x800FF; /* Set VXLAN Group Policy extension */
> > +     ret =3D bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     return TC_ACT_OK;
> > +}
> > +
> > +SEC("vxlan_get_tunnel_src")
> > +int _vxlan_get_tunnel_src(struct __sk_buff *skb)
> > +{
> > +     int ret;
> > +     struct bpf_tunnel_key key;
> > +     struct vxlan_metadata md;
> > +     char fmt[] =3D "key %d remote ip 0x%x source ip 0x%x\n";
> > +     char fmt2[] =3D "vxlan gbp 0x%x\n";
> > +
> > +     ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     ret =3D bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     bpf_trace_printk(fmt, sizeof(fmt),
> > +                      key.tunnel_id, key.remote_ipv4, key.local_ipv4);
> > +     bpf_trace_printk(fmt2, sizeof(fmt2),
>
> In bpf_helpers.h, bpf_printk can be used instead of bpf_trace_printk.
>
> > +                      md.gbp);
> > +
> > +     if (key.local_ipv4 !=3D 0xac100114) {
>
> I would suggest to make 0xac100114 a macro, so both set_* and get_*
> programs can use the same macro, which makes it easier to understand
> and check.

OK. I will replace it with a macro.

>
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +     return TC_ACT_OK;
> > +}
> > +
> [...]
