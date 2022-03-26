Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A24E8314
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 18:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiCZR0U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Mar 2022 13:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiCZR0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 13:26:19 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA821160177
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:24:42 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d3so7206276ilr.10
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vIy9cddiv9IOW7sSdvGDPtHMIijaLTSl8mxxQCpzTaI=;
        b=FNg/dctHcbdnZfYvT3oqMtOpxYEloYbgdZfD5jaVDP4p2yHmyhqcQT/M7v2x3AJ13+
         tqgytJOJCC0AXi7iVcyUczLycyCi904V1Ywe/b2uf2rpEzx552hNYpotPfk8NMZm2DGG
         s3zK90y2bThzU1T+jwzIFeAESPfhqxFK9gX5iyYOQfa1qdcSK9bU7R2+sZ3IiFU8pAUN
         A38XGD26E6yCYnjR1gxBuhd3Wv2k/1Pnj0eBY+IoulfCcypGV5mu5as9SERl0Q1ImvQj
         cILRdoZc6aEdd3kGke7RcW9c+Wf7xIH93YCRaOSDbmmgLoi4rnVPpWPrcY/JWcV+QfaZ
         PHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vIy9cddiv9IOW7sSdvGDPtHMIijaLTSl8mxxQCpzTaI=;
        b=EOwRpj/Ssj4hoEMNRy+QpSrep/9Tred++TQnvzF54+lDp4Y4HvK49F+DgVvEsYj/Il
         DnSfZF9PluahbKfJXKtUwS2gahf6B3+IRD1adu4Mq+pwyRD9NJMN0GRMR/GkrzQ9rSfp
         EVOqsxIokiaszotL+/tP/s2e1iBV2VTvtc5JopSJhR62PUUzu78vM86R8E9HIPItm/03
         ljAxA8/hEFNOnjiPRunqzR9T6vsYNSat4IcKms4aQhzFYfhlO6SUniUNocyxp4L3XAjH
         q3xAvsUOBFR4x7u+4I3EkRsXM3uS2hpGe3b8CilzKYPWxIlK02u3fcjg9v0j92Jr07JE
         DTIQ==
X-Gm-Message-State: AOAM531XYDcnAhUEomrg3wJnylpJMS7LUyDU2uvQybAnFQ9+m3mQexcf
        oPYNMoZU0o4RANcHIXgnv1OKJ6z0GV47Y72nVSK7Sw==
X-Google-Smtp-Source: ABdhPJwbF5Gs+rUKG/MilCf7ZL+bnF4QHRy68VF4s05fgFtkAnthgOW4Ju/8Fiyn+W1/5x8KmwQwyHWb3z5xZ1fAghQ=
X-Received: by 2002:a05:6e02:19cd:b0:2c7:c621:3da with SMTP id
 r13-20020a056e0219cd00b002c7c62103damr1961153ill.130.1648315482146; Sat, 26
 Mar 2022 10:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com> <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
In-Reply-To: <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Sun, 27 Mar 2022 01:24:30 +0800
Message-ID: <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
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

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=BA=94 03:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 22, 2022 at 11:42:31PM +0800, fankaixi.li@bytedance.com wrote=
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
> >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
> >  tools/testing/selftests/bpf/test_tunnel.sh    | 43 ++++++++++++++--
> >  2 files changed, 90 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/too=
ls/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index ab635c55ae9b..56e1aee0ba5a 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -740,4 +740,55 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
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
> Going back to the same comment on v1.
>
> How is this printk used?
> Especially for the most common test PASS case,
> afaict, this will be ignored and left in the trace buffer?
>
> Can it only printk when it detects error? like only print
> when it fails the !=3D 0xbb test case below?
>
> Also, a nit, try to use bpf_printk() instead.
>
> Some existing tunnel tests have printk but those are older examples
> when test_progs.c was not ready.  In the future, we may want
> to move these tunnel tests to test_progs.c where most of the tests
> don't printk/grep also and use global variables or map to check and
> only printF on unexpected values.  Thus, it may as well
> have this new test steering into this direction in term
> of only print on error.
>

