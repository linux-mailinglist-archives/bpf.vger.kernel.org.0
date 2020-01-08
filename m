Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE76134619
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 16:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAHPZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 10:25:31 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:16902 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 10:25:30 -0500
X-EEMSG-check-017: 69334067|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="69334067"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 15:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578497129; x=1610033129;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iuziM71b5Z+Ir6dUJLOdPDPmtz0juqUytHAPSIJ1Z7s=;
  b=KEdchQ0rhzLkgwE4SKM7uPFGg6FWfIxFhvT3hxKaxv4dXdpxJWGkUzq9
   xHfH2DkbSj4Ow8HG5mbdrUQX6enaSrDfqKJ+Cy+IQG1kAumZ4HB6F8dCo
   XjNA3igwEdXmo091NdvR145mLaETFU965B1lt1sdvxrrlu+085/Xz4U2m
   rLQHRIZo2yvOv6Z2Q2Pl7rOwAKuiGh0dP5JiHaina08jU60j7c30G0h4x
   AY2sheD6gBuyZu31aJHhArrrVi7JF96zgKEwJf3z3fRP1RsR+gN8JQP3J
   dKOZZuEkSlchYgd0cQiw1ygX5N/4lu8Waytz9WNdJgulD29vRzS7TIO6/
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31720437"
IronPort-PHdr: =?us-ascii?q?9a23=3AVFPVnBG/NgnkwfF5NiczMZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ75oc2zbnLW6fgltlLVR4KTs6sC17ON9fq9CSdfut6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8kVjIdtKKs8xA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRegCwSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSy5Qo2QTfa/qZfIiM+B7jU/yRIThgiH15ebK/gxey8VWlyuHmV8m011?=
 =?us-ascii?q?BHpTdGnNnUrn0ByhPe58edRvZ940utwyiD2g/N5u1ePEw5k7fQJYQ7zb4qjJ?=
 =?us-ascii?q?UTtFzOHirxmErrkqCbbl4k+u206+T/ZbXmu4OcO5d0ig7gNqQundSyAfgiPQ?=
 =?us-ascii?q?gUXmib5P+82Kfi/U3/TrVKieY2nbfFv5zAOcQaprK2Aw9S0oo57RawEyym38?=
 =?us-ascii?q?gCkXkCLVJFfAqLj4nvO17QPPD1FeqzjlujnTtxx/3KI6ftDovCI3TdirvtYK?=
 =?us-ascii?q?5x60tGxwoyydBf6YhUCrYEIP/rQU/+qcfYAwQlMw203+nnCNJ92pkYWWKUGK?=
 =?us-ascii?q?CVKqzSsViW5u43OemDeJcVuCrhK/gi//PujmE2lkEGfaa12psXb3O4E+96LE?=
 =?us-ascii?q?WZe3rshdIBEWYXvgo7VuDqj0eCUTFLbXaoQ608/i07CJ6hDYrbRYCtmKeB3C?=
 =?us-ascii?q?a9Hp1ZZmBLEUyDEXfyd4WDXvcMaT+SIsp7njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUEup35z9h6+e3SmAop9TNoD8SSyXyNT29wnmwWXT86xbxwrlZnxlif1q?=
 =?us-ascii?q?h4huRSFcZP6PNRTgc6KZncwvR+C9DzXALBY9iIRE+lQtq4GzExSMw+w9sVbk?=
 =?us-ascii?q?ZjFNWtkArD0zCpA7ALjbyLAoI78qbG03j2PcZ9xG7M1LM9gFk+XstPKWqmi7?=
 =?us-ascii?q?Zk+AjLCY7EiFuZl6m0eqQGxiLN93mMzXCIvE5GVA58S6LFXWoQZkHOt9T2+l?=
 =?us-ascii?q?vCT6OyCbQgKgZBzc+CKq1XatzmlFlGX+nsN8jDY2KrmmewGRaJyqqJbIrtZm?=
 =?us-ascii?q?odwSHdB1YfngAN8naJKxI+Cj2io23AFjxuE0zgY0f2/el5snO7QVc+zxuWYE?=
 =?us-ascii?q?15y7q15hkViOSGRPMIwrIJoyQhpCtuHFa7wd3WD8CMpw17fKVTedk9+ktI1X?=
 =?us-ascii?q?rFtwxhOZytN71tiUQYcwR2oUzu0w56CoRHkcglsnwl1hByJrmf0FJObT+Y24?=
 =?us-ascii?q?7/OqHPIGno4B+vc7LW2k3Z0NuO+KcP7fM4q0/5vAGoDUov6HNn3MNQ03SC55?=
 =?us-ascii?q?XGFg0SUYj+Ukwv7Rh1u6naYjUh54PTzXBsLam0sjDY1NIzAuslywivcsxDP6?=
 =?us-ascii?q?OEDg/yFMgaB8mzKOwvgVSpaQgEPO9K/q4uI8ymb+eG2LKsPOt4mTKmjX5I4I?=
 =?us-ascii?q?Rh3UKW8Cp9RPXF35kCw/Gf0QuHUynzgE29vcDwnIBOfSsSEXanySj4GI5RYb?=
 =?us-ascii?q?V/fZ4JCWeyOMC3ydJ+h5niW35c6lGvHU8J2MiseRCKdVzywRVQ1VgLoXyggS?=
 =?us-ascii?q?a31CZ0nC8vrqWCxiPOxf7uewcdNm5EXmltk1jsIYevgtAVWUindQkplB+/6U?=
 =?us-ascii?q?nmwKhbobx1L3PPTkdQYyj2M2ZiX7OytrWYZc5P7pMovD5YUOS7ZlCaRbr9rA?=
 =?us-ascii?q?UA3yz/GGtewSgxdyu2tZXhgxx6lGWdIW52rHrbdsF9xRPS6cfTRf5W2ToGSy?=
 =?us-ascii?q?14hifNClegONmp+M2el43fveCmS2KhSppTfDH3woOAriu75HZqAQG+n/+pnN?=
 =?us-ascii?q?3qChM10TXh2Nl3UyXHsgz8bpPq16S9KehnZFVnBEfg68pmHYFzio4whJAM1n?=
 =?us-ascii?q?UBm5qV/HUHkWbwMdVcxK3ydnwNSiAXw9TN+gjqxFVjLm6Vx4L+Tnid2NVuZ8?=
 =?us-ascii?q?ekbWMNxiIw9NxFCKeO7LxDmCt1o0e4rQfLbfh6hDcdxuMk6GQGjOERpAot0i?=
 =?us-ascii?q?KdD6gQHUZCISPslBGI4Mq4rKpMf2ugbbiw1FB5ndCkDbGCvwRcVGz+epc4Ei?=
 =?us-ascii?q?969t9/P07U0H3v9oHkf8HdbdEJuR2aiRjAjvNYKJwqmfYQmSVnPmf9t2U/y+?=
 =?us-ascii?q?EnlRxuwY26vI+fJmV2+6K5BBFYNjn0Z8MO4T7tl7xRntiX34CpEZVsATsLU4?=
 =?us-ascii?q?DyQf20FzISsOztNxySHz0ktnebBb3fEBef6UdmtHLCCJ6rOGqNKHYFytViQQ?=
 =?us-ascii?q?GXJFZDjwAMQDU6gpk5GxixxMP/akd56S4e60X4qhRWzuJoMxn+UmHFqAi0bT?=
 =?us-ascii?q?c0TYCVLABK4QFa+0fVLcue4/p2Hy5E/p2usgyNJXaAaAhPFmEGQEmEB0v+Pr?=
 =?us-ascii?q?mo6tnN6OuYCfSkL/vIf7qOrfZSV/CSxZKgyoFm5SqDNt2TPnl+CP02wldMUm?=
 =?us-ascii?q?pnG8vHnjUCUDEYmDjTb8GFoRe8/ip3rs6j8PjxXgLg+5ePAaNIMdpz4xC2nb?=
 =?us-ascii?q?uDN+mIiSZ2MzZXyJwMxXzIyLUE2F4SiidudySiELQOsi7NUaTQlbJNAB4Hai?=
 =?us-ascii?q?NzM81I47g73glXNs7Rksn12aJgjv4pF1dFUkTsmseoZcMWJGG9MEnIBF2ROL?=
 =?us-ascii?q?SIOzLL2dv3br2nRL1VjeVbqwewuTGHHE/jPzSDjyPlWAyoMeFJlCubJgBRuJ?=
 =?us-ascii?q?mhchZxDmjuVMnmZQC1MNJsgj02xro0hnzONWECKzRzb0RNrriI5yNCnvp/A3?=
 =?us-ascii?q?BB7mZiLeScgiaZ8vfXKpAKsftqBCR4jeda4HM8y7tT8i5EWOd4mC3Mod5yuV?=
 =?us-ascii?q?Gmle+Pyj1iUBVQsDpEmIWLvUB6M6XD6pZAQWrE/A4K7WiIERQFut1lBcf0tq?=
 =?us-ascii?q?Be0dfDjr78KDBH89jM58sTG9DUKN6bMHomKRfpGjnUAxUeQD+lL27fgVFSnO?=
 =?us-ascii?q?uU9nKLspg2sJ7smZsWQL9BSFM1Du8aClhiHNEaOJd4RC4kkbqAgc4Q/3W+sR?=
 =?us-ascii?q?3RSNxfvpDAUfKSG+vgJCyFgrlDYhtbiY//eKceO5az8EtlaREun4nHAEHXWt?=
 =?us-ascii?q?NlqS17aQo1vUAL92JxGCl7+HqtUQKr739bQf2shR8whQtWauQ38zLt/lJxIU?=
 =?us-ascii?q?DF8ngeik40zO75jCiRfTi5F6K5WYVbGmKgrEQqGo/qSAZyKwuplAprMymSFO?=
 =?us-ascii?q?EZtKdpaW0+0FyUgpBIA/MJCPQeOxI=3D?=
