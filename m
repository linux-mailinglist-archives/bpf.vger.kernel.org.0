Return-Path: <bpf+bounces-34119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E392A87B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D951C210FF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61814D435;
	Mon,  8 Jul 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHgVXsfF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838714D28B
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461204; cv=none; b=lpSVZJN+c/z7TQ1AaSlLZN3XrCjUsdcb+ZlRYDieJQPh5uFxWPOkYfh25w26qHbfHkeHW3RfpGOrjYuiBxiSnd1ehtClel8SnfSx0MW4RhyYf2IFxssC/k1d+3EXYluNT/frtPUOEd3WSTudaAsvRUC6PclZ4WllBwwvnvq5s1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461204; c=relaxed/simple;
	bh=Fwq598LR+8mlQO2p6TjLnld1n/7717Cfs4527OzaG5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mU+rmGOZv9ugI4uhCt7j2RFWw4l3gKJU84y+vvmmnCqVj1EVgbqGMUvkibWd2bXw/orA+b+czJxYJG4kfeP5ZRabutWYlMTiY+UjfNg8pneUBsGooF1kWmvAF6MGIUGaYZ1mm26eSPBxkdM4Ta+8SwbRG4w653ayq9SQApKQmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHgVXsfF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70df213542bso2057498a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720461202; x=1721066002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=112+AZPpcobXP36ro48y/cab7TQ2jEnz8UtIfQ93aro=;
        b=NHgVXsfFovLAowO5sZEXVmZI6r33+vHzr4g/SoxUEwHls2S7i+bNq8x53W/WuaepUm
         odWhK5VP+HuOTGzFNZZPJs+1dREJbto5MzpVCQxpGDWmiLTLXb0wWlITdw93CAHJ+LWd
         BHe/mQHxsPbX+g52VmIXwtyhAthjHX1p5F1jpFVx+lc8GbPZggHANAcfPDw8DPSYFO08
         79y4u3hBy6uehKwglu1UA+8d8pX9L/BUUkYNcyI24sbQYAxKQ3M5+v3nWtA5/NTaCwRs
         Kgp3/Y9AqsksvoWsiM/Akt9eeRI66JncR81CfQuBIM1725rMm67OJhKhynfnOcZhFICv
         ovNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461202; x=1721066002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=112+AZPpcobXP36ro48y/cab7TQ2jEnz8UtIfQ93aro=;
        b=ZALwL1eWMsYg40HJp5OMv2Ke2RwUANiwBs+EdIirlUMWtwmBrFesrUfMA55qA/eb8q
         LBc1TbqaMwg3cWjQmLnzN+6jLsJzulA+SeHSdJBV+E3onYX4B4NJXZpkA7BMhZQM8RUv
         NO50kKiPqnjlGZTpch5eJs90Z2w0iEim5K2dEFSsKaYLTH+eKdhuhdyyxE1+n1KdPxOo
         a8W7iuxGk6pFq2zaRDzLaPjor4Cfi2vjBn7kx9lCmhcT8rZF6+Hr7CyX9ZJrDu3jvDtQ
         6anXZFxncI55mQamgR1VY95MvRX+G6Nx6znxZGITWxjuHPoQVvDQXNuGH2s8yX8e6sUe
         WYiw==
X-Forwarded-Encrypted: i=1; AJvYcCW383DrxXAOLoznS4n+nD/9L7UejYtMQER8oM4N6ddl4tJNf8IggdHnPmbkv+SvVmJ6f3sYqzSyqDLRQJjygVxUUOTt
X-Gm-Message-State: AOJu0YyM3SmThbTa2NoNJhu7Yt6+qwhLEAqteSW14yK/MmA61IsRpPl/
	pVvFRdT4CaSWeN5BgsZyARbmQgEoGXUlwKFVUfwATzZKU+iU6gAPOgFYsg==
X-Google-Smtp-Source: AGHT+IG1OIRqWOCSBvf/XrV9uBRI71eAhqMgmUye+MYVPqXfRCMTliVXGuaxnxpPEFMO9spnYd16Gw==
X-Received: by 2002:a05:6a21:6d85:b0:1c2:96f1:a2ce with SMTP id adf61e73a8af0-1c2982038e7mr162975637.3.1720461201972;
        Mon, 08 Jul 2024 10:53:21 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a3132csm1420365ad.112.2024.07.08.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:53:21 -0700 (PDT)
Message-ID: <2422bc243643af56bf4646e6468b5489a3c7769c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: improve skeleton backwards compat
 with old buggy libbpfs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Jul 2024 10:53:16 -0700
In-Reply-To: <CAEf4BzZVMRtcM6dtLApzjq5zd18Nw52dC0eOJRfHtW+uDaDkLQ@mail.gmail.com>
References: <20240704001527.754710-1-andrii@kernel.org>
	 <20240704001527.754710-2-andrii@kernel.org>
	 <dbb10260a5c7df773f8205333e1433557a22d3c7.camel@gmail.com>
	 <CAEf4BzZVMRtcM6dtLApzjq5zd18Nw52dC0eOJRfHtW+uDaDkLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 10:15 -0700, Andrii Nakryiko wrote:

[...]

> > static inline int
> > profiler_bpf__create_skeleton(struct profiler_bpf *obj)
> > {
> >         /* ... */
> >=20
> >         map =3D (struct bpf_map_skeleton *)((char *)s->maps + 0 * s->ma=
p_skel_sz);
> >         map->name =3D "events";
> >         map->map =3D &obj->maps.events;
> >=20
> >         /* ... 4 more like this ... */
> >=20
> >         /* ... */
> >=20
> >         s->progs[0].name =3D "fentry_XXX";
> >         s->progs[0].prog =3D &obj->progs.fentry_XXX;
> >         s->progs[0].link =3D &obj->links.fentry_XXX;
> >=20
> >         s->progs[1].name =3D "fexit_XXX";
> >         s->progs[1].prog =3D &obj->progs.fexit_XXX;
> >         s->progs[1].link =3D &obj->links.fexit_XXX;
> >=20
> >         /* ... */
> > }
> >=20
> > Do we need to handle 'progs' array access in a same way as maps?
>=20
> Given bpf_prog_skeleton has never been extended yet (and maybe never
> will be), I chose not to uglify this unnecessarily. My thinking/hope
> is that by the time we get to extending prog_skeleton struct, all
> actively used libbpf versions will be patched up and will handle this
> correctly without the hacks we have to do for map_skeleton.

Understood, fair enough.

[...]

