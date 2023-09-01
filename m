Return-Path: <bpf+bounces-9125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C0E7903E8
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 01:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D482528102D
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE520134B0;
	Fri,  1 Sep 2023 23:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FFAD53
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 23:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EFFC433CD
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 23:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693609786;
	bh=uXWbEr53VQSjSgaX3cxjwV2nRm8dxhaLk3oJQqYvlKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=acQ+9qB5kRwMFTYf25XrgA1vwW9HcUX0V5GwsqwbtO/Ws3R1QsaxWXTzK5uR/LBy4
	 D75Yi4QunPajmQEoC8lb9tWRaPkEe53gbjqrSSsGbQSbf8vZumJ8enRTR5QOUGDMS7
	 BkHyVVkXKT9WfLDhr5XlyD1GmN9PYmI8cn1P8WGgY3KtaXsUH22qAJSq6AGiaBXS0q
	 zBgzsktwF6ATiGcK8OVj4BwQq8ShQUcI3B+XHVYYFSI4mJbFeHBXMm54aC+V7jeJmB
	 5kBfFxaG4y6pK2Ct5pV0Fuj5PNIwBM7TwvK94AtVpAIsQESXbu161t/iYdFYDE9J6S
	 mcXKNK09qwXFQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-500c7796d8eso4454347e87.1
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 16:09:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YyAdpaUwHklAbJSkGXx3DkMnsKMA/jM3K1H8UKhx5K9+Tw+V0mP
	qZFszoCd50UkB0F3jTSPthPj0rtDdFF1DWlRtHw=
X-Google-Smtp-Source: AGHT+IGnybv84QcaX91jE7zrLhmRVnAFxducWQlVyfkgNaFo6pax/KVYLNYzAAi0kjqmxVC9P0gzUBBrDL+9f+Z9Qu8=
X-Received: by 2002:ac2:5a0f:0:b0:4fd:d9dd:7a1a with SMTP id
 q15-20020ac25a0f000000b004fdd9dd7a1amr2230207lfn.31.1693609784371; Fri, 01
 Sep 2023 16:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831141103.359810-1-jolsa@kernel.org> <1fc894ed-0f54-ea4f-8b2f-d7120b6d9c0f@iogearbox.net>
In-Reply-To: <1fc894ed-0f54-ea4f-8b2f-d7120b6d9c0f@iogearbox.net>
From: Song Liu <song@kernel.org>
Date: Fri, 1 Sep 2023 16:09:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW64KL9T2B9ePzLSvfW2UonCircVj48+GozagJi8xLNo7w@mail.gmail.com>
Message-ID: <CAPhsuW64KL9T2B9ePzLSvfW2UonCircVj48+GozagJi8xLNo7w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Fix d_path test
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 8:21=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/31/23 4:11 PM, Jiri Olsa wrote:
> > Recent commit [1] broken d_path test, because now filp_close is not cal=
led
> > directly from sys_close, but eventually later when the file is finally
> > released.
> >
> > As suggested by Hou Tao we don't need to re-hook the bpf program, but j=
ust
> > instead we can use sys_close_range to trigger filp_close synchronously.
> >
> > [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> > Suggested-by: Hou Tao <houtao@huaweicloud.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> That did the trick, thanks everyone, applied!

I guess I am a bit late. But how about we use something like the following?
I like this one better because it tests bpf_d_path() from retval at fexit.

Thanks,
Song




diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
index a7264b2c17ad..fe91836cedcd 100644
--- i/kernel/trace/bpf_trace.c
+++ w/kernel/trace/bpf_trace.c
@@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+BTF_ID(func, close_fd_get_file)
 BTF_SET_END(btf_allowlist_d_path)

 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
diff --git i/tools/testing/selftests/bpf/progs/test_d_path.c
w/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..c880cfc95737 100644
--- i/tools/testing/selftests/bpf/progs/test_d_path.c
+++ w/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *=
stat,
        return 0;
 }

-SEC("fentry/filp_close")
-int BPF_PROG(prog_close, struct file *file, void *id)
+SEC("fexit/close_fd_get_file")
+int BPF_PROG(close_fd_get_file, int fd, struct file *file /* retval */)
 {
        pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
        __u32 cnt =3D cnt_close;

