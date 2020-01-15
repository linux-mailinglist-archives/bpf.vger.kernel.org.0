Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4923213C4E4
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAOOF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 09:05:59 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:44213 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgAOOF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 09:05:58 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 09:05:56 EST
X-EEMSG-check-017: 66275669|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="66275669"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 13:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579096709; x=1610632709;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QLClkBuRZv3qknPWa5cOYNHfW1CIQKXGZgBLhl3dFOw=;
  b=RleSTTdreivtUy5OyEVSC+hQLu5xr2deWpZeFp9x66yJ8zzngtk3MPtA
   kXINMWxI05Nj3IfigL3aunJBTFfneA0QrrFvXJdF661sUdy5myLemYcVF
   ujlDTQRwTn8NRCmqfTU3650DwfFWQVlbwjWbVWmtwflfA2Ma7R2QgOZ09
   U/exVW1CqXEp67EZwqO83x+coWyLYnp2m3mru0DEGZDIYUH5tyHpc09yS
   +hkJLmDiyZrTNDuWiMSyNtRjs+1dRzeK1IPOheSkFtsbsMheTKeMSmFNO
   7HC+SL8OF9rlxBEIwPUPFSz8VatllKndsxgX6Ni+y0ETTbfV58bc2iSqN
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="37802240"
IronPort-PHdr: =?us-ascii?q?9a23=3ALbayyxxrJHXV67TXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0eweLfad9pjvdHbS+e9qxAeQG9mCt7Qc0KGL7eigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5duJ6g+xh?=
 =?us-ascii?q?bJo3ZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwDIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/tWuaWJDd3nnNleLSniha98Eig1u38VtSv31?=
 =?us-ascii?q?pQsiVFldzMu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv03lKnZvpfaJd8FqaGlGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5KBG7w/38BdVh1oIRRWKPAq?=
 =?us-ascii?q?iDPKPUql+H/PgjI+aLZI8LoDr9MeQq5+byjX8lnl8QZbOm3Z8JZ3G3APtmIl?=
 =?us-ascii?q?+VYWHwgtgbC2cKuRQ+TOvriF2eVj5TeW2/X6055j4hCYKmCZ3PSZyqgLyExC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb4aEW+8XaCKTJM9hnTwEWKO9RI8hzxGuswr6y7t6Lu?=
 =?us-ascii?q?rR4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVTWF0m2QIRyUs3KB+ukxw0VGD3r?=
 =?us-ascii?q?J9g/NGFNxf/fRJUh01NZTE1ex1F8jyWh7dfteOUFumQcupDi8qTt0txN8OZE?=
 =?us-ascii?q?V9Fs6+gRDDxSqqBLoVl72WBJwx6K7c2GLxJ8llwXbcyKYhl0UmQtdINWC+mq?=
 =?us-ascii?q?Fw7RPTCJDJkkiCjKalaaQc0zTQ9GeNyWqBoltYXBdsXqrfR3wQekzWrdHh7E?=
 =?us-ascii?q?PYU7CuEagnMhdGycOaLqtKa9vpjUhJRfv6O9TRfXixm2GuChaM3b6McoXqdH?=
 =?us-ascii?q?sH3CnHC0gLjRoT/XCYOgg6HCuhpHjeDDN2H1L1f0zs6fV+qG+8TkIs1A6Kd0?=
 =?us-ascii?q?Nh2qGr+h4am/OcUekf3rEatyc7rTV7AlK908jRC9qaqAprZL9cbs8l4FdbyW?=
 =?us-ascii?q?LZsBRwPpihL6Bkm14ffB17v1jw2BprF4VAi8kqrG8qzQZrLKKY105Ody6c3Z?=
 =?us-ascii?q?/uIbDXNGby8w61a6LM2VHRzsyW+qER5/Q8sVnjuxupFkU6+XV9z9ZVy2ec5o?=
 =?us-ascii?q?nNDAcKS53xSVo3+gN5p77EeCk94Z3b1Xl2PamzqD/C1MojBPE5xRa4Y9dfLK?=
 =?us-ascii?q?SEGRfvHMIAAciuKfIlm1yyYxIFO+BS+7A7MNm8d/Sd366qM/xsnDS4gmRb+I?=
 =?us-ascii?q?p9yF6D9zJgSu7U2JYI2+2Y3guIVzjmllehtMH3lp5faD4OHmq/0y/kBItQZq?=
 =?us-ascii?q?1veIYHE2CuI9e4xt9mnZ7iR2ZY9EK/B1MBwMKpfBqSYEb53QJMz0QXpnKmlD?=
 =?us-ascii?q?C3zzxzlDEpoa6f0zLUz+v+cxoHP3ZBRHN+glf0PYi0k9caUVCwbwgriBuo/k?=
 =?us-ascii?q?n6x69cpKRwK2ncX11EcDTxL2FnSqGwrKaNY9ZT6JM0tiVaSP+zYUqERb77vh?=
 =?us-ascii?q?QVySXjE3FDyzwheDGqoIv2nxN1iG+GI3ZzqWDWecB0xRvF+NPcQvtR1CIcRC?=
 =?us-ascii?q?ZkkTnXGkS8P96x8NWWjZjDtOa+V2K6W51cdinryoyAtC+l6mFwHRK/mPWzkM?=
 =?us-ascii?q?X9EQcmyS/7y8VqVSLQoRb5YInr2KS3POZ8c0lnA1/87MV6GoVgnYcqmJ4Q3n?=
 =?us-ascii?q?0ajI2P/XUbiWfzLclb2aXmYXURRT4L2d/V4BP52E1iNH2JwZn0WW6HwsR7et?=
 =?us-ascii?q?m6ZH0Z2jgn48BLD6ee9KZEkjdtolqksQLRZuBwnjIcyfQy83MVnuAJuAUszi?=
 =?us-ascii?q?WeBbAdAFNUPSrymBSU99q+trlYZH6zcbis00pzhcqhA6+cog5CQ3b5ZowvEj?=
 =?us-ascii?q?Nw7sVlN1LM1Xzz6pzheNXKatITrBKUmQ/aj+dJMJIxiuYKhS1/NGL/p3Iq1+?=
 =?us-ascii?q?07jRl00pG8p4eKMHli/KKjAh5fMz31Zt4T+jT3gaZZhMaW0JilHo99FTUTQJ?=
 =?us-ascii?q?voUfWoHSoRtfv9OQaBCjw8p2yVGbXEBwOQ9EBmr3fXGZCxK36XPGUZzcllRB?=
 =?us-ascii?q?SFP0xfhwYUXDo+np44CwCl39bhf11n5jAQ4F74pQBByuxzOBXlTmjfowKoYC?=
 =?us-ascii?q?8uSJeDNBpW8h1C50DNPM2e7uJzBDpV/pO6owCXNmObYAFIB3kTWkOYH1DjIq?=
 =?us-ascii?q?Wu5d7Y/uiDGOW+NfTObquVpOxeTfiIwZav04tg/zqWKsqPOXxiBeUh2kVfRX?=
 =?us-ascii?q?B5B9jZmzIXRiwSiy3Nb9CUpBem9SJsqcy/6+7kWAf05YuSDbtSPs5i+xOojq?=
 =?us-ascii?q?eZMe6fmiJ5JSxf1pMWyn/C0KIf00IKiyFyazmtFqwNujPXQ6LOhKBXCgUWZD?=
 =?us-ascii?q?5pO8tW8a082w1NOcnVitPpzLJ4iOA6C0tdX1z7hs6pfdAKI326NF7fC0aLLq?=
 =?us-ascii?q?qJJTLIw8H3eq68TbxQjONJtxy/tzabFFLjPjKemDbzSxCvMOZMjCeBMBxZoo?=
 =?us-ascii?q?G9fQ5nCXL/Q9L+dh27LNh3gCUwwb01mnzKMmocPiJnc09XoL2f8zlYgu9hFG?=
 =?us-ascii?q?Fa63plLPWLmzye7+bEKpYWsONrDj5omOJd5XQw06FV4z1cRPxphCvSqcZjo0?=
 =?us-ascii?q?q7nemB0TdnXx1OqjFEhIKPo0puI7nW9p5FWXzc5hIC8X2QCwgWp9tiEtDvor?=
 =?us-ascii?q?1QxcbJlKLvKTdC9cjY/c4bB8jSLsKILmYhPAHvGDHKEAsFVzmrNWfYh0xYjv?=
 =?us-ascii?q?6e7GGarp8/qpL0gpoBVqdbVEApFvMdEkllBsENIJFtUT4/n76Ul9QE6ma5rB?=
 =?us-ascii?q?nUXM9apIzIVuqOAfXzLzaUlbtEZxwWzr7jI4UcLIv71FF4Zll8govKB1DcXd?=
 =?us-ascii?q?ZMoyd5dA87vF1N8GRiTm00w0/lchmi4GIXFfOvhh45kBZ+YeA0+Dfp5Fc3IU?=
 =?us-ascii?q?DKqzUqnEYtntXlhGPZTDmkBaO9TYxXQxHovlI2LJT6XwFrJVm7mUF0OTaCXK?=
 =?us-ascii?q?5Ylbx+cmF3jxH0tp5GGPoaRqpBNkw+3/aSMs403ExcpyPv/kpO4e/IGNM2jw?=
 =?us-ascii?q?cxWYK9pHJHnQR4ZZg6IrKGd/kB9URZmq/b5nzg7es22gJLYh9WoW4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DfBgDBGB9e/wHyM5BkHgELHIN4gRhUASASKoQPiQOGX?=
 =?us-ascii?q?AaBEiWJbo9igWcJAQEBAQEBAQEBLQoBAYRAAoIjOBMCEAEBAQQBAQEBAQUDA?=
 =?us-ascii?q?QFshTcMgjspAYJ5AQEBAQIBIw8BBUEQCxgCAiYCAlcGDQgBARWCQgw/AYJWB?=
 =?us-ascii?q?SAPpHl1gTKFSoNRgTgGgQ4ojDJ5gQeBEScMA4JdPoJLGQKBJySDKIJeBI0zU?=
 =?us-ascii?q?4ILh1+XVIJCgkmEdIVDiSoGG4JHjEeLYJc5lDQigVgrCAIYCCEPgyhPGA2ID?=
 =?us-ascii?q?ReDUIpxIwMwDY1TAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Jan 2020 13:58:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FDve9N056311;
        Wed, 15 Jan 2020 08:57:44 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
