Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6578E68C5C1
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBFS3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 13:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFS3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 13:29:42 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4F23D87
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675708180; bh=Ov+NmRLHb8fX0aflnd0jIz1NSVpflU7QO4bEru77Hro=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ktWXFQ48zRN30E/n4eYV6UspaipLlN3/BvXn6x+9+7Xb6wr7XnpqjJpJnsLVV2L5aV2Sy/RpZ9kfPlryvpfBuO6lMgIgUdJXcIICxLQJWEpsqRbOLSHCh9tUb6nIQBsCdLZZ8eWJ4rTElgSZCG6qmS68pMPykm6l7Y/4aqsOqrFzrRo3NnTvvRIID+VOE97rrRdkfjJBNOuAqMrSxxVpJ7uJkZfq+Q3svbfvR2+LrrB4thJ9jtecf/FOMpVUaWkMsS5oDFKwoTK9gFyomsx2PPyhH6wV4lCaGp/yEBvm5i1B/bzqJ0Um894S+eMxw358QZVg5qGe3p18nFHZWNJgSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675708180; bh=uXcGSQjBCxGpG0zG3pktKQJzVsmm3Eq0vYvIyGJCHVy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IOkbjG9ssF6dUAr5yjXKp4I9/4xMzSPUe9t2rLqmjHt9NiZ0X9+vbey0G6wy5qzycNCBHtxb/f9vDuL6K3i8gzNKx5I6bbNMOrkEzaCa+graSL4pVLIf57WVwY5z4a0pyXhAg8hH3NpDGPpURofttyc5EDPSrO0igp46hf/7Dq2BF30GXAx2t1UmbepjYSd7m5iPk89dm6VO6lUXLEwXsr9jxKojihFf+YuePBqRsqEyCtSf6iMSUfTzbjp0Srx+aLycZDyU8I9czqUsoyZxLZgcUjmkc+potyxfyUni4QIjOrLDnINHhjgWuyyaKT72zNDy9jQOfm/o9yiOjoadeA==
X-YMail-OSG: Me9O3r0VM1mWnDFybR1Q4O8gG.DnKD72dGydOD1uGqWiDS.Vq.FcpjrWQtu.H2b
 AjMkorRO2I4KxfTKcJ5lokqHK7dAFUoBMTcZJ8PojjJsOSHuAmwUUKK_k97qqrHe889xEbi8tmQv
 pQvYlKCP9.IyRZUnJ1_ge69QHQNgRQR24zkoux4XtSbp9wNi3RU_vGn4lk_pZFOAr3ChpCyq3tgs
 aOlJc31JEwauIY._wGTa.kcP9LCV9vLcDnOxBVvOveEOu.BIj7s1T4pKOOQEMlgKWwSy4tBZ5apO
 QYfBE2wmzfyTuL1YU944kl4.DCgDgQxzqC.k6iKj9gpIa3K9ZuHc9JWSMf6eHD_Lsobnl8BxW_jt
 ZnIN8rkUpPw3hO_SvhojogtH8hsshWXdfR5k..VeX8O3kBXw.P0HGByvICEunHUKI_6vtF2Ov0E7
 4wL2Hb8McoHQV1AdddNygNyzvnhAU_xQV.XEyC3jXOIeTgKzHKzjwo3r2Q2RmeME6XqDSRBZ1LyW
 KJ.tgfIwPkS3aZNr_3OsCRo0qG0nqlu9.JM.3aTk6xy9eNFbFw8MND1e9aGz1q5Lim.eOu7hQKiC
 XdTWv3VEzXWIm1Dt6f4BaYG9EPtxiB2B20x5oeZMoNsNzJ0zN1vB50nSZv7wuZChpKiwDbTBV1YY
 R3.IBobKZRkSGTYRqQ34px5on8TlDk2XPyadmh5Kh65mDSg26H1NpWcxoOnmrfKnE65EGKxgNZKc
 H1TkXtqoC0OOqqO3ujftvFP_g_0eDjuekhU6Q_Yi00GPYcBjuv3sj.EMx0KoqbOhNX9UZUto9c.5
 Vx7qEwU0gWOoQruuTAN.6dTs_kDyKtAdgdzM92eh_gcRKVDLmu6pIXlJmF2ukoPb5Y_U.kvJ8dgJ
 jyIv2h6bX2hTVNchDrfDnH0VfVPd8sJpcUqkfietndT3Si5.wVCIeWO1SJjnUopO5C7cjq_DMP6W
 HB6dxuY4iTkG1BM63IxbnitMUQxnOkyedn3SXQDS5SyG88Uh8yEjDyPIX93wxZCBcXDyX0GG.zWn
 YPLD1j0vdsJWsIEaqu6V8W7qEibbTtoL_izg2EV_ZrRZZaneH3FVmaPmMBToek4fH7l5gZcE86v_
 9KIr4KNDALvnnSiuu.sHj6YfQdE0gCSOe8QC8XVb4ZRXTup7iHUfxKsQ00vup_DcK8kgZNdFl3ln
 ux.w1F3X91tNswAZD9bkUpChtzwEn0I9lC2uByN7RfLWpcYjUcn7eJnoQ56IcEUuRSUblLYiyrrr
 8Rx8zPXu.fPehhsVRvO5un7clDKRkecVPNg2hRhYYwVt_ToqDske3N73g_Fw7LHg4PBsjffpabw6
 RrCH_yHlyXJsS7ddxnu0zsCi9yYlk3RnEk_oKWmzfPi6YGsYcL8PPQWau_YZAdC1ZjXEwm10D4pi
 ctz9anl5iUnik3.x.ajxry_jv6F8.t.h0hsvblSwAui8mCmFo7u4LdvZQ170HzMBfQC37wUoQmkV
 W77QR4L3mjHwioUkGNCN4j1PaV7azLDgVoxdQ6CFe98Mwk0rxKSk_Lq7gpHHrnh9p3i6IbTJ_sna
 0fNQCB.rm90F1lYBYOyqIidal46x6jmHmWUn0A7Hz7Daji.q7TsTE9K.7I2nxoEjSWElHNJ6kbpP
 lyb8qh7AHgk4WWAoglStsUECW1EFLAq8WvOTZgnjVgD_3h_p7l26KqyuwKToVIZnBRhDDjF6AIkj
 IcWp79hcnt5JvehJQekPTkFSotoKWC2Ea0UXsqfl1.Y_im1NagHBOwoihX87na_90k63G_Bl_AZQ
 Zwj2n5hn9tp5huD94cHVIvngCeX7cuYElTELgMKEgWQTnH2lQd_fYfylGffdZdKf55u9yXDSVBor
 Q6E65G_NW1pqR19BRQwlWKOGsQdZBMCZkrHx1fdx8Yk4uWl1DlvbX66lf7svwinvjxavtfQdxjSM
 MJMMyBvE3w4nOOyd0qEtpEgPC1uhRdco87dM5FyiWy_q0DqE39xRaMR3lD5UWVNnlNIz1y0g5uMt
 2aCd3CDz9fFundN2uaflF_swaqYa49jXCT0hOAAWNtMstQ1zld5va79Ducu1Fk_uCy0JiW8qE22z
 1sB9ZHbBlFPwoUSMVr6N_GFGmEfzB7U47_6EYWrLbS1OA3G1_PYb46t.cgY35d1knz0Rfg6X6JRn
 _hSAg83OrN6__gAewF8SCyhFXB_7uTbk9kOLTPa0rOHUb8gP9hmzAjcnm4mwXVavDKEV89IX9O.g
 BnFAOb7ylCVA9G6eSSuF5dWharXkGibp8j4Hhj7nb46OtUd9eQ8K15fZkv.7ec7C8fAjx1beHLzW
 yS96y5CuZMw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Feb 2023 18:29:40 +0000
