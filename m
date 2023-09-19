Return-Path: <bpf+bounces-10361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37297A5CB1
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BC281F5F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98038DC0;
	Tue, 19 Sep 2023 08:35:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B6F509;
	Tue, 19 Sep 2023 08:35:20 +0000 (UTC)
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 01:35:16 PDT
Received: from mail.katalix.com (mail.katalix.com [IPv6:2a05:d01c:827:b342:16d0:7237:f32a:8096])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F83512F;
	Tue, 19 Sep 2023 01:35:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:adca:73b6:841b:e197])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id C25287EA0A;
	Tue, 19 Sep 2023 09:27:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1695112033; bh=CWPOj42vo1VLahFkddCpX9HOxMdoGJMoAp4EYdfoRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=2019=20Sep=202023=2009:27:13=20+0100|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Eric=20Dumazet=20<edumazet@goo
	 gle.com>|Cc:=20Willem=20de=20Bruijn=20<willemdebruijn.kernel@gmail
	 .com>,=0D=0A=09David=20Howells=20<dhowells@redhat.com>,=0D=0A=09sy
	 zbot=20<syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>,=0D
	 =0A=09bpf@vger.kernel.org,=20davem@davemloft.net,=20dsahern@kernel
	 .org,=0D=0A=09kuba@kernel.org,=20linux-kernel@vger.kernel.org,=0D=
	 0A=09netdev@vger.kernel.org,=20pabeni@redhat.com,=0D=0A=09syzkalle
	 r-bugs@googlegroups.com|Subject:=20Re:=20[syzbot]=20[net?]=20WARNI
	 NG=20in=20__ip6_append_data|Message-ID:=20<ZQlbYVCjCyuPotdX@katali
	 x.com>|References:=20<3793723.1694795079@warthog.procyon.org.uk>=0
	 D=0A=20<CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.g
	 mail.com>=0D=0A=20<0000000000001c12b30605378ce8@google.com>=0D=0A=
	 20<3905046.1695031382@warthog.procyon.org.uk>=0D=0A=20<65085768c17
	 da_898cd294ae@willemb.c.googlers.com.notmuch>=0D=0A=20<CANn89iJ39H
	 guu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>|MIME-Vers
	 ion:=201.0|Content-Disposition:=20inline|In-Reply-To:=20<CANn89iJ3
	 9Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>;
	b=WnT0zDzGVLTO7JManFGA4oHixkhzvG2IjnUtWaXi0AdzSV2+FV27g/f4hhaf5hmTn
	 /tS94y+6rdjNpV664UAGmLSVLiTlCdqbEm8dybaxfUYsPMRFNaAVQ5xO942NbSfrOX
	 nUsEBgKB6i61ALidtdat6o1fEjlVPcjaEZAsg74D3cZKFlng/7u057lQ8a0mkuqf/p
	 Irgtcq2EGsci7fUi/YezBZDJ6pNsaZVClWyVOVnibZARlKraaflyyQJ/ndZEc3cntV
	 jBdOMhpud9Ol+F2jy9VlZtHYSdZGx6hYWb1fjVU6B+B02RpA81DJpXUPLG+9nlk5vk
	 yqSIQfETZtYmA==
Date: Tue, 19 Sep 2023 09:27:13 +0100
From: Tom Parkin <tparkin@katalix.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Howells <dhowells@redhat.com>,
	syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
Message-ID: <ZQlbYVCjCyuPotdX@katalix.com>
References: <3793723.1694795079@warthog.procyon.org.uk>
 <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
 <0000000000001c12b30605378ce8@google.com>
 <3905046.1695031382@warthog.procyon.org.uk>
 <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
 <CANn89iJ39Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qe7qz294sxBAXLZG"
Content-Disposition: inline
In-Reply-To: <CANn89iJ39Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--qe7qz294sxBAXLZG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Mon, Sep 18, 2023 at 16:04:49 +0200, Eric Dumazet wrote:
> On Mon, Sep 18, 2023 at 3:58=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > David Howells wrote:
> > > David Howells <dhowells@redhat.com> wrote:
> > >
> > > > I think the attached is probably an equivalent cleaned up reproduce=
r.  Note
> > > > that if the length given to sendfile() is less than 65536, it fails=
 with
> > > > EINVAL before it gets into __ip6_append_data().
> > >
> > > Actually, it only fails with EINVAL if the size is not a multiple of =
the block
> > > size of the source file because it's open O_DIRECT so, say, 65536-512=
 is fine
> > > (and works).
> > >
> > > But thinking more on this further, is this even a bug in my code, I w=
onder?
> > > The length passed is 65536 - but a UDP packet can't carry that, so it
> > > shouldn't it have errored out before getting that far?  (which is wha=
t it
> > > seems to do when I try it).
> > >
> > > I don't see how we get past the length check in ip6_append_data() wit=
h the
> > > reproducer we're given unless the MTU is somewhat bigger than 65536 (=
is that
> > > even possible?)
> >
> > An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 + =
40
> > sounds correct. But payload length passed of 65536 is not (ignoring ipv6
> > jumbograms). So that should probably trigger an EINVAL -- if that is in=
deed
> > what the repro does.
>=20
> l2tp_ip6_sendmsg() claims ip6_append_data() can make better checks,
> but what about simply replacing INT_MAX by 65535 ?

Slightly OT but I think the l2tp_ip6.c approach was probably cribbed
=66rom net/ipv6/udp.c's udpv6_sendmsg originally:


    /* Rough check on arithmetic overflow,
       better check is made in ip6_append_data().
       */
    if (len > INT_MAX - sizeof(struct udphdr))
        return -EMSGSIZE;


Should the udp code be modified similarly?

--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--qe7qz294sxBAXLZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmUJW1sACgkQlIwGZQq6
i9CDhwf8Dr9xdA/kYI0P1TS6do/S0cMJsdoybHmEfhErfoA5n20det6rz7EvsxLn
qkiFW3urMCSMAsB6wuftENVni4tswHbpWjuQ890o8BfmW/fBL7avioZd6qESgykx
X4WGGkDLeRnlOZb5jhzqVKsinxmhDQQL/Iogq18z/VWZwC6od+k61RIIIwdpgik8
foGPo6aJ3a43pAJ7Cl8AeAAySHHJ+0nZPlh7ns49bcBWfDa9y05hVddXAcNSOExL
LVt2Atkm1BIXGR7eSB9dIb5clb9WRWT1hqFfuE6N6DkYyqmRWkbEdsLvntWm5CcD
UC+ZbLZlslafOuG+BLDrAXiWcL3wRw==
=X+72
-----END PGP SIGNATURE-----

--qe7qz294sxBAXLZG--

