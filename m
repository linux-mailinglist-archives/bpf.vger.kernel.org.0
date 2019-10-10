Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A36D1DBC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfJJAxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 20:53:47 -0400
Received: from sonic315-22.consmr.mail.bf2.yahoo.com ([74.6.134.196]:36808
        "EHLO sonic315-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731166AbfJJAxr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Oct 2019 20:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570668825; bh=SSQ8Z1EQwqfaDRxNRixZXVO4/u1RC+wz2AlKOqrHGuI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=srn49EN42/PldG4PPESAAPcxdtWOUJbRjrgX90mu4qmxnlp2AP51NSaUd4KUgSO9A1Q/5fIMGcJSLVYRz8o4AnEnc3DdKhmAISznoKNtpYT9XSSz+SXNxXmgRhC2Ol9HIM3/TaCvg4fdLOsl1FcZrUfau+VsCBwzDt1l8jiVxL0uN4WX6I+USjJaTeW1/7lrZcAtp9pgUZwZvtM6ZPkYOBNdiZliQ+IwSyfSZUG+5eBZjrGhbw8dq0rHoeRA6TJlePHTwScXc0Zu3KB7zmU+T4100+1Zc7pTj4tQfgM4YH9maf9DVJqCHH4BycFJ1B0t2tD+IDlCjeg6GUflbZNzOA==
X-YMail-OSG: NMzIvkAVM1nnhnCXFtkwpKnljZFtd28BC8WppBeS3_hJxNn1huy3LTjY6L5hObN
 8lXab7KrenW33ASPv62aFKsO1bGbTZBhs77g_qxbt6YRw8M52wIu86lXgH1wQj.jIQIelKKmTTh6
 7A0JonpWFVCqhSrea0f0cI3HUq4i848rxiMsWLuCVmEDMpvK8M7EID9OONOLOGYgUqXeZ_R7YeuI
 IfZ.H_c4GG6SdZX48fBy8YKMdzNx2OfLx4FfQZYIeC1XzvxCo7fItBty7e9ZJW7SZErdCUicxS6K
 aa.np9yAqGOYa5fhOwk1DatNely3Si7FWDHv1AE.Z9shzlEcA.E07BCo44qXRQpTyIn6ZnugGOcG
 Lcbju7Rxh7kR4iBaITxXwh_84oQmXIfxAfNCmBWXupaEiWnFBalCeBce7diBLUKbTb66zmU3bWj3
 hJxbJPXu3daQIwBwZtLcGNhuj4F2ZJ0RgLiAMrsXAf8FdfDrwUUsOlUVIPUxuQUPilnNvmalXS8u
 cu56CdbnQ87HZrulsBahiWpKSrT3GhrJl0P1wvhw11fKD249uf7jH5wpE70LaBb4qtaxM_29Q.mj
 nbhLS6gEmu4Df7DnzKOUCRCtaMgn.83D8drE.nRr9SImai9FbtqqMZbrbvZEBp7TcAGrux5aVvWP
 Y_XIBbzute7y_yEGP1GWBfhRzss3IzVNYujmprN6eW7GvPePxE2bfjXPDNoDyaidTq5yFlNNw3uu
 4cGtTIGqFNXrguc1AH2dosEtjQ3AMDIbUdv21H_MfeEJbQh3ac5VHGKaQvdJUaTYu4P7.nxv5c7F
 eiiJEH74tgjCukbwZX3dez0LTMwywHjWuKRqb2EZctX1os3bSlKCafRPrt8c3hodAPz_M0sdhxua
 qqd1XGgRNcZweEriBOR5A_aG988ZLesKLZHFEvXAuhLWD3RKMswc7LZ7z1IWqAwWnqMr1SdA1q4V
 zI3.D1FnJWYKc1iIgk61Te8ikb_pYOj_9Q96dUBJbAE_E8Z6zZW0mOtWEAY2ZYb9YtkE76liyrkT
 rx6hU1_yEwW2iP57o_1nRY0AyaRpzetW9Lld6Tx6OLAO6jJAt568nFV5l4PgqQiD96sWaTwGqXsd
 MxSSVLjqFQdZXpBpCcwqXlbMyuC7PdqQ7k8f6UEYojex4dWARORPCNqps1vMrRUx43pnuiuO5G_K
 yt7REokicu3ZThqIIkURCc4PnHh5hnolLrkwqzm2nR6G_gDG0vFzr.fT4P8rMmeLtIyu1zbZD5QG
 zHwFWbRlf65c6Zp.b8ssGQBpu0JbM3uYh9ytZH2xIPutyezCg0sRGGcEMb8XcA1yU2bf.hZMgXv0
 Qvmhn0oIRyA0tZhI_js5gFL9KjUXXdrFwSJSPSQNCUQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 10 Oct 2019 00:53:45 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3ce68f22fa117db179b879a7855dd76;
          Thu, 10 Oct 2019 00:53:43 +0000 (UTC)
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>, casey@schaufler-ca.com
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
 <alpine.LRH.2.21.1910100912210.29840@namei.org>
 <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
 <20191010004023.GC96813@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <ea32212d-bd45-c363-841a-f4397aafd323@schaufler-ca.com>
Date:   Wed, 9 Oct 2019 17:53:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010004023.GC96813@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/2019 5:40 PM, Joel Fernandes wrote:
> On Wed, Oct 09, 2019 at 03:41:56PM -0700, Casey Schaufler wrote:
>> On 10/9/2019 3:14 PM, James Morris wrote:
>>> On Wed, 9 Oct 2019, Casey Schaufler wrote:
>>>
>>>> Please consider making the perf_alloc security blob maintained
>>>> by the infrastructure rather than the individual modules. This
>>>> will save it having to be changed later.
>>> Is anyone planning on using this with full stacking?
>>>
>>> If not, we don't need the extra code & complexity. Stacking should on=
ly=20
>>> cover what's concretely required by in-tree users.
>> I don't believe it's any simpler for SELinux to do the allocation
>> than for the infrastructure to do it. I don't see anyone's head
>> exploding over the existing infrastructure allocation of blobs.
>> We're likely to want it at some point, so why not avoid the hassle
>> and delay by doing it the "new" way up front?
>>
> I don't see how it can be maintained by the users (assuming you meant
> infrastructure as perf_event subsystem).

No, I meant allocated in security.c. Look at how file blobs are allocated=
=2E

>  The blob contains a SID which as far
> as I know, is specific to SELinux. Do you have an in-tree example of th=
is?
>
> Further, this is also exactly it is done for BPF objects which I used a=
s a
> reference.

There's no real harm in doing it that way, just that it is a change that
I'll have to make at some point in the future* and it would be really nic=
e
if I didn't have to.

> thanks,
>
>  - Joel

-----
* When? After I get the current AppArmor/SELinux stacking enabling in
  and can get to the Smack backlong, which includes BPF and perf_events.
=C2=A0


