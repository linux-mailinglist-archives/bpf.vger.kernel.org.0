Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82B22A8726
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgKET2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:28:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59709 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732133AbgKET2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 14:28:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6ADBD5C00EB;
        Thu,  5 Nov 2020 14:28:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 14:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=43Dc/Y9QBFZVEJ5n
        ctwhETgLISxd+T8jon80wTz0I60=; b=UIy6YlPw8mzEdhhCZ/4N1uw7oBsstJ2b
        qivyGyiJu0yquM+j3r6wyZyJD5Qv/1ZUHi/Anfbf/DJyRu31olSe5bbribdstDmn
        emSAbFXTN4VcZs2KBpWt3jh/5v/pzVo1q/zsC7AlKGde0m7FmPZ1ciBVH9L41XXd
        bGYnpZEvIgHhE4F+ltQeclAtwXcMOIQgWc7z6g11y38CHCYXOUgRQImJudK3Lusx
        O5RB7cJdUdJf98D8apZC3w0IWG+zb1m81VWWqWtfVdXIjg92nsF1A25/bWpsshKC
        uPB93REWIXekfEP+8NZUFCcB5IEb9ZtvIGbgrmjPF3O6hBZ0nQ5O+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=43Dc/Y9QBFZVEJ5nctwhETgLISxd+T8jon80wTz0I60=; b=rNhoaRcC
        braNnrp8mRFzc7m40DMBkpSV91jSeoVKu/GjmrpeyqHVgqA5LcsKuvH4BLfW9Gw1
        4ZkLowxwD4C5uKMJs7Vg0L1Chhg9m7IzuDEgqXreCFWugREKarbUpcyyqW8Kkyi3
        QobIsSVmVkpRNRushuEVQAAd5cZ0G4dpKwLlKoyh2P+Ypg4B2fOuJEREKTtqgFBi
        2I5Ymnb5IXOpVQyOs1hBZkRmwI/ywRG+DykzCRkRaQ432kZ+R0wOnyGQ3XraOmWk
        AI4SW7uap+oFZDFZkQWUspoJIlrkMhVU2jIJqhnpA96OrNG6fz+Y6QnmkEc8PRwB
        OrlDClWAe0eorQ==
X-ME-Sender: <xms:SVKkX_L12YLftyWYq6MYtDgYyH4sVw-L1vMVIH4IWXd_rbvrjZpxDw>
    <xme:SVKkXzJA02ifbofokvsw9dKLfyo0NhMfcxZp5zGt-sF81L25JsWGjRGOWIAndrfXC
    ZWSU9uJjCVs5IErYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgfuhffvfffkjgesthhqredttddt
    jeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeejfefhudeffefhjedvvefhheduledtueejvedugedvjedv
    jeeljefggedtjeejveenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:SVKkX3uZF-_mgxIUk_cqTPDsRskzex_cp9OWheKPcsRo2aC3w1aQ3g>
    <xmx:SVKkX4ZHOG2HGSd60BtEH7lKP16nS-Ka2tj76XkeRWQS2T_Yy0ME4g>
    <xmx:SVKkX2acBHHYOcY5-EvB7DHreTfUDFwzl9qymdaEo2EzVrYzr6otXA>
    <xmx:SlKkX2F17KWtf3BZYvoAXX_gu7Jra6quPl-vfiQNiKEUD2vQRM7ayw>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B63032802F8;
        Thu,  5 Nov 2020 14:28:09 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "bpf" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <songliubraving@fb.com>
