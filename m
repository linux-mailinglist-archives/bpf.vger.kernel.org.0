Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB40A0EAD
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH2Apv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 20:45:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46405 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfH2Apu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 20:45:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id o3so720692plb.13
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+e9P4o5owFVnHx2r+zK7dVFJy7ZPl+QBIWM88iu0HTo=;
        b=DJYSK7HPVgnMorDAM7rcRou0qAutsGZ60241mi9S8V9e2tAbdtvi7ZhAFgP44HhguJ
         GdTo6qvQpJTVKjRrrkzYodw82l440c1gap2x28NXcpBcR1k8oqe1VqoiLE0AyV1DcM6w
         OAmDIxtjytNDGcz5gav8svpQ1d9yBt1lVOIE8TRVqIEyhSE3g8gZJ7QxOOLE4exl8NuW
         rX9VL7iHcmL5FBZ1yrNbs0MY1Gk+a+v0QJ1vWol9lA0succ31vzRqLld148fCWoDkSzn
         KLPWU0AjQMTh9YVgxR9pwHLwChZ+6ZQrvXyEZp9m2kQgh8Qlcj5r0IxZCT7C3Ig4dZdG
         TbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+e9P4o5owFVnHx2r+zK7dVFJy7ZPl+QBIWM88iu0HTo=;
        b=l0VM07syTMunQf0amtYYne4UdJtLBHxOuRRO5z7j+SigmbMXJachZ4lcXHYOT0rQjL
         n7Guk0DzYmrOaZCZLrMincBI9Mz9vZqvQfS+DDwIhNnER1DC0MmRJ1yg4CF6o1zkcM6B
         EueOWiuTHqH/ULhh78hb81GJtz/o8JadPOuUrmv52ZGtrDPatvatAhD5YmaW24deYnl/
         Lxs//3qR6yViA91L0cM4xZNLrS6K2PiAIw13EwFDw3iGo8F298ZdQjCUkNAdvMeqeIgv
         ZBExmSjV/wjRQbNChg2wJCebKJIK8o4hAzrpDPRKT7AteFsII+dhlOqQhiCuFW0kIYfR
         oB6A==
X-Gm-Message-State: APjAAAWi+PLnJo0Hd7YMOUgBgx7ewIurLcYHzHpHGP61bIr4tnOpU7aD
        prezdn68We2tNREM/r83SLFuDg==
X-Google-Smtp-Source: APXvYqx9wttmQeUmstj9YDTRQe3NyQVC+a4+iSYRSGL4a3Ho6GdVSRdPvUsYd/BTGlovXk16q2l4iQ==
X-Received: by 2002:a17:902:f217:: with SMTP id gn23mr7067878plb.21.1567039549870;
        Wed, 28 Aug 2019 17:45:49 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:9437:f332:3e4c:f05b? ([2601:646:c200:1ef2:9437:f332:3e4c:f05b])
        by smtp.gmail.com with ESMTPSA id o67sm632953pfb.39.2019.08.28.17.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 17:45:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next] bpf, capabilities: introduce CAP_BPF
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <20190828225512.q6qbvkdiqih2iewk@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 28 Aug 2019 17:45:47 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA52992F-4862-4945-8482-FE619A04C753@amacapital.net>
References: <20190827205213.456318-1-ast@kernel.org> <CALCETrV8iJv9+Ai11_1_r6MapPhhwt9hjxi=6EoixytabTScqg@mail.gmail.com> <20190828003447.htgzsxs5oevn3eys@ast-mbp.dhcp.thefacebook.com> <CALCETrVbPPPr=BdPAx=tJKxD3oLXP4OVSgCYrB_E4vb6idELow@mail.gmail.com> <20190828044340.zeha3k3cmmxgfqj7@ast-mbp.dhcp.thefacebook.com> <CALCETrW1o+Lazi2Ng6b9JN6jeJffgdW9f3HvqYhNo4TpHRXW=g@mail.gmail.com> <20190828225512.q6qbvkdiqih2iewk@ast-mbp.dhcp.thefacebook.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Aug 28, 2019, at 3:55 PM, Alexei Starovoitov <alexei.starovoitov@gmail.=
com> wrote:
>=20
>> On Tue, Aug 27, 2019 at 11:12:29PM -0700, Andy Lutomirski wrote:
>>>>=20
>>>>=20
>>>> =46rom the previous discussion, you want to make progress toward solvin=
g
>>>> a lot of problems with CAP_BPF.  One of them was making BPF
>>>> firewalling more generally useful. By making CAP_BPF grant the ability
>>>> to read kernel memory, you will make administrators much more nervous
>>>> to grant CAP_BPF.
>>>=20
>>> Andy, were your email hacked?
>>> I explained several times that in this proposal
>>> CAP_BPF _and_ CAP_TRACING _both_ are necessary to read kernel memory.
>>> CAP_BPF alone is _not enough_.
>>=20
>> You have indeed said this many times.  You've stated it as a matter of
>> fact as though it cannot possibly discussed.  I'm asking you to
>> justify it.
>=20
> That's not how I see it.
> I kept stating that both CAP_BPF and CAP_TRACING are necessary to read
> kernel memory whereas you kept distorting my statement by dropping second
> part and then making claims that "CAP_BPF grant the ability to read
> kernel memory, you will make administrators much more nervous".

