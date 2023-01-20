Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939E675CE1
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjATSkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 13:40:11 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE34A1CB
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674240009; bh=Mjh3WPf7K01vqLuF2A+21BXm3stlpVpgiPRlWUMuypE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nAfulSG5CG0pidzS32SfGQ6KFKW9ecFQy9IAtjsasD6r0fSmv9gKB9wYPzT65YYw+EU96wV50Qvqj27tW8vDt2/PwRDxtOOutpSAboYBybhIniZ6/LgQ/cFywHrh5JSm0NUjXIUKkClqSh6ADRuka5WDLyLZ/xnxrsvwzQByu4TKLlwRNbEuHq39rlyKoAUUpeXqr1HauxZlFRn5+7AOe2ZaA2PZJVNSOodP/ZOArFBifBHRDCrN3xKkkffppkOkMArCEtcnj4fbemc25yVsDhSh2Dhj/Df5hojAndk6B/z3MkbC2HFgl4qC3GbXm+h/v7HyIj2RNMReNwcmiyrivw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674240009; bh=9zdo5TvItKHqT/B/TRdkpM/Te2XoIVGXqtRGqrD9B8h=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=USMvE6rfNV+2IlOIL6SAy/XFPyJFXMHQ2nLVfQ9qTnPejNVv/+AYR5P1VJq/LCDATgBwy9RrJUNSXw3qwY/So18aUeIQK8pVUoCFhj/lx/LHYX1E9Dl8UU5jaRNz+B8jkTXQTCmc5HOY5k3REaiwcpUsfaVVK0jJPqmWXhiarSCEtcZylXGpsxudK3Vdgczdba4Zx0+uUS1UP6ceTAIIqOkYaVmKxbHIs5Wvm4JyhgBlju8IwVEs4tsACNoZjtOh3Zq0/xcvC/zQ34Y+8cNjp8QkHOvfrx8Qqz5zgR9CRedvq1Otz2h0llJwXsr/KysWU9NdQ6nNP8ZGNBiTjdKW6A==
X-YMail-OSG: IJblym4VM1k_d3.YT3lpapAD7dwDIDzJTzbofxWRpS3NQqkXqQlJs_8UrLyF0Tg
 dOhjiJNuKHp4IWI9WfpQ7m58buoSPYd_z8cF2XN1y0wHbzS2AUEz5ceNMXCkEEn2P5xx.D89JJdh
 PEcd26AaEtUuYQD9au9IxtpOXa9XhvfYabcTjwSA5AuOB9JrDX0vgJvJRuMxjLL51wuyTpYom1ia
 xb9GoeLiPoav_AVaKu1EhObEloz3Btr9fqEq2w3JZ6Y74sLIJj5GpaRPwbndcXv2bfPrvCFRRcC8
 41biQH8dp5dqMI2uq8gPntrYLQqkzPPtMzJ5YVrEB4khqlBD1Dg3CvbJ02ZnKegO.RmMOvX_2Hqt
 Z6J8FnF2JwUBSCBJqXyqqmqZFNZyRXbyHGe.ZCR2jVaXMrnBmG5RL7U104zcGV__S51wqpWFzewQ
 gXRsCJUvm.GTSuSW9BcYL9XUmCSTnogsd8WzML8_iyvuugfnu3POOFjeh5TpZjwn.jt0r9vivJcd
 j1UIm2vyoPtsesHq_7OhqLpSDwMzDyv.HHipuGM.TLm45rDbrWOvyH26HxrhDYj6hbreBnwbYqPk
 Ct5IdYUda4ieZnWLgi.zn.RAm0CSqYDczp5RK1.dMHA_AoVJwHHGqKbFTrQlkbE5S3tXEQmio4wX
 LFf7ATaWWNzElhKKz8UF.veh8G2ueYfzzv0q3Oi_kEp3WPK.bjQc6bMl4x8plUnERwe.OqyRYluK
 5b.W3qdQsZFGRTVuD_V71dPOi7c6HRxyXCIgJ5PNeLtNXOJBASyLHMM2qQ89hsUzQrYXVp226YF_
 pjtBALm5D2qHd.bhFpPahd5CscrwwG3Lno93urZaRbmN9Pu6MKcVaIKHlV9tTlotdE92DHKDTHhp
 60fFjsAo0OeQ94bIYz0eLWFf8ipvgV00bEBbMcwljral3sradTYE6KBMb0JWKHeZT5jJNcRis3pE
 EhtV.0.N6JAg3LGsiA_cTud0yAe108jK2yP1nw2ORN.gH_PQBwbeIYGJXeZ1dRjcmrFyDx6ioTyy
 oi20sCPfMHu3FHjJxUhCUc48slKynl6m1DNYacisOWF_NRrrollji6pddPir6Oy8MuCwyLQes46F
 fgT5x68P8s7yxvBTtn1MAfub2GLBtleblBBemGx1ly0XPhJR.8cy08m5_1BaypAeAAZVHAaozqua
 S3XRepR3aJLxjQspv._nhv3iZYD2OBH9nhprphTwjwMebzeraKVebk4zAy91_ZZPUxoPfiQjhPUD
 ZYbFE.FWptQYD2OR5fmA7jYHYZDnbByavsIdpsqoC8yYIFNHQOC6v3HUlQZLjsZ8KvoVXsnAsJyg
 2W61dVGKmjHV7Jbf6eMO0rBo6Dm6hyaZq1_8ev4aKPXjxH70lhJ.a.xl6GEn9.kBbMcnbuyUER2M
 lAAb.CYsD4eqH87fTp7ZYkLR9i9tDZu9vHMSFNpAga.pVkrNVN2MEIx0flGWLeofgGcSCD4PQE9E
 ATfcXt8MnNj8ZSP5jJBQuB8yvfQj1.rFTQGsCEY4NsEsqxszSnbyImUmWxHQvbdUT0Z23hc9YoMN
 EPGp3QXcwAbSvn7WtOA5pSNl3BnAA8W5tsXKIvBajvWVO8PhABmZu9CE7So3dQsuk1bQuAFyYSkj
 Lonp8HCRVukGN.KUUtNda2NbDrmwDtfzff9eB5F8G_aplreasdOIu3qlB9q6iR9rw2naE0Kv9ZNn
 4zzz1j7RnBrNQUpKKiJoVreMni8fpXV2Kd6QAZ5ZvNs8XMo8atAiOyH4UM0D3YmOu4RwrzQKQQgI
 N3mp51NAUhYKgSGofpPOunZsNisEK1l2mludGZrFUfEfYqf.QcU8hC3K7TtTmgsY9DpRTT5IajmY
 eQ4Ja_LKAo_UiWH85vOTI7p_AX7K7QnTT.QLaVOUOaUxlRdVSxiI4aPOSqjlZBR2XbAx.sPaSjYh
 JJjPAm9iZ.bASCggAzGSlomHRL8OjeKzm7..IrueZYl0okfpReff6MRuZKmsNm8P_N7tUqowy6cN
 8yQ75huSxoq2QLW64sRKVEEaj2A554eQEDc6HSg.RPFNXEAuJBdGEeU_Dny6jKtqk05z8TO6O3yU
 saeaortflc.J_GvJ9D3yNwf0VlG0Nqrt6.FST4PgMdIMug2lRQlbqS6YpsMdgf2rxgIvTt4ukpDa
 CJ_sV1tXoQHNnvoHNkyw0P1nQWhAPOC2ggsNTIDyybCQNY.xacHkPmjlnr9Nee5TxgcuGcBSDr63
 SqLZK34CJqla8xSjMkQHlAikXkaE0jpY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Jan 2023 18:40:09 +0000