Date:   Thu, 05 Nov 2020 11:27:41 -0800
Message-Id: <C6VKT56JAC76.R5KKJWKRBWYM@maharaja>
In-Reply-To: <B9A62DF7-8C1B-448C-8672-0AF6FC1773BE@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 5, 2020 at 10:30 AM PST, Song Liu wrote:
>
>
> > On Nov 4, 2020, at 6:25 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
> >=20
> > Previously, bpf_probe_read_user_str() could potentially overcopy the
> > trailing bytes after the NUL due to how do_strncpy_from_user() does the
> > copy in long-sized strides. The issue has been fixed in the previous
> > commit.
> >=20
> > This commit adds a selftest that ensures we don't regress
> > bpf_probe_read_user_str() again.
> >=20
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> > .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
> > .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
> > 2 files changed, 94 insertions(+)
> > create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_us=
er_str.c
> > create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_us=
er_str.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str=
.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> > new file mode 100644
> > index 000000000000..597a166e6c8d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include "test_probe_read_user_str.skel.h"
> > +
> > +static const char str[] =3D "mestring";
> > +
> > +void test_probe_read_user_str(void)
> > +{
> > +	struct test_probe_read_user_str *skel;
> > +	int fd, err, duration =3D 0;
> > +	char buf[256];
> > +	ssize_t n;
> > +
> > +	skel =3D test_probe_read_user_str__open_and_load();
> > +	if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
> > +		  "skeleton open and load failed\n"))
> > +		goto out;
>
> nit: we can just return here.
>
> > +
> > +	err =3D test_probe_read_user_str__attach(skel);
> > +	if (CHECK(err, "test_probe_read_user_str__attach",
> > +		  "skeleton attach failed: %d\n", err))
> > +		goto out;
> > +
> > +	fd =3D open("/dev/null", O_WRONLY);
> > +	if (CHECK(fd < 0, "open", "open /dev/null failed: %d\n", fd))
> > +		goto out;
> > +
> > +	/* Give pid to bpf prog so it doesn't read from anyone else */
> > +	skel->bss->pid =3D getpid();
>
> It is better to set pid before attaching skel.
>
> > +
> > +	/* Ensure bytes after string are ones */
> > +	memset(buf, 1, sizeof(buf));
> > +	memcpy(buf, str, sizeof(str));
> > +
> > +	/* Trigger tracepoint */
> > +	n =3D write(fd, buf, sizeof(buf));
> > +	if (CHECK(n !=3D sizeof(buf), "write", "write failed: %ld\n", n))
> > +		goto fd_out;
> > +
> > +	/* Did helper fail? */
> > +	if (CHECK(skel->bss->ret < 0, "prog ret", "prog returned: %d\n",
>
> In most cases, we use underscore instead of spaces in the second
> argument
> of CHECK(). IOW, please use "prog_ret" instead of "prog ret".
>
> > +		  skel->bss->ret))
> > +		goto fd_out;
> > +
> > +	/* Check that string was copied correctly */
> > +	err =3D memcmp(skel->bss->buf, str, sizeof(str));
> > +	if (CHECK(err, "memcmp", "prog copied wrong string"))
> > +		goto fd_out;
> > +
> > +	/* Now check that no extra trailing bytes were copied */
> > +	memset(buf, 0, sizeof(buf));
> > +	err =3D memcmp(skel->bss->buf + sizeof(str), buf, sizeof(buf) - sizeo=
f(str));
> > +	if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
> > +		goto fd_out;
> > +
> > +fd_out:
> > +	close(fd);
> > +out:
> > +	test_probe_read_user_str__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str=
.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> > new file mode 100644
> > index 000000000000..41c3e296566e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include <sys/types.h>
> > +
> > +struct sys_enter_write_args {
> > +	unsigned long long pad;
> > +	int syscall_nr;
> > +	int pad1; /* 4 byte hole */
> > +	unsigned int fd;
> > +	int pad2; /* 4 byte hole */
> > +	const char *buf;
> > +	size_t count;
> > +};
> > +
> > +pid_t pid =3D 0;
> > +int ret =3D 0;
> > +char buf[256] =3D {};
> > +
> > +SEC("tracepoint/syscalls/sys_enter_write")
> > +int on_write(struct sys_enter_write_args *ctx)
> > +{
> > +	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> > +		return 0;
> > +
> > +	ret =3D bpf_probe_read_user_str(buf, sizeof(buf), ctx->buf);
>
> bpf_probe_read_user_str() returns "long". Let's use "long ret;"

Thanks for review, will send v3 with these changes.

[...]
