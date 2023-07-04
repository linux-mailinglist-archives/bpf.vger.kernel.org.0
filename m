Return-Path: <bpf+bounces-4006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A8B747A51
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A3B280F48
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117096FD3;
	Tue,  4 Jul 2023 23:20:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFB5664
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 23:20:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D792E75
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688512827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9aQAOPQwD+OOZUIe6eiLlOHucsE59TCJ7ry9WPFMNk=;
	b=i9vFaoURBQdf6dbk0+FEE7Ud1jSdKd3pRz6T03p/fD7GSPZdTh2e8N52lGUwXrNVFIhPYz
	IllwsgNBDP5XAREWhGd9pXdlnXjXE9pt4SE1JNI1Dt1X0wp83bVCf46Gxu1qluRjmKAijj
	aQfLEJzON3qSJMkegn+wFki+v+SE3lc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Aa-AyDKJP8G6ojr_LMyvHw-1; Tue, 04 Jul 2023 19:20:26 -0400
X-MC-Unique: Aa-AyDKJP8G6ojr_LMyvHw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3141a98a29aso52192f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 16:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688512824; x=1691104824;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9aQAOPQwD+OOZUIe6eiLlOHucsE59TCJ7ry9WPFMNk=;
        b=YgooWgtVxlpgbaoDHk67zVTBITuRPdPek5G/kUgJ0O7mLZ5IwfALAAk9h8KzdEOdS3
         76uQ61Y0ANgzkdZdIANPaEdKlTkYqFzJeP4K8N8MmCmyasPwkFqMoa5ys/c7be9F49V+
         rcb0bwLwdrAhh7lYpBnt4biQFNP/DhDo/QByq4U6HxkuJu1p5+2tvaIAVxvdc4CYU98D
         XfQWVW0+xR1Da5uIRfnojPAhabFVQU7sjbVEYheZmKdaNs7EyPCNp7ljjeHXxXCSIi4b
         hIPwUrdoU+3TK876M5PlNxNFflSq7a1F2ysn520KJdxAo2EfPzbk4mFLSP78GpHqLyTX
         gxAQ==
X-Gm-Message-State: ABy/qLariufgRgkX9u81hIDKG8DbJT01axypoq+Qkj4ICUayjbA1dzT0
	8MIhTuWZnkLZ7EsZNMHOiWsJnT+iN54i8+R0gz6D3irVPKFtmD3Hyza1Cecrv3iOex1GQqjawTh
	kkNg6HxBWsAeMP384uhXN
X-Received: by 2002:adf:f186:0:b0:314:2c9:64c with SMTP id h6-20020adff186000000b0031402c9064cmr502232wro.6.1688512824447;
        Tue, 04 Jul 2023 16:20:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF31K1Xy7QDVAwBBfozwLbnZWVZMK5ZMAARsXvoc8RTwiD4V6KdIQYl/V6JyfsF+c26tycpAQ==
X-Received: by 2002:adf:f186:0:b0:314:2c9:64c with SMTP id h6-20020adff186000000b0031402c9064cmr502215wro.6.1688512823938;
        Tue, 04 Jul 2023 16:20:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm29664484wri.73.2023.07.04.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:20:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AFD6FBC117E; Wed,  5 Jul 2023 01:20:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
In-Reply-To: <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
 <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jul 2023 01:20:22 +0200
Message-ID: <87v8ezb6x5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jun 29, 2023 at 4:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
>> > This patch set introduces new BPF object, BPF token, which allows to d=
elegate
>> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
>> > systemd or any other container manager) to a *trusted* unprivileged
>> > application. Trust is the key here. This functionality is not about al=
lowing
>> > unconditional unprivileged BPF usage. Establishing trust, though, is
>> > completely up to the discretion of respective privileged application t=
hat
>> > would create a BPF token, as different production setups can and do ac=
hieve it
>> > through a combination of different means (signing, LSM, code reviews, =
etc),
>> > and it's undesirable and infeasible for kernel to enforce any particul=
ar way
>> > of validating trustworthiness of particular process.
>> >
>> > The main motivation for BPF token is a desire to enable containerized
>> > BPF applications to be used together with user namespaces. This is cur=
rently
>> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be na=
mespaced
>> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to=
 BPF
>> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can saf=
ely read
>> > arbitrary memory, and it's impossible to ensure that they only read me=
mory of
>> > processes belonging to any given namespace. This means that it's impos=
sible to
>> > have namespace-aware CAP_BPF capability, and as such another mechanism=
 to
