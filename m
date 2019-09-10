Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5AAE99F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfIJL4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:56:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfIJL4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so19627101wrd.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mo5yaJO0wDVZcxETvf9G+UGVDSKQo9wAMG0rLSLtogk=;
        b=LndjXVPEBFKf9NfnEjUH1zWqN81OMhGQKkiFSw0ZnRcuw9u6GOnMYvRHHRwD27QVbp
         FyEaRjUMQDct4sdlb9zQLV2WiEW2puaRQA6o+7u7UkrFHcJKi3rF0G5PIXSbuwnBufnY
         xdPdtLud10jXs7U6myLB4IEPfNM/vMegT12kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mo5yaJO0wDVZcxETvf9G+UGVDSKQo9wAMG0rLSLtogk=;
        b=EfTl6cV3oOjrexUdThTcXBTk+PV7LzW2kkfNFXnyG2NXjKR6QQMnfvFFWMwPhmk9CG
         q77vdQ0zV4JBGyzPazwezLBrM2c+J8yXV86WG8RUB4v7VjQodAk3n6h/gPg7VmsWQUZC
         vx5mIcQojiwtnhZMfgr/+57/c1sFhL+AieIHOTLWDQKGdmoM6cmnTjxSg4z9WFCo6iOK
         2K3AEmz3gEhsyhDjKZjPoEhQQXwwZiBcKYPDbqOrroB0jugG+Odbh8JaXPj7xzx+pOQR
         ToIWRKtwuKTK8h3Ix7awcN2p46EQ2ln+3SaJlC2kqPVKmcOHCQPWzNnj88wocglPZvOY
         RA1Q==
X-Gm-Message-State: APjAAAUULwbYBnSR65RNtlWRz/eTiPwJaozaM+g/aYlP3CvWLiThLz6+
        dhXwl5gSY74GqnKV5tOkDHKopw==
X-Google-Smtp-Source: APXvYqxcPw89DoJ6YHSuGa/7uopRoYoLj5Au52WboX0WqnHqMLiDvIJcLDkFkW4lnm/E/oOiANF4cw==
X-Received: by 2002:a5d:45c3:: with SMTP id b3mr26777502wrs.207.1568116576461;
        Tue, 10 Sep 2019 04:56:16 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:15 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
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
Subject: [RFC v1 00/14] Kernel Runtime Security Instrumentation
Date:   Tue, 10 Sep 2019 13:55:13 +0200
Message-Id: <20190910115527.5235-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# Motivation

Signaling and mitigation are two key aspects of security which go
hand-in-hand.  Signals provide the necessary context to narrow down a
malicious actor and are key to creating effective MAC policies to
mitigate/prevent the malicious actor.

One can obtain signals from the kernel by using the audit infrastructure.
System-wide MAC is done separately as a part of the LSMs (eg. SELinux,
AppArmor).

Augmenting the signal information provided by audit requires kernel
changes to audit, its policy language and user-space components.
Furthermore, building a MAC policy based on the newly added signal
requires changes to various LSMs and their own respective policy
languages.

KRSI attempts to solve this problem by providing a common policy API in
the form of security focussed eBPF helpers and a common surface for
creating dynamic (not requiring re-compilation of the kernel) MAC and
Audit policies by attaching eBPF programs to the various LSM hooks.


# Why an LSM?

Linux Security Modules target security behaviours rather than the API. For
example, it's easy to miss out a newly added system call for executing
processes (eg. execve, execveat etc.) while the LSM framework ensures that
all process executions trigger the relevant hooks irrespective of how the
process was executed.

Allowing users to attach eBPF programs to LSM hooks also benefits the LSM
eco-system by enabling feedback from the security community about the kind
of behaviours that the LSM should be targeting.


# How does it work?

NOTE: The cover letter will be assimilated into the documentation
(Documentation/security/) as a part of the patch series.

## SecurityFS Interface

KRSI hooks create a file in securityfs to which eBPF programs can be
attached.  This file maps to a single LSM hook but adds a layer of
indirection thus shielding the user-space from any changes to the
underlying hook. This includes changes like renaming of the underlying
hook or replacing the hook with another that maps better to the security
behaviour represented.

For Example:

	/sys/kernel/security/krsi/process_execution -> bprm_check_security

## eBPF Program / Helpers

In order to keep things simple for the user, KRSI intends to provide one
eBPF program type. Since, there is only one type of context for a given
eBPF program type, the members of the KRSI context are selectively
populated depending on the hook.

KRSI is conservative about the access into the context and expects users
to use the helpers as an API for getting the required information. This
helps limit the internals of the LSM exposed to the user and maintain
backward compatibility. It also allows the maintainers to update the
structure of the context without worrying about breaking user-space.

