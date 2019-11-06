Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84332F134C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 11:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKFKHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 05:07:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45370 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfKFKHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 05:07:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so6460586pga.12
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 02:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X05zBYkPaLX+0zINsXEFrTIGhG2lc88Xq9e+QvToQFs=;
        b=OEt1lNHNq2Y25+Ru30BQlIgL1EGLF4SVCDHXPTBUUEH8XXrzP4rFCGQIIeA4HEfSu9
         RWld6zC55fYxRNKD4idGhvwNxieHUE/RWLmQcF3jnD/Tx3jT04Q52E9fs2zOYKPzkA9g
         abeKK24Z/udzmQEdJYQ6ClRdjgr/ngNM2VwBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X05zBYkPaLX+0zINsXEFrTIGhG2lc88Xq9e+QvToQFs=;
        b=O5TTPF8Qbl+lhRlxP5PwuNm+uoK7bV5zdgQlsnK85TSwmsqrbqs+OxFHEY0xogX4Ny
         sn/ozVoZg3qnqJ+SGFEmBjVetgVwDgptnfJwjqjin46BTcaqXLhpFSWRF3rt0ZCLZl9j
         Ha+L9L1nZlEBdehDPAR2UwttcfGL7fLJySOxy6kXprqf1y0yukfQzxxDtyWC2nN90WMg
         4s08RSR5oDFtcJ7nk0KhF/LG4kc6EclRlousDS+KRjGIfBe+kKbIDQXE9f0WHWWGclq6
         Hv8TvnothQ/U3kgaQZvTBEqqCwBfbHZHnd+5bkzzgsoh+VByDJk9Fb1NW6DpVrxwppiO
         AtJg==
X-Gm-Message-State: APjAAAWns50ApY5SPRHGRwzB+7GPEuxj28J7bAC+LvjCrUBxok6fSmXs
        GPqHtJisFF7aArBmXyJKb9U21A==
X-Google-Smtp-Source: APXvYqwrv7trCkuRJxdZlf4pExinvZ0+o6T0QzG7Jw/AdQ0WLySdLfsGsUbtgGqNbwJwE2iJbMk2xQ==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr1924765pgb.22.1573034836267;
        Wed, 06 Nov 2019 02:07:16 -0800 (PST)
Received: from chromium.org ([122.173.128.252])
        by smtp.gmail.com with ESMTPSA id k9sm22977594pfk.72.2019.11.06.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 02:07:15 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 6 Nov 2019 15:36:55 +0530
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v13 4/7] landlock: Add ptrace LSM hooks
Message-ID: <20191106100655.GA18815@chromium.org>
References: <20191104172146.30797-1-mic@digikod.net>
 <20191104172146.30797-5-mic@digikod.net>
 <20191105171824.dfve44gjiftpnvy7@ast-mbp.dhcp.thefacebook.com>
 <23acf523-dbc4-855b-ca49-2bbfa5e7117e@digikod.net>
 <20191105193446.s4pswwwhrmgk6hcx@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105193446.s4pswwwhrmgk6hcx@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05-Nov 11:34, Alexei Starovoitov wrote:
> On Tue, Nov 05, 2019 at 07:01:41PM +0100, Micka�l Sala�n wrote:
> > 
> > On 05/11/2019 18:18, Alexei Starovoitov wrote:
> > > On Mon, Nov 04, 2019 at 06:21:43PM +0100, Micka�l Sala�n wrote:
> > >> Add a first Landlock hook that can be used to enforce a security policy
> > >> or to audit some process activities.  For a sandboxing use-case, it is
> > >> needed to inform the kernel if a task can legitimately debug another.
> > >> ptrace(2) can also be used by an attacker to impersonate another task
> > >> and remain undetected while performing malicious activities.
> > >>
> > >> Using ptrace(2) and related features on a target process can lead to a
> > >> privilege escalation.  A sandboxed task must then be able to tell the
> > >> kernel if another task is more privileged, via ptrace_may_access().
> > >>
> > >> Signed-off-by: Micka�l Sala�n <mic@digikod.net>
> > > ...
> > >> +static int check_ptrace(struct landlock_domain *domain,
> > >> +		struct task_struct *tracer, struct task_struct *tracee)
> > >> +{
> > >> +	struct landlock_hook_ctx_ptrace ctx_ptrace = {
> > >> +		.prog_ctx = {
> > >> +			.tracer = (uintptr_t)tracer,
> > >> +			.tracee = (uintptr_t)tracee,
> > >> +		},
> > >> +	};
> > > 
> > > So you're passing two kernel pointers obfuscated as u64 into bpf program
> > > yet claiming that the end goal is to make landlock unprivileged?!
> > > The most basic security hole in the tool that is aiming to provide security.
> > 
> > How could you used these pointers without dedicated BPF helpers? This
> > context items are typed as PTR_TO_TASK and can't be used without a
> > dedicated helper able to deal with ARG_PTR_TO_TASK. Moreover, pointer
> > arithmetic is explicitly forbidden (and I added tests for that). Did I
> > miss something?
> 
> It's a pointer leak.
> 
> > 
> > > 
> > > I think the only way bpf-based LSM can land is both landlock and KRSI
> > > developers work together on a design that solves all use cases.
> > 
> > As I said in a previous cover letter [1], that would be great. I think
> > that the current Landlock bases (almost everything from this series
> > except the seccomp interface) should meet both needs, but I would like
> > to have the point of view of the KRSI developers.
> > 
> > [1] https://lore.kernel.org/lkml/20191029171505.6650-1-mic@digikod.net/
> > 
> > > BPF is capable
> > > to be a superset of all existing LSMs whereas landlock and KRSI propsals today
> > > are custom solutions to specific security concerns. BPF subsystem was extended
> > > with custom things in the past. In networking we have lwt, skb, tc, xdp, sk
> > > program types with a lot of overlapping functionality. We couldn't figure out
> > > how to generalize them into single 'networking' program. Now we can and we
> > > should. Accepting two partially overlapping bpf-based LSMs would be repeating
> > > the same mistake again.
> > 
> > I'll let the LSM maintainers comment on whether BPF could be a superset
> > of all LSM, but given the complexity of an access-control system, I have
> > some doubts though. Anyway, we need to start somewhere and then iterate.
> > This patch series is a first step.
> 
> I would like KRSI folks to speak up. So far I don't see any sharing happening
> between landlock and KRSI. You're claiming this set is a first step. They're
> claiming the same about their patches. I'd like to set a patchset that was
> jointly developed.

We are willing to collaborate with the Landlock developers and come up
with a common approach that would work for Landlock and KRSI. I want
to mention that this collaboration and the current Landlock approach
of using an eBPF based LSM for unprivileged sandboxing only makes sense
if unprivileged usage of eBPF is going to be ever allowed.

Purely from a technical standpoint, both the current designs for
Landlock and KRSI target separate use cases and it would not be
possible to build "one on top of the other". We've tried to identify
the lowest denominator ("eBPF+LSM") requirements for both Landlock
(unprivileged sandboxing / Discretionary Access Control) and KRSI
(flexibility and unification of privileged MAC and Audit) and
prototyped an implementation based on the newly added / upcoming
features in BPF.

We've been successfully able to prototype the use cases for KRSI
(privileged MAC and Audit) using this "eBPF+LSM" and shared our
approach at the Linux Security Summit [1]:

* Use the new in-kernel BTF (CO-RE eBPF programs) [2] and the ability
  of the BPF verifier to use the BTF information for access validation
  to provide a more generic way to attach to the various LSM hooks.
  This potentially saves a lot of redundant work:

   - Creation of new program types.
   - Multiple types of contexts (or a single context with Unions).
   - Changes to the verifier and creation of new BPF argument types 
     (eg. PTR_TO_TASK)

* These new BPF features also alleviate the original concerns that we
  raised when initially proposing KRSI and designing for precise BPF
  helpers. We have some patches coming up which incorporate these new
  changes and will be sharing something on the mailing list after some
  cleanup.

We can use the common "eBPF+LSM" for both privileged MAC and Audit and
unprivileged sandboxing i.e. Discretionary Access Control.
Here's what it could look like:

* Common infrastructure allows attachment to all hooks which works well
  for privileged MAC and Audit. This could be extended to provide
  another attachment type for unprivileged DAC, which can restrict the
  hooks that can be attached to, and also the information that is
  exposed to the eBPF programs which is something that Landlock could
  build.

* This attachment could use the proposed landlock domains and attach to
  the task_struct providing the discretionary access control semantics.

[1] https://static.sched.com/hosted_files/lsseu2019/a2/Kernel%20Runtime%20Security%20Instrumentation.pdf
[2] http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf

- KP Singh

> 