>> > allow safe usage of BPF functionality is necessary. BPF token and dele=
gation
>> > of it to a trusted unprivileged applications is such mechanism. Kernel=
 makes
>> > no assumption about what "trusted" constitutes in any particular case,=
 and
>> > it's up to specific privileged applications and their surrounding
>> > infrastructure to decide that. What kernel provides is a set of APIs t=
o create
>> > and tune BPF token, and pass it around to privileged BPF commands that=
 are
>> > creating new BPF objects like BPF programs, BPF maps, etc.
>>
>> So a colleague pointed out today that the Seccomp Notify functionality
>> would be a way to achieve your stated goal of allowing unprivileged
>> containers to (selectively) perform bpf() syscall operations. Christian
>> Brauner has a pretty nice writeup of the functionality here:
>> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-=
unprivileged-container-development
>>
>> In fact he even mentions allowing unprivileged access to bpf() as a
>> possible use case (in the second-to-last paragraph).
>>
>> AFAICT this would enable your use case without adding any new kernel
>> functionality or changing the BPF-using applications, while allowing the
>> privileged userspace daemon to make case-by-case decisions on each
>> operation instead of granting blanket capabilities (which is my main
>> objection to the token proposal, as we discussed on the last iteration
>> of the series).
>
> It's not "blanket" capabilities. You control types or maps and
> programs that could be created. And again, CAP_SYS_ADMIN guarded.
> Please, don't give CAP_SYS_ADMIN/root permissions to applications you
> can't be sure won't do something stupid and blame kernel API for it.

Right, I didn't mean "blanket" in the sense of "permission to do
anything on the system"; I do get that you can restrict which subset of
functionality you grant. However, *within* that subset, it's a blanket
permission grant. I.e., you can't issue a token that grants a *specific*
application permission to load a *specific* BPF program - you can only
grant a general "load any program" permission that can be used by anyone
who possesses the token.

I guess we could in principle extend the token mechanism to allow this,
but the kernel doesn't seem like the right place to implement such a
fine-grained policy engine...

> After all, the root process can setuid() any file and make it run with
> elevated permissions, right? Doesn't get more "blanket" than that.

Which is exactly why setuid binaries are not generally how we implement
security delegation these days. So I don't think designing a new
mechanism this way is a good idea.

>> So I'm curious whether you considered this as an alternative to
>> BPF_TOKEN? And if so, what your reason was for rejecting it?
>>
>
> Yes, I'm aware, Christian has a follow up short blog post specifically
> for using this for proxying BPF from privileged process ([0]).
>
> So, in short, I think it's not a good generic solution. It's very
> fragile and high-maintenance. It's still proxying BPF UAPI (except
> application does preserve illusion of using BPF syscall, yes, that
> part is good) with all the implications: needing to replicate all of
> UAPI (fetching all those FDs from another process, following all the
> pointers from another process' memory, etc), and also writing back all
> the correct things (into another process' memory): log content,
> log_true_size (out param), any other output parameters.

Right, OK, that bit does sound pretty tedious (although I'll note that
there are people who are trying to make all this generally more
palatable[0]).

However, all that tediousness could be avoided while still retaining the
model of blocking the syscall and asking a userspace policy daemon to
supply a verdict. This could even be done using the same token
mechanism: instead of attaching a permission to the token itself, just
make it an opaque identifier. Then, when a syscall is made that contains
the token, block it and send a notification to user space and use the
verdict that comes back in place of the token "value". The notification
could go through the same file descriptor (using read/write or an ioctl,
restricted to CAP_SYS_ADMIN), or it could be a separate one that is
returned alongside it on TOKEN_CREATE. The notification could include
all of the syscall args or a subset, depending on the command, but the
kernel can ensure there are no TOCTOU races, and no need for the policy
daemon to go poking into other another process' namespace.

Actually, using this model I don't think we would even strictly speaking
need the explicit token FD to be included by the calling application
inside the container at all? I.e., if the system policy daemon could
just instruct the kernel "please delegate all permission decisions for
this user namespace to me", it could - so to speak - issue tokens on
demand as each call is made, instead of ahead of time. Which would both
enable the policy daemon to make specific usage decisions, and wouldn't
require any change needed to the applications using BPF inside the
container (not even to include the BPF token FD).

-Toke


