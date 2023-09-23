Return-Path: <bpf+bounces-10690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500997AC375
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7F6E62820DA
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F01F956;
	Sat, 23 Sep 2023 16:06:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F4DF42
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C47C433C7
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695485213;
	bh=qw6onMa9f3p2GbSd4m629e1VcU32hUzhGQcWmSQ0GcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2TvBxd6b52Q31r7pATPxku3HBg0sumUlt+TJZyCFiyocWp2nPLWdcHdk8Zfwioey
	 Rr6zo8f4TM6bx/rAkozUsZxysdm4FODpNunTZpECJA/SL1iObl9V2fqpaNantQz7Wf
	 gsJy2Oowxw6aRqVf+myoVXbie2k741hO3zFEdOloy2fVY2sgTvLi3C/RH9cMts8PNk
	 ixGV2CVAvQgYXPYbES3H8CqwAR79lwVsVFUqFcITwKYrjaP0R4HQ9S2gonifaLbiR1
	 3KQOKvAF9v25JS9ENJ+zRINNcWA6VYq+JQgxBmn30j0ynPSE37+b3w+t+NUD6DGIMP
	 MhJ1t75lX/ysA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so65094881fa.2
        for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 09:06:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeBo2SsEyW4Eu0jxyb45WbzTPUqTTyrS2XRrMG0jZF/B9Q80P7
	adUb+pH1EalFMCtNzDSWqQHbgbYudEFqkbrbj4pDHQ==
X-Google-Smtp-Source: AGHT+IGmBvzDlT3b8OwVZug0FXqO2/Vp6kt9JrK44gwJoHFMrBlJ96XGWB1+OkuFvA+/1ZllbobJrT63az6f2srBhN8=
X-Received: by 2002:a05:6512:12cb:b0:503:3644:4a99 with SMTP id
 p11-20020a05651212cb00b0050336444a99mr2721821lfg.51.1695485211400; Sat, 23
 Sep 2023 09:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com> <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
In-Reply-To: <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 23 Sep 2023 18:06:40 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
Message-ID: <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 8:57=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/22 23:45, KP Singh wrote:
> >> I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, wi=
thout patching
> >> __ro_after_init out. We can load LKM-based LSMs, without patching the =
original kernel.
> >
> > Then __ro_after_init is broken in your tree and you are missing some pa=
tches.
>
> This fact applies to vanilla upstream kernel tree; __ro_after_init is not=
 broken and
> some patches are not missing. See https://akari.osdn.jp/1.0/chapter-3.htm=
l.en for details.
>

You are trying to use an unexported symbol from the module with lots
of hackery to write to be supported and bring it up in a discussion?
Good luck!

Regardless, if what you are doing really works after
https://lore.kernel.org/all/20200107133154.588958-1-omosnace@redhat.com,
then we need to fix this as the security_hook_heads should be
immutable after boot. I tried a build where the symbols are exported
and sure enough the module is unable to write to it. So, either your
kernel has the old CONFIG_SECURITY_HOOKS_WRITABLE, or it should
ideally fail with something like:

[   23.990387] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[   23.996796] BUG: unable to handle page fault for address: ffffffff83adf2=
70
[   23.997433] #PF: supervisor instruction fetch in kernel mode
[   23.997936] #PF: error_code(0x0011) - permissions violation
[   23.998416] PGD 3247067 P4D 3247067 PUD 3248063 PMD 100b9e063 PTE
8000000003adf163
[   23.999069] Oops: 0011 [#1] PREEMPT SMP NOPTI
[   23.999445] CPU: 0 PID: 302 Comm: insmod Tainted: G           O
  6.6.0-rc2-next-20230921-dirty #13
[   24.000230] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   24.001024] RIP: 0010:security_add_hooks+0x0/0xa0

If this is not happening, then it's a bug and you chose to report it.

>
>
> >>>
> >>> The performance benefits here outweigh the need for a completely
> >>> unsupported use case.
> >>
> >> LKM-based LSMs are not officially supported since 2.6.24. But people n=
eed LKM-based LSMs.
> >> It is very sad that the LSM community is trying to lock out out of tre=
e LSMs
> >> ( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-lov=
e.SAKURA.ne.jp ).
> >> The LSM interface is a common property for *all* Linux users.
> >
> > Again, I don't understand how this locks out out-of-tree LSMs. One can
> > go and patch static calls the same way one hacked around by directly
> > adding stuff to the security_hook_heads. I am not going to suggest any
> > hacks here but there are pretty obvious solutions out there.;
>
> The change that locks out out-of-tree LSMs (regardless of whether that LS=
M is LKM-based LSM
> or not) is a series including "[PATCH v15 01/11] LSM: Identify modules by=
 more than name".

This does not belong here, please stop cross posting stuff.