References: <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
 <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
 <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
 <49a45583-b4fb-6353-a8d4-6f49287b26eb@tycho.nsa.gov>
 <20200115024830.4ogd3mi5jy5hwr2v@ast-mbp.dhcp.thefacebook.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <38a82df5-7610-efe1-d6cd-76f6f68c6110@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 08:59:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115024830.4ogd3mi5jy5hwr2v@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/14/20 9:48 PM, Alexei Starovoitov wrote:
> On Tue, Jan 14, 2020 at 12:42:22PM -0500, Stephen Smalley wrote:
>> On 1/14/20 11:54 AM, Stephen Smalley wrote:
>>> On 1/10/20 12:53 PM, Alexei Starovoitov wrote:
>>>> On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
>>>>> On 09-Jan 14:47, Stephen Smalley wrote:
>>>>>> On 1/9/20 2:43 PM, KP Singh wrote:
>>>>>>> On 10-Jan 06:07, James Morris wrote:
>>>>>>>> On Thu, 9 Jan 2020, Stephen Smalley wrote:
>>>>>>>>
>>>>>>>>> On 1/9/20 1:11 PM, James Morris wrote:
>>>>>>>>>> On Wed, 8 Jan 2020, Stephen Smalley wrote:
>>>>>>>>>>
>>>>>>>>>>> The cover letter subject line and the
>>>>>>>>>>> Kconfig help text refer to it as a
>>>>>>>>>>> BPF-based "MAC and Audit policy".  It
>>>>>>>>>>> has an enforce config option that
>>>>>>>>>>> enables the bpf programs to deny access,
>>>>>>>>>>> providing access control. IIRC,
>>>>>>>>>>> in
>>>>>>>>>>> the earlier discussion threads, the BPF
>>>>>>>>>>> maintainers suggested that Smack
>>>>>>>>>>> and
>>>>>>>>>>> other LSMs could be entirely
>>>>>>>>>>> re-implemented via it in the future, and
>>>>>>>>>>> that
>>>>>>>>>>> such an implementation would be more optimal.
>>>>>>>>>>
>>>>>>>>>> In this case, the eBPF code is similar to a
>>>>>>>>>> kernel module, rather than a
>>>>>>>>>> loadable policy file.  It's a loadable
>>>>>>>>>> mechanism, rather than a policy, in
>>>>>>>>>> my view.
>>>>>>>>>
>>>>>>>>> I thought you frowned on dynamically loadable
>>>>>>>>> LSMs for both security and
>>>>>>>>> correctness reasons?
>>>>>>>
>>>>>>> Based on the feedback from the lists we've updated the design for v2.
>>>>>>>
>>>>>>> In v2, LSM hook callbacks are allocated dynamically using BPF
>>>>>>> trampolines, appended to a separate security_hook_heads and run
>>>>>>> only after the statically allocated hooks.
>>>>>>>
>>>>>>> The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
>>>>>>> still remains __lsm_ro_after_init and cannot be modified. We are still
>>>>>>> working on v2 (not ready for review yet) but the general idea can be
>>>>>>> seen here:
>>>>>>>
>>>>>>>       https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Evaluating the security impact of this is the next
>>>>>>>> step. My understanding
>>>>>>>> is that eBPF via BTF is constrained to read only access to hook
>>>>>>>> parameters, and that its behavior would be entirely restrictive.
>>>>>>>>
>>>>>>>> I'd like to understand the security impact more
>>>>>>>> fully, though.  Can the
>>>>>>>> eBPF code make arbitrary writes to the kernel, or
>>>>>>>> read anything other than
>>>>>>>> the correctly bounded LSM hook parameters?
>>>>>>>>
>>>>>>>
>>>>>>> As mentioned, the BPF verifier does not allow writes to BTF types.
>>>>>>>
>>>>>>>>> And a traditional security module would necessarily fall
>>>>>>>>> under GPL; is the eBPF code required to be
>>>>>>>>> likewise?  If not, KRSI is a
>>>>>>>>> gateway for proprietary LSMs...
>>>>>>>>
>>>>>>>> Right, we do not want this to be a GPL bypass.
>>>>>>>
>>>>>>> This is not intended to be a GPL bypass and the BPF verifier checks
>>>>>>> for license compatibility of the loaded program with GPL.
>>>>>>
>>>>>> IIUC, it checks that the program is GPL compatible if it
>>>>>> uses a function
>>>>>> marked GPL-only.  But what specifically is marked GPL-only
>>>>>> that is required
>>>>>> for eBPF programs using KRSI?
>>>>>
>>>>> Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
>>>>> specific verification for the v2 of the patch-set which would require
>>>>> all BPF-LSM programs to be GPL.
>>>>
>>>> I don't think it's a good idea to enforce license on the program.
>>>> The kernel doesn't do it for modules.
>>>> For years all of BPF tracing progs were GPL because they have to use
>>>> GPL-ed helpers to do anything meaningful.
>>>> So for KRSI just make sure that all helpers are GPL-ed as well.
>>>
>>> IIUC, the example eBPF code included in this patch series showed a
>>> program that used a GPL-only helper for the purpose of reporting event
>>> output to userspace. But it could have just as easily omitted the use of
>>> that helper and still implemented its own arbitrary access control model
>>> on the LSM hooks to which it attached.  It seems like the question is
>>> whether the kernel developers are ok with exposing the entire LSM hook
>>> interface and all the associated data structures to non-GPLd code,
>>> irrespective of what helpers it may or may not use.
>>
>> Also, to be clear, while kernel modules aren't necessarily GPL, prior to
>> this patch series, all Linux security modules were necessarily GPLd in order
>> to use the LSM interface.
> 
> Because they use securityfs_create_file() GPL-ed api, right?
> but not because module license is enforced.

