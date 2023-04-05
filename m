Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB18C6D8942
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjDEVHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDEVHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 17:07:46 -0400
Received: from sonic304-16.consmr.mail.bf2.yahoo.com (sonic304-16.consmr.mail.bf2.yahoo.com [74.6.128.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222061BF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680728857; bh=JDyh3wAFbW2Z4H45Zj97/BA/DNQxW03YfT7x8R2XxAo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DkvbI76q4R4szrkay2tV2ZeaYU+gZt2Drj4STqWL7HqJqCDYwjb8cuv8zD7KosZ8uLEXec7imQXeEo0wx1hmYKWLNQ8ca+RVWNoh8a4egishv8wFB96ZVPC1iK0vF8R5Zcw1tvD0I+0tiUxgmUH+qOc0d69b5nmJVbKI2BW1WTCZbeKPMBbOcJIUPK1sb5UHcO6sKHcWGS725aDKHYm2vpBxAU9y5SdQbGECKrRVnM/wWCPVbiwiL77W8Ly06dgI0ztL7XhXhdFmGqOh0eyN97YNXHWJq7x4TiVDlu2mPljY0JcVYZgqXC95JJqqpxp/XpO+/uE7tLnJRMzfaJ2eXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680728857; bh=yFNRc4SjcjQ4INjRB5Sjonn1iXLa6IoVj/R+NGLz4KC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F3b+eQroOCD1xOK2xqW67GjbbBcJwel0+APe0d+/hBykKFL02z0Y6JAHd7v06VvFGvvTsCDDY2019YozSqIwO6G4Zg+DOYUM+GO7iRQyGrVJxw8gJ1GPVvwDtOP2L4R6Pa9VrrP4sp0y61H54lsHj3Cb/ub6vxc1+T1L+dETGZTxtyefMZ6yzvyxLcbqie+aJ3fXxSy+mtOEpn89iED+vL5lv7VBCGViAcrI4J5DqLYJh7aOI9OsJd7onA4T8kGRDyLm0iQB4yAV6M+b4N8Cdideujwv2o3ys/cMkLLcuV/B93+guoUs5TYwoOQ8BfMGTVUSNK9CjBFk3/cAZ2BqSA==
X-YMail-OSG: dHQA6toVM1mcjfeiWC9RqrDsBpuf98q9wEcnG9eyx2kWWUzefgEVbGMJy35rDc.
 sGB5EYCm6.H7J_5tGccnQO_cqfMyjI5316._fh8jxINl7XWX8.oPVP2NpJDHOVtI77mKC.iDN_Z8
 eyGr3Bt69PSMJ9Oq.0CGJlKte8.CQaHNn6FgzAhHLkVN03DYv2QbP0eX66hnhoZgHeqKYYDzl3tu
 Apj3Nf33OoGGpSIxAJTlpZtxg0rSm7cvDTZq9E9flwJF2GafSl_5a9kl1TTgIV8lCLY3GNGka.WT
 Ewim2JqgOo9lQNoID1hFG.IaVWzjksz8dnIvn66s1vKN7QMvzlJ9qsedx6z9YQ.nDLAKi713n9z6
 IY_X57Wr7TO23z.l55HxHmRHAsbc.p6q5JKp0wPTs1eR4QEMsagoPKRY3S9BBuzYhzNMwa8XguEQ
 ApdRAjArUZqCC.Ktxto_IdocfmFAQmL8Rmz8szR_LmyBFhsiANC6HZtAgw4F0NpiuyugehCsqx.B
 b6qztT0NI2gmaLSzcKvmJvbEayv8meaqazkQDFMs3J3kCsdKxZMBH286rnpKCoJEpWWQli26NGjq
 fOWbuSzIt8JY7yKJi9d.0oFSKybIfnA6K3w9gxV9wNZyI6dewlTRXDqQVErsXNpO4MsQmyjDlzuW
 g5YPb6DZOgXQCFZWFZt3Dh07OOdQ25RQMzbevcAJKFEqHnv58jt8grYOBMDtSs0yFClE1CH..Geg
 0LnSLpj7qbW0FiCs1HLnjT6Y9chFi7vamCFe_MzAivlaYKQjrl5_fdKZ6d.ye0l_IVzVq.sHWiyQ
 HTbMW9xJCj_QyJug.QJM9910Nq9ya03Ei45XhDevHI.9c8fRU7nSF9vvsSlDsQHzx_Ia_LLnsOg2
 2w6kvU9q.xbQQtRuLViEKbX3MavZM__t27s7KlKGg4Tn5Fl8zuPXx8NjdqC4uLlJVGxtuDJLhPur
 TaWPo_yOqjnImSEzm51pXs8DeFNNA_XkUG3gPgOD_v_BeM0zSZrSCRvqbTemt0KTTCT0HYvvLwb9
 M48HBHoOIYJExtaEid1JXJUVzjAkUsWcZ6UX_CIOV7Vl92G0Clq4CmsdaLozcs9pmX5wcaw.uYun
 e3dGQ2G6IkLTN0oWadTxvJD9duaCazyGA81nX0GLRdW.ja3Hu5n9M82e6b8L_BjOxRjTia7EYAcc
 udSTAKhHt9fk._PCXCmRNxtfDRZU09BffVH9OXgCCzbyN0q5WgH6SCUzpkDn5Xs9yvBOWSFcLOdy
 yKPCz31wvyV0lVjuj1WdpZY.fOjFAI0xjnyNFNYMh_HBtZY5MGRcQKGG7lSLIp4ZErf2Vy6VZ4_i
 09QzPTxi6m8ui.QKUNhzCstzkkTKyqz6G2uwh9YnIcz_x_ZRGpk.QUO2ec6fHfhOE9P949QhAH8E
 Iq1h9SYOsDPD25nf.UVMnwVuTmxhaenXWXsmkzqyQECc0J2B1I1JclF_oX0xUvF_oiVQMQCDLChr
 bnniNjOZ4iCEgS8_QCInOP32EOW_A.M2pyHpMjiF0fif11uWQFME5VrZoMvUOcvKkikT4yhLforl
 .XbYgjcioFFPuOkEoX50az9oBg4r4C8GE0Wxdn2A4o0D_UFRlRP.CVVw7yh2jKNJ1Z77aP9CH33Q
 GJEHLwCZCqOkfdqu9imcSK96yzHFEEF2inD4hA54FXQeLmRtSBuN2vbwsKsINvZdyDjyGrW9jaTR
 ypEO5JakQOzXuIANQllZvNdD9VouvwY5vtAEcvvTqml0e3zfuFKNJs80WhbvWg2tGK5hC7gMJ99n
 t9NopdpIW2NTDUU1k4rDHQcFp1mDtmS0RmCm1pRN49azIAGU3wSh1Hq.SkaFQXhQN61Er4.8PpR.
 pAm74JCkXbXEI13s1T4L2jIKoypZ2idvUshkSUaexMr_ZjqIwssKT316JM7.97TCnMfSsMpRZVxP
 vbDegYTv597WfGoWqnhzTklwgPdHwLEuzsoly9NHgSZk816GtefJya4KlLY4JY_CPZIVFB2235r6
 dRe1VoTpKAy6bzcTEobx5IPgObPB.afQFeiZG3MRQT21CNbuSC162ci01Qqbeu.aiVEaUoNNQct8
 UIBv8nA6airrLjWAEIFA50bXoiPzkEs5qPCoqvfryUddK3nggFRN6sZr4Wcv2.Rdt_U_MOSou93f
 .bnYB8Kai6UuMOEFXhVEw41uZWTmxOP3HE6VqQSll2L9WScivg2nJKuMAYXaM5Bwa3chXFoyh38B
 .Q5f_2djPb66t0lPgsMlTmO.qi0PWUHics3bT8sEjC1AN0DeC8GidA5uGERhP6X6yRdwcsvXnP0M
 xEaiD5DcG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b263402b-59f1-42db-bb60-a0f824203bf4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 5 Apr 2023 21:07:37 +0000
Received: by hermes--production-ne1-7dbd98dd99-znv4z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f016e0c9d49925d34e0500ae1071c25;
          Wed, 05 Apr 2023 21:07:31 +0000 (UTC)
Message-ID: <c3751b2b-aa4b-2105-c238-29816bc85607@schaufler-ca.com>
Date:   Wed, 5 Apr 2023 14:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTO02CGUt0DUUmx=TUYS7Q81fas_Qy5miOFonaye0NEmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/2023 1:49 PM, Paul Moore wrote:
> On Wed, Apr 5, 2023 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/5/2023 12:59 PM, Paul Moore wrote:
>>> On Wed, Apr 5, 2023 at 5:44 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
>>>>> On 4/4/2023 11:54 AM, Paul Moore wrote:
>>>>>> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
>>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>> ..
>>>
>>>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>>>> index cfcbb748da2..8392983334b 100644
>>>>>>> --- a/security/smack/smack_lsm.c
>>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>>> @@ -52,6 +52,15 @@
>>>>>>>   #define SMK_RECEIVING  1
>>>>>>>   #define SMK_SENDING    2
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Smack uses multiple xattrs.
>>>>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>>> I think it would be good to move SMACK64EXEC to its own line; it took
>>>>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
>>>>>> when I only say three comment lines ... ;)
>>>>>>
>>>>>>> + * SMACK64MMAP - controls library loading,
>>>>>>> + * SMACK64TRANSMUTE - label initialization,
>>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>>> + */
>>>>>>> +#define SMACK_INODE_INIT_XATTRS 4
>>>>>> If smack_inode_init_security() only ever populates a single xattr, and
>>>>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
>>>>>> this '1' and shrink the xattr allocation a bit?
>>>>> If the parent directory is marked with SMACK64_TRANSMUTE, the access
>>>>> rule allowing the access has the "t" mode, and the object being initialized
>>>>> is a directory, the new inode should get the SMACK64_TRANSMUTE attribute.
>>>>> The callers of security_inode_init_security() don't seem to care.
>>>>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
>>>>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
>>>>> allowed for multiple Smack xattrs, but I'm not clear on exactly how.
>>>> If you like to set an additional xattr, that would be possible now.
>>>> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
>>>> another time and set SMACK64_TRANSMUTE.
>>>>
>>>> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
>>>> EVM would protect SMACK64_TRANSMUTE too.
>>> Ooookay, but can someone explain to me how either the current, or
>>> patched, smack_inode_init_security() function can return multiple
>>> xattrs via the security_inode_init_security() LSM hook?
>> It can't.
> I didn't think so.
>
> To be really specific, that's what we're talking about with this
> patch: the number of xattrs that smack_inode_init_security() can
> return to the LSM hook (and EVM, and the caller ...).  If it's only
> ever going to be one, I think we can adjust the
> 'SMACK_INODE_INIT_XATTRS' down to '1' and save ourselves some
> allocation space.

Does evm have an expectation that mumble_inode_init_security() is
going to report all the relevant attributes? It has to be getting
them somehow, which leads me to wonder if we might want to extend
smack_inode_init_security() to do so. Even if we did, the maximum
value would be '2', SMACK64 and SMACK64_TRANSMUTE. Now that would
require a whole lot of work in the calling filesystems, as setting
the transmute attribute would be moving out of smack_d_instantiate()
and into the callers. Or something like that. 

