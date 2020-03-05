Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD117AD5F
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCERfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 12:35:54 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com ([66.163.185.153]:41938
        "EHLO sonic305-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgCERfy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Mar 2020 12:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583429752; bh=k2xHTNONz5sMhvyO5N8Im0O7CjtgXx2Pz7D1hNnS8nk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oXe4cF7bDLveS/gG5YCN30IDwhDIldvK9+sF32Oew78jqh/ipNAt/kRy4mVU8wLijO8FWsz+tPPLbF3UV8L1O8LKRkyOFeMPujy4ZBrPsx0cxWJ2rWQwyQmQzr9RRxgY9ujUFhQEBnNbuP8CdOk4rJ5ZqrvUH4joOR6XLLotRxMRbmIPgD2Syktdvun0bVkf3EX3Jq8Re39vEfhATQ7wyS8r4L1y40QRTbmctPKByuTOMop/em3Joh0+nqHJkPiSh3Zh9mih+BxtqSVmQoO8ZpSYXURHXHmqXFjChHVextG3ciceziL7RqTLFSG8nq32/e2sPs7L3mCPjESgfCK+VA==
X-YMail-OSG: KzMLmncVM1l4LgZ_sS1bIlKREMtvCZ2IBZA5CG2ZrLCQ9ttB3GJdZTq6tYEJnUd
 sHof_5IdMQ4CPX95GzkS3vG4olGEYDVhB4e3a98E4U4o.FLXHmj081W7vOax3KMIw7AWbT.7EcHm
 DD6Hsn7ByOlzqnPUi94b.rJr20FnfXo5MeOXaw.GGz6fF2aWqvcFfY4aKCiHo3et3HHGsIhFNeoW
 TwDuOrHNAOKl3hu38V98KPKVX2dLJGn1M5k0iMBLeXJS4v39gl3_JjjTnIixKumFG._H1GyAEKb3
 ysZG_wzRogMVFnwAsc.Pka8Qg._XvFQ3v54E04f_Wn.MS3ddHqbOwBGuzN.KIDR_213445W_JPwO
 BS9JObIm4jqPPPl0hP2kbC357HvuYMbbDHbiv.MSuw6CUTzblKaXuHFtyJznzPjbnEaglJTVHEb0
 lmEqcR_V6SVo6L2m352eLXtp132KihQpCqWA9DITYC7B.0QJSM9npoA5acVSVSI3wVRFoooqAAlI
 BOmT2MxatdpY6_cPWXUkyofuCDVKJntk7dq4kT4CqhtznV8wfGHOl2Lr5jKTamiu5vIink.UwnD3
 QzsVCHHmVBg5asUCz8r9wSWOYj2rHLY7ASNXSUnEvQrA7lElZRRf6utDGFlRG8zO.TkmgTqhngxL
 ueAo1aBAGiMBKayml3tS2XkmH3P.aWjJ8fZg9DrCh2D0CXU3SVbq7ApVsKVrEojEV5hrlYreYQbJ
 gKeblR17Rp2ANEfLwxm2KM6lR_Ft_sN_HMwmw1aELL6Vqe_ZlXxPbB0U3RZELcMK4gkSaYnWhZnv
 coAvHZ9IiJJwbfmIGS9DAUd2i8XV1G6vZ9x47O2ecBRV5vPmFJEK2w8VKFS8qovh7QPgx8Ct2bva
 Q.8hV9esDXSma91.muKiEupvn2butjss3ge4NP6eefxg5of74FoQqjBJBvDrzajpNhsPt7cRrDhP
 8V3cB.zIUiNxtkgXNSJ24YH3xjG1N2dJTjoox2oxjkeIUwZLoTSf6Pv8.AGs9KQ1_lz.AADVzC78
 SHLMiFwjd5xX9eMb5I2Us2ZnDxWt4E1Wu8NYqtpau0QlMEFZ3ftoBKMZbxsg0QGTiQC7wALm9p39
 GXm.pP9cS40qXYMn8ZrQ8.A3mtJ7QzAU75EtgCXEQXzAA1dvQqlQZ9pGhhqoLkhQj2ZQSJX25G5v
 ouqgpqlnlGyeuC3MI9ZI1pFtIR0zkRN4PHn4hTrj1Ad58Xk4y0q4iQxW9aFPNIhgLArUADN3mdtD
 j.NfWuPTNJBqUHN_07kV5U2dqqskMP94XzXCxS7d5.1lI5sPlCMgvKxwvEebbAkPwMTOUoDq0ojf
 TEB_.B5mznKGK0KSZUOHdPkrgQaX8LbwF52ky0gahN9a5fdmsY_70Fd5LduZXSkDEqWIQhJRsaxm
 8h5Ta6ySv6TpoUxdunKX5xdOPIlC9PW1qikCU.MI2s1CF6A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Mar 2020 17:35:52 +0000
Received: by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 44f0bf907ef9420dd1891bfaea2db984;
          Thu, 05 Mar 2020 17:35:49 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
 <20200305155421.GA209155@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d7615424-48cb-1131-3c5d-f2a0b4adfaf7@schaufler-ca.com>
Date:   Thu, 5 Mar 2020 09:35:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305155421.GA209155@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/5/2020 7:54 AM, KP Singh wrote:
> On 05-Mar 08:51, Stephen Smalley wrote:
>> On Wed, Mar 4, 2020 at 2:20 PM KP Singh <kpsingh@chromium.org> wrote:
>>> From: KP Singh <kpsingh@google.com>
>>>
>>> When multiple programs are attached, each program receives the return=

>>> value from the previous program on the stack and the last program
>>> provides the return value to the attached function.
>>>
>>> The fmod_ret bpf programs are run after the fentry programs and befor=
e
>>> the fexit programs. The original function is only called if all the
>>> fmod_ret programs return 0 to avoid any unintended side-effects. The
>>> success value, i.e. 0 is not currently configurable but can be made s=
o
>>> where user-space can specify it at load time.
>>>
>>> For example:
>>>
>>> int func_to_be_attached(int a, int b)
>>> {  <--- do_fentry
>>>
>>> do_fmod_ret:
>>>    <update ret by calling fmod_ret>
>>>    if (ret !=3D 0)
>>>         goto do_fexit;
>>>
>>> original_function:
>>>
>>>     <side_effects_happen_here>
>>>
>>> }  <--- do_fexit
>>>
>>> The fmod_ret program attached to this function can be defined as:
>>>
>>> SEC("fmod_ret/func_to_be_attached")
>>> int BPF_PROG(func_name, int a, int b, int ret)
>>> {
>>>         // This will skip the original function logic.
>>>         return 1;
>>> }
>>>
>>> The first fmod_ret program is passed 0 in its return argument.
>>>
>>> Signed-off-by: KP Singh <kpsingh@google.com>
>>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>> IIUC you've switched from a model where the BPF program would be
>> invoked after the original function logic
>> and the BPF program is skipped if the original function logic returns
>> non-zero to a model where the BPF program is invoked first and
>> the original function logic is skipped if the BPF program returns
>> non-zero.  I'm not keen on that for userspace-loaded code attached
> We do want to continue the KRSI series and the effort to implement a
> proper BPF LSM. In the meantime, the tracing + error injection
> solution helps us to:
>
>   * Provide better debug capabilities.
>   * And parallelize the effort to come up with the right helpers
>     for our LSM work and work on sleepable BPF which is also essential
>     for some of the helpers.
>
> As you noted, in the KRSI v4 series, we mentioned that we would like
> to have the user-space loaded BPF programs be unable to override the
> decision made by the in-kernel logic/LSMs, but this got shot down:
>
>    https://lore.kernel.org/bpf/00c216e1-bcfd-b7b1-5444-2a2dfa69190b@sch=
aufler-ca.com
>
> I would like to continue this discussion when we post the v5 series
> for KRSI as to what the correct precedence order should be for the
> BPF_PROG_TYPE_LSM and would appreciate if you also bring it up there.

I believe that I have stated that order isn't my issue.
Go first, last or as specified in the lsm list, I really
don't care. We'll talk about what does matter in the KRSI
thread.


>> to LSM hooks; it means that userspace BPF programs can run even if
>> SELinux would have denied access and SELinux hooks get
>> skipped entirely if the BPF program returns an error.

Then I'm fine with using the LSM ordering mechanisms that Kees
thought through to run the BPF last. Although I think it's somewhat
concerning that SELinux cares what other security models might be
in place. If BPF programs can violate SELinux (or traditional DAC)
policies there are bigger issues than ordering.

>>   I think Casey
>> may have wrongly pointed you in this direction on the grounds
>> it can already happen with the base DAC checking logic.  But that's
> What we can do for this tracing/modify_ret series, is to remove
> the special casing for "security_" functions in the BPF code and add
> ALLOW_ERROR_INJECTION calls to the security hooks. This way, if
> someone needs to disable the BPF programs being able to modify
> security hooks, they can disable error injection. If that's okay, we
> can send a patch.
>
> - KP
>
>> kernel DAC checking logic, not userspace-loaded code.
>> And the existing checking on attachment is not sufficient for SELinux
>> since CAP_MAC_ADMIN is not all powerful to SELinux.
>> Be careful about designing your mechanisms around Smack because Smack
>> is not the only LSM.

:)
=C2=A0


