Return-Path: <bpf+bounces-14958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E651A7E92AE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 21:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77730B20A21
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D118640;
	Sun, 12 Nov 2023 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fFs7PJhY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AB18047
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 20:32:58 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F042129
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:32:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so3819423276.0
        for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699821176; x=1700425976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQZ6q7zkUzBb4xIAiq5ifefOrJoCgb7ZOALJX74IEOE=;
        b=fFs7PJhYwN5xunvMuG0hbY5QD4uE0tlRHi0nc/jDSqm2Dez5jCXmoUFYWP4xAeGgFY
         41jtb3VxDv1A0ExM0CLTNX5TTIru/6B1ic19+z4olqsoBhhb7LzEKtys1/6o6546NhMt
         +SSm4CcfzmUFH74YML+Tah8Nn3fHxLBrUUNDj3zRrSC3wU6ExiEsLQP0fhAhBsBqEpdT
         Nvf22oh+VX0XQTe0hkZdUo5B7hItfrJZsAT8xa7zYDMDaaLsCuCZcEIWsXqGVQXra9zw
         W2sb2lZBMopD+Exqf2+XGckw8sT/cy8Djf9Z4DkhTmSFJD7mEyDeqxWGyMxqUQ50nqnf
         iu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699821176; x=1700425976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQZ6q7zkUzBb4xIAiq5ifefOrJoCgb7ZOALJX74IEOE=;
        b=g8qL6xoGFp9GT58waIBuodNi0AizTok+4x9ZC2J5IFxI2LTvFCufJayO6pYfQHA7uT
         D0iROI+MsMa6VhUBr7ySUuYgExk6L/dYcQn1rIIItuHi0CwDIkeJ4d4mjSWgJnvo/ycV
         Wotdoo6tRDUPKF2U9Pe+xQCzHaOrK2ijQlxAVJbQnK5fyMdX6S/3TXESqKrycWeKgc08
         eTSarksdYFFOQY+ydim3YIeYJvLGSRkua8YccM5jeSEko56MGHFH7Ao/Ctxd4ac3UMSO
         hjIKXOfz1K58eWjV3cE0m+V9j/c/zhR08naK4BTUWLo0kZMP5ezmC3UyCh/PVeojYCKG
         G1UQ==
X-Gm-Message-State: AOJu0YyHu3T+yRW+N6Iz1xtVb0PYVM0vKSiAbZK+hF2ius1zGWu44Cb/
	sDIr6jWvlOyVyIFiPGs8l2HMwrc+iUr8/gyYHY7+
X-Google-Smtp-Source: AGHT+IFxB5XY+P9gbJKytFyNfW83PPd7xVRHBIT5WpoJ8OFrzjK3QzTvR+pgKG+BfzpG0R0eyls66J/UTrbCR5YIPWA=
X-Received: by 2002:a25:c008:0:b0:da0:400e:750c with SMTP id
 c8-20020a25c008000000b00da0400e750cmr3784114ybf.27.1699821176534; Sun, 12 Nov
 2023 12:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com>
In-Reply-To: <20231112073424.4216-1-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Nov 2023 15:32:45 -0500
Message-ID: <CAHC9VhT6YmQrvfQRu0N=0tXHD2+vJQU3pTqrryMekZsEQzwqUw@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 2:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In our containerized environment, we've identified unexpected OOM events
> where the OOM-killer terminates tasks despite having ample free memory.
> This anomaly is traced back to tasks within a container using mbind(2) to
> bind memory to a specific NUMA node. When the allocated memory on this no=
de
> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> indiscriminately kills tasks. This becomes more critical with guaranteed
> tasks (oom_score_adj: -998) aggravating the issue.
>
> The selected victim might not have allocated memory on the same NUMA node=
,
> rendering the killing ineffective. This patch aims to address this by
> disabling MPOL_BIND in container environments.
>
> In the container environment, our aim is to consolidate memory resource
> control under the management of kubelet. If users express a preference fo=
r
> binding their memory to a specific NUMA node, we encourage the adoption o=
f
> a standardized approach. Specifically, we recommend configuring this memo=
ry
> policy through kubelet using cpuset.mems in the cpuset controller, rather
> than individual users setting it autonomously. This centralized approach
> ensures that NUMA nodes are globally managed through kubelet, promoting
> consistency and facilitating streamlined administration of memory resourc=
es
> across the entire containerized environment.
>
> Proposed Solutions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Introduce Capability to Disable MPOL_BIND
>   Currently, any task can perform MPOL_BIND without specific capabilities=
.
>   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but this
>   may have unintended consequences. Capabilities, being broad, might gran=
t
>   unnecessary privileges. We should explore alternatives to prevent
>   unexpected side effects.
>
> - Use LSM BPF to Disable MPOL_BIND
>   Introduce LSM hooks for syscalls such as mbind(2), set_mempolicy(2), an=
d
>   set_mempolicy_home_node(2) to disable MPOL_BIND. This approach is more
>   flexibility and allows for fine-grained control without unintended
>   consequences. A sample LSM BPF program is included, demonstrating
>   practical implementation in a production environment.

Without looking at the patchset in any detail yet, I wanted to point
out that we do have some documented guidelines for adding new LSM
hooks:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ook-guidelines

I just learned that there are provisions for adding this to the
MAINTAINERS file, I'll be doing that shortly.  My apologies for not
having it in there sooner.

> Future Considerations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In addition, there's room for enhancement in the OOM-killer for cases
> involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> prioritize selecting a victim that has allocated memory on the same NUMA
> node. My exploration on the lore led me to a proposal[0] related to this
> matter, although consensus seems elusive at this point. Nevertheless,
> delving into this specific topic is beyond the scope of the current
> patchset.
>
> [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@byte=
dance.com/

--=20
paul-moore.com

