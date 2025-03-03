Return-Path: <bpf+bounces-53131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D5A4CF76
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F2C7A69B2
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E591F3FEB;
	Mon,  3 Mar 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtKlThu/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDA1E991A;
	Mon,  3 Mar 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045834; cv=none; b=aOe6dVD5mw1cMyEV8C1I8I0u9HMla0yu5GgcX0+EWGcn4/vopAJnqqxGiCaJTvJW69wneM89gOnRFxX0IdHSkl70zG/J32sysSJlHN0778GW/bqN5cX7c7ry5AsvgOr2GujODeqF2xPBPJyyq/tLVZdsriqAdieArbztQDfZAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045834; c=relaxed/simple;
	bh=ZtN7Vj4cOdhdtn+xFv0fG3ppvVknVymRTUOPHeuqZzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYhFRL33E2RfB5Asfe4lObc7Xa52qNFod3INpwXSQ44++CVK7iB0gdCVN/0wcMKxB19o2pVpt6fyeZ2ktkDE+PaOJYe7aIDTmrxoT0kCPbo04K0gvovpGfKWn5Ltg70Bn3V2TWAy9Nlg3IIBIL32gbzeAe6AUU+MC+kxNOSnnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtKlThu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71258C4CEEA;
	Mon,  3 Mar 2025 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741045833;
	bh=ZtN7Vj4cOdhdtn+xFv0fG3ppvVknVymRTUOPHeuqZzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qtKlThu/eL/B1gSFNrBKylcw7uOvXxONL9ifdr+7cy6fn6acrUK9/p0bxRAAAZQE9
	 b697mUdPnqpRVz8Ki22OowHyXStcf6MIG5Daw4ajJyGGvwXhlK9q+7bmGze0mnGftE
	 4sypDqoYPFa80rYGlijr9uE3fJbbA49EX9ZBwmPdmL7imlGN4/gd44bfazU/pKIaQY
	 q/fZkWmqK/TeTBPjysd+Jpbj06IplfITOXXA0Y2pbBioAjRLLgWtGHOnYriPdWM0KV
	 2O5D7QTKzMnkI2CVO311dw3Flc7HBsHaAra0czrxaxJ3JO6AfOJACy6if9fBNU5EJ+
	 aTH8H1hqWpJNA==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so49554425ab.0;
        Mon, 03 Mar 2025 15:50:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2LEAe9T3DEYZDxt3km8y7vai33WOARbtPLQoTbc16chQLLqLZZr0ati4P0ka5m5b9EQA=@vger.kernel.org, AJvYcCUuldPP5DVswwoDLEbdzWywcTpsQ1U8xKtgKX2tJf+iwbGarY9lUjNbigSBd+YQacXQm930179fkA==@vger.kernel.org, AJvYcCVAcgn5ik7Dg0nalzdJ7usyneLMYjxgigIv72ata49xNSHwtEGUa512Hhu02pAVrP7NuWBWV56LYL3JvW/f@vger.kernel.org, AJvYcCVWSEhmSgXL5FfzySxalNo2A2XZgXo05NUQvH+89185HOFFSfsJ9rsLNATMSpZh7AowMViX+bb3Kz2l7Uy69TFxKgezCosd@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9ZFkn+5ifHjoP0TLJwZr41hXq3/IjXvlvQvTOahXPhlnxvAj
	1HVN9nCoGHkVzxZllr518JM5F9hxIZnWNt/ZblIJ2wH91BfSgn7zIJmAtEp/qf9P51CosvZQ+Dq
	mS760xAR33B8P4jMQcwcSlbTQ/XI=
X-Google-Smtp-Source: AGHT+IEa2U04jzdtqm9QOxXPelAcw7uaid5QIC7++sbi7K86r+INBEjhOLZdluQ0kal3eyQloIgjX0ZeVZ07G9aOiRo=
X-Received: by 2002:a05:6e02:1805:b0:3d3:d163:ec84 with SMTP id
 e9e14a558f8ab-3d3e6e7442fmr131213825ab.10.1741045832644; Mon, 03 Mar 2025
 15:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303222416.3909228-1-bboscaccy@linux.microsoft.com> <20250303222416.3909228-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250303222416.3909228-2-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Mon, 3 Mar 2025 15:50:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7RsGErn+Gy-2S6ruyo+j9WmqwxWERh2XoRrWEH7-=e1w@mail.gmail.com>
X-Gm-Features: AQ5f1Jo2tzFzrgsbmtzBANFmzE1xKVmsW9OnQyVqM5ytF_Pbl82b-R4fsAPb2bo
Message-ID: <CAPhsuW7RsGErn+Gy-2S6ruyo+j9WmqwxWERh2XoRrWEH7-=e1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate caller information in bpf hooks
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For future patches, please use git-format-patch with --subject-prefix optio=
n and
specify target tree (bpf vs. bpf-next vs. bpf-next) and patchset version. F=
or
this version of the patchset the subject prefix should be "PATCH v3 bpf-nex=
t".

On Mon, Mar 3, 2025 at 2:24=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
>
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
>
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/lsm_hook_defs.h                     |  6 +++---
>  include/linux/security.h                          | 12 ++++++------
>  kernel/bpf/syscall.c                              | 10 +++++-----
>  security/security.c                               | 15 +++++++++------
>  security/selinux/hooks.c                          |  6 +++---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
>  .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
>  .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
>  .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
>  .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
>  .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
>  .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-

Please put kernel changes and selftest changes in two
patches. Other than this:

Acked-by: Song Liu <song@kernel.org>

>  12 files changed, 37 insertions(+), 33 deletions(-)

