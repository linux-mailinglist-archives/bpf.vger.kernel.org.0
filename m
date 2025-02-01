Return-Path: <bpf+bounces-50256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EEA245FB
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 01:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863067A33F3
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72210125B2;
	Sat,  1 Feb 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx6b5QGU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300F23CB;
	Sat,  1 Feb 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370725; cv=none; b=EL+b7dIO3ntBLd/cm2XcdpGuU1BntZqLQQekIqnLOB5F/6xS/HGqogrwFvjUlVqS8dNedVKpydb2MwWdmM1nAkW9ZJz7O1SV1YpMTEY1vh/aGILIglwi3gTlXJ10ao/pJBQc5sANZVRxyyS2YVdnWPNpnxxvxLY9t8QAaCSezOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370725; c=relaxed/simple;
	bh=M8/HYVtz6zoqdrk8Bbgqmd93WlSx8vJVnxmF6wSVq3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4/azXdAst+2B+x8ImObZ2K59xZyHuAPBoHvlDsGDzYFTBuLVZHFzNWJdOvwFLjwRMjxm8e31wonPgObf/Xj0gNdIXYSLAUHevJctjtw3jG2x9my5yg1encoX10kPE1Q3JcUNQLBvAzKF6LE3hL1gb413/9d5leVT36cDNXGCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx6b5QGU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso3029333276.0;
        Fri, 31 Jan 2025 16:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738370722; x=1738975522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciJHt/z1JFayiUPMBWhgXqEFfCdPvS6UdOyDyrwcJnc=;
        b=Jx6b5QGUuuvDnloRvwQ3ncgvxFK6GFGQFpxCw5GW59oBVDwIzZBLBbNiA2+vMGRo02
         CoKKF6dCYXZMyeAoPZPL/J8wG8G8w5bRjwC0se7UQtuoNjrHH1POMfXrF7Y1UxYYrWZu
         UfwiqWqTtTJa5RvTiZkhP58Fod+ve7JTiy8GdpenuZeXoAM/XaqRI4YfN7fmMG6KKHwr
         KVr0j40QlLBYfzOL6GOJTsdMPjlcy4GGUbfQeq0tn1Og82+F/zZDXapcKG/0zGJr4XPK
         rbPFOi7zjqWchYxpESaFdtWG4hJoC3WtMJVFY13Q1SgbF9/fmUyZlC5W3VdKvXJ02byc
         3t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738370722; x=1738975522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciJHt/z1JFayiUPMBWhgXqEFfCdPvS6UdOyDyrwcJnc=;
        b=SjGaFxnqxPYCr/WulPOqi0LmwpNqYh/CmD/P1T2XoaHY1sEtZhyhfSaPstUE9PYTEP
         J4k4hvDDytY1pSsKgI2fcGiZfW1HB4uphz0pMa0Ybmq5IEIYd9QQa3fJgXHBmXfbUV8V
         kxZQF8ob8Qk6h2+N2lLBl6ScYaH4WjmLTK7vSCfeMWrlonfYiRMAdM4lkCd0FdagWDXr
         XY7P4S6ud1owBlvV/y2pF8Vopqc2IndlZ4hONAbEQFE0h9FnzNnAiG61m5VthK3tw4+7
         58ZtjS86VZ/983ZrGIVjGriXuGr7jokyGrA5mq46b7sE1lQfrXgo0r64XN8Bm9JIpdAS
         YP7A==
X-Gm-Message-State: AOJu0YwuN//96lGVxTFJ2ylnbSqpHgWt/IaDDFWI0Mao5Eur9KLqJ8vc
	2SbfCQe4b3XzYVhBoNTti7nPWVmz85Ur4EPzzT5BHgSZekLNO+7jqBqvXC5by12axQCsvFmtmdz
	pmYz9ns0UWkl/NxZ2J3TY3lIxbDoRQI1j
X-Gm-Gg: ASbGnct7Ry/NpyYTXgamX7xdjtuVKIYDcJIFDpIWxZY9NBzPgRNZGezcqFJPr30wP/Z
	vtL/mGXJluKARa7S3ik6AvEH3qchgbmrw4u9gqp6mRbOmQ3wLYVzt+Tsp84+TdH+ed3lZMIbZ
X-Google-Smtp-Source: AGHT+IGSNNM0Oybm73v6It1imZW0DNTVrI9RLdxpWcxBoY51sv9EQtKiiTyXeNfiH2Q5uj/FB6uZJPjkF2oqIKlqk4Q=
X-Received: by 2002:a25:8a08:0:b0:e58:596:2811 with SMTP id
 3f1490d57ef6-e58a4bbe1aemr8234295276.34.1738370721923; Fri, 31 Jan 2025
 16:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131192912.133796-1-ameryhung@gmail.com> <20250131192912.133796-19-ameryhung@gmail.com>
