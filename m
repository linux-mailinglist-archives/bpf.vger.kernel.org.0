Return-Path: <bpf+bounces-13378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E47D8BF3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC68F28206C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03883D39F;
	Thu, 26 Oct 2023 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAMy+YlV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD812F506
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 22:56:32 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7C10E3
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:56:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so236402766b.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698360968; x=1698965768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMBHU+u6+XxqmT8lTQ0/sx+v8JuDfmX6JWQKG+kuvR8=;
        b=DAMy+YlVmqP1jWT6xH0yXiHptBkIenDgOefmYzxKSQYs10fRImnQ/lk5Lq9/835KNg
         Y4AB8anHKPqObJuasdmL6/jlSmUD+CHND17ujZbEYDdckt7Jr3QHNDE6VPxUNAFPulEH
         lvNfG0tFackUI3LLqABrVyaHVD94pQd0Ima0H71n0tQjOsTV2Opn3zTi5qfhKSlFLpMQ
         2gpDKthU04wGPMxOL9XYO8XZ1hYjyIiQ+oXLmyKJSlORGl20Cex+NaiPjKCVI+BnAzt9
         aqhQgRNRAFK5ArEPlh8frpRVb6x24+oPjkt7x7YqQcsQ5rsf4wdYXtkEI3N/ieNy51G6
         2Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360968; x=1698965768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMBHU+u6+XxqmT8lTQ0/sx+v8JuDfmX6JWQKG+kuvR8=;
        b=Dak4QrXq/9mDPyX7V74uyUy6yuXELeKif36+O/I9ORgxXkKcUUnWw5UlXM8ob1H6mt
         ls8a0RxD5Ac+mQPYba9jdbBzVHxmcwRfR7ZMtAGYbIY9htV67iD+3GWIFImmjsLbSt1B
         SKuxXNwXaXZxaC6Gcdh42FVvWoiwxDGHcrlDUrOKmxRVIYWWuqeu/E0DsZRun8OUG5nH
         dy07Zdh0RA+R1EmN6XSWcmhMRMU+Hf03FAgRDVfHu6/OvqehDX5UnE31KuFOCG6Rzdv2
         nFsESlcCcAzS+uxt4zTXm46xElfyYRfURBVftx5F4MWcOLnOQGN8zghNYPsSM2BwDIKR
         QHOQ==
X-Gm-Message-State: AOJu0YwyD7MA0AyumlEQ34F0scTgDmgmy1+G2dbaLJwZD8DCqa+p7AJI
	JeneRjnRQV6GgUSgZV+SW0k3G1b2tfsbhTCC4yc=
X-Google-Smtp-Source: AGHT+IHyGjY3qfNSer/fnklmnmeMT/h7XxD4H7yIA9uoV65IltYGQTw4XsoqC+l04rhcjS0+U3KN67TrVCVZzSmYCes=
X-Received: by 2002:a17:907:6eaa:b0:9be:d55a:81c5 with SMTP id
 sh42-20020a1709076eaa00b009bed55a81c5mr1093974ejc.60.1698360967684; Thu, 26
 Oct 2023 15:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGckFTu3sYFH=CtdLQhu=0oO_gQpa6ty6EzfWS9XH8zMWg@mail.gmail.com>
 <CANP3RGfNz2QY64xwexGvCk7ViB=NxLc1z=x8BgKoqLuMBOtR2A@mail.gmail.com>
In-Reply-To: <CANP3RGfNz2QY64xwexGvCk7ViB=NxLc1z=x8BgKoqLuMBOtR2A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Oct 2023 15:55:56 -0700
Message-ID: <CAEf4BzZO9Gk1=dE0tWPmXrNE-xisyMqQutRz_d5Dq1JL_JC0Bw@mail.gmail.com>
Subject: Re: possible fd handling bug/issue/opportunities? in libbpf
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:30=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> Alexei said he's travelling busy and to resend to bpf@vger, so here it go=
es:
>
> https://github.com/libbpf/libbpf/blob/master/src/libbpf.c#L4525
>
> int bpf_map__reuse_fd(struct bpf_map *map, int fd) {
> ...
> /*
> * Like dup(), but make sure new FD is >=3D 3 and has O_CLOEXEC set.
> * This is similar to what we do in ensure_good_fd(), but without
> * closing original FD.
> */
> new_fd =3D fcntl(fd, F_DUPFD_CLOEXEC, 3);
> if (new_fd < 0) {
>   err =3D -errno;
>   goto err_free_new_name;
> }
>
> err =3D zclose(map->fd);
> if (err) {
>   err =3D -errno;
>   goto err_close_new_fd;
> }
>
> This is based *purely* on very local code inspection of the ~50 lines
> up above - so I may well be wrong - but:
>
> (a) optimization opportunity: there should be no need to
> F_DUPFD_CLOEXEC 3 if fd is already >=3D 3
>    I assume in this case map->fd =3D=3D fd, though it's not clear from
> looking at the function...
>    why is fd a direct argument? maybe it's trying to take ownership
> while still allowing the caller to close the passed in fd?
>
> it feels like this function should:
>   close(map->fd) almost on entry
>   if (fd < 3) {new_fd =3D dupfd_cloexec(fd,3) and close(fd); fd =3D new_f=
d; }
>   map->fd =3D fd
>
> Note: I'm assuming here that kernel returned map fds already have
> cloexec set, which I seem to recall was the case?
>
> Maybe pass in *fd instead of fd?
>

bpf_map__reuse_fd() doesn't take ownership of passed FD, so it always
has to dup() it. Doesn't seem like we do anything unnecessary here?

> (b) the close() system call closes the file descriptor *even* if it
> returns an error
>   it's likely a mistake to be checking what value zclose() returns.
>   (close() returns *pending* errors but it always releases the file descr=
iptor)
>   looking at the implementation of zclose() earlier in the file, it's
> aware of this.
>   as such I think:
>
> err =3D zclose(map->fd);
> if (err) {
> err =3D -errno;
> goto err_close_new_fd;
> }
>
> should probably be *just*
>   (void)zclose(map->fd);
> or even just
>   close(map->fd)
> since map->fd will be overwritten in a moment.

This is true, I think we can safely just zclose() unconditionally and
proceed. I think we still need zclose() to avoid close(-1) situation,
though.

Please send a patch.

>
> btw. happened to look at this because I ran across the
> "fd =3D=3D 0 means AT_FDCWD BPF_OBJ_GET commands" thread.
> It looks like the kernel community is perfectly okay with the kernel
> throwing land mines at userspace...
> I totally agree with you that for most new fd-like things (incl.
> timerfd's, bpf, etc.)
> the kernel should never allocate them with index <3 because it's *too*
> ripe for abuse.
>
> Anyway, the above comments *might* not be correct.
> I didn't do a deep analysis or anything, just something I noticed /
> was confused by on a quick glance.
> There may be deeper reasons why the code should be the way it is
> (though perhaps it could use more comments then)
>

Thanks for taking a time to look at this and report what you think is
wrong. I think the F_DUPFD_CLOEXEC is a non-issue, but zclose() one we
can improve, thanks!

> - Maciej
>

