Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0062A177
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKOSlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKOSln (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:41:43 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692D2BB21
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668537701; bh=egkqihs2sr0oF22jXEFl2ODKUB6NoHIRqyFESnR22Po=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KG3/FWNcT9TEoxHxWqSuubdZnALbuRRJE8rvpivuFRBId2c6fbf/qUeQvlNEFjzAYEYlylGf/XKCt7xiimD25ehwZj/V316+gmlSd3WYzRuyJz2AuiZOywivX4TQ6mtHdw/lWjA/7qZeagc2cKWu9ZJwRQhuNPu3vsvebwV7oZtMsk4Vuawkd4Q8dhgpKdreThXHCrbqxZrjfAMd3RIevqYMmVWZL21ZcnRQgp7Nk2EhxElqKrqEWTREXMqdY5mPxeJsaec9ODMVo9OUePtHHtrrslDgLo5Ni2hACgx4//WTIR4r7Slyt982IFC45xhGqq5MAmqrCN+pfCnBKYbuZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668537701; bh=GV9vfvzuRmUmikfPnShy3dm10p8aECsF1GFLC6wwqhe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Du8Tf4jDq9yuYpK3nYt4Xj3SWH+iFJPyDh58JhVpRJhaT2F20Lhg8i4zQfr9nlfS8M5YoweJXvgZl6RWJMhsVA2UeD/5QtZyS4ik7z/NfbqeXtOYMd9iJYkksEgDf83GPYg0KTzyGvt7obDO23MilXEQpAhtjK5ceXbmm292WWzg5fMOBKsE5ltFQH35TfRUQ6RBqMsQDXgoTxrs38BbIf2QFLQCbcvSxFszAWPGYLPo3H5yEeouS7qwINDoOyNeg6gkhV1WB/5DHQYCJOLxaYEW3PToBcC/+AosJW/PQmRocY6lZ+l6XxTgNQrkFhll0887wAUZcML4oB2lzxbaUQ==
X-YMail-OSG: PtPiVa4VM1kxOR.C3vYFXqjEWnIpTEK631Q8btYdK1sYE5yfvkGXYsC0vEMkrUm
 kJW4jGwC159u2920gdaWhS0p8PNVPsdt74GOlu83X8S8D1A_bPRmAMAX48GkUKTUdh8PMGQ7b.Uu
 c.f4VYCJQlqwqEXCL9unXRy02V_eZToqPjoaJdzTUgr8ko_lCKGAJ3QkqJxwfIwP4_XONgK0YkvI
 Vn5uts8XpZQRUkSZ8aOFQB1rS8_WCmCaal56eFOYb6ybrKqHsxynIerKOavQEndxkVKAEu5rFxEp
 IkKZLYpEno_jyDFzzVorrtEuwlbsStiIsRqFkmuH1Ne.8899WgoOO8_aL.Nw7l00zCjAyF6JQAr8
 3J3s7fx.mifnlR15EN9lsU3YcllKAn3fh6Qeh_UHPmhVzXksvKU8yNo4lQnVeT4kS_..H457gU5h
 HEZOITwd6upvPAUZJHmywbpamK0LOZQes3eeGjgWAfgztSu3Y0USoN2egZbVYhsmZ_hsazQUhEY1
 nFFha3ZcFooqxLC5QnF2huWq.nOj6g9ycidz1cSgmEXbYO256J5L64ktcaieDahoLuQwCIqSeZFW
 x5Nkl0oTqpqFdmm.lfr0YTfp8LLsgcwM_RuPFw8V3dlo7eXhsaH2OMLcYsl0uQglvSgOg6xmTpZu
 MSlzbAm26UFuJMXdbn8_NeCWo.IgnQ_CyyyuEekBS4FzdD22a4Em.V8ADwpRMd7OfkkVxvYBn0lc
 ZQ8g0fismZN3YMJgKkh219Jg1roRl07uf3MCFAp7kz9kQWRuCcp2RDBLO1BiTj1L.N8f79JzkMuH
 B9Tq4LQjgtk9sFYe3U6TTIeaj3KVcfGh2lAQAbgETr.P45NFvKbz11nxW.wSfEWUxj6tQr7ms289
 sXmtKxpjkuujxzPZqRA8iUd9BfzLUrGdMJr6rcPZ1yNA.mQMeto0VcX8q_o_wFay1R_Ey_ZEtjln
 fH3o0Cx_Giuy_irQyMUCJtHd9mv5E0WhchtTRpTxESWCd9qRWNjy_GBXdYdEICGh2ALQ2_pN2WPi
 hTyU1zzYGif8GoM6plwUhEeYGyx4caQfAJe9hUPZxW_o4owuJ1CHMfeBsgVXv7WM4ZHYQqIByXqc
 NLrxfjD3Lz92_5PTYonJ49RuiGfphYTrZeUBJfd5R7KCL1OhCwAIUyqBT9YVXl4PIbjAIN9xuOGb
 Ua91Dfr5evNZRfoz3oP2UvCiFbIRunVRg97KpZ5LWcNCV_Uae2SyUENa3d0iWH.5RRzsK6XSCqS7
 yTwuGCcvcZahAviN_6_d6Ug6HmMirEpCmbxpo4nJLPvnTAftn2boeScuXx6Xwt5NjAg93H0e9qFw
 sHUsWFYnSz3T1ZgcA344zPIKlc2jcNr3mna4GQru8gRpWAromOL4d1au9vNwMuKzM4Qa7KuXk4aZ
 6ms0LgCfHlL3bwqwf4HjWCVyUdBuW38p1H_vwuDtOIGz_1jlFmpv6CY6pCyk15QJ4hvkpHTTq6cv
 Hx6P7wxG5Wg2CSMgm3FnBUUCHhvhbo0F0XJ1QntTaOcZ5qOr0_9L_uJO3KaqwXCs6aZooB9tfkGU
 cHKFAsepsxB7qrsZq0HtP81C40eEvTOV1VEekuqPerFXfHnA6gFvwyxaNf4TY_8wHubAODrpYsHJ
 pNcEfuU361UaV_iJ6cTwFCqMCS7YJzs9o7dRyE1zMv3XEl0o7yLUZpOkWASgleorpAlDoYxACP48
 4l.2NGkIf9EazNxLOB4bi.siahSt6Rp2iRtkWUN_CEfzFRJ5Ip.lOqeithRfu27owY_BrXeP1FL6
 plIV88z9ZNQO.ed6Iqs9kpW4fi22sgRaBjCB89qoi17U6oQrYLjLN4BkJ3CoAIwxwvAAMNAzgL0G
 CzaXNePl3z5EDmJ.FPT.wPT_N96HfK3559Zr54YkDlew2vASabkyTfnMQto02j4.6kd65wTtEH._
 _hLpsUivZXlmcHb_wS9aITM.J50allH8gfWazZN1jI6XXvuPd5QPreY8uxzh3KTFSKIZ594X9.nb
 VjrzfM51Ptn5jg7VHO.EB4bRa6qiUL4HnSDLR5rQPyD2F4JhHiYqHgPpznODC46eo0CfYNoILPK6
 IPBGfhiedOsh.8h3e8f6c.XBgIdzv39.AVly_l21c5WangkaeVUszucVidc0ESRxFtsRohFconJU
 vo9C0fi50wpg9wXxqa9sxZuQWNawvze5gsUYGkOrVDuuTwWRm7G6PQUSrgjlSTFdy1oMdE.f_arz
 cO96EqJpUdCp_Vo9D3w8ZoPXewAdwYTmeEQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Nov 2022 18:41:41 +0000
Received: by hermes--production-bf1-5878955b5f-kkjj4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c17cf4ef8fd2f159571973f2179af8ed;
          Tue, 15 Nov 2022 18:41:38 +0000 (UTC)
Message-ID: <8a52c1ca-c7cb-62a9-711c-532c33b5d40c@schaufler-ca.com>
Date:   Tue, 15 Nov 2022 10:41:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC][PATCH 0/4] security: Ensure LSMs return expected values
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/2022 9:56 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> LSMs should follow the conventions stated in include/linux/lsm_hooks.h for
> return values, as these conventions are followed by callers of the LSM
> infrastructure for error handling.
>
> The ability of an LSM to return arbitrary values could cause big troubles.
> For LSMs aiming at being upstreamed, this event is unlikely, as each LSM is
> carefully reviewed and it won't be accepted if it does not meet the return
> value conventions. However, the recent introduction of BPF LSM allows
> security modules (not part of the kernel) to inject arbitrary values,
> without BPF LSM verifying them.
>
> The initial idea was to fix BPF LSM itself. However, due to technical
> difficulties to determine the precise interval of return values from a
> static code analysis of eBPF programs, the new approach was to put the
> fix in the LSM infrastructure, so that all LSMs can benefit from this work
> as well.

