Return-Path: <bpf+bounces-1531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AAB718A60
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22CB1C209A4
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD434CC2;
	Wed, 31 May 2023 19:43:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1A805
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:43:42 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555F9F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:43:40 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D8BF3C151B09
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685562219; bh=vQYa+o7PrQRhVMAw5kY3uvxmSkuAyIWTsVMqJbjJmr4=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=LFFDVZsS7PTjCEQc8GFNotLDQ2xsnb0SJlZa/gDvTdUBNnzITVlXg6cNqpMnkNAKO
	 6WyEWH0BnS8ErWNVDsvXoE75AdhxzwMtw77HPbgBpLrumzPfvjGKANl2UAFSpmlW84
	 /H1P6TWNnZMeRVNdj7uxI8xXNa0QOzlJt+TnEIwg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed May 31 12:43:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B2B0FC15109E;
	Wed, 31 May 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685562219; bh=vQYa+o7PrQRhVMAw5kY3uvxmSkuAyIWTsVMqJbjJmr4=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=LFFDVZsS7PTjCEQc8GFNotLDQ2xsnb0SJlZa/gDvTdUBNnzITVlXg6cNqpMnkNAKO
	 6WyEWH0BnS8ErWNVDsvXoE75AdhxzwMtw77HPbgBpLrumzPfvjGKANl2UAFSpmlW84
	 /H1P6TWNnZMeRVNdj7uxI8xXNa0QOzlJt+TnEIwg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0B4B2C15109E
 for <bpf@ietfa.amsl.com>; Wed, 31 May 2023 12:43:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.695
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=fail (2048-bit key)
 reason="fail (bad RSA signature)" header.d=sandelman.ca
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pc0d6rTTt5Lc for <bpf@ietfa.amsl.com>;
 Wed, 31 May 2023 12:43:34 -0700 (PDT)
Received: from relay.sandelman.ca (relay.cooperix.net [176.58.120.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 14F90C151072
 for <bpf@ietf.org>; Wed, 31 May 2023 12:43:33 -0700 (PDT)
Received: from dyas.sandelman.ca (ipv6.dyas.sandelman.ca
 [IPv6:2607:f0b0:f:6::1])
 by relay.sandelman.ca (Postfix) with ESMTPS id 45973209C2;
 Wed, 31 May 2023 19:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sandelman.ca; s=mail;
 t=1685562211; bh=nh/2E7l9Eo6glIkU2giO2kr4x719RGydgBltRjrWVU4=;
 h=From:To:Subject:In-reply-to:References:Date:From;
 b=PUKKFULOQP48GVZ6LS1gKTGR97kt8dSGZFEvbQUlZ9mZd5mwkshUXZIFSSuAGOgK/
 FgsRDz/1t4x/tgLbLWFt+1pe0F3zg0L9Yp0obXsufhKpKVbA2oM5rZt6T6k12ga6BY
 V0XsaIGYInavlBiEWqpqLjsbVA0vZs6fxoUtybzwNCtvruv0wzyblvm/jMeI1+zwMF
 IUXAj7okLSW6mnY/oFR0rSX+8sJ/6IrJnbfKMO1YveQjwhETwwxfalSCnTxTmBw/3n
 M6Kz70BXK+kobF+QGLD0d+Eneqni67lCYBYcBKN23sanFxtLE0TVzuRHRvPDo67Fkw
 8pOi+H1cKryNA==
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
 id 9FCAFA63A6; Wed, 31 May 2023 15:38:10 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
 by dyas.sandelman.ca (Postfix) with ESMTP id 9D9D8A6377;
 Wed, 31 May 2023 15:38:10 -0400 (EDT)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: "bpf\@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
In-reply-to: <ZHbDekB0KderhSTl@infradead.org>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526171929.GB1209625@maniforge>
 <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZHbDekB0KderhSTl@infradead.org>
Comments: In-reply-to Christoph Hellwig <hch@infradead.org>
 message dated "Tue, 30 May 2023 20:48:10 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 May 2023 15:38:10 -0400
Message-ID: <9539.1685561890@dyas>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iz69Xpas_0xWzmHj_o0Ebue65A8>
Subject: Re: [Bpf] IETF BPF working group draft charter
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4641281693691712675=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============4641281693691712675==
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain


I assume that one use cases is where a VM (windows or Linux inside) does a
eBPF (XDP) load into a virtual network interface, and the hypervisor manages
to push that down to some engine in a physical card.

In that case, we might have mixes of Windows, Linux and network card
implementations of eBPF on the same "transaction" path.

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-                      *I*LIKE*TRAINS*




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmR3oiIACgkQcAKuwszY
gEPNywwApDNYEY1FOZxxA6q+3i2uuLVSgOD5fK7V92DyytX2t7tlWref0mN7EJry
a/N0GgIuTTKWLa/R8mf5hTdpCRQ3I1cHaOYJiupSiF3Gs7/zhwcEJ2qhIfcU4X9d
5N/Rzgif41NFyNJX+f9cvV03r3UStpMJeu2RJ0fRsGTq7Xfkc+7RwTNEzhu0pHfg
PoDitf0w6pSQDKeTBg/hmgpwYQoQ56qAWaeJsUU06baMru6RmfYPedb0g/Maac4o
T9jF2zfcILhBlJ/DGMFAuFypoXBirIuS+xhPpJzYD7gmY+ULCjayAu16mGdeg2kG
gwNMIQZdEDYQB5N4aiQINB4I8JFnlJ7G36EJiKhwINgweFpcuIVMTFNpRaLpOoSv
/9+aaMRnPINYyLixvoiIgZWbWNw5r/5zy2KIIBGqyfVzJFjVqH/9YkYkCrhzLPdN
4j096l0tDbtmoJk2fxlaBegMCm464ohVFBfiev3XUQUCraV9fTeZLXR7FPZVgM1i
iNCYd4NE
=KU0I
-----END PGP SIGNATURE-----
--=-=-=--


--===============4641281693691712675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4641281693691712675==--


