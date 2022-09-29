Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586895EF8A9
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiI2P1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiI2P1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 11:27:36 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2515D646
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664465253; bh=pGLNsoLzPUts8onFeF22LrTZNLZ89dyzql1L/5mktq8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TG2VHxC7Jp/WamRwkxNV7aQpdUWVGtw3qxo1yRBUfN2+5mJBUZIRa6KH6vSvToaAdpULnbikGHlTcBZQcvbZRT87LuTYJWSiIOu6Jo4Hy3PvFcEZ8Nad5E/pndC2quULsp68mx64cJehDFaSYO1Ij5I+Wk0PTMIDcPbclA+BeehQenPq1mX7SF9Tojmd6zgxX84YBp5nbpI+sMZ19+zsX1FwiDEyF6KqyYADoON2MDpNU9X9c66BkqgmXQ5CGcWkJ4XPNiunFXGHiFjp23qK8YqsbrC5NQxgXHB4HOa+H9QT1166QVOTDA27uUtKb8+S1eU5WpzjjUNmOKKtJJSZqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664465253; bh=7MC5hoLN8LU71/ClawFlKWuGXcHmN68PgWx/JqYpNNm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jcUhdHiJQUz/wZCicMA+rfFKfk5QNDcHZdtf+uPxclQfsYoxNTsh5wkAAxmEhsnou/0glbBiKvqqrrN9XNLXuIbcrzI7MYH/A2MexNuX/hDy34Sg4sThKysDc+ZY6BbJs68uuLufmRy8JhSBzxgbHmAov0Tc4IucJo0MYthh97EPZFEdRbodB3kW1Gupe+FAHf3rso4d/OlOZRFIQGyXKoHluFpaZncupTGTLgkKwrzOOVDMi9vM4dON26dXpPfD443Ak+fiXxXYo6ewyKZimchmLmf/I3ROFkucdadqgNuibfiuOLBf/Q67K8XwzXu8rUCyFWD7uyRr7gJyYZFqFw==
X-YMail-OSG: nCBF3oMVM1kH0ueRicuMGeRaCuWV7vAOXpVI_ygtyr2CwtiajojN9PmjhLxwVgk
 JE_RsYl1FWqAtVWCU8pqchNOgQGY6CZkuPs5WxeK8wZC93h5Ad59ANO3e4.kWsSUK21kf7l3vCMw
 CxBwmZ2uHKATxKBkaGtbCt0g4ZzwTN7Pn3mMTa_13xOkXuXdWabPgKcmCslAq5Bdc.3PY6gIjnLu
 aej5zJb4ClP0HBKeDXtD1AwUfbID4wBMn9aReIxTNIJjrYg282pLG5l1iv2PbAY2Cobggc.MRF8c
 BOaqtQNBxPdWnzALGNT0qME.FK2dUsmGUiOwV1FA3Dz_.TWCOZbDu8QBkCIjYSGf9j1U8..ew4T4
 ZuYXAE25xriUnn1sexwa97.cTjBuLqU0HjCsfQhKUQWjqc3FT6I4Y6g3zxNrXqC_gwtD9VLQ.HAX
 Xa71C84sV7C8aV7bq2mfM_Q9DRVXkAwvhCVW8l4qG5hXMmipGoinMdO3G9B7g2DT.J76aWx1jf0L
 fEQTlfIbdccWVgF8hO9J5AHd2H.qLA1Te3LJHvlGvNPu_xCxKSoncA6h7G0hXnTmVKcH_YpwFccL
 9HviUoPD84yxqsJCvDskTO4Tew4e3_LEXPVpvGWXWIkA9B2xuoHJOafRO5XuGqTO4uM28wgA9P8N
 NJq.DSRZ2.uV9e8DjnBD_Z54h2BcwB.AgcXE_yi9xx9Gu4QRDVdoWH2c7KKr0dP2aG2azIBEVDrA
 n6VhFXHouGcR7d2ABfVYAc6hyIKHbNT.rgPNovOyjfau_7to4lrMHA7SEWxRDEBzsJC8.pCI7CI7
 0_YLv1.jggsZsTNxtPi8D3GbB3KK1adXG.5aivNr_ocLTsR2CL_FD4g0jCMN.YkbGMPOSK.I9hVr
 Aw9CxJTRHZaRskKKcXJmo_YKfMRa1l5TZsBvZwb9E187uQtgvVjGtcQ1WX30mFEPhlkOSBt1AcVD
 m3mxNj_OOQKGdUIkofFE65D6ABkb.ElCnwe2KjDJOAUUaWm5GUY_rAkNrM0wkkWFlIwGQ6ZjQy1O
 pcpYwktQYAqB_xqnQ_SUAa_fujkMH1ug5RakF0mBzScYow._sH7Y2QbmwjLRTd2DVLL7MV7ID7oO
 LLinrjhppeVY1MU0Bu5VPoqfPlkw7au2RF.1_s709J7jsZwZK1kIYeyoAdbBE2m39HzxsK_dlGfC
 BN7AbOpitvMzSIQ0_sSXODz9UMSf2xiE9HkrRM1cSXinisx98XtnQjtjjNzJZZ2oUgt1h68miL86
 bidu_2WfQFpBJ0EHqHxuGgDxSkjKtS4szoaBZsvvPe3ZlskpCNLANQGRIvjUO9rci8G6ruButB99
 FVq2sdeQR2hH0tvv1b2BsS9wEhoo1NndLW09SHiWyzc0Kw_UVuXJNFJ4fgV7dcR2hg43szqx_exL
 AmjJ0Qheym3aFdB5FNA9bUUNSJJgqPKIzz2N.UtDm1hzKY1JX0tLqzkIQX1Tl3JqnU0tFPBilbec
 jesELeOGNwT2r1rTrwRB_e6tpgCLlVYsXzMGZEBRS541EVw079euok4o_K8U.v7THfz77j5jGu4k
 ICH18sEqQFTEbqDvY02H9IYhrL3wt3Y1U1yx0s3wGVeLQQAbJoN1Mr09eAnlsufCC3QbSA_IFOuK
 p.rLe8kO99ms1muyQb3D2HLyCpx_T7FZdBITdYgtIgO6e53UQGolw0DNB4fAa4l2chXcWeCn6ACd
 DQeYwSQejQPrH5_er54OhoM1WxydkxBQGOq36WEHLUuvUJF_WO_Ff_5H9FURGLGoikyJNfUjtzft
 JTGzYI6uWeTXerEIkP6x89PJspuq_PfTK6J874MLKJ6BgNmmFru8STtMavKRawHCH1RUdUtJihD5
 E7aBb7YnyRkendWPf5HvNyHHhYTJuHcR97iw4rVxtOIYcB5VaAfdpfhwR8VXDZvQlU_sp.2NSKPO
 4euqvqVkjhzZCG2I.3APYz37q_vmcPZUd_nnoDL6Y4aVXmonEanzzb3hCk1Xs94W7HrmVMonvzGX
 5vMysDa90Q9dHNqRghDUz3_dGprhq14OmmypSPI5gYIvS0nHswpf8erjCN52WhXF1qjoQK3IZ8IS
 W6Fx1_XJA3EoqMsPpypXI82hND2ZuRIDml9soFhcciSOMaqIM1SsULSxSgd3VCLXSzgK.AhrFOu.
 bAl8s84rN6Xa9e7Ui4exaeuUBtHn3Zl9TcDlKJrqqTGdhm6CJAgSdn8fMi3MLY4E4xPj3JnOAsGL
 5Ug7qSr7A0QHZ3Swi4XGkBdRu1zdV1a0k0...cmG2UDrBe7_g
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Sep 2022 15:27:33 +0000
Received: by hermes--production-ne1-6944b4579f-p7xcb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4e8fe131166d9d1396d49b7657ebfeb2;
          Thu, 29 Sep 2022 15:27:28 +0000 (UTC)
