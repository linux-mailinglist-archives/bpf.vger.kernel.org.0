Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B11428F3
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2020 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATLLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jan 2020 06:11:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgATLLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jan 2020 06:11:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so29135807wrq.0
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w9F1hoP3S1ul32+hBujttlabOR6HK4x53W1VGK8wrSU=;
        b=Xfor+QLEzkc7JxvtxHrkCkYyXIHXZZ878bSUru2o13cPR264WG8kc20BBcEe7PfaM5
         xAo+aZTyCrCkedBjrRj8qmQQ3x9/jQ3D2yULbuxwtT0OoFe86wHJpBMIB63N0CwaRSU4
         0A/TPeCcu5lviJwxXP7wn91TsBZ1kBs1kDMt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9F1hoP3S1ul32+hBujttlabOR6HK4x53W1VGK8wrSU=;
        b=Cam/jGmeWSjQ/0sYElThLhJ6CTTt3asL/uhaHWORBOJU7/q7uuv0sndLhhCLnFxzZZ
         85gnJcLjgXoBkIXCMyH8c7YSqTf4bWuSv5O7W98JESkxoftc5GcH47cVHLC+QTdnfZJ8
         L6hSEecRVti5mj+c3+L3l4bKOmURLci0n92DQUq70KFZilfifrqDD12PffFjgqZwHYoD
         vl7t6ABACzP59Pfpqiw57dtUDF4DKSP1XzDM9nCpgADVU3CRrFXhW6FrYorSDQo+YjDw
         buPxm3CyfC+QW07R7alCzmlyfVSznrh3Grhc3wu2i0CYJOOOD4MHb+l+eICtWb7WPnH9
         tOrQ==
X-Gm-Message-State: APjAAAWJFyXYukE59VEgQP1oivdmLHhiMxWiuUuuLuzbAre6M8O8+lPQ
        P+Attdjhi7cOv74ZNqnNQLd5MA==
X-Google-Smtp-Source: APXvYqxPcnRjxSWbpsvsgEJAom/kFNoYJ7Nh8oruEeCyG9G10bZw8E7DhFfAOqWPd6ploF8uHuv3Ig==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr17513193wrm.248.1579518712627;
        Mon, 20 Jan 2020 03:11:52 -0800 (PST)
Received: from chromium.org ([2620:0:105f:fd00:24a7:c82b:86d8:5ae9])
        by smtp.gmail.com with ESMTPSA id w17sm47163506wrt.89.2020.01.20.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:11:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 20 Jan 2020 12:12:14 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 00/10] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200120111214.GC26394@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <CAEf4BzbCT8_LvgyeOtfjx7tm+Q41iGEmjvHwSkR=aBoBs3xVZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbCT8_LvgyeOtfjx7tm+Q41iGEmjvHwSkR=aBoBs3xVZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15-Jan 14:12, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2020 at 9:15 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > # Changes since v1 (https://lore.kernel.org/bpf/20191220154208.15895-1-kpsingh@chromium.org/):
