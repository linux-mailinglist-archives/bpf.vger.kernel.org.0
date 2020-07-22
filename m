Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3E228D0B
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 02:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGVATn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 20:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGVATn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 20:19:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C4C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 17:19:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t131so451390iod.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAnwpjk2aTPFITxXAPilSUatuIBkbfzqgldbRY9J9y0=;
        b=oWbFuz4DeuVW4uqHT2oeLvPp/58yEXF/Z4IPgyeODpwQkGdaSIFVMNEtzLgEXy2OD2
         exxv+SFUJWJYUCWYCM+LYkIv0bv3rRkXramngQqBeCeKBU7gATY9pXYQE6aiiaLXARtN
         aW0Y/xsGPgFRQdtWbN90Ki0pxmr+FUlK0JQ03eXdq1b/N5fuaWEjyY+qxrWS2kiD71ai
         v+Q7Zj0SKn8TtxGA5GYAYPqCBwOva0H5p6zvjGyFan9wmn022YaQkMAXypyXE2q840k/
         Ma3qKgH+iHdTcg7A8qlPMvGt6E0KXwpSEo2WRTQsG+zL/2GoEvNfOBtZCj6HCqiRfhzl
         qKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAnwpjk2aTPFITxXAPilSUatuIBkbfzqgldbRY9J9y0=;
        b=ip+fH/My3/R7WmEuPvMVEMAJLlNW1hYBDEs2h0/B2X8E1kS9Xfk6t1epxFSjS4NQuw
         4Xo5qgQJHFtiWZJkBcv9HWTi0LCLMftQDVRsxnnkqVdeXMM1swvuKGtRK0p706M96jBY
         s2ZPFetjNzYWgkF2l7Ft7345mvpJa6sGJ/fPb3q380b4MVVamYRkhLAB3epgtfYUxDC1
         SGUyoUpSn43MPqtENod7MjSqiFfqmjuSlwTFCUQXFq0R3GHsDrv8A+Hrl3eqwGM5ssEs
         XnY7ZvhTTk+rCJbUV5y3XQvfhaNVswxF0gDovmHbb7rL8uRo1HNwVmeUD41t7ApOKjP3
         5hjg==
X-Gm-Message-State: AOAM532Qq9clQ9NZVLFuzrTkTE+Af/HG9+W36SYfmB/EXhm7RGPQ2+B7
        yaxKtNikemMc8lvVncm0dSCcACWUYgOY2xabOvp6xQ==
X-Google-Smtp-Source: ABdhPJzKUiay1iUG1a8m05Jr2tsYuJzedKu2iNt+Hx73Im1J42OWpt1j6xETOcOdmFdaE54GoTVBG6VL1IRNkWQeudE=
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr30594634ioh.182.1595377182576;
 Tue, 21 Jul 2020 17:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595274799.git.zhuyifei@google.com> <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp> <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
 <20200721224158.ylrgjjljlighny4f@kafai-mbp> <20200721225636.GB184844@google.com>
 <20200722000913.roxrdgomdgvy7ho4@kafai-mbp>
In-Reply-To: <20200722000913.roxrdgomdgvy7ho4@kafai-mbp>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Tue, 21 Jul 2020 19:19:31 -0500
Message-ID: <CAA-VZPk0E6nfbm6NpM7_523tvRWGPFEMEkEp-UZW+Oht3pszLQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 7:09 PM Martin KaFai Lau <kafai@fb.com> wrote:
> I think we are talking about the existing map->aux check in
> bpf_cgroup_storage_assign()?  Right, the map is dedicated for
> only one bpf prog which usually has only one expected_attach_type.
> Thus, the attach_type of the key is not really useful since it will
> always be the same.  However,  it does not mean the exposed
> attach_type (of the key) is meaningless or the value is invalid.
> The exposed value is valid.
>
> I am trying to say attach_type is still part of the key
> and exposed to userspace (e.g. in map dump) but it is sort of
> invalid after this change because I am not sure what that "0"
> means now.
>
> Also, as part of the key, it is intuitive for user to think the storage is
> unique per (cgroup, attach_type).  This uniqueness is always true now because
> of the map->aux logic and guaranteed by the verifier.  With this patch, this
> "key" intuition is gone where the kernel quietly ignore the attach_type.

Right. It is indeed non-intuitive for part of the "key" to be
completely ignored in cmp. However, what would a sane solution be
instead? I could at attach time, use the attach type to also perform
the lookup, and store the attach type as the key, if and only if the
size of the key == sizeof(struct cgroup_storage_key). This storage
will not be shared across different attach types, only across
different programs of the same attach type. The lifetime will still
bound to the (map, cgroup_bpf) pair, rather than the program, as the
implementation prior to this patch did.

YiFei Zhu
