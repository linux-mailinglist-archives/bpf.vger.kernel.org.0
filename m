Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468E8F066E
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2019 20:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfKETzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Nov 2019 14:55:23 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:40666
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729577AbfKETzX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Nov 2019 14:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1572983721; bh=d9L0VmPL6ALHaSammxHQMCwSd1ZmOK0RbRK+tf+z8FQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=H03KZzN/+bLe1zPdsfK8AFewMwl2a9WZwfFhivgszz+MukYWXM9Bnqfe8lyFBCNo02WrVli+VWcHNSrti5vTbY/jotdwj8opEQnb6Y8uAYI75b5tNbrMbXCLQaTJBPHkyzrb6VlV5Pt/6Onb+cvDOMJX5ikUCXBxuj74d3gmKpjRluqxIK20Rmx/7VtlZMqpyc7lb/yrzvMoyaIPqnOwSPREuQlYc55/Cghlk0MNooC15J7+cb+N6S3SxENScdv0BuY9LcMzmKKtLLqU0idpUfu9wTvhpo0zxJnIUKh+vcQM4LCORu5UM/+dBl2FBMn+lSBkiz4c9KAoDYdh1HbEuA==
X-YMail-OSG: EYiygnkVM1kbNPk0Yu.7vFvBJtEOXVpRrhcACoGas71uPCjpfxHhkAf_IHGekE0
 j7BhR0ymB9kpUJhJd0Ul4SMy7veFiHEAWTe9KWMchCjsJlgc3HJkt8fTVy3KQqFEIcaLKCCp.91e
 dZfK_SPPNVPJh9L5CuHryGEzqpEY0Xiv6yX78h1tPqGylKrGaC7UkSAFE7uPaCxi.QpCOCX5inXs
 xzrVGpXeg.OKf_q9g8xRp64tv4sB5Smik1Q5uKIZJUHN7EvWjTiLitHvBM5ElpbUKgJIWfgiPQsT
 yQ13Ojg7aBRZ2YC5yNjAFMD65P7KQMgGNpVxS0gtgmcMS_hBFrnB29_1X8aQGDcZezqXPAdUWBu2
 _05KL8wsKEddFHTU6oAp.wO1bB_DLCnj1j3E1zGrvrSDJ_Zp0AgDHTr5P2Iu737Q36HAE0gkRiDD
 xIw3PLb1WJFM2NCVLnTtVBeT45tyIjgKXxdiwvM6ukbBgAsF0DhBNn3UMFLc2zOhPK8rppM2oZ5C
 fA3T9Px5dg8MDvyKXTEnD8HH2hu2YKdV7jImbrDklxcTlWuIMFewflJSxByYd30arfkn2QVSknJn
 D_tkngy9hi72vKUt8NP95OQZodxEZbL0HsvgkPC0UP1p8yMEOhklppj7XQ0APHNo7bPm9cu.a8y_
 uZVqOCm2BaQ7KZZPZvyWdWfAs3SNKmqJoopvdsSKJ.0bNebYmKRLPGDDDsCXZvfX8CAY34CDkso2
 To01qNAVEW0suEoQhhTKz6rj_FQwp5aW8.VRhfMxQLOZsAeTBXIMpu1lObJzHHWxODmon3XpGp38
 AcKgCy4ZCpR_Ny7OQmeXYLmpk0qcaQI_vVRYswhCJPaUUjPdCLgPV4aMxkekS9ediAsJ8oyoK248
 0dPDceNJywBKAgzqot5XVRiZNnO7ImjfURyYhyVbVmeQqhTEKCQwGH1VEUdqSbB087MOigc7AywA
 TeKGcsHjNVhuyq.SI1KkY4hFpas2yCISA2sxbJwekUvrI9Ga3vrPVuQ2wkyzC0djLAOXqSGGrV9j
 4bNgNRYs8io4PR1Ad42oZ4TL16SJf6a6Pl37P2xWf_Oe0TMGYPjUany9ElCW7KxiDyDmpys5ONcG
 hxSZW6_kxSYapJnjDCxE_zKNv5bRgb4NECJDOCpSLEOSgePGXWNjI3DfRmhJvxjLsIQFn4SFZvyK
 cQkJiFf1P6cMVLc3jGugnQlwe7iKvzwKZDlJdqw1D.6n1bj._LzFr.Z7N..s3y4kwxKzgXHvK2dj
 aTr.s8dEIGG70epPQyqVvVllOSgFNQnTqtBXBprHtaTA4pPkQge..mN_1ejctPWr_MOGKsQfH2uK
 Ex__eeW7JE91Ab_QRIWFyMSvqJp8xPstTtmUolL69WNYAoJsP9bnC.YcQTAVKlfuxa.iuLVJmEeP
 lXfOyjo2w34bsRw.T_Cfrbh829_mXJkqFMZn0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 5 Nov 2019 19:55:21 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ea7233fffc1d793da98fdfec1a3806b8;
          Tue, 05 Nov 2019 19:55:18 +0000 (UTC)
