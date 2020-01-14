Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB94E13B129
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgANRl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 12:41:57 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:48150 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 12:41:57 -0500
X-EEMSG-check-017: 45652462|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,319,1574121600"; 
   d="scan'208";a="45652462"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 17:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579023711; x=1610559711;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HDo9FQhngwTpufm0+JLleGQgxI59uRdUncI1V6P6U0M=;
  b=Z1gTCrlUbbKs2JbntCIjFYBxF5eM09IFXAXCLpyXFpUwCPc/WhJ1ioGO
   vTbud3+KuCDu6tsF1KFIlFlp4tG17LPKEbHQ8hf2mu49t8xQVqoah3eeb
   AAoAfXV9cURUb3aFmiJtW+iyjxlyQfK9vGq6faOBdPBeexPCyse5q+Hg8
   8ykmFqg5UGUHXZEiQwNeSfvZNbFm0kwZ8ux/RIfbo0nXzipBiGRpbRJja
   mKX7Hgtb/61LFpbl9QkN5iuDO8HvDRzFTS2gdMNDGFAJXBk15K3wgBiuQ
   7z6Reb9iGn/vZl/hyCq8WsDbIeHwBjjN0xY74a+y1kGK1w4i/N//kOHBg
   A==;
X-IronPort-AV: E=Sophos;i="5.70,319,1574121600"; 
   d="scan'208";a="31938384"
