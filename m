Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A64611550
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJ1PBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiJ1PBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 11:01:18 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58CC8964
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666969275; bh=kNyK8LiHAxU0Baoaw2EBjtRpMgg355HG5nEDCzX07uA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=X0zRLVfVjuirsCU/mDJIrtCmmPjdwSwgg+oQCN/mJQdic/ZCJkEtMjMeT8/X6zbjcPXTtWHntaJ/YyztPNQ+FVCyLe7iuC/iC1xkp6Gbf/10cmN2XLdCgBQbpQZ3gsGUBegiIGdijVyGICBNLXkp5Y1OcpFg5ZOVd7KeWKtlSMBQNXoKcRXjm0Ib8OQM7uXJPo1gxjF+/OjjOV99P0MdCPZkfGnVINfgopb76ndt5djk0aRXguQlUGE1jlPZJDCg3Snrru8T/Gq0xcBZHZB731YFhVPhD3DNgLzwDnLVqZKjuA35DrDwiCLu+pXPh0OalUIaP0BZQHpupVxBObapxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666969275; bh=wSYuNAOgAki7bK5lvCSN9kVE3M3h0vR+g/XcV1Vtm5z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=krdg8gLXxPZ6QOaJ0rGzq1vJDc6yRmz38b2MC4msKbXj603wboiYYaBo7H0O+qw+nfGa+GBhRXIZPqvP7KBAWcBuUE4udeasYBRiNRXLB/R7n9l7Ca5fLyNy2fTdZtYufkRKbkMTvSEi69wvZL5sdQ/Uj6jzCJC//OvQhIo/x969E8dc9jS3xQehuTBCIfpj7NEdNu8w2U8vhUlihPqL84Dt20K76kWH0WZMXA78CAUHEpANtRxYCWTnUabmvQjaRpPas8Zt7XLL3VEGt+2UWXb04D2BjpbIOiUrQBG4bNy56mx83LVcXSY7cpbGOdPyV4riDnwca2XtoHnOXf9f8A==
X-YMail-OSG: O.kLg5QVM1nwhdI0XQUEtJZRGiAnTeqOciksCLu6rAW7S_SQiX0tucWp__SKGe0
 a10ajouyEELyqUOt4eT84_iSnsGN1VZbwhOkHiZ3dMp3QgdKDZCAIGaZrJof0bRl3l0OcdAxVBNa
 obL7PQ4YxnEQ9tcoYQrFQyboq4qTl8BEyVXFTu3ZcLUNuMrPd2sYVaVNCBez1Q7XrdtCCyWjJvAN
 Sb3Cl7N0wCdY2MS96wD_.S4AjYRWNLt0vF_slXa8J6KYAHPsiHzmf_ArIey.NCnLP90gmi_lI29g
 VR7Lod_Latv1DjneKoGda.Auoy45ZE4rw9Jqprj7pQ_PcvCOno9RXPEhDBWForQz3QAYL9RDXf5Z
 ALdgmEMx74i4Ev.LWQh8RUl9We91NH0e8pn31Zvw61zBMEiktLKEzB8kHu7agB_boPnKwyYZlHpK
 OBOY7qaM3gjuHxkmwIyYMKNaqZ.DWlIazsFeAdtkdX66eym.UqwK0CGu4GP_TJHU8WcsnHJ9eR1J
 PZ5gCm9i2ARZDTrXaMvZ8YHR9T2kDdNVjhyVje3mnWQs23EOGdyhuh6Bhk2xJLNp7HM8Wl1XGt_6
 JU1Q8U1smdobw6FfW4gxIvV3cDcOok1sMq8TfNNP6LCnY0PrpD_sBkW1CstPxejcWyFYpmy6UZKJ
 Bd8IwLnAHT.x7D0LvIKnn.IGydc9sp.I8uRxaXLXV1VZi0gmqRKlCJbdeYDK1w7RaG9awhSPojgY
 DvTJ8cVPnMHiBAefM25gseZzDSAvA0MKtwwVPEZ.Owkefnhz8ieJ0oYf5ZZWxhBgVrXiQJXZi8ms
 0BSg2IGuQT23zKdBuCfE6hLSAVZYkKSMly4mvIe9hA38Brc7eW7QqKsN3FEbMT7xr2Y8uOLhslxZ
 cHxYjoDpuZAoqQkVs2cBDiP0r1n3LG9laPGtSVYuk4JE968jf1Sscw2qiiVyaXhfGoFNe_I1thfJ
 37xuGRWlZwzTxIb5HMMqrRko0_VYgV3ky1tqOcsDgTYV53M01qXNBnCCmEIvdgNcSqbqLnVAccg6
 uv9OIsucpNxl19iCAAhwtXImrWDICyKwufP49pozFsXLR.00iRoQkgH9UgHQbdNBLAmFTZipkBgb
 sKjH4huEaR0YMs3xFsfRK3OV8p5itZR5VISWI5SQ59UKjebCh07lpUvP1Te7SP6GjNNnHI4PXI3l
 isyN623CkH1ytttSKJtk22ZQUyDxw1Ywn8iDGavAfCt2IwTaOKEvPuqOMy2FjIOxc9VepPTnVUlB
 PfDnPq4sgqrhPTHw_V3AWa9J.eycEnusFx835ftdQKm0FYHbogHn0SpwLmwWaniRiF687k_sH.xq
 A4dlgUbYzb8RfLLJO.i4DfbEEAaVsRQFgrUo_DbzMzC03T_jIQK_8tnYpf1ZGD0LoRZzbUefHgBr
 CBblYNYtHqiCbgkBbO6TlOsiks_cg.DDyxvEnksNA.6LVrNK.Iqp7tYRBBXgpHuTIzFhQ85fRIwF
 fcAS0BW8m6OwRQP0hDm7rqP1NMUSj9jLb6fXPQ83X7hyOrpxP6N1XF3wY2mQIqQT3Zmcy09GwZCp
 Z5ekgAaKmWpa8anITEMg.10SMTEr7NMNXqNq78d.H4q7ulZ3L.6_xpHdOslAZiMvb7AzryNk5F8i
 rm.NZDfyQ..FctKVgQdtN4zNADyiuIn4QrmWARczKi9u7FBdjychWkX9K9wWCYXraQbkEZ6mbi.H
 u4tD6S.rGIOjl3NDkYXTXFj455CGdm0Cw0j4yuZrtN0Vqmz5TqtiJyjTXz4Tcjvhhz.t.fh2IIA1
 ZPttAI8zKhMvC3KO5sSwOwKHoTBMSOk3a4wDCM49b3PJeo9NYRX5NdKTSrCDW3JhpwR6c01AkfVv
 mhW5M2s2Y8HsbM5DTAkXYAzSyDc9YPPT.Tz7q62zxTfQjs2H0ziGGEWFP8Tz4JK8JeAXVDHg3S5j
 RiDwErke04OQwIWf1gelx7E6MDcF0veiC0bo3S_VT7GuJuQYZg5.d3x827X6U1DtUJg5AaexbFoE
 LnlHZm8rrIiZOqWioQTKspDXKKJSsJ5V49naIa4aT2CJXK8zmZORSNIy1PMpWcPcjolQDuBJIeUp
 iUEZN.cb0_xZ28fI2dAieg4P7EpiYAAYJ3H0bNHKa5DKBoxGOkwGqaskkf0M2VATpnvzVeFqM_yf
 h7CFWPaKhR7_yiPGrjkgsSjUbcGXRtGErC33yqL_uc4jcDQT_Fxqm.y9JzIqJuYQVtf2VB9IbSHP
 UZ11BSuN2.bpIIDz7RNZs0njzk5A-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Oct 2022 15:01:15 +0000
