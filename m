Return-Path: <bpf+bounces-9977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1679FD78
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1791C20ABD
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09498CA46;
	Thu, 14 Sep 2023 07:50:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2B62C;
	Thu, 14 Sep 2023 07:50:11 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEA1BF6;
	Thu, 14 Sep 2023 00:50:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-637aaaf27f1so879236d6.0;
        Thu, 14 Sep 2023 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694677810; x=1695282610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xSJrjhw+CAgjUU+CnG7bgDYmbWTm16CWonGbji4gpHo=;
        b=DpIMjldUduI79FSW9HQCK7Y5JvXDPLPyoGf+n1MoOpbUrdevMBawUg6IwGUoCfH20N
         Vu1a2P/zYbWQcoT9YqXqfsqefZBydDzCtdnAQmwExps+9qO1bBx8U6BHxtZI3kjcuRxx
         PubMArlT11Nxf5d6GSGyTU5h8wIIYtItvFpB1xhmFmyttF7bHQsqWEfjpfc6v6ShzfMT
         von8EoIjmAyR1EMytHnga4n55pqwvzvkyFBlaR+rasLLlcJgb9gtwSG0GLSzcaRgKKC3
         cLXSI8daDX5Mme2HiL0OxAnxWL+lbkzcrLwIjmm1aI7mFYr3ANptcoK/Kk45Hro33zUj
         yviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694677810; x=1695282610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSJrjhw+CAgjUU+CnG7bgDYmbWTm16CWonGbji4gpHo=;
        b=ZsIdR9UQwX7ldAZDqMAofyU1WnUmGvBwVcXRCsXmkVNJQQgt4S1blhTDZiUpcdXyJE
         kjKLPVcsH/gTFoNM2PpM3NAeAbH1fT/1oZSqdaFweL6RZYKwznInmn5fBgRAG4BhL18O
         EeybBBLmmbwKF00yzRpBwsHWzX4qrN0oJm3n7Y9/DQmu6EOPMByn6hiWm655bwyHKJTN
         PUq/PbaFIS/OXhH8PwcbFCgxorgrFOCqYAgi5Hzjj73m5QAmeIBsfFKm4A3WPYkc2p2V
         N7SPdEF/VQ7aiSI1u9Q0yhd6yPlqHtpKRMAbUKMh0RbN2JD3C/dAlve//CRWFlswD1SQ
         1TUQ==
X-Gm-Message-State: AOJu0Yz7XkKj1aPT1NKiTTibPCJTypfbpmUwNfNb3fbusT/wf6C/uKkK
	8DGob4IS6Qx9RqYrrXGUxdLhPD/nQ9xPQRCct3Q=
X-Google-Smtp-Source: AGHT+IEF0twwx0OZBOsL0rdNCAjIXOcEzqfz68Ap1djEahoNJvYSKXNrjRyDnBSoX+t9gHT/w+c5FAUpDy6VK6Pf57k=
X-Received: by 2002:a05:6214:f6e:b0:63d:2a0b:3f91 with SMTP id
 iy14-20020a0562140f6e00b0063d2a0b3f91mr4896001qvb.2.1694677810006; Thu, 14
 Sep 2023 00:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
 <20230913110248.30597-8-magnus.karlsson@gmail.com> <ZQHuEATwIdONDg9o@boxer>
