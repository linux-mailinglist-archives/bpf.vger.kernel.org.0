Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755C0549BEE
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiFMSmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiFMSl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:41:57 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86885E277A
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655133829; bh=k6swwIFZqAzL7SBEhBTa/ZMKE1/o6lUjDfKoNOQ84pw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ni7z0Gs+JC9C4Tu59d3o/4uRAaKCLDYcFEy44hcCpA7MUDRFpD7OHcTOELJWl7diqkZs67DcN7lzjA22a5CeApLxtOcYb4u98yq4IZbL/uHomdhKcCkPUVttIkgnudy/nIOEs166f2b4s5xmK3B7x38hcJkRFIkXTkM5qG8XDe4MMao0wuAmIwE77nNCbuRamg7EaQSgkHcVGH4yIvy/tpu+8e7olwPkGZ/O3GixEgon4apaQhDyuaabDwkZUVsv9I0FSLbTVpfZD/mcXJUwAZ2UXkCCaNnLtE6v5WE7Sx6MiFcNV2Tqr/s90AQ78mqnAK8hWjJFYFEdzJdTGa0N+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655133829; bh=qLsakBHZ+VMj03EOcUdNkyzlgqLy9/XQiSqX2Jmw6st=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YfTVYfPxiZaVBM6xo5uP+dh9Umv0tJsBPyCHy6M27X9viwxytQ33re15GoU/DvCYfJAOwHoID+CLHcYfR4IWh50FD+9u+G7mRiLGJH5MG1+dThWMM2Q4qGRO/Zh1sJ7UiPYjqX+FJf5xktFGKjIyaMUaC5TFiSZBaxM/7XZJY/X4yCVWDLHDb4GvDg9bpRcqUaWSW+XWObXWl7Ci/AZUY7D70Nsqb90+u9mbcUx3B9a2dxeBMvNTwVNE9lUzqOSqN3yfIXfvTYKxxfiKys43yaasrKLbdlUFFA34zrjjD1PFdP52Q2mWcx6R/Ec3A/gh6R2j1DqYRkLi0+WDw3Htig==
X-YMail-OSG: zJivHawVM1lR1s6hTjJMPj9G64EwY92.2d.rC9Vld3Kq1JvPg4FSnEt2oYijaVI
 03eJpXtWYi9I3S8zIoApE8vT1MeaNexrgdormfVYCz0x1FNYFcC8IWhaHd95JWHV40gZtJfxBShA
 Zb1XtmgXvPOyWZPyASGzgBfebcSmGAiZX.Jx75QDyAS5GEIxo3T5c3Ziyn624P5B2dMfhz552aog
 Nb5P2pY6V3EnC1WRJF.MQxMq0knGcN5Pay50EIkPtRze1qWMM1h9A5SwrPFG7vqsWk_YsoCQyavU
 Uw48v0dre.y8hf5dEtFGixtvpdUNW4pN3Y8PHWdrkHunvUOlfgLXcdW_bfWSnbLzUK17v1iOo5iO
 hCbB8Vxtln_TwHANMFAjzNzubjrs6NJc0ZEmKJ409R43mAKRQoeU15B2VM623MexUhhr3IRlbrY.
 SRjTxN6soC2X_SVDlp4uEz7cDHGLtqK3GdM_9iUTeuzf9pr3Lv_ovl0JdM5i8F_FbMF5crUydYDf
 ouvOCX2woI_S_vvljQDMip3n9p0a37JZDDwGuLZlaOHLIcsPaOkFDvdYc5xrWh_ZMN3q02sSmYtq
 7pFRccKX_3omQ2FqtO6hOakAkeLtTcyQjr4gu.n_2B06pctRHac2nJOFa4N1AZReRL.9ezpvAJQY
 gORE.OVVUwxjTQAT9D2otHooDkjSswXsWGwO1VV9SUn17dluagsX4hsuVFo.NI65GH0RYWakP1ua
 tvC9blLXAFi0V4_mOnV7ExCgHAn96MyuAxe3u4vuhd_FFP0s9MqAKT_CcEDjL9gv3gBpDwzJfD2r
 RsH_8GW9pvzD.pppHHlpwiIz75thCLCWC1ebAb76DAH_vhbdKVfqcVM0a6i0Pe2LWCZaghOPbKpG
 Tncfgo1AJ9O9eoqEpR1PUBZ2AfbzXDXDMQslBdR3QWSJPmbdfH0cXz.orlDVUzXpbmIn8ay5UTUl
 l63q3F2nx17jJQ7ZXXO1nsKHlJLPS831u5PhDD5G2QXN5U9KQGFXJILOFePg.16qvelXGdSYkpUc
 Uj5CX4jtUDiDcxj8WnT9lybyVGL8u9rjiJbjyqhiJMmvH9GdoArQmVYhC_taE7zQVonTO8htYUT8
 Slei5DNz.S0vM4w5tq6y.B5RCHg.jzk_kV2Y8n_nEjo2EJW._WbyvTrYKbxhvyqjMkm3_j8_MfSc
 Q8Gbbu1MHFF7eRJHy9ubw0fqhpM89ieukTDCpt2aYuM1BDk9M0ImdxvYFKkrrHlHOhPh2CIRU_jo
 pbM__6JxvQ6LlnZiUNd9NoEkykXwObaXFkF9oVdDwC28TzuYJKDzyMDnkgWUYp0TJha.JB.Kg7m9
 JjunO5U4H6e2WHv72TttNTymPSiNLtaMl7VmVA_TePR3rhiXeO4CXVQS13oBWS9_AAQ5Qp81U1ma
 KcVEUVrhNbaOKsyUFhXP4Gu64AD7S0xPpDlZ9yR.KCRvGi3ImbwkAThInYI4iuy1TJiFLI4yzJx6
 _C.Da_72YGOy4_i_gjLJ_mwF4Fm3VhlhSHHaQMJjj_yHzKyOCwpDN4DfGsrfw_6yyyyjSW_e9vMs
 IUdaDMv3oz8JYfhpD1MmsytLPojGrWdj_qScgpPgIyKxlf5rs1Ef438otpnDFXFX.UA6lri6LeFs
 gqhEPVAXccFO4nq2328CYBkZC_pAgkUOL7pmR6oOdDi_y3MYUbWOAMCsDqhZ3FYrMx7GkRxMdjr8
 UW33O6ZBP4BJEFQ5kvMDxYz7_RkT_otfjdNGkT27RlsEGy1PqBGG2Ucv1ArwutC6gCDbc7C0h1fP
 k4Tdt0DRWlX0mctXo.A1oWOSZOMWKjksWJYUWYlcZH9mefPrnW3fU7Io8lGLcH.6OsayvMJ.Y7yT
 Of4uFha322Uxu5zw6wnUnxyCZ1RgUkPKwTTpVglzU7mR5r4wK6iDNliLZY6CXp5jQgdcaCo2iEn6
 YpNML76uCBkjJ7orpSYEke4nDHY1kmxJw3DXc02JeCZVtETQlprXbaNaUgYbSteNLbOzK2n9Is_B
 sS2E3dG.Y5Qn0J.7Vl8Urt37DZrmu7C68zObaHY_35jQFgJcQ1iAuW9R4TIMgTufWcqbMb9HKmXn
 Hj0MJdd3FVYy0mEOrIWwpoWd02R7mvhnuKAK.iFBVd96psvU0BqhhwKmE0048hKrc199sjWSWEAK
 e7RTwY5zzvq4QTMvHK1KtLI.O2Jy8_SjPAEdqR3OoOsH4A11GPzdwnmGoOkEap0HZTAoX.BkELVQ
 QnHpLUoFe5fiKQxN6CVBlBzAYcK8wo9qfEqdPifSkFn00cERpqCy4UI_pLqnBEf.agjgBNrI7trL
 fcekNnIIxljMGCuqrtQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Jun 2022 15:23:49 +0000
