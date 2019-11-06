Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3FF2104
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKFVqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 16:46:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41405 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbfKFVpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 16:45:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so5729446plj.8
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 13:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wHTfhRohaRD5+YSmn4w/tSNSPwRjR2Kg2q+1zQkt4iA=;
        b=F807TyZKEzeWi4NbHz+to+x3TpcNcfrYZWWTqgXNxaBYjgIQe724YD+lT9GO1IaMPh
         lAAQ6Y+6cGPwhZ/IXuWoUdjIkFqLQpFCMIt3Ocg/1yt1t0BAZuH1DtoDcu8RMLEFY8Xm
         XIvj0IsMN/+/fOh8/0Te74LsJUb2oJc2d32+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wHTfhRohaRD5+YSmn4w/tSNSPwRjR2Kg2q+1zQkt4iA=;
        b=kATDfj1fGaFF2yjyCEMjcSxJXwXLUmOaETFbrGoRDsf7HBFlutMq00toIr/PxDVjLC
         cBHbKeednYpkLvAaOWlyh6x4r9V9P2lr6J/BqNGCdf48tHHxatUVBSDLXNoukSDcYSHK
         uVdX8Y0i1xH1GbNPK/gy6oleV7yzjhv91lSghV8FEh2rc+ZZZxXui/tGPpW4XRrkQyjq
         g/8BzdQxgfKiyI9XAEc7bHfZM/JMkSClBDPfMowUFaA65FRC+C9HrX4FyDxsvyRVvH59
         gq9jtiSeMg6WdSd5Mz9D/T5yYAd9PH+p4cyprgRkx392z3Y1gecc1FD+RcBurLFDksTs
         QUyQ==
X-Gm-Message-State: APjAAAXxWNRt1SOojHzeTN2y+piKVTz78VGDDztNnjg8x8Z7Fj56WjsM
        AE/l72aPfzN+GzvkaayNDIiN/A==
X-Google-Smtp-Source: APXvYqzJI3smLMVgrak3bMVAMNdOtDewOJhibyW0/pIikIwy+Kzub2+iiZp8mOLYLBdMNTzlMWQZPQ==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr5115222plz.144.1573076747293;
        Wed, 06 Nov 2019 13:45:47 -0800 (PST)
Received: from chromium.org ([122.173.128.252])
        by smtp.gmail.com with ESMTPSA id c12sm32820159pfp.178.2019.11.06.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 13:45:46 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 7 Nov 2019 03:15:26 +0530
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20191106214526.GA22244@chromium.org>
References: <20191104172146.30797-1-mic@digikod.net>
 <20191104172146.30797-5-mic@digikod.net>
 <20191105171824.dfve44gjiftpnvy7@ast-mbp.dhcp.thefacebook.com>
 <23acf523-dbc4-855b-ca49-2bbfa5e7117e@digikod.net>
 <20191105193446.s4pswwwhrmgk6hcx@ast-mbp.dhcp.thefacebook.com>
 <20191106100655.GA18815@chromium.org>
 <813cedde-8ed7-2d3b-883d-909efa978d41@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <813cedde-8ed7-2d3b-883d-909efa978d41@digikod.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06-Nov 17:55, Mickaël Salaün wrote:
