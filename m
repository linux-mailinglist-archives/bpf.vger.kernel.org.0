Return-Path: <bpf+bounces-21362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453E84BBEC
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE184284738
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C322BA55;
	Tue,  6 Feb 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLSB8V/G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F13DDAE;
	Tue,  6 Feb 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240737; cv=none; b=OTOgznpv++eIzfkYV9ERVekQFsoctWQQDfzsAqr09fkHpi6jRuhEnJmSl5zqsWUHNlBdqk//tXcBPn13MRlBGqCOiUt9nURH/B2Bt6Nstkjok+pa6XTFIfv7Mqu9sclXVlNzflYG40NcuFa9We0KwY3hKsojtiiyCz0/jL9qhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240737; c=relaxed/simple;
	bh=CmCPWBgzbBETCy3LXXfZQv6qzrYT3HCTZqp7bi9YhpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIkbjcEsBU2ojNTp4B3Q59QFi+YSXOd5noad7+wmzY8chfyzckHIBJuXyftSKJensBoOjdZdX4GqEeFpOQuVaQjWzVDuJVWZcXgZSQub3vmKy/2vLSmcOi/qurZXNFmp3SFjYfmM8RUciH3K3yzImngzH3mYkQs+ulfRmbTJ1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLSB8V/G; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595aa5b1fe0so3928471eaf.2;
        Tue, 06 Feb 2024 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240734; x=1707845534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yM2zrDJO+07OlKVAv2LMPJV5bZ22BQggsUrffsapbs=;
        b=fLSB8V/GanyVWJlN0EYgyHnglHA19fyM9ia1sW6TFSYcbj6OG7ulqI0eGybNDP2DLz
         8M9YueAD2EJLituZohUePcpUgYbdOwF18pmHr2/VArz2j3oTvZAPQF8KzcR5yudpOlOb
         XzIzxFerduTslq16RmUk6i5sWjIApoBCXRuC6uvR2aCQ9Ef1CRp+k3kIeQG413Ojm72+
         o3PkLVWEnv/KHGfOkDWnLIGAgZOQwvnZAOyJtqFv72z4K7m67kcLsyyUL4XbYeBqZSXv
         z4Q8e9qDp+GgssJm/o6Sw5WjDc6nVCsdW0FxMbPMDUPgTJrVhaz6tEtn+987dVKL+6K1
         cCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240734; x=1707845534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yM2zrDJO+07OlKVAv2LMPJV5bZ22BQggsUrffsapbs=;
        b=cOtRBGJ0b1RXybKxKd3UgwI7mPH1CK0NWmfX3msof7nZyjL0HIiwwFjF/NSJjiy1z2
         SqZldHaPy+StYbiDcQT/GoJJpYpRLSTj8+aLP31ry4xnextMabdD+oXGZjF0obuk9ALj
         TFvK4M3O9qrZLAZDig4ZUn7rsmqsQRXQOhkzCdcMmksZ6+wKMJYXeKKrcRKxxis4Xc1B
         7s6/37XStMpOD1QGCBuFkN157QExw9e0GXgP0CmcZSxlvwRpzif4Vn+irUGhobEf6B7P
         mn39UP3TebT5F85x+aPPPBqjE4ocWKfdLurG6Wnzb6c+nr/66pVi/iMaekiG/xoDD7Rz
         0cJg==
X-Gm-Message-State: AOJu0Yzn4+IpmdKxtiaGUPQ0qPsN9bvxZqIFSJxwsVVrX8yJqx93D7c7
	ybQeXNX7AZ8K2zhIYp8wQ9+U+kn2VCSZqfKTBhwtqpxS9lfLHTH/FpS5qce4V/oJFdlCyG/r6Ix
	V52kEQ9MmVn/39nxsD4MDzPxW/hs=
X-Google-Smtp-Source: AGHT+IG0FO7KZ4C1nLA/ujfGgcoblVAVAdfGYQkGX/bELpz4O932WglPtzEM9hc45I91Won7AczqRjWybPlXfKfUKiw=
X-Received: by 2002:a05:6358:d585:b0:176:b16a:f392 with SMTP id
 ms5-20020a056358d58500b00176b16af392mr295851rwb.10.1707240734495; Tue, 06 Feb
 2024 09:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707080349.git.dxu@dxuuu.xyz> <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
 <ZcI3Pt6Gr45wiig7@krava> <cn7sqqtplcle3udyxsbywfxs25wqnwxoutdf7w7cbbucmxkfsm@x67uxj6ubmzk>
In-Reply-To: <cn7sqqtplcle3udyxsbywfxs25wqnwxoutdf7w7cbbucmxkfsm@x67uxj6ubmzk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Feb 2024 09:32:02 -0800
Message-ID: <CAEf4BzZ-Jxw0r=34Jf5nScW8kaowXh5Kah7hYkZ-o6oqSVGnaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const pointer
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 7:44=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Jiri,
>
> On Tue, Feb 06, 2024 at 02:42:22PM +0100, Jiri Olsa wrote:
> > On Sun, Feb 04, 2024 at 02:06:34PM -0700, Daniel Xu wrote:
> > > Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is n=
ow
> > > exporting a const arg version of bpf_rdonly_cast(). This causes the
> > > following conflicting type error when generating kfunc prototypes fro=
m
> > > BTF:
> > >
> > > In file included from skeleton/pid_iter.bpf.c:5:
> > > /home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bp=
f_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
> > > extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) _=
_ksym __weak;
> > >              ^
> > > ./vmlinux.h:135625:14: note: previous declaration is here
> > > extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __=
ksym;
> >
> > hi,
> > I'm hiting more of these when compiling bpf selftests (attached),
> > it looks like some kfuncs declarations in bpf_kfuncs.h might be in conf=
lict
>
> Yep, I was actually going to put that as an office hours topic on how we
> want to handle that for selftests. Marking kfuncs in bpf_kfuncs.h and
> bpf_experimental.h as __weak is an option. ifdef is another option.
> Final option I can think of is bumping required pahole version up and
> simply deleting all the kfunc definitions.

I think we should mark all kfuncs in selftests as __weak. And then
audit all of them and add consts where it makes sense and make sure
that all definitions are compatible between vmlinux.h and manual
declarations. I'd rather avoid #ifdef'ing anything, it should work as
is.


>
> But given that pahole changes come with the feature flag, I don't see
> this as a pressing issue. So I was planning on getting to that after
> current outstanding patchsets (just so there's less stuff for me to
> juggle).
>
> [...]
>
> Thanks,
> Daniel

