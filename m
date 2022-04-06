Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED64F5DAC
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiDFMKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 08:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDFMKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 08:10:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D68752CDFF
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 01:03:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z7so2071116iom.1
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K4/aryaUch903l9YHQnc2btF3jVpYSkKoEpDQCamr88=;
        b=2yVxcigU2NW+c7txU7X9s349oVsgAmK7Bjn6Sioc84KObNLkELuKZT19Q6jXsIBM6S
         hVvWHGDuAsoKIxF0Ims1Z054QLns+fydh/nbtoCdduhKlwwuEoGgdwXnAZXEbDXWYAwj
         TVWoq+0HyhKkDAegxZgTYuZCqR1rP5YFkC6N2TKsGwdgqCV3AU/dflrne3PJ0JRiYan4
         8D9J5gB8blE6ZpJMRTG36O5Q8Q+AxirIrIjmgQbvGbCobG3Drq0mKIxM1BTRgmn28U/d
         SOK2sPcCvBXvT/oiulAgwQ0DkY+0Zji4OEnjKKPc3T4u/XVU5oOJqmZQtu48e2Rd3/Gx
         k4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4/aryaUch903l9YHQnc2btF3jVpYSkKoEpDQCamr88=;
        b=yr60XkGhCRtMiojWRUgF2poAZSWoCJelu5/KBjYugyDqSKhirqD/1oPOeyGZESPA8d
         Gw/T2B/6TpAOIzawOLav8JI94SobCpPLN7qPsYKTeKDRxDr/GNz1PubzTo0TByr4sgTH
         28kLosP+aAFhaPM4VU+Z/SgxCTRYhh8+bbMMyblcll9qlsct39NiLtHFlFAXlwnfIXz3
         SSi7AF7Yj9aCYq6f2hZ4L+64dYd5RCk8KtYGkZ/HuS2kxnT2X8uSZHN7Z1NV5LLa1I4p
         dkfzRI9wtyZdgK8KDh0uGQwDRZWnxudaCLuJAagZT3ZzbrDo8V3Ejox2jELMASPoYw+y
         RTsw==
X-Gm-Message-State: AOAM531zacx3F5TmIQWr5KXrMzZfWObCghKNxsK+6dDNEFfN6ubE5wOA
        a4mz7QPUiA6Qezr+wNxvA7igw1StpNJjkKr0lpLhmQ==
X-Google-Smtp-Source: ABdhPJyu79EKOeek/DTd3y+QgXvfJKcI2OjsYts6SQDXbtei8dRm+HOgmlKlld2QwxxdTL5N0sy0ACequOHQBTj+2ak=
X-Received: by 2002:a05:6638:2512:b0:323:e54d:711 with SMTP id
 v18-20020a056638251200b00323e54d0711mr3771963jat.132.1649232223664; Wed, 06
 Apr 2022 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com> <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
In-Reply-To: <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Wed, 6 Apr 2022 16:03:32 +0800
Message-ID: <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
To:     Martin KaFai Lau <kafai@fb.com>, yhs@fb.com
Cc:     songliubraving@fb.com, john.fastabend@gmail.com,
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

