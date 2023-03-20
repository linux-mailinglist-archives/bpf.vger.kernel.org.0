Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3EF6C1B2C
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCTQUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCTQTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64717CF
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 09:10:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so1892208eda.0
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679328636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6lkGN+Hqt047ctYbCrIgeVmW8J9XBau9Xa42F0v6zQ=;
        b=goBla01jjWbhixl/0xr8n+xF7egIopYz2wEBuh+R5myUJbyF3Usjga+SC8UkBX/EMN
         qL4G2bctJPgm0nmmwZibYqqsUClYaeNTBCls0WoA8O6BX5LUSOvGNg/7O1cH/hUW8wms
         s8aXX6B42htbgxTP84nwHqR9JtFQyf48od4bFeSrp8kvAiTtrTHAqxpG4+3vYLZoUc5b
         L4VcpYulObpYMvMJU9kyhTTSEvTv+mF52CXi1sOPiWAd1C5LPegsIEhI8WSGwUEHqk2b
         Gimp146ZxQwXcPqC0HACL0ku8Qvz9JEzQcZFZY32tR4NCN8RL4uxhpdqFRSj28j36nfJ
         Oztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6lkGN+Hqt047ctYbCrIgeVmW8J9XBau9Xa42F0v6zQ=;
        b=XXH+UwZwhWuimYT0clTgwjeM7O+kfRxCVBhgg0bA3xP2kAA9KpEXcHsxL9pGbBPPe+
         NsKtCU9HdT0Id98X8s4CIdfmcLp8BlbSjsETV1Y3n+J8cKsn07a9dKaD7scWSqRCl1qL
         FxdKJQkITCDVrB4Vd1lBjqAbSuSJeJQH14QLjGx5MQzRVd//Mrbv2mkCeZ51aGoUJwiJ
         nHLNYJdtB9QX3eIRNPYsNsxOJJI2RdZ+OYH1tUZjMAx2VqIl2uDOIg2P9nnEadmEU9gi
         Fq7y3JNMBDKHluerAKA+nSM46jJ9TFF+YRR3s3h3BZpLZXOQV0MOMSIXddBg/5V27xc+
         nzTg==
X-Gm-Message-State: AO0yUKXD7jHyiR/nK6XGZF9gkXgzaR/2IOQg3AA7wtfGo3DJ9gozWUrO
        nPhLwsZCjUFhAhcAx7AyGO4GUezPjWfQBmrcmnM+Dg==
X-Google-Smtp-Source: AK7set/eJKKj1NgrLXZ6ONu2TKFteJ5U6EKGnR4hmI72ioRJ87fG1S4+5S9emnex5wwwr8mslGsXeeYEcCdKSHyzEKk=
X-Received: by 2002:a17:906:4e0c:b0:932:777a:d34b with SMTP id
 z12-20020a1709064e0c00b00932777ad34bmr4015191eju.14.1679328635941; Mon, 20
 Mar 2023 09:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
 <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net> <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
In-Reply-To: <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 20 Mar 2023 16:10:24 +0000
Message-ID: <CAN+4W8j4Xi2zNx-0QgkRDgyzLFCP+-TqX3NzD=_nuJrD44TK0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
        i@lmb.io, timo@incline.eu, alessandro.d@gmail.com,
        Dave Tucker <dave@dtucker.co.uk>,
        =?UTF-8?B?Um9iaW4gR8O2Z2dl?= <robin.goegge@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii!

This is a great idea. Preserving the end of the log is the right thing
to do, and I agree that it would've been nice to do this from the
start. Some thoughts on the approach below, based on a discussion I
had with Robin and Timo.

On Fri, Mar 17, 2023 at 11:13=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Libbpf by default uses 16MB right now, I didn't touch that part yet,
> but it might be good to reduce this size if the kernel supports this
> new behavior. Go library seems to be using 64KB, which probably would
> be adequate for a lot of cases, but yeah, maybe Go library would like
> to use slightly bigger default if rotating log behavior is supported
> by kernel?

cilium/ebpf relies on ENOSPC to figure out if the verifier log has
been truncated, and makes that information available in the API via
VerifierError.Truncated [0]. This happens so that cilium can retry the
program load with successively larger log buffers to capture the full
verifier log. The full log is very valuable to us since we don't
operate on our own infrastructure, so reproducing an error that a
customer has on our own hardware is not always straightforward.
Instead we include the full log in sysdumps. We want to preserve this
as much as possible.

Arguably 64KB might already be on the large side! The library
currently does the "execute PROG_LOAD with log disabled first, get
debug output later" trick (which libbpf also does I think?). It'd be
nice if we could right-size the buffer on the retry.

> Alternative would be to make this rotating behavior opt-in, but that
> would require active actions by multiple libraries and applications to
> actively detect support. Given the rotating behavior seems like a good
> default behavior I wish we had from the very beginning, I went for
> making it default.

Given the above, taking away ENOSPC is problematic because an old
cilium/ebpf on a new kernel doesn't know how to get the full log. I
think it's better to make this opt in, since it also makes it easier
to reason about from user space. Working with UAPI that changes
behaviour based on kernel version is harder than doing feature
probing.

I do agree that ENOSPC is not a great API however and that it doesn't
make sense for the rotated log to return it. It's a really big hammer
that doesn't actually give us a key bit of information: how big should
the buffer have been to obtain the full log. To recap, cilium/ebpf
needs to know when the log was truncated and would like to know how
big the buffer should be. How about the following:

- To avoid breaking old libs on new kernels we make the behaviour opt
in via BPF_LOG_TRUNCATE_HEAD or similar.
- We add a field log_size_full to bpf_attr for PROG_LOAD. In the
kernel we populate it with the buffer size that is required to
retrieve an untruncated log for the given flags. log_size_full must be
0 when entering the syscall.
- If BPF_LOG_TRUNCATE_HEAD is specified, we enable rotation and never
return ENOSPC.

From the user space side, we can use the API as follows:

- If errno =3D ENOSPC or log_size < log_size_full we can deduce that the
log was truncated.
- If log_size_full > 0, we can use it to right-size the log buffer and
retry only once instead of the increase-buf-size-and-retry loop.

FWIW, BTF_LOAD would benefit from the same improvements!

Best
Lorenz

0: https://pkg.go.dev/github.com/cilium/ebpf@v0.10.0/internal#VerifierError
