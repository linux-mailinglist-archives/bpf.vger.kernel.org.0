Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3108C68C33B
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBFQ30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBFQ3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 11:29:25 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDF27495
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675700963; bh=DHkqyunjk/SjTiaFlMuP+tSu1dS0VWgA9YO9G6cCCew=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Sq6zFlbkVuUawknoRFhwRBZ1tSTLw6dQ+ksdgefS0F3IziJKeWskJnnwoqkm8ro/91Z71GE8x/wOhmHBjiCUj6Qcqfw5lxe12ht8lA+bjD0lAGjWBewJPXf7OY3U6+RO+H8vveSZN73dWukx048dafVlVeJNgnNhW8wEjdHOtVU3v1QoGoYvXlpZoAjhrdj5OUQhCLNznbyNOffnzUes2BM9JDLlqvCozMye1B4BL66omq3p6juQ16wLalkWql4XuTs4DVRR1eYbPF+pC4fYRzFgkYlADXgO5FM75EOkf531POEtA3UfGPOWB8U9/AeMc+7S8oD79tqF5QGNu7KIQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675700963; bh=JBNKwW0ISnwGgrDP4M00eX+fZ4kBpgNjLEc3ok3f578=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BxwEyQ3Eq+zrvu2JcEZJmYwCHHN3Uy5YizjvQBG1nU1UpQVKUrofX27DFOsfjLwsEUCarphOINAAPpC0e+Is93rs/7izu8DJFijWUE+ecTWPn9eftdhsK5ES6qucE5hv9o/zo/1zBD2b5Jg7j0EyWJjPRVimO8/2f5NL0BGUeWs0YtZUOZC2IDs+pbzXI+ZGRkG6+fS9SC+eax6XJFU48tm01FqzbsWBKZqJ0lcVLdad4dLlcvvxtPSubtiNrAW6Q4cz4qNUlHP2h/8Fsmiz1nDz7r7OwDU8VZBEVgnrAzG/024tgoivivaVmNsZHhTsrhPwWzWzJUf2xLU46k1CzA==
X-YMail-OSG: 9gzKFH8VM1lIcoNCRq1XrrZMFEiEEJo7UR3nav0FsQT3pX1hL8IInRl2fk5m9_U
 6qp9u_3Wt4Pq._oCXfmweFXoxrQQd1MOzhu1kKx1PhBb2ft3rzupqcANxk898R2W4UmsBWLeGzRk
 .SMy5pMqZmtBjawFeyjdxnJk8.30zEwsaRvwGU7B02cJb0FTp44PA0TNh1KBoatbCTVoQIipiPh_
 cBTtiIl0C.56DWzsoh2wUckoxv4CAz_GyI.Fy3GhDon_dfCLxdd.QKsoM0QlFf4yXUcDeblbAEic
 wDyPo1eTXaVhYODNAx0ewFxhK6DBzc9.lAZFMVJ8dhfFdqM3ieG8dvD8SUVv9GZkz4itY1UuDdXs
 3waE_uy.P40cqIc5e7roteekQoN_47VYezD7L5MQtVQopcYn3idHsdfaB6NE5mKRJy5q4VnWd1yi
 Itbnc6FcKKIavKCPuDV4J1Gz.pmF.L19wRzZRW9S7pf3SOMAQ9ZSPMdlpJkUvZbY3uEAPnDxuN0r
 5T3iq88ZnCCfJi5_25Xzc8n3t396.9uBM8HyjwGAIpmx0hpV354d5KeSXuMlVR36qldb8sBELZBJ
 A6z5Ng1BkMTCQ1g9pJYW54rOwHEu31qg.VrGl4MyAWDDWNxOW56bqIc9v4MCcKToYktQe6vbEplV
 tlVa04L0nmxq_wmDExKv_k7KZhbd1Udln2cw98UYYac6FPfzaeOsQLaR0QRTvekdvHiqLHVbxyn1
 tXFdHJcBgEQ7_2YGEY3UILPi_udP4LGmY0ya87_vpzHVr8QjYNYDeFDKCg45j1_GyEb4Q11uV7wM
 67LaMidnMZZZY.x_sYo3jgF6iaXo8oWwbhbdAsOk4Zu6rPjGKzNITHNrw6svYZkGJTDEglQm5rbY
 zi_aXquN9axtEQzDNGYAvT8zTwZEV3iOGtjU3C6CzIPDOhtPWf3R82LoJiWIBhtRtep4EwdGV__k
 XXl9.EZskbwLPZjD0fLejs744rPcBInaGVFlntPNoru3DpILGQtmPMnnULnEGQclAaO46.Prup.j
 mnLSomL9AeoHFNyDlIcSrIuc_9U4YGBc7YKZ.sqsf_lb64D3rzzP1ek58DK0mYPrxmyzSLvZ5CSF
 KHOH00UEZjAMdGIo50dGypkNJs5Y_UtUqdbmgrPsO5wxEOeQReg1BZ_PZzclrJvH1I5LzVUvP8U3
 KmmWRPCyrfJKar9wLQnL00KoB7MK0_1Z6B40Zfcb.PJH9Rn5.9rLFy_Tpvh4i2MmRMYwv.iqnK5L
 7itNsAa4qEIBqGfEz9o5Yay0ByDSOfyvbdw2Qvr5uvdE76rMunjsZ3.26_hfnG_tmvz054hltwyM
 YOpfqQkvtWLNQEH_UHQbS.YiwibbXZnX7pscnxMzbaZ3TID_8f_Hj3ozIeojxeeKGSkONkZfDuam
 v8PD7B07srcDhcypF7UahxdkZVHf2N_uQggbyD0QMD_ey4cZepjqdnI1FdkxU.xdhYW7M4B.KVEn
 UpmN2LED1jXSXfXvJ0uElFW.atmgTtJxdFbxyTZqnFaLOZhSpFUzcE_Vt_aA18pkJ93FZfztMFVR
 _YgFvUPasFV.I3_gQXMY2xT5.i.4A9Zqv_.KwlxsC3zPJlDf.SRONGUF29Bgi7TDw4XaqrNhdit2
 uJ6sW5qXsJ0qNmaRyhAb9avi9p4EW1kMj9NzpsHNnfTxBFx2VwQu8bfafzPlyPRQxFIsDHXG5h07
 Lj2tjjijQPk.pjIwU1JWCzjHMZf.jKNLE4zzgIuffNsLVIfbRRLaVAkTw7ozXV_rLCHs0272_sXt
 GJpEgYhBB4PycHbOXkNUWev8OISlbdDj9vpKc91Q0.l2HJmwmlQfPz4damsU2se4o8_i81OLhnHO
 hEHAQL02m8an2seo3uFDB8iRdSfXD83BKGRap3KtV4LGs8vkyPk5MnWO6H8pVhiB46uYzKLasfzD
 RLBcDOAU5aXTkjUDW_VUuBi2FDN45R1ndcolOsbsnLY1tFaqmj4xsFw7JzuYvDMUVyytE6ol1B_e
 9mysfuDTcrozlE5DGZ9tBKyAe3yrESa1fjT2zYJ3aM9R3lIZvISkNTmG6s23ga54Ic3QFc57zL9p
 EDsFVnvJtFd9D52csv_pYaTeOoN6tJptFfGJ55rB09xAv4.ce1GMYszdrZwK4SYCcUANicLe6Uhq
 8YYPBng4tRxEq5gKZv24J9LWryOtteN2QRFO5ZSxnF1ufB0CbnlMX420TFOiz2r05dwQqNuT5bC7
 l08pgII6UPwQM_yXUGaD9e3dDkrqnYwIDlAjsCaOMWr31ncwMMqlZ8Bxh0qiuribpcNSvfom9orx
 dmomqyrU0JFo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Feb 2023 16:29:23 +0000
