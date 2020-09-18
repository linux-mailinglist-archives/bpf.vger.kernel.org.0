Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4982703AE
	for <lists+bpf@lfdr.de>; Fri, 18 Sep 2020 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRSFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 14:05:44 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:36982
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgIRSFn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Sep 2020 14:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600452343; bh=SmJswVZNey4nynVHmLVAlhPE7Cm0YJOK+IjBlwglVFc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=iIH6rbU6LJXpefXuGeaqur+XFmTGUOwDm+ChrXtSbCCOoY3zjdbLKWfSJ+cSG2lLgu2fjaUDu7HN58SWp4Lm3OMmwbFN80zzOmHlLg75UuGR66ftt93YLzxmqYosLkRbFlocg1wb1n86CCkfxIyAXA3gBHaYQ2aYRtwBwUufrGGjj36Ee5nwUiqG32F0V6nJDJqwIdv4eQjuFqwH/7s40ZBBl9K0JG8QWiVV1uBo4BWwoKiayEIIKBVxw8U871yzVLgyzBvmXQiZAWR9fIhCETlkQ4IbKQyaOjivCIp8Tz4qXL3W9YfxxMno918l439UtqAEOc7sdv+fZEiqTNvEEw==
X-YMail-OSG: 1Fg_fQwVM1mc1tnOJ_IzT96_FH40vnwMMp9WwxsGrIlUOIG7lZJJnbuHaZ4jA1c
 lK.bFkfww9aEWGdW0UTUsdRorFSdIXKAVZQz2vJsgoBRp9mpt6SP0yYy0Q9altUhob.0NoMNJB1V
 EPnZatCtuEs7skY.SC1qiLe6FKMcVEO5GQjXidJBe_3YA9I5PC_wG9b2O2jfwKyC8AU7lTfbCxTb
 N7R5LWWiMndDhejc7e7MtdeVPmuL4nj7.o19FHiefVrd52hXpl8KAVO6d.Woz.wintzpPHlv_ArS
 ts_EBxJcMPrMM7FlfFnMZdyQGk6ALpj70bWIhqmd6RVuk_NgBvhgmP2ImGJJynAXMmINxESvD70v
 lzl4RkZkCfjETOdc7NT2HAVG7CLZqMhKrTxyVW9wbER.HjGnKpHUemPRPMKw4D8UE0MtYJRN6ag6
 Z_bDL9SW0ZJ_zbsr1oDCuZQ9IICMf0f6EPUtFII9qd84hyHWDCvxc56ML5bRwyp3xwqrCOffLEjh
 VNp7Qz8Gx2xMqFVl6BNdtA_E6XMGrDazdPbewfvCt4Y.xmXVVqXNwj.zL4D4IQBzTNiZnpd7iIy9
 D_FVOyb.swvPBBIZBi7DFJxaV7YqlzUQAE_mxSBUcwlQ_QtMbYC54VY_.gq2.RfSYYZni0Phq3vi
 V0F3QhWamTvWK8PdMjPH2sVo31p1QvXbvXqtpxLYaVK8r0kIhuKNJ7Ik5wC9WpoVVTJ6U9wKQoKX
 uXnboGS0VHQFvnEdzqOd53nfNqea4raLm1Nw0eDVMOJtghlgIDolXBRRwE0jlDORHfA64Q9FJAOc
 WoYGMlNkFte.hveDQKCSy2G6hlrzQQxTHTkGQcTiPT8e2OizPLxVxAuvMY.NJwYB7MAvCu3JR5XO
 0l8liUTDbD4n2hhT1QKX0ofysYawk3Wtq_GzbNe8T20iFopO8dRbBJJmTvJIxhAMG3lmEEgXPbah
 mC3VADoox6lUElNJXKIr_Ru.tihoSxNyXyf4yjPcEiYx5Otm2xHPYAP_6aHkPPVr7.D6XBAlyc7M
 jxt5RYIedkpdrojczEf3Kme.zA34.C46qgXmb1xK6R4LDprG4JwWOovCczWN4_sQu.mnvKH58LS7
 E0pQQ8QsmllbhWl6asWyI4l4rysYayzVblRDdOrSxUHLICD4x_IO1zdvW_3dQ0AQ1ob7vKegPg6i
 zpabhAD7lvg3uhPPE.PzXQMVk3mb81z5_rWYoX0qMjuuUOs9XvwimzzVz_3zMVEXrrDPc9GM7BA.
 Rv_zfxFkMyBaF7p9UvM45jEJBkbzEnwpfz9182UVgBpageFh1kObE5oHwN0fa97KwRn9LYuXEVGW
 BFj9uwEO3b8OPhJIdqmMZF_bm1mqUgMK5mf8MOzIQ8J1B661yZo2ttzJNTcFY4RYisiO_9XUNkcA
 bjqruna3Aq9a_StTSZmHPQGYShswH_3qt8CMeKx5KsMn1fflX2Ss8f5ZT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Sep 2020 18:05:43 +0000
Date:   Fri, 18 Sep 2020 18:05:42 +0000 (UTC)
From:   "Mr.Barrak Salah " <mrcaraluda900@gmail.com>
Reply-To: mrbarraksalah1970@gmail.com
Message-ID: <767655269.6203881.1600452342755@mail.yahoo.com>
Subject: READ AND REPLY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <767655269.6203881.1600452342755.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Dear friend.
I assume you and your family are in good health. I am the foreign operations Manager at one of the leading generation bank here in West Africa.

This being a wide world in which it can be difficult to make new acquaintances and because it is virtually impossible to know who is trustworthy and who can be believed, i have decided to repose confidence in you after much fasting and prayer. It is only because of this that I have decided to confide in you and to share with you this confidential business.

In my bank; there resides an overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred Thousand Dollars Only) when the account holder suddenly passed on, he left no beneficiary who would be entitled to the receipt of this fund. For this reason, I have found it expedient to transfer this fund to a trustworthy individual with capacity to act as foreign business partner. Thus i humbly request your assistance to claim this fund.

Upon the transfer of this fund in your account, you will take 45% as your share from the total fund, 10% will be shared to Charity Organizations in both country and 45% will be for me. Please if you are really sure you can handle this project, contact me immediately.

Yours Faithful,
Mr.Barrak Salah
