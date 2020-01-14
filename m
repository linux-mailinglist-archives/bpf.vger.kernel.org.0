Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6961113B103
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgANReA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 12:34:00 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:44820 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 12:33:59 -0500
X-EEMSG-check-017: 69474453|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,319,1574121600"; 
   d="scan'208";a="69474453"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 16:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579020850; x=1610556850;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XVbXHRWLO+g2+YgyDFmamqRig5D2mLxtRJUy4lLEic4=;
  b=YzltanvcPa72ilnJYxITvxsEgTm5wDwRyeaSWnUTggi9JV2/0x4FZq9j
   v+yH+aUjHcwEXPGGqp2ClAJrcZYy3E0v77yDMgoPyb9KEXyXW2dQO76b1
   9/ZGUsuwvnfXX9EbxTkp/xAx2ma/Eh0/hFDklWy4KoeID5YmAKcR0Ohek
   OA0a4uTmUEYsBionbluX4OO2I8+4CTJlaFLZxG7WeBUgc97rkJvwKGQ0o
   u7y5eoDR8ezsRLzCNbglNGL4VwHVi23Tm1FMfxFGmE6pKvuInHdOy/RUI
   dCYXtz9TAnl1gvO+1Tx0aFcRkZYaDC2uLyPpY90wpj74++FWt6VapLW/U
   w==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="31934995"
