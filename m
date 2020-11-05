Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49B2A8B0A
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgKEXzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:55:52 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35557 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729784AbgKEXzw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 18:55:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 799775C0109;
        Thu,  5 Nov 2020 18:55:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 18:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:subject:from
        :to:cc:date:message-id:in-reply-to; s=fm1; bh=eI4RIxMgvzb0GvIXx2
        OlXfTW0lvQgGCqO2xUtCYmnl8=; b=Cp1y5WV5v73rKJzH9WfAP8ROECQ/+OUMR6
        Qbpr+elxkMOx+gx8XDiN7MHvdURVTef14Z3AURCgkc2KB1qTHYReeSY2b1MqHPhq
        mMaPAXiqA6oWvA02uunCWPqoObxuGG9PoXz4B6j1evRHyFvIvkow+S1w4o2zEHHK
        kQr87LAvg4jU3Q0zhTGY13qQqoJew9F+hrVHqky/JDZTJ8UobegLnfTsbDgltOr/
        CiinH/SyCyCjk0HV0icXflc290LOGgShH7Z59t8s31WmdckZ1TC1oGw80VKR3Ft/
        IzpO49XzXjKuBTpAL1INCkvi53v21X9N9kr2P4T4QKcemhZpcWfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eI4RIxMgvzb0GvIXx2OlXfTW0lvQgGCqO2xUtCYmnl8=; b=lM83Mj2q
        HS8cdZwI5mJhLNnJHUMbMjXfaBhlbSQ1Xg3Q6Jc/79zOPP3zmYkBFHmicMqr1NKQ
        gqXHgfIXMgKRbZhQjuQoGOfGKt8b2EZByD57Mpm84XFJRNfI0oY7wZ6qVtGv74c8
        WRg5pF2cceTO59lJklpNMVKlXGYGmdLgmQN632opb+iBhK7dtreqdUUR+VxJ3XwU
        SvTw0RX7Q8cGOpc0Ul8gUNWvKXLDYRFol7FEaEy3aNWRMHY9VMZZOCkr5zbK8kZr
        6yJY9Ug+W+0Yq4hbzn2yKAfRHKSA8DhveUXho4VzyElM1/o3+IWQBgfYVj2DoxwE
        d+aSb/tiY8s+Sw==
X-ME-Sender: <xms:BpGkX38e8HMOJmlGKgLUCzMXP1IHs7okSt7-wownrHoBff-j4_mrSg>
    <xme:BpGkXzsyrZ-L1OdZRgmaMMHRb2_vUX42INaIHkohbHcwdYYpEaJhYhyKtHYGCdJK4
    BfDLcyXYxY5nX8qTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpegggfgtuffhvfffkfgjsehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepjeefhfdufeefhfejvdevhfehudeltdeujeevudegvdejvdej
    leejgfegtdejjeevnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:BpGkX1C9owdzwI3uL5YohnFyGJF4QNXWQGzF7jBEBm3D9Q6Ew142ew>
    <xmx:BpGkXzfncIfIQdIUgWya7dDjubt9h-zp3GuA0V5U736PqZI1XJ1AoQ>
    <xmx:BpGkX8OgxS8IkpmoVS7M0jS-wr1pZ6eAtn321z2gWesIzm6QaHRdDg>
    <xmx:B5GkX5qrqkFKEQKPcKBauZzZWZOsMkZPoAoIIRbp3UKxUZYQIVtoyQ>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D90A3280261;
        Thu,  5 Nov 2020 18:55:50 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <songliubraving@fb.com>
Cc:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        "bpf" <bpf@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>
Date:   Thu, 05 Nov 2020 15:55:40 -0800
Message-Id: <C6VQIBZJGQ3W.22AG4C72KZQLI@maharaja>
In-Reply-To: <32285B9E-976A-4357-8C97-6A394926BDFE@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 5, 2020 at 3:31 PM PST, Song Liu wrote:
>
>
> > On Nov 5, 2020, at 3:22 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
> >=20
> > On Thu Nov 5, 2020 at 1:32 PM PST, Andrii Nakryiko wrote:
> >> On Wed, Nov 4, 2020 at 8:51 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > [...]
> >>> diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_s=
tr.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> >>> new file mode 100644
> >>> index 000000000000..41c3e296566e
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> >>> @@ -0,0 +1,34 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +#include <linux/bpf.h>
> >>> +#include <bpf/bpf_helpers.h>
> >>> +#include <bpf/bpf_tracing.h>
> >>> +
> >>> +#include <sys/types.h>
> >>> +
> >>> +struct sys_enter_write_args {
> >>> +       unsigned long long pad;
> >>> +       int syscall_nr;
> >>> +       int pad1; /* 4 byte hole */
> >>=20
> >> I have a hunch that this explicit padding might break on big-endian
> >> architectures?..
> >>=20
> >> Can you instead include "vmlinux.h" in this file and use struct
> >> trace_event_raw_sys_enter? you'll just need ctx->args[2] to get that
> >> buffer pointer.
> >>=20
> >> Alternatively, and it's probably simpler overall would be to just
> >> provide user-space pointer through global variable:
> >>=20
> >> void *user_ptr;
> >>=20
> >>=20
> >> bpf_probe_read_user_str(buf, ..., user_ptr);
> >>=20
> >> From user-space:
> >>=20
> >> skel->bss->user_ptr =3D &my_userspace_buf;
> >>=20
> >> Full control. You can trigger tracepoint with just an usleep(1), for
> >> instance.
> >=20
> > Yeah, that sounds better. I'll send a v4 with passing a ptr.
> >=20
> > Thanks,
> > Daniel
>
> One more comment, how about we test multiple strings with different
> lengths? In this way, we can catch other alignment issues.

Sure, will do that in v4 also.
