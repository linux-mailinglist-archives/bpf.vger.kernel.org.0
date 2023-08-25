Return-Path: <bpf+bounces-8576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7DE78880D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352981C20A23
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A2D52C;
	Fri, 25 Aug 2023 13:04:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3EAD5C;
	Fri, 25 Aug 2023 13:04:11 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D11BE2;
	Fri, 25 Aug 2023 06:04:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a81591c73dso82395b6e.1;
        Fri, 25 Aug 2023 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692968649; x=1693573449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9WlV5I5uMhZM4F2qM/JBJpZl9Q3cSTvVPxorqe+tqs=;
        b=NT65cALhvPy26bvnEujd1qJlRorCWh9e5n4x7mNifNl6ZQ353kcD1gdDKyrnZaEgTB
         J7Lh+Cc0PEbGoYHvaNFPkQBpnsyxU2nRR8xgTjlCl84BJzWAVqBZDU6T9CMwSEIkxzw9
         nMFb3tmzFyyfkUEh7OYd9oevahHZI/wEPX2e9s9BwCo/tzzDuFECPgwkIEfH9f5VU4h6
         uNuBRXqJMSQBT5M8SAXcjN0VL/e6rcnb2P7v/j0k0u5HZruNmVf1/d9WcB9XAhndzy7H
         arcq/NKgfYh4FMoAkvsBEnYM2ib01iLW1xusPvOr6lPFd+PEjZ/aq6NEQz9CeV1Ivpsr
         nLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968649; x=1693573449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9WlV5I5uMhZM4F2qM/JBJpZl9Q3cSTvVPxorqe+tqs=;
        b=l9YdpF2k+bAxO5YBKcIGFtHeonc9F1GlbfYK/D2aNaoiBD/uoTpz9LYZ0gl5SQPvUx
         Og/1rmPcn1gX1rJiy3u/OnxKnzo09JWVr88OSJ/nYsnRqjNXZ9bKrBNW198UMUTnFjJd
         QiMBNs1wDwHnYAxmxZCAQDnqg9UGrOYk3jKG6JNRjM9qamsyMAKnjd+C/yUYt8kvQCzU
         RC4qjT1UTTCjhMkPpY4OGdvX6R+5K+/z0psNQ0OjooVj5PiGzcIvRLUrog3fAugPtjJg
         PCE+hNXvyPVvR98HisWUeCtLrmOcl9+391fii6BfO0jCnYbk4j3bdii3KdcAGI2ZiviH
         5fog==
X-Gm-Message-State: AOJu0YwB5hoEJeRv/F/KtYtPWG33JYm4bk2PPDqirgL90YI8AJmIHdC/
	CdUqv4o/kq0mfMSV4MAX/duwb9n4lSQr5/H9i1g=
X-Google-Smtp-Source: AGHT+IEHcY8aDd8Jn/kto8YEO74kgZFsbJfC7Jap2G0JIS6uGPMK4DGnFbs+KsKxTYZI8I0N7xZ4ANEp7F5C2K+0KeA=
X-Received: by 2002:a05:6808:4284:b0:3a7:5724:8bfd with SMTP id
 dq4-20020a056808428400b003a757248bfdmr16601909oib.1.1692968649541; Fri, 25
 Aug 2023 06:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-12-magnus.karlsson@gmail.com> <ZOilNr8AgqZKCUeF@boxer>
In-Reply-To: <ZOilNr8AgqZKCUeF@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 25 Aug 2023 15:03:58 +0200
Message-ID: <CAJ8uoz2pdVG0K62pQXnm6hgJxnp64eaQmQwNUEzSXX8DpPbSJQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 25 Aug 2023 at 14:57, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 02:28:53PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Introduce the XSKTEST_ETH environment variable to be able to set the
> > network interface that should be used for testing.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/test_xsk.sh | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 9ec718043c1a..3e0a2302a185 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -88,14 +88,12 @@
> >
> >  . xsk_prereqs.sh
> >
> > -ETH=""
> > -
> >  while getopts "vi:dm:lt:h" flag
> >  do
> >       case "${flag}" in
> >               v) verbose=1;;
> >               d) debug=1;;
> > -             i) ETH=${OPTARG};;
> > +             i) XSKTEST_ETH=${OPTARG};;
> >               m) XSKTEST_MODE=${OPTARG};;
> >               l) list=1;;
> >               t) XSKTEST_TEST=${OPTARG};;
> > @@ -157,9 +155,9 @@ if [[ $help -eq 1 ]]; then
> >          exit
> >  fi
> >
> > -if [ ! -z $ETH ]; then
> > -     VETH0=${ETH}
> > -     VETH1=${ETH}
> > +if [ -n "$XSKTEST_ETH" ]; then
>
> Sorry - is point of this patch is just to invert the logic and rename the
> env var?

The purpose was to make it setable from the outside and give it a name
that is more descriptive and targeted only to xskxceiver.

> > +     VETH0=${XSKTEST_ETH}
> > +     VETH1=${XSKTEST_ETH}
> >  else
> >       validate_root_exec
> >       validate_veth_support ${VETH0}
> > @@ -203,10 +201,10 @@ fi
> >
> >  exec_xskxceiver
> >
> > -if [ -z $ETH ]; then
> > +if [ -z $XSKTEST_ETH ]; then
> >       cleanup_exit ${VETH0} ${VETH1}
> >  else
> > -     cleanup_iface ${ETH} ${MTU}
> > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> >  fi
> >
> >  if [[ $list -eq 1 ]]; then
> > @@ -216,17 +214,17 @@ fi
> >  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
> >  busy_poll=1
> >
> > -if [ -z $ETH ]; then
> > +if [ -z $XSKTEST_ETH ]; then
> >       setup_vethPairs
> >  fi
> >  exec_xskxceiver
> >
> >  ## END TESTS
> >
> > -if [ -z $ETH ]; then
> > +if [ -z $XSKTEST_ETH ]; then
> >       cleanup_exit ${VETH0} ${VETH1}
> >  else
> > -     cleanup_iface ${ETH} ${MTU}
> > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> >  fi
> >
> >  failures=0
> > --
> > 2.34.1
> >

