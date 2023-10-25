Return-Path: <bpf+bounces-13283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC97D77D7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 00:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2449A281D44
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F137C8A;
	Wed, 25 Oct 2023 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtxbMBA3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CC374F7
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:28:35 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAE4191
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 15:28:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2925959a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698272912; x=1698877712; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yi6GTY5FGRRh0BrXl/Ig8eic89FBn4yalxmbVERoBgI=;
        b=RtxbMBA3svZm0kQpi/QyTktFa037R1My/KZNdMrcjHoAaSgzCGM1R6gdfpFxcKQAD/
         wjW1QMZ9Oetmql+vXgm6rS+BszlG2O3HIU1ncGYHlphvWM8NBnzkGDptMAZO4mdsDMCc
         47GdcIQqxU5nPVlTerYOIhWm43M/JkoM6ED5ff0x/yorhuQvvS4MLH6loLycicYKciCO
         eHzuUabZ50AwPIiODCzxvzdJNzDluR+odsPARxdJeqjtrs8Q4gKtU1+EW2CW+8inrv8I
         5nhq1u/RqglUfD80qxJifYYFoZb3gEczx+NPejDRYtsQK86X03skKRaFBwWYH5Xv3Xsb
         nt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272912; x=1698877712;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi6GTY5FGRRh0BrXl/Ig8eic89FBn4yalxmbVERoBgI=;
        b=fOR8nmwKSsQv42eDGqop4+QX0iF1OX7zmF92an16jwpdfqDO0wfuX6XaQGcwAD+yYG
         JDGFlV/Wg6lxzEWhDHvbDM2EvIu3DYXAdMp1fwctXIMZxdYVkZKwVz2cpmI0PZdrtARG
         6GLZW1QErk1cc4YgqfxQl5KIeZhHuFhmHNuU2hoMc5xKbvwyHkHlQTGN33BqGuAScgh3
         bq+TMSnwpT4RwH9+6GSaH04ZYA9ImpKRR6j9LAPm7AFqY99JRRYxlCb6WxgnScqa+32S
         zyYZNaC0ulC83gq5P2RkNgM33FDvOapFJN7TkFUgl+L1Sn/IJULWDcgO2szt30HTTvcE
         f6Nw==
X-Gm-Message-State: AOJu0Yy3+cH+NESWUP9YxvAX/+GpOL2oBIQO9EDhnDG7JoXFKKyMpOMx
	O4hW/cV92FaJNwG+heqWygM=
X-Google-Smtp-Source: AGHT+IGYIwfTyX1Wx+4v2YdzI5W1FmeZsnVPfMsjo5eewqL6PQlZkDEYHgij3cP18BtfPQwkoJNYLQ==
X-Received: by 2002:a17:907:9445:b0:9a1:f1b2:9f2e with SMTP id dl5-20020a170907944500b009a1f1b29f2emr760526ejc.2.1698272912356;
        Wed, 25 Oct 2023 15:28:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id pw17-20020a17090720b100b009bd9ac83a9fsm10508485ejb.152.2023.10.25.15.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:28:31 -0700 (PDT)
Message-ID: <f65dd024a49323f4b0e282c1f71384b96f170d16.camel@gmail.com>
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, mykolal@fb.com,  bpf@vger.kernel.org
Date: Thu, 26 Oct 2023 01:28:25 +0300
In-Reply-To: <ZTlerFwlAn3AP+o4@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
	 <ZTlTpYYVoYL0fls7@kernel.org> <ZTlVAtFw7oKaFrvl@kernel.org>
	 <ZTlaoGDkALO2h95p@kernel.org> <ZTlerFwlAn3AP+o4@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 15:30 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 25, 2023 at 03:12:49PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > But I guess the acks/reviews + my tests are enough to merge this as-is,
> > thanks for your work on this!
>=20
> Ok, its in the 'next' branch so that it can go thru:
>=20
> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>=20
> But the previous days are all failures, probably something else is
> preventing this test from succeeding? Andrii?

It looks like the latest run succeeded, while a number of previous
runs got locked up for some reason. All using the same kernel
checkpoint commit. I know how to setup local github runner,
so I can try to replicate this by forking the repo,
redirecting CI to my machine and executing it several times.
Will do this over the weekend, need to work on some verifier
bugs first.

Thanks,
Eduard.

