Return-Path: <bpf+bounces-5915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2513762F55
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B021C2110D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09857A939;
	Wed, 26 Jul 2023 08:10:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD939460
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:10:24 +0000 (UTC)
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 01:10:22 PDT
Received: from mail.tryweryn.pl (mail.tryweryn.pl [5.196.29.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900606E89
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 01:10:22 -0700 (PDT)
Received: by mail.tryweryn.pl (Postfix, from userid 1002)
	id D869326A17; Wed, 26 Jul 2023 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tryweryn.pl; s=mail;
	t=1690358553; bh=Bo+/jg3TCpOeS79PpZREuOWEeqJV//jojylD9dSrSik=;
	h=Date:From:To:Subject:From;
	b=Ptd2KOcHMmXlFb6X09eivFQnX5xMFSDwjt7hwJVu4/ZWhvcPAaSFdxdl6dtZ7Gphs
	 uXAiWKBvr6R9qSlsWaYL0pHM+e8wF3PPYZDOMQnvao8fLTuo12z4arDbq0X4oEPV+l
	 GWMGA4Pk5NDjP7OHN6UdxnxDyRdt+/RsO4B8FeSRUNcaqdlU9DhwF4IS4hfmzGDexP
	 Id39PRW4mwy2/INuVLdsIO+I2rdDXIdK0BRnBVWTCVKbbrFHaT7Hx3k0NjqyGlmR6h
	 Harsv+6UPQLXyajXydz9lvfcZQyrnkFBiq+z9Z8mvPDi6/1skz8HMWDQlhj4rHsyr1
	 Z+3miQtlOSe5g==
Received: by mail.tryweryn.pl for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:00:41 GMT
Message-ID: <20230726064500-0.1.l.5v8f.0.1mfam5inj0@tryweryn.pl>
Date: Wed, 26 Jul 2023 08:00:41 GMT
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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

