Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D564332CAEB
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 04:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhCDDl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 22:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhCDDln (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 22:41:43 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF667C061574
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 19:41:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mj10so26537248ejb.5
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 19:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ctdwcy3w021/XfAUg4TkaZecW5irl6CDz7k2Rv83QVU=;
        b=dRfjnbRjfljwbo6rfVlJdJWSjlo2hEdcoJnu0H29poV1QYXv3XQhg6mxj1FVOpsyoE
         YreUIY4mvu4eSJUniP4iG8Dgci95/0YkIadYy2zNiMam7QnO2KTtzG+bpn9Jhm1hPtmT
         yqPVc4Oy1M0A1FMw8t6fwkkgxX59C8eg2JqKKPf1XLEG0i5VsUh92Kb91QToAyBBii5Y
         FaXKB98LYcrPs9B8Clx8TqA/Hrz++oIkrcQ/94dn2yYarauK+m3RbNYKq3qhyc/DtJ/u
         oQo4CdGpFjwsXi6m7vp6J2wDB6TkevCa+02u+LfN+HXcCocm5JuoQNfpSc9Jr8nJCfc7
         oHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ctdwcy3w021/XfAUg4TkaZecW5irl6CDz7k2Rv83QVU=;
        b=Ufj7DJtHPGSPsNwLs7RWHculoADz0mFSuG/PtmFOF6oPvxDjviO6YkqaBiuavKxdf6
         pRArv+AHzo76o5btihjUDaGBRLMs6MMBViaB513TUkJDNzCa7q1IaTBQSk+ur1Cuv11g
         NmaqP72HEHqzXg0F8otZxrzv/ca7y0+VFCUNdW+pywp7pyTD+pcdNT5SXY7IfohB9Oge
         48wl7jnvcoAnv8Ec6Tb0aUGBdiCRtYd4vRV9xB6rwyka0MlJuwN4sfjE1X/3YEwGK73H
         7GIy90n70r/Ui3IDQp6bkESUI2BwgkjNj93EPtir3XHKf4NuQFJWxYEJMwVHoBRTtc9K
         lzdA==
X-Gm-Message-State: AOAM530H8snQRJaIOA7dssEf9GKM0/UuOz/v/HLFrbMvt2Oug2elciyE
        27WQ7P2DCd13XxNUT9mm89O/IWtf/wA=
X-Google-Smtp-Source: ABdhPJyXT2MyaDqdwKTeJ5h8fbdq52qu4h+xBl28BigbLaY9B107aB3QY7/KMnAovFW1FXgk0CSY3w==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr2000349ejc.177.1614829261280;
        Wed, 03 Mar 2021 19:41:01 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id v24sm13687165ejw.17.2021.03.03.19.41.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 19:41:00 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id h98so25994763wrh.11
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 19:41:00 -0800 (PST)
X-Received: by 2002:adf:fa08:: with SMTP id m8mr1805401wrr.12.1614829260152;
 Wed, 03 Mar 2021 19:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20210303123338.99089-1-hxseverything@gmail.com>
 <CA+FuTSfY0y7Y2XSKO-rqPY5mX83NWgAWbQeVukFA94eJVu2B2g@mail.gmail.com> <5D5B444A-FE98-46CF-80D2-DEEBE9C1D74A@gmail.com>
In-Reply-To: <5D5B444A-FE98-46CF-80D2-DEEBE9C1D74A@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 3 Mar 2021 22:40:22 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdLQPvEChSDDAoN+qk2vOVmhA1OCvJ5T38OvOY1=5HQpQ@mail.gmail.com>
Message-ID: <CA+FuTSdLQPvEChSDDAoN+qk2vOVmhA1OCvJ5T38OvOY1=5HQpQ@mail.gmail.com>
Subject: Re: [PATCH/v4] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > Instead of untyped macros, I'd define encap_ipv4 as a function that
> > calls __encap_ipv4.
> >
> > And no need for encap_ipv4_with_ext_proto equivalent to __encap_ipv4.
> >
> I defined these macros to try to keep the existing  invocation for encap_=
ipv4/6
> as the same, if we define this as a function all invocation should be mod=
ified?

You can leave the existing invocations the same and make the new
callers caller __encap_ipv4 directly, which takes one extra argument?
Adding a __ prefixed variant with extra args is a common pattern.

> >>        /* add L2 encap (if specified) */
> >> +       l2_hdr =3D (__u8 *)&h_outer + olen;
> >>        switch (l2_proto) {
> >>        case ETH_P_MPLS_UC:
> >> -               *((__u32 *)((__u8 *)&h_outer + olen)) =3D mpls_label;
> >> +               *(__u32 *)l2_hdr =3D mpls_label;
> >>                break;
> >>        case ETH_P_TEB:
> >> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen=
,
> >> -                                      ETH_HLEN))
> >
> > This is non-standard indentation? Here and elsewhere.
> I thinks it=E2=80=99s a previous issue.

Ah right. Bad example. How about in __encap_vxlan_eth

+               return encap_ipv4_with_ext_proto(skb, IPPROTO_UDP,
+                               ETH_P_TEB, EXTPROTO_VXLAN);

> >> @@ -278,13 +321,24 @@ static __always_inline int encap_ipv6(struct __s=
k_buff *skb, __u8 encap_proto,
> >>        }
> >>
> >>        /* add L2 encap (if specified) */
> >> +       l2_hdr =3D (__u8 *)&h_outer + olen;
> >>        switch (l2_proto) {
> >>        case ETH_P_MPLS_UC:
> >> -               *((__u32 *)((__u8 *)&h_outer + olen)) =3D mpls_label;
> >> +               *(__u32 *)l2_hdr =3D mpls_label;
> >>                break;
> >>        case ETH_P_TEB:
> >> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen=
,
> >> -                                      ETH_HLEN))
> >> +               flags |=3D BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
> >
> > This is a change also for the existing case. Correctly so, I imagine.
> > But the test used to pass with the wrong protocol?
> Yes all tests pass. I=E2=80=99m not sure should we add this flag for the =
existing tests
> which encap eth as the l2 header or only for the Vxlan test?

It is correct in both cases. If it does not break anything, I would do both=
.

Thanks,

  Willem