> 
> On 06/11/2019 11:06, KP Singh wrote:
> > On 05-Nov 11:34, Alexei Starovoitov wrote:
> >> On Tue, Nov 05, 2019 at 07:01:41PM +0100, Mickaël Salaün wrote:
> >>> On 05/11/2019 18:18, Alexei Starovoitov wrote:
> 
> [...]
> 
> >>>> I think the only way bpf-based LSM can land is both landlock and KRSI
> >>>> developers work together on a design that solves all use cases.
> >>>
> >>> As I said in a previous cover letter [1], that would be great. I think
> >>> that the current Landlock bases (almost everything from this series
> >>> except the seccomp interface) should meet both needs, but I would like
> >>> to have the point of view of the KRSI developers.
> >>>
> >>> [1] https://lore.kernel.org/lkml/20191029171505.6650-1-mic@digikod.net/
> >>>
> >>>> BPF is capable
> >>>> to be a superset of all existing LSMs whereas landlock and KRSI propsals today
> >>>> are custom solutions to specific security concerns. BPF subsystem was extended
> >>>> with custom things in the past. In networking we have lwt, skb, tc, xdp, sk
> >>>> program types with a lot of overlapping functionality. We couldn't figure out
> >>>> how to generalize them into single 'networking' program. Now we can and we
> >>>> should. Accepting two partially overlapping bpf-based LSMs would be repeating
> >>>> the same mistake again.
> >>>
> >>> I'll let the LSM maintainers comment on whether BPF could be a superset
> >>> of all LSM, but given the complexity of an access-control system, I have
> >>> some doubts though. Anyway, we need to start somewhere and then iterate.
> >>> This patch series is a first step.
> >>
> >> I would like KRSI folks to speak up. So far I don't see any sharing happening
> >> between landlock and KRSI. You're claiming this set is a first step. They're
> >> claiming the same about their patches. I'd like to set a patchset that was
> >> jointly developed.
> > 
> > We are willing to collaborate with the Landlock developers and come up
> > with a common approach that would work for Landlock and KRSI. I want
> > to mention that this collaboration and the current Landlock approach
> > of using an eBPF based LSM for unprivileged sandboxing only makes sense
> > if unprivileged usage of eBPF is going to be ever allowed.
> 
> The ability to *potentially* do unprivileged sandboxing is definitely
> not tied nor a blocker to the unprivileged usage of eBPF. As explained
> in the documentation [1] (cf. Guiding principles / Unprivileged use),
> Landlock is designed to be as safe as possible (from a security point of
> view). The impact is more complex and important than just using
> unprivileged eBPF, which may not be required. Unprivileged use of eBPF
> would be nice, but I think the current direction is to extend the Linux
> capabilities with one or multiple dedicated to eBPF [2] (e.g. CAP_BPF +
> something else), which may be even better (and a huge difference with
> CAP_SYS_ADMIN, a.k.a. privileged mode or root). Landlock is designed to
> deal with unprivileged (i.e. non-root) use cases, but of course, if the
> Landlock architecture may enable to do unprivileged stuff, it definitely
> can do privileged stuff too. However, having an architecture designed
> with safe unprivileged use in mind can't be achieve afterwards.
> 
> [1] https://lore.kernel.org/lkml/20191104172146.30797-8-mic@digikod.net/
> [2] https://lore.kernel.org/bpf/20190827205213.456318-1-ast@kernel.org/
> 
> 
> > 
> > Purely from a technical standpoint, both the current designs for
> > Landlock and KRSI target separate use cases and it would not be
> > possible to build "one on top of the other". We've tried to identify
> > the lowest denominator ("eBPF+LSM") requirements for both Landlock
> > (unprivileged sandboxing / Discretionary Access Control) and KRSI
> > (flexibility and unification of privileged MAC and Audit) and
> > prototyped an implementation based on the newly added / upcoming
> > features in BPF.
> 
> This is not as binary as that. Sandboxing can be seen as DAC but also as
> MAC, depending on the subject which apply the security policy and the
> subjects which are enforced by this policy. If the sandboxing is applied
> system-wide, it is what we usually call MAC. DAC, in the Linux world,
> enables any user to restrict access to their files to other users.
> 
> With Landlock it is not the same because a process can restrict itself
> but also enforce these restrictions on all its future children (which
> may be malicious, whatever their UID/GID). The threat and the definition
> of the attacker are not the same in both cases. With the Linux DAC the
> potentially malicious subjects are the other users, whereas with
> Landlock the potentially malicious subjects are (for now) the current
> process and all its children. Another way to explain it, and how
> Landlock is designed, is that a specific enforcement (i.e. a set of BPF
> programs) is tied to a domain, in which a set of subject are. From this
> perspective, this approach (subjects/tasks in a domain) is orthogonal to
> the DAC system (subjects/users). This design may apply to a system-wide
> MAC system by putting all the system tasks in one domain, and managing
> restrictions (by subject) with other means (e.g. task's UID,
> command-line strings, environment variables). In short, Landlock (in
> this patch series) is closer to a (potentially scoped) MAC system. But
> thanks to eBPF, Landlock is firstly a programmatic access-control, which
> means that the one who write the programs and tie them to a set of
> tasks, can implement their own access-control system (e.g. RBAC,
> time-based…), or something else (e.g. an audit system).
> 
> The audit part can simply be achieve with dedicated helpers and programs
> that always allow accesses.
> 
> Landlock evolved over multiple iterations and is now designed to be very
> flexible. The current way to enforce a security policy is to go through
> the seccomp syscall (which makes sense for multiple reasons explained
> and accepted before). But Landlock is designed to enable similar
> enforcements (or audit) with other ways to define a domain (e.g. cgroups
> [3], or system-wide securityfs as done in KRSI). Indeed, the only part
> tied to this scoped enforcement is in the domain_syscall.c file. A new
> file domain_fs.c could be added to implement a securityfs for a
> system-wide enforcement (and have other features as KRSI does).
> 