Mea culpa. CAP_BPF does, however, appear to permit breaking kASLR due to uns=
afe pointer conversions, and it allows reading and writing everyone=E2=80=99=
s maps.  I stand by my overall point.

>=20
> Just s/CAP_BPF/CAP_BPF and CAP_TRACING/ in this above sentence.
> See that meaning suddenly changes?
> Now administrators would be worried about tasks that have both at once.
> They also would be worried about tasks that have CAP_TRACING alone,
> because that's what allows probe_kernel_read().

This is not all what I meant. Of course granting CAP_BPF+CAP_TRACING allows r=
eading kernel memory. This is not at all a problem.  Here is a problem I see=
:

CAP_TRACING + CAP_BPF allows modification of other people=E2=80=99s maps and=
 potentially other things that should not be implied by CAP_TRACING alone an=
d that don=E2=80=99t need to be available to tracers. So CAP_TRACING, which i=
s powerful but has somewhat limited scope, isn=E2=80=99t fully useful withou=
t CAP_BPF, and giving CAP_TRACING *and* CAP_BPF allows things that teachers s=
houldn=E2=80=99t be able to do. I think this would make the whole mechanism l=
ess useful to Android, for example.

(Also, I=E2=80=99m not sure quite what you mean by =E2=80=9CCAP_TRACING ... a=
llows probe_kernel_read()=E2=80=9D. probe_kernel_read() is a kernel function=
 that can=E2=80=99t be directly called by userspace. CAP_TRACING allows read=
ing kernel memory in plenty of ways regardless.)

>=20
>> It seems like you are specifically trying to add a new switch to turn
>> as much of BPF as possible on and off.  Why?
>=20
> Didn't I explain it several times already with multiple examples
> from systemd, daemons, bpftrace ?
>=20
> Let's try again.
> Take your laptop with linux distro.
> You're the only user there. I'm assuming you're not sharing it with
> partner and kids. This is my definition of 'single user system'.
> You can sudo on it at any time, but obviously prefer to run as many
> apps as possible without cap_sys_admin.
> Now you found some awesome open source app on the web that monitors
> the health of the kernel and will pop a nice message on a screen if
> something is wrong. Currently this app needs root. You hesitate,
> but the apps is so useful and it has strong upstream code review process
> that you keep running it 24/7.
> This is open source app. New versions come. You upgrade.
> You have enough trust in that app that you keep running it as root.
> But there is always a chance that new version doing accidentaly
> something stupid as 'kill -9 -1'. It's an open source app at the end.
>=20
> Now I come with this CAP* proposal to make this app safer.
> I'm not making your system more secure and not making this app
> more secure. I can only make your laptop safer for day to day work
> by limiting the operations this app can do.
> This particular app monitros the kernel via bpf and tracing.
> Hence you can give it CAP_TRACING and CAP_BPF and drop the rest.

This won=E2=80=99t make me much more comfortable, since CAP_BPF lets it do a=
n ever-growing set of nasty things. I=E2=80=99d much rather one or both of t=
wo things happen:

1. Give it CAP_TRACING only. It can leak my data, but it=E2=80=99s rather ha=
rd for it to crash my laptop, lose data, or cause other shenanigans.

2. Improve it a bit do all the privileged ops are wrapped by capset().

Does this make sense?  I=E2=80=99m a security person on occasion. I find vul=
nerabilities and exploit them deliberately and I break things by accident on=
 a regular basis. In my considered opinion, CAP_TRACING alone, even extended=
 to cover part of BPF as I=E2=80=99ve described, is decently safe. Getting r=
oot with just CAP_TRACING will be decently challenging, especially if I don=E2=
=80=99t get to read things like sshd=E2=80=99s memory, and improvements to m=
itigate even that could be added.  I am quite confident that attacks startin=
g with CAP_TRACING will have clear audit signatures if auditing is on.  I am=
 also confident that CAP_BPF *will* allow DoS and likely privilege escalatio=
n, and this will only get more likely as BPF gets more widely used. And, if B=
PF-based auditing ever becomes a thing, writing to the audit daemon=E2=80=99=
s maps will be a great way to cover one=E2=80=99s tracks.


> I think they have no choice but to do kernel.unprivileged_bpf_disabled=3D1=
.
> We, as a kernel community, are forcing the users into it.
> Hence I really do not see a value in any proposal today that expands
> unprivileged bpf usage.

I think you=E2=80=99re overemphasizing bpf=E2=80=99s role in the whole specu=
lation mess. I realize that you=E2=80=99ve spent an insane amount of time on=
 mitigations to stupid issues. I=E2=80=99ve spent a less insane amount of ti=
me on mitigating similar issues outside of bpf.  It=E2=80=99s a mess.  At th=
e end of the day, the kernel does its best, and new bugs show up. New CPUs w=
ill be less buggy.=20=