In-Reply-To: <20250131192912.133796-19-ameryhung@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 31 Jan 2025 16:45:11 -0800
X-Gm-Features: AWEUYZk4vrs47MlmcKqSXX5ntmJctK0Ty9NH7Z_cHdeOiZGScONwdXxGrrusY0c
Message-ID: <CAMB2axPNe0MK-_T6Dw3ioCLJD3VcPEMiHnv9Kyp4RYFqngoz+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 18/18] selftests/bpf: Test attaching bpf qdisc
 to mq and non root
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, ming.lei@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 11:29=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Until we are certain that existing classful qdiscs work with bpf qdisc,
> make sure we don't allow attaching a bpf qdisc to non root. Meanwhile,
> attaching to mq is allowed.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/bpf_qdisc.c      | 111 +++++++++++++++++-
>  2 files changed, 110 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 6b0cab55bd2d..3201a962b3dc 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -74,6 +74,7 @@ CONFIG_NET_MPLS_GSO=3Dy
>  CONFIG_NET_SCH_BPF=3Dy
>  CONFIG_NET_SCH_FQ=3Dy
>  CONFIG_NET_SCH_INGRESS=3Dy
> +CONFIG_NET_SCH_HTB=3Dy
>  CONFIG_NET_SCHED=3Dy
>  CONFIG_NETDEVSIM=3Dy
>  CONFIG_NETFILTER=3Dy
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_qdisc.c
> index 7e8e3170e6b6..f3158170edff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -86,18 +86,125 @@ static void test_fq(void)
>         bpf_qdisc_fq__destroy(fq_skel);
>  }
>
> +static int netdevsim_write_cmd(const char *path, const char *cmd)
> +{
> +       FILE *fp;
> +
> +       fp =3D fopen(path, "w");
> +       if (!ASSERT_OK_PTR(fp, "write_netdevsim_cmd"))
> +               return -errno;
> +
> +       fprintf(fp, cmd);
> +       fclose(fp);
> +       return 0;
> +}
> +

I will replace netdevsim with veth for attaching mq. The function
above that failed to compile in CI will also go.


> +static void test_qdisc_attach_to_mq(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook,
> +                           .attach_point =3D BPF_TC_QDISC,
> +                           .parent =3D 0x00010001,
> +                           .handle =3D 0x8000000,
> +                           .qdisc =3D "bpf_fifo");
> +       struct bpf_qdisc_fifo *fifo_skel;
> +       struct bpf_link *link;
> +       int err;
> +
> +       hook.ifindex =3D if_nametoindex("eni1np1");
> +       if (!ASSERT_NEQ(hook.ifindex, 0, "if_nametoindex"))
> +               return;
> +
> +       fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> +       if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> +               return;
> +
> +       link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +               bpf_qdisc_fifo__destroy(fifo_skel);
> +               return;
> +       }
> +
> +       ASSERT_OK(system("tc qdisc add dev eni1np1 root handle 1: mq"), "=
create mq");
> +
> +       err =3D bpf_tc_hook_create(&hook);
> +       ASSERT_OK(err, "attach qdisc");
> +
> +       bpf_tc_hook_destroy(&hook);
> +
> +       ASSERT_OK(system("tc qdisc delete dev eni1np1 root mq"), "delete =
mq");
> +
> +       bpf_link__destroy(link);
> +       bpf_qdisc_fifo__destroy(fifo_skel);
> +}
> +
> +static void test_qdisc_attach_to_non_root(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex =3D LO_IFINDEX,
> +                           .attach_point =3D BPF_TC_QDISC,
> +                           .parent =3D 0x00010001,
> +                           .handle =3D 0x8000000,
> +                           .qdisc =3D "bpf_fifo");
> +       struct bpf_qdisc_fifo *fifo_skel;
> +       struct bpf_link *link;
> +       int err;
> +
> +       fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> +       if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> +               return;
> +
> +       link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +               bpf_qdisc_fifo__destroy(fifo_skel);
> +               return;
> +       }
> +
> +       ASSERT_OK(system("tc qdisc add dev lo root handle 1: htb"), "crea=
te htb");
> +       ASSERT_OK(system("tc class add dev lo parent 1: classid 1:1 htb r=
ate 75Kbit"), "create htb class");
> +
> +       err =3D bpf_tc_hook_create(&hook);
> +       ASSERT_ERR(err, "attach qdisc");
> +
> +       bpf_tc_hook_destroy(&hook);
> +
> +       ASSERT_OK(system("tc qdisc delete dev lo root htb"), "delete htb"=
);
> +
> +       bpf_link__destroy(link);
> +       bpf_qdisc_fifo__destroy(fifo_skel);
> +}
> +
>  void test_bpf_qdisc(void)
>  {
> +       struct nstoken *nstoken =3D NULL;
>         struct netns_obj *netns;
> +       int err;
>
> -       netns =3D netns_new("bpf_qdisc_ns", true);
> +       netns =3D netns_new("bpf_qdisc_ns", false);
>         if (!ASSERT_OK_PTR(netns, "netns_new"))
>                 return;
>
> +       err =3D netdevsim_write_cmd("/sys/bus/netdevsim/new_device", "1 1=
 4");
> +       if (!ASSERT_OK(err, "create netdevsim")) {
> +               netns_free(netns);
> +               return;
> +       }
> +
> +       ASSERT_OK(system("ip link set eni1np1 netns bpf_qdisc_ns"), "ip l=
ink set netdevsim");
> +
> +       nstoken =3D open_netns("bpf_qdisc_ns");
> +       if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +               goto out;
> +
>         if (test__start_subtest("fifo"))
>                 test_fifo();
>         if (test__start_subtest("fq"))
>                 test_fq();
> -
> +       if (test__start_subtest("attach to mq"))
> +               test_qdisc_attach_to_mq();
> +       if (test__start_subtest("attach to non root"))
> +               test_qdisc_attach_to_non_root();
> +
> +out:
> +       err =3D netdevsim_write_cmd("/sys/bus/netdevsim/del_device", "1")=
;
> +       ASSERT_OK(err, "delete netdevsim");
>         netns_free(netns);
>  }
> --
> 2.47.1
>

