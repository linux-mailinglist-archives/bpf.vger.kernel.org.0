Return-Path: <bpf+bounces-74096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FFC48EAB
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3674D4EEE4D
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AA31B127;
	Mon, 10 Nov 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbL/IFuv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EC2441A0
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801619; cv=none; b=iktEyjwfC3gAYH2xJdJcKSWJ1aRM+HaDYL86kqaVwwsahYcSLoBHIMS5NJRmTr7CLZVaQ8exyVbILWbUJM5l3gI52PC8RIPhygIPhuAmi0KAs5eIeZBppWUtufOSd3lQMJtq+/exG7ONUSLzvCm2wa2bVa8KxMTDehBolRD65N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801619; c=relaxed/simple;
	bh=I62HfsaXJviTD0oYYt3HL+abOLh6JDUNa2oOncj76Dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TD+wEhq3Cd4/h5Y+cX3rXftQjW8iCyEndxy4aJEtySvZ2LoJUMX+/4wWzXq7icFtNETNlbu7orwxi8Ng9bsiGKL7RIBMu0c/rV4OcUTdCh0vgPBLWAxYyVUGCS67knTY0OJrduhvQTZ3cIeLK9brUfatk7PAzcGRRPaaeRWDfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbL/IFuv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298250d7769so7663755ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762801618; x=1763406418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I62HfsaXJviTD0oYYt3HL+abOLh6JDUNa2oOncj76Dg=;
        b=KbL/IFuvmRg52+OgJNS1r4BhoSZdw8qVp4GsBwm5SZf5GWexIp6DFnKPOkI2RwlU60
         b7ihZb+ecjJOV5Ou6wwX1C8rjXl+vBeGbTmJPM0chYq3TpzHrxq1Hi9ABV7YKuynhOn0
         o5l6tWRXt4ojN6XaHUkyR9vpL6wwYob30bBOFQPth+BLBim5s3iNuWRwaY9mYCBFQgsr
         L8S/GZuIOJ9EzgXrxD5XrO2+4mpozR29wG+0CpsY3wqhED2CM1Px0kKmVpuTm9HLcNqx
         ZdRZkidCrCWFyhXeg225BtOrsJd5qtzKJ6GFP7jq8j0el14iuG4T0SVpyiwExpxsCwFY
         cClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801618; x=1763406418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I62HfsaXJviTD0oYYt3HL+abOLh6JDUNa2oOncj76Dg=;
        b=CrRLtCCTOlF6xsQoDp2kFb51speV/USC5Dk4Kq9l/6HI6j0RzJ+qovcFaI3QY4hqSb
         wOAu7OKFqVB6QKvMV+k7jgJtztsCLiGjSP4RSE1BUi9pbgQ1aX/HVsR78wZv/blZiM5q
         2IHSgP+VizelZAmxdWvwYk18usz3wfBcrQz+dNPl95URvSZO5/bZeX/aMxMP1QKON708
         hKasaf5d9YfrM1sesd1J679twp3UNomXxnv6jfWvurtWO27a6QMzx2nm5Mz5UeUq+gU5
         uj9aE93VYJwbKYNxoZ2wcUQ+nt1u/Sc7ta5X6g/KhLtQHZptACeVjPtWS+uouezZ7os6
         Ds1g==
X-Forwarded-Encrypted: i=1; AJvYcCXyr+/BsOagWSQxqBR4FxBKSd2dynQ8bMQvbRsDRNDClIDEi8Q/83lRAF8hcgzkS7Csqg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCe+VFMp31p+H3N555T/x5rbQf1aKoNjjonbWWYwOInDkFP3o
	20b3oAzoE35M6UGXdotK8GRtCkMORE5KGzFOZK6Zfi5bNGRlqtZnvENV
X-Gm-Gg: ASbGncu/l67PJ4KY0OLP1Q4w92UvM93LRj4uTbeU5Fd399pc13M+fdsptJANaOPZuTv
	/h8/+9IXGWKG958Zh522Dy/yAqlWqBYRex8xD14OfA694WffgOU396mseBcFzorbV5GsE0sZYea
	iIK0kpX2J2u69cJwUtMTgOyeL8GBP6mAvnTFuRems+Gyt1PQdTSJJTK+fVDASw5pV0gi2IxIv7x
	BBDYMcGCHIEO10nM09C4KmGzNtAwGTtJshGjZLtK5hU/Em1Qjh+fWUeRP9/Oj/tjEbqlaMpQ1M8
	vFAE8ap2kJmHrOZxTsMqNoM1FcEx9yKJ801JvWD0m/XQooZuENnDcDbrRX9QBLOKrWcmiSujOg8
	Zs/ASaQYoafYeg+IsO3n2lW54rBM3kbHL1w7gfPNhLAWaXzcS/4QTzB81pXPyDPushn/2zPWg+Y
	oFT6q1+MufrBdbWisLKzFGlIpNJVOV5AE0gzE=