Message-ID: <24b60b5d-2664-89e6-1aa4-088623781455@schaufler-ca.com>
Date:   Thu, 29 Sep 2022 08:27:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Closing the BPF map permission loophole
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
 <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
 <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
 <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
 <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com>
 <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
 <87mtajss8j.fsf@toke.dk>
 <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
 <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com>
 <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/29/2022 12:54 AM, Roberto Sassu wrote:
> On Wed, 2022-09-28 at 20:24 -0400, Paul Moore wrote:
>> On Wed, Sep 28, 2022 at 7:24 AM Roberto Sassu
>> <roberto.sassu@huaweicloud.com> wrote
>>> On Wed, 2022-09-28 at 12:33 +0200, Toke Høiland-Jørgensen wrote:
>>>> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
>>>>
>>>>> On Wed, 2022-09-28 at 09:52 +0100, Lorenz Bauer wrote:
>>>>>> On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
>>>>>>> Uhm, if I get what you mean, you would like to add DAC
>>>>>>> controls
>>>>>>> to
>>>>>>> the
>>>>>>> pinned map to decide if you can get a fd and with which
>>>>>>> modes.
>>>>>>>
>>>>>>> The problem I see is that a map exists regardless of the
>>>>>>> pinned
>>>>>>> path
>>>>>>> (just by ID).
>>>>>> Can you spell this out for me? I imagine you're talking about
>>>>>> MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not
>>>>>> great
>>>>>> maybe, but no gaping hole IMO.
>>>>> +linux-security-module ML (they could be interested in this
>>>>> topic
>>>>> as
>>>>> well)
>>>>>
>>>>> Good to know! I didn't realize it before.
>>>>>
>>>>> I figured out better what you mean by escalating privileges.
>>>>>
>>>>> Pin a read-only fd, get a read-write fd from the pinned path.
>>>>>
>>>>> What you want to do is, if I pin a read-only fd, I should get
>>>>> read-
>>>>> only
>>>>> fds too, right?
>>>>>
>>>>> I think here there could be different views. From my
>>>>> perspective,
>>>>> pinning is just creating a new link to an existing object.
>>>>> Accessing
>>>>> the link does not imply being able to access the object itself
>>>>> (the
>>>>> same happens for files).
>>>>>
>>>>> I understand what you want to achieve. If I have to choose a
>>>>> solution,
>>>>> that would be doing something similar to files, i.e. add owner
>>>>> and
>>>>> mode
>>>>> information to the bpf_map structure (m_uid, m_gid, m_mode). We
>>>>> could
>>>>> add the MAP_CHMOD and MAP_CHOWN operations to the bpf() system
>>>>> call
>>>>> to
>>>>> modify the new fields.
>>>>>
>>>>> When you pin the map, the inode will get the owner and mode
>>>>> from
>>>>> bpf_map. bpf_obj_get() will then do DAC-style verification
>>>>> similar
>>>>> to
>>>>> MAC-style verification (with security_bpf_map()).
>>>> As someone pointed out during the discussing at LPC, this will
>>>> effectively allow a user to create files owned by someone else,
>>>> which
>>>> is
>>>> probably not a good idea either from a security PoV. (I.e., user
>>>> A
>>>> pins
>>>> map owned by user B, so A creates a file owned by B).
>>> Uhm, I see what you mean. Right, it is not a good idea, the owner
>>> of
>>> the file should the one that pinned the map.
>>>
>>> Other than that, DAC verification on the map would be still
>>> correct, as
>>> it would be independent from the DAC verification of the file.
>> I only became aware of this when the LSM list was CC'd so I'm a
>> little
>> behind on what is going on here ... looking quickly through the
>> mailing list archive it looks like there is an issue with BPF map
>> permissions not matching well with their associated fd permissions,
>> yes?  From a LSM perspective, there are a couple of hooks that
>> currently use the fd's permissions (read/write) to determine the
>> appropriate access control check.
> >From what I understood, access control on maps is done in two steps.
> First, whenever someone attempts to get a fd to a map
> security_bpf_map() is called. LSM implementations could check access if
> the current process has the right to access the map (whose label can be
> assigned at map creation time with security_bpf_map_alloc()).
>
> Second, whenever the holder of the obtained fd wants to do an operation
> on the map (lookup, update, delete, ...), eBPF checks if the fd modes
> are compatible with the operation to perform (e.g. lookup requires
> FMODE_CAN_READ).
>
> One problem is that the second part is missing for some operations
> dealing with the map fd:
>
> Map iterators:
> https://lore.kernel.org/bpf/20220906170301.256206-1-roberto.sassu@huaweicloud.com/
>
> Map fd directly used by eBPF programs without system call:
> https://lore.kernel.org/bpf/20220926154430.1552800-1-roberto.sassu@huaweicloud.com/
>
> Another problem is that there is no DAC, only MAC (work in progress). I
> don't know exactly the status of enabling unprivileged eBPF.
>
> Apart from this, now the discussion is focusing on the following
> problem. A map (kernel object) can be referenced in two ways: by ID or
> by path. By ID requires CAP_ADMIN, so we can consider by path for now.
>
> Given a map fd, the holder of that fd can create a new reference
> (pinning) to the map in the bpf filesystem (a new file whose private
> data contains the address of the kernel object).
>
> Pinning a map does not have a corresponding permission. Any fd mode is
> sufficient to do the operation. Furthermore, subsequent requests to
> obtain a map fd by path could result in receiving a read-write fd,
> while at the time of pinning the fd was read-only.
>
> While this does not seem to me a concern from MAC perspective, as
> attempts to get a map fd still have to pass through security_bpf_map(),
> in general this should be fixed without relying on LSMs.
>
>> Is the plan to ensure that the map and fd permissions are correct at
>> the core BPF level, or do we need to do some additional checks in the
>> LSMs (currently only SELinux)?
> Should we add a new map_pin permission in SELinux?
>
> Should we have DAC to restrict pinnning without LSMs?

As you've hinted above, DAC hasn't been an issue because there isn't
unprivileged eBPF. Even with privileged eBPF I expect that there are
going to be cases where not having DAC controls will surprise someone.
The less BPF looks like low level kernel internals and the more it looks
like general userspace code, the more likely this is to be an issue.

Or ...

If you are treating maps as kernel internal data structures you don't
need DAC. If you are treating them as user accessible named objects you
do need DAC. Security modules that implement MAC may chose to control
kernel internal data access (e.g. SElinux) in addition to named objects,
so you may want to accommodate that as well. If you do decide that maps
are named objects Smack (and possibly AppArmor) needs significant work.
Probably audit and IMA, too.

>
> Thanks
>
> Roberto
>
