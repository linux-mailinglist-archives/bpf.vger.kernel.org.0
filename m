Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BC6E560C
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDRAwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:52:10 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBCD170B
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681779126; bh=Nbsy0VFN6If15pT0m78u23vy9zJKwmD15mlDxP+zhaM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mQ2N7dk0MfT+PXn+NueegD6X4635nV7RYQaNUvp4S3wT8RuWeAjJdm9o+ffW5FfTSHA/CrSsgWfPyheMGpcU36L6OUe+SglcOgFFnZG28WpOrDjFwL/2uAEs3bAlMFZ9W/JkIJeXmv+0l/e+lcheBmh+SD95U1S9pGx+fcxfeFVHAqLn3ZFngIZHoN6bZYTo/Ddms/y+BcFqGQZW0HRfqhNSuJ8v/4KyGQeZQW2VL3vM/xa9LuexENxqJh6wo+BqMqOXbdXhHr2UQ7bqFUCyyZvjjDovZhoYxTf9RHxIZtiC3t0KeKDn3KjiS3gtOxEk1QKTofehzNX7lphNG/m/1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681779126; bh=nZ8YfRKkK4yR0BCNZeKOrOKyqXpBt6lJPiHb/30l2Ld=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Y2ST51bHhzgxP6X18BEcwSEhTuFX5ejE3FjjK/mSfiYUYjUm6OfJmfJ5tQp1VMrbqxlTgAYDnnTJ2k4hsVrrrvU8zyYr3tUyCK7yBm/fB2ZfQtOWJvYRozoUR+I8KvhUCW44cnXkGAk4nECtSCFNnN17RrCzbskyibt8A0c06f8YuaZ5fPUmjNRFW/NnaC3DeeLT+7o1msuGu1SeTLS/RwG+HMKrrJW5/lQdGmqd0W6cF6Kjafwaur+hAbeq+ZMUtxTFQxrlB/lPW8ErijSds0W5K4J+nSIASEFVXDDv1o1k1AqJpAxm/yNud9wVkQF5P+PMlTgW4tvLrIJQ9feLqQ==
X-YMail-OSG: buy3.HUVM1mewdzFBrP0azfvMLyUc5wGK5nSo3a.Xq7QCbKGgrdT2HkCYMjko.2
 2ODaRo4PJP6El4XPHOq4p16flcnm7iaDUj2Xt.bGNtftnkw9HGAoPQUnDAUF7_rbKpoJmqOLVRmC
 DRqxWkN36CkQsGCqjOWUvpOuOVd2kZ2fGg_C7bhSpn2oB9SeF6cFS6pRvlyQ8PAgZH69rCFg13ZS
 0VQOTX684QiwGnQ8g5S79zL53DgcsF56drlSGIngbg_lb905F3tSusIn4okB2uQotHijTAWn8r6i
 Sk0FBHvhTU2BEHRvJzqAvHCa_y21o6Ih.fZgPM22BEmk8h9dp26coF6m7gcXa7VLxe2_ZfnPs3Ij
 oLTB_z1RwckqtWoUwmPXmue13qu1lx7Lv64ruAdBzQwXBrj65are7.K1DENV0XmcxkqdGKcj9YqG
 bg8FZfti67yPc_IjSObfnD3MPD4OMBFmLd.9va126Q069_IDLOKfRG8qxEULAMBLV4GUHIp8K.f3
 OUeChWXpi0ONaWA6iXCcqEWi1lSJnTF4UoBvehCKvkMXk3VFIqnleudhC4wtibkxYKyNAI3Bo2rr
 R_ZZ1YbYo7338F4noEG0a2jbtJcx7bD013BwoBFiEv3L6EVo97cMEd8J08bBHAvmwjYcePODWSXV
 mDWXV04H1oh1rPaNeEUxz8hbbEFDZEZWJy3n_pZwQPMZ7p7GaVYP218sEqT3V3FNbJH7T9zhJNs8
 1KyqrznSn7eQBkp_qvkNus0AKuksiQY3YsGbNgOdpSIVN7lCkYT.pcajG2.wrDDIv2MdPuxyHWE.
 znonLHUovhfugNOeJoeMhiZoGhtw4uEckb9Nad3icGoTHGj5qy4jxcT2bDYut.UnUlEITlvu7yv8
 HYTruKjQvdKFBGzdDPtU1PXOpMTdXZgZiiEh7SSelOFV_yrs6bENzOUcBXbjlz.C6WbAvJqeWHEz
 5BEG0Qmw45mqBgfYbxuML9oVFqLDZ4VRQqGc4Bu510RqA0WpnF5KKRax7lo5NSW5fK97jZR9Z6pi
 51Ucz7SoXTOp420eKcsSDJMT1WoxrM5Fi7gpjN3uopQDnvgZx4ChKc4.R77z2izdkrFoENArV5JN
 6XmqI5J1OBOEVfzV7nS_gCnIlzv2VYUuPAoB6yBIbtDCF8F8c_mMDrjmAunTgSycC3GjzJWFlkMC
 Q_6i59J3sampvmS7kHjuLXOAWdIRfdYt6ut4AXaPtOFuIkTPzGbwLCIDE7GnBS2BNPbn4KBorvum
 J.DqNdn53CTA9shyie4CUhioUqaUv43AwygeBPcG4BA9OAc1ZCIjzHbzmtPeee1nA_EHCkc8QFcP
 5E0ltnpKV_wd2hnKuuLDvuC0ijHh9zP7Pfhwfk1JTtQtawGdF85zpaeW3efKWZUm6jn9PcFlZ.Ub
 KU.5tDumNwbLFDpSMSbctLzyhSTEJjQtKA5obMR6C6Y.THcO5lgCB8yD9FFhvHNEx4fKHBhgVxwR
 c_Tn4qB3EcICJhSDvh6WRiydh10LVebsAJxUbQygiDoq1GjoGHOx7ZDv6.D9fdvO6hZtgaHy.C8a
 KEMext4n.oGYB8zvbgg8hX85AfmEPn5YGPLETqYcBTzjeX9WxjMyMY97bACxTQFade81G4OLe3B4
 q7YaY4FKzkdi_ImJMOdvj7KL3qZNb6bB_I_9jBUNq6.J3Yql0fBgIbV03Mx9Epd77C8mlhs4lEv8
 VmUHhrWCrco0KPE8KLWzzcNQZ5f_afdP.WAh0V3ihv4s.QPJj7.219rf09ALCoICGfFP6786HZTT
 TXdcVO_BloTx_ddB0ucdOxNL1Ybb9OfZHAY48uhgzH11juQD02dlRujoQlo9pta2k_zADTWUYU8H
 hEWUvR2GPK3Y95q_KK8yTa5DACCgRY_HdJLbbyIfuzMxMhoe_hwRvecyEXovwu6pEM5iTpwyBY11
 a4Z6ZbrjjMaSfRLl96NFecH5DYPhAtT6tZ.nE7EmmF2NndqAllUT2dRl3vRuF8GdpjVho1g1l8Y2
 G58rVSRx4ti7xZFegB4HgVRWYe97xGCxsDpWAf.tuSLzyzgkOaxWcLpM4Lma0LMnTvsVujNSMfz3
 tWHcylBLqkvjMFzSQNVnQVq9gonX3H9nFDt4M7MzryzCR.t7N1HYDGgJqjmd.yw82n5AhePjsPuu
 SnIeBHWOo.Q.V_y3VrZqA.akLM08D8vf4aDJQglK3esQsLjJcK2.2tpcCbWzHT8hLXSj1EsCefHD
 m_TUwyCW3ASch10JvFpYTQI5rhSfCP4lnAnVdhfKxZNIS6XiF8R_QKGMrlVHDvJ9mtCZq86WPZIx
 rPlVGww--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e395ae4-1aee-4d1f-aafb-9f03dba58eff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Apr 2023 00:52:06 +0000
