Return-Path: <bpf+bounces-7459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3D7778A5
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C201F28220E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A31E1B7;
	Thu, 10 Aug 2023 12:36:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAF1E1AA;
	Thu, 10 Aug 2023 12:36:23 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B31B4;
	Thu, 10 Aug 2023 05:36:21 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6418aa6742dso11686d6.0;
        Thu, 10 Aug 2023 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691670981; x=1692275781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cl6U70GGjC9GjTcgAiV67hBWjjSaGrzbMWtqGM0T+Y=;
        b=Eo43TBaBhHT80/UH8STT03JvlDY+fDYwUd5BcIMsU/42gWDRXH12kfftHP0kg+8JQ3
         KELXtfVqXgJc7lvtUMkXZK0gRGDDqhorriYau1rHPuJP9Jg/uMow5o7Ik5pOtDxI/oIy
         8gbvAinXCc6o0wziXxuw3ovae4iARajjcdLmF8V+qC4+uYspst+Rv6WjRNZvHlbjeP5N
         D3Udcvg9MfRn87MBLWIEpai6dJzPOuyVKCjxTP3wHDSgJQNFeQcta2l+j+CxLMyS3NZk
         LGpsdOJOPoc7EuJJ2z1wii/xbDwg4biBzc/Ku1q5cBMB8K/yxWOzeQbJ8g6HmSt96TrU
         xyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691670981; x=1692275781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cl6U70GGjC9GjTcgAiV67hBWjjSaGrzbMWtqGM0T+Y=;
        b=H7eTPt6pZG4g2VuSg/zwrlnoqRtnDjdqY2aTnEsbX//P+QY+UUs3a3e5A6mDmjbfZf
         tR1ojvacyVjGhivGdzimrrT3zHLFKVmG3oytEXXc8oBEHue70Yc8MBphErptPjkTsX75
         kofZNc6PGXJOTt3Z6SkCMZxS/LuPY7PXS6r1z8ahiCkImiiWEyBTABe5kZ9UMpgQUrcL
         18Ia7eSGs++H7dKpMzNR4nB21TmJCFSLChyozB2bx2z2+fQeGSRKrfveg+LUDvy0Buay
         As6eFMJxt8fNtvUZkH9nfF+Ne0COqJj/giQlgr6JCob9f8Wjk8rL/v+WFjHz5BZ3tYU0
         LyNw==
X-Gm-Message-State: AOJu0YzMVg7xiDMSuMjrLkRXJ77ZtimzZNM+5ZvFqVAKEwz6WmTtTUue
	TWJeYeCgwXrfr/5nAOOb3b07g/HfZPBGDhC9eAc=
X-Google-Smtp-Source: AGHT+IFziHpqrXO9fFy2staeerqg0RHOIF5jHUQOwdiN767bu5EGRtLGvyUxQ5ymO0hkZp8bPJ8WwZsw9DHgqPXtQBk=
X-Received: by 2002:ad4:5aa3:0:b0:63c:fd2d:6ff1 with SMTP id
 u3-20020ad45aa3000000b0063cfd2d6ff1mr2853429qvg.1.1691670980641; Thu, 10 Aug
 2023 05:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-4-magnus.karlsson@gmail.com> <be1643cc-dbfd-5e62-4750-54b41658f82f@intel.com>
In-Reply-To: <be1643cc-dbfd-5e62-4750-54b41658f82f@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 10 Aug 2023 14:36:09 +0200
Message-ID: <CAJ8uoz3tQWfAFo48QsUEf0SNV_hBxuURF+nk9ipO_Qm-62Ah1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] selftests/xsk: add option to only run
 tests in a single mode
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"yhs@fb.com" <yhs@fb.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 at 14:14, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/9/23 14:43, Magnus Karlsson wrote:
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
> >   tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
> >   tools/testing/selftests/bpf/xskxceiver.c | 34 +++++++++++++++++++++---
> >   tools/testing/selftests/bpf/xskxceiver.h |  4 +--
> >   3 files changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 2aa5a3445056..4ec621f4d3db 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -73,17 +73,21 @@
> >   #
> >   # Run test suite for physical device in loopback mode
> >   #   sudo ./test_xsk.sh -i IFACE
> > +#
> > +# Run test suite in a specific mode only [skb,drv,zc]
> > +#   sudo ./test_xsk.sh -m MODE
> >
> >   . xsk_prereqs.sh
> >
> >   ETH=""
> >
> > -while getopts "vi:d" flag
> > +while getopts "vi:dm:" flag
> >   do
> >       case "${flag}" in
> >               v) verbose=1;;
> >               d) debug=1;;
> >               i) ETH=${OPTARG};;
> > +             m) MODE=${OPTARG};;
> >       esac
> >   done
> >
> > @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
> >       ARGS+="-v "
> >   fi
> >
> > +if [ ! -z $MODE ]; then
>
> better: `if [ -n "$MODE" ]`
>
> note that quotes are really good invention for such cases, especially
> that default value of MODE is "take such named variable from user env".

Definitely better. Will fix. Thanks!

> > +     ARGS+="-m ${MODE} "
> > +fi
> > +
> >   retval=$?
> >   test_status $retval "${TEST_NAME}"
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index 514fe994e02b..9f79c2b6aa97 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -107,6 +107,9 @@
> >   static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
> >   static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> >
> > +static bool opt_verbose;
> > +static enum test_mode opt_mode = TEST_MODE_ALL;
> > +
> >   static void __exit_with_error(int error, const char *file, const char *func, int line)
> >   {
> >       ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
> > @@ -310,17 +313,19 @@ static struct option long_options[] = {
> >       {"interface", required_argument, 0, 'i'},
> >       {"busy-poll", no_argument, 0, 'b'},
> >       {"verbose", no_argument, 0, 'v'},
> > +     {"mode", required_argument, 0, 'm'},
> >       {0, 0, 0, 0}
> >   };
> >
> >   static void usage(const char *prog)
> >   {
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
> >   }
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
> >   };
> >
> >   enum test_type {
> > @@ -98,8 +98,6 @@ enum test_type {
> >       TEST_TYPE_MAX
> >   };
> >
> > -static bool opt_verbose;
> > -
> >   struct xsk_umem_info {
> >       struct xsk_ring_prod fq;
> >       struct xsk_ring_cons cq;
>

