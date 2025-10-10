Return-Path: <bpf+bounces-70713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D958BCB502
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D953A78EC
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83C1F8691;
	Fri, 10 Oct 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex5RgLKS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E141482E8
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058025; cv=none; b=G7uM6ItFsWfcdaVRdCmTH9t2qwXvFWTs//+LQhZVzQ/IX2c/cU8In0YjTzGREqOxnp2wIG2CeuCUaASnqIOs2vA7iNqe+NVQV04ohs75BprpUMQa08Ak9/64nELctYxG7XzYtMPMySK9ZaU+ky/D8JmdfNRzIZ205GA6Mkx0+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058025; c=relaxed/simple;
	bh=317f2O6jDI484oZyyZztwYrl/kBOO7FfdffIhWpwkXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3WUPU+IpKW2SHZKgMshgXbzllGhw/2+Fda1uKEkj+ymIMJALMTkbueCyIOny0cRxH4jDMF0Qv2+nJsjqN4DRM1WxG84W0SSDgpGNYgqni5e2nXQOtHoV0X1ci/Ho/NWoOOBnthaFrNlvsgNjtv0//gPCRdI8WQpC014DvdJzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex5RgLKS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso8723765e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058022; x=1760662822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxyJBBM7Wb2g2o+uxozv3KN+nj4K7alQxAlD+QYyuwM=;
        b=Ex5RgLKSG+FnvcMN6U7geBuaL6MFtQn88FJrV1h0n4AX3VqtGsucW/63V1j1OA6tD8
         h4WbIw0z4KzEVbx3Ty7fCn4aVLHMY3MleyAaJuvvSapN2tJPD1cXSAPFQNbVoRlGWQ6H
         um3bRyFBQWHz/WECgMzl+OE4/x9Xk5zICDxXjR+IVXYLxvFFztTuV2BysztMQmmIc+r/
         u5dVfblGGu40uOUGyQnwI/2zQz78qkpuH256je7tHLdf6d1hk5T5uAph+4u2j74XW8Oq
         gmnAl02VoBP0pn2xvqQa2p4la0HUMq15bIZlwy1rlb8bRlrsva7qRVgYkiZqKS6Ebwif
         tf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058022; x=1760662822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxyJBBM7Wb2g2o+uxozv3KN+nj4K7alQxAlD+QYyuwM=;
        b=H9TFYZ8IeNpGge7oX4OcpPn4yoMTpvqiBqozFfLjy77QDqbSiQm63Mlov2wCwZ1C0W
         OEDWoBDaZvP9OPMh3JFwlPPLOwhN0UwB5MlbX2k6y32pAdBwfL+nUf6VRazJJdYhHWZ8
         q2XhN01OJRfExbTtlr2NGK1lOzwsca7oqqKEYL8mMIDapDbHw7zA03uvm7y3SehToi06
         OSzYHtYksFuJeRQqpa90Is/qOvCxFqJeZn75YExh3kUuvg1tTkVz4ubTTJ9BKUZXA/qd
         okugDuHc3vH6oNXXCrFUrVNpSXXw6nSaQHXdiSXLHBy+mGPDc/Ik5WmPTxy2DWXALaNR
         Ifhg==
X-Forwarded-Encrypted: i=1; AJvYcCX2lcHDCcBIOo/EQuzdmfncvuIt3EKlZ7EWRLw6FyaqTwnShNJPR0SN6yfqi2+K7n15YLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweX2U8S60VDdkk5ynKbX0SuxYm81H+hU+hRY6YjNLBpdIsF55w
	nb1UJpFSSY2pMNeqcs7oPiPj9hiUcnYXKy+4G9mTbb0LClTvCBvDEVMPgJL0RDPI5IbTD0yQSv4
	nqNGpR/+RTGqeet88VAu/5qyAcQyJBNw=
