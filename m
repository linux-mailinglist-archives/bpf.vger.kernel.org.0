Return-Path: <bpf+bounces-57254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFCAA78D9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976BB9A3DD5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1CC2609D0;
	Fri,  2 May 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwV5q50I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35D79D2;
	Fri,  2 May 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208357; cv=none; b=Y3Po3sBoLAzMvTHG8rf1PfWca/lC42LnJ8vtx9SOo19jYaClnnvMv4oO63lUmyHfIjKuyXzySoSNqeCX+7sEqjyceT5R4DexCT+2vOZc+rC1826F166wVsDEyM6GCybn1IK4Xcy2Ko0NCKD4ocsln/4xEj8e2S8XCj1g6k+YMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208357; c=relaxed/simple;
	bh=vjS8jgTul1WtZ6z2zj/dmJa8VfflckHqR9kg8wclsck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyWNFE4w8+eofmm5oFtHo2azsWwiYc9M0jV2urUX6UV7C2NTLYtVTiiNXZX0EflsF1swiZyjQWQu9D5KzkCygFeL99Tg+JbM4DZEs/izUZvmJG5gHpWBqLQCbqQ7ejgbKG5y4f0U/RCM3n2eqzj5fBr6sakYnkeN8Y8hI506mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwV5q50I; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e728cd7150dso1713120276.3;
        Fri, 02 May 2025 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746208355; x=1746813155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TKrGTrei+o08fUU8B5T0TZBHZrTaMqeNf1MYykjSyE=;
        b=XwV5q50IyC+Kl+tgUYsgVshWWEfiVl9XwqvR/Fvza+F0pvXcZAeTYguU8bLKyBNk6X
         me/UyPF+S8keenm+8H5mW/lBo9DNTLXQ0KAZRN1w9NBWwhs+YotGc5Cgik7b2zrnOfst
         39hUWZAneFcr+rt1uAx0aGmRHvYCHmVeTz7RQV6KTU4XTPCKV7YzxjMMAjn3Dr5DEZqG
         o0VtlnEExs9BGCQKHuhVIdwFJmNJJBNpz5GnVLEEFVaQI0DKlvdhZPtg2yffQIlXUh0e
         9tq10OAzN4v6I9rzst+vEEoUhRso8YJmMsPFgx4v3a/UF0V+XInV/2tgwKCdepN34eUk
         yhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208355; x=1746813155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TKrGTrei+o08fUU8B5T0TZBHZrTaMqeNf1MYykjSyE=;
        b=tBPCLuJ0bUzEQdHTQo5XV2y7rRcgNm5r6Ssd5ifu+d3nQq5WE2Joxs7/eQlmnZFpQS
         ynqMD6fylDKDyYj6GhEyfqJBLyVmTz+jo1VUq+9mUx8bIdP/Mrdh7MPBmfE40hV1HCcJ
         Yl+aLt4j/VXBfUSQwDA6XFUKyu0JwCyje8mMm0LZbS6Re9jA9ThwkW/oZFFvK7VMvm7l
         QaEfyVTEjRjq9nQ49PL0LfUvIxGvPrSlUzSYUIHFQzg139FI2D4VgvP/soSxgPRyuwp8
         sZ3JrqtJaNeyBHMsiEAWXITYdbalR2HUIrrqJPeTagfowVraHc/EA7GTBJW28dv+Lv5B
         Q8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV6broONueKYbBLWuTbY6omgu5K8Ydii6ABpxj3WStJYQycC+Q65ZJGbzv0ZE+efPg3s1FcsN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PNM/FbucPrUdqgb+Bg2BrxkMQxjhbom1zGx6KKXbfixwy2Uw
	CyrtqLIKSatt5pa1Ud+SuaUzqN9RxKst2itV5Eb9l707dzTbMrJXt0wHUPJ+iR7NZrMvE/2gV6O
	dRD3hGbB8JvPIcsYxvTjyEt4FYFQ=
X-Gm-Gg: ASbGnct4xPOmzy1ahCxJ/b9zW3k02VySHpJljU/pLyhtmk1Yo+cAg86mFGg8EnraTo+
	TnKvpXYvrX2PjZd3JexpnoJdj/tzXI/P8ORnjJOR+yj0AipZZa4J/U7mNdXU1g+vlKu8037yRUC
	b9qsAechlU7n9IfSK67Bxs5HHGQMQR7Jsm
X-Google-Smtp-Source: AGHT+IEwFh4+UvvZVtH4lxvcGyMLZ/1VlDyJvEGMbRKzsvc1ugr/mTGj1Egq0eVkJVEbcEl7xQTTlOa/f8KjN5Nj9hU=
X-Received: by 2002:a05:690c:4d01:b0:6f9:a3c6:b2e4 with SMTP id
 00721157ae682-708cee10cb8mr60804937b3.37.1746208354570; Fri, 02 May 2025
 10:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501223025.569020-1-ameryhung@gmail.com> <20250501223025.569020-3-ameryhung@gmail.com>
 <83c8f387-c4a9-4293-9996-fec285d34c94@linux.dev>
In-Reply-To: <83c8f387-c4a9-4293-9996-fec285d34c94@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 2 May 2025 10:52:23 -0700
X-Gm-Features: ATxdqUGH80K2A4cNjSDr11LTmgOT3CzXtmllOmdxwB1jmN3mlZClfwZoIQgaKVo
Message-ID: <CAMB2axO2Jkc4Ec051+BYhju2Vr_GwzZL6yhHGuohMdg2q6WLRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net v1 2/5] selftests/bpf: Test setting and
 creating bpf qdisc as default qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	xiyou.wangcong@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 4:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 5/1/25 3:30 PM, Amery Hung wrote:
> > First, test that bpf qdisc can be set as default qdisc. Then, attach
> > an mq qdisc to see if bpf qdisc can be successfully created and grafted=
.
> >
> > The test is a sequential test as net.core.default_qdisc is global.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   .../selftests/bpf/prog_tests/bpf_qdisc.c      | 78 ++++++++++++++++++=
+
> >   1 file changed, 78 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > index c9a54177c84e..c954cc2ae64f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > @@ -159,6 +159,79 @@ static void test_qdisc_attach_to_non_root(void)
> >       bpf_qdisc_fifo__destroy(fifo_skel);
> >   }
> >
> > +static int get_default_qdisc(char *qdisc_name)
> > +{
> > +     FILE *f;
> > +     int num;
> > +
> > +     f =3D fopen("/proc/sys/net/core/default_qdisc", "r");
> > +     if (!f)
> > +             return -errno;
> > +
> > +     num =3D fscanf(f, "%s", qdisc_name);
> > +     fclose(f);
> > +
> > +     return num =3D=3D 1 ? 0 : -EFAULT;
> > +}
> > +
> > +static void test_default_qdisc_attach_to_mq(void)
> > +{
> > +     struct bpf_qdisc_fifo *fifo_skel;
> > +     char default_qdisc[IFNAMSIZ];
> > +     struct netns_obj *netns;
> > +     char tc_qdisc_show[64];
> > +     struct bpf_link *link;
> > +     char *str_ret;
> > +     FILE *tc;
> > +     int err;
> > +
> > +     fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> > +     if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> > +             return;
> > +
> > +     link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
>
>         fifo_skel->links.fifo =3D bpf_map__attach_struct_ops(....);
>
> Then no need to bpf_link__destroy(link). bpf_qdisc_fifo__destroy() should=
 do.
>

I see. I assume it will also be okay to set autoattach and call
bpf_qdisc_fifo__attach()?

> > +     if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> > +             bpf_qdisc_fifo__destroy(fifo_skel);
> > +             return;
> > +     }
> > +
> > +     err =3D get_default_qdisc(default_qdisc);
> > +     if (!ASSERT_OK(err, "read sysctl net.core.default_qdisc"))
> > +             goto out;
> > +
> > +     err =3D write_sysctl("/proc/sys/net/core/default_qdisc", "bpf_fif=
o");
> > +     if (!ASSERT_OK(err, "write sysctl net.core.default_qdisc"))
> > +             goto out;
> > +
> > +     netns =3D netns_new("bpf_qdisc_ns", true);
> > +     if (!ASSERT_OK_PTR(netns, "netns_new"))
> > +             goto out;
>
> This should be 'goto out_restore_dflt_qdisc'.
>
> I would stay with minimum number of cleanup labels if possible. Initializ=
e the
> variables that need to be cleaned up instead. There is no need to optimiz=
e each
> cleanup case for a test,
>
> e.g. "struct netns_obj netns =3D NULL; char default_qdisc[IFNAMSIZ] =3D {=
};..."
>

I will simplify the cleanup as you suggested.

> > +
> > +     SYS(out_restore_dflt_qdisc, "ip link add veth0 type veth peer vet=
h1");
> > +     SYS(out_delete_netns, "tc qdisc add dev veth0 root handle 1: mq")=
;
> > +
> > +     tc =3D popen("tc qdisc show dev veth0 parent 1:1", "r");
> > +     if (!ASSERT_OK_PTR(tc, "tc qdisc show dev veth0 parent 1:1"))
> > +             goto out_delete_netns;
> > +
> > +     str_ret =3D fgets(tc_qdisc_show, sizeof(tc_qdisc_show), tc);
> > +     if (!ASSERT_OK_PTR(str_ret, "tc qdisc show dev veth0 parent 1:1")=
)
> > +             goto out_delete_netns;
> > +
> > +     str_ret =3D strstr(tc_qdisc_show, "qdisc bpf_fifo");
> > +     if (!ASSERT_OK_PTR(str_ret, "check if bpf_fifo is created"))
> > +             goto out_delete_netns;
>
> Instead of pipe and grep, how about having the bpf_fifo_init bpf prog to =
set a
> global variable when called and then check the "fifo_skel->bss->init_call=
ed =3D=3D
> true" here?
>

That simplifies things quite a bit. I will use a global variable to
check if the qdisc is being created.

> > +
> > +     SYS(out_delete_netns, "tc qdisc delete dev veth0 root mq");
> > +out_delete_netns:
> > +     netns_free(netns);
> > +out_restore_dflt_qdisc:
> > +     write_sysctl("/proc/sys/net/core/default_qdisc", default_qdisc);
> > +out:
> > +     bpf_link__destroy(link);
> > +     bpf_qdisc_fifo__destroy(fifo_skel);
> > +}
> > +
> >   void test_bpf_qdisc(void)
> >   {
> >       struct netns_obj *netns;
> > @@ -178,3 +251,8 @@ void test_bpf_qdisc(void)
> >
> >       netns_free(netns);
> >   }
> > +
> > +void serial_test_bpf_qdisc_default(void)
> > +{
> > +     test_default_qdisc_attach_to_mq();
> > +}
>