>
> I was not pushing LKM-based LSM because the LSM community wanted to make =
it possible to
> enable arbitrary combinations (e.g. enabling selinux and smack at the sam=
e time) before
> making it possible to use LKM-based LSMs.
>
> According to https://marc.info/?l=3Dlinux-security-module&m=3D12323207632=
9805 (Jan 2009),
> Casey said that "SELinux and Smack should never be stacked in the same ke=
rnel.".
> I'm personally wondering how many users will enable selinux and smack at =
the same time.
> But in that post, Casey also said "You could revive the notion of loadabl=
e modules
> while you're at it." while implementing LSM Multiplexer LSM.
>
> According to https://marc.info/?l=3Dlinux-security-module&m=3D13305541010=
7878 (Feb 2012),
> Casey said that support for multiple concurrent LSMs should be able to ha=
ndle
> loadable/unloadable LSMs.
> The reason for removing unload support was that no in-tree users needed i=
t, and
> out of tree use-cases are generally not supported in mainline. That is, w=
hen the
> LSM interface became static, the LSM community was not seeing the reality=
.
> I don't think that rmmod support for LKM-based LSMs is needed, but I beli=
eve that
> insmod support for LKM-based LSMs is needed.
>
> According to https://lkml.kernel.org/r/50ABE354.1040407@schaufler-ca.com =
(Nov 2012),
> Casey said that reintroducing LSMs as loadable modules is a work for anot=
her day
> and a separate battle to fight.
>
> These postings (just picked up from LSM mailing list archives matching ke=
yword "loadable"
> and sent from Casey) indicate that the LSM community was not making chang=
es that forever
> makes LKM-based LSMs impossible.
>
> Finally, pasting Casey's message (Feb 2016) here (because the archive did=
 not find this post):
>
>   From: Casey Schaufler <casey@schaufler-ca.com>
>   Subject: Re: LSM as a kernel module
>   Date: Mon, 22 Feb 2016 10:17:26 -0800
>   Message-ID: <56CB50B6.6060702@schaufler-ca.com>
>   To: Roman Kubiak <r.kubiak@samsung.com>, linux-security-module@vger.ker=
nel.org
>
>   On 2/22/2016 5:37 AM, Roman Kubiak wrote:
>   > I just wanted to make sure that it's not possible and is not planned =
in the future
>   > to have LSM modules loaded as .ko kernel modules. Is that true for no=
w and the far/near future ?
>   >
>   > best regards
>
>   Tetsuo Handa is holding out hope for loadable security modules*.
>   The work I've been doing on module stacking does not include
>   support for loadable modules, but I've committed to not making
>   it impossible. There has never really been a major issue with
>   loading a security module, although there are a host of minor
>   ones. The big problem is unloading the module and cleaning up
>   properly.
>
>   Near term I believe that you can count on not having to worry
>   about dynamically loadable security modules. At some point in
>   the future we may have an important use case, but I don't see
>   that until before some time in the 20s.
>
>   So now I'm curious. What are you up to that would be spoiled
>   by loadable security modules?
>
>
>   ---
>   * The original name for the infrastructure was indeed
>     "Loadable Security Modules". The memory management and
>     security policy implications resulted in steadily
>     diminishing support for any sort of dynamic configuration.
>     It wasn't long before "Loadable" became "Linux".
>
> But while I was waiting for "make it possible to enable arbitrary combina=
tions" change,
> the LSM community started making changes (such as defining the maximum nu=
mber of "slots"
> or "static calls" based on all LSMs are built into vmlinux) that violate =
Casey's promise.
>
> As a reminder to tell that I still want to make LKM-based LSM officially =
supported again,
> I'm responding to changes (like this patch) that are based on "any LSM mu=
st be built into
> vmlinux". Please be careful not to make changes that forever make LKM-bas=
ed LSMs impossible.
>
>
>
> >
> > My recommendation would be to use BPF LSM for any custom MAC policy
> > logic. That's the whole goal of the BPF LSM is to safely enable these
> > use cases without relying on LSM internals and hacks.
>
> I'm fine if you can reimplement TOMOYO (or AKARI or CaitSith) using BPF L=
SM.
> Since BPF has many limitations, not every custom MAC policy can be implem=
ented using BPF.

Please stop making generic statements, either be explicit about your
understanding of the limitations or don't claim them without evidence.

- KP

>
> The need to insmod LKM-based LSMs will remain because the LSM community w=
ill not accept
> whatever LSMs (that are publicly available) and the Linux distributors wi=
ll not build
> whatever LSMs (that are publicly available) into their vmlinux.
>
> But "LSM: Identify modules by more than name" is the worst change because=
 that change
> locks out any publicly available out of tree LSMs, far away from allowing=
 LKM-based LSMs.
>