Received: by hermes--canary-production-bf1-856dbf94db-lhjkg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 31b0896f80a37b0ff0abab2c4fa57d76;
          Mon, 13 Jun 2022 15:23:46 +0000 (UTC)
Message-ID: <5e6d1293-000e-18f9-a593-8efd49eaa55b@schaufler-ca.com>
Date:   Mon, 13 Jun 2022 08:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM
 hooks
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220609234601.2026362-1-kpsingh@kernel.org>
 <bc4fe45a-b730-1832-7476-8ecb10ae5f90@schaufler-ca.com>
 <CACYkzJ6e2f+vdQmWBvRaQCJJ1ABPrfw4hYU231LbwhB_03GWLQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ6e2f+vdQmWBvRaQCJJ1ABPrfw4hYU231LbwhB_03GWLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/2022 4:49 PM, KP Singh wrote:
> On Fri, Jun 10, 2022 at 8:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/9/2022 4:46 PM, KP Singh wrote:
>>> BPF LSM currently has a default implementation for each LSM hooks which
>>> return a default value defined in include/linux/lsm_hook_defs.h. These
>>> hooks should have no functional effect when there is no BPF program
>>> loaded to implement the hook logic.
>>>
>>> Some LSM hooks treat any return value of the hook as policy decision
>>> which results in destructive side effects.
>>>
>>> This issue and the effects were reported to me by Jann Horn:
>>>
>>> For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
>>> (via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
>>> by removing the security.capability xattrs from binaries, preventing
>>> them from working normally:
>>>
>>> $ getfattr -d -m- /bin/ping
>>> getfattr: Removing leading '/' from absolute path names
>>> security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=
>>>
>>> $ setfattr -x security.capability /bin/ping
>>> $ getfattr -d -m- /bin/ping
>>> $ ping 1.2.3.4
>>> $ ping google.com
>>> $ echo $?
>>> 2
>>>
>>> The above reproduces with:
>>>
>>> cat /sys/kernel/security/lsm
>>> capability,apparmor,bpf
>>>
>>> But not with SELinux as SELinux does the required check in its LSM hook:
>>>
>>> cat /sys/kernel/security/lsm
>>> capability,selinux,bpf
>>>
>>> In this case security_inode_removexattr() calls
>>> call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name), which
>>> expects a return value of 1 to mean "no LSM hooks hit" and 0 is
>>> supposed to mean "the LSM decided to permit the access and checked
>>> cap_inode_removexattr"
>>>
>>> There are other security hooks that are similarly effected.
>> This shouldn't come as a surprise.
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2281257.html
>> is just one place where this sort of issue has been discussed.
>>
>>> In order to reliably fix this issue and also allow LSM Hooks and BPF
>>> programs which implement hook logic to choose to not make a decision
>>> in certain conditions (e.g. when BPF programs are used for auditing),
>>> introduce a special return value LSM_HOOK_NO_EFFECT which can be used
>>> by the hook to indicate to the framework that it does not intend to
>>> make a decision.
>> The LSM infrastructure already has a convention of returning
>> -EOPNOTSUPP for this condition. Why add another value to check?'
> This is not the case in call_int_hook currently.
>
> If we can update the LSM infra to imply that  -EOPNOTSUPP means
> that the hook iteration can continue as that implies "no decision"
> this would be okay as well.

It would be really nice if there was sufficient consistency in
the LSM infrastructure for this to make sense. The cases where
a module supplies a hook but only cares about the data some of
the time are rare, excepting for BPF. As I mention elsewhere,
general stacking is what you need.