IronPort-PHdr: =?us-ascii?q?9a23=3AOT5pmRPlAuGE5JVbGckl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0KPv6psbcNUDSrc9gkEXOFd2Cra4d16yO6uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5duJrsswR?=
 =?us-ascii?q?fNvndEZv5ayGx1KV+dhRrw+tu88Jt++ClMpvwt8NJNX7/ndKoiV7xYCzomM2?=
 =?us-ascii?q?Ex5ML1sBTIUBWC6HgBXGgIixREGwfK4g30UZf3qSv6q/Fy2DKGMs3sTLA7Qi?=
 =?us-ascii?q?qt4qF2QxL1kigHNjo58GbKisxsia9QvRysqwBjz4PSfYqYL+R1cL/DctwGRG?=
 =?us-ascii?q?pBRsdRWDJHAoOgdIsEEu4NMf9Fo4Xhu1cCqB2zCge2BOPr1zRGmHn406Mn2O?=
 =?us-ascii?q?glCA3L0ggtE9cIvX/Jrtv6Kb0SXPiowqfWwzXNb/BY1znz54fHcB8uvf6CUK?=
 =?us-ascii?q?lsccfT00QjCx/Jg1uSpIHjIjib1v4Ns2+e7+d4SOyvl3AoqxlxojexwMcnl5?=
 =?us-ascii?q?THhocPxVDA8SV23oY0LsC/RU5gfNGkC4Bdtz2aNoRqQsMiRHtkuCAhyrIco5?=
 =?us-ascii?q?K7cy8KyIo+yhPZdveJfY+I4hf5W+aQJzd1nH1leLOjhxay7Eiv0ffwWdWz0F?=
 =?us-ascii?q?ZPqCdOj9rCtmgV2hDO5cWKReFx80e81TqVyQze5f9ILVopmafdNpUv2KQ/lo?=
 =?us-ascii?q?AJvkTGBiL2nUL2g7KIeUg84eio7vjnYq3hpp+BK494kgH+Pboqmsy4Gek4Lh?=
 =?us-ascii?q?IBX3Ka+eShz73v50z5QLNEjv0xianWrozVKd4Hpq+5HwBV0oEj5wy5Dzi6y9?=
 =?us-ascii?q?QXgWMLLFdEeBKDl4TpOlfOL+7kDfqnnlihnzhmy+rGM7H8GJnBMHfOnKn7cb?=
 =?us-ascii?q?pg80JczRA8zdFb55JaELEBJ/fzV1fqtNPFFR80KBC0wub7B9V90YMSQ2SPAr?=
 =?us-ascii?q?SDP6/Ivl+I4fwvL/GWZIAJoDb9N+Ql5/n2gHAjnV8SY6ao0oUWaHyiBfRmP1?=
 =?us-ascii?q?+WYWDrgtcfFmcKvxY+TOv0iFCZXj5TYmy9X6M45j0hFI2mCoLDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CPCXfobISEW/EDaCKSOcJujjwEVaKmS48k1BGuqQr6x6BgLu?=
 =?us-ascii?q?rO9S0SrYjj28Rt5+3PiREy8iR5D8aY02GKVWF0hGIIRyQt0aB5u0N9z0mM0a?=
 =?us-ascii?q?lij/xfD9xT6OtDUh0mOp7E0+x6F9fyVxrCftiXVlmmWcmpATY2TtIy2NIBf0?=
 =?us-ascii?q?Z9G8+ljhDG3iqqHroVm6aMBJwu/aLWx2LxKNply3bayKkhiEErTddVOm29mK?=
 =?us-ascii?q?F+9xPeB5XVnEWZjamqaKoc3CrT+2eZ1GaBoFtXXBRsXqXCWHAVflHWosjh5k?=
 =?us-ascii?q?PeU7+uDqwqMg9Ayc6EN6tLZcTljVZYS/f5PtTRfWaxlnyuBRaH2LyMdpDme2?=
 =?us-ascii?q?YD0yXHDkgLjQQT8WyBNQgkCSeru3jeAyB2FVLzf0Ps9vFzp2ijTk861AyKcU?=
 =?us-ascii?q?Jh2KSv+hIPhvyTVekT3rQatyclsTl0G0y9393OAdqauwVhZLlcYc864Fpf0W?=
 =?us-ascii?q?LZtgp9PoGvLqx7nV4RbRh4v1701xV2FoVBkdEmrHYtzAVvNKKY1E1OeiiG3Z?=
 =?us-ascii?q?D/JLLXMHP+/BOxZK7M3FHRztKW9r0I6PQipFXppBupGVY683V7z9lV1GOR6Y?=
 =?us-ascii?q?/RDAoOSp/xUVg49wJ8p77EZikx/YTU1WdjMaOsqD/Nx8opBPc5yhanZ9pQLb?=
 =?us-ascii?q?mLFAnzE8IEA8ijM+0qm1+mbh0aJu9S7rU7P8Spdvec3q6kIvpgliq8jWtb+I?=
 =?us-ascii?q?B9zl6M9y1kR+7U35YFzOuX3hGBVzf9klisqdz4mYBeZTEVG2q/yDXkBItLaq?=
 =?us-ascii?q?11Z4YLBn+kI9erydVmm57tR3lY+UamB1MGwsCpfQadb0b63QxezkkXrnunmS?=
 =?us-ascii?q?y3zzxwjT4ltLaQ3CvLw+76bhoIJnZLRHV+jVfrOYW0l9IaXFSzYggmkxul4k?=
 =?us-ascii?q?n6x6xFq6hlM2bTRkJIdTDsL25+SquwqqaCY8lX5ZwzqyVYTuK8bk2ARb77uR?=
 =?us-ascii?q?cVzjnvH2RExD8leDGqtY70nxN/iG2HLXZzqGDVdt13xRfa/NbcX+Je3iIaRC?=
 =?us-ascii?q?lkjjnaHlq8MMOv/dWSl5fOqe++V2WmVp1cdSnk05mMuze85W1vGRe/hey8ms?=
 =?us-ascii?q?X7EQgm1i/2z9xqVSfHrBv8ZoTmzKu6MeVgfklnAF/z9dB2FZ15kos1nJsQw2?=
 =?us-ascii?q?QVho2J/Xoblmf+KclU2aLkbHoMXj4L39/V7xLj2EB4NX2J3Zj2VmibwsR/fd?=
 =?us-ascii?q?m2eGIW2iUl5cBQFKiU9KBEnTdyolegqALRYORykywAxvsv534aguIJuA0wwS?=
 =?us-ascii?q?mHBLAdA1VYNzT2lxuU99C+sLlXZGG3fLiqykV+g86uDKqeogxHRHn5eo0iHS?=
 =?us-ascii?q?h17sV+LVLM1Wf/6ob+eNnfddgTrAGbkw/cj+hJL5I8jvgKijB7NmL+uH0q0e?=
 =?us-ascii?q?g7ggd10J6mvIiHMWJt/Ke4Ah5FMz35fcQT+ivijaxGhMaZw5ivHol9GjUMRJ?=
 =?us-ascii?q?boTuinEDwIuvTmLAuOHiYzpm2HFrrYGA+V8F1moG7XE5C3K3GXI2EUzc5lRB?=
 =?us-ascii?q?mbK0xfhAEUXCghkZ4jDA+q2s3hcEF25j0K6F73sQFAxf5vNxn6Sm3fvhunai?=
 =?us-ascii?q?8oSJiDKxpb9gFD50fOMcGF4OJ8BDtU8YGmrAyIMmabfRhHDXkVWkyYAFDuJq?=
 =?us-ascii?q?Ku6sfa8+iXGOWzNPvObq+KqexaV/aIw4ij3Zdh/zaJLs+PJGVtD+Un2kpfWn?=
 =?us-ascii?q?B0A8HZlCkPSyMJlyLCddWUqBCn+iJtq8C/6+nrWATg5YaUCLtdL89v+xaojq?=
 =?us-ascii?q?eHLeKQgzx5KTlA3JMW2XDI0KQf3EIViyx2ajaiC6oAujDITK/Lh6BYFQAbZD?=
 =?us-ascii?q?12NMtM6KI80BVNNdTditzryr5yluQ1BEtdVVz9hsGpYtQHI26nNFzZC0aLN7?=
 =?us-ascii?q?SGKCbPw8H2Z6O8VLJRjOtTtx2tvzaUDlXsPiiClznuURCjK+ZMjDuUPBZGoo?=
 =?us-ascii?q?Gybg5tCXT/TNLhchC7Nt53giExwb0wnHzKLnQQMTZifENXtL2f8zhVgvB+G2?=
 =?us-ascii?q?Nd9HplKvWLmyaY7+nAMJoZrfxrAiFsneJA/Hs606dV7D1DRPFtgyvds9Burk?=
 =?us-ascii?q?qpkumIzTpnXx5OpShRiI2XukViPL3T9oNcVnbc4BIN8WKQBgwTp9t4FNLvvb?=
 =?us-ascii?q?xQytnJlK7pLTdC9NTU/c0CCMjIM8+HNmQuMQbzGD7TCgsFSjurOn/Fi0NBl/?=
 =?us-ascii?q?GS82WfroImpZj0hJoOVrhbWUQvFvwHDERqBscPIJlsUT8+jbGbi8sI72KkrB?=
 =?us-ascii?q?bNXMVaoozHVvWKDPXtLzaWk6JJZhUSzrP+MIsfLIv71FJ+alVgmoTLGlLaXc?=
 =?us-ascii?q?pRrS15cg80vEJN/WBmTmIpxkLlbhig4GcJGv6pmh46kw5+YeMq9Df2/Vg7PE?=
 =?us-ascii?q?bFpCw1kBp5pdKwqDScYDPwZJysVJtRFS31q08vesfyRwtlYAz0hlBtLjDaQL?=
 =?us-ascii?q?NNiKVIemViiQuaspxKT7oUbpUMWx4WyvHfM/YwylVapSWPzk9d4u7EFJ4kkx?=
 =?us-ascii?q?ElJ82CtXVFjjl/YcY1KKqYH69Aylxdl+rapSOz/vwgyw8ZYUAW+SWdfzBe6x?=
 =?us-ascii?q?9ADaUvOyf9pr8k0geFgTYWPTFXBvc=3D?=
