Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E216419585C
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgC0Ntk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 09:49:40 -0400
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:13738 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgC0Ntk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 09:49:40 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 09:49:39 EDT
X-EEMSG-check-017: 71368882|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="71368882"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 13:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585316549; x=1616852549;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EluxbPINP69ahvzM5QR7sPRQweHHFIS2OjUyuJ8MGO8=;
  b=g9btz5neRwCNeNvrhumA11va9WhAVrZLctT58YZLVotp3VB3lmOYsq3O
   V8rAX8AmgVLkNTzhw6Q30a/TGFSsWmk17Isyi5jml3z9aA3HUiUZ+8zwY
   eLyI1m966FpJYOLHuKOe95WZWtAXhXdfWiHUaJPg71uCoupmKsWDzGphQ
   MfVsu4rYnncYf+8vmy8L86zihRCe9GeUj68vpxbEt8xjyE2G1dZy6n2HT
   cHqEYQyaxJ+ZJG3y3WVFq/SGgxxu4F6Ajbwcewn/EGHBFVWqo/JxiXAgh
   p6ag0EXaKVwubwgIDW9CwE3gEFP47RygYzzYgZ9+zvHyKXUE7ryAYrnJG
   g==;
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="41132559"
IronPort-PHdr: =?us-ascii?q?9a23=3A+wouJR1LxFUSBm5msmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQI/XxwZ3uMQTl6Ol3ixeRBMOHsq4C0reH+P26EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmssAncts0bjYRiJ6ov1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9V1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nxLMGvp?=
 =?us-ascii?q?u7czILyJQh3xPfaOKIc5KO4h39UOadOzB4hGhqeL+5mh288lCgx/XhWsS731?=
 =?us-ascii?q?tGtCpInsTWunwT2BHf9NKLRuZ780y8wziAzRrT5ftBIU0skKrbLIMuzaAom5?=
 =?us-ascii?q?oItETDAjf2mELrjK+Kbkkk+van6+DgYrj+up+TLZV0igDjMqQ1gMC/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qHs/VblT7lQi/02k63ZvIjbJcQduKG5HxdY3pss5huwFTur0M?=
 =?us-ascii?q?kUkWMZIF9KZh6LlZXlN0nLIP/iDPe/h1qskC1sx/DDJrDhGYjCLmPYnbf9fb?=
 =?us-ascii?q?dy905cyA0pwdBZ/JJbEKsNIP30Wk/vrNDYFAM2MxSow+b7D9VwzoAeWXqUAq?=
 =?us-ascii?q?+YNqPSvl+I6/kzLOmMfo8VvzP9K/k45/7rl3M5nkUdfaax15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0gNcBFGAKvhAkTOzrk12PSjhTaGy3X60i5zE3EoWmDZ3MRoq1mryOwD?=
 =?us-ascii?q?+7HoFKZmBBEl2MFXbod4OZW/YDcS6SIdFukiYCVbe/T48szg+utADkxLp9NO?=
 =?us-ascii?q?bU+TMXtYjl1Ndr4+3fjxYy9SZ7D86FyWGCU3l0nn8URz8xxK1wulR9ylmY3K?=
 =?us-ascii?q?hmjPxXC8ZT6+lKUggkL57cyfJ1C9ToVgLGZNeJR06sQs+6DjEpUtIx39gObl?=
 =?us-ascii?q?55G9WjiBDDwiWrD6YOl7OVGJM077jc33ntJ8d90nrG0a4hgEQ7QstLK2Krnb?=
 =?us-ascii?q?B/9wfNCI7TiUmZlLildb4a3CHT8GeP122OvFtXUARoS6XKQWgfZlfKrdT+/k?=
 =?us-ascii?q?7CTaWhBqgkMgtE08GCLLBFZ8bmjVVBQ/fjN9DebHyrl2isAhaIw6uGbJD2dG?=
 =?us-ascii?q?UFwCXdFE8EnhgJ/XmYKwgxGDyho37FATxhElLvZEzs8e1gp3+hUkA0yASKZV?=
 =?us-ascii?q?V717Wp4h4VmeCcS/QL070eoychty55HFWj0NLMDdqPuQ5hcL9bYdMn71dNzX?=
 =?us-ascii?q?jZuBBlPpy8M6BigUYTfBltsEPo1hV4FIFAnNMrrHMtwwp9N7iX0ElaeDOf0p?=
 =?us-ascii?q?H8ILvXJXfu/Bq3ca7Zxkne0MqK+qcI8Pk4qEvssx+yFkU+9HVn1NpV3mCA6Z?=
 =?us-ascii?q?XKFgoSVpfxUkcq9xh/vb3aZTM954zM3312Laa0qiPC284uBOY90hagfctfPb?=
 =?us-ascii?q?iLFA/1FM0aCMyuJ/Iwl1e1aRIEOfhY9LQoMMO+a/uGxKmrMf5inD28i2RH5o?=
 =?us-ascii?q?B931mD9yp7Te7I0JIFzO+C0gSbUDf8iU+rstrrloBceTESAm2/xDD+BIFPeK?=
 =?us-ascii?q?19Y50LCXu1LsKrxtV+nZntW3tZ9F6+AlMKwsipeQCdb1blxw1fyVwXoWC7mS?=
 =?us-ascii?q?u/1zF0kSsmobac3CzL2evicgEIN3VXS2lil1fsJo20j9EHXEitdQQpkwGl5U?=
 =?us-ascii?q?nizahBuKt/N3XTQVtPfyXuIGFiSLW/trWBY85P854otSRXUOKhYVGVRL79pA?=
 =?us-ascii?q?Ya0yX+EGRE2DA7djaqupPjkxx9kmKdI255rGDFdsFo2Rff+NvcSOZJ3jUcWS?=
 =?us-ascii?q?l4jSLaBkCmMNm0+dWYjpLDsue5V2K7SJJfazXkzYSFtHjz2Wo/IiX3pPG1ld?=
 =?us-ascii?q?2vRQsiyi792NlCXiXSqxP9f4yt0L61Z7FJZE5tUWTg5tJ6F4c2qY45gJUdyD?=
 =?us-ascii?q?BOnZmO1WYWmmf0d9NA0OTxa2RbFm1D+MLc/AWwgB4rFXmO3Y+sEyzGk8Y=3D?=
