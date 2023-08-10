Return-Path: <bpf+bounces-7461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525237778B3
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A18628210F
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82031E1B5;
	Thu, 10 Aug 2023 12:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31041FA3;
	Thu, 10 Aug 2023 12:41:15 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D110C7;
	Thu, 10 Aug 2023 05:41:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76d198deb34so8229385a.1;
        Thu, 10 Aug 2023 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691671273; x=1692276073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FfjNDNgC24vs9Kdz3Xj80hL5fKYTUu+BDGtRZjA/j9o=;
        b=ZjTxzE0EjzlRfDTUtEekeM2g7RPcgcZ+KbFxnPzQqgkh1ro7l8FqrNd+rNU1YEIyd9
         gqFP41XWc13kz90KgvnFSWmQl9Y+gRm+SjR9ftLuev76phgyTPl3fDet2nQvMy4oK2NY
         +uytXAXlI/gQDVv/uXCQCcgQ44LED6kFsIJFaxebcI1cbwbplu8kANtKTcvsY8raMnxz
         GSWPF+CBXfHmWwjfK4/vIuGyZ1RuACG3cSfQmegmpPP7v9YqZJjmyN93VRC+EQwGpI/X
         1EE9clgDDNtaQ+HfVBD6SyI45ZMynwKju/g2OidTawhSlb5Tt9OB9tKUFxUgLiUBVG7h
         u2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691671273; x=1692276073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfjNDNgC24vs9Kdz3Xj80hL5fKYTUu+BDGtRZjA/j9o=;
        b=jXpZ5rc3iCl+EW9f4Ycpc0hsfztO9+/QIzEbl/LiQKRR++N63DPMqYxMjaEmtjPTHX
         y1RygmTHTuGUPwAQQdm+GRZAbt6cFQsw88Xl1xWmrrxhP8FRmaHNVu5whevTvN8vCdt/
         NMkJKweHs2EVz5ROiFIDThDv+w42uUmpNekPZah5CLFye4LETM+hqQQRtpY3jnA3nhIf
         bzvRdSPsIJeWEnXtgxLrWNDCMG0YEsjqTH9jQPNmmLAlT8fJdMp2UCUy4uy41S7P1z/a
         qhCEnCAkD/DyzSCUg8VclqBJAfrOhEzFGISg6h0KgFtiHZyB+Q4ojeY1af0Hde6vSgT/
         dd6g==
X-Gm-Message-State: AOJu0YxDx1mGkP2iTAXK91Uw8P0sbRsvTBkpuGbRs//uRNEWa1iaWqX6
	QjVDbtrRF1fa8qrKAonPTMjii0ULRVhFRgTpDpA=
X-Google-Smtp-Source: AGHT+IHsRaFUYW0gFyhcABKjtFZ0/TYe4GG+7qPeW4ujXO9zs6o/LXn7fjDwsz+alICGFUVZ6ql0R+kWLpVHc8jkJIo=
X-Received: by 2002:a05:6214:509e:b0:63c:7427:e7e9 with SMTP id
 kk30-20020a056214509e00b0063c7427e7e9mr334545qvb.6.1691671273646; Thu, 10 Aug
 2023 05:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-11-magnus.karlsson@gmail.com> <8cb436d2-0f7f-6c78-c4bd-08a2d4caa584@intel.com>
In-Reply-To: <8cb436d2-0f7f-6c78-c4bd-08a2d4caa584@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 10 Aug 2023 14:41:02 +0200
Message-ID: <CAJ8uoz19edB3d=wHhVAbHf-QhNhyNz7gUciXfZ=_f0boXJBoyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] selftests/xsk: display command line
 options with -h
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 at 14:19, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/9/23 14:43, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add the -h option to display all available command line options
> > available for test_xsk.sh and xskxceiver.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >   tools/testing/selftests/bpf/test_xsk.sh | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 94b4b86d5239..baaeb016d699 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > @@ -79,12 +79,15 @@
> >   #
> >   # Run a specific test from the test suite
> >   #   sudo ./test_xsk.sh -t TEST_NAME
> > +#
> > +# Display the available command line options
> > +#   sudo ./test_xsk.sh -h
>
> any "help" / "list" commands (that do nothing but print) should be (able
> ot) execute/d without `sudo`.
> Removing `sudo` part from the doc here would make it clear to reader too.

You are correct. Will remove the "sudo" here as it is not needed.
Would be nice if we could execute the list option (-l) without sudo
rights too since it does not involve creating any xsk sockets. Will
fix that in patch 6.

> >
> >   . xsk_prereqs.sh
> >
> >   ETH=""
> >
> > -while getopts "vi:dm:lt:" flag
> > +while getopts "vi:dm:lt:h" flag
> >   do
> >       case "${flag}" in
> >               v) verbose=1;;
> > @@ -93,6 +96,7 @@ do
> >               m) MODE=${OPTARG};;
> >               l) list=1;;
> >               t) TEST=${OPTARG};;
> > +             h) help=1;;
> >       esac
> >   done
> >
> > @@ -140,6 +144,11 @@ setup_vethPairs() {
> >       ip link set ${VETH0} up
> >   }
> >
> > +if [[ $help -eq 1 ]]; then
> > +     ./${XSKOBJ}
> > +        exit
> > +fi
> > +
> >   if [ ! -z $ETH ]; then
> >       VETH0=${ETH}
> >       VETH1=${ETH}
>

