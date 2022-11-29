Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3163C612
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 18:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiK2RD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 12:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiK2RDg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 12:03:36 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165D5C74E
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669741256; bh=7iroGIbVR4OxPkC3NVITmuStzr81hSzdnaar4vrIWpc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qOFcyVYfOVOn8DiV/SKTRlLYiefq35BnuXS0rYPvZf96vJO1EVkY0Zcp+747fW7Dwren7vtTa5mdilp1VTnvD4scZpkUsVwpYnMwGowoJLj53NFrRLOpzCVU8x/BbHnp7DZxaedCRTuhkObWMYyDxZ+6ATKPG5bXTzjTT2CPUrkdu6Vn7s1ftX7PLrIKEocvUcBfkhsW8ClvQ0NbpH0npx6IlpcOLX2PaGvw5lZYoy+vBf9GowNJ4nmSxFS04HIYmcgwp1HbaWNW0zynhG51U7rTafd05w3Bl9vrr/FgLu0kybTn1F/RbtmpO8kenZFrNbAc4HwrsC5/4cYRTcYdPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669741256; bh=Czm12+njfEZIb5xnOyiENcEJRFLsA02QtMubuGX8Xmh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gDSikSeZmopdrFpJt97yNfYPbNTSIy1mInpD0kNZFzrf0pXRjuzs4kjH10/IeCqqXn/xbIbFT7aWCa5fMPQq1yhMA35ALOhh55ToeUpHIDJl1kYi9o2eft4cuAYSF1/ITaaGomml+mYfebgUVrR2BooERCqyKLPoMiYdZY8FaCXJ962d+C9Ck4QNl/r85cfYYN5TCWFPtb6f8LKt/besiRxCHJNHpUb434SCblSxaRUOE1G+M9q/1bslgHt7SffwwV1kdScM9UexlMZNs0QO4S/Lu+LXWpjccaw9Ct56aZUmyGhoSYasLxKtflohiQYQJKFktayPqg0PI1OHCssQmQ==
X-YMail-OSG: xIbadvUVM1nqYjUp9hp8aDEZtFVw1aMpJth4JPE1mEGrzHxiXWMEjP8On9cmjmq
 GeWyNnqV2gko7klQPSESVM9V2CdEesZA2MPWStzlAW0ocDPhaB9lTQyNJL339tcmXbuytw5v7o3b
 NEHaOboD3bPt1GWt_4sLh9N4JLGpSZQWGmX4XwKlsgluWrPCfSY_9aN7Z7qrWfwGJj9jBMuug9V3
 SjQV7vb8c3pEgEUeruVfabydtbl0qWu0j1FizK.y1p4z4SeysiHe3r_4iMAVTu1djJq9G7pPoX4B
 HggJWuLnI4TX13ny8cspoi7eG6GvNwz58gjquFi4JzO84QPqkiLeNrsF7d_LnZOW1S6q5FFEV7XP
 6PX578DCdvyhLvCWU0m3LlocCed0SoTM9oWsEjYbjmIxqGXj0PORaFBy6O5KvP6t3ovzMm_1P4Rf
 fwmny1JWseN7Wzrolpsx.Qy1.NvaVA226DYv3v0KjBS1pd9x_SeUrKdQDTlDXxnTpBeXLGwJcxBb
 t9khRJglEl6oA2WzsRxA1.j_hmYd5xsESoJS7RK1fPwBkt6Cv8fDdlGOOk7qAmb1_hQ.VEkUSeak
 OxTYRpEKut3EdDfDGlpQQEjJ8nLbfkre8nBKETLQG5X0J9pjzDvrmCk_I45m.SP4D46tSaLmPmsB
 owmMreBqcpaazgBVJ_LTzoMfzPf5KU.nkdKi5YSWrLc6QM.oQR_MwDutKoLIN4q43HQDEZNhx7bY
 k5_RJzDHWNlkA1nchPGQL.NSNLLKX2gqzdO2yzWV1sQ1cBN5VcoxpWTQE.84Is_qcXNybGPGkbDn
 L33zCQAHkJmB1Q4eziFF22FaQ7nfU3K_OTkK5DaVEOZH0aznpb2xYFuOjh6ru30ctof4vAlu5Xfa
 ZoemmEEHXet9sdb5H_jGcgyCMQDSUF1B1yvlA08hKvEX0pKgYkBgiGcy63.8hyp1hAKpJy2Y2z48
 czn1AIrg5vqCLfg1MT_wVwvz6CQXSrNTijuQygVWJWXCSow6LLCwO9A9OS1Hm0pVgMB.TC9bTSg2
 IcPi.ZWWIfBmXOSWAOi0sl8Sp1Wc0_oSjtvheo5B5RPmsRwsHSxT5Xoz91.Y0UeJ7VWLrazca5Cg
 BFPsUWO4Trhev4sKWvLDAHAAQ_DDYaBgKZJMdf_xM7O5LchNaC_xlqDTYhpDzut5s8PojR0fypNT
 IdQPUjyYzLIdxMySdX0OXkyy29E.7pWkY5PXA9jFEGyK0IR6wZ9S_qjXgUoBMZknVkaKo3.zyN1A
 cUNcwUJn1XzGPxEiUDOGZB8d6l.u4kFXNNS66HhjkiiStP6BOkYFLJ_9BWCkoQ9gAkC5I9OaQAkA
 6iq6Upw.lgtfOZnds.0SbBtYD7_VZMq.CbTey3sg33H.SXXAZyvpuU1PUdvdQLPl7TxGW2ozzQHE
 xYmGcFagq8FrujA60YD_Ric07R.XyF_DdO3Ltzz1wDBIgqX.eTwAReWPyqspuUdFovqrJoEDYdOA
 5wnsCIqRfekxM1W7BtO1MFZSc7Ppa3p6omYRQDmlCpfUrXsSB.vCnEivVFQCmNAfQNevxOnSuhIy
 QwUBfiKLS7k1SAQDT0oa17YSTv6JyVS.ncoat7m_QXlrGbQl8_s_nLt37xWx_Hp0ORjwBoP_27xY
 L7a8b8AvcrH0ufxZHaJvqyxgZ6hAmgI_WRtdmDfGrYlMKZxo4.u0O65rSCLBxU5M9IfwzoXkaZEr
 WIZ8jLEcnOjqYOYq3ele5imbI9qTPYWPjDFN20wLuz9NUrgM6jWLEXNdtA4lH0z3A5upt7trcwWb
 K1.PuJp7w71EaV3vzPygnDgOCKd9Qh7XNjFCRSGgk6fsNlxOjDOxwnsK1GlMapv0I75Nt_O9qzLs
 PTfE.rvjO4nYOkrZnGiha0yz1hbE_4xi0fOrNcPSTefAZVO6Gledv_r3LBfTwFPunhFDlM4iGgNs
 _Ah8lzRkyknqWhrmi.OXWwqeMIXbxzwLh0eZzF5EqlIcsWUg_liFlRQFuFSw1KK6zEDLmptSc0OP
 FNoKuByT7bOOuksqAsWVtIXx75qXoYO5cqI32qCXV08k9mJ6pHHyNOW2IKo5bnLzmHYvIkXmK2A_
 n6PEvbIQagdFfyv_raWrVT0eNOqlwP37TCL3ddMU7GPSaDWCEuTkXqoxBQ5whC7Sbwgic.RYChVH
 sr_251CgOBi.P9fLSNfAmxvkyl1x_2noZoRwHkxdHVg0iam6BQCld0qwPrE59_F6QvACG5mL.kns
 PMDIslWh.r7w.HuoVOL7TNn3KiV7qG.8h2LHtDR0PrYV9oHa6dqYVr4u87GFODl7JhC_lATNqFbh
 zeBy6l5alZTJUDDM-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Nov 2022 17:00:56 +0000
