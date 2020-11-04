Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2D2A700C
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgKDV7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 16:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728416AbgKDV5R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 16:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604527034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xLd9UIzjawre+4pDsoByOIIICry9R8qSsVwWyLpC9EE=;
        b=JHF7WZzWvV4DAbSDDbivY4HZ18ou+C+DVZOGRlHPwt0fyj2MH2xsi3UOAVN8EwnUW8bU/s
        Q8g9CeZvVVPaNMF3NVUBnvjv+ucdliggR0svFrpqNFxPr1GEDEMKywZWPOvvq6fcFn7Frm
        YclhVOSVPkgTCsNTMzvCaMcFZttU/Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-tl20Fq8cNliFsTh3atdMzA-1; Wed, 04 Nov 2020 16:57:11 -0500
X-MC-Unique: tl20Fq8cNliFsTh3atdMzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3C51803652;
        Wed,  4 Nov 2020 21:57:06 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59A125578B;
        Wed,  4 Nov 2020 21:57:03 +0000 (UTC)
Date:   Wed, 4 Nov 2020 16:57:02 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: RFC: default to spec_store_bypass_disable=prctl spectre_v2_user=prctl
Message-ID: <20201104215702.GG24993@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

[ Given the CC list and your mention of spectre_v2_user=prctl is spot
  on to show the badness... I spawned a new thread to suggest another
  thing related to seccomp that I've been intending to suggest for
  a while ]

On Tue, Nov 03, 2020 at 04:29:38PM -0800, Kees Cook wrote:
> I assume this is from Indirect Branch Prediction Barrier (IBPB) and
> Single Threaded Indirect Branch Prediction (STIBP) (which get enabled
> for threads under seccomp by default).
> 
> Try booting with "spectre_v2_user=prctl"

We need to change the kernel default to
"spec_store_bypass_disable=prctl spectre_v2_user=prctl".

I've been recommending to everyone to use
"spec_store_bypass_disable=prctl spectre_v2_user=prctl" for a while
now. I already recommend to Yifei too a few months ago when he first
found out of the huge seccomp regression when he upgraded his codebase
to the upstream kernel with both STIBP/SSBD enabled in seccomp jails.

Here's below a tentative RFC, the code is actually trivial, if you
could help reviewing/improving the commit header it would be great.

Thanks,
Andrea

From 3f7adb783262dc7f4e71cdbf07b4ef9f6b8d3ed9 Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Wed, 4 Nov 2020 15:20:33 -0500
Subject: [PATCH 1/1] x86: change default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl

Switch the kernel default of SSBD and STIBP to the ones with
CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.

Several motivations listed below:

- If SMT is enabled the seccomp jail can still attack the rest of the
  system even with spectre_v2_user=seccomp by using MDS-HT (except on
  XEON PHI where MDS can be tamed with SMT left enabled, but that's a
  special case). Setting STIBP become a very expensive window dressing
  after MDS-HT was discovered.

- The seccomp jail cannot attack the kernel with spectre-v2-HT
  regardless (even if STIBP is not set), but with MDS-HT the seccomp
  jail can attack the kernel too.

- With spec_store_bypass_disable=prctl the seccomp jail can attack the
  other userland (guest or host mode) using spectre-v2-HT, but the
  userland attack is already mitigated by both ASLR and pid namespaces
  for host userland and through virt isolation with libkrun or
  kata. (if something if somebody is worried about spectre-v2-HT it's
  best to mount proc with hidepid=2,gid=proc on workstations where not
  all apps may run under container runtimes, rather than slowing down
  all seccomp jails, but the best is to add pid namespaces to the
  seccomp jail). As opposed MDS-HT is not mitigated and the seccomp
  jail can still attack all other host and guest userland if SMT is
  enabled even with spec_store_bypass_disable=seccomp.

- If full security is required then MDS-HT must also be mitigated with
  nosmt and then spectre_v2_user=prctl and spectre_v2_user=seccomp
  would become identical.

- Setting spectre_v2_user=seccomp is overall lower priority than to
  setting javascript.options.wasm false in about:config to protect
  against remote wasm MDS-HT, instead of worrying about Spectre-v2-HT
  and STIBP which again is already statistically well mitigated by
  other means in userland and it's fully mitigated in kernel with
  retpolines (unlike the wasm assist call with MDS-HT).

- SSBD is needed to prevent reading the JIT memory and the primary
  user being the OpenJDK. However the primary user of SSBD wouldn't be
  covered by spec_store_bypass_disable=seccomp because it doesn't use
  seccomp and the primary user also explicitly declined to set
  PR_SET_SPECULATION_CTRL+PR_SPEC_STORE_BYPASS despite it easily
  could. In fact it would need to set it only when the sandboxing
  mechanism is enabled for javaws applets, but it still declined it by
  declaring security within the same user address space as an
  untenable objective for their JIT, even in the sandboxing case where
  performance would be a lesser concern (for the record: I kind of
  disagree in not setting PR_SPEC_STORE_BYPASS in the sandbox case and
  I prefer to run javaws through a wrapper that sets
  PR_SPEC_STORE_BYPASS if I need). In turn it can be inferred that
  even if the primary user of SSBD would use seccomp, they would
  invoke it with SECCOMP_FILTER_FLAG_SPEC_ALLOW by now.

- runc/crun already set SECCOMP_FILTER_FLAG_SPEC_ALLOW by default, k8s
  and podman have a default json seccomp allowlist that cannot be
  slowed down, so for the #1 seccomp user this change is already a
  noop.

- systemd/sshd or other apps that use seccomp, if they really need
  STIBP or SSBD, they need to explicitly set the
  PR_SET_SPECULATION_CTRL by now. The stibp/ssbd seccomp blind
  catch-all approach was done probably initially with a wishful
  thinking objective to pretend to have a peace of mind that it could
  magically fix it all. That was wishful thinking before MDS-HT was
  discovered, but after MDS-HT has been discovered it become just
  window dressing.

