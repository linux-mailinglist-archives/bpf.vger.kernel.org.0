Return-Path: <bpf+bounces-2166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FF728B07
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619542817E8
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037234D86;
	Thu,  8 Jun 2023 22:18:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53C34CD2
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:18:03 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397D210C;
	Thu,  8 Jun 2023 15:18:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-976a0a1a92bso210563266b.1;
        Thu, 08 Jun 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686262680; x=1688854680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM94IDZlFcOi7Ij9j2D+vnzyDlWGkrXzSL9hn9Nm6kY=;
        b=XhyVs8FekDfWbH680cja8y7S/fLN2qHQXGUAhGQRbS8aAdU4fvbInDwQNqx7zjObCF
         bLm6I9DyihqyILPo5mftrD0r1rfo9zopZFW4eTAzksYrDkjm9OQCPw94bg5kNwC/FnoI
         7mWPvRRLHA7gw1P3JXl5b1McWWZzhrRG0Jj3qJx6/PUb3iS7styTkX6JisHJJTepyfZv
         a0OyxdSeqK2PUZiRGo/+YnTstR0T8eEGTHmUP7Fd8vFvxFx67p/ewPOAL6xLQjMk0I1T
         PMKaRNYzs3iQFFLwV5ywzlxRBrW9B/8mCG5ow92bHEAQnKbHoMLz35xo9GJpHsvGKyio
         UHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686262680; x=1688854680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM94IDZlFcOi7Ij9j2D+vnzyDlWGkrXzSL9hn9Nm6kY=;
        b=IAH4LdjvWFFS5IxDFQIAKuPSiEeCj/Fr3gYJaRZj2KsOTfg7bCSJkmP/QgGrpqaNpR
         5pOn/CLislPNKh3iEYOsPnhpo25Z/tIpGY1WC3JEUo1PYaF8ykaUScFVOql569ZY7+dX
         IJf3Jfai0zx+OVPCvCzJt6F995DJLrUbE9N364lpVJj8w7NJYO+E5+fXxX2cO7fhpOVz
         7LRTSWqKyQSIv4aBVMlS9xczIfCwz1qDB/l7Esw5A3t3uzRUU3M4a9NOVsxzms8BNBs2
         SIcKP1fgetMMq5M56ml+GNNWRWrX39Pi2ZTIAoqcowr63ZiNCY2/Mz9XEoge+n2Pz4bL
         rkaw==
X-Gm-Message-State: AC+VfDwbJwPM5o7G8Q0VURyUGu2ig8GNL8Acx+XCndxkpY/4H531fpZh
	jtvab+pOv9qS3D6lhaSMOWko/UXeBuH8mm5kpZg=
X-Google-Smtp-Source: ACHHUZ4UOd7bTt3rEB73C0kkIsiuD6JeMo5Lx7qeCq+bogArq5jKNJPSHN6H1nG4fGGmORNVfp4PKmSRZyW+aAGEqvA=
X-Received: by 2002:a17:907:3fa8:b0:96a:3f29:40d9 with SMTP id
 hr40-20020a1709073fa800b0096a3f2940d9mr533945ejc.25.1686262679687; Thu, 08
 Jun 2023 15:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <ZIIipx1NhKYQq7T/@google.com>
In-Reply-To: <ZIIipx1NhKYQq7T/@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 15:17:48 -0700
Message-ID: <CAEf4Bza5xkMBKFcgi+NkjFq4rfCHAfgrH6GJLhEVWxD0pVWeZw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 11:49=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 06/07, Andrii Nakryiko wrote:
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token.
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is curr=
ently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be nam=
espaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to =
BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safe=
ly read
> > arbitrary memory, and it's impossible to ensure that they only read mem=
ory of
> > processes belonging to any given namespace. This means that it's imposs=
ible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism =
to
> > allow safe usage of BPF functionality is necessary. BPF token and deleg=
ation
> > of it to a trusted unprivileged applications is such mechanism. Kernel =
makes
> > no assumption about what "trusted" constitutes in any particular case, =
and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to=
 create
