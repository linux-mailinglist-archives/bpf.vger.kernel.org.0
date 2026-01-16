Return-Path: <bpf+bounces-79346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0ED38938
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E286D30AE78D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688931282F;
	Fri, 16 Jan 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnGZbEP2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A230EF7B
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602488; cv=pass; b=vDe3xT9VMRpd4ZktAhVWPB4unruA+izOZ7lCr+Xq7hlQMCIQSo5fRYrwLCo3nozFCNIt0KtIeaSAkr2GZRT3PA1dT5HKCWwIXgdeFCZ8k+PptwUEoKh5HI6tL0W7vPYtsbqQdyE153Tx/p1wYxI6+Ogyf9h3p+flA1NltdwcpDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602488; c=relaxed/simple;
	bh=e5O3aFYeIvcKbfg0/jZu7gJTJoVVq8BY3YqjjOKcV04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTSKrVzjJhvEVaNldSqL1m20h/Ke5YqG43h3yZjt+SvSusyPc+YW8YprWzGVvzEujxKoVEdlc8iC6QeIDLKUS13bmX3URknGyg96g4rB/uioZgp0Xwu00mqrqlWAiMNHrOXehTJn4x0RufI3eZWrhorLdriR1QYOLoC8Vx1jUok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnGZbEP2; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso1585815a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602485; cv=none;
        d=google.com; s=arc-20240605;
        b=fTX86WqmMPBuJ3UTYy4+V1Y0F0TO1Soo3ruBrd0kmZuiXm0SDpHUN+jO8DNpfFn+rD
         9GUjjxOvGdyly4Y81vh2t2mgJhXPzQQat7FXl8x/D0Aj85bJRsa8Z2UxGD1mrN5xtJtP
         i6BP2rxKXdrWVLN/okE23CZgxOwDIuyp6WtzL/LqdewfAaQRzoHfoTmRZwOafbOdBXk0
         AXU7Omq6mqQmfR/vQXUgGkVBHPLveXSQ8sBMqsYJMmgJmOSW4TV0TdcLS92I/lyPGXqL
         IOrvswLUZaqmr2b6W3hMpKvxEkUcgmpav8Vexey3puB1qgpi0Nm8I40C4L0UFzQPKZxT
         jW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=g1W8mRAFWi46ac2VZrQqr8s1+oKWcJBUDYHeR3Bk/xG4z4SZYNyB87QkpNtP14BIvX
         7/BqiVczrRnpVHoC4ap5urKwE5Z54spRa//9htakh+KAUjs85MUXNYtKbAoFwtjrTVwi
         8oI0Jbub71a/Cxp/MgCNhupehzRqsFcvhce++Fi+6aHjFuL/UY/puXpIe84/5vhBNkdV
         vRis91zRABeaxeWXq/fK/7BRfxLKs87wEVTsrnCMfEMVwiyRWV8ljbbSGULLvtzc1JbL
         OWa0oxl7l1uJhup6WNUciYBYv7WYaeqmZmUmUyL50ki08BCWQgP+894uAmC1kdm3ybLM
         PhAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602485; x=1769207285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        b=fnGZbEP2krZR1mRqomojCpv8Yth1Dn/wRHLNNiTicWzmKaC07xWWXh6xAUJfdzK6yx
         sglAtpEw8+CQ90x3RXACz9OsOSJBmiY9bJr8sXnATUZ/n3i0AZZ4nZyd2Ae1LOcJeNuT
         d8v8bduZqTERy5oPEU1IatabyHD/YbRqn5sX8ixtyCM0PWq3tYA4xXxorczeO4cVdL9K
         BkUT493Xj3C5yokH0YpXn07V40fanlJs7jnp6+fpsY9N5Gp8Q5gyiXYbkIVE91/uklyt
         Y5rR7RecrvDRhhOFB4E8j8egChyoERbEtJAK0p8kdokyN0lYvTZxowWdf+O4PWcHCP8u
         XBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602485; x=1769207285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        b=dKreHWwbEQiqfwi7EpKhxnk1EzyyrOlO3qWhjv9KG7OgUGCefO0xEKAubevh3U3bAN
         W7Vsrp1YbCKLng0aNeLq9P9hzMVIXW7Ez5i0tg9X+/LDe8lXzi4tc+3RS3f0NNb5vsw9
         vA5DwUwfDK/RPObgsufSe9TL8lRV5/tXfQJErrjOtMyaJW9/3SE555NYq5KojPbFruan
         Xqz2EHNApPsej1uDGM4X28OM3acrHOu0zoM8EpirB6rgolh2kpTqpRm+VJkJQD+RArCa
         cX0eyt6viF8NiR/8DO03seYDjm3fTTYOMa9Y/BHvbepsYlzbU4Zu7obVUmw+/Wg+CJPV
         ADMQ==
