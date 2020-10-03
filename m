Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CF282453
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJCNiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Oct 2020 09:38:21 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:33841
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgJCNiV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Oct 2020 09:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601732300; bh=LcsgbWrTWSmcOJf9EzyjatKhkQkt0sGuPVxdgUAFysc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gJgE+GU+ynSa7xkUzbXzDHB/7tfVhqY3Tz3JcBmT8ryZFzGmZ7dVSCqFZva213EoaM++lou8z1xTTYU4ITM5Ww8BjDazDRE9dN95Pg/YOBqHo/0HI/G3ZBSoSFvfGTa/C7HroTQEqWHuekYZJT5whwBu9rLiweJnAduYOHqQ+kmqWkqymDodTuruRfLd9ElQSq0uVjpcFKqbP1pasy96BIEMXuIIclS14jGNbRGjIXdFrh0uD06i6m6ygfRB1QuZf6WytEhGVMxfjlu8CuUqKHQIUXa85O0jvaRflGu0X8SnWZBe8uRx8Yl4vk/SGmy0tcnrSgQkwAkM1y89UHKPtQ==
X-YMail-OSG: RpHsq44VM1kPtBhHSbOOJ1ohSrUtr0..ImzJHtlcH9BPvLFl23CO1zPKjMm4.4X
 aWndr2gfpGOYzs63.s56a2o0Eu1lDXHm5tGCyLK7e6XW_HOWykE18bnJuHm71Dui_fjZJ9KxV5ow
 aKEMOuk2ha3jD9hCplUrjBFxP.cjwS.jyf828WB0WxWmAxl8s5dICEhkYh8js.RmW8SuT5W1YuFA
 vLGuGf9fb0SO_dfMNkc.oJefss8M3tycnYgSmK6kph8gJy6pRFnRl3fIkQQQ2WQkdhGLlKkXoGdk
 VlL.vEIM0Vzicguca_wL5t6uKTQnOQoBBUP9s7iKTzxZnAWI5fnc1.9Wpo1aqyDHxHopnQASx27P
 LVRPNfJIZycyuWoi3ecXEDS4TrP9AENyJb8uw72.xDjliywXURMqQXvhYR4M_84o91.kZ3SOk8EF
 kdGnjL0WFJxTvaQQRBkJhVVR_8Hw1kzN181FvIw1PTQtSuvCyTwAP0ZkUp.PD20Md.Mv.tIwRQ1H
 K6Q17OXqT1sqAgMMjLmtVVtjMFjL0Ngy.NNRxfdpxJK50ZFddVAdb7jOQbP5su0Yc7QaowGacPR4
 WgMYHnPTihXTubLV7xHIq2gvqzPM_FmK.jjAPOoSWwyg1o4qvnXvJThAgNWJmRzG2TqcsQ9KYbik
 .j3H6wGXH_ZmsG9fbYPEJHkdZMiQDIALiXC5c.HEJbS5v.6xEEgCPh6z7qiK54hjsQF48dHpLInQ
 vV9jZRR_EEq5V1IPuWkJmOTlrNKwfFPw8.hBe.a2wtOGLGG24J6okoJHwCXbKLB0lVAyMD.r6o7a
 nfJjY3Ji.q7Djdy2gjKjOhUpfgBjkSp_Zv6Y49WVzgKOiUbVvzkgmTrBAxTQDTUWEBPgj1KLIKOd
 exLYmNC5.D0HaBKC3zoTIcZCA9j7zmgIjDdDqbmpRrpNZ3lIk8kT1ERsSIxz8hR0XLXqGRYpO9cC
 l.cVy07aAHuxYFxXoO1X_lGxnzhBf40UxrjKi3anDgXkP_mFYIt9Pv6G_rzIa2j1fNOwV85a39yo
 vSD.mZGNgUAmUL67if4DAHY.Ky.yTEUGY88RrGx8.tQTs5wwzjHmFzi7CIfbGBsjzHTmMwFtEuQT
 hFp8N9YdAENSDSKEHqBuqJRYgGBgkLS6Cs00_RMfXoDKw482nsbzyKL6dbTZ5R8UpFfGwt8vKAvN
 w0_Nw7GDy_cdYHcX_wAmk17txXYgTrFZXg5BdEdSYZPsfAuQ13bEopBUFCO89vbI913ED8y4V2v4
 CPHaskKXw6MvRYZa2KwSAtk_BbRwRT9OQzpnRPJRdTeBNiS2aotDO8AL33b2uP.LOO9L6lwslI.G
 nUCeoNgIvc_4RrIE.szvCFWOADsbwCfow.bVQquEgC0PC18ALWfiPSkLWMkP6zBjpf0aZWRxTCNb
 2SEcK46yjkQBGon4oD1v3E1URYnWZHamcwHxGcUC78KlCptFkpQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 3 Oct 2020 13:38:20 +0000
Date:   Sat, 3 Oct 2020 13:38:19 +0000 (UTC)
From:   "Mrs. Aisha Gaddafi." <mj2643979@gmail.com>
Reply-To: aisha208g@gmail.com
Message-ID: <576347777.1533470.1601732299973@mail.yahoo.com>
Subject: Assalamu alaikum,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <576347777.1533470.1601732299973.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkFzc2FsYW11IGFsYWlrdW0sDQoNCkkgaGF2ZSBhIGJ1c2luZXNzIFByb3Bvc2FsIGZvciB5
b3UgYW5kIEkgbmVlZCBtdXR1YWwgcmVzcGVjdCwgdHJ1c3QsDQpob25lc3R5LCB0cmFuc3BhcmVu
Y3ksIGFkZXF1YXRlIHN1cHBvcnQgYW5kIGFzc2lzdGFuY2UsIEhvcGUgdG8gaGVhcg0KZnJvbSB5
b3UgZm9yIG1vcmUgZGV0YWlscy4NCg0KV2FybWVzdCByZWdhcmRzDQpNcnMgQWlzaGEgR2FkZGFm
aQ0KDQrYp9mE2LPZhNin2YUg2LnZhNmK2YPZhdiMDQoNCtmE2K/ZiiDYp9mC2KrYsdin2K0g2LnZ
hdmEINmE2YMg2YjYo9mG2Kcg2KjYrdin2KzYqSDYpdmE2Ykg2KfZhNin2K3Yqtix2KfZhSDYp9mE
2YXYqtio2KfYr9mEINmI2KfZhNir2YLYqSDZiNin2YTYo9mF2KfZhtipDQrZiNin2YTYtNmB2KfZ
gdmK2Kkg2YjYp9mE2K/YudmFINin2YTZg9in2YHZiiDZiNin2YTZhdiz2KfYudiv2Kkg2Iwg2YjZ
htij2YXZhCDYo9mGINmG2LPZhdi5INmF2YbZgyDZhNmF2LLZitivINmF2YYNCtin2YTYqtmB2KfY
tdmK2YQuDQoNCtij2K3YsSDYp9mE2KrYrdmK2KfYqg0K2KfZhNiz2YrYr9ipINi52KfYpti02Kkg
2KfZhNmC2LDYp9mB2Yo=
