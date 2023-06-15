Return-Path: <bpf+bounces-2641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E1731C5A
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87621C20EB4
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396215AEF;
	Thu, 15 Jun 2023 15:21:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6520F5
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 15:21:20 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73B12E;
	Thu, 15 Jun 2023 08:21:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso10612790e87.1;
        Thu, 15 Jun 2023 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686842476; x=1689434476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZGTBGF0vX5H+cBn/kub68kDoPw51WDE6/g4hKhy20Y=;
        b=r4EC4w7/hLiXXodN+vKFdcpd3m6kuBmapXE1AOZ6UcODUUTNVzMmph/aqZ9g+LHKUE
         EdXsIoE6Ls5mnlOrsmCD4NlfyrOjxzYScYm8sC3mWUL1Gs8T+MXQ/gVice3fQ4fG5erc
         cNB1kK6dMFSJ2AKVENHLwCmccTRZ74ietR4NH+gBOVeQ2fZw/tcQGHN5FX4NlQ/W0QHO
         wT8vqebLC/N+KLrubvrPKCK5+EWqqTWIhH+knrayrc1ELV8AAX8AlyCvi3UNOQh/OJuS
         AvffhwZptYWY5xgb/XqbMEbJewi89360Pg5ucZzksey9tgotY5oqNlsK+QC4BF5RTDRa
         5a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842476; x=1689434476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZGTBGF0vX5H+cBn/kub68kDoPw51WDE6/g4hKhy20Y=;
        b=c30Kx2UUIex1cMGyFWvX7SBP85h0hzrtRz4Y4luZONdKPmmWJjAnngZfoBgPOnzTS9
         vnS0aP4H4DVEgYAU9j1jDCbbFotx4KLNzCSQRzNgUYlnyR+HJz3+BnZEG5J8T7/fyoYq
         cpQvt0K98/CNX8fFzMjk8qvWIVIuv68yteG6zF+7hLoD+uUCT4c3E0sxuoYUiWfhBeG2
         HD6D51hpUqHpd/+cagvo9wxw0NMsFMfIZI7XmggLCqfwZth5XK8rkv0oUnM0nquH6uv/
         5nj4DOWcd6MbaTw4b7WSAIqFFoHl/ZhHpGmL8DFfAzeWUqDlaVA5JqNpwKvoNySdCjkW
         doAw==
X-Gm-Message-State: AC+VfDxZCSvGACcNrwWfCOd3iEOgbWrORWSZaYJxjaN/0rwPTi2x6TC8
	tAG1pIEH7ivHdOmjixOVEUQA5WYY8i0=
X-Google-Smtp-Source: ACHHUZ5swJgtHHCiscBDnu3XBnMgyD+DMNaqAeOlJnpWSzZVzCbi2gRUZcpL3gpmA/8ttmCY4rWXFA==
X-Received: by 2002:a19:440a:0:b0:4e9:cfd2:e2d with SMTP id r10-20020a19440a000000b004e9cfd20e2dmr10245992lfa.65.1686842476163;
        Thu, 15 Jun 2023 08:21:16 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v13-20020a056512048d00b004f84706d761sm177758lfq.20.2023.06.15.08.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:21:15 -0700 (PDT)
Message-ID: <e2620d326d60acb4e5fbd31a1bc9391b14395dcc.camel@gmail.com>
Subject: Re: ppc64le vmlinuz is huge when building with BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>, dwarves@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 15 Jun 2023 18:21:14 +0300
In-Reply-To: <8d6c094ec12c32e4166299f4a89be7fa4d0f9360.camel@gmail.com>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
	 <8d6c094ec12c32e4166299f4a89be7fa4d0f9360.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-15 at 18:15 +0300, Eduard Zingerman wrote:
> On Thu, 2023-06-15 at 12:32 +0900, Dominique Martinet wrote:
> > Hi,
> >=20
> > coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issu=
es/12563
> >=20
> > alice noticed the kernel packages got quite bigger, in particular for
> > ppc64le I've confirmed that the vmlinuz file size jump when building
> > with BTF:
> > currently released package with BTF:
> > https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.3=
3-r0.apk
> > 272M	boot/vmlinuz-lts
>=20
> Hi Dominique,
>=20
> I've just checked the linked apk and it looks like DWARF sections are
> not stripped and take most of the space, e.g.:
>=20
> $ llvm-objdump --headers boot/vmlinuz-lts | grep \.debug \
>   | gawk '{ sum +=3D strtonum("0x"$3); } END { print sum; }' | numfmt --t=
o iec
> 228M
>=20
> Compare this to BTF sections size:
>=20
> $ llvm-objdump --headers boot/vmlinuz-lts | grep BTF \
>   | gawk '{ sum +=3D strtonum("0x"$3); } END { print sum; }' | numfmt --t=
o iec
> 3,9M

Heh, Alan answered while I was looking into it, sorry for the spam.

>=20
> >=20
> > test build without BTF:
> > https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
> > 44M	boot/vmlinuz-lts
> >=20
> >=20
> > Is that a known issue?
> > We'll probably just turn off BTF for the ppc64le build for now, but it
> > might be worth checking.
> >=20
> >=20
> > While I have your attention, even the x86_64 package grew much bigger
> > than I thought it would, the installed modules directory go from 90MB t=
o
> > 108MB gzipped); it's a 18% increase (including kernel: 103->122MB) whic=
h
> > is more than what I'd expect out of BTF.
> > Most users don't care about BTF so it'd be great if they could be built
> > and installed separately (debug package all over again..) or limiting
> > the growth a bit more if possible.
> > I haven't tried yet but at this point ikheaders is probably worth
> > considering instead..
> > Perhaps we're missing some stripping option or something?
> >=20
> >=20
> > Thanks!
>=20


