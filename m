Return-Path: <bpf+bounces-9527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE789798B5B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDB41C20D30
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AA14298;
	Fri,  8 Sep 2023 17:17:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5F14277
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 17:17:33 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CF199F
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 10:17:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56c2e882416so1801082a12.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694193452; x=1694798252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dytdhOUY4d267Lvi8EgrlRmP7ykYMIsK1Jem27n9klw=;
        b=KWKzxaeVmuW9HCFbNTl1CgxJpebCNvWWjROKyYtXL4dS8q6kztH4kN2cZ8CYEk2dvt
         +ba04Bu9xjC+9UzeHsaAWVgmV46OeR2G3cRxFYbosC1bKzThu0ZrKon+i482uWyReM7A
         VdPQfWixVwcZ5BYr5RA7NUrqCFYMAmhPgMPH4T2kwBWnR6qEVbCp0BHsAqfdmRqbQVck
         bMBM2OkGGrnXThVPGgH2v7WrMGfJvNQ1wAJDzkl8pLf+rM+50CM2yLlwUVHwV0u+Lf35
         JhmAQ0LwzMbh/RPxIUbUOz2xzyahbzgmZ+dAPcr0Sy9bgCsObz0Dw1fqPCJqhXivsIdA
         FRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694193452; x=1694798252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dytdhOUY4d267Lvi8EgrlRmP7ykYMIsK1Jem27n9klw=;
        b=bupJB/10dkNSYWQe08V18XawRlcUv0KqRnaCfWa7e9UHiy3B36gwo1ZA1tbcfMUZr2
         Ar9WzWbebriL3NnbqQLqiTMn3Sx1Hat0pWWv2M+lPl+69yu3Ach55H8RC/q94XHNWXJS
         hbQq+JlSTgzwHGiOJ5M1bLilz/PlqcQot5rWFEiUDh1bf9Jv6EDTCJ6dXu9UeJNQnoeG
         0qbOY3Pw3G0w70LyB+IH9vr5jEzXcfrqacXQw41qkT/Ihz8vIEBgVfd6nCzu2SdNOu85
         7iflgHrrePwWdW/yXfqCdMkoasV2sYCTeC+G9Gl8FGBq5nqunv7xDjnwe1wUgeI4XLsd
         Z1zw==
X-Gm-Message-State: AOJu0YxLJI0q52dp+DECnCzd83T+HD1Bqo8XtZCMA7352aiGutttIdi3
	J+29eTsbjeXXv14u8dt1f74rWnfpmhhVEmJTF2e6DQ==
X-Google-Smtp-Source: AGHT+IGAe/fv4uMQ0BlxMb67RlhBxKTj5nqsa5XxGuEZUU4hL1QHPUBOFNZRoNQc3deWgEJMnJF1y/FmCRWoPUgPXvc=
X-Received: by 2002:a17:90a:d484:b0:26b:3625:d1a2 with SMTP id
 s4-20020a17090ad48400b0026b3625d1a2mr3123198pju.41.1694193451678; Fri, 08 Sep
 2023 10:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221121180340.1983627-1-sdf@google.com> <20221121180340.1983627-2-sdf@google.com>
 <2b84e81a-90f8-898f-d320-a29233ff37ad@iogearbox.net>
In-Reply-To: <2b84e81a-90f8-898f-d320-a29233ff37ad@iogearbox.net>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 8 Sep 2023 10:17:20 -0700
Message-ID: <CAKH8qBv5xvjxF2G78Nm3iOeC5OVygSZK3vVzZgOXT8EwyW+Obg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 9:54=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Hi Stan,
>
> Do you have some cycles to look into the below?

Sure, I'll take a look!

