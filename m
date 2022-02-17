Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346014B9B5F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiBQIpt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 03:45:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiBQIpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 03:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 113502221B4
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645087532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/VQgLhh1DBOYffBqGYngony3TZbnaAH3gw4sPL+y8Y=;
        b=THEdw38vzB0QWr4jHcxHN+OaOpdlOkXAwUgJbz0PFhdOFvTd7Peg6Z9BVjnBoC8DElB8V1
        S/zG6gEwFUhy/PVPBynXGnn2tWYNL7XqZAAKk/0/sHS1u6t2l+KRbobbJb6z/Mb/7QIj83
        Es249uGRRbdMgKDYdUXZpNiVbXBgZc4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-Mt4B4Tg6PBOgJfpjfbCemA-1; Thu, 17 Feb 2022 03:45:30 -0500
X-MC-Unique: Mt4B4Tg6PBOgJfpjfbCemA-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso1378520wml.1
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 00:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l/VQgLhh1DBOYffBqGYngony3TZbnaAH3gw4sPL+y8Y=;
        b=irEVV7CtUayxCSnARaHwyi6p4+whr78SVfEdRDzsG+BKtTEKRccY4VSOY5IIBM+UkI
         lp961smK+7HgoJJedt7hsGXUClkRl/oJNVI9gNSaKHSWB+gCVT8MXWXscwyyfxGJ9Ntb
         fMjkE1sSEVG3lBdj94ctrPzex6xEGeR2p0fnW7BDQuYiq9c8KbhfHrkinYWjcXP+20PW
         VugHbiGsNKotD6qfSKoKWSgYzo4+4dyHd9pj1CCqUWoxUIuGmE92yoru2nZMa+bbCs2J
         DiLXfQF7VTxXIbeHMB5VXqUY8ppSNbI7ixblA593eArATwSBqNq28+CIJF4caGrhpDqy
         Avig==
X-Gm-Message-State: AOAM5310fWXfhF2u3xW3QLQ/5lgtI4P4vMyWkjxJejVrsCsmgkGHWRW0
        pFzJN8KNwRSzEcplKGTZQBswLi55DOzDgXP/gfze3bnDKdI5U0ltF0V/MzJgCnrSldGOSJ6YYta
        VzVS2QJCU7txP
X-Received: by 2002:a05:600c:4e0a:b0:37b:c548:622a with SMTP id b10-20020a05600c4e0a00b0037bc548622amr5359162wmq.55.1645087529259;
        Thu, 17 Feb 2022 00:45:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg9hz9QXiPqil98HtD9zdj/RRqil2JJJiJ6kNUJxNsL96+bttpFtCe95wg8+235HI07HM++Q==
X-Received: by 2002:a05:600c:4e0a:b0:37b:c548:622a with SMTP id b10-20020a05600c4e0a00b0037bc548622amr5359148wmq.55.1645087529037;
        Thu, 17 Feb 2022 00:45:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id z7sm492824wml.40.2022.02.17.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 00:45:28 -0800 (PST)
Message-ID: <41a3e6e4f9331c6a0a62fe838fc6f9084a5c89bc.camel@redhat.com>
Subject: Re: [PATCH v3] net: fix wrong network header length
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lina Wang <lina.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>,
        Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Feb 2022 09:45:27 +0100
In-Reply-To: <20220217070139.30028-1-lina.wang@mediatek.com>
References: <CAADnVQK78PN8N6c6u_O2BAxdyXwH_HVYMV_x3oGgyfT50a6ymg@mail.gmail.com>
         <20220217070139.30028-1-lina.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Thu, 2022-02-17 at 15:01 +0800, Lina Wang wrote:
> On Wed, 2022-02-16 at 19:05 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 15, 2022 at 11:37 PM Lina Wang <lina.wang@mediatek.com>
> > wrote:
> > > 
> > > When clatd starts with ebpf offloaing, and NETIF_F_GRO_FRAGLIST is
> > > enable,
> > > several skbs are gathered in skb_shinfo(skb)->frag_list. The first
> > > skb's
> > > ipv6 header will be changed to ipv4 after bpf_skb_proto_6_to_4,
> > > network_header\transport_header\mac_header have been updated as
> > > ipv4 acts,
> > > but other skbs in frag_list didnot update anything, just ipv6
> > > packets.
> > 
> > Please add a test that demonstrates the issue and verifies the fix.
> 
> I used iperf udp test to verify the patch, server peer enabled -d to debug
> received packets.
> 
> 192.0.0.4 is clatd interface ip, corresponding ipv6 addr is 
> 2000:1:1:1:afca:1b1f:1a9:b367, server peer ip is 1.1.1.1,
> whose ipv6 is 2004:1:1:1::101:101.
> 
> Without the patch, when udp length 2840 packets received, iperf shows:
> pcount 1 packet_count 0
> pcount 27898727 packet_count 1
> pcount 3 packet_count 27898727
> 
> pcount should be 2, but is 27898727(0x1a9b367) , which is 20 bytes put 
> forward. 
> 
> 12:08:02.680299	Unicast to us 2004:1:1:1::101:101   2000:1:1:1:afca:1b1f:1a9:b367 UDP 51196 → 5201 Len=2840
> 0000   20 00 00 01 00 01 00 01 af ca 1b 1f 01 a9 b3 67   ipv6 dst address
> 0000   c7 fc 14 51 0b 20 c7 ab                           udp header
> 0000   00 00 00 ab 00 0e f3 49 00 00 00 01 08 06 69 d2   00000001 is pcount
> 12:08:02.682084	Unicast to us	1.1.1.1	                 192.0.0.4 	 	  UDP 51196 → 5201 Len=2840
> 
> After applied the patch, there is no OOO, pcount acted in order.

To clarify: Alexei is asking to add a test under:

tools/testing/selftests/net/

to cover this specific case. You can propbably extend the existing
udpgro_fwd.sh.

Please explicitly CC people who gave feedback to previous iterations,
it makes easier to track the discussion.

/P