Subject: Re: [PATCH bpf-next v13 4/7] landlock: Add ptrace LSM hooks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        casey@schaufler-ca.com
References: <20191104172146.30797-1-mic@digikod.net>
 <20191104172146.30797-5-mic@digikod.net>
 <20191105171824.dfve44gjiftpnvy7@ast-mbp.dhcp.thefacebook.com>
 <c5c6b433-7e6a-c8f8-f063-e704c3df4cc6@schaufler-ca.com>
 <20191105193130.qam2eafnmgvrvjwk@ast-mbp.dhcp.thefacebook.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <637736ef-c48e-ac3b-3eef-8a6a095a96f1@schaufler-ca.com>
Date:   Tue, 5 Nov 2019 11:55:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105193130.qam2eafnmgvrvjwk@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14638 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/5/2019 11:31 AM, Alexei Starovoitov wrote:
> On Tue, Nov 05, 2019 at 09:55:42AM -0800, Casey Schaufler wrote:
>> On 11/5/2019 9:18 AM, Alexei Starovoitov wrote:
>>> On Mon, Nov 04, 2019 at 06:21:43PM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:
>>>> Add a first Landlock hook that can be used to enforce a security pol=
icy
>>>> or to audit some process activities.  For a sandboxing use-case, it =
is
>>>> needed to inform the kernel if a task can legitimately debug another=
=2E
>>>> ptrace(2) can also be used by an attacker to impersonate another tas=
k
>>>> and remain undetected while performing malicious activities.
>>>>
>>>> Using ptrace(2) and related features on a target process can lead to=
 a
>>>> privilege escalation.  A sandboxed task must then be able to tell th=
e
>>>> kernel if another task is more privileged, via ptrace_may_access().
>>>>
>>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>>> ...
>>>> +static int check_ptrace(struct landlock_domain *domain,
>>>> +		struct task_struct *tracer, struct task_struct *tracee)
>>>> +{
>>>> +	struct landlock_hook_ctx_ptrace ctx_ptrace =3D {
>>>> +		.prog_ctx =3D {
>>>> +			.tracer =3D (uintptr_t)tracer,
>>>> +			.tracee =3D (uintptr_t)tracee,
>>>> +		},
>>>> +	};
>>> So you're passing two kernel pointers obfuscated as u64 into bpf prog=
ram
>>> yet claiming that the end goal is to make landlock unprivileged?!
>>> The most basic security hole in the tool that is aiming to provide se=
curity.
>>>
>>> I think the only way bpf-based LSM can land is both landlock and KRSI=

>>> developers work together on a design that solves all use cases. BPF i=
s capable
>>> to be a superset of all existing LSMs
>> I can't agree with this. Nope. There are many security models
>> for which BPF introduces excessive complexity. You don't need
>> or want the generality of a general purpose programming language
>> to implement Smack or TOMOYO. Or a simple Bell & LaPadula for
>> that matter. SELinux? I can't imagine anyone trying to do that
>> in eBPF, although I'm willing to be surprised. Being able to
>> enforce a policy isn't the only criteria for an LSM.=20
> what are the other criteria?

They include, but are not limited to, performance impact
and the ability to be analyzed. The interactions with other
subsystems meeting the requirements thereof is always a concern.


>
>> It's got
>> to perform well and integrate with the rest of the system.=20
> what do you mean by that?

It has to be fast, or the networking people are
going to have fits. You can't require the addition
of a pointer into the skb because it'll get rejected
out of hand. You can't completely refactor the vfs locking
to accommodate you needs.

>
>> I see many issues with a BPF <-> vfs interface.
> There is no such interface today. What do you have in mind?

You can't implement SELinux or Smack using BPF without a way
to manipulate inode data.

>
>> the mechanisms needed for the concerns of the day. Ideally,
>> we should be able to drop mechanisms when we decide that they
>> no longer add value.
> Exactly. bpf-based lsm must not add to kernel abi.

Huh? I have no idea where that came from.


