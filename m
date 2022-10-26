Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8560DD75
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiJZIoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiJZIoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 04:44:22 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16CD7E1D;
        Wed, 26 Oct 2022 01:42:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4My2Fz396Gz9v7HC;
        Wed, 26 Oct 2022 16:36:07 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP2 (Coremail) with SMTP id GxC2BwC37Pje8lhjkXoSAA--.11282S2;
        Wed, 26 Oct 2022 09:42:15 +0100 (CET)
Message-ID: <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com>
Date:   Wed, 26 Oct 2022 10:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
 <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
 <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwC37Pje8lhjkXoSAA--.11282S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury7WryrXr1kWry8CFy7GFg_yoW5WrW8pF
        W5KF4UKFs8JF97u3s2qa1rWFWIy395Kr47Ja98JwnrZrn8Ar1ayr1fJFWY9ay7Cw4xCw1F
        v3y2v3sxu3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj4SrugAAsw
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
> On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
>>> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
>>>> I'm looking at security_inode_init_security() and it is indeed messy.
>>>> Per file system initxattrs callback that processes kmalloc-ed
>>>> strings.
>>>> Yikes.
>>>>
>>>> In the short term we should denylist inode_init_security hook to
>>>> disallow attaching bpf-lsm there. set/getxattr should be done
>>>> through kfuncs instead of such kmalloc-a-string hack.
>>> Inode_init_security is an example. It could be that the other hooks are
>>> affected too. What happens if they get arbitrary positive values too?
>>
>> TL;DR - Things will go cattywampus.
>>
>> The LSM infrastructure is an interface that has "grown organically",
>> and isn't necessarily consistent in what it requires of the security
>> module implementations. There are cases where it assumes that the
>> security module hooks are well behaved, as you've discovered. I have
>> no small amount of fear that someone is going to provide an eBPF
>> program for security_secid_to_secctx(). There has been an assumption,
>> oft stated, that all security modules are going to be reviewed as
>> part of the upstream process. The review process ought to catch hooks
>> that return unacceptable values. Alas, we've lost that with BPF.
>>
>> It would take a(nother) major overhaul of the LSM infrastructure to
>> make it safe against hooks that are not well behaved. From what I have
>> seen so far it wouldn't be easy/convenient/performant to do it in the
>> BPF security module either. I personally think that BPF needs to
>> ensure that the eBPF implementations don't return inappropriate values,
>> but I understand why that is problematic.
> 
> That's an accurate statement. Thank you.
> 
> Going back to the original question...
> We fix bugs when we discover them.
> Regardless of the subsystem they belong to.
> No finger pointing.

I'm concerned about the following situation:

struct <something> *function()
{

	ret = security_*();
	if (ret)
		return ERR_PTR(ret);

}

int caller()
{
	ptr = function()
	if (IS_ERR(ptr)
		goto out;

	<use of invalid pointer>
}

I quickly found an occurrence of this:

static int lookup_one_common()
{

[...]

	return inode_permission();
}

struct dentry *try_lookup_one_len()
{

[...]

         err = lookup_one_common(&init_user_ns, name, base, len, &this);
         if (err)
                 return ERR_PTR(err);


Unfortunately, attaching to inode_permission causes the kernel
to crash immediately (it does not happen with negative return
values).

So, I think the fix should be broader, and not limited to the
inode_init_security hook. Will try to see how it can be fixed.

Roberto

