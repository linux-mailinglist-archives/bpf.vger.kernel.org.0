Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623BC60FC66
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiJ0Pw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiJ0Pw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 11:52:57 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092C193479
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666885974; bh=N2YpvW+5ItUJsnAIe1ipg8wFd7uwoIbNezB4yjf4fNs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eHKVlThrVeui6DT7v1oUK1wx/zscRbQr5L2XGBVZUF19OUaIczJPR4BjDwMtw+e/85dRhW7pHvA3tQbR56xIRJAzD+Lh5fhsdtU5vGjrz2cQHXrruR5xfGIxb+sbHbpMUDNt6A220+obAD/mzwLDOUa2IjvEf1ezHbFNkwUzuljP+j0Ka7KjQcaWm5lAKMeVF4QpzFlyZx50BDssrni1gaSLHS8fnFrIaX6psHqSaGWlQ1unQ7oVjJCw3smTaoL3FJyzGwm76RJlt0ESApNUX8qEbzC9//G98EaC6903CjHkFbOyg9vYlbxCaNfpfzsWkcKKPeRreeQ7swiC9Vpz6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666885974; bh=pQdBfjVW5UY0Fr6eHNFsU12NE20xS2VeuoZOu03N82i=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uk1uvp5MWkijDTD4MaCpFTPzgSOY8TiDru1rtKpGx39XSQNLjeS+/fQWYLDYMGWMmhyd4xq2lhDWof6HESUSrw7wJMxZnGC/gcwlMRWA1Z/96URJ/ogHhrt+aW4SljROh7i03TA7L46JGKYgD2/yEnEO6aRFQShCCcRp4Z+HseOdlAaPvBUXRPHoBLR+JQk8qNFy6uG17GJ0CK65k+6hlJ1zX3I90nxPLR21OJrAXJngG4uZi8dKojXWDjGM622y5v0iZYd67z0D7hw7uf07X1iBm3eDNzO55gZvs9c4miWVZXE/0pH1Ijt0ka/tBDfTdeeex1T9otHrDuuPaiiLXQ==
X-YMail-OSG: _LLe3nEVM1l8T5YgW55Wo1bbtUiRseVTSam9kKXhYpjwmDGr5E0r1_ulq07QSB.
 4XsXwmNyO85GePWt9AYzvCR3WgQRdi9QIjOcXy4duugFmTvtc7SFvUp80EmtAfqvkuSOvKaN8yTi
 Yw3_42CqaGu5NMkg.A4ENWkUhQ6cklOSQbYcIljMyXb7HzIVQFtz7g5kvxWHggGMYvVZnv902t5O
 ACeVGNGTfw77wXDGo32a74TkaK7wn.b07h8LMRctKphPcOPxVlJflGrg1hgtm3Z54xzgdG9_nS25
 hQzjRMhNm6J239hs1CPNHOB2pfd4OdgD8CpG3QL9eXelKij0mYDEeUaJTNDdwZy2UZr6Ap6yb2Da
 HaSx3W4HdfQCgAZlYTkOs1G5YX7KaaYPTN_n6SGyAVHmE8Tq99RIFiFlD0KbCPAaHL0aH4wXq7pd
 UZMZ5bIP6L8TIYbp9rN.kHsKJ7WSW53Ymq2edVLp2BkklAlbnNoWtPafHH90AoKTd9VrESiUJDAJ
 Yp2JjhqNwC5QSPCurXtlOyIK_DzMxozrXlEEyoOXzyHUkzGjMoEzVmnSrwYT5u02n30slrsjL6I7
 MR1.AdSbyCymcyVzSvuiZMdrW8efZXEm_TT2i8gqEUkU33cHQxpzbW13PkLm4Aag8QZL0aVFBT8z
 VD_R6LezNjO1CKCuiEbyZkqW1clZdUfBTW.PXESkMi2YBArATSodbxB2cAJ9iyHxPX0DlhDDa8xA
 rOkJjs6Q4kEPiwxeHaLzjKWlMRvs.MejZ4aduu0yvBCyUfC_G9mN_dBsRFoNzVZ572kavH5pPDbu
 Hg.3BuXLqEJpOSKnl11b3Kc2FSMeoBBB1bQkvDNOrCTNCzbihPdpIOhbs.Cy7i_qrdUAntkaTNIK
 o_avAzcXC6eH9oPBlIqswN3anJdjVcMUUELaiXKdbJ6lAemEzusx4oChYHNjCy.yUJ459nJamnWa
 mEBsYJJuYlvYIs1IfQIuVzbJaEC0y2QJdmZbY9.0U6QB9ShybTigSx5qCO52E6zna7A9yjC0jjKw
 XaDVQScdDK3nCdr5kb0my6Uc88vu9pSCLlVvjTLGipH.pKrNOf6BEnHcOPWYt5laMxp5MPoHnNip
 ywXGMN3U603ZpLj6mFcG6EAJ7jLFEn2PUDm8oCAJO9a0McBQhzi6zBte99YigJjub98hxLyMkkrT
 P2ThWN89RwzohoLQ860YHWOFJ.jXjL7f_wSvgRiRuS4gyE.zFX4NZ0GUyI6O9Wi7RwpLWevVCray
 kq8uFsyO7RcTjuPWHMnywJKk0ws.vcvizi9Rvm07a.lQaoFvmWqKbwiH_BKqFeSyFqoEQI.FLWrF
 7qvsumOHrIAA6FrvgQLa_rBKh_dDYDPYCh1r15yHJAnZ6ocH.NZ26YcMAZfPn8Ifu44hij7iq8bF
 tDsJrl.SPGJ_xoL1UwEn27.iR34rKDEGtE8P_SO4a5ZGzeOJ8WabLaj0ImrHW7CaMoMQg5yfWsn0
 AG0Ro6Z515IqsLii0.MgplY3vkVb2V0li9k4vN8NTW95bkfWzRSYEkm2j.UCvwC5hWYmMdTYoxub
 Vdu3vcmVIiaZjO6sfKE1mdS674vH70DbA1_Qo1C1mVA7cEG_y8aoFA3mE.f1dciZoqFmHDIC2Wqu
 TtGe_gh1DxAZjS89RHwGUtlBC2h2wuzRdURVnavBANLHrdNmwUvZq_QF2FOzsYCTiQlvojdSBnN6
 H5ZQ.3nplIHFuqnULQJq_CgLk6CTg6FRzhre6rNHl.8jxk1cks7.sQqJJ0SK5yaGNELWIVBi8Pi2
 glH3RD.USzznXdRMgkLwZWX7Jvn8Q8QfIsvPMUKzlBwBRzN7a4YH_p2K7yDzeu9vDK2kjggMLixb
 10EBELs5Hu5vp8JdKDAEuc2N4.JspCleUqIk8qLzxboirhxeW80jSh1zXh3BlQlSqXlYjDqaj_IR
 p0WT1dl_u8EqUWfsPUo361U.3XZIPUpHTTm0MTOsFoZh8HWRRc4EOmykpZIVl.84rXdfQm4nn3UR
 e_t4WWugRCL1bmeSZTAA_F7ZUojuVk5BSNOt_UVjzKUxBOPO9.2fqW8OePkzVUsybkTv3.ydm1tc
 fT3sddUUd4AFGDTPNyjCGz.XjXERjowguxbLTMuMcYyr8QKE4fwTGmicuHMUXrhyASjqqssuI0bV
 pt0kCSlqeBh5ZoqqeSMUwdJkEZqDl6anI9exvPnPUA0PvswOsCYqEFkyC1klwuYZxBD6nwiRhZk0
 FyggKryWPzddYIf9QIpmS.tI2D_nkdSY1FQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Oct 2022 15:52:54 +0000
