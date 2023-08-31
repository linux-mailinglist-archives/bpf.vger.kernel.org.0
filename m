Return-Path: <bpf+bounces-9068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0578EFEA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BDE1C20AB1
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23476125C2;
	Thu, 31 Aug 2023 15:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317C11CBA;
	Thu, 31 Aug 2023 15:03:11 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74795CC5;
	Thu, 31 Aug 2023 08:03:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso109404466b.1;
        Thu, 31 Aug 2023 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693494189; x=1694098989; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJr3S4oVZbd7ZT/Wt+7mrgyluXxLgkA2mmGZaMzWAxQ=;
        b=cJjlNM5J2cApuvt65DqY7DI9RPE4K3833or49Kc1/p0wDw3Jh0/j4r/sA8VMKqeoFe
         yzLouxxeEDKnsBxRXImWoBHcxHepMk8C2Iemc6ehkhYvJHMzPeLzI6hNaTh8vTcEIuih
         Br2OkTfG92GMI6mwso2/royffukGfzLCCrAsCuANeHJDH+CLaOr6Cb3Y80KamD/Spm1d
         tEUkjconAkbCAdwW6YcCYkJniHEGI0ueHiIVUn4LGSOkr1rTwyXFcYV87WOx8z9zADAA
         jjXTTjcF5JPQJcmwHe92liB2esdqQoPzREvEqYYDOaqaDsFQPxbZ6uuVZ0sXYK+od7d5
         QpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494189; x=1694098989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJr3S4oVZbd7ZT/Wt+7mrgyluXxLgkA2mmGZaMzWAxQ=;
        b=EKdRUrrBhfqNnmMttohZ96+pzerhMAAx9il4Bl/YrSzXVgas0KLLQwsT+VRSs25AWR
         mfomEV2gVw8S/GGFpuxeU+fhrOFs6bGJQq0dfWHhtig8M4/0UfGDcvP1pakXK2sUi8Vt
         FKolWc6WDq6zMt5nnmmQfRPN4mlO2aO8CniniASC1NwN6GPdywau8MyBJLWdf5lS4wSF
         Jx3CE6GkBHzdfRVyYmPICrG9pysCL0y74QfM+mDilePsv/oRom2mh2gtEIeiKjSRSMbE
         m0+1GU5Im2YKl5wI4wZp+4JuufAYIrxcQdJuYgTpOxB/iwVTWzxdTIwbHhXPY2ZBjiuI
         mb5g==
X-Gm-Message-State: AOJu0YyMQBaKm7DzKdmV970+scmujKDh5MuSd3cQyOPtnYr7zX+Xy7n0
	UH3mYvXw85WjKgdq/p0m9s4=
X-Google-Smtp-Source: AGHT+IEW+ktfjOUsEEI5CWESHXT9h4cOqIVOPWDVyT8ai1Es9Izu+9nja9zmyaHhiEK/bTn4jOXIFA==
X-Received: by 2002:a17:907:77da:b0:9a1:f21e:cdfe with SMTP id kz26-20020a17090777da00b009a1f21ecdfemr3796205ejc.58.1693494186444;
        Thu, 31 Aug 2023 08:03:06 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b009a198078c53sm834496ejr.214.2023.08.31.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:03:05 -0700 (PDT)
Message-ID: <082a6db6838d3aee5ca39eabd35d4da0c9691a0d.camel@gmail.com>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>,  Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Date: Thu, 31 Aug 2023 18:03:04 +0300
In-Reply-To: <de816b89073544deb2ce34c4b242d583a6d4660f.camel@gmail.com>
References: <ZO+RQwJhPhYcNGAi@krava> <ZO+vetPCpOOCGitL@krava>
	 <de816b89073544deb2ce34c4b242d583a6d4660f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-31 at 13:52 +0300, Eduard Zingerman wrote:
> On Wed, 2023-08-30 at 23:07 +0200, Jiri Olsa wrote:
> > On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
> > > hi,
> > > I'm hitting crash below on bpf-next/master when running selftests,
> > > full log and config attached
> >=20
> > it seems to be 'test_progs -t sockmap_listen' triggering that
>=20
> Hi,
>=20
> I hit it as well, use the following command to reproduce:
>=20
>   for i in $(seq 1 100); do \
>     ./test_progs -a 'sockmap_listen/sockmap VSOCK test_vsock_redir' \
>     | grep Summary; \
>   done
>=20

For what its worth, bisect points to the following commit:
147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")

Which was merged into bpf-next 3 days ago as a part of:
3ca9a836ff53 ("Merge tag 'sched-core-2023-08-28' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/tip/tip")

Scheduling changes uncovered some old race condition?

[...]