IronPort-PHdr: =?us-ascii?q?9a23=3AA8g++RIeerUpnpPUO9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgULf77rarrMEGX3/hxlliBBdydt6sYzbKP+PixESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo91x?=
 =?us-ascii?q?TFrmdMdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1L2Tnz9obIfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjVids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeifITB9hH1/ebK/gQ6/8Uehyu3gVsm0zU?=
 =?us-ascii?q?1FojBZndnLs3AA0QHY5MufSvZl40us1jmC2xrT5+1ZO0w4i6XWJ4A7zrItkJ?=
 =?us-ascii?q?cYrF7NETXsmErsia+bbkAk+u+15Ov5erjmvZqcN5NsigH5L6QuhtSzAeQmPQ?=
 =?us-ascii?q?gKWGiW4fi826f5/U34XbVKlec6kqjfsJDUIsQbvbC2DBNP3oY/6xewEzem0N?=
 =?us-ascii?q?MCkXkBMF1FYw6Ig5LsO1HPJPD0Ffa/g1Kynzd33/3KI7LsD5rXInXDjbvtZ6?=
 =?us-ascii?q?hx5kFCxAYp0NxT/5dUBasAIPL3VE/xrtvYDhohPgyv3unnE85w1p8eWG2TAq?=
 =?us-ascii?q?+ZN7nesVmT5u01OeWMa4gVuCjlJ/g/+/HulWM5mUMafaSxx5QXbG63H/t4LE?=
 =?us-ascii?q?WYe3bsmcsBHn0Qvgo5Uuzqj1yCUSJUZ3asRK886TQ7B5inDYfHXIyinLuB3C?=
 =?us-ascii?q?KjFJ1Mem9GEkyMEWvvd4icWPcMcDmSIs5nkjwLVbisUJMu1RG0tA/9zrpnL/?=
 =?us-ascii?q?fU+igCuZLkzth16PXZlQsu+jxsE8Sdz2aNQnl2nmMNQD82xrp/oU1mylqY16?=
 =?us-ascii?q?h3mflYGsJS5/9TVQc6L5HcxfRgC9/uQgLBYsuJSFG+T9WlHz4+UMkxzMMJY0?=
 =?us-ascii?q?Z6GNWvlQzM3yqwA78SkryLBYE08qfG03j2PcZ9xG7M1LM9gFk+XstPKWqmi7?=
 =?us-ascii?q?Zj+AfJHI7GjUWYmr2xdasA3C7C7nqDzWSKvE5GSg58SLnKUmoFakTKqtT541?=
 =?us-ascii?q?vIT6WyBrQ/LgtB1cmCJ7NOat3oi1VGWfjiNM3dY22vgWewAwiHxreXYYr0dG?=
 =?us-ascii?q?USwj/dBFIHkw8N53aGMxYxBiO7r2LZFjxuGkrlY1nw/ulmtHO7Ukg0whmRYE?=
 =?us-ascii?q?152bq44QAVhfOCRPMJxL4Euzkuqy9yHFmj29LaEd2ApxBufK9Ee9My/E9H1X?=
 =?us-ascii?q?7Ftwx6JpGgK6FihlgDcwV4pk/uzAt4BZldkcgwrXMq0ApzJbud0FNGajyYwJ?=
 =?us-ascii?q?TwNaPMJ2ns8xCgdbTW1kvd0NmI4KcP7uo3q1H5sAGuDEoi/G1t08NJ3HuE+p?=
 =?us-ascii?q?XKEA0SXIrrXUYs6xh3vLLabTcn54PSy3JsNbO4sjjY29ImHOEl0Aqvf89DMK?=
 =?us-ascii?q?OYEw//C9AVCNKoKOwrhVepagkJPOFV9K47IcypbeGG17WsPOdvhj6mi3pI4J?=
 =?us-ascii?q?xl2EKW6yV8UvLI34oCw/yAwguHVzj8g027ssDxmIBLeyofEXa/ySj+A45RY6?=
 =?us-ascii?q?xyfZsOCWu0JM233Np+jYb3W3FE7F6jG08G2MixdBqXb1zyxwlQ2lgNoXygly?=
 =?us-ascii?q?q11DN0kzYurqqQ2CzB3f7uewYAOm5OXGNil0vjIZCoj9AGW0ildxAplBm55U?=
 =?us-ascii?q?vhyKhbo6N/L2bXQUhWZST5M2ZiUq6ovLqYf8FP8I8osTlQUOmkel+aUKDyox?=
 =?us-ascii?q?0H3Cz5GWtS3i00eyulupXjgRN6h22dIW18rHrcY85wxBPf6MbASv5W2zoMXD?=
 =?us-ascii?q?N4hiXPBligI9mp+s2Zl5XZveC4UWKhVoZecSbszYOHuyu74XNlDQejkPC0n9?=
 =?us-ascii?q?3tCRI63jPj19l2SSXIqw7xYozp16S1Me9qelJlBFD768p9FYF+lpU/iIsM1n?=
 =?us-ascii?q?gdg5Wf5WAHnnvrMdVHxaL+a2IASiILw97P4Qjlw1FjLnOTyIL/TXiS2dFhaM?=
 =?us-ascii?q?OnYmMQxC099dpGCKaT7LZchyt6vkK4rR7NYfh6hjodzPou52IBju4UuQotwS?=
 =?us-ascii?q?SdArMVHUZFJyDskQqH78ympqVNeGmvaaSw1FZ5nd25FrGNvB9cV2jiepc+Bi?=
 =?us-ascii?q?J/8sV/MEjL0H3264HkZdzQYcgUth2OnBfKl/JVJ44plvoWmSpnPnrwvX8/xO?=
 =?us-ascii?q?Enjhxu2Iu1vI6cJGh24K25AgRYNjrwZ8MS5zHtiLxSnsGM34CgBp9hACkEXI?=
 =?us-ascii?q?P0TfK0FzIfrffnOByAEDImq3eWArTfEhSF5Eh6qHLPFoihN2uLK3kB0dViWB?=
 =?us-ascii?q?6dKVREgAATWjU6kZo5FgG3xMP6akd2/C4R5l/+qhtD0e9oOQLwXn3Dqwevbz?=
 =?us-ascii?q?c+UIKfIwZO7gFe+0fVNtST7+JzHyFD5ZChoheCJnaHaARPCGEDQlaECEz7Pr?=
 =?us-ascii?q?my+dnA9PCVBvGgIPvUbrWBt/dTV/eSypKr1otn/zCMOt+TMXllCv0xwlBDUm?=
 =?us-ascii?q?xhG8TFhzUPTDQalyfRYM6buhi8+jd4odu4/PTwQg3v4JCPC6ZUMdVg4B22gr?=
 =?us-ascii?q?mMN/SWhClnLTZUzJQMxWXHyLIHxl4dlzludyWxEbQHrSPCUbjfmrFJAB4ecC?=
 =?us-ascii?q?58KdFH77wi0QlIPc7bjd311qJigv4zFVhFSUTrmtu1aswSP2G9KFTHCV6ENL?=
 =?us-ascii?q?ScOzLLzML3YaOnRL1UjeVUsQCwuDmVE0/kIzSDkSTmWAqzMeFNiyGbOgZSuI?=
 =?us-ascii?q?anchZiEWLjVs7pagWnMN9rij072bs0hnLWOm4bNThzaVhNoqee7SxGmPV/AX?=
 =?us-ascii?q?JO42FgLemFhymZ9e7YJYoWsftqGiR4jf5V4HM/y7FN9iFLWOR1mDfOrt5pu1?=
 =?us-ascii?q?ymifSAyjR8XRpBrTZLg42LvUF8NqnD6pZAXnPE9goX7WqMExQKu8dlCtr3tq?=
 =?us-ascii?q?BJ19jAiqTzKCtD89LS58ccAs/UKMSBMHU/LRrkAzjUAxUZTT6xMmHfgUtdkP?=
 =?us-ascii?q?SM+XGPspc6rZ3skoIUSrBHTFw1Cu8aCkN9EdwYPZh3WCkrnKWVjMET/3axsB?=
 =?us-ascii?q?7RRMBCtJDdSv2SGenvKCqejbRcZRsIxq33IJ8dN4Lh3Uxtd0N2nILUFErMR9?=
 =?us-ascii?q?xNpCxgZBcuoEpR6Hh+UnEz20X9ZwO1+nATCPq0kwUuigRkfOQt8C7g41IwJl?=
 =?us-ascii?q?rNvis/jlM9lsnigTCUI3bNK/KZWYxGBiu8jFQ4KJTlRAdpahP6yUVgOSfJRv?=
 =?us-ascii?q?RKk7J6cn5siRPbp7NAHPddSetPZxpGgbm0X70T0FJTqm3zxldc5O3KCbNplB?=
 =?us-ascii?q?EtdJ+xqjRHwQ01P/AvIqmFH7ZE1lhdgOq1uyas0u0giFsFK10l7HKZeClOvl?=
 =?us-ascii?q?cBcLYhOXz7raRX9QWelm4bKyA3XP0wr6cvrxhsNg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CWAwAJ/B1e/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEDYkDhmwGgRIliW6RSQkBAQEBAQEBAQEtCgEBhEACgiI4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMPAQVBEAsYAgImAgJXBgEMCAEBg?=
 =?us-ascii?q?lcMPwGCViUPrDmBMokYgTcGgQ4ojDJ5gQeBEScMA4JdPoJLGQKEc4JeBJAPh?=
 =?us-ascii?q?12XUoJCgkmEc4VDiSgGG4JHjEaLYI5biFyULCKBWCsIAhgIIQ+DKE8YDYt0i?=
 =?us-ascii?q?nEjAzAMjRkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Jan 2020 17:41:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EHf3Ix265082;
        Tue, 14 Jan 2020 12:41:04 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