Given the current way landlock exposes LSM hooks, I don't think it's
possible to build system-wide detections. But let’s try to come to a
consensus on the semantics of the how the LSM hooks are exposed to
BPF. At the moment I think we should:


* Bring the core interface exposed to eBPF closer to the LSM surface in
  a way that supports both use cases. One way Landlock can still provide
  a more abstract interface is by providing some BPF helper libraries
  that build on top of the core framework.

* Use a single BPF program type; this is necessary for a key requirement
  of KRSI, i.e. runtime instrumentation. The upcoming prototype should
  illustrate how this works for KRSI - note that it’s possible to vary
  the context types exposed by different hooks.


It would be nice to get the BPF maintainers’ opinion on these points.


> [3] https://lore.kernel.org/lkml/20160914072415.26021-17-mic@digikod.net/
> 
> One possible important difference between Landlock and KRSI right now is
> the BPF program management. Both manage a list of programs per hook.
> However KRSI needs to be able to replace a program in these lists. This
> is not implemented in this Landlock patch series, first because it is
> not the main use-case and it is safer to have an append-only way to add
> restrictions (cf. seccomp-bpf model), and second because it is simpler
> to deal with immutable lists. However, it is worth considering extending
> the Landlock domain management with the ability to update the program
> lists. One challenge may be to identify which program should be replaced
> (which KRSI does with the program name). I think it would be wiser to
> implement this in a second step though, maybe not for the syscall
> interface (thanks to a new seccomp operation), but first with the
> securityfs one.
> 
> 
> > 
> > We've been successfully able to prototype the use cases for KRSI
> > (privileged MAC and Audit) using this "eBPF+LSM" and shared our
> > approach at the Linux Security Summit [1]:
> > 
> > * Use the new in-kernel BTF (CO-RE eBPF programs) [2] and the ability
> >   of the BPF verifier to use the BTF information for access validation
> >   to provide a more generic way to attach to the various LSM hooks.
> >   This potentially saves a lot of redundant work:
> > 
> >    - Creation of new program types.
> >    - Multiple types of contexts (or a single context with Unions).
> >    - Changes to the verifier and creation of new BPF argument types 
> >      (eg. PTR_TO_TASK)
> 
> As I understood from the LSS talk, KRSI's approach is to use the same
> hooks as LSM (cf. the securityfs). As said Alexei [4] "It must not make
> LSM hooks into stable ABI".  Moveover, the LSM hooks may change
> according to internal kernel evolution, and their semantic may not make

I think you misunderstand Alexei here. I will let him elaborate.

> sense from a user space point of view. This is one reason for which
> Lanlock abstract those hooks into something that is simpler and designed
> to fit well with eBPF (program contexts and their attached types, as
> explained in the documentation).
> 
> [4]
> https://lore.kernel.org/lkml/20191105215453.szhdkrvuekwfz6le@ast-mbp.dhcp.thefacebook.com/
> 
> How does KRSI plan to deal with one LSM hook being split in two hooks in
> a next version of the kernel (cf. [5])?

How often has that happened in the past? And even if it does happen,
it can still be handled as a part of the base framework we are trying
to implement.

> 
> [5] https://lore.kernel.org/lkml/20190910115527.5235-6-kpsingh@chromium.org/
> 
> 
> Another reason to have multiple different attach types/contexts (cf.
> landlock_domain->programs[]) is to limit useless BPF program
> interpretation (in addition to the non-system-wide scoped of programs).
>  It also enables to handle and verify strict context use (which is also
> explain in the Guiding principles). It would be a huge wast of time to
> run every BPF programs for all LSM hooks. KRSI does the same but instead
> of relying on the program type it rely on the list tied to the
> securityfs file.
> 
> BTF is great, but as far as I know, it's goal is to easily deal with the
> moving kernel ABI (e.g. task_struct layout, config/constant variables),
> and it is definitely useful to programs using bpf_probe_read() and
> similar accessors. However, I don't see how KRSI would avoid BPF types
> thanks to BTF.
> 

This should become clearer once we post our updated patch-set. Do note
that I am currently traveling and will be away for the next couple of
weeks.