Received: by hermes--production-bf1-57c96c66f6-npzd5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e9befca87377a5e700eab3c3d2ee6a95;
          Mon, 06 Feb 2023 18:29:38 +0000 (UTC)
Message-ID: <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
Date:   Mon, 6 Feb 2023 10:29:35 -0800
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
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

On 2/6/2023 9:48 AM, Song Liu wrote:
> On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/6/2023 5:04 AM, KP Singh wrote:
>>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
>>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
>>>>> The indirect calls are not really needed as one knows the addresses of
>>> [...]
>>>
>>>>> +/*
>>>>> + * Define static calls and static keys for each LSM hook.
>>>>> + */
>>>>> +
>>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
>>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
>>>>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
>>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
>>>> Hm, another place where we would benefit from having separated logic for
>>>> "is it built?" and "is it enabled by default?" and we could use
>>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
>>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
>>>> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
>>>> trying to optimize for having LSMs, I think we should default to inline
>>>> calls. (The machine code in the commit log seems to indicate that they
>>>> are out of line -- it uses jumps.)
>>>>
>>> I should have added it in the commit description, actually we are
>>> optimizing for "hot paths are less likely to have LSM hooks enabled"
>>> (eg. socket_sendmsg).
>> How did you come to that conclusion? Where is there a correlation between
>> "hot path" and "less likely to be enabled"?
> I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
> hot path will give more performance overhead. In our use cases (Meta),
> we are very careful with "small" performance hits. 0.25% is significant
> overhead; 1% overhead will not fly without very good reasons (Do we
> have to do this? Are there any other alternatives?). If it is possible to
> achieve similar security on a different hook, we will not enable the hook on
> the hot path. For example, we may not enable socket_sendmsg, but try
> to disallow opening such sockets instead.

I'm not asking about BPF. I'm asking about the impact on other LSMs.
If you're talking strictly about BPF you need to say that. I'm all for
performance improvement. But as I've said before, it should be for all
the security modules, not just BPF.

>
>>>  But I do see that there are LSMs that have these
>>> enabled. Maybe we can put this behind a config option, possibly
>>> depending on CONFIG_EXPERT?
>> Help me, as the maintainer of one of those LSMs, understand why that would
>> be a good idea.
> IIUC, this is also from performance concerns. We would like to manage
> the complexity at compile time for performance benefits.

What complexity? What config option? I know that I'm slow, but it looks
as if you're suggesting making the LSM infrastructure incredibly fragile
and difficult to understand. 

>
> Thanks,
> Song
