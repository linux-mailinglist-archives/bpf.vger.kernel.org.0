Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648421ACA52
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442488AbgDPPdt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 11:33:49 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com ([77.238.177.30]:36399
        "EHLO sonic310-57.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2898244AbgDPNlE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587044462; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NanOUyc/9r/djFikpujWF8tF14PjAFuZcArPL9X8ZcEJ2Ah/fDqgBxU93sKOOnXxP9KFJHX3m15L/2bK6WKnH9WupN0YSUCgLRBsjkovGu4Ni73uEsCS5FlXHLW3xzeAOJg+/LIf1rZ0tZbN/t5wO1yNh+mSb+I3u1TGZLUZ8a1BdWhUwcrv37+Zkg6PocvbtrqlNuVv3Qwn28MIUxkt1WyVsziFYrei9V9iDiE5iuIz/g0LpTyTFu7f0YXOuFzbAzzwHdNQCcapiDMRQ7IqSqQlHrGiadqPNB9kO6thpRk7bnm4QCGYrqcBhjYFEtohc0NxuyarvfX/eYe0Id2R1Q==
X-YMail-OSG: _r.j.CQVM1kv27Mx68ZOg3ol0ZBGM03xo47eyAX2EhLMj86ieBQ2mwhPSgYS_2k
 wpsie1J_ACmv.2XTSNGbQLiePt_BwzLfT7uRBHqpQug7sckJxbT7g1rM9te167hFbO3hvtq7nQKm
 q5yWMp_0PQdYPLFpF9MnYxchwsgGxuK2OusiKqfbp31OVFtUbof0i_n65tOMUCh5.A442BysNICh
 iHDkzzrHFsKUKH2.oTOe2LDPi31IxKiz6yOLszm3K8hO8_1l00I9wscBP9PHd5sPdav7mgPFDEyI
 l1QauDqKyequMo5aNfNsxy0a3g53gqjMAHfE5IR5wdzw2O62jaf7bJiiHn9fAlE4R.Z1g9CPPxpx
 budht1hoSmlFMMEqpSpXmCWxyRyduwRGfXN47dXOJyKNPXBnCaw4aCTma2pcP2KZKSitoBPGe0Xg
 GDcl325Gh0hRik3nA1ptU9iRMW9dCr.o4y.86h2DyzMp2tQ_i3Vahfmi_lnSqt.DsDUQJF09OIRD
 fxrWULsZMkrh0BdDOvAu41N50Opd9zNGLPiWRDoWs2GdmL9mj.UPhp8Ur9seTR1JSXwNHp98VD.T
 5evh1jYOqUY3PsRpxMgGkqhgkFf5QCpHpIPd2j5AHmbq9B9QBRXt21fgc5OANthoCCfEo6Iph8a4
 P3ReIcTxuhUv2TiyqnNqo3lSLPfCwfgFxxrJakHJ6BSmpm0tmuEkkAPEsmD_eBadp6ppDiIuu21j
 k8kYrJqTxoYK20z1ACxuZ1_DCN7X4KKlVy5t.4Io8birOO8e2GHg1opfXlTYWRIm_76hM_CLzj6E
 Yj9cRvvcueikrXTBGq7TqWOQGHnHw8RbCBEHGJAoXZdpwKfZmlGvOxCjqUgGWSVQEBum8XXL2zxQ
 Oahrfu9zMwccny_r2ShI_SkBqjtzOOsBtHbqh4yRUI3eJ9SBLvCpy0J6XaCmwxPfilNRqToaoHG6
 dssqVxxyh0VzZY3rgKmliyB6hANNs58RGxWL5DzqaW6qQdj3nbq1ZULeQL0b0rFAAqTAbU31g3aS
 k7xYcj7_nHuek28u7CYk6tckPbsVrCSf_qSQszQhbqQ7bj2N6KQkXMrJURZLmeO0jmvXJWu3.Q5D
 3GDTos1JZfBQ08NhOfIgl7dVXQ_qnHO_7IG0zM9JsmA5oJsVHZiswhYbGVq6rpNfaQeojJlJnECw
 iLqr30IqV6j7dEgI6k8LgfslaD9UCZNvhAa4zDPHvKUr4EdrPCI41Ny85kphbsJSAm4O9tGunVDC
 KXKJ9FderRsTopuWcc9d6bjvAma7KBe8uTeGYs16dLeoICgrim3EHUCprL0VH2Y.vqR4Bzvs0IIM
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Thu, 16 Apr 2020 13:41:02 +0000
Date:   Thu, 16 Apr 2020 13:40:57 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaabrunel209@gmail.com>
Reply-To: mrs.minaabrunel2021@aol.com
Message-ID: <970478456.2949094.1587044457537@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <970478456.2949094.1587044457537.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.92 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