Received: by hermes--production-bf1-64dccd5d47-f7vnj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10f49f79f0cdf48ed8842991966da22c;
          Thu, 27 Oct 2022 15:52:53 +0000 (UTC)
Message-ID: <fc303279-5853-4be8-6055-649f23a3ac7a@schaufler-ca.com>
Date:   Thu, 27 Oct 2022 08:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        casey@schaufler-ca.com
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
 <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
 <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
 <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com>
 <CAADnVQKD5e9vKsSo1TPeBm5hr6j4GzQeHqRURoBJyB++VOwHCw@mail.gmail.com>
 <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/27/2022 3:39 AM, KP Singh wrote:
> On Wed, Oct 26, 2022 at 7:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Oct 26, 2022 at 1:42 AM Roberto Sassu
>> <roberto.sassu@huaweicloud.com> wrote:
>>> On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
>>>> On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
>>>>>> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
>>>>>>> I'm looking at security_inode_init_security() and it is indeed messy.
>>>>>>> Per file system initxattrs callback that processes kmalloc-ed
>>>>>>> strings.
>>>>>>> Yikes.
>>>>>>>
>>>>>>> In the short term we should denylist inode_init_security hook to
>>>>>>> disallow attaching bpf-lsm there. set/getxattr should be done
>>>>>>> through kfuncs instead of such kmalloc-a-string hack.
>>>>>> Inode_init_security is an example. It could be that the other hooks are
>>>>>> affected too. What happens if they get arbitrary positive values too?
>>>>> TL;DR - Things will go cattywampus.
>>>>>
>>>>> The LSM infrastructure is an interface that has "grown organically",
>>>>> and isn't necessarily consistent in what it requires of the security
>>>>> module implementations. There are cases where it assumes that the
>>>>> security module hooks are well behaved, as you've discovered. I have
>>>>> no small amount of fear that someone is going to provide an eBPF
>>>>> program for security_secid_to_secctx(). There has been an assumption,
>>>>> oft stated, that all security modules are going to be reviewed as
>>>>> part of the upstream process. The review process ought to catch hooks
>>>>> that return unacceptable values. Alas, we've lost that with BPF.
>>>>>
>>>>> It would take a(nother) major overhaul of the LSM infrastructure to
>>>>> make it safe against hooks that are not well behaved. From what I have
>>>>> seen so far it wouldn't be easy/convenient/performant to do it in the
>>>>> BPF security module either. I personally think that BPF needs to
>>>>> ensure that the eBPF implementations don't return inappropriate values,
>>>>> but I understand why that is problematic.
>>>> That's an accurate statement. Thank you.
>>>>
>>>> Going back to the original question...
>>>> We fix bugs when we discover them.
>>>> Regardless of the subsystem they belong to.
>>>> No finger pointing.
>>> I'm concerned about the following situation:
>>>
>>> struct <something> *function()
>>> {
>>>
>>>         ret = security_*();
>>>         if (ret)
>>>                 return ERR_PTR(ret);
>>>
>>> }
>>>
>>> int caller()
>>> {
>>>         ptr = function()
>>>         if (IS_ERR(ptr)
>>>                 goto out;
>>>
>>>         <use of invalid pointer>
>>> }
>>>
>>> I quickly found an occurrence of this:
>>>
>>> static int lookup_one_common()
>>> {
>>>
>>> [...]
>>>
>>>         return inode_permission();
>>> }
>>>
>>> struct dentry *try_lookup_one_len()
>>> {
>>>
>>> [...]
>>>
>>>          err = lookup_one_common(&init_user_ns, name, base, len, &this);
>>>          if (err)
>>>                  return ERR_PTR(err);
>>>
>>>
>>> Unfortunately, attaching to inode_permission causes the kernel
>>> to crash immediately (it does not happen with negative return
>>> values).
>>>
>>> So, I think the fix should be broader, and not limited to the
>>> inode_init_security hook. Will try to see how it can be fixed.
>> I see. Let's restrict bpf-lsm return values to IS_ERR_VALUE.
>> Trivial verifier change.
> Thanks, yes this indeed is an issue. We need to do a few things:
>
> 1. Restrict some hooks that we know the BPF LSM will never need.

It might be difficult to identify which hooks will never be useful
in a general purpose programming system like BPF. I do suggest that,
if at all possible, you restrict any hook that uses or provides a
secid. That will take out the bulk of the "dangerous" hooks.

> 2. A verifier function that checks return values of LSM
> hooks.

That would be grand.

> For most LSK hooks IS_ERR_VALUE is fine, however, there are some hooks
> like *xattr hooks that use a return value of 1 to indicate a
> capability check is required which might need special handling.

The exceptions are pretty rare, and I don't see a reason why
we couldn't "normalize", or at least more clearly document the
outliers. 