The intention is to keep the helpers precise and not depend on kernel
headers or internals strengthening the backward compatibility and
usability across a large and diverse fleet.

Precise helpers also help in tackling seemingly intractable problems. For
example, a helper to dump all environment variables is hard because the
environment variables can be 32 pages long. While a helper to only extract
certain relevant environment variables (e.g. LD_PRELOAD, HISTFILESIZE)
helps in building a more reliable and precise signal with lower overhead.

## Attachment

A privileged (CAP_SYS_ADMIN for loading / attaching eBPF programs)
user-space program opens the securityfs file and the eBPF program
(BPF_PROG_LOAD) and attaches (BPF_PROG_ATTACH) the eBPF program to the
hook.

	hook_fd = open("/sys/kernel/security/krsi/process_execution", O_RDWR) 
	prog_fd = bpf(BPF_PROG_LOAD, ...) 
	bpf(BPF_PROG_ATTACH, hook_fd, prog_fd)

There can be more than one program attached to a hook and attaching a
program with the same name replaces the existing program. The user can see
the programs attached to the hook as follows:

	cat /sys/kernel/security/krsi/process_execution 
	env_dumper
	my_auditor

## Audit / MAC Policy

The userspace controls the policy by installing eBPF programs to the LSM
hook.  If any of the attached eBPF programs return an error (-ENOPERM),
the action represented by the hook is denied.

The audit logs are written using a format chosen by the eBPF program to
the perf events buffer (using bpf_perf_event_output) and can be further
processed in user-space.


# Current Status

The RFC provides a proto-type implementation with a few helpers and a
sample program samples/bpf/krsi_kern.c that hooks into process execution
and logs specific environment variables to the perf events buffer.

The user-space program samples/bpf/krsi_user.c loads the eBPF program,
configures the environment variable that needs to be audited and listens
for perf events.


KP Singh (14):
  krsi: Add a skeleton and config options for the KRSI LSM
  krsi: Introduce types for KRSI eBPF
  bpf: krsi: sync BPF UAPI header with tools
  krsi: Add support in libbpf for BPF_PROG_TYPE_KRSI
  krsi: Initialize KRSI hooks and create files in securityfs
  krsi: Implement eBPF operations, attachment and execution
  krsi: Check for premissions on eBPF attachment
  krsi: Show attached program names in hook read handler.
  krsi: Add a helper function for bpf_perf_event_output
  krsi: Handle attachment of the same program
  krsi: Pin argument pages in bprm_check_security hook
  krsi: Add an eBPF helper function to get the value of an env variable
  krsi: Provide an example to read and log environment variables
  krsi: Pin arg pages only when needed

 MAINTAINERS                               |   8 +
 include/linux/bpf_types.h                 |   3 +
 include/linux/krsi.h                      |  19 ++
 include/uapi/linux/bpf.h                  |  44 ++-
 kernel/bpf/syscall.c                      |   7 +
 samples/bpf/.gitignore                    |   1 +
 samples/bpf/Makefile                      |   3 +
 samples/bpf/krsi_helpers.h                |  31 ++
 samples/bpf/krsi_kern.c                   |  52 ++++
 samples/bpf/krsi_user.c                   | 202 +++++++++++++
 security/Kconfig                          |   1 +
 security/Makefile                         |   2 +
 security/krsi/Kconfig                     |  22 ++
 security/krsi/Makefile                    |   3 +
 security/krsi/include/hooks.h             |  22 ++
 security/krsi/include/krsi_fs.h           |  19 ++
 security/krsi/include/krsi_init.h         | 106 +++++++
 security/krsi/krsi.c                      | 157 ++++++++++
 security/krsi/krsi_fs.c                   | 190 ++++++++++++
 security/krsi/ops.c                       | 342 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h            |  44 ++-
 tools/lib/bpf/libbpf.c                    |   4 +
 tools/lib/bpf/libbpf.h                    |   2 +
 tools/lib/bpf/libbpf.map                  |   2 +
 tools/lib/bpf/libbpf_probes.c             |   1 +
 tools/testing/selftests/bpf/bpf_helpers.h |   3 +
 26 files changed, 1288 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/krsi.h
 create mode 100644 samples/bpf/krsi_helpers.h
 create mode 100644 samples/bpf/krsi_kern.c
 create mode 100644 samples/bpf/krsi_user.c
 create mode 100644 security/krsi/Kconfig
 create mode 100644 security/krsi/Makefile
 create mode 100644 security/krsi/include/hooks.h
 create mode 100644 security/krsi/include/krsi_fs.h
 create mode 100644 security/krsi/include/krsi_init.h
 create mode 100644 security/krsi/krsi.c
 create mode 100644 security/krsi/krsi_fs.c
 create mode 100644 security/krsi/ops.c

-- 
2.20.1