No, securityfs was a later addition and is not required by all LSMs 
either.  Originally LSMs had to register their hooks via 
register_security(), which was intentionally EXPORT_SYMBOL_GPL() to 
avoid exposing the LSM interface to non-GPLd modules because there were 
significant concerns with doing so when LSM was first merged.  Then in 
20510f2f4e2dabb0ff6c13901807627ec9452f98 ("security: Convert LSM into a 
static interface"), the ability for loadable modules to use 
register_security() at all was removed, limiting its use to built-in 
modules.  In commit b1d9e6b0646d0e5ee5d9050bd236b6c65d66faef ("LSM: 
Switch to lists of hooks"), register_security() was replaced by 
security_add_hooks(), but this was likewise not exported for use by 
modules and could only be used by built-in code.  The bpf LSM is 
providing a shim that allows eBPF code to attach to these hooks that 
would otherwise not be exposed to non-GPLd code, so if the bpf LSM does 
not require the eBPF programs to also be GPLd, then that is a change 
from current practice.

>> So allowing non-GPL eBPF-based LSMs would be a
>> change.
> 
> I don't see it this way. seccomp progs technically unlicensed. Yet they can
> disallow any syscall. Primitive KRSI progs like
> int bpf-prog(void*) { return REJECT; }
> would be able to do selectively disable a syscall with an overhead acceptable
> in production systems (unlike seccomp). I want this use case to be available to
> people. It's a bait, because to do real progs people would need to GPL them.
> Key helpers bpf_perf_event_output, bpf_ktime_get_ns, bpf_trace_printk are all
> GPL-ed. It may look that most networking helpers are not-GPL, but real life is
> different. To debug programs bpf_trace_printk() is necessary. To have
> communication with user space bpf_perf_event_output() is necssary. To measure
> anything or implement timestamps bpf_ktime_get_ns() is necessary. So today all
> meaninful bpf programs are GPL. Those that are not GPL probably exist, but
> they're toy programs. Hence I have zero concerns about GPL bypass coming from
> tracing, networking, and, in the future, KRSI progs too.

You have more confidence than I do about that.  I would anticipate 
developers of out-of-tree LSMs latching onto this bpf LSM and using it 
to avoid GPL.  I don't see that any of those helpers are truly needed to 
implement an access control model.