- For qemu "-sandbox" seccomp jail it wouldn't make sense to set STIBP
  or SSBD. SSBD doesn't help with KVM because there's no JIT (if it's
  needed with TCG it should be an opt-in with
  PR_SET_SPECULATION_CTRL+PR_SPEC_STORE_BYPASS and it shouldn't
  slowdown KVM for nothing). For qemu+KVM STIBP would be even more
  window dressing than it is for all other apps, because in the
  qemu+KVM case there's not only the MDS attack to worry about with
  SMT enabled. Even after disabling SMT, there's still a theoretical
  spectre-v2 attack possible within the same thread context from guest
  mode to host ring3 that the host kernel retpoline mitigation has no
  theoretical chance to mitigate. On some kernels a
  ibrs-always/ibrs-retpoline opt-in model is provided that will
  enabled IBRS in the qemu host ring3 userland which fixes this
  theoretical concern. Only after enabling IBRS in the host userland
  it would then make sense to proceed and worry about STIBP and an
  attack on the other host userland, but then again SMT would need to
  be disabled for full security anyway, so that would render STIBP
  again a noop.

- last but not the least: the lack of "spec_store_bypass_disable=prctl
  spectre_v2_user=prctl" means the moment a guest boots and
  sshd/systemd runs, the guest kernel will write to SPEC_CTRL MSR
  which will make the guest vmexit forever slower, forcing KVM to
  issue a very slow rdmsr instruction at every vmexit. So the end
  result is that SPEC_CTRL MSR is only available in GCE. Most other
  public cloud providers don't expose SPEC_CTRL, which means that not
  only STIBP/SSBD isn't available, but IBPB isn't available either
  (which would cause no overhead to the guest or the hypervisor
  because it's write only and requires no reading during vmexit). So
  the current default already net loss in security (missing IBPB)
  which means most public cloud providers cannot achieve a fully
  secure guest with nosmt (and nosmt is enough to fully mitigate
  MDS-HT). It also means GCE and is unfairly penalized in performance
  because it provides the option to enable full security in the guest
  as an opt-in (i.e. nosmt and IBPB). So this change will allow all
  cloud providers to expose SPEC_CTRL without incurring into any
  hypervisor slowdown and at the same time it will remove the unfair
  penalization of GCE performance for doing the right thing and it'll
  allow to get full security with nosmt with IBPB being available (and
  STIBP becoming meaningless).

Example to put things in prospective: the STIBP enabled in seccomp has
never been about protecting apps using seccomp like sshd from an
attack from a malicious userland, but to the contrary it has always
been about protecting the system from an attack from sshd, after a
successful remote network exploit against sshd. In fact initially it
wasn't obvious STIBP would work both ways (STIBP was about preventing
the task that runs with STIBP to be attacked with spectre-v2-HT, but
accidentally in the STIBP case it also prevents the attack in the
other direction). In the hypothetical case that sshd has been remotely
exploited the last concern should be STIBP being set, because it'll be
still possible to obtain info even from the kernel by using MDS if
nosmt wasn't set (and if it was set, STIBP is a noop in the first
place). As opposed kernel cannot leak anything with spectre-v2 HT
because of retpolines and the userland is mitigated by ASLR already
and ideally PID namespaces too. If something it'd be worth checking if
sshd run the seccomp thread under pid namespaces too if available in
the running kernel. SSBD also would be a noop for sshd, since sshd
uses no JIT. If sshd prefers to keep doing the STIBP window dressing
exercise, it still can even after this change of defaults by opting-in
with PR_SPEC_STORE_BYPASS.

Ultimately setting SSBD and STIBP by default for all seccomp jails is
a bad sweet spot and bad default with more cons than pros that end up
reducing security in the public cloud (by giving an huge incentive to
not expose SPEC_CTRL which would be needed to get full security with
IBPB after setting nosmt in the guest) and by excessively hurting
performance to more secure apps using seccomp that end up having to
opt out with SECCOMP_FILTER_FLAG_SPEC_ALLOW.

The following is the verified result of the new default with SMT
enabled:

(gdb) print spectre_v2_user_stibp
$1 = SPECTRE_V2_USER_PRCTL
(gdb) print spectre_v2_user_ibpb
$2 = SPECTRE_V2_USER_PRCTL
(gdb) print ssb_mode
$3 = SPEC_STORE_BYPASS_PRCTL

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 ++---
 arch/x86/kernel/cpu/bugs.c                      | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..105401a3582f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4980,8 +4980,7 @@
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
 
-			Default mitigation:
-			If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl"
+			Default mitigation: "prctl"
 
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
@@ -5025,7 +5024,7 @@
 				  will disable SSB unless they explicitly opt out.
 
 			Default mitigations:
-			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+			X86:	"prctl"
 
 			On powerpc the options are:
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db463f96..5ec39397fe9c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -721,11 +721,11 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
+	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_PRCTL:
 	case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		mode = SPECTRE_V2_USER_PRCTL;
 		break;
-	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_SECCOMP:
 	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 		if (IS_ENABLED(CONFIG_SECCOMP))
@@ -1132,7 +1132,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		return mode;
 
 	switch (cmd) {
-	case SPEC_STORE_BYPASS_CMD_AUTO:
 	case SPEC_STORE_BYPASS_CMD_SECCOMP:
 		/*
 		 * Choose prctl+seccomp as the default mode if seccomp is
@@ -1146,6 +1145,7 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
+	case SPEC_STORE_BYPASS_CMD_AUTO:
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
 		mode = SPEC_STORE_BYPASS_PRCTL;
 		break;

