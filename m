Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541796D9D54
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjDFQRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjDFQRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:17:17 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com (sonic305-8.consmr.mail.bf2.yahoo.com [74.6.133.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4930FD
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680797835; bh=VuSERGq4d+Cfe8sCq/lVtoww/oUbwbdKqqQ64i5D7LE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CsZM3TfsFQb7BNQgiB/R9kYXLI4Q2KKUe9O9pONITa1Dx+4yOTGTRTKpQ446oHSdudyl0+JADNfEqGgygI9f2Pm34+rCj2P+WjSIVpf2mVoy4z0L4yAgmJazkEmQXyBK5ftOECMulXkgn68LXi0pMiJAiMidP9hz3z+S39wbNliwxB3nN/OGViHW/D3C8U7dTQySEP1QB0ikfvsYBbr0kQ2hFjLjYmEn27YL8OcKXlQfw93drrHiXkrQ2KYMSFU3IQDYMTnJRpvDB/by4+0quD9/FZQzBpclu4WcnavOD1XptAMxhJVsXeu6RrtvH5+ziDnJ9KdXG3qxxqZqc02cJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680797835; bh=v7+6uJ/gTTHM32UIrDPLnkqewRfrVmpO9kVwo6uf8Ae=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DX9NxAD4QaVMT6cTyZN5NRiifiNAypC1h5aP7OLFADPjqRcxUDCyVF3icU093dfGYG1rpWtyH0kymCyMP2J3yFVD93Bfsy0D4PXNNAc2lJ2HW2zuGny55ZZzcgwR3xy74dTTBIcdeLXoktX2Pc9piBaUC/Nw0iR77iaUmeWvJDazg2IRz7D+eNM/itt2MCEFZqwnoDAcy8zuIswtJ0qKcAbdQnfRVqMt/NmX3TtKGYRM0Gut/9wQRaA9Pat8QFXvz/SHdBj9sQ94ErYfntak5udtYEnAE44ZaxQs/GmjNjPZzC9ORJZcjc0Bv9NDE3TANAkhhNrdWo+qvu9UTmjIRw==
X-YMail-OSG: tUl9KEgVM1nZI52wCWlixedTkWjoD82z33IB7eYk.U.gLbKfV00IOSqzvK0IKoj
 G3ge29ww6dMqQd_DL3lZh2GQUwNkQjIg1dxxbB3QOtPeMZ5kP4TLxyonjCa9JGqZsrLYZdTB1WZD
 xriXzcbUzYX_aHD_WxwVQ783Y28dDq80HY1MiUTQInClC4N2_O4_lxcY9ZkygdCATm4tZHs9Ts..
 sd51Z_yQ7n32roXV8qE46ezdc3wD3cjnYWMmD.MFWrH4tQQvrTPFvMYgCrxiNx7N2mm7LIW2nd2k
 GwGI0ETmkMEKEQkMueJz0njns11ZG50ti9Bu4lZmHG9rpz2pqREQU.jqqYJGKsckrtfBE7OcV3hv
 nUDu78ugyve1Uf37Dqe2l.GoRuwEJnbcco4W8C..79Jdcwth5G2ikiCfIZhvqGJ7DnxIbLPqJkb5
 ku1H5q.Z8CX7zDcHGfUIa27p.SXe6OBBQmFZB3DPKmpGshvOlTenY_Nc9jpYgRTh9yvDrdJvT3sA
 pj.vIXfraVL.Q0G6s2xkvXY69xrnqxUSyDIkARl8ckbdZ2dGJtPZe12z36RLS.ZDrauDO7wD0Abf
 u.v7ooL4zzY8zbGlhZebQ.1AiXDPtUMSmvhz76KxDRhbwQlqVeUK9fkvgp3N4EPpFw05nVOHNKUj
 WNVzUKUWLXjI2P05JQ6q1ZLBNiBhpeDUzPlFvfLcBCoJZABD7CxAiyuWtaSKjDgO5_0yg4v3wLZr
 kwuhN2YhiM0w.xd4Y0LG4md0TQtt50bjXTM92hr2sAqlRNzPjKKCgIRCn_VElhaND08YOIMpSC3y
 huSQgyj0.XHRFJEdkkTrPrnZW4zOQUixljoICU73WmPyZy2TL.bANJ5L_pqtvggKXE2TV7J7SjOD
 MrVF.XhIpSkVoULX4JBYjeHVuqDAJjx_EQIE7cLDg6SssE5_xgeZB11ERI7U9FPWiANKxjjOwWDf
 BDavf94W3izvMHPAGMlj2jOH5OyUqloJr6pjDYRawTqb4J94fJHQqzZ62xtSA24NfgCnrXXN132v
 z.75vIBpXqWmAM2pvdkOWebMt9DemPfVoLxso6HOuw49bYUwBgXznRJ_rGjR3Qd8FAkoa8GNTLqx
 zyFTD2Zu_y9qD5fqUGSzA475juGX7AjwYSArdfA.P3z6G7KIbeMi8p6TlU8JPNKJjVZ_j466PWMy
 jTp7XfhA2ch9LTMN_eEG4fsrSN4G.R1WUTpCVWVUoJ9jLgW18GYUb2SstccyUuloZ_P3_gIYSprO
 zYoFnJbot9PgRepf8.XjUE2X7UO84O.QiLKtdPnYM5lEm93J5DRF7o6feNAphPGkkAepjKozmEPJ
 iSm0V2Tb.QR3C1hoQpqtFZQ_ipDfpfj140ItI8w9cmqFW.tjSSXZ.CU0dKXIXhvGaf1i62lRgxlU
 TfHXUB7vBZobFxop2lMEFqLnKoNv.vVUvIflnH0GHxyM1z0TI1hslusOc7bmj1DUXyKsIKaFcgeb
 v_d5ltbqCMIK2m31AfxFNu4RDiO9pkhbW0W4.5AkESY.Y5QkwbpZpjc7Ydogu_M5n5HhAQcSxlYq
 azCQ65opt4hTxncUJXBToKLelbu0_IB8z22kUTulktDRp_kg2pVwp3QXRMQA47jZ8Qm1K8SDt6fr
 oVmuyT9GjQVK_8bAuV0Xt.jsD2yvuMiDJZDuE8juy4yNg9Dg4Fx7AEtrujLggWPoWMj_C.DAatMA
 TtjL3z.7POVPurCd_c8O0hbwJqNhTs1zEhuD07rcAQTN8Jz1SkLEjwOxvWodWOM5nW_oVXEcccNb
 BN8YfHKqbfuuZcRd3exnLLnr3t_2lA7skqny7gH6okQTPFiRhs0cx8RsDcVwlnl3VsN027SnMz2F
 BOsVqMMtGaPd72OF4XQzR9PGuX8WI9L3F8kLtxRWgEvQB9q57SynSDtBvglRRaj0S3bFuZ.Q6zZR
 JaKou5M9syXv7pU1JTbWwh0iYgj2ruFMFSvp7ToscTvcbPuwUEU4yL.1yCwtgUmWrjUt0ZjoncmJ
 WrNbwsNajw86RaVWWM.h_vCIVbZoTrlfIacRxKBPRCfKMbOS6u8sGizS0Jkc4hXfgnQ_i09JIXr4
 wMlVWD1iSOt9GbpzqruE8raC5UBH3UsrQb2b9XEVgh54Rk79.QIpdT1fqhZVUhB1b50LNLOdMAKz
 QYEXi3ZqlHsSPZOgaYWW7CDPSSzUMCUwUa.DdYql2GOml3wcrPXNEPUpWH2HUcWWje23W6EVGutF
 sirSNvz1SqsikKqYxTAetEMUZp2ri303tGVy7tw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a5a8ccf3-a3b9-4c0d-b117-55a4932d35a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Apr 2023 16:17:15 +0000
Received: by hermes--production-ne1-7dbd98dd99-nn8pc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 24a7d9931c2812c4db7376cbcf2cd759;
          Thu, 06 Apr 2023 16:17:08 +0000 (UTC)
Message-ID: <733a7896-0b0e-f86f-0068-0285d646d563@schaufler-ca.com>
Date:   Thu, 6 Apr 2023 09:17:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
 <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com>
 <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
 <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com>
 <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
 <CAHC9VhTO02CGUt0DUUmx=TUYS7Q81fas_Qy5miOFonaye0NEmw@mail.gmail.com>
 <c3751b2b-aa4b-2105-c238-29816bc85607@schaufler-ca.com>
 <841747d7-ab17-2904-ea1d-6adb3d35c711@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <841747d7-ab17-2904-ea1d-6adb3d35c711@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/6/2023 2:14 AM, Roberto Sassu wrote:
> On 4/5/2023 11:07 PM, Casey Schaufler wrote:
>> On 4/5/2023 1:49 PM, Paul Moore wrote:
>>> On Wed, Apr 5, 2023 at 4:43 PM Casey Schaufler
>>> <casey@schaufler-ca.com> wrote:
>>>> On 4/5/2023 12:59 PM, Paul Moore wrote:
>>>>> On Wed, Apr 5, 2023 at 5:44 AM Roberto Sassu
>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>>> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
>>>>>>> On 4/4/2023 11:54 AM, Paul Moore wrote:
>>>>>>>> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
>>>>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>> ..
>>>>>
>>>>>>>>> diff --git a/security/smack/smack_lsm.c
>>>>>>>>> b/security/smack/smack_lsm.c
>>>>>>>>> index cfcbb748da2..8392983334b 100644
>>>>>>>>> --- a/security/smack/smack_lsm.c
>>>>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>>>>> @@ -52,6 +52,15 @@
>>>>>>>>>    #define SMK_RECEIVING  1
>>>>>>>>>    #define SMK_SENDING    2
>>>>>>>>>
>>>>>>>>> +/*
>>>>>>>>> + * Smack uses multiple xattrs.
>>>>>>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the
>>>>>>>>> program,
>>>>>>>> I think it would be good to move SMACK64EXEC to its own line;
>>>>>>>> it took
>>>>>>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set
>>>>>>>> to '4'
>>>>>>>> when I only say three comment lines ... ;)
>>>>>>>>
>>>>>>>>> + * SMACK64MMAP - controls library loading,
>>>>>>>>> + * SMACK64TRANSMUTE - label initialization,
>>>>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>>>>> + */
>>>>>>>>> +#define SMACK_INODE_INIT_XATTRS 4
>>>>>>>> If smack_inode_init_security() only ever populates a single
>>>>>>>> xattr, and
>>>>>>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can
>>>>>>>> we make
>>>>>>>> this '1' and shrink the xattr allocation a bit?
>>>>>>> If the parent directory is marked with SMACK64_TRANSMUTE, the
>>>>>>> access
>>>>>>> rule allowing the access has the "t" mode, and the object being
>>>>>>> initialized
>>>>>>> is a directory, the new inode should get the SMACK64_TRANSMUTE
>>>>>>> attribute.
>>>>>>> The callers of security_inode_init_security() don't seem to care.
>>>>>>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for
>>>>>>> that
>>>>>>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older
>>>>>>> system
>>>>>>> allowed for multiple Smack xattrs, but I'm not clear on exactly
>>>>>>> how.
>>>>>> If you like to set an additional xattr, that would be possible now.
>>>>>> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
>>>>>> another time and set SMACK64_TRANSMUTE.
>>>>>>
>>>>>> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
>>>>>> EVM would protect SMACK64_TRANSMUTE too.
>>>>> Ooookay, but can someone explain to me how either the current, or
>>>>> patched, smack_inode_init_security() function can return multiple
>>>>> xattrs via the security_inode_init_security() LSM hook?
>>>> It can't.
>>> I didn't think so.
>>>
>>> To be really specific, that's what we're talking about with this
>>> patch: the number of xattrs that smack_inode_init_security() can
>>> return to the LSM hook (and EVM, and the caller ...).  If it's only
>>> ever going to be one, I think we can adjust the
>>> 'SMACK_INODE_INIT_XATTRS' down to '1' and save ourselves some
>>> allocation space.
>>
>> Does evm have an expectation that mumble_inode_init_security() is
>> going to report all the relevant attributes? It has to be getting
>> them somehow, which leads me to wonder if we might want to extend
>> smack_inode_init_security() to do so. Even if we did, the maximum
>> value would be '2', SMACK64 and SMACK64_TRANSMUTE. Now that would
>> require a whole lot of work in the calling filesystems, as setting
>> the transmute attribute would be moving out of smack_d_instantiate()
>> and into the callers. Or something like that.
>
> After changing the inode_init_security hook definition to pass the
> full xattr array, this is not going to be a problem. EVM sees all
> xattrs that are going to be set when an inode is created, and adds its
> own too.
>
> If you have enough information to set security.SMACK_TRANSMUTE64 in
> smack_inode_init_security(),

I think there's enough information to do that. I'm going to have to look
at your patch more closely.

> this patch sets already allows to set both xattrs at the same time. We
> would just need to call lsm_get_xattr_slot() another time, assuming
> that we reserve two xattrs.
>
> Roberto
>
