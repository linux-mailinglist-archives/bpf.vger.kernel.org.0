Return-Path: <bpf+bounces-16154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2E7FDC2E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70942825EE
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8F39AC0;
	Wed, 29 Nov 2023 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTP3n+O7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510539879
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E4C433B9
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701273983;
	bh=TC7ljq37dxoM/N5BhmRf4oO+x43hche9TKzUYyoc/2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TTP3n+O75BxHrh7nQdgG+DVP7XICfxzlZxf29NjtO/5Z4eKv766vkBxV/+E4AC1jE
	 Ym3i40L2gaJjEKJG/4BOIXAjmM6sy2zC7eynF9/0X6qTydBUagIAVyVPYEnNKIs2X4
	 hCua37pThJfNRRQXLvNUinOmJ0S0+HoMhtJKjHcV1QzhqaoEVaMWfPKa3nhnO53N6+
	 6ZGUxs1cQYHrku+LNbjrFuy+mL97sgQspzunxNcfbyC3Ys0+KuZLyt1PdOyZR6SK3E
	 SySEzGsRC3lrnK4tpBD4DiyU5Gq3BYMjwZ2dbn6O5WNgshqioArOh6RILKAac1F26G
	 0ShfsO3b3IqIA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so7651139a12.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:06:23 -0800 (PST)
X-Gm-Message-State: AOJu0YzNaJ4QYbG9ENGMiKM49oKGUN5dcyoN5e8GSAGpwZ5y3zOUQrFb
	OZZE8uNEWveN1rTNA/OFwh5Du+/yH8rwRKgm4/VljA==
X-Google-Smtp-Source: AGHT+IHJqz1hroxRgeKBvuotxqNz5IAAJ/Ci8bcGGncdN5ojveL5t+JX7nwfjC37Jm+7alW9HB3GlXBqLpK3eL47qQU=
X-Received: by 2002:a50:cd47:0:b0:544:a26c:804c with SMTP id
 d7-20020a50cd47000000b00544a26c804cmr16413550edj.16.1701273981612; Wed, 29
 Nov 2023 08:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-2-song@kernel.org>
In-Reply-To: <20231129003656.1165061-2-song@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 29 Nov 2023 17:06:10 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7XybrUU1NuZDJHc-GSVv-rOXGMDsLfX5NxvJ1jE71cWA@mail.gmail.com>
Message-ID: <CACYkzJ7XybrUU1NuZDJHc-GSVv-rOXGMDsLfX5NxvJ1jE71cWA@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev, ebiggers@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com, 
	amir73il@gmail.com, roberto.sassu@huawei.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 1:37=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> It is common practice for security solutions to store tags/labels in
> xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> bpf_get_file_xattr().
>
> The first use case of bpf_get_file_xattr() is to implement file
> verifications with asymmetric keys. Specificially, security applications
> could use fsverity for file hashes and use xattr to store file signatures=
.
> (kfunc for fsverity hash will be added in a separate commit.)
>
> Currently, only xattrs with "user." prefix can be read with kfunc
> bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
> for bpf_get_file_xattr().
>
> To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Christian Brauner <brauner@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>

