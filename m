Return-Path: <bpf+bounces-13530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516617DA484
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 02:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DFA282686
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDF644;
	Sat, 28 Oct 2023 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMY1No3M"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CD630
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 00:54:04 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519B1CC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:54:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b7c234a7so23566245ad.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698454442; x=1699059242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0nwOxHPkB6i4ngyrlHDE1gqKKu9W57mHqmk4+8aKui0=;
        b=mMY1No3MdP0T6aLc1qOvLj/cpXsiT9KJa8+ZsiGVIQ4O4f0Lsjpfs0GVRu2e8LVHpj
         TxUXRY6P2G2v0bNksKqZQUMVgWZO9kmT1aW0p40FTS35EIPHsOd6AWyPM8kI3acV314A
         BUhfrrhhj10oK4T4s1DnNG0y4at6DEaW67xNHf0pkAoa/RdqKuj76BdtGx7tRrqhxR4Q
         hMlCBW27A1NZEx8yYnTWstVaj+bIeFAmzyUQcaPOVqFMfAD2r6iaQO0sD2Ygn0E2vrdb
         gVFl5Pg1M5CSgCeVnIzmdYL8Uqf/wBQ6dN3JwYtaRA8+vTn7IVkQLRGlu+hPLdq0i1Fl
         QFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698454442; x=1699059242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nwOxHPkB6i4ngyrlHDE1gqKKu9W57mHqmk4+8aKui0=;
        b=eRKDKyn7jgIuKyAw5av+Ky+bhlFJyCqwXhDAtigtpSOfNH1ZaanR59TvSo+PdC6OFn
         QRB9dtN6xQnr6tURdR6c8O+/vJjBusqKga4IXdMFkJseP5x+dqPwRRNENc3evSZV5EeL
         QEgMnxAijxb/G5RHjgUanOtKjteid3AV9h6vrcliTX5G9STTAtCG1X+vnt5YrbW+UCTd
         0vCArP6JkCHeC/k+cLyyZI/hu1rGKFQ/sfzOjgTUWbBHGeC1sfC1POiD+qsnlpIENCOs
         7eZIjNEizdSiJHrvNDVO3pO+iEtzCGEfSD1JLiPN1bbvpX8b/pkktuXV79DzwNuDmfP3
         IwQg==
X-Gm-Message-State: AOJu0YzRg5F5JKVwg348q6lyA22CeOa/HVuKkVVsUxqYiIgQX/0FfiEk
	oiSzXr2aqsQt2+PZj1ecy0Q=
X-Google-Smtp-Source: AGHT+IEAf1veSSQDzvDLsdcdpJms73aB1mksCFIGFRerP7NQiNcraROrMEszTOtzGispQtN7KpfEJQ==
X-Received: by 2002:a17:902:cac4:b0:1c0:cbaf:6930 with SMTP id y4-20020a170902cac400b001c0cbaf6930mr3480902pld.54.1698454441615;
        Fri, 27 Oct 2023 17:54:01 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b001c625acfed0sm2205725plk.44.2023.10.27.17.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 17:54:01 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:53:59 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in
 the generic config file
Message-ID: <ZTxbp+C7FMDNgxpC@surya>
References: <20231027212304.3354504-1-chantr4@gmail.com>
 <CAPhsuW5em+cY6HiwAyS0j5GwUQMoSXWUHTt45omXR6JDOXpTRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5em+cY6HiwAyS0j5GwUQMoSXWUHTt45omXR6JDOXpTRA@mail.gmail.com>

On Fri, Oct 27, 2023 at 02:33:34PM -0700, Song Liu wrote:
> On Fri, Oct 27, 2023 at 2:23 PM Manu Bretelle <chantr4@gmail.com> wrote:
> >
> > Those configs are needed to be able to run VM somewhat consistently.
> > For instance, ATM, s390x is missing the `CONFIG_VIRTIO_CONSOLE` which
> > prevents s390x kernels built in CI to leverage qemu-guest-agent.
> >
> > By moving them to `config`, we should have selftest kernels which are
> > equal in term of functionalities.
> >
> > The set of config unabled were picked using
> >
> >     grep -h -E '(_9P|_VIRTIO)' config.x86_64 config | sort | uniq
> >
> > added to `config` and then
> >     grep -vE '(_9P|_VIRTIO)' config.{x86_64,aarch64,s390x}
> >
> > as a side-effect, some config may have disappeared to the aarch64 and
> > s390x kernels, but they should not be needed. CI will tell.
> >
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config         | 13 +++++++++++++
> >  tools/testing/selftests/bpf/config.aarch64 | 16 ----------------
> >  tools/testing/selftests/bpf/config.s390x   |  9 ---------
> >  tools/testing/selftests/bpf/config.x86_64  | 12 ------------
> >  4 files changed, 13 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > index 3ec5927ec3e5..c22a068bc1de 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -86,3 +86,16 @@ CONFIG_VXLAN=y
> >  CONFIG_XDP_SOCKETS=y
> >  CONFIG_XFRM_INTERFACE=y
> >  CONFIG_VSOCKETS=y
> > +# VIRTIO/9P configs to run in VMs
> > +CONFIG_9P_FS_POSIX_ACL=y
> > +CONFIG_9P_FS_SECURITY=y
> > +CONFIG_9P_FS=y
> > +CONFIG_CRYPTO_DEV_VIRTIO=y
> > +CONFIG_NET_9P_VIRTIO=y
> > +CONFIG_NET_9P=y
> > +CONFIG_VIRTIO_BALLOON=y
> > +CONFIG_VIRTIO_BLK=y
> > +CONFIG_VIRTIO_CONSOLE=y
> > +CONFIG_VIRTIO_NET=y
> > +CONFIG_VIRTIO_PCI=y
> > +CONFIG_VIRTIO_VSOCKETS_COMMON=y
> 
> Please keep these in alphabetical order.
> 

ACK, I wanted to keep those related configs together, but by moving it to a
different file, per Andrii comment, that will address 2 birds with one stone.

While at it, I can probably sort the current files, which seem out of order
(per sort result).

> Thanks,
> Song

