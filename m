Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A224E363B
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 02:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiCVBzd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 21:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCVBzb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 21:55:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999A42EFF
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:54:04 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j15so1383550ila.13
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MRY9DQu4LYrr0wnyDc1sOlLiPqdcmZSNQVrmdBH1w9I=;
        b=Txd3IGAANmeqq/eqrVoUyr2s30sztKa08G+/7LLnwRe4eqiAoBivRuzm7qEWC0sDzl
         gLMpQzOB7gh9AvdgkG0ilmLxPiPlzQMeSSMPExrFqEU2sk/aa1m058kpgb6Btq/k103n
         YlEWtgKPnAaZNySWZgCB6dM19ZN8EIzuKShesufuXP3jv/DyJoQ9FAZ4kmJWxLsABCzC
         w+SegIiGMEdlLvMIgs6986z0Jp+NYrNJ0klNNqEc9ssSammkbUsQWLn7szSYc4xJSxvV
         NaaG/8Gml+R855JsKfambLRQkv7/47kVaMVPDv388XXlCTVe7LOivbR98QY77olYYFRM
         YFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MRY9DQu4LYrr0wnyDc1sOlLiPqdcmZSNQVrmdBH1w9I=;
        b=AEnYE4I33c60aVmHUb7bgaaBakezwgdPj/Qijc/KstwDkTETu+Db+jISlIMHDoaUjV
         C8FxlxFnhOFSG6XBo2ztY2CaVm7PHuJGyAec8N7sMKsAHU2CvgHkITux+6AYx6ZSf6+J
         nFCs2SXEH8Uk8eOoPgYxrDPJQn72DFMxT56Y0UEPMQqdkhS+Of6SzekyN5X6/VF/WjFI
         YaPnDxfs0qIUiJCIsFh3Ff/PkvRvD3Kv7Kl0TBUCR79uF+sU+U13CpUJkHRPoPRAX8gU
         PNFbGJ1V5nVTspGeSndI53P7MDgjnhq9PS6UFmABPYHsI5ooZJd2kHuKO2ZQaf4DAqrQ
         Na3g==
X-Gm-Message-State: AOAM533TeHne0DJtBBvf26TTlnRPLPOypaVWRY181cvruFUZjQFukfCC
        bzWFU1YnlKcidU0UvqL0i+1kgwU8tG4yabbNo+zTcQ==
X-Google-Smtp-Source: ABdhPJxp9GQPkbSaptdTlplQBXXJn5OdQqbRSQI6e8j5H/q0MB+SImBYf0h49VtVNvVDfackXGRfgq0AmrQiQv0R5b4=
X-Received: by 2002:a92:7d08:0:b0:2c2:d72c:62bf with SMTP id
 y8-20020a927d08000000b002c2d72c62bfmr11731561ilc.167.1647914043810; Mon, 21
 Mar 2022 18:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220319130538.55741-1-fankaixi.li@bytedance.com>
 <20220319130538.55741-4-fankaixi.li@bytedance.com> <20220322003317.m52ylgsw4xaivasx@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220322003317.m52ylgsw4xaivasx@kafai-mbp.dhcp.thefacebook.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Tue, 22 Mar 2022 09:53:52 +0800