X-Google-Smtp-Source: AGHT+IEORoP5wfiyglUtznbXaUNpfkanl1hsPW2gsDIZgNMibqG79z6Bn/MhaZARIGhaczYk2LMo3w==
X-Received: by 2002:a17:902:ea0a:b0:297:c638:d7c9 with SMTP id d9443c01a7336-297e562e197mr136228105ad.13.1762801617440;
        Mon, 10 Nov 2025 11:06:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccca64sm153446015ad.105.2025.11.10.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:06:56 -0800 (PST)
Message-ID: <a27413bc0fb9a4d8925366b239aa08f195164810.camel@gmail.com>
Subject: Re: [PATCH] libbpf: fix BTF dedup to support recursive typedef
 definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: polo <paulhoussel2@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Houssel	 <paul.houssel@orange.com>,
 Martin Horth <martin.horth@telecom-sudparis.eu>,  Ouail Derghal
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>, Ludovic Paillat	 <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>,  Tristan d'Audibert
 <tristan.daudibert@gmail.com>
Date: Mon, 10 Nov 2025 11:06:54 -0800
In-Reply-To: <CA+aJb_27fAdAXNwkYCxTKaWCCOdiWmJc7a_qhpmykXqxMjJYMA@mail.gmail.com>
References: <20251107153408.159342-1-paulhoussel2@gmail.com>
	 <4c33ab7a31ccbc1235bd183a5e4bfa4f94896c63.camel@gmail.com>
	 <CA+aJb_27fAdAXNwkYCxTKaWCCOdiWmJc7a_qhpmykXqxMjJYMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 21:49 +0100, polo wrote:
> Hello Eduard,
>=20
> On Fri, 7 Nov 2025 at 20:45, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Fri, 2025-11-07 at 16:34 +0100, paulhoussel2@gmail.com wrote:
> > > From: Paul Houssel <paul.houssel@orange.com>
> > >=20
> > > Handle recursive typedefs in BTF deduplication
> > >=20
> > > Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> > > Podman) due to recursive type definitions that create reference loops
> > > not representable in C. These recursive typedefs trigger a failure in
> > > the BTF deduplication algorithm.
> > >=20
> > > This patch extends btf_dedup_ref_type() to properly handle potential
> > > recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> > > handled for BTF_KIND_STRUCT. This allows pahole to successfully
> > > generate BTF for Go binaries using recursive types without impacting
> > > existing C-based workflows.
> > >=20
> > > Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> > > Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> > > Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> > > Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> > > Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> > > Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> > > Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> > > Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> > > Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> > > Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> > > Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> > > Signed-off-by: Paul Houssel <paul.houssel@orange.com>
> > >=20
> > > ---
> > > The issue was originally observed when attempting to encode BTF for
> > > Kubernetes binaries (kubectl, kubeadm):
> > >=20
> > > $ git clone --depth 1 https://github.com/kubernetes/kubernetes
> > > $ cd ./kubernetes
> > > $ make kubeadm DBG=3D1
> > > $ pahole --btf_encode_detached=3Dkubeadm.btf _output/bin/kubeadm
> > > btf_encoder__encode: btf__dedup failed!
> > > Failed to encode BTF
> >=20
> > Hi Paul,
> >=20
> > Could you please provide some details on why would you like to use BTF
> > for golang programs?
>=20
> We would like to use BTF for Golang programs in order to trace
> compiled Go user-space applications using eBPF uprobe programs.
> Tetragon [1] implements the use of the BTF file to resolve paths to
> attributes in hook parameters, and therefore if we can obtain the BTF
> for Go programs, we will be able to start reading any attributes.
> Recently, this feature has been extended to support uprobes [2].
>=20
> [1] https://tetragon.io/docs/concepts/tracing-policy/hooks/#attribute-res=
olution
> [2] https://github.com/cilium/tetragon/pull/4286#pullrequestreview-342772=
5698
>=20
> > Also, is this the only scenario when golang
> > generated DWARF has loops not possible in C code?
>=20
> This is the only scenario we=E2=80=99ve identified where Golang DWARF con=
tains
> loops, which are not possible in C. We=E2=80=99re not aware of any other
> Go-specific characteristics that could cause additional DWARF loops.
> We tested BTF generation on a set of Go projects that are quite large
> and representative of the diversity of Go programs, and we only
> observed loops for this specific typedef usage.
>=20
> Paul Houssel

Hi Paul,

Thank you for explaining, this sounds like a reasonable use-case.
I'll comment on the patch itself in the separate email.

Thanks,
Eduard

