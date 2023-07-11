Return-Path: <bpf+bounces-4660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943D74E30B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920AF1C20C0C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D899621;
	Tue, 11 Jul 2023 01:10:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A653382;
	Tue, 11 Jul 2023 01:10:26 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D810C1;
	Mon, 10 Jul 2023 18:10:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso77615991fa.3;
        Mon, 10 Jul 2023 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689037780; x=1691629780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynUCCAwIsl1Knhawj6TPxHdOw1pZmTll5Cp5Uex+0IE=;
        b=Wspu0Rw0rq4G+yiT/xcrDqPKF9DuPIpcT4Hwu09vhMoNJ/sUP8l3WPmRhgomBLSpG9
         HeLd27oJKMV/ySIqjmqs3GQQUh6XwGit8BR640LihItLdaMOTxTwnK7zCfbogQQpr5Zj
         /hoLmqgsW+3mJPBXI4CmDSSv44w/FlGBq+WC0zMpcp+hO8b03SBrK7gUrrgWB9PUlgFQ
         +eLAKHoA/DzgiBh/GNTyrGMRWeoJNo4o4gA2Fc1NI1q3ccV8RXuybgpUjYeY5ap3T1E0
         4NNJ69pDBB5nRbw2xtHOFpN9StfXLEMqhN84/dnozhdxJbre4JcDH7yUhP0c5xPIgICz
         ChKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689037780; x=1691629780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynUCCAwIsl1Knhawj6TPxHdOw1pZmTll5Cp5Uex+0IE=;
        b=VyGFKF/QHJbTU1kBTGFgA6WTYnqS+Q6efKgcCTPz55cv1ilMudpHJiz/MnfHkMeay5
         oGcLffmQ/AMBI8VIJhpvS1q1OU2EYoy9L1i1Cm8SNvopHaBVXPjxDCbo+D91M6YWKko1
         YCQXidI9H/CtNXB9lP9XnVp5Lb+z/Aphe8UREolwGJrXYrj+6XqdewZ5BVjqr3yuk+3u
         RxXOdd2f4dLEeblLxXqWrKlWBlkpvhk29TJ5ugedwL+41bvKi8tfVxBqrw5dy9giBBXe
         2hPvaLbHK6gPTseDaR6opTgqWRzbNDOzW7yl7k8sMUrtx9IpY3L1qXNd97HV6XbxX6g2
         NNaw==
X-Gm-Message-State: ABy/qLaEGosR2vGpjL+4uQ89B7J4f0XC+ZMqbSIbaAHidc449b079jIb
	xF3Qy46nXmn/APwJwHaOG0+ZZKRst/7EyML4z6DD6isL
X-Google-Smtp-Source: APBJJlGfk/0uBNhDBcz+njgSqPxjFnfVmGtc7ljfQQOeW1XdVcK06I65ylABsXv4uRC0EJKZFcqzd9sATTq3icIHxLw=
X-Received: by 2002:a2e:9d16:0:b0:2b6:e958:5700 with SMTP id
 t22-20020a2e9d16000000b002b6e9585700mr5857244lji.4.1689037779714; Mon, 10 Jul
 2023 18:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com> <20230706204650.469087-11-maciej.fijalkowski@intel.com>
In-Reply-To: <20230706204650.469087-11-maciej.fijalkowski@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 18:09:28 -0700
Message-ID: <CAADnVQLKDratBrgvwHzXZBW9chH9SBXPhnXpExYwu0BbRVFPjQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/24] xsk: add new netlink attribute
 dedicated for ZC max frags
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, Simon Horman <simon.horman@corigine.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 1:47=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Introduce new netlink attribute NETDEV_A_DEV_XDP_ZC_MAX_SEGS that will
> carry maximum fragments that underlying ZC driver is able to handle on
> TX side. It is going to be included in netlink response only when driver
> supports ZC. Any value higher than 1 implies multi-buffer ZC support on
> underlying device.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

I suspect something in this patch makes XDP bonding test fail.
See BPF CI.

I can reproduce the failure locally as well.
test_progs -t bond
works without the series and fails with them.