X-IPAS-Result: =?us-ascii?q?A2AGAQA4An5e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8LGxUATIqhBqOfFIBAQaBCi2Je5FNCgEBAQEBAQEBASsJAQIEAQGER?=
 =?us-ascii?q?AKCMSQ3Bg4CEAEBAQUBAQEBAQUDAQFshVYMgjspAYMMAQUjDwEFQRALGAICJ?=
 =?us-ascii?q?gICVwYNBgIBAYJjPwGCVyUPrECBMoQ1AYEVg2uBOAaBDioBjC4aeYEHgREnD?=
 =?us-ascii?q?4JePoJOhRKCXgSQOV2fR4JGglaFCY8nBh2baZgmlHgjgVgrCAIYCCEPgygSP?=
 =?us-ascii?q?RgNlySFXSUDMgGBAwEBjX4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 13:42:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RDglU2212485;
        Fri, 27 Mar 2020 09:42:47 -0400
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
To:     KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
 <20200327124115.GA8318@chromium.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 09:43:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327124115.GA8318@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/20 8:41 AM, KP Singh wrote:
> On 27-Mär 08:27, Stephen Smalley wrote:
>> On 3/26/20 8:24 PM, James Morris wrote:
>>> On Thu, 26 Mar 2020, KP Singh wrote:
>>>
>>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>>>> +			const struct bpf_prog *prog)
>>>> +{
>>>> +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
>>>> +	 */
>>>> +	if (!capable(CAP_MAC_ADMIN))
>>>> +		return -EPERM;
>>>> +
>>>
>>> Stephen, can you confirm that your concerns around this are resolved
>>> (IIRC, by SELinux implementing a bpf_prog callback) ?
>>
>> I guess the only residual concern I have is that CAP_MAC_ADMIN means
>> something different to SELinux (ability to get/set file security contexts
>> unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
>> here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
>> the implementation of that hook for the modules that want that) conflates
>> two very different things.  Prior to this patch, there are no users of
>> CAP_MAC_ADMIN outside of individual security modules; it is only checked in
>> module-specific logic within apparmor, safesetid, selinux, and smack, so the
>> meaning was module-specific.
> 
> As we had discussed, We do have a security hook as well:
> 
> https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/
> 
> The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
> module specific logic for LSM programs. I thougt that was okay?
> 
> Kees was in favor of keeping the CAP_MAC_ADMIN check here:
> 
> https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook
> 
> If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
> check here, but given that we already have a security hook that meets
> the requirements, we probably don't need another one.

I would favor removing the CAP_MAC_ADMIN check here, and implementing it 
in a bpf_prog hook for Smack and AppArmor if they want that.  SELinux 
would implement its own check in its existing bpf_prog hook.