In-Reply-To: <ZQHuEATwIdONDg9o@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 14 Sep 2023 09:49:59 +0200
Message-ID: <CAJ8uoz3pQiATi+JZvrn8+nc0M-pEF9r3b6n117Rg5KL3heBjLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/10] selftests/xsk: add option to run single test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Sept 2023 at 19:15, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 13, 2023 at 01:02:29PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add a command line option to be able to run a single test. This option
> > (-t) takes a number from the list of tests available with the "-l"
> > option. Here are two examples:
> >
> > Run test number 2, the "receive single packet" test in all available modes:
> >
> > ./test_xsk.sh -t 2
> >
> > Run test number 21, the metadata copy test in skb mode only
> >
> > ./test_xsh.sh -t 21 -m skb
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/test_xsk.sh  | 10 +++-
> >  tools/testing/selftests/bpf/xskxceiver.c | 59 +++++++++++++++++-------
> >  tools/testing/selftests/bpf/xskxceiver.h |  3 ++
> >  3 files changed, 55 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index cb215a83b622..296006ea6e9c 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -79,12 +79,15 @@
> >  #
> >  # List available tests
> >  #   ./test_xsk.sh -l
> > +#
> > +# Run a specific test from the test suite
> > +#   sudo ./test_xsk.sh -t TEST_NAME
> >
> >  . xsk_prereqs.sh
> >
> >  ETH=""
> >
> > -while getopts "vi:dm:l" flag
> > +while getopts "vi:dm:lt:" flag
> >  do
> >       case "${flag}" in
> >               v) verbose=1;;
> > @@ -92,6 +95,7 @@ do
> >               i) ETH=${OPTARG};;
> >               m) MODE=${OPTARG};;
> >               l) list=1;;
> > +             t) TEST=${OPTARG};;
> >       esac
> >  done
> >
> > @@ -170,6 +174,10 @@ if [ -n "$MODE" ]; then
> >       ARGS+="-m ${MODE} "
> >  fi
> >
> > +if [ -n "$TEST" ]; then
> > +     ARGS+="-t ${TEST} "
> > +fi
> > +
> >  retval=$?
> >  test_status $retval "${TEST_NAME}"
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index a063b9af7fff..4d5c53153465 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -110,6 +110,7 @@ static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> >  static bool opt_verbose;
> >  static bool opt_print_tests;
> >  static enum test_mode opt_mode = TEST_MODE_ALL;
> > +static u32 opt_run_test = RUN_ALL_TESTS;
> >
> >  static void __exit_with_error(int error, const char *file, const char *func, int line)
> >  {
> > @@ -316,10 +317,11 @@ static struct option long_options[] = {
> >       {"verbose", no_argument, 0, 'v'},
> >       {"mode", required_argument, 0, 'm'},
> >       {"list", no_argument, 0, 'l'},
> > +     {"test", required_argument, 0, 't'},
> >       {0, 0, 0, 0}
> >  };
> >
> > -static void usage(const char *prog)
> > +static void print_usage(char **argv)
> >  {
> >       const char *str =
> >               "  Usage: xskxceiver [OPTIONS]\n"
> > @@ -328,9 +330,11 @@ static void usage(const char *prog)
> >               "  -v, --verbose        Verbose output\n"
> >               "  -b, --busy-poll      Enable busy poll\n"
> >               "  -m, --mode           Run only mode skb, drv, or zc\n"
> > -             "  -l, --list           List all available tests\n";
> > +             "  -l, --list           List all available tests\n"
> > +             "  -t, --test           Run a specific test. Enter number from -l option.\n";
> >
> > -     ksft_print_msg(str, prog);
> > +     ksft_print_msg(str, basename(argv[0]));
> > +     ksft_exit_xfail();
> >  }
> >
> >  static bool validate_interface(struct ifobject *ifobj)
> > @@ -350,7 +354,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >       opterr = 0;
> >
> >       for (;;) {
> > -             c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
> > +             c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
> >               if (c == -1)
> >                       break;
> >
> > @@ -390,16 +394,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >                                                               strlen("zc")))) {
> >                               opt_mode = TEST_MODE_ZC;
> >                       } else {
> > -                             usage(basename(argv[0]));
> > -                             ksft_exit_xfail();
> > +                             print_usage(argv);
> >                       }
> >                       break;
> >               case 'l':
> >                       opt_print_tests = true;
> >                       break;
> > +             case 't':
> > +                     errno = 0;
> > +                     opt_run_test = strtol(optarg, NULL, 0);
> > +                     if (errno)
> > +                             print_usage(argv);
> > +                     break;
> >               default:
> > -                     usage(basename(argv[0]));
> > -                     ksft_exit_xfail();
> > +                     print_usage(argv);
> >               }
> >       }
> >  }
> > @@ -2330,8 +2338,8 @@ int main(int argc, char **argv)
> >       struct pkt_stream *rx_pkt_stream_default;
> >       struct pkt_stream *tx_pkt_stream_default;
> >       struct ifobject *ifobj_tx, *ifobj_rx;
> > +     u32 i, j, failed_tests = 0, nb_tests;
> >       int modes = TEST_MODE_SKB + 1;
> > -     u32 i, j, failed_tests = 0;
> >       struct test_spec test;
> >       bool shared_netdev;
> >
> > @@ -2353,15 +2361,17 @@ int main(int argc, char **argv)
> >               print_tests();
> >               ksft_exit_xpass();
> >       }
> > +     if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
> > +             ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
> > +             ksft_exit_xfail();
> > +     }
> >
> >       shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
> >       ifobj_tx->shared_umem = shared_netdev;
> >       ifobj_rx->shared_umem = shared_netdev;
> >
> > -     if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
> > -             usage(basename(argv[0]));
> > -             ksft_exit_xfail();
> > -     }
> > +     if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
> > +             print_usage(argv);
> >
> >       if (is_xdp_supported(ifobj_tx->ifindex)) {
> >               modes++;
> > @@ -2380,16 +2390,33 @@ int main(int argc, char **argv)
> >       test.tx_pkt_stream_default = tx_pkt_stream_default;
> >       test.rx_pkt_stream_default = rx_pkt_stream_default;
> >
> > -     if (opt_mode == TEST_MODE_ALL)
> > -             ksft_set_plan(modes * ARRAY_SIZE(tests));
> > +     if (opt_run_test == RUN_ALL_TESTS)
> > +             nb_tests = ARRAY_SIZE(tests);
> >       else
> > -             ksft_set_plan(ARRAY_SIZE(tests));
> > +             nb_tests = 1;
> > +     if (opt_mode == TEST_MODE_ALL) {
> > +             ksft_set_plan(modes * nb_tests);
> > +     } else {
> > +             if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
> > +                     ksft_print_msg("Error: XDP_DRV mode not supported.\n");
> > +                     ksft_exit_xfail();
> > +             }
> > +             if (opt_mode == TEST_MODE_ZC && modes <= TEST_MODE_ZC) {
> > +                     ksft_print_msg("Error: zero-copy mode not supported.\n");
> > +                     ksft_exit_xfail();
>
> shouldn't these checks go with patch 03?

Yes of course! My bad. Will spin a v4.

> > +             }
> > +
> > +             ksft_set_plan(nb_tests);
> > +     }
> >
> >       for (i = 0; i < modes; i++) {
> >               if (opt_mode != TEST_MODE_ALL && i != opt_mode)
> >                       continue;
> >
> >               for (j = 0; j < ARRAY_SIZE(tests); j++) {
> > +                     if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
> > +                             continue;
> > +
> >                       test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
> >                       run_pkt_test(&test);
> >                       usleep(USLEEP_MAX);
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> > index 3a71d490db3e..8015aeea839d 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -5,6 +5,8 @@
> >  #ifndef XSKXCEIVER_H_
> >  #define XSKXCEIVER_H_
> >
> > +#include <limits.h>
> > +
> >  #include "xsk_xdp_progs.skel.h"
> >
> >  #ifndef SOL_XDP
> > @@ -56,6 +58,7 @@
> >  #define XSK_DESC__MAX_SKB_FRAGS 18
> >  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
> >  #define PKT_DUMP_NB_TO_PRINT 16
> > +#define RUN_ALL_TESTS UINT_MAX
> >
> >  #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
> >
> > --
> > 2.42.0
> >

