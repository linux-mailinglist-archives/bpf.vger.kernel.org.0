Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF8168664
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUSX7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 13:23:59 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:43736
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgBUSX7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 13:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582309437; bh=gOhMKqzGn0V8Y6w//oELZyi0fPcFzlzxFDnKT/XEQTE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NpBCfn3lA/2gQexjbr76H9+u4UpTVT2c2xT8et0vI6qEVHzs0ZKWlrFSLbCUDq3aHS+tBaOqp5S57MnAW+pvCoHjLaDpiXEv5r2K02tfCWEfJTwPrA8HFmQOcOsDYCVBJU8yPfQaghCXRZiXx8NHUSxt3Nadl4Lf3c6zMA6aKCm8WlJXU5H4hxDmZiOu50rGcu33E8goc0y7RGguAKsb2vYsa78G6BCmLbcGNiqvWsM66ePvSW9aP5ZcV2/x2n8s28PXF49rcjfC036Nb1JvqwIp7QQtHWFRLcUFc9QRfn+KNl4ZqmC/ipjFBmFx7GYwiQXNyEfov5lRU2Y9zd3pfA==
X-YMail-OSG: UUmCupsVM1k7ebf5Et3WamgXbLlL6qFf.diymB7et1o_5Womow_NswYmGAlvlSq
 8omLV8wGkYSK9by0Om5HDlRLt3Tn1AR7pRZXqQm0F4Rqu30UufmF8BvDrthCcB78sIBzDJcvZBFh
 0TPi3CwKERfDC9pq.KRXmeJwOLh5mEibLuvMAyXtOUo8RxWog70fxMYRsoQpcYMpx5ceY5I8wk9A
 ndxSjTUHhddFjq7eL.vWOtckho70DkKQ9z2F7NRoDGM_yDc62mcpBdNhYS8XrHfXWCaKebMRoygm
 57ncj2sWjWsaapnFYAJxGE2cyCva4it.s426RvoMrDIgrLZZH.v3AsY8TmvE9yemUAfUH53pqkmq
 xFouQwkKZbc991s8kQZig4enkx.4bUQ4MlXsxapaLvgkpRS1v7V7_gUMPISqPo5KyHFif8sIlkuw
 HBQjfthCTxRIoCIwjsI2AoSO1itl.WYOJ6dWPUVZrFF.u0iVVei4nEggukv_zqNCX1A36CnAn1Uh
 PlPcoNu3hz3y725w2QfwIFHn2R9awt8zqnW5GB2e2pCwChhoEAG4_4SFh9Nvb.P8xn6ocb0ljRRI
 9BdZ5zC8P2VMPJ2mQATpGV3wIXSbmDWHA3Hqe56xfgtYfVonFe7EDnIEyKEV6LaQfl1jjOHh0MqB
 oa81TR5GbFNI_3A2GLBAd9g1W5Els5QK1BQ8aevYqS2_6O.K5BuZ6ek0TeUUlhr86WH_Va9xVqcH
 q4wBH8ONHDiovNdQKCnjFh.aqeVVP0cUdCdhdqW5geW3zgFcCRIpg78WoO.l6zI198C5hlpjpUem
 ZOccs7f0scvrX9FmlzS4ODPS0EZwupVp6aKtve12siqwVmCi3i0c6Lk72dPfQHPsyBCslPgdpbBw
 nCgKfdCWBgsaYurmU0Px.npQNwIoPGK88Bv1RjJNiIEj9MRKY71.gTvch5L32Cppi.9LsjDUfpCB
 G61wnCfxlgBYZk5B5nvRwcVZP0pNZTOzDVHKh7MAlYNY5DLnXZ.kJ1qMLnwhk_P7Tf2eTnGdycaX
 5mZElY1JLRlGFLsY0fHvmUMJSRMobgWBbfTz8F.7UnA7vV2cxtK8rwaM3.kXJHJ5x_EAkNQgyhGU
 p.6q_Xymh6.viljSzRFt8MZzo6s8ZLxkqX5_LYL2dCLGTDSGf00LByVhQkEaO.yxzoKofqR6rhhK
 cjDgrpbXB6mMGBu1ch_dxnF2zFUVW7vRYcpr2GoepdEPG9JvT.4Kv1VE8CqHpZRyhWpkQMe32yS_
 mGjIzb3IS0VC.pJUe3VTTaVneLuxvM0Rh5q12IrGszkeolJr5Enb57uZvH4cWSNPw.IK2w52j5qs
 TDQX7Trqslj7qnDUyYE26e4k_wS41T5_k68tZiE05H5WpNQT5ImSAXIVfqAkruBu4VlT3HQ5LhTe
 gPiofKQCfS3o58_4yV.rpu6LoxGl2hleoXw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2020 18:23:57 +0000
Received: by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a4b3b99e33a6493e11de2915c46a0e02;
          Fri, 21 Feb 2020 18:23:52 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <20200221114458.GA56944@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <37fa4f0b-be38-5a7d-9bff-39d77c3c7335@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 10:23:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221114458.GA56944@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/21/2020 3:44 AM, KP Singh wrote:
> On 20-Feb 15:49, Casey Schaufler wrote:
>> On 2/20/2020 9:52 AM, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>> Sorry about the heavy list pruning - the original set
>> blows thunderbird up.
>>
>>> The BPF LSM programs are implemented as fexit trampolines to avoid th=
e
>>> overhead of retpolines. These programs cannot be attached to security=
_*
>>> wrappers as there are quite a few security_* functions that do more t=
han
>>> just calling the LSM callbacks.
>>>
>>> This was discussed on the lists in:
>>>
>>>   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium=
=2Eorg/T/#m068becce588a0cdf01913f368a97aea4c62d8266
>>>
>>> Adding a NOP callback after all the static LSM callbacks are called h=
as
>>> the following benefits:
>>>
>>> - The BPF programs run at the right stage of the security_* wrappers.=

>>> - They run after all the static LSM hooks allowed the operation,
>>>   therefore cannot allow an action that was already denied.
>> I still say that the special call-out to BPF is unnecessary.
>> I remain unconvinced by the arguments. You aren't doing anything
>> so special that the general mechanism won't work.
> The existing mechanism would work functionally, but the cost of an
> indirect call for all the hooks, even those that are completely unused
> is not really acceptable for KRSI=E2=80=99s use cases.

Are you at all familiar with the way LSMs where installed
before the current list infrastructure? Every interface had
a hook that got called, even if the installed module did not
provide one. That was deemed acceptable for a good long time.

Way back in the early days of the stacking effort I seriously
considered implementing a new security module that would do
the stacking, and leave the infrastructure alone. Very much
like what you're proposing for BPF modules. It would have worked,
but the list model works better.

>  It=E2=80=99s easy to avoid and
> I do think that what we=E2=80=99re doing here (with hooks being defined=
 at
> runtime) has significant functional differences from existing LSMs.

KRSI isn't all that different from the other modules.
The way you specify where system policy is restricted
and under which circumstances is different. You're trying
to be extremely general, beyond the Mandatory Access Control
claims of the existing modules. But really, there's nothing
all that special.

I know that you don't want to be making a lot of checks on
empty BPF program lists. You've come up with clever hacks
to avoid doing so. But the cleverer the hack, the more likely
it is to haunt someone else later. It probably won't cause
KRSI any grief, but you can bet someone will take it in the
chin.