Message-ID: <CAEEdnKFqk5bdvEr=bcnmfrAhd_4suvhitBGtAZyqCb7r_Fp++g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=8C 08:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 19, 2022 at 09:05:38PM +0800, fankaixi.li@bytedance.com wrote=
:
> > From: "kaixi.fan" <fankaixi.li@bytedance.com>
> >
> > Add two ipv6 address on underlay nic interface, and use bpf code to
> > configure the secondary ipv6 address as the vxlan tunnel source ip.
> > Then check ping6 result and log contains the correct tunnel source
> > ip.
> >
> > Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> > ---
> >  .../selftests/bpf/progs/test_tunnel_kern.c    | 46 ++++++++++++
> >  tools/testing/selftests/bpf/test_tunnel.sh    | 71 +++++++++++++++----
> >  2 files changed, 105 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/too=
ls/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index 4a39556ef609..67cb7ca3e083 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -736,4 +736,50 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
> >       return TC_ACT_OK;
> >  }
> >
> > +SEC("ip6vxlan_set_tunnel_src")
> > +int _ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
> > +{
> > +     struct bpf_tunnel_key key;
> > +     int ret;
> > +
> > +     __builtin_memset(&key, 0x0, sizeof(key));
> > +     key.local_ipv6[3] =3D bpf_htonl(0xbb); /* ::bb */
> > +     key.remote_ipv6[3] =3D bpf_htonl(0x11); /* ::11 */
> > +     key.tunnel_id =3D 22;
> > +     key.tunnel_tos =3D 0;
> > +     key.tunnel_ttl =3D 64;
> > +
> > +     ret =3D bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> > +                                  BPF_F_TUNINFO_IPV6);
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     return TC_ACT_OK;
> > +}
> > +
> > +SEC("ip6vxlan_get_tunnel_src")
> > +int _ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
> > +{
> > +     char fmt[] =3D "key %d remote ip6 ::%x source ip6 ::%x\n";
> > +     char fmt2[] =3D "label %x\n";
> > +     struct bpf_tunnel_key key;
> > +     int ret;
> > +
> > +     ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
> > +                                  BPF_F_TUNINFO_IPV6);
> > +     if (ret < 0) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     bpf_trace_printk(fmt, sizeof(fmt),
> > +                      key.tunnel_id, key.remote_ipv6[3], key.local_ipv=
6[3]);
> > +     bpf_trace_printk(fmt2, sizeof(fmt2),
> > +                      key.tunnel_label);
> How is the printk output used?  Is the output text verified in the
> test_tunnel.sh?
> Can the values be checked in the bpf prog itself to avoid the printk?
>
> The same goes for the patch 2.
>
> > +
> > +     return TC_ACT_OK;
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing=
/selftests/bpf/test_tunnel.sh
> > index 62ef5c998b6a..a0f9a5c5e0a5 100755
> > --- a/tools/testing/selftests/bpf/test_tunnel.sh
> > +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> > @@ -67,6 +67,11 @@ add_second_ip()
> >    ip addr add dev veth1 172.16.1.20/24
> >  }
> >
> > +add_second_ip6()
> > +{
> > +  ip addr add dev veth1 ::bb/96
> > +}
> > +
> >  add_gre_tunnel()
> >  {
> >       # at_ns0 namespace
> > @@ -94,7 +99,7 @@ add_ip6gretap_tunnel()
> >       # at_ns0 namespace
> >       ip netns exec at_ns0 \
> >               ip link add dev $DEV_NS type $TYPE seq flowlabel 0xbcdef =
key 2 \
> > -             local ::11 remote ::22
> > +             local ::11 remote $REMOTE_IP6
> >
> >       ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
> >       ip netns exec at_ns0 ip addr add dev $DEV_NS fc80::100/96
> > @@ -143,7 +148,7 @@ add_ip6erspan_tunnel()
> >       if [ "$1" =3D=3D "v1" ]; then
> >               ip netns exec at_ns0 \
> >               ip link add dev $DEV_NS type $TYPE seq key 2 \
> > -             local ::11 remote ::22 \
> > +             local ::11 remote $REMOTE_IP6 \
> afaict, only add_ip6vxlan_tunnel needs something other than ::22,
> so this and other similar code churns is not necessary?
>
> >               erspan_ver 1 erspan 123
> >       else
> >               ip netns exec at_ns0 \
> > @@ -196,7 +201,7 @@ add_ip6vxlan_tunnel()
> >       # at_ns0 namespace
> >       ip netns exec at_ns0 \
> >               ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
> > -             local ::11 remote ::22
> > +             local ::11 remote $REMOTE_IP6
> Can it be an optional argument instead and default to ::22 ?
>
> Also, using $1 is as good?
>
> [ ... ]
>
> > +test_ip6vxlan_tunsrc()
> > +{
> > +     TYPE=3Dvxlan
> > +     DEV_NS=3Dip6vxlan00
> > +     DEV=3Dip6vxlan11
> > +     REMOTE_IP6=3D::bb
> > +     ret=3D0
> > +
> > +     check $TYPE
> > +     config_device
> > +     add_second_ip6
> > +     add_ip6vxlan_tunnel $REMOTE_IP6
> here.  It seems most of the patch needs is
>         add_ip6vxlan_tunnel '::bb'
>
> > +     ip link set dev veth1 mtu 1500
> > +     attach_bpf $DEV ip6vxlan_set_tunnel_src ip6vxlan_get_tunnel_src
> > +     # underlay
> > +     ping6 $PING_ARG ::11
> > +     # ip4 over ip6
> > +     ping $PING_ARG 10.1.1.100
> > +     check_err $?
> > +     ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> > +     check_err $?
> > +     cleanup
> > +
> > +     if [ $ret -ne 0 ]; then
> > +                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
> > +                return 1
> > +        fi
> > +        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
> > +}
> > +
> >  attach_bpf()
> >  {
> >       DEV=3D$1
> > @@ -818,6 +860,11 @@ bpf_tunnel_test()
> >       test_vxlan_tunsrc
> >       errors=3D$(( $errors + $? ))
> >
> > +
> > +     echo "Testing IP6VXLAN tunnel source..."
> > +     test_ip6vxlan_tunsrc
> > +     errors=3D$(( $errors + $? ))
> > +
> >       return $errors
> >  }
> >
> > --
> > 2.24.3 (Apple Git-128)
> >

Thanks.
Maybe it's better to attach a bpf prog to the ingress of tunnel device
in namespace "at_ns0". This prog could be used to check the tunnel
source ip.
"add_ip6vxlan_tunnel" and "add_vxlan_tunnel" would be reflected to
accept an argument as tunnel remote ip.