Received: by hermes--production-bf1-5f9df5c5c4-fgkgh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3d6a7b5eae83e84ab6d79974880bc353;
          Tue, 18 Apr 2023 00:52:05 +0000 (UTC)
Message-ID: <678b5aeb-1fbd-9060-d1dc-aa6dab3d5390@schaufler-ca.com>
Date:   Mon, 17 Apr 2023 17:52:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
 <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com>
 <CAEf4BzaaFruReHByj_ngz+BiQmKQGeK+1DsAzg1YmVnZxfADug@mail.gmail.com>
 <eb0a2955-0ca0-8b95-526f-3eb3dc720c26@schaufler-ca.com>
 <CAEf4BzYaiqe13fjYVQ0gbv=OXm+RC-VubGJhD69V11eiiELPDQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzYaiqe13fjYVQ0gbv=OXm+RC-VubGJhD69V11eiiELPDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/17/2023 5:28 PM, Andrii Nakryiko wrote:
> On Mon, Apr 17, 2023 at 4:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> ...
>>
>> The BPF developers are in complete control of what CAP_BPF controls.
>> You can easily address the granularity issue by adding addition restrictions
>> on processes that have CAP_BPF. That is the intended use of LSM.
>> The whole point of having multiple capabilities is so that you can
>> grant just those that are required by the system security policy, and
>> do so safely. That leads to differences of opinion regarding the definition
>> of the system security policy. BPF chose to set itself up as an element
>> of security policy (you need CAP_BPF) rather than define elements such that
>> existing capabilities (CAP_FOWNER, CAP_KILL, CAP_MAC_OVERRIDE, ...) would
>> control.
>>> Please see my reply to Paul, where I explain CAP_BPF's system-wide
>>> nature and problem with user namespaces. I don't think the problem is
>>> in the granularity of CAP_BPF, it's more of a "non-namespaceable"
>>> nature of the BPF subsystem in general.
>> Paul is approaching this from a different angle. Your response to Paul
>> does not address the issue I have raised.
> I see, I definitely missed this. Re-reading your reply, I still am not
> clear on what you are proposing, tbh. Can you please elaborate what
> you have in mind?

As requested, I've moved over to the "other" thread.