> On 11/21/22 7:03 PM, Stanislav Fomichev wrote:
> > LWT_XMIT to test L3 case, TC to test L2 case.
> >
> > v2:
> > - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
> > - add comment about which condition triggers the rejection (Martin)
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> [...]
> > +             /* ETH_HLEN+1-sized packet should be redirected. */
> > +
> > +             {
> > +                     .msg =3D "veth ETH_HLEN+1 packet ingress",
> > +                     .data_in =3D eth_hlen_pp,
> > +                     .data_size_in =3D sizeof(eth_hlen_pp),
> > +                     .ifindex =3D &veth_ifindex,
> > +             },
> [...]
>
> This one is now failing in BPF CI on net/net-next ff after the veth drive=
r changed
> it's drop error code in [0] from NETDEV_TX_OK (0) to NET_XMIT_DROP (1) :
>
> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress [redirect_egress]=
 unexpected ret: veth ETH_HLEN+1 packet ingress [redirect_egress]: actual 1=
 !=3D expected 0
> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [tc_redirect_ingr=
ess] 0 nsec
> test_empty_skb:PASS:ret: veth ETH_HLEN+1 packet ingress [tc_redirect_ingr=
ess] 0 nsec
> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [tc_redirect_egre=
ss] 0 nsec
> test_empty_skb:PASS:ret: veth ETH_HLEN+1 packet ingress [tc_redirect_egre=
ss] 0 nsec
> test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [redirect_ingress=
] 0 nsec
> test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [redirect_ingress=
] 0 nsec
> test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [redirect_egress]=
 0 nsec
> test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [redirect_egress]=
 0 nsec
> test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [tc_redirect_ingr=
ess] 0 nsec
> test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [tc_redirect_ingr=
ess] 0 nsec
> test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [tc_redirect_egre=
ss] 0 nsec
> test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [tc_redirect_egre=
ss] 0 nsec
> close_netns:PASS:setns 0 nsec
> #71      empty_skb:FAIL
>
> The test was testing bpf_clone_redirect which is still okay, just that fo=
r the
> xmit sides it propagates the error code now into ret and hence the assert=
 fails.
> Perhaps we would need to tweak the test case to test for 0 or 1 ... 0 in =
case
> bpf_clone_redirect pushes to ingress, 1 in case it pushes to egress and r=
eaches
> veth..
>
> Thanks,
> Daniel
>
>    [0] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/com=
mit/?id=3D151e887d8ff97e2e42110ffa1fb1e6a2128fb364
>
> > +     };
> > +
> > +     SYS("ip netns add empty_skb");
> > +     tok =3D open_netns("empty_skb");
> > +     SYS("ip link add veth0 type veth peer veth1");
> > +     SYS("ip link set dev veth0 up");
> > +     SYS("ip link set dev veth1 up");
> > +     SYS("ip addr add 10.0.0.1/8 dev veth0");
> > +     SYS("ip addr add 10.0.0.2/8 dev veth1");
> > +     veth_ifindex =3D if_nametoindex("veth0");
> > +
> > +     SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2")=
;
> > +     SYS("ip link set ipip0 up");
> > +     SYS("ip addr add 192.168.1.1/16 dev ipip0");
> > +     ipip_ifindex =3D if_nametoindex("ipip0");
> > +
> > +     bpf_obj =3D empty_skb__open_and_load();
> > +     if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
> > +             goto out;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> > +             bpf_object__for_each_program(prog, bpf_obj->obj) {
> > +                     char buf[128];
> > +                     bool at_tc =3D !strncmp(bpf_program__section_name=
(prog), "tc", 2);
> > +
> > +                     tattr.data_in =3D tests[i].data_in;
> > +                     tattr.data_size_in =3D tests[i].data_size_in;
> > +
> > +                     tattr.data_size_out =3D 0;
> > +                     bpf_obj->bss->ifindex =3D *tests[i].ifindex;
> > +                     bpf_obj->bss->ret =3D 0;
> > +                     err =3D bpf_prog_test_run_opts(bpf_program__fd(pr=
og), &tattr);
> > +                     sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_pr=
ogram__name(prog));
> > +
> > +                     if (at_tc && tests[i].success_on_tc)
> > +                             ASSERT_GE(err, 0, buf);
> > +                     else
> > +                             ASSERT_EQ(err, tests[i].err, buf);
> > +                     sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_pr=
ogram__name(prog));
> > +                     if (at_tc && tests[i].success_on_tc)
> > +                             ASSERT_GE(bpf_obj->bss->ret, 0, buf);
> > +                     else
> > +                             ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret=
, buf);
>

