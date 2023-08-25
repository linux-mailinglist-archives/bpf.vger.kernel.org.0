Return-Path: <bpf+bounces-8567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306778878C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559DC1C20F35
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62F229D2;
	Fri, 25 Aug 2023 12:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4C229C6;
	Fri, 25 Aug 2023 12:31:33 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949A199E;
	Fri, 25 Aug 2023 05:31:07 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5733d11894dso122677eaf.0;
        Fri, 25 Aug 2023 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966665; x=1693571465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRKIbe9km6CeNUkJxYwc6+rnZeYcY9trxyLwF4yKyMs=;
        b=cNf6HggT6H5bB1KJUjN1N/RPS0cln1ZWWk+GyjOtOhL8NlUBcjGIZSDGUJfWvXXvmp
         iFgtJp8lhNIIeIvHd0vBnXytgCb8/crtqQhmZPE5+Blxwq674S560hLPuxyC9XV5wYvE
         qORTfYN93VcQbLm5rSYI9ScPRoXQSt24KSDnl+JMRuJTN7fbfNgWag6UijaCrfsIfyTp
         UfzxYSQOR+kkc9XdND96tMNgscUp6wZaZzz9WVEu6EXCeihXIYbkT1WE9qt5daQgNiJM
         I8fqcaNDcyGq/XyxtYiUVM63Y5dfzGmCmbHBDszn1ktkkS5DT9NJHcK1R/9R9/T+ZvPb
         W6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966665; x=1693571465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRKIbe9km6CeNUkJxYwc6+rnZeYcY9trxyLwF4yKyMs=;
        b=RkD3PhRtIa7CL/F8s0oORRclYpavYGVaJU+fzE4sHSgij40FC9COvGllG3xHQfx2he
         l4Zb86KR6L3WvmSV3hIqQrf+zy7ax2ZnENDNsiwMVGAWYJsyvBfP6R54Hilo+II31Wgc
         nj2dmEVu7A+FVXxEKyxCiT5oe5O1kmDGwdaEsw9EktUQP2wVqjiMB+h//waAM6Pqe7Ai
         FtQC03V/gS+JDZ6cnTmOq0XIHtNfJ1gdU86Cu+swfkIEuLJDwNJDqnEy0Hl5CIi8PaRE
         7YLKU8DvqjhYc2jhi4rYzozS2k6gTXaWaJkbu80Azuyw1sQrlrgX3DU71uWfwdzMpOCN
         2qsg==
X-Gm-Message-State: AOJu0YzDscsilO2qmFZkKYhhj153HQIL2aB6FdAkcD4FU4DkW7C5pKMg
	jCRDlCB0HZy4UobPztYIno6/89bQjDJ3zTXnSKHI5rN0K6Fpyw==
X-Google-Smtp-Source: AGHT+IH8KeaZ4JVhL35+Edw7ObMw0tKMmTAtQ95xGkfNLVLhv9B12YWfbptMfkykRKSlOllYC6ZC1UroRldmZbwhSys=
X-Received: by 2002:a4a:bc82:0:b0:569:a08a:d9c5 with SMTP id
 m2-20020a4abc82000000b00569a08ad9c5mr17077662oop.0.1692966665381; Fri, 25 Aug
 2023 05:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-4-magnus.karlsson@gmail.com> <ZOiYOw0eSsU6dfRX@boxer>
In-Reply-To: <ZOiYOw0eSsU6dfRX@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 25 Aug 2023 14:30:54 +0200
Message-ID: <CAJ8uoz3LTC6XQ6SiS6KpY=bhVHgphU8_F29MzFdEvbKZKt7wtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/11] selftests/xsk: add option to only run
 tests in a single mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 25 Aug 2023 at 14:02, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 02:28:45PM +0200, Magnus Karlsson wrote:
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
> > index 2aa5a3445056..5ae2b3c27e21 100755
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
> > +             m) XSKTEST_MODE=${OPTARG};;
> >       esac
> >  done
> >
> > @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
> >       ARGS+="-v "
> >  fi
> >
> > +if [ -n "$XSKTEST_MODE" ]; then
> > +     ARGS+="-m ${XSKTEST_MODE} "
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
>
> what will happen if i run zc mode for a device that does not support it?
> what will happen if i run xdp mode for a device that does not support it?
>
> I know we will do nothing and exit gracefully, but i am wondering if
> xskxceiver should catch it.

Hmm, yes it would be nicer just to get a message that zc or drv is not
supported than that it does nothing. I can add two if statements for
this if you like? We do have the information already at this point.

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
> > 2.34.1
> >

