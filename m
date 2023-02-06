Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1768C74C
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 21:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBFULR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 15:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBFULQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 15:11:16 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53971C7EB
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675714275; bh=2gC99Tl6Bi3qc7284zXMWuTmNLxRYVHyD45hhneoWwc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ssPQshCIxlCLaplPH9TFKhGBcpXhWyZqtOp4HOlrNtfRaDCF7JINWexWyPjgTHAiV/b9BjQFUqlT/vxjr2gvj3iLIYB61T74NQ09ghjWcV5P5fq2f9bbeLnfLzTx5xaDLuqwtKRGJubGyHBapm7GgMPv8MCAVgLW1G5Zp/SOdQHKmpKXhzDbkWu4NmN0l67HtHad5tb3Pr2Tlxzb1KBObgj5XpeR0f5HLjP7cXWC3g9wL/v/8cyfH/M5hC8A/FnGEWodIC3HZMHbpWVKiCfqUvJgbXzRqN2f4+XMzLbY++vnFpB89IkNMSBIPElZ5pcE6gz8K61+AOAikUy9EMggag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675714275; bh=e1liGNTlRaMJhnp/i3NoUGSmh4z+mxWz2MniAC8UOmZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NA2l8F9pNz1hwNVm0oEi2yGiVQ+q4VrJH9bTXa2g4L746cBbtw9Tu+n1XVNTqk+I6Ic9OLCCOoCkTFC+vLrOyG0bz8QPvIUfhNsIZF9eOxF2lNb1LQb5v1P6XLtSnNcZSAYXnjZORlkdNdqoAD1QzgT+ZWhOdClV/z3BDbAiFAnrSaKlGEFyF6Szyi8nucgjcfuBrkyT6osWnIQEKQIhduxFZk/a9/Nf44sEkhXUcuhg7R1kG77LIz5iYRwKFC0EaxjQigz6VP4tpLO5yXD4AAJYom0y4rDEdDbJCKV/so+kusPecOd7DO16ZNEkmb1L5in+KIbh6OQQmjYriw4vfg==
X-YMail-OSG: UNjZjJMVM1k8fG9jIpXVp1tua6qH2WOuXpWbzr2yjd6XyDeXGjjhTvKZJ2kjL6T
 SK0mkpUBBofRTfAdNSdMGasPmiOGgLI3HOsKIOggnYH5RuPdawS9M90Axb8BIEzmo_LjjwjNcbaO
 D9OHY331mIwaAwAI6YF.ad4WZeQDLRvsgAXUNrahc7E6wGEoaWnIMv9KNbaMxuNLe4YApKj7TcvV
 NcbqQM5qtLc_IP38ZBmb2U7brMaXYiSRrrBV_aqeDjZFhSC2AE0M2_maSiOHKZokUPP9EgikWi1T
 EcwB3xWsqczgyN2szSN54gpjjD2kyT9lDJQIKTpNi5wUCmjRIdSZ5XYySETNVWiXAkLsx4LsGT_U
 vFGk47TBLO_VQjwz2YL6kJZ0BvwC7CZkaWOYxuPzOI4jk0_vDrod1yLYugzOoBy_m2WxXR18ZY2i
 sSLTPb0xj2y0.e17R_TpDATcW0ceNZyLBgAfV7Umi_ZBqc7.g7n.6U9W0vym4309nkCqP.LQZr6y
 eMY_VHpbdszj62myf8N5O5m323XolbkZ_DQZ4vWPdHGB52ofS4Mp76N0S7XHQbnDPYRnXKmOWdAp
 bOjJ20MKx_L9N3jWE.02O.SFBeDqVL_3Hw7XzyUJquIkBYCruMP202u5imFI.ZkSi0jxUlxsWNSf
 hoPpZAoYZJIbVPfU3WuhuBMQB7kpFH0uCwUBCtB3zsn9EuIyj2ILwUyHozkzb7m827sl04Czj4CA
 rYTQQR0yL2wosGzWffKNE6cymCetuHykaLsBAMvE32j_cDkiXu5UjrF.U5ZkppdiYH1WsQDEMtg3
 o4zgiFoCo0QeCLBUQE..vX4832wlVC3BUHykhS4yB4DCutmLkM0UDTM9CDBd3p6BvH3uzvqZQ73p
 2g_otfPVxJO8i0vu_PAkbvMsXgYvCZ01RIwvpOeaDLzJhR4P95qD1iSU41nyuwAwz366KpWHQpts
 6pOFBPd2sCyvoO86AF78dhkuI3I6hCB7UAREkY1XakQhAZ__hZwrVQ9blr1f0VpeP1Wb16.8jscB
 qn8UgY1ssyC4F6_vxa3pxJtWDATYbmE1eBnsPxlmWym3s7EnHYPT3Cy0hQiOqoSzbOpTC_0pYd_g
 mxaqrQSjQqc2Dt6OSgLm3vsGTeZbxkse2o99StxvKWohfroNM6T22sBea1JxvXIcJSiTwuM7dghT
 5pjajyDMdJeQkuO0Ak1Z1i7BKNeIZGa.1JDUIDIdt7V4KqZmCbsyZk9bUs2KDHBl_CVaEgQD3uBK
 aIz0wGSd0weMmCLEKn_aMwcaVvkLAiq6tl8SWx2IOV.JjzdCMTKkjckLB6SR50I78QipkLNw.VrD
 MHwOHS7Ulns16NYa8x6f2lypBgPRpaId3GmGfTt5PjLjADfboWNipobwa3hPQwaoHgJwVFUQTCCB
 3c2.VRjelwfB9sRjaRUZgDfuUTfU0BeJ9oQoYRyE1tHyN5oxu8JKdFvr0Cbqb60BQ99Eyxro0ssq
 VfLMl62V0Uhn5ubLl8RQwWT7SLA.l385h6ErgIeZ12UPVJvtLjoeMjH9KZ32iXjiikDSkKYqoOU6
 5a.V3p.uKjn7Wr4Jm8e2OdUmxS.yD2j3miysEoy.lKNanPeZyfLr4GJp6yhL99H.O6dFk.qUA7vR
 sI.MiA8fhf0W0_OZkF9ghxCsWt5iBuJZ9JkpEsVXcPRXOnqWVNTDwUAMwBRh1y4oYQ3hA_wNQTIO
 582mz71r.f4HR1NljBdWV2KYdukAw86cJ3iXAkBGoZr5GVIWq7Ibr.PcXE8rymR.9KMegHH9C7d.
 CqXdDBioxejWhW3_0Ar8NusRcJVrl9G4_l.nPv_Syoa6MTzWHlQqQYcFouyK1s5bT8zQHTkr0kCh
 sbHnjcd9psN1.8MqOIN3xNUa7dNYvX0ks9EGIDa7tjdbHQ6nI7Nj3LE.uunhFhYqisFbLGsnxauO
 XJgvUR7i9xn1oerCCNLiCbdBg54gVL.M1e3USOScK9qYx7ZqKDmDlJeRK1LMesiDlWVlCMp3iFEg
 ktYGfHuBQo7vc3VUyM28KFJyiH1LxSNXl4ygYLqeHquI9OYq7bV_B1MtoXEd2I.t0fWUFg0wzXed
 fNynYRmVSvqUcfuLurXXml.2SEkMZ2n_Vx6u5WkwCaTo0Oo5GDF1Rp18aT_OXgcLZch93zwYeLjn
 KEH2izHZQgmyLOw1lKNRxKnIECtZK2eNKbfNQqMb1D68gmZjZcjpVtV8alqmaGoZEgp.vxvOvEcj
 YXENN5LqNkIHC2bMXrIhgLHkzgPVqnSd4Jf.8lCSmYz4JyfohaTL_Gv..oB_WW0LmjI4Mive63VU
 Cy.ulFJ2DrQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Feb 2023 20:11:15 +0000
