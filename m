Return-Path: <bpf+bounces-8251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47151784279
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7EF1C20A76
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4771CA0D;
	Tue, 22 Aug 2023 13:52:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3687F;
	Tue, 22 Aug 2023 13:52:47 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF9E49;
	Tue, 22 Aug 2023 06:52:34 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6418b4732afso11556026d6.1;
        Tue, 22 Aug 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692712354; x=1693317154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJtcfC0nsNf0kNV3/O1t14SsceMfGx6TLxYk1clgGg0=;
        b=WtrcceimQ1D2kZhth3nxTsu7NugKjXMWIbV/RHHcxiRdVRfmv4Rxp3CDQ97aSU/dyb
         8I66Ye66g1GH/52ez3lQzIGsv/K78Qh+LWIKse8+AqzBVsLsRALiKrYhp9wtsF/qb+jl
         M8Q5Cc8mQX/PtkAQABZ6cOMBdepJ5pc6NHuxD/p6XMMRGl2sUo53kd8mAmIh8D10Eyfu
         2BiIfz5giuH+hIcGt/XvwTCYCF0FKWZV14+jshubSRTut2lwW+vts5HsosLIEXy5FJag
         i4V6LUDzkPgVCeV2JDALFHcyP7zhRGu0CzqHowfN73n2DUrXvWEgLtiPf/eJr4GpxKCU
         aBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712354; x=1693317154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJtcfC0nsNf0kNV3/O1t14SsceMfGx6TLxYk1clgGg0=;
        b=gYxvWicy8woFfmYQUbmYbdsrLubqQ6bvh49eBiOt3mz4U5sctc1ZkjfAwXp6acoq66
         gYZoTjDvAAmdPxvt7ou5CPh+kv0qB5rE60flfC76aQKe3hLouiOiZ1msfNoViQ/lW+MK
         uFkFlZXnk8XkJT7kwOMosYqPaj5dZ7w8obqKmTXk9XUSabl2/olSS2O49cfHBR9jbJOk
         vpNkPotanpUR+h5V45vBPk+Y1epm7YRjXHCIzetFcx0sUvBOtbIQr6TazFfDT9YBaxJ6
         18Yy4g1ngjrNXEN5o5WxSeIkGRoBMhsvhpPOZHGMMvE50Mt3ZeE1x5Ak/OX7gEhYUlRd
         9NDQ==
X-Gm-Message-State: AOJu0YxbarbGbsjSkj7ZeQzmhbbhacbwXqKj2odZsZNkr/E0kOL0ByAR
	vDegSXk0oIK1SDmYkuSZS9I7RJt+cXAR8FseL28=
X-Google-Smtp-Source: AGHT+IE4SOihzfyOgqcUSmruBzLsRt0MMIn0VBSM5Ecr32GuY+9e7AKpX0D3kKMTeE5/TXhxpEqBhSPye7nkJe58ATE=
X-Received: by 2002:a05:6214:4017:b0:635:da19:a67f with SMTP id
 kd23-20020a056214401700b00635da19a67fmr11408955qvb.1.1692712353800; Tue, 22
 Aug 2023 06:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-7-magnus.karlsson@gmail.com> <ZOSr/muPbfiGAw+M@boxer>