From:   Stephen Smalley <sds@tycho.nsa.gov>
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
 <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
Message-ID: <49a45583-b4fb-6353-a8d4-6f49287b26eb@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 12:42:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/14/20 11:54 AM, Stephen Smalley wrote:
> On 1/10/20 12:53 PM, Alexei Starovoitov wrote:
>> On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
>>> On 09-Jan 14:47, Stephen Smalley wrote:
>>>> On 1/9/20 2:43 PM, KP Singh wrote:
>>>>> On 10-Jan 06:07, James Morris wrote:
>>>>>> On Thu, 9 Jan 2020, Stephen Smalley wrote:
>>>>>>
>>>>>>> On 1/9/20 1:11 PM, James Morris wrote:
>>>>>>>> On Wed, 8 Jan 2020, Stephen Smalley wrote:
>>>>>>>>
>>>>>>>>> The cover letter subject line and the Kconfig help text refer 
>>>>>>>>> to it as a
>>>>>>>>> BPF-based "MAC and Audit policy".  It has an enforce config 
>>>>>>>>> option that
>>>>>>>>> enables the bpf programs to deny access, providing access 
>>>>>>>>> control. IIRC,
>>>>>>>>> in
>>>>>>>>> the earlier discussion threads, the BPF maintainers suggested 
>>>>>>>>> that Smack
>>>>>>>>> and
>>>>>>>>> other LSMs could be entirely re-implemented via it in the 
>>>>>>>>> future, and that
>>>>>>>>> such an implementation would be more optimal.
>>>>>>>>
>>>>>>>> In this case, the eBPF code is similar to a kernel module, 
>>>>>>>> rather than a
>>>>>>>> loadable policy file.  It's a loadable mechanism, rather than a 
>>>>>>>> policy, in
>>>>>>>> my view.
>>>>>>>
>>>>>>> I thought you frowned on dynamically loadable LSMs for both 
>>>>>>> security and
>>>>>>> correctness reasons?
>>>>>
>>>>> Based on the feedback from the lists we've updated the design for v2.
>>>>>
>>>>> In v2, LSM hook callbacks are allocated dynamically using BPF
>>>>> trampolines, appended to a separate security_hook_heads and run
>>>>> only after the statically allocated hooks.
>>>>>
>>>>> The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
>>>>> still remains __lsm_ro_after_init and cannot be modified. We are still
>>>>> working on v2 (not ready for review yet) but the general idea can be
>>>>> seen here:
>>>>>
>>>>>     
>>>>> https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c 
>>>>>
>>>>>
>>>>>>
>>>>>> Evaluating the security impact of this is the next step. My 
>>>>>> understanding
>>>>>> is that eBPF via BTF is constrained to read only access to hook
>>>>>> parameters, and that its behavior would be entirely restrictive.
>>>>>>
>>>>>> I'd like to understand the security impact more fully, though.  
>>>>>> Can the
>>>>>> eBPF code make arbitrary writes to the kernel, or read anything 
>>>>>> other than
>>>>>> the correctly bounded LSM hook parameters?
>>>>>>
>>>>>
>>>>> As mentioned, the BPF verifier does not allow writes to BTF types.
>>>>>
>>>>>>> And a traditional security module would necessarily fall
>>>>>>> under GPL; is the eBPF code required to be likewise?  If not, 
>>>>>>> KRSI is a
>>>>>>> gateway for proprietary LSMs...
>>>>>>
>>>>>> Right, we do not want this to be a GPL bypass.
>>>>>
>>>>> This is not intended to be a GPL bypass and the BPF verifier checks
>>>>> for license compatibility of the loaded program with GPL.
>>>>
>>>> IIUC, it checks that the program is GPL compatible if it uses a 
>>>> function
>>>> marked GPL-only.  But what specifically is marked GPL-only that is 
>>>> required
>>>> for eBPF programs using KRSI?
>>>
>>> Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
>>> specific verification for the v2 of the patch-set which would require
>>> all BPF-LSM programs to be GPL.
>>
>> I don't think it's a good idea to enforce license on the program.
>> The kernel doesn't do it for modules.
>> For years all of BPF tracing progs were GPL because they have to use
>> GPL-ed helpers to do anything meaningful.
>> So for KRSI just make sure that all helpers are GPL-ed as well.
> 
> IIUC, the example eBPF code included in this patch series showed a 
> program that used a GPL-only helper for the purpose of reporting event 
> output to userspace. But it could have just as easily omitted the use of 
> that helper and still implemented its own arbitrary access control model 
> on the LSM hooks to which it attached.  It seems like the question is 
> whether the kernel developers are ok with exposing the entire LSM hook 
> interface and all the associated data structures to non-GPLd code, 
> irrespective of what helpers it may or may not use.

Also, to be clear, while kernel modules aren't necessarily GPL, prior to 
this patch series, all Linux security modules were necessarily GPLd in 
order to use the LSM interface.  So allowing non-GPL eBPF-based LSMs 
would be a change.

