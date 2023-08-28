Return-Path: <bpf+bounces-8833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AD78A6EB
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57247280DF9
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02703110D;
	Mon, 28 Aug 2023 07:58:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078010F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:58:42 +0000 (UTC)
Received: from mail.tryweryn.pl (mail.tryweryn.pl [5.196.29.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F3114
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 00:58:40 -0700 (PDT)
Received: by mail.tryweryn.pl (Postfix, from userid 1002)
	id 19BF823F32; Mon, 28 Aug 2023 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tryweryn.pl; s=mail;
	t=1693209425; bh=Bo+/jg3TCpOeS79PpZREuOWEeqJV//jojylD9dSrSik=;
	h=Date:From:To:Subject:From;
	b=nv1aERI6yX+Ss9WkZFDnOARoO1Eyu31hJ6fS+YLD09kqxYbsRXeAxNcvCvnNqx4ZY
	 sccIfsVWDZ07vQv4nko10L3dle0yhobG431LUlZduMeBq6F7DAtOxoYcdqz54pLWKP
	 cH4Wzl34qvQWFkRpnSnDpOBmSzcOL7iW8791+2QEfxQz126sQ/us5SiUkZSTjXL/b1
	 OXNgbnKHN9l8qTiX2TkGAyCai/b5FsLYwPwcB3NY575nvXLtovTGu8A5Z3PkO3gVPb
	 r4xlQe6ABbtm59u1UqbkcfjvCYGqCNQnbI2EkcfdKKhumbw44PWfHHd2krJz27uljv
	 HsObXvd+K7AMQ==
Received: by mail.tryweryn.pl for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:55:53 GMT
Message-ID: <20230828064500-0.1.19.f8am.0.2i8ckf4dnw@tryweryn.pl>
Date: Mon, 28 Aug 2023 07:55:53 GMT
From: "Karol Michun" <karol.michun@tryweryn.pl>
To: <bpf@vger.kernel.org>
Subject: Prezentacja
X-Mailer: mail.tryweryn.pl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe tworzenie planu tras czy =
dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Karol Michun