The LSM infrastructure is a hodgepodge of inconsistently defined functions.
That makes them difficult to deal with in any sort of consistent way.
Your attempt to make them more rational is laudable, but falls short of
being useful, while slowing all security processing to no end.

I don't consider this a "fix", and I don't see how it benefits any LSM
other than BPF. Adding return code checks into the infrastructure code is
insufficient. If someone adds a bpf_secid_to_secctx() eBPF program you're
going to have a whole new set of problems that this clutter isn't going to
help with at all. Return values are an important part of the problem, but
nowhere near the whole of it.

Please take this back into the BPF security module, where it belongs.
BPF isn't playing by the admittedly complex, inconsistent and arbitrary
rules of the LSM infrastructure. Your proposal doesn't change that, nor
does it sufficiently change the infrastructure to make BPF safe.

>
> The biggest problem of allowing arbitrary return values is when an LSM
> returns a positive value, instead of a negative value, as it could be
> converted to a pointer. Since such pointer escapes the IS_ERR() check, its
> use later in the code can cause unpredictable consequences (e.g. invalid
> memory access).
>
> Another problem is returning zero when an LSM is supposed to have done some
> operations. For example, the inode_init_security hook expects that their
> implementations return zero only if they set the fields of the new xattr to
> be added to the new inode. Otherwise, other kernel subsystems might
> encounter unexpected conditions leading to a crash (e.g.
> evm_protected_xattr_common() getting NULL as argument). This problem is
> addressed separately in another patch set.
>
> Finally, there are LSM hooks which are supposed to return just 1 as
> positive value, or non-negative values. Also in these cases, although it
> seems less critical, it is safer to return to callers of the LSM
> infrastructure more precisely what they expect.
>
> Patches 1 and 2 ensure that the documentation of LSM return values is
> complete and accurate. Then, patch 3 introduces four flags (LSM_RET_NEG,
> LSM_RET_ZERO, LSM_RET_ONE, LSM_RET_GT_ONE), one for each interval of
> interest (< 0, = 0, = 1, > 1), and sets the correct flags for each LSM
> hook. Finally, patch 4 verifies for each return value from LSMs that it is
> an expected one.
>
> Roberto Sassu (4):
>   lsm: Clarify documentation of vm_enough_memory hook
>   lsm: Add missing return values doc in lsm_hooks.h and fix formatting
>   lsm: Redefine LSM_HOOK() macro to add return value flags as argument
>   security: Enforce limitations on return values from LSMs
>
>  include/linux/bpf_lsm.h       |   2 +-
>  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
>  include/linux/lsm_hooks.h     | 136 ++++--
>  kernel/bpf/bpf_lsm.c          |   5 +-
>  security/bpf/hooks.c          |   2 +-
>  security/security.c           |  38 +-
>  6 files changed, 589 insertions(+), 373 deletions(-)
>