Thanks. I would use bpf_printk().
For tunnel source test cases, printF would only be used for errors. And I
will use macros for tunnel ip addresses based on Yonghong's suggestion.

> > +
> > +     if (bpf_ntohl(key.local_ipv6[3]) !=3D 0xbb) {
> > +             ERROR(ret);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     return TC_ACT_OK;
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing=
/selftests/bpf/test_tunnel.sh
> > index b6923392bf16..4b7bf9c7bbe1 100755
> > --- a/tools/testing/selftests/bpf/test_tunnel.sh
> > +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> > @@ -191,12 +191,15 @@ add_ip6vxlan_tunnel()
> >       ip netns exec at_ns0 ip link set dev veth0 up
> >       #ip -4 addr del 172.16.1.200 dev veth1
> >       ip -6 addr add dev veth1 ::22/96
> > +     if [ "$2" =3D=3D "2" ]; then
> > +             ip -6 addr add dev veth1 ::bb/96
> Testing $1 is not "::22" is as good as another $2 arg and
> then $2 is not needed?

Yes. It's more refined now.

>
> > +     fi
> >       ip link set dev veth1 up
> >
> >       # at_ns0 namespace
> >       ip netns exec at_ns0 \
> >               ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
> > -             local ::11 remote ::22
> > +             local ::11 remote $1
> >       ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
> >       ip netns exec at_ns0 ip link set dev $DEV_NS up
> >
> > @@ -231,7 +234,7 @@ add_ip6geneve_tunnel()
> >       # at_ns0 namespace
> >       ip netns exec at_ns0 \
> >               ip link add dev $DEV_NS type $TYPE id 22 \
> > -             remote ::22     # geneve has no local option
> > +             remote ::22    # geneve has no local option
> Unnecessary space change.  Please try to avoid.  This distracts
> the code review.

OK. Sorry for the confusion.

>
> >       ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
> >       ip netns exec at_ns0 ip link set dev $DEV_NS up
> >
> > @@ -394,7 +397,7 @@ test_ip6erspan()
> >
> >       check $TYPE
> >       config_device
> > -     add_ip6erspan_tunnel $1
> > +     add_ip6erspan_tunnel
> What is this change for?
> How is the patch set related to the test_ip6erspan()?
>
> or it is an unrelated clean up? If it is, please use another patch
> in its own cleanup patch set.

Yes and I would separate it into another patch.

>
> >       attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
> >       ping6 $PING_ARG ::11
> >       ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> > @@ -441,7 +444,7 @@ test_ip6vxlan()
> >
> >       check $TYPE
> >       config_device
> > -     add_ip6vxlan_tunnel
> > +     add_ip6vxlan_tunnel ::22 1
> >       ip link set dev veth1 mtu 1500
> >       attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
> >       # underlay
> > @@ -690,6 +693,34 @@ test_vxlan_tunsrc()
> >          echo -e ${GREEN}"PASS: ${TYPE}_tunsrc"${NC}
> >  }
> >
> > +test_ip6vxlan_tunsrc()
> > +{
> > +     TYPE=3Dvxlan
> > +     DEV_NS=3Dip6vxlan00
> > +     DEV=3Dip6vxlan11
> > +     ret=3D0
> > +
> > +     check $TYPE
> > +     config_device
> > +     add_ip6vxlan_tunnel ::bb 2
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
> > +                echo -e ${RED}"FAIL: ip6${TYPE}_tunsrc"${NC}
> > +                return 1
> > +        fi
> > +        echo -e ${GREEN}"PASS: ip6${TYPE}_tunsrc"${NC}
> > +}
> > +
> >  attach_bpf()
> >  {
> >       DEV=3D$1
> > @@ -815,6 +846,10 @@ bpf_tunnel_test()
> >       test_vxlan_tunsrc
> >       errors=3D$(( $errors + $? ))
> >
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
