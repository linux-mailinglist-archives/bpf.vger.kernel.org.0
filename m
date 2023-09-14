Return-Path: <bpf+bounces-9976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C879FD71
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EAC9B20A8D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8FC8F9;
	Thu, 14 Sep 2023 07:48:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910C2915;
	Thu, 14 Sep 2023 07:48:42 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27A1BF6;
	Thu, 14 Sep 2023 00:48:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76eecd12abbso14446985a.0;
        Thu, 14 Sep 2023 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694677720; x=1695282520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uP5RW7KbyqebGradKrb29u75wMnHMI0ogwbMs4NIpgU=;
        b=VzPHSyj1YK46D7I8eDj9vaMsQIDoZ/O+pwwsbJB0a7z2dgGFLB5GOee26EFtCrTGQ6
         gKO4toS9J4IyoETHbsyJn8NLvC/VN4E9oBLUr6qVkW7eIdLWmtOG3PjE5W2TZNJejS9R
         oTXybMO2ei7rMTQ69JOdtmdEXUYbgdTHM3S8c1FgaO+2gY2NvKqgE+HSqymRE6Vdk33O
         8BbQ4LQEiwJzFsK4BU79QS2Nvv0rzTzDLxMh7dbSBReX4CXtM6MZ92uBzb/VS8lwGuV4
         q4HtBhkyiEp/8C/WIr8gQ/RzNVZ+ci3mXVRAiR8P7ETOK67yxYdF54F8ZDOn9YNQMBlM
         5S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694677720; x=1695282520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP5RW7KbyqebGradKrb29u75wMnHMI0ogwbMs4NIpgU=;
        b=CHaK0qrybRFr/7hfj6+CUpBuE7I+kua/ob3+nPA0YhqNSmafITVWXSUaUk6Jpv1W8r
         Nq4ZblQ6wht7LxJIpeQB0DDUse0LSlZj/Gzk+Ru9j9lRvbL1nPRZp8oif9SWhRfdXDAH
         MblKHxBkuyBj4dByxVqdhphFjkLOmiG9VsUpHYc1jglyx6+U1lifKniRR3NFzA33QKru
         LkGUm147lNZ8xUQszwhpSdgALBTS6B4vZO3HnyNnEsn1/S+AH2C9VjIgTVFZgyL3d1VK
         sk31A+5IAtTTflo5oUSYhW4EJeDXxFnfXgV95c9dcef/eUPvc6/Mo8JTZMXXOnV8g6Br
         Ax6w==
X-Gm-Message-State: AOJu0YzYJcYkO2lPgNK/CcxJL2Ydh9ulDMXp3uT43LQQoCBEwArelDUU
	bvKH1ZUkEkHZbvNbDjrTXhqVh5WW9eSdbC106SmCkcwALEebCJQT
X-Google-Smtp-Source: AGHT+IGJkApzvMQI3mgECNgrp7rBnF5y/0gxWkqXGAbe6p2ggzbZKgHgjgukkLAD6HEed8L75z3gAJZRzy6ACF+Yvuc=
X-Received: by 2002:a05:6214:76e:b0:653:576d:1ec with SMTP id
 f14-20020a056214076e00b00653576d01ecmr4838087qvz.3.1694677720542; Thu, 14 Sep
 2023 00:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
 <20230913110248.30597-4-magnus.karlsson@gmail.com> <ZQHtYo2i/oio1xbT@boxer>
In-Reply-To: <ZQHtYo2i/oio1xbT@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 14 Sep 2023 09:48:29 +0200
Message-ID: <CAJ8uoz0sef8MwwPeRS9_y94AFAXahrRaJ7S-RewF2pKG6sE-iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/10] selftests/xsk: add option to only run
 tests in a single mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Sept 2023 at 19:12, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 13, 2023 at 01:02:25PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add an option -m on the command line that allows the user to run the
