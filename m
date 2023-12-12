Return-Path: <bpf+bounces-17497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E908B80E7F9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89024B20DA7
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE858AD3;
	Tue, 12 Dec 2023 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsam3izC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13FE3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:43:12 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5e176babd4eso12728367b3.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702374191; x=1702978991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiID8pfIX0nrJNb9iu5LXacbfZr5jsVzryvlI6y0FVg=;
        b=jsam3izCy2ghQtZ2UPbW+RByzPxVXIJ7kUBmCMPWmHxenJuCzy+pfbiTCh1PTD8mEu
         cuvfhreGK6kP+UjtnDQXJ7nS1z732eHGDkpLPRVfzIDw9d8Vw3KiRbz2bA1GopaQ/D3T
         BPPGeyS4R3d7T3E5HmT4gNIlp0ZJtp4geKOok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374191; x=1702978991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiID8pfIX0nrJNb9iu5LXacbfZr5jsVzryvlI6y0FVg=;
        b=rhfpTd0tUG8oUSRtMnb3z7GHu0CyZu2uT5X9EAMFmTDpdc2ECbEUIPsqsKRI0/NP0l
         mNUY44oI/imnJniO9LHBlnuxaI+iNpV2j+e0MfLl03AVzhHkmpGXje38WIztZ6s+GqQA
         8Lnhe3B3uNHF1hjDqEJNPzu3rIcPaflx0wDwGgh42TiAaEPI55UpvBvYpg0rilLEcZbB
         ixsTqOOWA4Cn6mLZzSWkzSZQTM2mDFsfqQ0uzBBgv35nrO/NxHwMJ5uRWASCiBnwwam/
         tNxxetdfW4GbsFcVf6X91psUZA94nRrLn5RmJ3xvsNzIhWFmFZewvDknC9PgFwjKZgv2
         29wQ==
X-Gm-Message-State: AOJu0YwJ+T0A9kLAafk40mdBOJTezdbcn4EI7xgAzM6WHrb+RkIwOGlI
	BjPKTnya328POGYBUK8gt1qO4uMnTM/uOUOVng0XKg==
X-Google-Smtp-Source: AGHT+IEtEIii5q9IUjZoipTUayD9S1toAxqgmFNnQPnYae3hH5GbMw1MvnW5jrI7eCtE3ZBEFlP6s/JGBxQfOaeHV9A=
X-Received: by 2002:a0d:cacb:0:b0:5d7:1940:53ef with SMTP id
 m194-20020a0dcacb000000b005d7194053efmr4537433ywd.103.1702374191434; Tue, 12
 Dec 2023 01:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207035706.2797103-1-jiejiang@chromium.org>
 <c9a98edc-f8cb-e52d-e9e6-53834193aee8@iogearbox.net> <20231211-beide-golden-84ecb9d596c1@brauner>
In-Reply-To: <20231211-beide-golden-84ecb9d596c1@brauner>
From: Jie Jiang <jiejiang@chromium.org>
Date: Tue, 12 Dec 2023 18:43:00 +0900
Message-ID: <CAGUv5Mg3Nre2H3WnRdSxL=v4E7OT8esfM+BG=L7CGM_vnKsA7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Support uid and gid when mounting bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, vapier@chromium.org, 
	andrii@kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:21=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> I think you want
>
> opt->uid =3D current_fsuid();
> opt->gid =3D current_fsgid();
>
Thanks for catching this and the suggestions!
Added the above two lines in the v4.

> because bpf_init_fs_context() is called from fsopen() which may be
> called inside a user namespace. Then you can just transfer
>
> s_fs_info->uid =3D opts->uid;
> s_fs_info->gid =3D opts->gid;
>
> and then always use:
>
> inode->i_uid =3D s_fs_info->uid;
> inode->i_gid =3D s_fs_info->gid;
>
> when initializing inodes. Otherwise looks good.

