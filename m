Return-Path: <bpf+bounces-34658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C259392FDFC
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EF8B211B8
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554DE174EFB;
	Fri, 12 Jul 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4QWq40e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030C1741EA
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799798; cv=none; b=QG+USJVc2Pg/L4i/EXFGA3Z0plVVsMGmDgVMSzCWaJe3vaqC0m/QD0pFzDP3tJOzsdZfNcv4yJMtN1osezup1QS95W2AlzGc+oEwL8k82OhheseMElDtBmXsLu2orLef/0caBucAip8C3HhLStMAwN9qj0vxYsf5y50/BBQoItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799798; c=relaxed/simple;
	bh=9GoUeoqOGpJE9IFCx1+lY+ZwgMwflk9QKydcloi4W1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m83P51wAe2Hl7t1A07rCJMIo8kYG6aAyXSuIZLvZoUQ0GoIboFj5lY+FFkD4/qvSw3TrVojb3iv8PR3qw9Kb3KTLBmi+omGb+anrtGenp2Fr5XIPHLFPA+kW+7/4ffmiKTnObTmmgOUcuuKZxX/hrhj3NYU9unYONNwbtGfyECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4QWq40e; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64d408a5d01so21164587b3.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720799796; x=1721404596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0+yKauGBfVgztiyzO4psOZ39jXUy61P0Z2otIutEDo=;
        b=B4QWq40ebSGjBiU/WHKMsBBIdB9R3LPN3ANwEo9RckJRdn+IFAubgcWKAW20eSpD7C
         TtpViz2wrZ7aVjcw6cS0rvw3CHGPhz6FXpa0axw9+zO9YL9izEEEhC6jCA6rLvL2Ucz0
         ZuuGGf/HAhCYZcfJ00ikHAJGIR6fYmW/EnJDKcb6mM8wsJmjCOx3BLYXyKwBduQ+0zNR
         WWX0vBG+LKBAUhH8hLj9N3mNk22jKWJxcau/hkEQOLK7Yj6LToLBrNFHu3CH+HW7Fa4p
         grqPQGCZzmrh/2bn4q+/Ht2XEPmXu7YyZ+2c+tI7rT3JUQUN042AZHg3lU1b64FMMi1p
         KgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799796; x=1721404596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0+yKauGBfVgztiyzO4psOZ39jXUy61P0Z2otIutEDo=;
        b=jhsUN61EjjoaBQUG6KQo601GXZcZeJuq668XHEl4LtQujumooHtkRABQPzkJbtFjyI
         2lSf4qTVlWmuF+2iylxIU8Q/KWAm/8DsQeQIFZ4y8YhRX66jLti9Oo5K+VB3JZSIgxIq
         yXyuDfv4TpqpVxIsftOBPsHtzutRnudclPkiOCyr04jsEWR2DEDUszMF6OOvALsP65qw
         Xk/Q9umolcLnrMTypl1wfSk9zaaUXDyYi/K5IY5gOXhNcWfXe5PnJrPJcRfBASq/61m8
         JuufKAcM2NKdQcuwxLkQa7XYbYBk4K9qiojDzyW5Jc0wsicymI9g6/bNRZy3F7aMwIPC
         sUuw==
X-Gm-Message-State: AOJu0YyM7Kc+DOa9I0YtMIMfeQJsWKZVv/lHKsVgfuHhUIQhxEGDLs01
	eKG+T6qOhMzghjB5t1E82ctE02k1IMo26sIACWl9eFnYPAO525ks4ujbwPoK6sCr7SNw+IAuZLE
	hfOU0jAnPcysJ+yzsv+qcvDqKOwQ/1xDnTFZn
X-Google-Smtp-Source: AGHT+IF+g3vVIQGlu+DNJrMzZR5GHCzdBLPdnG5032hms9DBcj/kbAYdQFAnbzbxP88gJHMhlwAUxx/RSDis8DM3exE=
X-Received: by 2002:a81:ae07:0:b0:62c:e6c0:e887 with SMTP id
 00721157ae682-658ee790cedmr131373017b3.9.1720799796245; Fri, 12 Jul 2024
 08:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jul 2024 11:56:25 -0400
Message-ID: <CAHC9VhSBg7qf81O+mC1EDSUhZ4xR57jfY4h0P6Vy1PO++JqMBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] Add return value range check for BPF LSM
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> LSM BPF prog returning a positive number attached to the hook
> file_alloc_security makes kernel panic.

...

> Xu Kuohai (20):
>   lsm: Refactor return value of LSM hook vm_enough_memory
>   lsm: Refactor return value of LSM hook inode_need_killpriv
>   lsm: Refactor return value of LSM hook inode_getsecurity
>   lsm: Refactor return value of LSM hook inode_listsecurity
>   lsm: Refactor return value of LSM hook inode_copy_up_xattr
>   lsm: Refactor return value of LSM hook getselfattr
>   lsm: Refactor return value of LSM hook setprocattr
>   lsm: Refactor return value of LSM hook getprocattr
>   lsm: Refactor return value of LSM hook key_getsecurity
>   lsm: Refactor return value of LSM hook audit_rule_match
>   bpf, lsm: Add disabled BPF LSM hook list
>   bpf, lsm: Enable BPF LSM prog to read/write return value parameters
>   bpf, lsm: Add check for BPF LSM return value
>   bpf: Prevent tail call between progs attached to different hooks
>   bpf: Fix compare error in function retval_range_within
>   bpf: Add a special case for bitwise AND on range [-1, 0]
>   selftests/bpf: Avoid load failure for token_lsm.c
>   selftests/bpf: Add return value checks for failed tests
>   selftests/bpf: Add test for lsm tail call
>   selftests/bpf: Add verifier tests for bpf lsm

I'm not quite sure what happened, but it looks like patches 13/20
through 20/20 did not hit the mailing lists, see lore link below; did
you have any mail failures when sending the patchset?  Regardless, can
you sort this out and resend the patchset?

https://lore.kernel.org/all/20240711111908.3817636-1-xukuohai@huaweicloud.c=
om

--=20
paul-moore.com

