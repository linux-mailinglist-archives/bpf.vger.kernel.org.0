Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E717117284B
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgB0TEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 14:04:32 -0500
Received: from wind.enjellic.com ([76.10.64.91]:58486 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgB0TEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 14:04:31 -0500
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 14:04:31 EST
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 01RIf1sj026858;
        Thu, 27 Feb 2020 12:41:01 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 01RIewJG026857;
        Thu, 27 Feb 2020 12:40:58 -0600
Date:   Thu, 27 Feb 2020 12:40:58 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200227184058.GA25392@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 27 Feb 2020 12:41:01 -0600 (CST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 06:52:42PM +0100, KP Singh wrote:

Good morning, I hope the week is going well for everyone.

Apologies for being somewhat late with these comments, I've been
recovering from travel.

> # Motivation
> 
> Google does analysis of rich runtime security data to detect and thwart
> threats in real-time. Currently, this is done in custom kernel modules
> but we would like to replace this with something that's upstream and
> useful to others.
> 
> The current kernel infrastructure for providing telemetry (Audit, Perf
> etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
> information provided by audit requires kernel changes to audit, its
> policy language and user-space components. Furthermore, building a MAC
> policy based on the newly added telemetry data requires changes to
> various LSMs and their respective policy languages.
> 
> This patchset allows BPF programs to be attached to LSM hooks This
> facilitates a unified and dynamic (not requiring re-compilation of the
> kernel) audit and MAC policy.
> 
> # Why an LSM?
> 
> Linux Security Modules target security behaviours rather than the
> kernel's API. For example, it's easy to miss out a newly added system
> call for executing processes (eg. execve, execveat etc.) but the LSM
> framework ensures that all process executions trigger the relevant hooks
> irrespective of how the process was executed.
> 
> Allowing users to implement LSM hooks at runtime also benefits the LSM
> eco-system by enabling a quick feedback loop from the security community
> about the kind of behaviours that the LSM Framework should be targeting.

On the remote possibility that our practical experiences are relevant
to this, I thought I would pitch these comments in, since I see that
LWN is covering the issues and sensitivities surrounding BPF based
'intelligent' LSM hooks, if I can take the liberty of referring to
them as that.

We namespaced a modified version of the Linux IMA implementation in
order to provide a mechanism for deterministic system modeling, in
order to support autonomously self defensive platforms for
IOT/INED/SCADA type applications.  Big picture, the objective was to
provide 'dynamic intelligence' for LSM decisions, presumably an
objective similar to the KRSI initiative.

Our IMA implementation, if you can still call it that, pushes
actor/subject interaction identities up into an SGX enclave that runs
a modeling engine that makes decisions on whether or not a process is
engaging in activity inconsistent with a behavioral map defined by the
platform or container developer.  If the behavior is extra-dimensional
(untrusted), the enclave, via an OCALL, sets the value of a 'bad
actor' variable in the task control structure that is used to indicate
that the context of execution has questionable trust status.

We paired this with a very simple LSM that has each hook check a bit
position in the bad actor variable/bitfield to determine whether or
not the hook should operate on the requested action.  Separate LSM
infrastructure is provided that specifies whether or not the behavior
should be EPERM'ed or logged.  An LSM using this infrastructure also
has the ability, if triggered by the trust status of the context of
execution, to make further assessments based on what information is
supplied via the hook itself.

Our field experience and testing has suggested that this architecture
has considerable utility.

In this model, numerous and disparate sections of the kernel can have
input into the trust status of a context of execution.  This
methodology would seem to be consistent with having multiple eBPF tap
points in the kernel that can make decisions on what they perceive to
be security relevant issues and if and how the behavior should be
acted upon by the LSM.

At the LSM level the costs are minimal, essentially a conditional
check for non-zero status.  Performance costs will be with the eBPF
code installed at introspection points.  At the end of the
day. security costs money, if no one is willing to pay the bill we
simply won't have secure systems, the fundamental tenant of the
inherent economic barrier to security.

Food for thought if anyone is interested.

Best wishes for a productive remainder of the week.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker
IDfusion, LLC               SGX secured infrastructure and
4206 N. 19th Ave.           autonomously self-defensive platforms.
Fargo, ND  58102
PH: 701-281-1686            EMAIL: greg@idfusion.net
------------------------------------------------------------------------------
"We have to grow some roots before we can even think about having
 any blossoms."
                                -- Terrance George Wieland
                                   Resurrection.