> >
> > * Eliminate the requirement to maintain LSM hooks separately in
> >   security/bpf/hooks.h Use BPF trampolines to dynamically allocate
> >   security hooks
> > * Drop the use of securityfs as bpftool provides the required
> >   introspection capabilities.  Update the tests to use the bpf_skeleton
> >   and global variables
> > * Use O_CLOEXEC anonymous fds to represent BPF attachment in line with
> >   the other BPF programs with the possibility to use bpf program pinning
> >   in the future to provide "permanent attachment".
> > * Drop the logic based on prog names for handling re-attachment.
> > * Drop bpf_lsm_event_output from this series and send it as a separate
> >   patch.
> >
> > # Motivation
> >
> > Google does analysis of rich runtime security data to detect and thwart
> > threats in real-time. Currently, this is done in custom kernel modules
> > but we would like to replace this with something that's upstream and
> > useful to others.
> >
> > The current kernel infrastructure for providing telemetry (Audit, Perf
> > etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
> > information provided by audit requires kernel changes to audit, its
> > policy language and user-space components. Furthermore, building a MAC
> > policy based on the newly added telemetry data requires changes to
> > various LSMs and their respective policy languages.
> >
> > This patchset proposes a new stackable and privileged LSM which allows
> > the LSM hooks to be implemented using eBPF. This facilitates a unified
> > and dynamic (not requiring re-compilation of the kernel) audit and MAC
> > policy.
> >
> > # Why an LSM?
> >
> > Linux Security Modules target security behaviours rather than the
> > kernel's API. For example, it's easy to miss out a newly added system
> > call for executing processes (eg. execve, execveat etc.) but the LSM
> > framework ensures that all process executions trigger the relevant hooks
> > irrespective of how the process was executed.
> >
> > Allowing users to implement LSM hooks at runtime also benefits the LSM
> > eco-system by enabling a quick feedback loop from the security community
> > about the kind of behaviours that the LSM Framework should be targeting.
> >
> > # How does it work?
> >
> > The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> > program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
> > Attachment requires CAP_SYS_ADMIN for loading eBPF programs and
> > CAP_MAC_ADMIN for modifying MAC policies.
> >
> > The eBPF programs are attached to a separate security_hook_heads
> > maintained by the BPF LSM for mutable hooks and executed after all the
> > statically defined hooks (i.e. the ones declared by SELinux, AppArmor,
> > Smack etc). This also ensures that statically defined LSM hooks retain
> > the behaviour of "being read-only after init", i.e. __lsm_ro_after_init.
> >
> > Upon attachment, a security hook is dynamically allocated with
> > arch_bpf_prepare_trampoline which generates code to handle the
> > conversion from the signature of the hook to the BPF context and allows
> > the JIT'ed BPF program to be called as a C function with the same
> > arguments as the LSM hooks. If any of the attached eBPF programs returns
> > an error (like ENOPERM), the behaviour represented by the hook is
> > denied.
> >
> > Audit logs can be written using a format chosen by the eBPF program to
> > the perf events buffer or to global eBPF variables or maps and can be
> > further processed in user-space.
> >
> > # BTF Based Design
> >
> > The current design uses BTF
> > (https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html,
> > https://lwn.net/Articles/803258/) which allows verifiable read-only
> > structure accesses by field names rather than fixed offsets. This allows
> > accessing the hook parameters using a dynamically created context which
> > provides a certain degree of ABI stability:
> >
> >
> > // Only declare the structure and fields intended to be used
> > // in the program
> > struct vm_area_struct {
> >         unsigned long vm_start;
> > } __attribute__((preserve_access_index));
> >
> 
> It would be nice to also mention that you don't even have to
> "re-define" these structs if you use vmlinux.h generated with `bpftool
> btf dump file <path-to-vm-linux-or-/sys/kernel/btf/vmlinux> format c`.
> Its output will contain all types of the kernel, including internal
> ones not exposed through any public headers. And it will also
> automatically have __attribute__((preserve_access_index)) applied to
> all structs/unions. It can be pre-generated and checked in somewhere
> along the application or generated on the fly, if environment and use
> case allows.

Cool, I will update the documentation to mention this. Thanks!

- KP

> 
> > // Declare the eBPF program mprotect_audit which attaches to
> > // to the file_mprotect LSM hook and accepts three arguments.
> > SEC("lsm/file_mprotect")
> > int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> >              unsigned long reqprot, unsigned long prot)
> > {
> >         unsigned long vm_start = vma->vm_start;
> >
> >         return 0;
> > }
> >
> > By relocating field offsets, BTF makes a large portion of kernel data
> > structures readily accessible across kernel versions without requiring a
> > large corpus of BPF helper functions and requiring recompilation with
> > every kernel version. The BTF type information is also used by the BPF
> > verifier to validate memory accesses within the BPF program and also
> > prevents arbitrary writes to the kernel memory.
> >
> > The limitations of BTF compatibility are described in BPF Co-Re
> > (http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf, i.e. field
> > renames, #defines and changes to the signature of LSM hooks).
> >
> > This design imposes that the MAC policy (eBPF programs) be updated when
> > the inspected kernel structures change outside of BTF compatibility
> > guarantees. In practice, this is only required when a structure field
> > used by a current policy is removed (or renamed) or when the used LSM
> > hooks change. We expect the maintenance cost of these changes to be
> > acceptable as compared to the previous design
> > (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).
> >
> 
> [...]