Received: by hermes--production-bf1-57c96c66f6-7qgxj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f21b2013dc2415aad785c1b85ab9228f;
          Mon, 06 Feb 2023 20:11:11 +0000 (UTC)
Message-ID: <3a53f633-d0aa-2ca3-2c12-9e6d483502ff@schaufler-ca.com>
Date:   Mon, 6 Feb 2023 12:11:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org,
        casey@schaufler-ca.com
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook>
 <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com>
 <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
 <CAPhsuW5RiduusLJFTcj6p78aMsv7_XhepvptN7CG+9oV8oHSiA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAPhsuW5RiduusLJFTcj6p78aMsv7_XhepvptN7CG+9oV8oHSiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21161 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/6/2023 11:05 AM, Song Liu wrote:
> On Mon, Feb 6, 2023 at 10:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> [...]
>>>>> I should have added it in the commit description, actually we are
>>>>> optimizing for "hot paths are less likely to have LSM hooks enabled"
>>>>> (eg. socket_sendmsg).
>>>> How did you come to that conclusion? Where is there a correlation between
>>>> "hot path" and "less likely to be enabled"?
>>> I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
>>> hot path will give more performance overhead. In our use cases (Meta),
>>> we are very careful with "small" performance hits. 0.25% is significant
>>> overhead; 1% overhead will not fly without very good reasons (Do we
>>> have to do this? Are there any other alternatives?). If it is possible to
>>> achieve similar security on a different hook, we will not enable the hook on
>>> the hot path. For example, we may not enable socket_sendmsg, but try
>>> to disallow opening such sockets instead.
>> I'm not asking about BPF. I'm asking about the impact on other LSMs.
>> If you're talking strictly about BPF you need to say that. I'm all for
>> performance improvement. But as I've said before, it should be for all
>> the security modules, not just BPF.
> I don't think anything here is BPF specific. Performance-security tradeoff
> should be the same for all LSMs. A hook on the hot path is more expensive
> than a hook on a cooler path. This is the same for all LSMs, no?

Yes. Alas, for some security schemes it isn't possible to avoid checks in
hot paths. The assumption that "hot paths are less likely to have LSM hooks
enabled" is not generally valid. The statement is question seems to imply
that it's OK to not optimize hot paths. Maybe I read it wrong. I will hold
off further comment until we see the next version.

>
> Thanks,
> Song
