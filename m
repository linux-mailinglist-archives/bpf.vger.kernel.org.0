Return-Path: <bpf+bounces-8573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEA77887D9
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F07281470
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E9D523;
	Fri, 25 Aug 2023 12:54:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D43C2E0;
	Fri, 25 Aug 2023 12:54:27 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A352118;
	Fri, 25 Aug 2023 05:54:13 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4108e0ec4d0so1550711cf.0;
        Fri, 25 Aug 2023 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692968052; x=1693572852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwEmxrx9+QpwqzKwVMBIoNd1qZa5shtIpSb4Mytf0Vk=;
        b=XUQBnT2CVaYrvauMdU7eTh2NWhY0oW6Lrv4U2UQdhNcsml6Y9ubtY3KGDXhoppo9gL
         xvsXrr/3YpncHwSd+xd49wj7n6Q5e79hKF62pTP6v3ntSPLFazwdShEHYyCBMheOqlTm
         vgPnUSMVl7JYXkPXRxYsl2qdhdiTrV7VqrfDBhAqJCglAz3Ay5c0zntw9n4TH+GylEQG
         sUizQ+YJKKo65QMifrBdtnySYLfhkOjE3Rz3FtHgsLKFB1VmTff5QNJwMraCE1T35pRx
         9SbE7SCXhMgRc4XCeHGhIhF8nQ6Xe4BG8jOyW7f+kXfW+4E8++HB2cmw1aJ3nfLqC17S
         Frtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968052; x=1693572852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwEmxrx9+QpwqzKwVMBIoNd1qZa5shtIpSb4Mytf0Vk=;
        b=SqAYTf/eYSKwrHIkQ0iwLCrdBxb0r8g8l7lL0V30j0Ft8+kT32wzkQIw1PHWL3tTTU
         f2gSQQmEy/weUh2/FJ0KjZhL8H0CWGn30pLW5Hlp/H9sCsftTXeMbafJhxt3BO5w9b0R
         rHdDO05cFKtokdJWxDVtAMGBPv4ByU9LJQAeE8n3+rDusPvJH7gnzLpxYCGOdvRKnT/k
         HSDnU9C2+wvVtKpBBQsgjYFLvSqWIMohv+g5El445QXHLWBEWaKCgVjgKJEPptM1y7+7
         djSqE2v/+vNNVKB8vKhcWWMEeNL3oWYxcWCvlv8PuU42A6Shr8/0Blquo5hvBx7I5Tr4
         yaRw==
X-Gm-Message-State: AOJu0Yz++294L/VUD4zZVx0v0NYg/8Zo1VTnwcr9+IajUspm57hs1jpJ
	2WXEY7YfJshobI4o/MjSMKcaidkpa/q2u6UaPlI=
X-Google-Smtp-Source: AGHT+IHnzOdlKV2aZ9CRwAMEyjHcck1rWX0+BfEYnpC90qtUbtLjvEZcgtz5NzA4t3cGerhTnc/8sXc1gIG+6i3K7KU=
X-Received: by 2002:a05:6214:262e:b0:63c:7427:e7e9 with SMTP id
 gv14-20020a056214262e00b0063c7427e7e9mr21313366qvb.6.1692968052479; Fri, 25
 Aug 2023 05:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-11-magnus.karlsson@gmail.com> <ZOijXlBwnLxxyfFt@boxer>
In-Reply-To: <ZOijXlBwnLxxyfFt@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 25 Aug 2023 14:54:01 +0200
Message-ID: <CAJ8uoz1tukkS6MACytUyZtNo9WOzbUR_EBXiZBcc7zhXWefccg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/11] selftests/xsk: display command line
 options with -h
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 25 Aug 2023 at 14:50, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 02:28:52PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add the -h option to display all available command line options
> > available for test_xsk.sh and xskxceiver.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/test_xsk.sh  | 11 ++++++++++-
> >  tools/testing/selftests/bpf/xskxceiver.c |  5 ++++-
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index b7186ae48497..9ec718043c1a 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -82,12 +82,15 @@
> >  #
> >  # Run a specific test from the test suite
> >  #   sudo ./test_xsk.sh -t TEST_NAME
> > +#
> > +# Display the available command line options
> > +#   ./test_xsk.sh -h
> >
> >  . xsk_prereqs.sh
> >
> >  ETH=""
> >
> > -while getopts "vi:dm:lt:" flag
> > +while getopts "vi:dm:lt:h" flag
> >  do
> >       case "${flag}" in
> >               v) verbose=1;;
> > @@ -96,6 +99,7 @@ do
> >               m) XSKTEST_MODE=${OPTARG};;
> >               l) list=1;;
> >               t) XSKTEST_TEST=${OPTARG};;
> > +             h) help=1;;
> >       esac
> >  done
> >
> > @@ -148,6 +152,11 @@ if [[ $list -eq 1 ]]; then
> >          exit
> >  fi
> >
> > +if [[ $help -eq 1 ]]; then
> > +     ./${XSKOBJ}
> > +        exit
> > +fi
> > +
> >  if [ ! -z $ETH ]; then
> >       VETH0=${ETH}
> >       VETH1=${ETH}
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index 19db9a827c30..9feb476d647f 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -318,6 +318,7 @@ static struct option long_options[] = {
> >       {"mode", required_argument, 0, 'm'},
> >       {"list", no_argument, 0, 'l'},
> >       {"test", required_argument, 0, 't'},
> > +     {"help", no_argument, 0, 'h'},
> >       {0, 0, 0, 0}
> >  };
> >
> > @@ -331,7 +332,8 @@ static void print_usage(char **argv)
> >               "  -b, --busy-poll      Enable busy poll\n"
> >               "  -m, --mode           Run only mode skb, drv, or zc\n"
> >               "  -l, --list           List all available tests\n"
> > -             "  -t, --test           Run a specific test. Enter number from -l option.\n";
> > +             "  -t, --test           Run a specific test. Enter number from -l option.\n"
> > +             "  -h, --help           Display this help and exit\n";
> >
> >       ksft_print_msg(str, basename(argv[0]));
> >       ksft_exit_xfail();
> > @@ -406,6 +408,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >                       if (errno)
> >                               print_usage(argv);
> >                       break;
> > +             case 'h':
>
> do you need 'fallthrough' here?

Did not get any complaints from checkpatch, so do not know since it is
a case without any content on its own. I would say it is obvious that
it is "falling through" in this case :-). But I do not know what the
rule is.

> >               default:
> >                       print_usage(argv);
> >               }
> > --
> > 2.34.1
> >