Received: by hermes--production-ne1-749986b79f-rgmsx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5a95df882e4421c4d8d91192e9e3b075;
          Fri, 20 Jan 2023 18:40:05 +0000 (UTC)
Message-ID: <77a767f5-48ae-0d5a-9222-c47040fd6b17@schaufler-ca.com>
Date:   Fri, 20 Jan 2023 10:40:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org, casey@schaufler-ca.com
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <1e14f68c-90ba-f406-f08c-6d62bbfef6a0@schaufler-ca.com>
 <CACYkzJ6DEegggQBRJwe0Z2gChfxficOVmoe2K5mjAx7Zq0aApw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ6DEegggQBRJwe0Z2gChfxficOVmoe2K5mjAx7Zq0aApw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21096 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/2023 6:17 PM, KP Singh wrote:
> On Fri, Jan 20, 2023 at 2:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/19/2023 3:10 PM, KP Singh wrote:
>>> # Background
>>>
>>> LSM hooks (callbacks) are currently invoked as indirect function calls. These
>>> callbacks are registered into a linked list at boot time as the order of the
>>> LSMs can be configured on the kernel command line with the "lsm=" command line
>>> parameter.
>>>
>>> Indirect function calls have a high overhead due to retpoline mitigation for
>>> various speculative execution attacks.
>>>
>>> Retpolines remain relevant even with newer generation CPUs as recently
>>> discovered speculative attacks, like Spectre BHB need Retpolines to mitigate
>>> against branch history injection and still need to be used in combination with
>>> newer mitigation features like eIBRS.
>>>
>>> This overhead is especially significant for the "bpf" LSM which allows the user
>>> to implement LSM functionality with eBPF program. In order to facilitate this
>>> the "bpf" LSM provides a default callback for all LSM hooks. When enabled,
>>> the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
>>> especially bad in OS hot paths (e.g. in the networking stack).
>>> This overhead prevents the adoption of bpf LSM on performance critical
>>> systems, and also, in general, slows down all LSMs.
>>>
>>> Since we know the address of the enabled LSM callbacks at compile time and only
>>> the order is determined at boot time,
>> No quite true. A system with Smack and AppArmor compiled in will only
>> be allowed to use one or the other.
>>
>>>  the LSM framework can allocate static
>>> calls for each of the possible LSM callbacks and these calls can be updated once
>>> the order is determined at boot.
>> True if you also provide for the single "major" LSM restriction.
>>
>>> This series is a respin of the RFC proposed by Paul Renauld (renauld@google.com)
>>> and Brendan Jackman (jackmanb@google.com) [1]
>>>
>>> # Performance improvement
>>>
>>> With this patch-set some syscalls with lots of LSM hooks in their path
>>> benefitted at an average of ~3%. Here are the results of the relevant Unixbench
>>> system benchmarks with BPF LSM and a major LSM (in this case apparmor) enabled
>>> with and without the series.
>>>
>>> Benchmark                                               Delta(%): (+ is better)
>>> ===============================================================================
>>> Execl Throughput                                             +2.9015
>>> File Write 1024 bufsize 2000 maxblocks                       +5.4196
>>> Pipe Throughput                                              +7.7434
>>> Pipe-based Context Switching                                 +3.5118
>>> Process Creation                                             +0.3552
>>> Shell Scripts (1 concurrent)                                 +1.7106
>>> System Call Overhead                                         +3.0067
>>> System Benchmarks Index Score (Partial Only):                +3.1809
>> How about socket creation and packet delivery impact? You'll need to
>> use either SELinux or Smack to get those numbers.
> I think the goal here is to show that hot paths are beneficial, and
> the results are pretty clear from this. I have an even more detailed
> analysis in https://kpsingh.ch/lsm-perf as to what happens when the
> static calls are enabled v/s not enabled. I don't have the socket
> numbers, but I expect this to be very similar to pipes. Is there a
> particular Unixbench test you want me to run?