> > tests in a single mode instead of all of them. Valid modes are skb,
> > drv, and zc (zero-copy). An example:
> >
> > To run test suite in drv mode only:
> >
> > ./test_xsk.sh -m drv
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
> >  tools/testing/selftests/bpf/xskxceiver.c | 34 +++++++++++++++++++++---
> >  tools/testing/selftests/bpf/xskxceiver.h |  4 +--
> >  3 files changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 2aa5a3445056..85e7a7e843f7 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -73,17 +73,21 @@
> >  #
> >  # Run test suite for physical device in loopback mode
> >  #   sudo ./test_xsk.sh -i IFACE
> > +#
> > +# Run test suite in a specific mode only [skb,drv,zc]
> > +#   sudo ./test_xsk.sh -m MODE
> >
> >  . xsk_prereqs.sh
> >
> >  ETH=""
> >
> > -while getopts "vi:d" flag
> > +while getopts "vi:dm:" flag
> >  do
> >       case "${flag}" in
> >               v) verbose=1;;
> >               d) debug=1;;
> >               i) ETH=${OPTARG};;
> > +             m) MODE=${OPTARG};;
> >       esac
> >  done
> >
> > @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
> >       ARGS+="-v "
> >  fi
> >
> > +if [ -n "$MODE" ]; then
> > +     ARGS+="-m ${MODE} "
> > +fi
> > +
> >  retval=$?
> >  test_status $retval "${TEST_NAME}"
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index 514fe994e02b..9f79c2b6aa97 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -107,6 +107,9 @@
> >  static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
> >  static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> >
> > +static bool opt_verbose;
> > +static enum test_mode opt_mode = TEST_MODE_ALL;
> > +
> >  static void __exit_with_error(int error, const char *file, const char *func, int line)
> >  {
> >       ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
> > @@ -310,17 +313,19 @@ static struct option long_options[] = {
> >       {"interface", required_argument, 0, 'i'},
> >       {"busy-poll", no_argument, 0, 'b'},
> >       {"verbose", no_argument, 0, 'v'},
> > +     {"mode", required_argument, 0, 'm'},
> >       {0, 0, 0, 0}
> >  };
> >
> >  static void usage(const char *prog)
> >  {
> >       const char *str =
> > -             "  Usage: %s [OPTIONS]\n"
> > +             "  Usage: xskxceiver [OPTIONS]\n"
> >               "  Options:\n"
> >               "  -i, --interface      Use interface\n"
> >               "  -v, --verbose        Verbose output\n"
> > -             "  -b, --busy-poll      Enable busy poll\n";
> > +             "  -b, --busy-poll      Enable busy poll\n"
> > +             "  -m, --mode           Run only mode skb, drv, or zc\n";
> >
> >       ksft_print_msg(str, prog);
> >  }
> > @@ -342,7 +347,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >       opterr = 0;
> >
> >       for (;;) {
> > -             c = getopt_long(argc, argv, "i:vb", long_options, &option_index);
> > +             c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
> >               if (c == -1)
> >                       break;
> >
> > @@ -371,6 +376,21 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >                       ifobj_tx->busy_poll = true;
> >                       ifobj_rx->busy_poll = true;
> >                       break;
> > +             case 'm':
> > +                     if (!strncmp("skb", optarg, min_t(size_t, strlen(optarg),
> > +                                                       strlen("skb")))) {
> > +                             opt_mode = TEST_MODE_SKB;
> > +                     } else if (!strncmp("drv", optarg, min_t(size_t, strlen(optarg),
> > +                                                              strlen("drv")))) {
> > +                             opt_mode = TEST_MODE_DRV;
> > +                     } else if (!strncmp("zc", optarg, min_t(size_t, strlen(optarg),
> > +                                                             strlen("zc")))) {
>
> with that logic i can type -m zcafxdprocks and this will still fly.

Anyone who writes that deserves at least a bonus level in my mind ;-).
Will fix it.

> Sorry for being such a PITA over this but couldn't we simplify this to
>
>                         if (!strncmp("skb", optarg, strlen(optarg)))
>                                 opt_mode = TEST_MODE_SKB;
>                         else if (!strncmp("drv", optarg, strlen(optarg)))
>                                 opt_mode = TEST_MODE_DRV;
>                         else if (!strncmp("zc", optarg, strlen(optarg)))
>                                 opt_mode = TEST_MODE_ZC;
>
> as one of the next patches moves ksft_exit_xfail() to print_usage which
> makes the braces in branch statements redundant. Using len of optarg
> solves the -m zcafxdprocks problem.
>
> > +                             opt_mode = TEST_MODE_ZC;
> > +                     } else {
> > +                             usage(basename(argv[0]));
> > +                             ksft_exit_xfail();
> > +                     }
> > +                     break;
> >               default:
> >                       usage(basename(argv[0]));
> >                       ksft_exit_xfail();
> > @@ -2365,9 +2385,15 @@ int main(int argc, char **argv)
> >       test.tx_pkt_stream_default = tx_pkt_stream_default;
> >       test.rx_pkt_stream_default = rx_pkt_stream_default;
> >
> > -     ksft_set_plan(modes * TEST_TYPE_MAX);
> > +     if (opt_mode == TEST_MODE_ALL)
> > +             ksft_set_plan(modes * TEST_TYPE_MAX);
> > +     else
> > +             ksft_set_plan(TEST_TYPE_MAX);
> >
> >       for (i = 0; i < modes; i++) {
> > +             if (opt_mode != TEST_MODE_ALL && i != opt_mode)
> > +                     continue;
> > +
> >               for (j = 0; j < TEST_TYPE_MAX; j++) {
> >                       test_spec_init(&test, ifobj_tx, ifobj_rx, i);
> >                       run_pkt_test(&test, i, j);
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> > index 233b66cef64a..1412492e9618 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -63,7 +63,7 @@ enum test_mode {
> >       TEST_MODE_SKB,
> >       TEST_MODE_DRV,
> >       TEST_MODE_ZC,
> > -     TEST_MODE_MAX
> > +     TEST_MODE_ALL
> >  };
> >
> >  enum test_type {
> > @@ -98,8 +98,6 @@ enum test_type {
> >       TEST_TYPE_MAX
> >  };
> >
> > -static bool opt_verbose;
> > -
> >  struct xsk_umem_info {
> >       struct xsk_ring_prod fq;
> >       struct xsk_ring_cons cq;
> > --
> > 2.42.0
> >

