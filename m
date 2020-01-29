Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDC14CF7C
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2020 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA2RTM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 12:19:12 -0500
Received: from sonic310-20.consmr.mail.sg3.yahoo.com ([106.10.244.140]:39379
        "EHLO sonic310-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbgA2RTM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Jan 2020 12:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580318347; bh=IqIi6+3mbOnh5cHcnEVkCYtF9t4fYHH50re0YVAJvic=; h=Date:From:Reply-To:Subject:References:From:Subject; b=iK27NEnGjHUA34U/XBloGoh4FHX2UyAg5mWhseqolscXlT3TtZ1e3asTCHeGK0B1X8EZl5+mvt5yYiITjQC38oZYlLSkxtVgnorb8r4WRgqVw9UnkXliGrVS13HqPG4kgjVwbgjPqM7Z/x1siEe0e+NBJOd3f6PRwaPowNsgXCpDuBwjp1dHKHbD5y3wAehYKP5T2kKEysj9jZUQKIVA75M0VZusp8tvu70rLU6DKtlWQLpNPrLgvM57r3/tm0YjxF6OAaCpu8AXFuNm82ZzVoMxlbTTSauP2v3Gif1ullvR5j1B7tO8y8KCUv6QAHv/2Xla3yFEP8jeLwx5hiRckQ==
X-YMail-OSG: PbeIP1gVM1k4m6xJ4IKvtPVtkI7W.ff0C4oFr1eZjg3K4jPhg7kEQdziEZOgwLT
 zy0T3JUkb57Ed.osya_GWD5Pf4hW9MzXBvItH5VKOOBEl9.aSdyuSF5I2z8KZkQnuNwMrE6hoHnD
 4nd67ECbY2xeZ8kU81OKJhm2qJm.5aSUlHvA8.8n0_VlWABRWfiRMSPhrQOztwq7AIhcGRaPmVCP
 pWtau.cwdtC3z4hwBkbg54n7cWE95Su6JXocIi7JOA9MwIQgiU7UX2fw60lostkKROZzdKmCOHCr
 _nXt5UPKFVA3xL41WJx05dJAM06zjPizsxvKXWlDNWvB0bya8WR6o.tJsacI2oSNjNMAZcX81edu
 J6J15gnLHINZHpQXh_D3VvkOXMUx81zHNS58HCKQP_ptumYfZT.OSFyyYp5W2JAWfkWrnM3cXm16
 FwnSWw71FfaTDcOqtTeTR_cXvSq24wvbokUnLE7QazNWJDflRUy.7X9ksE6d9id0dhCCiwPhKPV_
 OMsVwGZHWDFOPYVCIPoVw6l31ThG4B4v2SHgwTNR2BSk4Vc1hWwRSLw2523zYWee15v6X2QNDH0W
 evbuuKqROoxyB0E8_lbG42kxmt6DF4jeHe8ADy6WC5iN1YZyoIUxBxecm1NhefzD.CIl1J0djog5
 EENV3Kiw0bzPyrOXKF9R.10NzxTLhskUqBJAsV9se6WeRPSylEox1pm7.f7bHXjEzY7D3HRFlckE
 ntqdKElarJ0MeB85pDppGgPmAsEiya.uiVuB1vYAuJYGvlRWkv7R7sa2YKA6ORxfjYq.IkKD4QX2
 nsxnl9xK91GFQ7D6X.xIm8LjYxXSLiL678MPWh2Cpu4CmFkupITZ1rDYoLlgv2zsE7NtZRffqFFi
 h0lwNCs.sNYoM10fvnDpMSpFyBWUy5JIj3lWERIpIAD3dDW2ED7rMQQqenJF4z6.d5k0t91O1WFS
 J_acjiTVPaqqHAt6ODZj1BnVBHRNue1IJ0MPO6Mw56ZPIybHuYnW8BPvRfj0zVUJ0vff12g8tKj7
 YZJJWB4BICvCYvZVulP2bsX_TCU47k_l_SxjyUvUghya70q5nM27rgB7PZn9qn_qgkPD1Z.YTeEl
 385VIir17R6Ed8gfL9N5xJe48pCn2l94qrcexV00PFjYOCCEVTumLvjPniQexRnxPZy6BZifk0_K
 K3KcHY37dwlvC3ITxrT98ao7iwAwfJKPSsRT226UlCz41b1vvD1JMq9RnlqEb5_qu.5xrsqcEegr
 s_yyxTcqHy7AP39e38JAqLyJFnB6k2Ca_hmgJHZiIVSfbY.BnrfqJ2eh1ZGDrdepJCV6qtC2vUbW
 rAZfdMtBvvPbUchvvUItnSbT.TlMfPU8943oxv01tUuiR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Wed, 29 Jan 2020 17:19:07 +0000
Date:   Wed, 29 Jan 2020 17:19:05 +0000 (UTC)
From:   Mrs Aisha Al-gaddafi <mrsaishagaddafi18@gmail.com>
Reply-To: mrsaishaalgaddafi09@gmail.com
Message-ID: <2089168415.843734.1580318345296@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2089168415.843734.1580318345296.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15116 YMailNodin Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 AVG/77.2.2156.122
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Friend,

Greetings and Nice Day.

Assalamu Alaikum

May i  use this medium to open a mutual communication with you seeking your acceptance towards investing in your country under your management as my partner, My name is Aisha  Gaddafi and presently living in Oman, i am a Widow and single Mother with three Children, the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi) and presently i am under political asylum protection by the Omani Government.

I have funds worth "Twenty Seven Million Five Hundred Thousand United State Dollars" -$27.500.000.00 US Dollars which i want to entrust on you for investment project in your country.If you are willing to handle this project on my behalf, kindly reply urgent to enable me provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address below:

mrsaishaalgaddafi09@gmail.com

Best Regards
Mrs Aisha Gaddafi