Received: by hermes--production-ne1-c47ffd5f5-fzch8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 00a6f1cfa7da200883440c6b3d111468;
          Fri, 28 Oct 2022 15:01:13 +0000 (UTC)
Message-ID: <3752db45-c89e-dfa7-0bd0-246421daf8cc@schaufler-ca.com>
Date:   Fri, 28 Oct 2022 08:01:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florent Revest <revest@chromium.org>,
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
 <edf0ec89c61fbee68fd537981982e14b1674393d.camel@huaweicloud.com>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <edf0ec89c61fbee68fd537981982e14b1674393d.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/28/2022 1:48 AM, Roberto Sassu wrote:
> On Thu, 2022-10-27 at 12:39 +0200, KP Singh wrote:
>> On Wed, Oct 26, 2022 at 7:14 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Wed, Oct 26, 2022 at 1:42 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
>>>>> On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <
>>>>> casey@schaufler-ca.com> wrote:
>>>>>> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
>>>>>>> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov
>>>>>>> wrote:
>>>>>>>> I'm looking at security_inode_init_security() and it is
>>>>>>>> indeed messy.
>>>>>>>> Per file system initxattrs callback that processes
>>>>>>>> kmalloc-ed
>>>>>>>> strings.
>>>>>>>> Yikes.
>>>>>>>>
>>>>>>>> In the short term we should denylist inode_init_security
>>>>>>>> hook to
>>>>>>>> disallow attaching bpf-lsm there. set/getxattr should be
>>>>>>>> done
>>>>>>>> through kfuncs instead of such kmalloc-a-string hack.
>>>>>>> Inode_init_security is an example. It could be that the
>>>>>>> other hooks are
>>>>>>> affected too. What happens if they get arbitrary positive
>>>>>>> values too?
>>>>>> TL;DR - Things will go cattywampus.
>>>>>>
>>>>>> The LSM infrastructure is an interface that has "grown
>>>>>> organically",
>>>>>> and isn't necessarily consistent in what it requires of the
>>>>>> security
>>>>>> module implementations. There are cases where it assumes that
>>>>>> the
>>>>>> security module hooks are well behaved, as you've discovered.
>>>>>> I have
>>>>>> no small amount of fear that someone is going to provide an
>>>>>> eBPF
>>>>>> program for security_secid_to_secctx(). There has been an
>>>>>> assumption,
>>>>>> oft stated, that all security modules are going to be
>>>>>> reviewed as
>>>>>> part of the upstream process. The review process ought to
>>>>>> catch hooks
>>>>>> that return unacceptable values. Alas, we've lost that with
>>>>>> BPF.
>>>>>>
>>>>>> It would take a(nother) major overhaul of the LSM
>>>>>> infrastructure to
>>>>>> make it safe against hooks that are not well behaved. From
>>>>>> what I have
>>>>>> seen so far it wouldn't be easy/convenient/performant to do
>>>>>> it in the
>>>>>> BPF security module either. I personally think that BPF needs
>>>>>> to
>>>>>> ensure that the eBPF implementations don't return
>>>>>> inappropriate values,
>>>>>> but I understand why that is problematic.
>>>>> That's an accurate statement. Thank you.
>>>>>
>>>>> Going back to the original question...
>>>>> We fix bugs when we discover them.
>>>>> Regardless of the subsystem they belong to.
>>>>> No finger pointing.
>>>> I'm concerned about the following situation:
>>>>
>>>> struct <something> *function()
>>>> {
>>>>
>>>>         ret = security_*();
>>>>         if (ret)
>>>>                 return ERR_PTR(ret);
>>>>
>>>> }
>>>>
>>>> int caller()
>>>> {
>>>>         ptr = function()
>>>>         if (IS_ERR(ptr)
>>>>                 goto out;
>>>>
>>>>         <use of invalid pointer>
>>>> }
>>>>
>>>> I quickly found an occurrence of this:
>>>>
>>>> static int lookup_one_common()
>>>> {
>>>>
>>>> [...]
>>>>
>>>>         return inode_permission();
>>>> }
>>>>
>>>> struct dentry *try_lookup_one_len()
>>>> {
>>>>
>>>> [...]
>>>>
>>>>          err = lookup_one_common(&init_user_ns, name, base, len,
>>>> &this);
>>>>          if (err)
>>>>                  return ERR_PTR(err);
>>>>
>>>>
>>>> Unfortunately, attaching to inode_permission causes the kernel
>>>> to crash immediately (it does not happen with negative return
>>>> values).
>>>>
>>>> So, I think the fix should be broader, and not limited to the
>>>> inode_init_security hook. Will try to see how it can be fixed.
>>> I see. Let's restrict bpf-lsm return values to IS_ERR_VALUE.
>>> Trivial verifier change.
>> Thanks, yes this indeed is an issue. We need to do a few things:
>>
>> 1. Restrict some hooks that we know the BPF LSM will never need.
>> 2. A verifier function that checks return values of LSM
>> hooks.
>> For most LSK hooks IS_ERR_VALUE is fine, however, there are some
>> hooks
>> like *xattr hooks that use a return value of 1 to indicate a
>> capability check is required which might need special handling.
> I looked at security.c:
>
> /*
>  * SELinux and Smack integrate the cap call,
>  * so assume that all LSMs supplying this call do so.
>  */
>
> Other than checking the return value, probably we should also wrap
> bpf_lsm_inode_{set,remove}xattr() to do the capability check, right?

Long term I hope to fix the way capabilities are dealt with in
this hook, but for now your suggestion seems reasonable. 

>
> Roberto
>