X-Gm-Gg: ASbGncuN3owvVcANyqfcjMoFLJouNqpZewdskXHr7y7AgUq1oR7G+LHrj/HKwIiKVxN
	osHRjPj/8wDCOkm1EEORKFart8mmP2R+f3azR+tlf0s/G9X//pIQoHnRmgDVSsPd15aPvn/e+w1
	O+YnLk622X0WYrjKY6nlZjmUPMQ9kfivRg7VSZJRi2piBddhdV6JELzAnEmU9eKiKNzjPCjcRwb
	aS0p4VpHn9R5J9WfwxEu9FBTHjx8fhT2kar19+AmAmZKygZwkCqlNC2q/iIwsoS
X-Google-Smtp-Source: AGHT+IGHOXbu9ExQKzm/l1DEKOqTD/8UxKuS6Ty93Mbp7hCKUVTcpKX4fjWtxbXWTgUwyE1SxTqe6T4YIcrSaYww2Wo=
X-Received: by 2002:a05:600c:4f08:b0:46e:3dcb:35b0 with SMTP id
 5b1f17b1804b1-46fa9a94553mr65215995e9.2.1760058021701; Thu, 09 Oct 2025
 18:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com> <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
In-Reply-To: <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 18:00:09 -0700
X-Gm-Features: AS18NWBLhPrItqdGptxcz1segXT70AM46ED1AQ4HqEpfTXy8v7DngMLQAs6a3mo
Message-ID: <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 7, 2025 at 9:53=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Mon, Oct 6, 2025 at 5:08=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Fri, Oct 3, 2025 at 12:25=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > > > On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > > On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.o=
rg> wrote:
> > > > > > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-m=
oore.com> wrote:
>
> ...
>
> > I feel we will keep going in circles on this and I will leave it up to
> > the maintainers to resolve this.
>
> Yes, I think we can all agree that the discussion has reached a point
> where both sides are simply repeating ourselves.
>
> I believe we've outlined why the code merged into Linus' tree during
> this merge window does not meet the BPF signature verification
> requirements of a number of different user groups, with Blaise
> proposing an addition to KP's code to satisfy those needs.  Further, I
> believe that either Blaise, James, or I have responded to all of KP's
> concerns regarding Blaise's patchset, and while KP may not be happy
> with those answers, no one has yet to offer an alternative solution to
> Blaise's patchset.
>
> With that in mind, I agree with KP that it's time for "the maintainers
> to resolve this".  Alexei, will you be merging Blaise's patchset and
> sending it up to Linus?

Nope. Both you and James did not understand what Blaise
patch set is actually doing, and that followed the whole set of
arguments and reasons that made no sense.

James's concern is valid though:

> However, the rub for LSM
> is that the verification of the program map by the loader happens
> *after* the security_bpf_prog_load() hook has been called.

I understand the discomfort, but that's what the kernel module loading
process is doing as well, so you should be concerned with both.
Since both are doing pretty much the same work.
Both allocate and populate kernel memory with data.
For kernel module it's bss, data, rodata.
For bpf it's BTF, maps.
Then the kernel applies relocations to .text against .data and against
the kernel.
bpf is doing the same. It applies relocation against maps, btf, kfuncs.

The only difference here is that ko loading is done by
kernel/module/main.c which is pretty complex on its own,
since it's parsing ELF, symbols, etc
While bpf loader is doing a fraction of that.
It doesn't need to parse ELF. It's a dumb sequence of commands:
load mapA, load mapB, apply relocation at off N to prog M.
If bpf loader has a bug it will still be caught by the verifier,
since it effectively runs multiple times. Once for loader prog,
and then for each prog that loader wants to load.

For kernel modules and for bpf we trust the build system to be correct.
gcc, clang, linker, objtool, pahole, various scripts/* need to do the
right thing for the kernel modules.
In bpf case it's only libbpf that is trusted to produce
valid loader bpf program for a set of bpf programs and maps.
I share the discomfort that tools/lib/bpf/gen_loader.c
is doing something that you don't understand,
but, really, do you understand what gcc, clang, objtool are doing?
You have to trust the build process otherwise it's all pointless.
Malicious "gcc" can inject special code into a signed kernel module.
Malicious "libbpf" can inject something into "loader prog",
but again the verifier is still there even if "loader prog" is busted.

