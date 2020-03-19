Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3418C393
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCSXZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:25:08 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33308 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgCSXZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:25:08 -0400
Received: by mail-qv1-f65.google.com with SMTP id cz10so2056493qvb.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xDCuhuLfm9YoYWOlfeyY36sXFmH/iwUgla7d8KHfDF0=;
        b=lk0dT8vPheiEYjwtqv3cryTQjCnAu4RwiLhFB54sK+9oIkHL5iVTzew0To8ukyRdFS
         iDWHIgJaNPQYEO8lekxKRPq+9XKOTh6xl9TZrj0JadmxAZe6k3m23K/u443UK8WwK/SU
         12sI4yHvdAGu8ShYu9oVe5siUFf5ihGeAJBmSGIMMm3ZhNrY+22H3Oz/Tq/M6oMtsrxC
         p4vs854eXRLHqzdHIbAbGLPBs+PbyZHb9CCev0OhLB/GbWAabMCeVpHTHDmIrqnSc9ir
         W6I52DU1uyABiNrmR3/hSO/PDadv+X8ubnm42ao4eFyH+RHpQeHwR+pUU0uGYH25UNH+
         jWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xDCuhuLfm9YoYWOlfeyY36sXFmH/iwUgla7d8KHfDF0=;
        b=XwBhAn2shUkS/d4TIdiO7WgKSNpXXBIYcDQavR4aka7V4RAmkUnK0Ox9t7fdPkabKQ
         L1O7l93k3WjSdCxiry2mGIGUy4eOJ6y0ktfUfAeNIdWJLfqFQy4P+AwuIhlIKHtDpjEf
         ZHFRL+1gapxasjCJQwacTE9XAyn8zksqhTRd0jIEqSBvaUn0PfvWgXBJzFPnkMNzqCj0
         xu+azvW3wwpYpqXbeioO3EFqFLHVGMAcws2BZEJYehDgtyfFIKU/9aGCEiX0BwU157JU
         X/CarlIoq0vQrCUEi7QiNoGe9FWPvQlTHhbRmz/WBBgeo9Q7GcKl0WEGU/DvLTjT1jga
         WrUA==
X-Gm-Message-State: ANhLgQ2zwmzou7mEfmmbEErbvMowmdwXUvaEFUhtA/2dzVFIIgjbAaHo
        Iv98A9BM2Ul1QVSoHZ+qPHm0pj1I6CP49t0PuGf5WLesk9I=
X-Google-Smtp-Source: ADFU+vuc3hHY9f7sxaJL1+74EamkUSwTwU7Z/Rx3QGVOjJQiQbo0B5XE8NTQDBRyAPUtYoVSyRJkutMKYJr8rq62wfQ=
X-Received: by 2002:a0c:bd2a:: with SMTP id m42mr5691250qvg.163.1584660306598;
 Thu, 19 Mar 2020 16:25:06 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Mar 2020 16:24:55 -0700
Message-ID: <CAEf4BzZX76w6Dhkgi6HkQzgvLjoNDsSJ8zg9HQ5yirKj_PDgAw@mail.gmail.com>
Subject: [ANNOUNCEMENT] Automated multi-kernel libbpf testing
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Julia Kartseva <hex@fb.com>, osandov@fb.com,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf is the important part of the BPF ecosystem and it defines
modern ways to build and run BPF applications. As such, it=E2=80=99s crucia=
l
that it is well-tested, reliable, and seamlessly works across multiple
kernels. Until recently, the only testing that was performed were BPF
selftests, run manually by BPF maintainers against the bleeding edge
versions of kernel. As diligent as maintainers are, this setup is not
perfect, requiring a lot of manual work, and could still miss
regressions and bugs due to kernel and environment differences.
Catching regressions on old kernels was especially ominous leading to
real problems in production at Facebook.

This seemed like a problem that needed automation. We took the idea of
our internal VMTEST framework, which allows to run application
integration tests against a range of kernels to catch problems, and
applied it to open-source Github mirror [0] of libbpf. We built upon
Omar Sandoval=E2=80=99s <osandov@fb.com> initial implementation for his drg=
n
tool [1] and adapted it to libbpf needs. It saved many hours of
tinkering with generic qemu/Linux image setup! Julia Kartseva <hex@fb.com>
spent lots of time and efforts on bringing this workflow to libbpf
and making process robust and maintainable.

Now, with each change to libbpf, we=E2=80=99ll pull and compile the latest
kernel and the latest BPF selftests using libbpf with patches to be
tested. Next, a VM with that kernel will start and will run a battery
of tests (test_progs, test_verifier, and test_maps), verifying that
both libbpf and the kernel are still working as expected. Further, to
verify libbpf didn=E2=80=99t regress on older kernels, we=E2=80=99ll downlo=
ad a set of
older kernels and will perform a supported subset of tests against
each of those kernels. This gives us confidence that no matter how
bleeding-edge libbpf library you use, it will still work fine across
all kernels. Check out a typical Travis CI test run [2] to get a
better idea. You can also see an annotated list [3] of blacklisted
tests for older kernel.

# Why does this matter?

- It=E2=80=99s all about confidence when making BPF changes and about
maintaining user trust. Automated, repeatable testing on **every**
change to libbpf is crucial for allowing BPF developers to move fast
and iterate quickly, while ensuring there is no inadvertent breakage
of BPF applications. The more libbpf is integrated into critical
applications (systemd, iproute2, bpftool, BCC tools, as well as
multitude of internal apps across private companies), the more
important this becomes.

- Well-tested and maintained libbpf Github mirror (as opposed to
building from kernel sources) as a single source of truth is important
for package maintainers to ensure consistent libbpf versioning across
different Linux distributions. This results in better user experience
overall and everyone wins from this consistency.

- This is also a good base for a more general kernel testing, given
that this test setup exercises not just libbpf, but the kernel itself
as well. With a bit more automation, it is possible to proactively
apply upstream patches and test kernel changes, saving tons of BPF
maintainers time and speeding up the patch review process.

In a short time we=E2=80=99ve had this running, this setup already caught
kernel, libbpf, and selftests bugs (and undoubtedly will catch more):
- BPF trampoline assembly bug [4];
- Kprobe tests triggering bug [5];
- Test cleanup crashes [6];
- Tests flakiness [7];
- Quite a few libbpf-specific problems we=E2=80=99ve never got to track exp=
licitly...

  [0] https://github.com/libbpf/libbpf
  [1] https://github.com/osandov/drgn
  [2] https://travis-ci.org/github/libbpf/libbpf/builds/663674948
  [3] https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs=
/blacklist/BLACKLIST-5.5.0
  [4] https://lore.kernel.org/netdev/20200311003906.3643037-1-ast@kernel.or=
g/
  [5] https://patchwork.ozlabs.org/patch/1254743/
  [6] https://lore.kernel.org/netdev/20200220230546.769250-1-andriin@fb.com=
/
  [7] https://lore.kernel.org/bpf/20200314024855.ugbvrmqkfq7kao75@ast-mbp.d=
hcp.thefacebook.com/T/#ma733d8e9840d9f91ce20d1143a429aa0d6650959
