Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106E514A8C5
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0RPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 12:15:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42312 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0RPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 12:15:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so5460279pgb.9
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jIzb/j/4J41W177kdHDtOvmQT1/kIJ9hYkAS/3aA1+g=;
        b=M3xyDxtLbI4xvgdRYZSoJDBpFlSSV+nnUjQoxjL5TS8tsud7Tmo+R3LLOGPQd4RUo1
         gmyql/Izc7XCDbX1aVy8PA+byncYAh5MiYWN6xjZhhsmfsW++7LPT2g2KmprC6O3ZKs4
         1WLmSO2iKjoEkm9rNoHwiHhd4y11L72TTZceU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jIzb/j/4J41W177kdHDtOvmQT1/kIJ9hYkAS/3aA1+g=;
        b=P4qO1GAAk5iQN4d1RS6AsV/LyIoy8bxrM/xjV7Sg7hrMIBRZNYre3/mgtfNvBDNX7V
         AUNc6u7U89nFKCy+lfdhwJJFxzh3tCdCIl6ZXyMUr1mSJMmnb96mYT70WP3pbXsFiSxU
         jYJGFm9iJksdNZCKyAgLnemtLKOTvV0k6j5zBAHoOPFEfxwUYh+Qys1Gv/dtTzJzTDkl
         YXl8vBd1OIaNsUdfQkR/TQOxbnn/Cj+i+cMmVzCzaQ2eedtKpEMt58/+zGaofeFdwRSL
         E2Cyi8nIKdleDvmjB3iBB0R4pU3ky6kwsWG9lj+wRpJBVpxeavpc+BF/4f92NC9pQ4FX
         g5KA==
X-Gm-Message-State: APjAAAUsNvgpTAFXReEGkPBbV4J8c+Efu+RS+1mW9Z92Ui+DWUBTuZ+B
        4Y86TukcwCJ/jZpJpQ4Ixs/uhQ==
X-Google-Smtp-Source: APXvYqxk2QMZyJxF1GLw6Pkt90rqqFRpm8Jc0Q5FONJV/kHptTKNHbMdRWr/5HGRXkBTNf4LTc1wLA==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr20312131pgb.306.1580145323859;
        Mon, 27 Jan 2020 09:15:23 -0800 (PST)
Received: from chromium.org (8.100.247.35.bc.googleusercontent.com. [35.247.100.8])
        by smtp.gmail.com with ESMTPSA id v15sm16371542pju.15.2020.01.27.09.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 09:15:23 -0800 (PST)
Date:   Mon, 27 Jan 2020 09:15:16 -0800
From:   KP Singh <kpsingh@chromium.org>
To:     lsf-pc@lists.linux-foundation.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Thomas Garnier <thgarnie@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: [LSF/MM/BPF TOPIC] What's more in BPF+LSM (KRSI)?
Message-ID: <20200127171516.GA2710@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

What's more in BPF+LSM (KRSI)?
============================

The basics for the KRSI patches are being reviewed currently on the
mailing list:

   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#t

Here are some proposed discussions topics:

RCU/Preemption + BPF_PROG_TYPE_LSM
----------------------------------

With the new Trampoline based implementation it's ~trivial~ to enable
preemption and remove the RCU read side critical section when
executing the JIT'ed program. This is required, atleast, for the
following 2 use-cases:

1. Non-Atomic Helpers

Getting remote user pages (get_user_pages_remote) for argv and
environment variable based policies needs to run in non-atomic context
(because it might trigger a page fault).

2. BTF __rcu pointer access

Since BPF_PROG_TYPE_LSM uses BTF, it can access valid struct members.
However, if such a member is "__rcu" pointer, there are no
checks/helpers to "properly" access it.

Ideas:

 Here are a couple of options we can discuss:

* Update the JIT logic to guard helper calls with RCU critical
  sections or wrap pointer access with rcu_deference automatically
  when a BPF program calls it. This might still be restrictive if a
  user wants to use rcu_deference_raw etc for pointer values.
  It's also going to be tricky to determine the scope of the
  critical section beyond adding RCU calls before and after a helper
  call or a pointer dereference.

* Just track and verify whether the BPF program calls the right
  helpers (say bpf_rcu_*) This is likely to be more feasible and
  similar to the spin lock tracking already done by the verifier.

If sleepable BPF becomes a thing, one can dump argument pages in 4K
chunks to the perf events buffer there by saving a large amount of
memory which is currently required to "pin" these pages in a preamble
so that they are accessible in an atomic context in the program.

Security Blobs using BPF programs
---------------------------------

Security blobs must be set at init to provide any real guarantees to
any API that uses security blobs. KRSI currently plans to have static
hooks for blobs but one can think of loading a restricted set of
BPF programs purely to enable security blobs at boot time.
This would make the overall code more flexible.

Userspace eco-system
--------------------

As we bring KRSI closer to mainline, it's worth thinking of the
userspace ecosystem. e.g. can we add BPF capabilities to the likes of
auditctl and use bpftrace for KRSI programs?

- KP
