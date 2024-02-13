Return-Path: <bpf+bounces-21888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF4853C4E
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA20C289B18
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B691612E2;
	Tue, 13 Feb 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoVohAHP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E29612D1
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856661; cv=none; b=B6Nl34bCACh37Tl2zoh90tehmSMTx1RgaccEjRMmA/yYdkjtBixnQKBkpTKFdYtkp2umrLvxrK03XvEr36ErfFIGGd3TMKtfSlULJ1zVo+yQTENELuDrJENQDQF0yk7qWshrKP0nKyjhBYf+YTfWsCUDZN+8cG1MlysbPdJNaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856661; c=relaxed/simple;
	bh=FY8BYq/xz6qjz5JdjnETn1nguRizrkw/A3y9LXtG9QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIowuuYgltdVllFkaDxXDfKEnlaX/u/nMhzOFuAYU2qJK3bEb1sciec4ixtT/Y+0YETdhesvxd9NgZsc3Xyj5k1Zlp+tYyD8uj4tF/336dPs+DWfhVk8XSdR9u4+p5t+L/isj8TIoekW5pq16LFyNnufLgkYAlxguHc3EKKPdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoVohAHP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4108cbd92b9so26409945e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856658; x=1708461458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY8BYq/xz6qjz5JdjnETn1nguRizrkw/A3y9LXtG9QE=;
        b=DoVohAHPX//UUwOzhZi769vdTnka2eJMbFYxuJnpoQ0BXjMusn6b/a439wk5kd3Bbh
         KfNSs/1CfBQBZ4s3SdLPR70hs3molfJA+1eeFC80mIwNEDU2vU6Cr2yFOZ3NIrvJ4DaE
         MjFQ9TG4vyae2/agiiR/qpDAcXdFLlTPykSKwzu3+lN6bT0NdkmDy6oFjXKOJOvFYJQD
         iiqDjkeBtrHvGbdjcQUJGNsfJs4tA0u2lM6Yr9QJugtBI2BSduCuC1/ZpAo6tJGAdh8H
         Rs8w1fwPwCgaGEJj2fTepz8NxxEvxIG6+XiH2Lt3immfJ8hFfD7mgFmCb+SCEgkLVcZ4
         dsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856658; x=1708461458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY8BYq/xz6qjz5JdjnETn1nguRizrkw/A3y9LXtG9QE=;
        b=ZLsRcR3c90YvYxiwc4H6XtidjskDle/smZTXfizytCKXSaVKqAWscjT7HlHL0U04rw
         rQqmzrEixd6XEvTSJWODbWeGV6T68Ktqqrdo8O8M+T6C1rs8B7qMvhLtyEIKThtLsVc0
         G/fd1tzDfQtqBj4qaLI7iX3OD3rguJGChqkXvcsHwSFlSb9B+44OoMUu7VoCXfWf6k9X
         OSn1kuDPYL5fblOU0WJROmgKiJiuzciTeozGPQ0flBAIpz7eIOYWsI2uKnLH0w+Yh8S5
         +IfB2WH5vqQh7XqIGbNMkqWUkDi4Ezmw44vRH7xpZ1mdwY3b0AsPaMNghbzee+3vC/VJ
         gXEA==
X-Gm-Message-State: AOJu0YzpxO/azs++mJ80C7JXyzL16McT669/pVDbOsRYsy7eFnVBSNXy
	DrMJXQr9/wxxIua4lDLv1og/Vvre9OZhJ1D5MM82dC9GHF89x9sDeIJOm287t35Pl54msuwXmtD
	opBzsSSwEPQMtUUZq4WRWtU1DszU=
X-Google-Smtp-Source: AGHT+IH823lDN8JMWoT1CaMgWGOr61W8//if2QvVxYgKhxFdxDTNg2TSkyrm9yndx9RyTQfKh7lat5hKsRI+Y4slmzY=
X-Received: by 2002:a05:600c:474f:b0:411:ddc2:28b2 with SMTP id
 w15-20020a05600c474f00b00411ddc228b2mr388779wmo.27.1707856658155; Tue, 13 Feb
 2024 12:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqEB3REkEKJahQu@google.com>
In-Reply-To: <ZcqEB3REkEKJahQu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 12:37:26 -0800
Message-ID: <CAADnVQJ2Sh2MaU+ReQ3x02DhBbyyOUg2FNpOzHJHumSRUOjLrQ@mail.gmail.com>
Subject: Re: Generic Data Structure Iterators
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:48=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> In numerous BPF programs, I've found myself needing to iterate over
> some in-kernel generic data structure i.e. list_head, hlist_head,
> rbtree, etc. The approach that I generally use to do this consists of
> using bpf_loop(), container_of(), and BPF_CORE_READ(). The end result
> of this approach is always rather messy as it's mostly implementation
> specific and bound to a specific in-kernel type i.e. mount, dentry,
> inode, etc.
>
> Recently, I came across the newly added bpf_for_each() open-coded
> iterator, which could possibly help out a little with trivially
> performing such iterations within BPF programs. However, looking into
> the usage of this helper a little more, I realized that this too needs
> to be backed by the new kfunc iterator framework
> i.e. bpf_iter_##type##_new(), bpf_iter_##type##_destroy(),
> bpf_iter_##type##_next(). So, in practice it seems like adopting this
> approach to solve this specific iterator problem would lead us into a
> situation where we'd be having to define iterator kfuncs for each
> in-kernel type and respective field.
>
> Now having said this, I'm wondering whether anyone here has considered
> possibly solving this iterator based problem a little more
> generically? That is, by exposing a set of kfuncs that allow you to
> iterate over a list_head, hlist_head, rbtree, etc, independent of an
> underlying in-kernel type and similar to your *list_for_each*() based
> helpers that you'd typically find for each of these in-kernel generic
> data structures. If so, what were your findings when exploring this
> problem space?

If you're looking for read-only (aka untrusted_ptr_to_btf_id) access
you can iterate link lists and everything else already without
modifying the kernel.
See list_for_each_entry() that is arena specific:
https://lore.kernel.org/bpf/20240209040608.98927-19-alexei.starovoitov@gmai=
l.com/
Same thing can be done today (no need to wait for arena)
to walk kernel link lists.
typeof and container_of would need to change to use bpf_core_cast.
Then all pointers are untrusted and JIT-ed like inlined probe_read_kernel.

