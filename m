Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF96326EC2
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhB0T10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Feb 2021 14:27:26 -0500
Received: from sonic314-49.consmr.mail.bf2.yahoo.com ([74.6.132.223]:41848
        "EHLO sonic314-49.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhB0T1Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Feb 2021 14:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614453999; bh=h/9a/Fy6iXiOd5QokDs7ep8voH7YVL4u2LG3cYHR+ow=; h=Date:From:Reply-To:Subject:References:From:Subject:Reply-To; b=UXIE2Hg9XvVgsOoRxznIzsvKzdHwoRhm5hsiV6YRHbl+oqhkwWseqT9jeoNS6ePfigHgJ2+kKSdYt1g1nn7TMuEJiFZXdrYdx1XtQ3Ks3E+v4XBIOvfBCdF4MtWAdHOTZ6c74VKGl6fJLU3jZEYmP+qhWu9ve/hivJZBFO6oLmYiu/a/ifwl2j3OrMIjaBRmT60L1WInkpeweRYmPxNWtJEnrSYarRCQ4SOKNMNZFLQfiZLKHf2BzYlUCRuBd2WmqfariC8x1zp/blu17efthxsfY19XE8dCy7XuQxO82NM2hrIXsid7vWcyVCY5YUnz0dqoCLgrNy0DU1TN+YF7zQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614453999; bh=wD0n/Vic4iyJRMkA84kJ82HjcvQy/vQk59AIWHneLgh=; h=X-Sonic-MF:Date:From:Subject:From:Subject; b=qSPIHirDfDCLOq+fEPQTcusJ4Ew0Qqy5NZiRe4P/8ElpuNQjaOt4XnYRZkC2nc/q/4ctMoMXsroKDidpVebXNvwQwB4bOHKU+mh0MlLyPkRT/WkrByHWZwxcNmlTfzii7dl7RwVWBQPH8InB7WCSM86P766SDQPCsBnddhOIptN9prGjhqzVz8BDirmNttow7loXzUZqLD5BOHxknl/T5TSz+PUslO1PpPng5MlVkQMAMQFHXdhImLE28Oy+rBqCPc0MeZ1XQqoVpbLQubB2fVWKA+zASTKLSLP49brAvFXloI/T53NoCmKhkbkwX2YvIG4HWcYhpkLmK0QktckayA==
X-YMail-OSG: w_kJcIQVM1nyFAbfIh3SNBQjz1kN2.4P692kkdNHmfTxfRN7K7Sc0CLH2x91np.
 R_p63YsRLAknNy5.i1U3FzRhI.1bXXUG.7OBrAGFl7Qg5cj3lVMk0lqFWUPOByPIFirbnK3lclnp
 jyLzXZmX5uUR44uQo5AYCP41vee.hf7dLR_Iv7mInDEWosnSbjumHGGY806iPNOhXDSqfkRWyyLV
 SbxgGhbDnjXqhu_1G6U5ZqpPpK9AzhF4m2e.gO5uTWSKiQma1WkcKER9QAYSOxDH0F4CoMjGxvOt
 4JlwkHSWuFgKUo8cJc9XGHL2QB4h.o2mymdvSTajK.4ZelNIajGUOCANcuhUfjsUwjyFDrIhXTGt
 FHuYfG3EtCbr8yXyThfRsIVfD5PYLsqsBwKe_DBVyXg5bgOXJxVXfgY1x70lndInhlBvWtEncvni
 RBs28H1zX6G02fSe8y0h3I31wh6Y8RLuykcAq.fZ7pmcPMptAwCSBYH9TpkWkEswJTxplIVsDrG6
 OtMaqvJVgs3gFm0Q9xMfVemFVsMR8mZKK0GSY9_16ZWy1yW1GRNVNpIvFoNoZFcp6C.LWTukAeLB
 NJZkVZtTokDFKXVsFjb43Rx9KaLG6UoXFEt2ctWWOamwqd8CCIWNBvi8Bv6GeNvVS54a.hM_0lkc
 AMJ.pka_J21_GPRfp3vrs9n1ngZUGysr8mjHyCXLDVP5AvdIC5N8Eu3lY2Ja8TF8XwZxOjQRj9uk
 iReCG6MGYGQqLNiA8C7ibRkqrqXlI89MzvxBIrJ56sUix1PbD9R8auM4Ra9J1MVPpy8uQMMuQWNB
 37rMKqPs1tVDcdIM_tWj9uIaTAmxnWl0Zs9HyxzDLjhDa212RndNIPRXLxxzpIo_ArbAj6lIQVHR
 0Dfl4Y1ljut3e6789LK17__DnDQNnG9d1Y8pfeLp4DNL9ltSBwJ3JMHn9p45subawZrYWdhzDOTb
 a7fZJRcoZ6pcCrBFrDHbu.xP6n9dcCrdAaTJR_BR3xqIWJA01wcaQGiCXCi84m7yngBS7keshxyg
 6Scrnv5z.1ETF7eg89PJ2K2j0H6dtVR9wGTOD9445CpUZBH4viqr.HhiLxMGiDagXaD4P5BRnx5D
 uWZFCbuqqWY3rutwFioxI2lBdxJxBO3vK9_qZA_ZrX0yYTd7rs02MMHBxuuqFumxRmUiCsDtdYqd
 Hj3IEgpSvVjqo0_wZ9GmmWzz_phUaUiKAsajI9z6Ih.6SESDvyz.PVBoGUt1dAS46zKOj_UK1fZP
 DsCRHYxjuVcRixZ.a.ENbcsBhviBd6PRMA.0weMVcpRUqfm2EJG_I7wp0bTdS7URs0czRgX476k1
 NqZSEOK5KOLwK1bejQylN27FyORHv83s3C3x55AgYTcrIxiyI1YZtt8UegfKQiEatTyMliqkMpq_
 cmkEJ0EA4kf0Zy3fVwx8CRF2n.R7VAlauphvEKIA3KRunyKUjBRqoiNmtlvR89sUvuHQIvUGCzG5
 g2yiKAMoCYRygHWlNiRyPjjSzMXKmPpyIgkgmNOCeeWocmDQjUysc3Tm5Y2UXpBkd5mN7xVRK87N
 NRIHR4eiNWigH2lPyTL57lhRKw_gkqt6mGcvTsWkmrOQbfzbeYhXcdaXXl7BitIgH6ywNlDhy7zp
 jk9bOckjaqqmZ_2jhEJVKw4FZ2ct0p_tdp_7Cmv0LHMjkzdavsRIP8628H60qeKU2Jx0a32Ro1YF
 OiZ5Lt0de.X7K9L1cXSRtaM6504IC3p5rvians4ohtQzw_1MFnMdMlEWaPuedHosubMeoqy28.vp
 KjwJpZPaxIlxLVge.nuDqCpCFRvsLhkBOyU4ZD5BzGwrn1gzQRDW7pBJ.P1cPmoqxaQVABLJhGhv
 gIzSy_i_c5ql4pvEBhqnMjKgw3jqrqr_n10njKA.uU.QeiOwolJWhTCtn6DgAcmtJGWVae_Bf0KZ
 hA56PcJ42yxXs3od0PPN1c2m_d_a3U3Dbo.1_A0yagmW9WXBfdCAH4e_nDXrH6MXOZ16f7i2s8yk
 sFQHq19_n0fwk5Ks8bqawa3Fso0gw3LdbzfV_SwMQVSY8yroimQJM8fio0OvyByM1MEO8TLvWtca
 GKMWaSPjsGeXg84OfwaCllFpzlAs7PkwrqCrCmz_VTsHpTGfK2cM26KgBcY7SevVX.gcmQAR7Yns
 duCsZr0UNR1iDSzsdvZlARb2VjkJPP_GE_.HVdmy9u8H_frL60tdrejyqof5roE.L.7KoocwrWlM
 3LDPI_dsUO5yXPo2tZhJB4QvqGUfeRl9nmDOuWp.scn0dNa_h7Cq8mMb3Z6XSwu6GRTkmYYKlern
 gj_ZjLmVbP.YCwUygEXBy2Myb5r50GKOWEEkll443ZoPZQ1RCdiHcNP.9Jfyp.sSKSbl2A6NOkEf
 EsdOGKnbAX6VMjEJRUtGpzRg7QaoFo2LtsGqjso1Liu8SL1NXd0vUlK2bTi2FF07rUsNSk2ccnS9
 ZREjOvdLyuj9lCC.urXUHDrGMWDRHIIREUUJlQhOuFAy9tEsUyBZ4FtMZHd3loC8D7xflvxrVK1R
 5.dBisO5Rqh29OO7w_WhyeOcJlslusi3tb4g3Dofc2YTWZEk9d3hTT4F9TeJTeEK8p9_lwBtiBPQ
 ouZKHIQnDlaQDTxLWlIRmb_4xPSM8vQrQA7K6N.toud4UW1w7_gPYZnnFBUpLjT6AJnmgaRFVIzL
 Z4r4j..VTt5uAXBj3xaOHiySpZmCPfoQbHnnTSqEwLrb2aaREyJOIyi0wdccpqFCRZak53Q5bMME
 wNg6i5nh0JSJnjZhfzOVt5LX.C3v7CI_c0Vj8R2NmW9ZLWRAg4eds_YiZhddEtCOX17rykAFEU96
 .DMX8Sd34AQ4zEKrYWpAfEAbkRABo.mAn7XDaxhCSXRq7mo1jemLiYMnBwMeWLNqmeYUWptZ_rl3
 H_ZPVGTeq_OAzSraKjv3eZVJAHJIGFX73DQZQ383eC0xIowFETihMFH9BPhLlvn5iCV1Ak6Febn7
 3PrmRV8Jm_5HfTal6GwetPAEjzMC28tfembmgjAD7aUwchhRt7gGh8Bu.1Bz.GK7kw83.l7OR8kx
 s83r1BfAdee2tCdo5TFKKjNYWB6HzQwH.i.yan5Yqvwff8YAsljKUaUDzLlS_jEIqh0oiMx57MnA
 BWqXSeYZI9TNJqKr_qMCYXX1q5fnRMXiSm9VJlYF9F5OWpqIK5VgdTvbn3lvJpod0Xijaf5PR1Ch
 9XenQ4U90FFdTyEgx_iI5qm7fkpmJh43C5uZRa6N2FYiTVsDm9hZSsEaNg1hJlAk3Uvp8LixZZul
 W_RyOM1rrhkRUeKEel4T8RpI9uZJJEfqKWokE9cKgGtZUKkgDLkWjSnHMh2ep7X6MjQI.8XQm3IQ
 wqAOVIQcQha5UZQBujBB9sBtPu0RQxR4w5muxPAx1B_TsE1ZapeKqSwwfyHGEe5Xqgiw9pPV4kTL
 duLnwQVeNY8BdjIDZRD613GluDtMqXSs6mWk9zytBcFbwmHIbwBZ3t.Dlo0YjV6gDS5.WeBzMegA
 4cfIgJyOaNO04F1ilL6HmguhxAShm_EH4.IMPf7It9kODE.7n8o_ntLMSXp6LNu0i6nV7BpEvTEo
 PMZc5jqGXixnvnd0LRmBWwsrntNfS_7v7CfdAur0f66DhOao.Odz1HRok0O0MNLBvk0meTOux0Hs
 2kRdZNhqsfIXJBlxVO5TkRg--
X-Sonic-MF: <mau55@ebcon.in>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sat, 27 Feb 2021 19:26:39 +0000
Date:   Sat, 27 Feb 2021 19:24:38 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau55@ebcon.in>
Reply-To: maurhinck4@gmail.com
Message-ID: <593717815.313273.1614453878402@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <593717815.313273.1614453878402.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17828 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck5@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92021 The Maureen Hinckley Foundation All Rights Reserved.
