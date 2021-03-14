Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8F33A57C
	for <lists+bpf@lfdr.de>; Sun, 14 Mar 2021 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhCNPlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhCNPkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B5C061574
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 08:40:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mj10so62155239ejb.5
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=eAolkeVAs6twIMfafNH4ooYxcEspAkSAgExip2r7Rmw=;
        b=Ws7GSog+4OxW7JzMuyvzwhtMdBiCU3s8ROave78XvbeMb8OfvRMKYhPGMtZuom83Rz
         wZyKvpt37g+WFd3OlY3mb3sR5Cg9ZvnPqTUq+cMeuOuxqQ3/OwhnGJl4UvsT3Qp2KGEE
         5oNzHm3i68z5vpPU6bK8vrb0cQ7WMIb4pOLVeYAIzr/qDd3Y7iKp6MMxuEbH9Op0aa4U
         wOUjEvYh3+nSGdLaCSgJ0CdIUw5U9ZVCIXcDfT4PeO2j7VtMP1o2bGqw0VMucPM2y9kS
         GBU5NjDUXUX+blFZQzElbFdF1lJv6B80tNV7sDvVjVzvM8Uy49I48KvnFz6RASB1CUh5
         P9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=eAolkeVAs6twIMfafNH4ooYxcEspAkSAgExip2r7Rmw=;
        b=Dzz5Y0azaxFxxqMhl6z0nU0O717jEb+ZIUecYCiRi+5MWUdM+EPsRpFV1AG3vsO6aa
         ODXnd+JbHZShxbkpeoAfmnjHRPl3OhvgQAp3iYurNMpA3piqN43D2DXFwsDvdphhxWL9
         Og5Aybo6c0vWe2N0GNkkeob3uKBjaEaGoD3S95XfAod6G/fz6XR8J4wlQivEjftX+2DE
         vUMhhc+fGCKgkHGlp4QTDB07krgghaOF2QpKUnFGHGrTGxVONjHnzdwP23Cgqf7okgNf
         fTfa/02GYhi9XFo5KUKWShKXBktWpgnggsLiPi+TZQRTg1BzlLa49m7oJtrLwgemkTS5
         h3mQ==
X-Gm-Message-State: AOAM530L+s9VCyIDY/2AIItaie8thHkN9yqVcn8WxT7ofJkiVpjtiuCF
        FRemW8mMB1Yk1RraQok1kUUZ0RX47KYGfgMQ+YFUudHPlzvAcA==
X-Google-Smtp-Source: ABdhPJzpn8lTbKpkRZtTbYcZcaI/80RNMHLzuIOVoCLWLADbXucfcO2r5gAdXPwiCpCjshcL2AtUCTrf0Su5F+maKDI=
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr19515434ejb.39.1615736431045;
 Sun, 14 Mar 2021 08:40:31 -0700 (PDT)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Sun, 14 Mar 2021 17:39:55 +0200
Message-ID: <CANaYP3GTwpRMNrLNLLvOyaVzU6UiV-h2Ji=JwWeOJq4NBiJ_Bg@mail.gmail.com>
Subject: libbpf pinning strategies - towards v1
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As libbpf is heading towards a first major release, we wanted to
discuss libbpf's object pinning strategy.

bpf object pinning has a couple of use cases (feel free to add, there
are more for sure):
1. Sharing specific bpf objects between different processes (for
example, one process loads a bpf skeleton, another one interacts with
it using various bpf maps (for example, for changing configurations
(i.e. dynamic networking rules etc))
2. Preventing bpf objects from destruction upon owning process exit
(i.e. to prevent bpf progs detach upon userspace program crash)

Regarding the first use case, for most cases manually setting the pin
path (both in the loading process and in other processes) will
probably be the best. In such cases, no redesign is required here.

For the second one, something like the bpf_object__pin will be more
appropriate (to allow a complete reuse of the bpf objects). For that
use case, some sensible requirements we can consider are:

1. Paths should be unique:
    a. at the bpf_object level (that is, same pinnable objects that
belong to different bpf_object s should be pinned at different paths).
    b. in the same bpf_object, between different pinnable object types
(i.e. a map and a prog) should always be pinned at different paths.
    c. different objects, belonging to the same bpf_object and of the
same type should be pinned at different paths.
2. Paths should be predictable, given enough information on the
originating bpf_object (that is, adding random UID to ensure
uniqueness is not an option).

All the above should be applied to auto-pinned maps and the
bpf_object__pin function. I am not sure if the
bpf_object__pin_{maps,programs} should conform to those requirements
too. Of course, all paths should be overridable similarly to the
current implementation.

Regarding implementation, 1.c. will already be satisfied by the
current implementation (after the program name pinning path will be
changed, since both map names and function names are unique inside a
single object).
For 1.a and 1.b, I think that bpf_object__pin should produce the
following directory layout:

<obj_name>
=E2=94=9C=E2=94=80=E2=94=80 maps
=E2=94=82      =E2=94=94=E2=94=80=E2=94=80 <map_name>
=E2=94=94=E2=94=80=E2=94=80 programs
        =E2=94=94=E2=94=80=E2=94=80 <program_name>

If we decide that the requirements should apply to the specific
bpf_object__pin_<type>s variants, then each will produce

<obj_name>
=E2=94=94=E2=94=80=E2=94=80 <type>s (i.e. maps, programs)
        =E2=94=94=E2=94=80=E2=94=80 <name>

It may be better to put all pinned objects under a objects/ directory
too, I am not sure about that.

As a last point, I think that it will be nice to have a way to pin a
bpf_object_skeleton. This will be an improvement over the current
bpf_object__pin since skeletons keep track of attached links.

There are more use cases I am not familiar with for sure, so I would
like to hear other's opinions and comments.