=E8=8C=83=E5=BC=80=E5=96=9C <fankaixi.li@bytedance.com> =E4=BA=8E2022=E5=B9=
=B43=E6=9C=8827=E6=97=A5=E5=91=A8=E6=97=A5 01:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=94 03:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Mar 22, 2022 at 11:42:31PM +0800, fankaixi.li@bytedance.com wro=
te:
> > > From: "kaixi.fan" <fankaixi.li@bytedance.com>
> > >
> > > Add two ipv6 address on underlay nic interface, and use bpf code to
> > > configure the secondary ipv6 address as the vxlan tunnel source ip.
> > > Then check ping6 result and log contains the correct tunnel source
> > > ip.
> > >
> > > Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> > > ---
> > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++=
++
> > >  tools/testing/selftests/bpf/test_tunnel.sh    | 43 ++++++++++++++--
> > >  2 files changed, 90 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/t=
ools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > index ab635c55ae9b..56e1aee0ba5a 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > @@ -740,4 +740,55 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
> > >       return TC_ACT_OK;
> > >  }
> > >
> > > +SEC("ip6vxlan_set_tunnel_src")
> > > +int _ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
> > > +{
> > > +     struct bpf_tunnel_key key;
> > > +     int ret;
> > > +
> > > +     __builtin_memset(&key, 0x0, sizeof(key));
> > > +     key.local_ipv6[3] =3D bpf_htonl(0xbb); /* ::bb */
> > > +     key.remote_ipv6[3] =3D bpf_htonl(0x11); /* ::11 */
> > > +     key.tunnel_id =3D 22;
> > > +     key.tunnel_tos =3D 0;
> > > +     key.tunnel_ttl =3D 64;
> > > +
> > > +     ret =3D bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> > > +                                  BPF_F_TUNINFO_IPV6);
> > > +     if (ret < 0) {
> > > +             ERROR(ret);
> > > +             return TC_ACT_SHOT;
> > > +     }
> > > +
> > > +     return TC_ACT_OK;
> > > +}
> > > +
> > > +SEC("ip6vxlan_get_tunnel_src")
> > > +int _ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
> > > +{
> > > +     char fmt[] =3D "key %d remote ip6 ::%x source ip6 ::%x\n";
> > > +     char fmt2[] =3D "label %x\n";
> > > +     struct bpf_tunnel_key key;
> > > +     int ret;
> > > +
> > > +     ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
> > > +                                  BPF_F_TUNINFO_IPV6);
> > > +     if (ret < 0) {
> > > +             ERROR(ret);
> > > +             return TC_ACT_SHOT;
> > > +     }
> > > +
> > > +     bpf_trace_printk(fmt, sizeof(fmt),
> > > +                      key.tunnel_id, key.remote_ipv6[3], key.local_i=
pv6[3]);
> > > +     bpf_trace_printk(fmt2, sizeof(fmt2),
> > > +                      key.tunnel_label);
> > Going back to the same comment on v1.
> >
> > How is this printk used?
> > Especially for the most common test PASS case,
> > afaict, this will be ignored and left in the trace buffer?
> >
> > Can it only printk when it detects error? like only print
> > when it fails the !=3D 0xbb test case below?
> >
> > Also, a nit, try to use bpf_printk() instead.
> >
> > Some existing tunnel tests have printk but those are older examples
> > when test_progs.c was not ready.  In the future, we may want
> > to move these tunnel tests to test_progs.c where most of the tests
> > don't printk/grep also and use global variables or map to check and
> > only printF on unexpected values.  Thus, it may as well
> > have this new test steering into this direction in term
> > of only print on error.
> >
>
> Thanks. I would use bpf_printk().
> For tunnel source test cases, printF would only be used for errors. And I
> will use macros for tunnel ip addresses based on Yonghong's suggestion.
>

Hi Martin KaFai Lau and Yonghong,

I have prepared v3 patches for tunnel source ip feature. Some obviously
errors have been fixed. But there are three problems left. They makes me
copy tunnel test cases and put tunnel source ip test codes into them.
I put these three problems here:

I have tried to use bpf_printk in bpf kernel code. But the object file coul=
d
not be loaded by tc filter command. There are .relxxx section such as
.relgre_set_tunnel in the output of objdump.  The tc filter says it could
not find the dedicated section.
So I still use bpf_trace_printk now.

I have tried to use a bpf map "local_ip_array" to store tunnel source ip
address. Userspace code change tunnel source ip by updating map
"local_ip_array" in the middle of test. Kernel bpf code get the tunnel sour=
ce
ip by looking up the map. But the object file could not be loaded by tc fil=
ter
command also. The verifier says "R1 type=3Dscalar expected=3Dmap_ptr" when
calling "bpf_map_lookup_elem" helper function. I check the assembly code
that the r1 register value is 0 when calling "bpf_map_lookup_elem".
I write a tiny bpf loader for this test. But It's too heavy.

I have read test cases in prog_tests directory. They use c code to replace
shell command to create network namespace and ping. Also functions like
"test_tc_peer__load" are used to load bpf code. It's more complicate than
shell commands. And there are many duplicate funtions like create_ns in
some files.
The code in test_progs.c are common functions not test cases.
Maybe we could move tunnel test code to it in the future until the test
framework is complete.

Thanks.