Received: by hermes--production-bf1-57c96c66f6-lmv78 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c446cb4ecd826ab201c9abe64b447d10;
          Mon, 06 Feb 2023 16:29:19 +0000 (UTC)
Message-ID: <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com>
Date:   Mon, 6 Feb 2023 08:29:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, casey@schaufler-ca.com
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook>
 <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21161 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/6/2023 5:04 AM, KP Singh wrote:
> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
>>> The indirect calls are not really needed as one knows the addresses of
> [...]
>
>>> +/*
>>> + * Define static calls and static keys for each LSM hook.
>>> + */
>>> +
>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
>>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
>> Hm, another place where we would benefit from having separated logic for
>> "is it built?" and "is it enabled by default?" and we could use
>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
>> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
>> trying to optimize for having LSMs, I think we should default to inline
>> calls. (The machine code in the commit log seems to indicate that they
>> are out of line -- it uses jumps.)
>>
> I should have added it in the commit description, actually we are
> optimizing for "hot paths are less likely to have LSM hooks enabled"
> (eg. socket_sendmsg).

How did you come to that conclusion? Where is there a correlation between
"hot path" and "less likely to be enabled"? 

>  But I do see that there are LSMs that have these
> enabled. Maybe we can put this behind a config option, possibly
> depending on CONFIG_EXPERT?

Help me, as the maintainer of one of those LSMs, understand why that would
be a good idea.

