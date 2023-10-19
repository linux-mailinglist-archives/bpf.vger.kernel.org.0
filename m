Return-Path: <bpf+bounces-12672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D37CF040
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29C31C20B90
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185663D9;
	Thu, 19 Oct 2023 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTSj+Cz4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E046671
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:41:02 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3802BB0;
	Wed, 18 Oct 2023 23:41:01 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b08ac3ce7fso3225035241.2;
        Wed, 18 Oct 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697697660; x=1698302460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSM0gtYPhT8KLNYeGoXpc/snxVUwQGh9ZlepoNZq59A=;
        b=OTSj+Cz4BjNWgavgpt0K3OBFS2xR+j/+urKiBf3lnhQz1PMQAbognbcjSrvklBPRex
         F1IBXBVJE4io8PXT81PjBpI0ZkVUbv+KRLu7PrINyXFHGArtCOFHH+LkA9orVYuz1l8h
         kzb2sBSHGHXsYMFnRRLU9gGkrn3Y1jqbBG4cYR7VUf4ES1tb1MnNV7HVt2H6bNRKT9Pz
         zyOrmN6Ys/lM3yfYku3x41BHXsdh4OebLow28y/PDn3PM9wYCeUS8DzvuyZwUKy56DTX
         6W7gOtI+8MzvLpe9DjVex5w6vqd1RPvHVN9lxdeKZOxUNZDTEPf7lB5M2CuQD7WlMu24
         WELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697660; x=1698302460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSM0gtYPhT8KLNYeGoXpc/snxVUwQGh9ZlepoNZq59A=;
        b=JFWX0HkAgwNz8LporUPSLQeGsFyDd6mijThPdnq7UaFg872dSV+Nn1ByT3JRBvoAYp
         1rezJxn4UlK0ooQHF2XFxcELcV8nmswSJtJDgtZsIBzXdF1+LoD81Hzty90h5FJs+s+Y
         YPf0nCfiU//zRAdCsQZIRD5O0n8yYIwvW84fWa6t3Y8Wa9CKA+L+xVWkdruxxY9xrVIl
         Smdk/tXgHpCqGabuIdn05zo2TtxdjXqmwqoIxbmVQpzb3PnFBdZ8Jdgbfn5zXYM37Q6d
         g2AwrNkHoumTK7GybVZNc+yz4AWkW7SovtmG4dkgn+Wsur2uyyM+RITF0qdYkg5i70CK
         Jquw==
X-Gm-Message-State: AOJu0YxAxdYca0qLS8hsx5o5huOcADTFNHw6Tz+EjvQEeksgttQbBdOA
	wIXVhAULYKvovgOorsFpx3iDYd6l5ELDVG9hqnA=
X-Google-Smtp-Source: AGHT+IF/q6vR7P0Z4aC3s+1pJ+SdIYgAWm2R6cZoaSZenJDxaiWDdWyZhcT8Fg6Zr3Hfo0L/NIPjLWNZm5YY8SEAwkM=
X-Received: by 2002:a67:c893:0:b0:452:5b16:c290 with SMTP id
 v19-20020a67c893000000b004525b16c290mr1290614vsk.7.1697697660266; Wed, 18 Oct
 2023 23:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-5-laoar.shao@gmail.com>
 <ZS-oGKUGgShsfOEH@slm.duckdns.org>
In-Reply-To: <ZS-oGKUGgShsfOEH@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 19 Oct 2023 14:40:24 +0800
Message-ID: <CALOAHbDd1+ArvEDX9AX2kg8Bfh3qksV-3w5Uc0RF9O8NBpPqLw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 4/9] bpf: Add a new kfunc for cgroup1 hierarchy
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 5:40=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> One nit.
>
> On Tue, Oct 17, 2023 at 12:45:41PM +0000, Yafang Shao wrote:
> > +/**
> > + * bpf_task_get_cgroup_within_hierarchy - Acquires the associated cgro=
up of
>                          ^
>                          1

Thanks for pointing it out.
will fix it.

--=20
Regards
Yafang