X-IPAS-Result: =?us-ascii?q?A2AdBAB48xVe/wHyM5AaAUscAQEBAQEHAQERAQQEAQGBf?=
 =?us-ascii?q?AKBe4EYVSASKoQJiQOGaAEBAQEBAQaBEiWBAYhtkHEDVAkBAQEBAQEBAQErD?=
 =?us-ascii?q?AEBhEACgg44EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnkBAQEBAx0GFUEQC?=
 =?us-ascii?q?xUDAgImAgJXBgEMBgIBARCCTz8BglIlD41/nGh1gTKEOgETQUCDOoE3BoEOK?=
 =?us-ascii?q?AGMMnmBB4ERJwwDgig1PoJLGQGCEIJkgl4EjV+CKocVRpZOdYJAgkWEcY5mB?=
 =?us-ascii?q?huaYo5ViFeOOoVoIjeBISsIAhgIIQ+CcwEzEz0YDY45AQiFJ4IwhV0jAzABA?=
 =?us-ascii?q?ZB5AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 15:25:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008FOfpc001064;
        Wed, 8 Jan 2020 10:24:42 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
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
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 10:25:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <201912301112.A1A63A4@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/30/19 2:15 PM, Kees Cook wrote:
> On Fri, Dec 20, 2019 at 06:38:45PM +0100, KP Singh wrote:
>> Hi Casey,
>>
>> Thanks for taking a look!
>>
>> On Fri, Dec 20, 2019 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>> On 12/20/2019 7:41 AM, KP Singh wrote:
>>>> From: KP Singh <kpsingh@google.com>
>>>>
>>>> This patch series is a continuation of the KRSI RFC
>>>> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
>>>>
>>>> # Motivation
>>>>
>>>> Google does rich analysis of runtime security data collected from
>>>> internal Linux deployments (corporate devices and servers) to detect and
>>>> thwart threats in real-time. Currently, this is done in custom kernel
>>>> modules but we would like to replace this with something that's upstream
>>>> and useful to others.
>>>>
>>>> The current kernel infrastructure for providing telemetry (Audit, Perf
>>>> etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
>>>> information provided by audit requires kernel changes to audit, its
>>>> policy language and user-space components. Furthermore, building a MAC
>>>> policy based on the newly added telemetry data requires changes to
>>>> various LSMs and their respective policy languages.
>>>>
>>>> This patchset proposes a new stackable and privileged LSM which allows
>>>> the LSM hooks to be implemented using eBPF. This facilitates a unified
>>>> and dynamic (not requiring re-compilation of the kernel) audit and MAC
>>>> policy.
>>>>
>>>> # Why an LSM?
>>>>
>>>> Linux Security Modules target security behaviours rather than the
>>>> kernel's API. For example, it's easy to miss out a newly added system
>>>> call for executing processes (eg. execve, execveat etc.) but the LSM
>>>> framework ensures that all process executions trigger the relevant hooks
>>>> irrespective of how the process was executed.
>>>>
>>>> Allowing users to implement LSM hooks at runtime also benefits the LSM
>>>> eco-system by enabling a quick feedback loop from the security community
>>>> about the kind of behaviours that the LSM Framework should be targeting.
>>>>
>>>> # How does it work?
>>>>
>>>> The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
>>>> program type, BPF_PROG_TYPE_LSM, which can only be attached to a LSM
>>>> hook.  All LSM hooks are exposed as files in securityfs. Attachment
>>>> requires CAP_SYS_ADMIN for loading eBPF programs and CAP_MAC_ADMIN for
>>>> modifying MAC policies.
>>>>
>>>> The eBPF programs are passed the same arguments as the LSM hooks and
>>>> executed in the body of the hook.
>>>
>>> This effectively exposes the LSM hooks as external APIs.
>>> It would mean that we can't change or delete them. That
>>> would be bad.
>>
>> Perhaps this should have been clearer, we *do not* want to make LSM hooks
>> a stable API and expect the eBPF programs to adapt when such changes occur.
>>
>> Based on our comparison with the previous approach, this still ends up
>> being a better trade-off (w.r.t. maintenance) when compared to adding
>> specific helpers or verifier logic for  each new hook or field that
>> needs to be exposed.
> 
> Given the discussion around tracing and stable ABI at the last kernel
> summit, Linus's mandate is mainly around "every day users" and not
> around these system-builder-sensitive cases where everyone has a strong
> expectation to rebuild their policy when the kernel changes. i.e. it's
> not "powertop", which was Linus's example of "and then everyone running
> Fedora breaks".
> 
> So, while I know we've tried in the past to follow the letter of the
> law, it seems Linus really expects this only to be followed when it will
> have "real world" impact on unsuspecting end users.
> 
> Obviously James Morris has the final say here, but as I understand it,
> it is fine to expose these here for the same reasons it's fine to expose
> the (ever changing) tracepoints and BPF hooks.

This appears to impose a very different standard to this eBPF-based LSM 
than has been applied to the existing LSMs, e.g. we are required to 
preserve SELinux policy compatibility all the way back to Linux 2.6.0 
such that new kernel with old policy does not break userspace.  If that 
standard isn't being applied to the eBPF-based LSM, it seems to inhibit 
its use in major Linux distros, since otherwise users will in fact start 
experiencing breakage on the first such incompatible change.  Not 
arguing for or against, just trying to make sure I understand correctly...



