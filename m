Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2856F228B03
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgGUVUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGUVUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 17:20:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622EC061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 14:20:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so23000420iob.4
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM61428LjGN588YQN36h72yArdqaAFPN4TXDMMWL2DU=;
        b=SRhZnWgt+zeVhOOY0LwsO14b9o1tCWS62FRluS6HY3JohF0ublNudUiGy0vWjBfWEO
         AteM0GyWaLC6/gN3v6sdthV9BbuoMWeHyR2JM/ONmswyATe7euH4DJM88u6Yjo3Z5r8D
         9uwoIYK5HDkzn2pviuT6AV5z98sNwKm/Q77e6pLyQAgzq0p5bMA8/1YkM4TcRmaEqmws
         rNBgIW01xxkfpO/w1DkURd58xa7V986cRNyoSeuQkmJUuGqMNT5OErVOPwX/LmMgX/8w
         ziJ43d018xHbv5d+uUjWrhtiGdu/bwKAVNITKIKAiMuRR2j4Q4XrvxiNJTpNUxDalleM
         n7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM61428LjGN588YQN36h72yArdqaAFPN4TXDMMWL2DU=;
        b=pkOVhpwfsmsWQF0gNsw94ikDthikyvuzCJCjLv0vRu5aY5/DiAjpszkc90wBD3UODl
         79f/R1O7dZIW2QWmKO2hhvPJ7rqMNmnYdL7KDFb4+uYg1r0JzDTzeG5OwZIvCR/Z28xF
         mbZK8PR5TcBkADyHy1lboJHkCJb6kyePYAwW7BqoJN02iO9iuGgWy3ifiDt/zFHPGgus
         Plb/cFzzbkxxAn/+TDqSskTGaKvkBdb1XTEeomseBoJtqyKmsjf8Z71NpYRAK/VQSB6X
         ztgFvW3JnDoVbXnCl3g6eKByifshXOumqiD2MhYdjjOykCbr57G1eGRbMqRIl9+SssEy
         J3PQ==
X-Gm-Message-State: AOAM530PItKzFQHpigxuldASvhuKiMpg3TYgWB9YjJ1Cu5pGhtgxmSfS
        9144CtSRNhZAJUzR7LpqifQHBrDSUQ84XjmElQz64w==
X-Google-Smtp-Source: ABdhPJzVICytkjRuF/BmzFgFPw4udyu/0FGwiC+EuPXQqd1/n0JstO9a1XY5Lyi4ggPttafmXBQU5qdqheb/RJYr89U=
X-Received: by 2002:a5d:9752:: with SMTP id c18mr30150553ioo.10.1595366411002;
 Tue, 21 Jul 2020 14:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595274799.git.zhuyifei@google.com> <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp>
In-Reply-To: <20200721180536.57kbngehupi4hqra@kafai-mbp>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Tue, 21 Jul 2020 16:20:00 -0500
Message-ID: <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> I quickly checked zero is actually BPF_CGROUP_INET_INGRESS instead
> of UNSPEC for attach_type.  It will be confusing on the syscall
> side. e.g. map dumping with key.attach_type == BPF_CGROUP_INET_INGRESS
> while the only cgroup program is actually attaching to BPF_CGROUP_INET_EGRESS.
>
> I don't have a clean way out for this.  Adding a non-zero UNSPEC
> to "enum bpf_attach_type" seems wrong also.
> One possible way out is to allow the bpf_cgroup_storage_map
> to have a smaller key size (i.e. allow both sizeof(cgroup_inode_id)
> and the existing sizeof(struct bpf_cgroup_storage_key).  That
> will completely remove attach_type from the picture if the user
> specified to use sizeof(cgroup_inode_id) as the key_size.
> If sizeof(struct bpf_cgroup_storage_key) is specified, the attach_type
> is still used in cmp().
>
> The bpf_cgroup_storage_key_cmp() need to do cmp accordingly.
> Same changes is needed to lookup_elem, delete_elem, check_btf, map_alloc...etc.

ACK. Considering that the cgroup_inode_id is the first field of struct
bpf_cgroup_storage_key, I can probably just use this fact and directly
use the user-provided map key (after it's copied to kernel space) and
cast the pointer to a __u64 - or are there any architectures where the
first field is not at offset zero? If this is done then we can change
all the kernel internal APIs to use __u64 cgroup_inode_id, ignoring
the existence of the struct aside from the map creation (size checking
and BTF checking).


> > +#include "../cgroup/cgroup-internal.h"
> Why?

cgroup_mutex is declared in this header.

YiFei Zhu
