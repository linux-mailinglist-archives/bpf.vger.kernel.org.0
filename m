Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF656429462
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhJKQVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJKQVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 12:21:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB149C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 09:19:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so58114600wrg.5
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=n/kS3cJk0pcVJA+tncADE8W6k42vqiHaBpBk3cGY/Rs=;
        b=SS5ivHzRfbVvkxZEYcAU0GoNHk2zlAMrPxi8UMiT1YcSVufmAy51NKDT8egPooBjO0
         BlIXezKioAYZZiI+Le9GdenrhQFKuRAPfXRp1coxee32X30a5xGC+R2OPKzCSj7Acq75
         3JM8Wj58dcdvd1qBNsg/3Jvun93KvqjPRv4xUYYbcrr1fnKcRIBqKk3Tt3TPAEgXDBEx
         OJVA+6eXG41hBzHoKSSvXG+FUgabZy44S1fvFrZTLyAvmU3STplo9ndkJk+lyotWuPRo
         z9uj/OvigdYcYYCKwJ2h2/O+2CklhZd5h31OlIunOIItysx6DlRBIJbylYQA0T1n57V+
         IOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=n/kS3cJk0pcVJA+tncADE8W6k42vqiHaBpBk3cGY/Rs=;
        b=2BhPmejFtK7o0OKEUYn8U4hX8cOto6FVNnxgA9WY0A84Uzc3vy8NB7o4WnJe0r1xea
         wuKI/5sws1AIBLsZoiqd1uJ6ICm8lQNcECOyaZC76kT8fkQEqqgUJRyFg6hnKC2dCZ9o
         sA/mQOQKD4aoTknAmMeess0qNbFmhkwM1zIi4CdqotljabOgBXR2RznVPydHwqen3gMI
         3n2IKYHr/ClMngkXHksst6xGHPyiQMtsSgOKUErnBeIsZY1X8nEtmczYykeOdcenA/m3
         j4Bzzcb1Fk75FoaRg02K3VFQjZXci2mnk4v0r0CSnCQgCVyil4cP8V8+g/PQUVrFDDwv
         Bpmw==
X-Gm-Message-State: AOAM533N8rz9LaTlxxSN25xJLBM2+Vlx2PR4Phl2HYKevhJzSyPk3JZx
        fezHCXjd9pjY4GxmdUWwBtjA+pSukMeyA388hjCdgCA53V8=
X-Google-Smtp-Source: ABdhPJwgvNPFnkI4pR/au7DzWRoSEE3pP7E392zC/GLu3J4ScCNdQxzuHO0u2Dhap2EqAmbUBHxn1tv7YguMM90BhDA=
X-Received: by 2002:adf:9787:: with SMTP id s7mr25094223wrb.191.1633969174915;
 Mon, 11 Oct 2021 09:19:34 -0700 (PDT)
MIME-Version: 1.0
From:   Sanjit Bhat <sanjit.bhat@gmail.com>
Date:   Mon, 11 Oct 2021 11:19:23 -0500
Message-ID: <CAF7Jse9d9s0gFAi_bF3=ShE3FZw6k4X_nvDyGJkLRG7cDPDKCQ@mail.gmail.com>
Subject: [bpf-next] bpf, verifier: Automated formal verification tool for
 finding bugs in eBPF verifier range analysis routines
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, hovav@cs.utexas.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I=E2=80=99m Sanjit Bhat, a researcher at UT Austin. My advisor, Hovav Shach=
am,
and I have been working on a tool to enable developers to
automatically check the eBPF verifier=E2=80=99s range analysis routines for
bugs, to generate sample bad inputs if bugs exist, and to formally
prove that there are no range analysis bugs. We=E2=80=99re reaching out to =
get
your feedback on whether there would be interest in using our tool.

Some more details about what the tool does:

We verify the range analysis routines in the eBPF verifier. These
routines predict the output range of ALU operations on scalar
registers. They include all code touched from the
`adjust_scalar_min_max_vals` function in `verifier.c`, as well as the
functions in `tnum.c`. In the past, these routines have led to a few
CVE=E2=80=99s, e.g., CVE-2020-8835, CVE-2020-27194, and CVE-2021-3490. Our
tool, written purely in Python, translates the C range analysis code
to Z3 SMT solver inputs and verifies that the code implements a
correct range analysis pass for all 32- and 64-bit ALU operations on
scalar registers. Our tool already produces some interesting results,
described below, but we=E2=80=99re still actively working on it. We would l=
ove
your thoughts on ways we could make it more useful.

Some preliminary results:

We analyzed commit bc895e8b, which made a small change to the
`signed_sub_overflows` function from 32-bit inputs to 64-bit inputs.
Our tool found that before the commit, range analysis of 64-bit
scalar-scalar subtraction was incorrect. The tool generated a BPF
program that exploits the bug and leaves a register that has a
concrete value outside the register=E2=80=99s tracked range. After applying
the patch, the tool determined that 64-bit subtraction was now
correct. In addition to this bug, we were able to re-find bugs
exploited in prior zero-days, and we=E2=80=99ve done preliminary analysis o=
n
all verifier range analysis ops on a commit from back in May.

Please let us know if this tool sounds interesting! We would be happy
to explain it in more detail and collaborate on using it to aid eBPF
verifier development.