> There is only one program type for Landlock (i.e.
> BPF_PROG_TYPE_LANDLOCK_HOOK), and I don't see why adding new program
> *attach* types (e.g. BPF_LANDLOCK_PTRACE) may be an issue. The kernel
> will still need to be modified to implement new hooks and the new BPF
> helpers anyway, BTF will not change that, except maybe if the internal
> LSM API is exposed in a way or another to BPF (thanks to BTF), which
> does not seem acceptable. Am I missing something?
> 
> 
> The current KRSI approach is to allow a common set of helpers to be
> called by all programs (because there is no way to differentiate them
> with their type).
> How KRSI would deal with kernel objects other than the current task
> (e.g. a ptrace hook with a tracer and a tracee, a file open/read) with
> the struct krsi_ctx unions [6]?
> 
> [6] https://lore.kernel.org/lkml/20190910115527.5235-7-kpsingh@chromium.org/
> 

The best part of BTF is that it can provide a common way to pass
different contexts to the various attachments points and the verifier
can use the BTF information to validate accesses which essentially
allows us to change the helpers from:

       is_running_executable(magical_krsi_ctx)

          to

       is_running_executable(inode)


which can work on any inode (ARG_PTR_TO_BTF_ID = btf_id(struct inode))

This makes the helpers much more useful and generic. All this is
better explained in our upcoming patch-set.

> 
> How does KRSI plan to deal with security blobs?

The new prototype uses security blobs but does not expose them to
user-space. These blobs are then used in various helpers like
“is_running_executable” which uses blobs on the inode and the
task_struct. This should become clearer when the next patchset is
posted.

I don’t think it’s currently possible to allow the blobs to be set
using eBPF programs with the main reason being that the blob will only
be set after the program is loaded. The answer to
“is_running_executable” becomes dependent on whether the file was
executed before the blob setting eBPF program was loaded.

Blob management with eBPF is not possible unless we can load eBPF
programs that can set blobs at boot-time.
In short, the next KRSI version will not give eBPF
programs access to arbitrarily write security blobs.

> 
> 
> > 
> > * These new BPF features also alleviate the original concerns that we
> >   raised when initially proposing KRSI and designing for precise BPF
> >   helpers. We have some patches coming up which incorporate these new
> >   changes and will be sharing something on the mailing list after some
> >   cleanup.
> > 
> > We can use the common "eBPF+LSM" for both privileged MAC and Audit and
> > unprivileged sandboxing i.e. Discretionary Access Control.
> > Here's what it could look like:
> > 
> > * Common infrastructure allows attachment to all hooks which works well
> >   for privileged MAC and Audit. This could be extended to provide
> >   another attachment type for unprivileged DAC, which can restrict the
> >   hooks that can be attached to, and also the information that is
> >   exposed to the eBPF programs which is something that Landlock could
> >   build.
> 
> I agree that the "privileged-only" hooks should be a superset of the
> "security-safe-and-potentially-unprivileged" hooks. :)
> However, as said previously, I'm convinced it is a requirement to have
> abstract hooks (and associated program attach types) as defined by Landlock.

I would like to hear the BPF maintainers’ perspective on this. I am
not sure they agree with you here.

- KP Singh

> 
> I'm not sure what you mean by "the information that is exposed to the
> eBPF program". Is it the current Landlock implementation of specific
> contexts and attach types?
> 
> > 
> > * This attachment could use the proposed landlock domains and attach to
> >   the task_struct providing the discretionary access control semantics.
> 
> Not task_struct but creds, yes. This is a characteristic of sandboxing,
> which may not be useful for the KRSI use case. It makes sense for KRSI
> to attach program sets (or Landlock domains) to the whole system, then
> using the creds does not make sense here. This difference is small and a
> previous version of Landlock already validated this use case with
> cgroups [3] (which is postponed to simplify the patch series).
> 
> [3] https://lore.kernel.org/lkml/20160914072415.26021-17-mic@digikod.net/
> 
> 
> > 
> > [1] https://static.sched.com/hosted_files/lsseu2019/a2/Kernel%20Runtime%20Security%20Instrumentation.pdf
> > [2] http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf
> > 
> > - KP Singh
> 
> I think it should be OK to first land something close to this Landlock
> patch series and then we could extend the domain management features and
> add the securityfs support that KRSI needs. The main concern seems to be
> about hook definitions.
> 
> Another approach would be to land Landlock and KRSI as distinct LSM
> while trying as much as possible to mutualize code/helpers.