> > > +
> > > +     if (bpf_ntohl(key.local_ipv6[3]) !=3D 0xbb) {
> > > +             ERROR(ret);
> > > +             return TC_ACT_SHOT;
> > > +     }
> > > +
> > > +     return TC_ACT_OK;
> > > +}
> > > +
> > >  char _license[] SEC("license") =3D "GPL";
> > > diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testi=
ng/selftests/bpf/test_tunnel.sh
> > > index b6923392bf16..4b7bf9c7bbe1 100755
> > > --- a/tools/testing/selftests/bpf/test_tunnel.sh
> > > +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> > > @@ -191,12 +191,15 @@ add_ip6vxlan_tunnel()
> > >       ip netns exec at_ns0 ip link set dev veth0 up
> > >       #ip -4 addr del 172.16.1.200 dev veth1
> > >       ip -6 addr add dev veth1 ::22/96
> > > +     if [ "$2" =3D=3D "2" ]; then
> > > +             ip -6 addr add dev veth1 ::bb/96
> > Testing $1 is not "::22" is as good as another $2 arg and
> > then $2 is not needed?
>
> Yes. It's more refined now.
>
> >
> > > +     fi
> > >       ip link set dev veth1 up
> > >
> > >       # at_ns0 namespace
> > >       ip netns exec at_ns0 \
> > >               ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
> > > -             local ::11 remote ::22
> > > +             local ::11 remote $1
> > >       ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
> > >       ip netns exec at_ns0 ip link set dev $DEV_NS up
> > >
> > > @@ -231,7 +234,7 @@ add_ip6geneve_tunnel()
> > >       # at_ns0 namespace
> > >       ip netns exec at_ns0 \
> > >               ip link add dev $DEV_NS type $TYPE id 22 \
> > > -             remote ::22     # geneve has no local option
> > > +             remote ::22    # geneve has no local option
> > Unnecessary space change.  Please try to avoid.  This distracts
> > the code review.
>
> OK. Sorry for the confusion.
>
> >
> > >       ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
> > >       ip netns exec at_ns0 ip link set dev $DEV_NS up
> > >
> > > @@ -394,7 +397,7 @@ test_ip6erspan()
> > >
> > >       check $TYPE
> > >       config_device
> > > -     add_ip6erspan_tunnel $1
> > > +     add_ip6erspan_tunnel
> > What is this change for?
> > How is the patch set related to the test_ip6erspan()?
> >
> > or it is an unrelated clean up? If it is, please use another patch
> > in its own cleanup patch set.
>
> Yes and I would separate it into another patch.
>
> >
> > >       attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
> > >       ping6 $PING_ARG ::11
> > >       ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> > > @@ -441,7 +444,7 @@ test_ip6vxlan()
> > >
> > >       check $TYPE
> > >       config_device
> > > -     add_ip6vxlan_tunnel
> > > +     add_ip6vxlan_tunnel ::22 1
> > >       ip link set dev veth1 mtu 1500
> > >       attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
> > >       # underlay
> > > @@ -690,6 +693,34 @@ test_vxlan_tunsrc()
> > >          echo -e ${GREEN}"PASS: ${TYPE}_tunsrc"${NC}
> > >  }
> > >
> > > +test_ip6vxlan_tunsrc()
> > > +{
> > > +     TYPE=3Dvxlan
> > > +     DEV_NS=3Dip6vxlan00
> > > +     DEV=3Dip6vxlan11
> > > +     ret=3D0
> > > +
> > > +     check $TYPE
> > > +     config_device
> > > +     add_ip6vxlan_tunnel ::bb 2
> > > +     ip link set dev veth1 mtu 1500
> > > +     attach_bpf $DEV ip6vxlan_set_tunnel_src ip6vxlan_get_tunnel_src
> > > +     # underlay
> > > +     ping6 $PING_ARG ::11
> > > +     # ip4 over ip6
> > > +     ping $PING_ARG 10.1.1.100
> > > +     check_err $?
> > > +     ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> > > +     check_err $?
> > > +     cleanup
> > > +
> > > +     if [ $ret -ne 0 ]; then
> > > +                echo -e ${RED}"FAIL: ip6${TYPE}_tunsrc"${NC}
> > > +                return 1
> > > +        fi
> > > +        echo -e ${GREEN}"PASS: ip6${TYPE}_tunsrc"${NC}
> > > +}
> > > +
> > >  attach_bpf()
> > >  {
> > >       DEV=3D$1
> > > @@ -815,6 +846,10 @@ bpf_tunnel_test()
> > >       test_vxlan_tunsrc
> > >       errors=3D$(( $errors + $? ))
> > >
> > > +     echo "Testing IP6VXLAN tunnel source..."
> > > +     test_ip6vxlan_tunsrc
> > > +     errors=3D$(( $errors + $? ))
> > > +
> > >       return $errors
> > >  }
> > >
> > > --
> > > 2.24.3 (Apple Git-128)
> > >