In-Reply-To: <ZOSr/muPbfiGAw+M@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 22 Aug 2023 15:52:22 +0200
Message-ID: <CAJ8uoz22vVMt_XP3uV2QEpAQRZcfnhVN8tsYg6E4PZeSCvhsNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] selftests/xsk: add option that lists all tests
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 14:37, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 02:43:39PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add a command line option (-l) that lists all the tests. The number
> > before the test will be used in the next commit for specifying a
> > single test to run. Here is an example of the output:
>
> I was thinking whether we should have a way of combining -l with -m, but I
> believe there is only a single test currently that can not be run in ZC
> mode (rx dropped) ?
>
> >
> > Tests:
> > 0: SEND_RECEIVE
> > 1: SEND_RECEIVE_2K_FRAME
> > 2: SEND_RECEIVE_SINGLE_PKT
> > 3: POLL_RX
> > 4: POLL_TX
> > 5: POLL_RXQ_FULL
> > 6: POLL_TXQ_FULL
> > 7: SEND_RECEIVE_UNALIGNED
> > :
> > :
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/test_xsk.sh    | 11 +++++++++-
> >  tools/testing/selftests/bpf/xsk_prereqs.sh | 10 +++++----
> >  tools/testing/selftests/bpf/xskxceiver.c   | 24 ++++++++++++++++++++--
> >  3 files changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 4ec621f4d3db..00a504f0929a 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -81,13 +81,14 @@
> >
> >  ETH=""
> >
> > -while getopts "vi:dm:" flag
> > +while getopts "vi:dm:l" flag
> >  do
> >       case "${flag}" in
> >               v) verbose=1;;
> >               d) debug=1;;
> >               i) ETH=${OPTARG};;
> >               m) MODE=${OPTARG};;
> > +             l) list=1;;
> >       esac
> >  done
> >
> > @@ -157,6 +158,10 @@ if [[ $verbose -eq 1 ]]; then
> >       ARGS+="-v "
> >  fi
> >
> > +if [[ $list -eq 1 ]]; then
> > +     ARGS+="-l "
> > +fi
> > +
> >  if [ ! -z $MODE ]; then
> >       ARGS+="-m ${MODE} "
> >  fi
> > @@ -183,6 +188,10 @@ else
> >       cleanup_iface ${ETH} ${MTU}
> >  fi
> >
> > +if [[ $list -eq 1 ]]; then
> > +    exit
> > +fi
> > +
> >  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
> >  busy_poll=1
> >
> > diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
> > index 29175682c44d..47c7b8064f38 100755
> > --- a/tools/testing/selftests/bpf/xsk_prereqs.sh
> > +++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
> > @@ -83,9 +83,11 @@ exec_xskxceiver()
> >       fi
> >
> >       ./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
> > -
> >       retval=$?
> > -     test_status $retval "${TEST_NAME}"
> > -     statusList+=($retval)
> > -     nameList+=(${TEST_NAME})
> > +
> > +     if [[ $list -ne 1 ]]; then
> > +         test_status $retval "${TEST_NAME}"
> > +         statusList+=($retval)
> > +         nameList+=(${TEST_NAME})
> > +     fi
> >  }
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index b1d0c69f21b8..a063b9af7fff 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -108,6 +108,7 @@ static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
> >  static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> >
> >  static bool opt_verbose;
> > +static bool opt_print_tests;
> >  static enum test_mode opt_mode = TEST_MODE_ALL;
> >
> >  static void __exit_with_error(int error, const char *file, const char *func, int line)
> > @@ -314,6 +315,7 @@ static struct option long_options[] = {
> >       {"busy-poll", no_argument, 0, 'b'},
> >       {"verbose", no_argument, 0, 'v'},
> >       {"mode", required_argument, 0, 'm'},
> > +     {"list", no_argument, 0, 'l'},
> >       {0, 0, 0, 0}
> >  };
> >
> > @@ -325,7 +327,8 @@ static void usage(const char *prog)
> >               "  -i, --interface      Use interface\n"
> >               "  -v, --verbose        Verbose output\n"
> >               "  -b, --busy-poll      Enable busy poll\n"
> > -             "  -m, --mode           Run only mode skb, drv, or zc\n";
> > +             "  -m, --mode           Run only mode skb, drv, or zc\n"
> > +             "  -l, --list           List all available tests\n";
> >
> >       ksft_print_msg(str, prog);
> >  }
> > @@ -347,7 +350,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >       opterr = 0;
> >
> >       for (;;) {
> > -             c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
> > +             c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
> >               if (c == -1)
> >                       break;
> >
> > @@ -391,6 +394,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >                               ksft_exit_xfail();
> >                       }
> >                       break;
> > +             case 'l':
> > +                     opt_print_tests = true;
> > +                     break;
> >               default:
> >                       usage(basename(argv[0]));
> >                       ksft_exit_xfail();
> > @@ -2310,6 +2316,15 @@ static const struct test_spec tests[] = {
> >       {.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
> >  };
> >
> > +static void print_tests(void)
> > +{
> > +     u32 i;
> > +
> > +     printf("Tests:\n");
> > +     for (i = 0; i < ARRAY_SIZE(tests); i++)
>
> Nit: I believe you can do
>         for (u32 i = 0; i < ARRAY_SIZE(tests); i++)

Thank you for reviewing this Maciej. Will fix all your comments in all
the patches except this one. There are none of these embedded
declarations previously in the file, so let us just stick to declaring
variables right after "{", for consistency.

> > +             printf("%u: %s\n", i, tests[i].name);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       struct pkt_stream *rx_pkt_stream_default;
> > @@ -2334,6 +2349,11 @@ int main(int argc, char **argv)
> >
> >       parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
> >
> > +     if (opt_print_tests) {
> > +             print_tests();
> > +             ksft_exit_xpass();
> > +     }
> > +
> >       shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
> >       ifobj_tx->shared_umem = shared_netdev;
> >       ifobj_rx->shared_umem = shared_netdev;
> > --
> > 2.34.1
> >