Received: by hermes--production-gq1-579bc4bddd-hbm49 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 065068aa4a352c836ee8e25097808977;
          Tue, 29 Nov 2022 16:48:47 +0000 (UTC)
Message-ID: <3765301a-0c55-6e6b-c964-888677842248@schaufler-ca.com>
Date:   Tue, 29 Nov 2022 08:48:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/2] lsm: Improve LSM hooks documentation
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/28/2022 6:42 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

For the series:

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

>
> The recent discussion about return values from LSM hooks, available here:
>
> https://lore.kernel.org/bpf/20221115175652.3836811-1-roberto.sassu@huaweicloud.com/
>
> motivated revisiting the documentation in include/linux/lsm_hooks.h, to
> ensure that it is complete and accurate. It was also a good occasion to fix
> discovered formatting issues.
>
> Changelog:
>
> v1 (security: Ensure LSMs return expected values):
> - A positive value, not only 1 can cause cap_set_admin to be set when
>   calling __vm_enough_memory() (reported by Paul)
> - Improve description of the vm_enough_memory hook
> - Remove documentation of the sb_add_mnt_opt hook, as it was removed
>   (reported by Paul)
> - Add more periods in the parameters description
> - Adjust mmap_addr and mmap_file semicolon
> - Move description of gfp parameter of xfrm_policy_alloc_security together
>   with the others
> - Add missing return value description for binder_transaction,
>   binder_transfer_binder, binder_transfer_file, quotactl and quota_on
> - Improve return value description for sb_eat_lsm_opts, sb_show_options,
>   dentry_init_security, dentry_create_files_as and sctp_assoc_established
>
> Roberto Sassu (2):
>   lsm: Clarify documentation of vm_enough_memory hook
>   lsm: Add/fix return values in lsm_hooks.h and fix formatting
>
>  include/linux/lsm_hooks.h | 227 ++++++++++++++++++++++++--------------
>  1 file changed, 143 insertions(+), 84 deletions(-)
>
