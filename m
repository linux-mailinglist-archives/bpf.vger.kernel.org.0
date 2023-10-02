Return-Path: <bpf+bounces-11214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA67B5801
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3DB751C204FA
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724FB1DDC2;
	Mon,  2 Oct 2023 16:46:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925921D553
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 16:46:24 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B2A9
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 09:46:21 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ae19da7b79so4061233241.2
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696265180; x=1696869980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGBqf2RnmzptaT9iLtaWez4RLGgdWxaNUdHCjJ7UdFY=;
        b=I9iTn0HC2ijdPgiBDJPJoT7S07Sjo3iYvJgrV7KrkXaZOTvXKt+4j91ZxYazB0Lqot
         47uHkiSMKQLfjrMJAMwkRdyo2w6ssgJMSIG8AMFjopEsHBt/flsqdmxyTmLHoBEgID7g
         fuXWFirg4rqK8AkdzN/O6SuB3W2npT8JUC1nvmDTVxLhB+aNfFryubZkKVjUHYJXFygk
         iiUiG5JNtY/wpcMOlcrzhIdDDQ+t4Lb4DOyY2GI9GX5AqZD4SNc5u03v4lU2gWRX86Ez
         HB5wfH22W9+7jet1isI30AJnZeS6i3xldW6zkBUvjvngJQGRC67QE+/2tAgSFjExFJet
         Du2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265180; x=1696869980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGBqf2RnmzptaT9iLtaWez4RLGgdWxaNUdHCjJ7UdFY=;
        b=TkeifpW3CWSoiD4DM1XOBzGERb6wYSD5U98fEuEvDVGmMdOVNLMgK1wHcDpRo6yaN2
         1j78znALfcYyS71kJhW5ESF1GkXD2f2w8/D5agBEUzq6C3rJey6FpIQ+gVIk0VlAGkQH
         r2QtULJJjDny5VU4Qu9a2VNUHqSRzPJQOF2oFGSrb53KGMaPkqEmeMqxCsRuBfWTV0ta
         ePHtGwTufQFMs57Hkk4/mbPW+hCDRp8m8N3fHrf7YE0MTJBPSG4cSFxx/xH4vKSOmMZr
         Wcjzd3UvmGo9JXYCrFoEweyG8/ihPIAbNrcQhrmgHrFQeumRuSH38V0wzgVc1amIaSiF
         irhA==
X-Gm-Message-State: AOJu0YyUbIW9q7FP0bBi0n1uGPJwgS8jtSDuhLmWHL7BKjgv9+o94pMC
	d0c1yi4KdbzN9wrE5DTmeqmoaXZtFTlMOofH83Hssg==
X-Google-Smtp-Source: AGHT+IFNJokdZvPkz1n1Kh3JJXi5svhRQyl6CpPYVybM+2pDTGJQQ0JUYWXxaSJtEPQt6TTebpYwxVqjmMJiI2nV1Ns=
X-Received: by 2002:a1f:e182:0:b0:495:ee2e:23f9 with SMTP id
 y124-20020a1fe182000000b00495ee2e23f9mr7964509vkg.15.1696265179921; Mon, 02
 Oct 2023 09:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002162653.297318-1-larysa.zaremba@intel.com>
In-Reply-To: <20231002162653.297318-1-larysa.zaremba@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 2 Oct 2023 09:46:08 -0700
Message-ID: <CAKH8qBtGBOw7j01s-ZO4tZmU9kQf-jQi1xUP9UmZ0ebN+W0whw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and ZC mode to xdp_hw_metadata
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 9:35=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> By default, xdp_hw_metadata runs in AF_XDP copy mode. However, hints are
> also supposed to be supported in ZC mode, which is usually implemented
> separately in driver, and so needs to be tested too.
>
> Add an option to run xdp_hw_metadata in ZC mode.
>
> As for now, xdp_hw_metadata accepts no options, so add simple option
> parsing logic and a help message.
>
> For quick reference, also add an ingress packet generation command to the
> help message. The command comes from [0].
>
> [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/

I did similar changes in my pending [0], but I made the zerocopy, not
the copy mode, the default.
If you want to get this in faster (my series will probably need
another iteration), let's maybe do the same here?
ZC as a default feels better.

0: https://lore.kernel.org/bpf/20230914210452.2588884-9-sdf@google.com/


> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 59 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testin=
g/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..c1d1b161a964 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -26,6 +26,7 @@
>  #include <linux/sockios.h>
>  #include <sys/mman.h>
>  #include <net/if.h>
> +#include <ctype.h>
>  #include <poll.h>
>  #include <time.h>
>
> @@ -49,6 +50,7 @@ struct xsk {
>  struct xdp_hw_metadata *bpf_obj;
>  struct xsk *rx_xsk;
>  const char *ifname;
> +bool zero_copy;
>  int ifindex;
>  int rxq;
>
> @@ -60,7 +62,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32=
 queue_id)
>         const struct xsk_socket_config socket_config =3D {
>                 .rx_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
>                 .tx_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> -               .bind_flags =3D XDP_COPY,
> +               .bind_flags =3D zero_copy ? XDP_ZEROCOPY : XDP_COPY,
>         };
>         const struct xsk_umem_config umem_config =3D {
>                 .fill_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> @@ -404,6 +406,54 @@ static void timestamping_enable(int fd, int val)
>                 error(1, errno, "setsockopt(SO_TIMESTAMPING)");
>  }
>
> +static void print_usage(void)
> +{
> +       const char *usage =3D
> +               "  Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"

Maybe [OPTIONS] <IFNAME> to mark ifname as required?

> +               "  Options:\n"
> +               "  -z            Run AF_XDP in ZC mode (copy mode is used=
 by default)\n"
> +               "  -h            Display this help and exit\n\n"
> +               "  Generate test packets on other machine with:\n"
> +               "    echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
> +
> +       printf("%s", usage);
> +}
> +
> +static void read_args(int argc, char *argv[])
> +{
> +       char opt;
> +
> +       while ((opt =3D getopt(argc, argv, "zh")) !=3D -1) {
> +               switch (opt) {
> +               case 'z':
> +                       zero_copy =3D true;
> +                       break;
> +               case 'h':
> +                       print_usage();
> +                       exit(0);
> +               case '?':
> +                       if (isprint(optopt))
> +                               fprintf(stderr, "Unknown option: -%c\n", =
optopt);
> +                       fallthrough;
> +               default:
> +                       print_usage();
> +                       error(-1, opterr, "Command line options error");
> +               }
> +       }
> +
> +       if (optind >=3D argc) {
> +               fprintf(stderr, "No device name provided\n");
> +               print_usage();
> +               exit(-1);
> +       }
> +
> +       ifname =3D argv[optind];
> +       ifindex =3D if_nametoindex(ifname);
> +
> +       if (!ifname)
> +               error(-1, errno, "Invalid interface name");
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         clockid_t clock_id =3D CLOCK_TAI;
> @@ -413,13 +463,8 @@ int main(int argc, char *argv[])
>
>         struct bpf_program *prog;
>
> -       if (argc !=3D 2) {
> -               fprintf(stderr, "pass device name\n");
> -               return -1;
> -       }
> +       read_args(argc, argv);
>
> -       ifname =3D argv[1];
> -       ifindex =3D if_nametoindex(ifname);
>         rxq =3D rxq_num(ifname);
>
>         printf("rxq: %d\n", rxq);
> --
> 2.41.0
>