> > and tune BPF token, and pass it around to privileged BPF commands that =
are
> > creating new BPF objects like BPF programs, BPF maps, etc.
> >
> > Previous attempt at addressing this very same problem ([0]) attempted t=
o
> > utilize authoritative LSM approach, but was conclusively rejected by up=
stream
> > LSM maintainers. BPF token concept is not changing anything about LSM
> > approach, but can be combined with LSM hooks for very fine-grained secu=
rity
> > policy. Some ideas about making BPF token more convenient to use with L=
SM (in
> > particular custom BPF LSM programs) was briefly described in recent LSF=
/MM/BPF
> > 2023 presentation ([1]). E.g., an ability to specify user-provided data
> > (context), which in combination with BPF LSM would allow implementing a=
 very
> > dynamic and fine-granular custom security policies on top of BPF token.=
 In the
> > interest of minimizing API surface area discussions this is going to be
> > added in follow up patches, as it's not essential to the fundamental co=
ncept
> > of delegatable BPF token.
> >
> > It should be noted that BPF token is conceptually quite similar to the =
idea of
> > /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> > difference is the idea of using virtual anon_inode file to hold BPF tok=
en and
> > allowing multiple independent instances of them, each with its own set =
of
> > restrictions. BPF pinning solves the problem of exposing such BPF token
> > through file system (BPF FS, in this case) for cases where transferring=
 FDs
> > over Unix domain sockets is not convenient. And also, crucially, BPF to=
ken
> > approach is not using any special stateful task-scoped flags. Instead, =
bpf()
> > syscall accepts token_fd parameters explicitly for each relevant BPF co=
mmand.
> > This addresses main concerns brought up during the /dev/bpf discussion,=
 and
> > fits better with overall BPF subsystem design.
> >
> > This patch set adds a basic minimum of functionality to make BPF token =
useful
> > and to discuss API and functionality. Currently only low-level libbpf A=
PIs
> > support passing BPF token around, allowing to test kernel functionality=
, but
> > for the most part is not sufficient for real-world applications, which
> > typically use high-level libbpf APIs based on `struct bpf_object` type.=
 This
> > was done with the intent to limit the size of patch set and concentrate=
 on
> > mostly kernel-side changes. All the necessary plumbing for libbpf will =
be sent
> > as a separate follow up patch set kernel support makes it upstream.
> >
> > Another part that should happen once kernel-side BPF token is establish=
ed, is
> > a set of conventions between applications (e.g., systemd), tools (e.g.,
> > bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through=
 BPF FS
> > at well-defined locations to allow applications take advantage of this =
in
> > automatic fashion without explicit code changes on BPF application's si=
de.
> > But I'd like to postpone this discussion to after BPF token concept lan=
ds.
> >
> >   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel=
.org/
> >   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_=
BPF_LSFMM2023.pdf
> >   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubravi=
ng@fb.com/
> >
> > v1->v2:
> >   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
> >   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
>
> I went through v2, everything makes sense, the only thing that is
> slightly confusing to me is the bpf_token_capable() call.
> The name somehow implies that the token is capable of something
> where in reality the function does "return token || capable(x)".

heh, "bpf_token_" part is sort of like namespace/object prefix. The
intent here was to have a token-aware capable check. And yes, if we
get a token during prog/map/etc construction, the assumption is that
it provides all relevant permissions.

>
> IMO, it would be less confusing if we do something like the following,
> explicitly, instead of calling a function:
>
> if (token || {bpf_,perfmon_,}capable(x)) ...
>
> (or rename to something like bpf_token_or_capable(x))

I'd rather not open-code `if (token || ...)` checks everywhere, but I
can rename to `bpf_token_or_capable()` if people prefer. I erred on
the side of succinctness, but if it's confusing, then best to rename?

>
> Up to you on whether to take any action on that. OTOH, once you
> grasp what bpf_token_capable really does, it's not really a problem.

Cool, thanks for taking a look!

