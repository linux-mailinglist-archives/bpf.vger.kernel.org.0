Return-Path: <bpf+bounces-8579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A737888C5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CC11C2101E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD9DDD8;
	Fri, 25 Aug 2023 13:35:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCA20E7;
	Fri, 25 Aug 2023 13:35:15 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B6269E;
	Fri, 25 Aug 2023 06:34:43 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bb3df62b34so95823fac.0;
        Fri, 25 Aug 2023 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692970470; x=1693575270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtfGJuUQm0GaUGwoDwh2jow/cl2e4xD1xbhLlraXQh0=;
        b=C4fCAv+v23obyjetX0yxm9OrNMxtEMmx61fyigswLwWi+0eiWH77vi5cWWArKVkYVT
         F+BAsL0qSPGvoRjW8yLWBL1ejTLrdhIl+jR8FYOS6LrWf+TIMxGdIB0yAFaRL/8t/bd6
         l9MmUCHI1ZEAuK7GD0H81hYuk/PIw+6mU6dMEQZkPGFn2jY4NxfyCTBTziGJR52OQYkf
         6/xo9Lnofszl4JLBhpJskfCXp6QxyDIkw5nIVlgqwd+Uvukxb5NtMdR90LRR9N/lpmty
         vuTN1vGF0RfQ5AaL4xnLLWrxZUs75B2z4p0HjVXSBtoJdMMx7/BmzSKvZl6SX8cssvof
         XaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692970470; x=1693575270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtfGJuUQm0GaUGwoDwh2jow/cl2e4xD1xbhLlraXQh0=;
        b=JOMN2zGlFf3Po9uhut0tS/NYHuYQMtePe9jr7W/P3ZhF9EWGx0GxemCffTne6WDm/o
         425O1yOH7JeMdZKEFss9YYU0vtAvAt9ZxqkKNjWh7XDltL7tRDFK0Kqw7XITsDiYZ6rK
         rsa+vk9m09xBGzdlzBlWS9rhgoMCGX2To0qs8mRf0VW6yUz8gMZd0tkUIqmc/VfNDlBH
         rGcAnZSngXRlUaDwwMoei7hcOie25n69mtnJTG3Pi2wJThj+1EJiaAIhW6jOJjiBkPsU
         p4hR5TW0+Rw0QdJzMDB5zHz7ze+OoBa8TUswj2FRXW0BSBiFjiFFgXsobEi8Mz7adTf0
         z+Lg==
X-Gm-Message-State: AOJu0YwINH1O6ddmrzq7bKMByXuF9sRW88o5KOULmt3ezg5NjY+Ih2f9
	r6YfWh2Kwg0Q2jztgxFDfL6Q0aWna2g+ZCLWsB0=
X-Google-Smtp-Source: AGHT+IE909lqqbT++xwvJEVCRHPEYsaUl/c1NtO/gbPSlLa8Jj2y2/sRAB8S58GykadMmqGvifzH7vPT5MtR5YT0wts=
X-Received: by 2002:a05:6870:332a:b0:192:6fce:d3be with SMTP id
 x42-20020a056870332a00b001926fced3bemr19432773oae.1.1692970469841; Fri, 25
 Aug 2023 06:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-12-magnus.karlsson@gmail.com> <ZOilNr8AgqZKCUeF@boxer>
 <CAJ8uoz2pdVG0K62pQXnm6hgJxnp64eaQmQwNUEzSXX8DpPbSJQ@mail.gmail.com> <ZOiqX6jMIcHwAwgR@boxer>
In-Reply-To: <ZOiqX6jMIcHwAwgR@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 25 Aug 2023 15:34:18 +0200
Message-ID: <CAJ8uoz0mFUB3Pg8DU6k6aADywmGuZfds8qaUUnpCc1MBJhjc2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/11] selftests/xsk: introduce XSKTEST_ETH
 environment variable
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