X-IPAS-Result: =?us-ascii?q?A2ByAwBF8R1e/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEDYkDhmwGgTeJbpFJCQEBAQEBAQEBAS0KAQGEQAKCIjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KQGCegEFIxVBEAsYAgImAgJXBgEMCAEBglcMP?=
 =?us-ascii?q?wGCViUPrDqBMoVJg1SBNwaBDiiMMnmBB4ERJw+CXT6CSxkChHOCXgSQD4cXR?=
 =?us-ascii?q?pdSgkKCSYRzjmsGG4JHjEaLYI5biFyULCKBWCsIAhgIIQ+DKE8YDYt0inEjA?=
 =?us-ascii?q?zAMjRkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Jan 2020 16:54:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EGrGGX246103;
        Tue, 14 Jan 2020 11:53:18 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
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
References: <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
 <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 11:54:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/10/20 12:53 PM, Alexei Starovoitov wrote:
> On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
>> On 09-Jan 14:47, Stephen Smalley wrote:
>>> On 1/9/20 2:43 PM, KP Singh wrote:
>>>> On 10-Jan 06:07, James Morris wrote:
>>>>> On Thu, 9 Jan 2020, Stephen Smalley wrote:
>>>>>
>>>>>> On 1/9/20 1:11 PM, James Morris wrote:
>>>>>>> On Wed, 8 Jan 2020, Stephen Smalley wrote:
>>>>>>>
>>>>>>>> The cover letter subject line and the Kconfig help text refer to it as a
>>>>>>>> BPF-based "MAC and Audit policy".  It has an enforce config option that
>>>>>>>> enables the bpf programs to deny access, providing access control. IIRC,
>>>>>>>> in
>>>>>>>> the earlier discussion threads, the BPF maintainers suggested that Smack
>>>>>>>> and
>>>>>>>> other LSMs could be entirely re-implemented via it in the future, and that
>>>>>>>> such an implementation would be more optimal.
>>>>>>>
>>>>>>> In this case, the eBPF code is similar to a kernel module, rather than a
>>>>>>> loadable policy file.  It's a loadable mechanism, rather than a policy, in
>>>>>>> my view.
>>>>>>
>>>>>> I thought you frowned on dynamically loadable LSMs for both security and
>>>>>> correctness reasons?
>>>>
>>>> Based on the feedback from the lists we've updated the design for v2.
>>>>
>>>> In v2, LSM hook callbacks are allocated dynamically using BPF
>>>> trampolines, appended to a separate security_hook_heads and run
>>>> only after the statically allocated hooks.
>>>>
>>>> The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
>>>> still remains __lsm_ro_after_init and cannot be modified. We are still
>>>> working on v2 (not ready for review yet) but the general idea can be
>>>> seen here:
>>>>
>>>>     https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
>>>>
>>>>>
>>>>> Evaluating the security impact of this is the next step. My understanding
>>>>> is that eBPF via BTF is constrained to read only access to hook
>>>>> parameters, and that its behavior would be entirely restrictive.
>>>>>
>>>>> I'd like to understand the security impact more fully, though.  Can the
>>>>> eBPF code make arbitrary writes to the kernel, or read anything other than
>>>>> the correctly bounded LSM hook parameters?
>>>>>
>>>>
>>>> As mentioned, the BPF verifier does not allow writes to BTF types.
>>>>
>>>>>> And a traditional security module would necessarily fall
>>>>>> under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
>>>>>> gateway for proprietary LSMs...
>>>>>
>>>>> Right, we do not want this to be a GPL bypass.
>>>>
>>>> This is not intended to be a GPL bypass and the BPF verifier checks
>>>> for license compatibility of the loaded program with GPL.
>>>
>>> IIUC, it checks that the program is GPL compatible if it uses a function
>>> marked GPL-only.  But what specifically is marked GPL-only that is required
>>> for eBPF programs using KRSI?
>>
>> Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
>> specific verification for the v2 of the patch-set which would require
>> all BPF-LSM programs to be GPL.
> 
> I don't think it's a good idea to enforce license on the program.
> The kernel doesn't do it for modules.
> For years all of BPF tracing progs were GPL because they have to use
> GPL-ed helpers to do anything meaningful.
> So for KRSI just make sure that all helpers are GPL-ed as well.

IIUC, the example eBPF code included in this patch series showed a 
program that used a GPL-only helper for the purpose of reporting event 
output to userspace. But it could have just as easily omitted the use of 
that helper and still implemented its own arbitrary access control model 
on the LSM hooks to which it attached.  It seems like the question is 
whether the kernel developers are ok with exposing the entire LSM hook 
interface and all the associated data structures to non-GPLd code, 
irrespective of what helpers it may or may not use.


