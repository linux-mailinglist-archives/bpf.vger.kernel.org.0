Return-Path: <bpf+bounces-17779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9396C81265B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7AC28275D
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508E46AF;
	Thu, 14 Dec 2023 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSBwaoGI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF2B9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 20:26:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33646500f1aso298814f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702527975; x=1703132775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c37ofhDvRdm/Gg6mIeqm/gGPvt7pIQ59HTaD/jbm0eQ=;
        b=RSBwaoGIz119f4HYfw6sj5OD1v/IwkynVT/4k0NHnC8XNILIykcXFhanI+VjpXQ1V3
         eqKSJGA8EwWCFTC70RlYtrj6ijJP8s12tdhUjdm4lebazG/ocJgUNfSLWQFdPDfinRSr
         hI470fUZifdkHUycuE5IirEsJQFBCsi3qa8rKCLW4tnLNXBlmfubyBHvjURzkvob/RFH
         i6DY/RiPGO1I78ekhYp4JrrUZL20MG8/rcTkOqwfqENw0f09u96mZY43k4hdfJArYlyP
         TsvenPBXCHmyNKkg1rI5ldAxVbTkITk54MsYE/rTQpcEzrXDuG+KuHiUiFBtuDhxZu1y
         0kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702527975; x=1703132775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c37ofhDvRdm/Gg6mIeqm/gGPvt7pIQ59HTaD/jbm0eQ=;
        b=r0t1SbuYy30qhd196/p9Aro3wt36o/Msdsdg432gjHWTC4c5kDx3ZmPqyBoG1scqwD
         E1ZYFlzWkIDXWM+rDWsmVjIlI0beTReR1kqKCQdLV1N7XWrdEaE75pP6E+lIeFDWf+fT
         9qNuU+ngmply15POtEQO9SniqrUe1Qy6SQ2mMA8Qn47ZjM/PiSnu7nRtrB+NxLwuQAjC
         t/IN2wanYBjpxI50v8yr7U8hHMr9opKKpW3qh2kVbkoCOrpwmco9l9ubTRmSXIs9uQPE
         /s2c0R9HGILJAuRmXWdhvyA/dJn9G16dxvfPCQVnsk2d+HVAMVlft8eKe/fs9A+1+I5a
         iKiw==
X-Gm-Message-State: AOJu0YwsmwAKjB947Z3IjjNmebJ7MXrPRd5+W2CvZmS3gy4TpxLXASDs
	dvGm3i3Vls709dUI1EBOaAUZ3+inUEx/GaZBviU=
X-Google-Smtp-Source: AGHT+IFciCPue3DHqGAkJ7/FjybKESdIeJtxMx6qRNzKpXZPnx/uSDycqqsEithw+bQzE5HukH1il1R5U6bBAvID+Yk=
X-Received: by 2002:a05:600c:2048:b0:40c:5536:66da with SMTP id
 p8-20020a05600c204800b0040c553666damr1120616wmg.21.1702527974990; Wed, 13 Dec
 2023 20:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
 <20231213112531.3775079-5-houtao@huaweicloud.com> <CAEf4BzbHu3t+Bg3wA2ZMWzw3PTgMtaq0w-McjU3Hje=GUTYK8g@mail.gmail.com>
 <b34e560c-0b1f-4c7c-c96c-57a17aaeee7f@huaweicloud.com>
In-Reply-To: <b34e560c-0b1f-4c7c-c96c-57a17aaeee7f@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 20:26:02 -0800
Message-ID: <CAEf4BzahB2i7Y3M==N47XM3+s7jgT76pf3FwXyM7BM-D9cLYCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for abnormal cnt
 during multi-kprobe attachment
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 12/14/2023 7:33 AM, Andrii Nakryiko wrote:
> > On Wed, Dec 13, 2023 at 3:24=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> If an abnormally huge cnt is used for multi-kprobes attachment, the
> >> following warning will be reported:
> >>
> >>   ------------[ cut here ]------------
> >>   WARNING: CPU: 1 PID: 392 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
> >>   Modules linked in: bpf_testmod(O)
> >>   CPU: 1 PID: 392 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> >>   ......
> >>   RIP: 0010:kvmalloc_node+0xd9/0xe0
> >>    ? __warn+0x89/0x150
> >>    ? kvmalloc_node+0xd9/0xe0
> >>    bpf_kprobe_multi_link_attach+0x87/0x670
> >>    __sys_bpf+0x2a28/0x2bc0
> >>    __x64_sys_bpf+0x1a/0x30
> >>    do_syscall_64+0x36/0xb0
> >>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >>   RIP: 0033:0x7fbe067f0e0d
> >>   ......
> >>    </TASK>
> >>   ---[ end trace 0000000000000000 ]---
> >>
> >> So add a test to ensure the warning is fixed.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 14 +++++++++++++=
+
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.=
c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> index 4041cfa670eb..802554d4ee24 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> @@ -300,6 +300,20 @@ static void test_attach_api_fails(void)
> >>         if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"=
))
> >>                 goto cleanup;
> >>
> >> +       /* fail_6 - abnormal cnt */
> >> +       opts.addrs =3D (const unsigned long *) addrs;
> >> +       opts.syms =3D NULL;
> >> +       opts.cnt =3D INT_MAX;
> >> +       opts.cookies =3D NULL;
> >> +
> >> +       link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.tes=
t_kprobe_manual,
> >> +                                                    NULL, &opts);
> >> +       if (!ASSERT_ERR_PTR(link, "fail_6"))
> >> +               goto cleanup;
> >> +
> >> +       if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_6_error"=
))
> > this is unreliable, store errno right after the operation before
> > ASSERT_xxx() macros
>
> I didn't fully follow the reason why it is unreliable. Do you mean
> ASSERT_ERR_PTR() macro may overwrite errno, right ? But _CHECK() already
> saves and restores errno before invoking fprintf(), so I think it is OK
> to use libbpf_get_error() to get the errno here ?

We shouldn't be using libbpf_get_error() in new code, it's legacy and
not advised to be used. If ASSERT_xxx() macro guarantee to
save/restore errno, then it might be actually fine, but it still feels
better to save errno explicitly right after the operation, just like
you'd do in normal code.

> >
> >> +               goto cleanup;
> >> +
> >>  cleanup:
> >>         bpf_link__destroy(link);
> >>         kprobe_multi__destroy(skel);
> >> --
> >> 2.29.2
> >>
>

