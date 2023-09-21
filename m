Return-Path: <bpf+bounces-10530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBA7A9855
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A80B21243
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7B18C1C;
	Thu, 21 Sep 2023 17:11:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49114F63;
	Thu, 21 Sep 2023 17:11:21 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED579025;
	Thu, 21 Sep 2023 10:11:02 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76f2843260bso72941785a.3;
        Thu, 21 Sep 2023 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316262; x=1695921062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmAqS4POZPQ4cWVva2XsitwLpylcffcICW2xKCJAJKs=;
        b=MRqMb0ErSrr4wYpe1itOlcjN7/APkPythWOmRjzTboiRL9JfU7RByvJ+F5O+xIFIUE
         //9lhMbVyepYpQBzICN6lJx8Z4RsedsNuXC9qIJePcKhw/0lGnni6JIxgZY+9xXpni+/
         e1rvMEpKozskOfDaWLuqGRHkmdtLf2IrjzyANzv8Zg/X84BcAP2f3tjmkizpd1Br3Viq
         IhJtiFosCPVtAMeygLusVi/Emx/c9XtrNWlHtuSd/Rn6pUtp0oAWRY6PA3E4W6ibTaOD
         l15BVKpKVTCdJn16jYhf03QerAUZ/Z6+A7hrcoy5oDhoVPVdsRNhR6bavnhvhiU4VGib
         3HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316262; x=1695921062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmAqS4POZPQ4cWVva2XsitwLpylcffcICW2xKCJAJKs=;
        b=T4wm7iURJMAeaggidUIV1+o/pv+Da1DiBqEulNbkY0UKyZesupg90ao9L1bma0p1P4
         M8+pcHGb+wllbDQRel1sEFEaI6W4K4vyvLNHoNG1rvfPEFNrjlUkvZZWXZ6Gg1Ehm1Gt
         fKnGjgfbrcWKPc8A2IsdDRoTHN5/dO6/o3GIZ975j+pR8ep3UmNOzn+8dbOowZWYbtwL
         3CJ157xLeZFajm4FAqjOqJgO+Hi2/9/M6ZM0sHP8ZL9thhu/xS4OkQledWccUF+2Mlnl
         YuZ3YmWSMHf9tDKZfVOG2E6n/1Vcl7iEg6xifvtVNJARbVIrUX5PvDMXaF76pMlCKmFZ
         DQ/g==
X-Gm-Message-State: AOJu0YwPNJI+WREc5Q+AMX58ylpzRsn68gH40hU+CkObp+wNT1Hnk9aU
	nO2KG/WYYnmIVGUNFAA+eOzexHSZ7w92WLXbuIx2wqTx
X-Google-Smtp-Source: AGHT+IGlJdba7Njyh19TjaAtxrKa+auxnuBas8gb+0vYCa3DLBBmCmHN8Sx2z82f9gjmZ9zPPKAz/33voSKrEqm8sUA=
X-Received: by 2002:a1f:c886:0:b0:496:21dc:ec73 with SMTP id
 y128-20020a1fc886000000b0049621dcec73mr5737338vkf.5.1695302243773; Thu, 21
 Sep 2023 06:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <730408.1695292879@warthog.procyon.org.uk> <CANn89i+wUq5R2nFO8eGLp7=8Y5OiJ0fwjR+ES74gk1X4k9r0rw@mail.gmail.com>
In-Reply-To: <CANn89i+wUq5R2nFO8eGLp7=8Y5OiJ0fwjR+ES74gk1X4k9r0rw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 21 Sep 2023 09:16:48 -0400
Message-ID: <CAF=yD-JhsNCtP7iWCL830=JWwsKHMqo4OMb9NSgReGJK7C=_0w@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To: Eric Dumazet <edumazet@google.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 7:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Sep 21, 2023 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.c=
om> wrote:
> >
> >
> > Including the transhdrlen in length is a problem when the packet is
> > partially filled (e.g. something like send(MSG_MORE) happened previousl=
y)
> > when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> > transport header or account for it twice.  This can happen under some
> > circumstances, such as splicing into an L2TP socket.
> >
> > The symptom observed is a warning in __ip6_append_data():
> >
> >     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_appen=
d_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
> >
> > that occurs when MSG_SPLICE_PAGES is used to append more data to an alr=
eady
> > partially occupied skbuff.  The warning occurs when 'copy' is larger th=
an
> > the amount of data in the message iterator.  This is because the reques=
ted
> > length includes the transport header length when it shouldn't.  This ca=
n be
> > triggered by, for example:
> >
> >         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
> >         bind(sfd, ...); // ::1
> >         connect(sfd, ...); // ::1 port 7
> >         send(sfd, buffer, 4100, MSG_MORE);
> >         sendfile(sfd, dfd, NULL, 1024);
> >
> > Fix this by only adding transhdrlen into the length if the write queue =
is
> > empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.
> >
> > l2tp_ip_sendmsg() looks like it won't suffer from this problem as it bu=
ilds
> > the UDP packet itself.
> >
> > Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support f=
or IPv6")
> > Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com=
/
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: David Ahern <dsahern@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: netdev@vger.kernel.org
> > cc: bpf@vger.kernel.org
> > cc: syzkaller-bugs@googlegroups.com
> > ---
>
> Looks safer indeed, thanks to you and Willem !
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

