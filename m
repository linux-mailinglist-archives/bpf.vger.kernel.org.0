Return-Path: <bpf+bounces-14965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE87E9565
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B5028102E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 03:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565058829;
	Mon, 13 Nov 2023 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuHfEqpr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E8881E
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 03:18:34 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F51704;
	Sun, 12 Nov 2023 19:18:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6705379b835so25307106d6.1;
        Sun, 12 Nov 2023 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699845512; x=1700450312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkrhYJmroTlYiiJ3rV5QSD9C69+eZxDckLyTvIr5/NM=;
        b=NuHfEqprjzC5N5CupEHDrmRLW5zzq5fgTwnWhszhxu6jUIycBTGzF+JeqpsInCoFTZ
         DxV1EGS1MtKDcj4wnVh2C3VV1k0wzKNAFHcR67ZwXp7EW+ftpuaDinoZPnt1l3QP0Hfj
         Huow404zc3Z/Wfkh9ROlJXKS2niTP/FmPBJ+9cNEeHYcF8d8qKG2wLXAPzZeW5AxnEbR
         nD4MHLSniCZMLZvVjWFCSGtc2qKorzY1y2TbnHM7Z8VCR3GV1VM0nOKDD4D7jYTiuzvk
         OPe33YNTvWde4yCv41N0QYTU7V64iNFQYmq/SLD1PSf5IlJa/NfmY8pyckvkE8O79k2s
         ATyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699845512; x=1700450312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkrhYJmroTlYiiJ3rV5QSD9C69+eZxDckLyTvIr5/NM=;
        b=ItGrMKFvcLio6iHubDWpipa+PT2eV6iIhJVBPMQOP69YrwBelBSJA4quda9m2UkRVg
         mEPFaNDy4XXRSM63hNE8D/CJXZjhEsBrni8WgNHz/UrG2B2E5sGYrYdkJT6lVHyfOolj
         W7/E8S5/wQVtz5AQgir4+3+qNUNw3PnxbvfYwdFLZdtB53JN71ei6V4VluDq4pzfZqLf
         CE0ho3d9dWmKKCz12rtSVw9+4jBN+xnDnJ3Dh219e1xO/vxUrnMvFT1dxy1jgxvJhN3V
         NOT+iV5+e93v9jNFi9c8slo3LhVgs0hfF5jEJE0VE8r0KKVrLaiO80BnEAdVQvhsYD5q
         CIPw==
X-Gm-Message-State: AOJu0YyyGGWIV//lvO8tal4yxV8es/Z3b2VqfE+VF1nztK3k2+RnUhuk
	badCRK1c6dTtAkMQgEH4kvVTxXNCDP6+pe5Z8Xo=
X-Google-Smtp-Source: AGHT+IGgewBV0p901aWIwLc8NDDsI5JIf/ir2MxmFpNxLqWRWfFMliNwGoQSDRsyoIsjj6tIBqlDvc1N9Ky2ckvuHAk=
X-Received: by 2002:a0c:c683:0:b0:66f:b00b:9d51 with SMTP id
 d3-20020a0cc683000000b0066fb00b9d51mr5256007qvj.9.1699845512052; Sun, 12 Nov
 2023 19:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <CAHC9VhT6YmQrvfQRu0N=0tXHD2+vJQU3pTqrryMekZsEQzwqUw@mail.gmail.com>
In-Reply-To: <CAHC9VhT6YmQrvfQRu0N=0tXHD2+vJQU3pTqrryMekZsEQzwqUw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 13 Nov 2023 11:17:51 +0800
Message-ID: <CALOAHbCxNuSdguRMOWFK_PHvMNkmgh=U9PY6Wjvdk_Uj2=7e+A@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Paul Moore <paul@paul-moore.com>
Cc: akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 4:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Nov 12, 2023 at 2:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In our containerized environment, we've identified unexpected OOM event=
s
> > where the OOM-killer terminates tasks despite having ample free memory.
> > This anomaly is traced back to tasks within a container using mbind(2) =
to
> > bind memory to a specific NUMA node. When the allocated memory on this =
node
> > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > indiscriminately kills tasks. This becomes more critical with guarantee=
d
> > tasks (oom_score_adj: -998) aggravating the issue.
> >
> > The selected victim might not have allocated memory on the same NUMA no=
de,
> > rendering the killing ineffective. This patch aims to address this by
> > disabling MPOL_BIND in container environments.
> >
> > In the container environment, our aim is to consolidate memory resource
> > control under the management of kubelet. If users express a preference =
for
> > binding their memory to a specific NUMA node, we encourage the adoption=
 of
> > a standardized approach. Specifically, we recommend configuring this me=
mory
> > policy through kubelet using cpuset.mems in the cpuset controller, rath=
er
> > than individual users setting it autonomously. This centralized approac=
h
> > ensures that NUMA nodes are globally managed through kubelet, promoting
> > consistency and facilitating streamlined administration of memory resou=
rces
> > across the entire containerized environment.
> >
> > Proposed Solutions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Introduce Capability to Disable MPOL_BIND
> >   Currently, any task can perform MPOL_BIND without specific capabiliti=
es.
> >   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but th=
is
> >   may have unintended consequences. Capabilities, being broad, might gr=
ant
> >   unnecessary privileges. We should explore alternatives to prevent
> >   unexpected side effects.
> >
> > - Use LSM BPF to Disable MPOL_BIND
> >   Introduce LSM hooks for syscalls such as mbind(2), set_mempolicy(2), =
and
> >   set_mempolicy_home_node(2) to disable MPOL_BIND. This approach is mor=
e
> >   flexibility and allows for fine-grained control without unintended
> >   consequences. A sample LSM BPF program is included, demonstrating
> >   practical implementation in a production environment.
>
> Without looking at the patchset in any detail yet, I wanted to point
> out that we do have some documented guidelines for adding new LSM
> hooks:
>
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hook-guidelines
>
> I just learned that there are provisions for adding this to the
> MAINTAINERS file, I'll be doing that shortly.  My apologies for not
> having it in there sooner.

Thanks for your information. I will learn it carefully.

--=20
Regards
Yafang