It isn't wise to assume that the paths used in IP code behave the same
way as any others. Unixbench doesn't look like a great tool for doing
this measurement. I would look at iperf or even some of the low level
tests in lmbench.

>
>>> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
>>> The full analysis can be viewed at https://kpsingh.ch/lsm-perf
>>>
>>> [1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/
>>>
>>> KP Singh (4):
>>>   kernel: Add helper macros for loop unrolling
>>>   security: Generate a header with the count of enabled LSMs
>>>   security: Replace indirect LSM hook calls with static calls
>>>   bpf: Only enable BPF LSM hooks when an LSM program is attached
>>>
>>>  include/linux/bpf.h              |   1 +
>>>  include/linux/bpf_lsm.h          |   1 +
>>>  include/linux/lsm_hooks.h        |  94 +++++++++++--
>>>  include/linux/unroll.h           |  35 +++++
>>>  kernel/bpf/trampoline.c          |  29 ++++-
>>>  scripts/Makefile                 |   1 +
>>>  scripts/security/.gitignore      |   1 +
>>>  scripts/security/Makefile        |   4 +
>>>  scripts/security/gen_lsm_count.c |  57 ++++++++
>>>  security/Makefile                |  11 ++
>>>  security/bpf/hooks.c             |  26 +++-
>>>  security/security.c              | 217 ++++++++++++++++++++-----------
>>>  12 files changed, 386 insertions(+), 91 deletions(-)
>>>  create mode 100644 include/linux/unroll.h
>>>  create mode 100644 scripts/security/.gitignore
>>>  create mode 100644 scripts/security/Makefile
>>>  create mode 100644 scripts/security/gen_lsm_count.c
>>>