On Fri, 25 Aug 2023 at 15:20, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Aug 25, 2023 at 03:03:58PM +0200, Magnus Karlsson wrote:
> > On Fri, 25 Aug 2023 at 14:57, Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 02:28:53PM +0200, Magnus Karlsson wrote:
> > > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > > >
> > > > Introduce the XSKTEST_ETH environment variable to be able to set the
> > > > network interface that should be used for testing.
> > > >
> > > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/test_xsk.sh | 20 +++++++++-----------
> > > >  1 file changed, 9 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > > > index 9ec718043c1a..3e0a2302a185 100755
> > > > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > > > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > > > @@ -88,14 +88,12 @@
> > > >
> > > >  . xsk_prereqs.sh
> > > >
> > > > -ETH=""
> > > > -
> > > >  while getopts "vi:dm:lt:h" flag
> > > >  do
> > > >       case "${flag}" in
> > > >               v) verbose=1;;
> > > >               d) debug=1;;
> > > > -             i) ETH=${OPTARG};;
> > > > +             i) XSKTEST_ETH=${OPTARG};;
> > > >               m) XSKTEST_MODE=${OPTARG};;
> > > >               l) list=1;;
> > > >               t) XSKTEST_TEST=${OPTARG};;
> > > > @@ -157,9 +155,9 @@ if [[ $help -eq 1 ]]; then
> > > >          exit
> > > >  fi
> > > >
> > > > -if [ ! -z $ETH ]; then
> > > > -     VETH0=${ETH}
> > > > -     VETH1=${ETH}
> > > > +if [ -n "$XSKTEST_ETH" ]; then
> > >
> > > Sorry - is point of this patch is just to invert the logic and rename the
> > > env var?
> >
> > The purpose was to make it setable from the outside and give it a name
> > that is more descriptive and targeted only to xskxceiver.
>
> and this is accomplished by not having ETH initialized here? What will be
> 'the outside' ?
>
> Currently I don't see much value within this patch, unless you explain the
> need for setting this from outside of this script. Maybe I missed some

Outside = from the command line or your environment variables. ETH is
not a good name to have set in your environment variable. Who knows
what it would be used for. with XSKTEST_* at least you know it is used
for the xsk testing.

> discussion from v1. I can live with this variable being ETH, what's more
> concerning/confusing to me is that for ZC we have to set VETH0 and VETH1
> to ETH and then use that later on.

That is in the old code. Nothing I am trying to address here.

If this patch is useful or not, I do not know to be honest. Just added
it because Przemyslaw suggested that we make the mode setable from
your env variables in your shell. Weird to have the mode setable but
not the ethernet interface. So either we drop both and make it
impossible to use env variables, or support setting both from the env
variables. Do not have a strong opinion either way. Maybe this is just
an unnecessary "feature" that will not be used.

>
> >
> > > > +     VETH0=${XSKTEST_ETH}
> > > > +     VETH1=${XSKTEST_ETH}
> > > >  else
> > > >       validate_root_exec
> > > >       validate_veth_support ${VETH0}
> > > > @@ -203,10 +201,10 @@ fi
> > > >
> > > >  exec_xskxceiver
> > > >
> > > > -if [ -z $ETH ]; then
> > > > +if [ -z $XSKTEST_ETH ]; then
> > > >       cleanup_exit ${VETH0} ${VETH1}
> > > >  else
> > > > -     cleanup_iface ${ETH} ${MTU}
> > > > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> > > >  fi
> > > >
> > > >  if [[ $list -eq 1 ]]; then
> > > > @@ -216,17 +214,17 @@ fi
> > > >  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
> > > >  busy_poll=1
> > > >
> > > > -if [ -z $ETH ]; then
> > > > +if [ -z $XSKTEST_ETH ]; then
> > > >       setup_vethPairs
> > > >  fi
> > > >  exec_xskxceiver
> > > >
> > > >  ## END TESTS
> > > >
> > > > -if [ -z $ETH ]; then
> > > > +if [ -z $XSKTEST_ETH ]; then
> > > >       cleanup_exit ${VETH0} ${VETH1}
> > > >  else
> > > > -     cleanup_iface ${ETH} ${MTU}
> > > > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> > > >  fi
> > > >
> > > >  failures=0
> > > > --
> > > > 2.34.1
> > > >

