Return-Path: <bpf+bounces-11175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490F7B4820
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AD6901C20823
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F6F9C7;
	Sun,  1 Oct 2023 14:43:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B72561
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 14:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3491AC433CC
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696171421;
	bh=MxXNKGkMABTj7m1F3TnGs0m9Nxu+TtI9S/sISzcyIis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MDa/wof5f7n7KdZbQpuQjIEyiC75hw90J5UMHSP9yMZDgwbymTUeCS/mBw70cluho
	 7YTQyxWz9o0Hj+/HIXJ6g4+Zv3t9DjCkWirjPrb/Kslm63xSmvxenLbs4cC8ZiIPBK
	 LDbhl6uf8k6CcRbRurIKrOy7hJEeSxeqaz630aVE80zCSo9Y7sL/eIryJ+dxFVH38U
	 yFTf4pWZLebL6iErYhMl3K9yNoywxBsLR/ZzOMa/PQSQyyR0R4KgdiVpOTxw262xGQ
	 YreEImWKUmmltNRzrcrmWU4apV0O3O8xlFDV9EqzBUge7ByIyoFm3fhUUXTeE6ruh8
	 b6jZEM0qiTndw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso11985557a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Oct 2023 07:43:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YyeE/bN3B/tVCVR0Sym3VEg/QDWECZLMo65+a0zqYxzJ4Uwlf20
	Yaxn7CVRJmEyoLm+M00WoNBS9PeE3EPTz6S3d5WIeg==
X-Google-Smtp-Source: AGHT+IFXD1zwL0BFsbEcDshW+JOKqTiSKH988yrcZYFh4rFUK1Gnv1NJrE+66LFvnxVk3cg6eZMEkAlM70J6AnkSh6w=
X-Received: by 2002:aa7:c7c3:0:b0:530:52a0:8b1a with SMTP id
 o3-20020aa7c7c3000000b0053052a08b1amr7385105eds.25.1696171419555; Sun, 01 Oct
 2023 07:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com> <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
In-Reply-To: <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 1 Oct 2023 16:43:28 +0200
X-Gmail-Original-Message-ID: <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com>
Message-ID: <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 1, 2023 at 1:08=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/28 1:02, KP Singh wrote:
> >> Question for KP Singh would be how can we allow dynamically appendable
> >> LSM modules if current linked list is replaced with static calls with
> >> minimal-sized array...
> >
> > As I suggested in the other thread:
> >
> > https://lore.kernel.org/bpf/20230918212459.1937798-1-kpsingh@kernel.org=
/T/#md21b9d9cc769f39e451d20364857b693d3fcb587
> >
> > You can add extra static call slots and fallback to a linked list
> > based implementation if you have more than say N modules [1] and
> > fallback to a linked list implementation [2].
>
> As I explained in the other thread:
>
> https://lkml.kernel.org/r/c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAK=
URA.ne.jp
>
> build-time configuration does not help at all.
>
> >
> > for [1] you can just do MAX_LSM_COUNT you can just do:
> >
> > #ifdef CONFIG_MODULAR_LSM
> > #define MODULAR_LSM_ENABLED "1,1,1,1"
> > #endif
> >
> > and use it in the LSM_COUNT.
> >
> > for [2] you can choose to export a better module API than directly
> > exposing security_hook_heads.
> >
> > Now, comes the question of whether we need dynamically loaded LSMs, I
> > am not in favor of this. Please share your limitations of BPF as you
> > mentioned and what's missing to implement dynamic LSMs. My question
> > still remains unanswered.
> >
> > Until I hear the real limitations of using BPF, it's a NAK from me.
>
> Simple questions that TOMOYO/AKARI/CaitSith LSMs depend:
>
>   Q1: How can the BPF allow allocating permanent memory (e.g. kmalloc()) =
that remains
>       the lifetime of the kernel (e.g. before starting the global init pr=
ocess till
>       the content of RAM is lost by stopping electric power supply) ?

This is very much possible using global BPF maps. Maps can be "pinned"
so that they remain allocated until explicitly freed [or RAM is lost
by stopping electric power supply"]

Here's an example of BPF program that allocates maps:

    https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/=
bpf/progs/test_pinning.c#L26

and the corresponding userspace code that does the pinning:

    https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/=
bpf/prog_tests/pinning.c

Specifically for LSMs, we also added support for security blobs which
are tied to a particular object and are free with the object, have a
look at the storage which is allocated in the program:

   https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/b=
pf/progs/local_storage.c#L79

Again, code and context on what you want to do will let me help you more he=
re.

>
>   Q2: How can the BPF allow interacting with other process (e.g. inter pr=
ocess communication
>       using read()/write()) which involves opening some file on the files=
ystem and sleeping
>       for arbitrary duration?

The BPF program runs in the kernel context, so yes all of this is
possible. IPC can be done with the bpf_ring_buffer / maps and BPF also
has the ability to send signals. One can poll on the ring buffer on
events and data from the BPF program and do a lots of things.

* e.g. receive and log command line parameters (e.g. from the security
hook bprm_committed_creds).
* Trigger various actions in user space.

Can you share your module code here, so that one can provide more
concrete suggestions?

- KP

>
>
>
> >>  struct security_hook_heads security_hook_heads __ro_after_init;
> >> +EXPORT_SYMBOL_GPL(security_hook_heads);
> >
> > Rather than exposting security_hook_heads, this should actually export
> > security_hook_module_register. This should internally handle any data
> > structures used and also not need the special magic that you did for
> > __ro_after_init.
>
> I'm fine if security_hook_module_register() (and related code) cannot be
> disabled by the kernel configuration.
>