X-Gm-Message-State: AOJu0Yz8EPmlsvza973hvedjZKKZjVGcRdKrRw4hDhmTSa0P3NoDFJmX
	ng0eMHdsPdthRdxB6zJ9xUq7l8iF7QzwY+xkNKB8PUHsS/zM41zvVGTkaZpzRwljG6MtWBXJxhT
	UeBfJ2oZbbaFFRs6/aPny+rr1/a1emEQ=
X-Gm-Gg: AY/fxX5cuctsAfgqM97tf0mStYBgPBTevmILfFSNUsAkfs3Gra/6bjnewLNUjP0QgYZ
	MPFk2iYdQ/B8AHQpNzvDR6KEk76ZLlREF37OmZ1J0aIfWhQ70MArKcnyTv4qpovWLzLAuApX9dR
	e8ZTV/Hb3xUHPv12pRjqPxtnAGhB4XiXyBTOc9Wp/Q05XrHL2uBYMAEbescwc7/oADUp2PehIVC
	PHo8UXrt15/Gy9RxtEnKRDT0HBr6XAFBB1KmOMD1G+aUbgvFvPyqGBDLTcTt6pfgk8hfmuzRFgf
	rdIgzAhuW9E=
X-Received: by 2002:a17:90b:3c85:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-3527317db23mr3752920a91.11.1768602484921; Fri, 16 Jan 2026
 14:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-3-leon.hwang@linux.dev>
 <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com> <3b0fa14d-a11d-4ed7-8f28-2e99d74f6b46@linux.dev>
In-Reply-To: <3b0fa14d-a11d-4ed7-8f28-2e99d74f6b46@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:27:38 -0800
X-Gm-Features: AZwV_QiRj9jk-5uJ87ReS5F4IFipAEUi6jE4X1Cajov5CAwqsqjl7f0Fw_saIUU
Message-ID: <CAEf4Bzbig7bZoaOgOWvcv1W46iUe6m77NpToghu+vZCvQYsMpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/1/16 08:42, Andrii Nakryiko wrote:
> > On Mon, Jan 12, 2026 at 6:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> To support the extended BPF syscall introduced in the previous commit,
> >> introduce the following internal APIs:
> >>
> >> * 'sys_bpf_ext()'
> >> * 'sys_bpf_ext_fd()'
> >>   They wrap the raw 'syscall()' interface to support passing extended
> >>   attributes.
> >> * 'probe_sys_bpf_ext()'
> >>   Check whether current kernel supports the extended attributes.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c             | 34 ++++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/features.c        |  8 ++++++++
> >>  tools/lib/bpf/libbpf_internal.h |  3 +++
> >>  3 files changed, 45 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index 21b57a629916..d44e667aaf02 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>         return (__u64) (unsigned long) ptr;
> >>  }
> >>
> >> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> >> +                             unsigned int size,
> >> +                             struct bpf_common_attr *common_attr,
> >
> > nit: kernel uses consistent attr_common/size_common pattern, but here
> > you are inverting attr_common -> common_attr, let's not?
> >
>
> Ack.
>
> I'll keep the same pattern.
>
> >> +                             unsigned int size_common)
> >> +{
> >> +       cmd =3D common_attr ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_C=
OMMON_ATTRS);
> >> +       return syscall(__NR_bpf, cmd, attr, size, common_attr, size_co=
mmon);
> >> +}
> >> +
> >> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *at=
tr,
> >> +                                unsigned int size,
> >> +                                struct bpf_common_attr *common_attr,
> >> +                                unsigned int size_common)
> >> +{
> >> +       int fd;
> >> +
> >> +       fd =3D sys_bpf_ext(cmd, attr, size, common_attr, size_common);
> >> +       return ensure_good_fd(fd);
> >> +}
> >> +
> >> +int probe_sys_bpf_ext(void)
> >> +{
> >> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_toke=
n_fd);
> >> +       union bpf_attr attr;
> >> +       int fd;
> >> +
> >> +       memset(&attr, 0, attr_sz);
> >> +       fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &at=
tr, attr_sz, NULL,
> >> +                    sizeof(struct bpf_common_attr));
> >> +       if (fd >=3D 0)
> >> +               close(fd);
> >
> > hm... close can change errno, this is fragile. If fd >=3D 0, something
> > is wrong with our detection, just return error right away?
> >
>
> How about capture errno before closing?
>
> err =3D errno;
> if (fd >=3D 0)
>         close(fd);
> return err =3D EFAULT;

not sure what this code is trying to do, but yes, preserving errno is
one way to fix an immediate problem.

But fd should really not be >=3D 0, and if it is -- it's some problem,
so I'd return an error in that case to keep us aware, which is why I'm
saying I'd just return inside if (fd >=3D 0) { }

>
> Then, we can wrap all details in probe_sys_bpf_ext().
>
> >> +       return errno =3D=3D EFAULT;
> >> +}
> >> +

[...]

