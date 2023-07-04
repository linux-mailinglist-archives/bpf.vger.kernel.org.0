Return-Path: <bpf+bounces-4008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23001747A65
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8C6280FCA
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B88839;
	Tue,  4 Jul 2023 23:33:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6E210A
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 23:33:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881610E5
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 16:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688513612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kA4f+8B/kxLukv7a/BQg0loCO+oeIsR1MEG7lGSAPE=;
	b=SCcTWrlpx7oYUL8L16a1WUeuVR5k33yhmq8E0LI48yWhE9ZQwG0gb925NP9q/dr1hvzjH/
	7IxCyyZ11/TvLd+RdROe1PhzeeM4hFdq0MLQAbLvjiEMXyqFYqAy9hgrzxFsSc9Sp0Dr+a
	Jo4DNWpwWDWzZoisqfk29G2nILJc2lQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-_d37b-G6MXOTTDq7GCQMFg-1; Tue, 04 Jul 2023 19:33:31 -0400
X-MC-Unique: _d37b-G6MXOTTDq7GCQMFg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa8cd898e0so41753325e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513609; x=1691105609;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kA4f+8B/kxLukv7a/BQg0loCO+oeIsR1MEG7lGSAPE=;
        b=fedRS9ETvACFyfTITVqeZw+NAJvGtgOggOwDgViQLB8ecSyAc5j2lh9OU+rnacwCCw
         /JQaXvChP4jJ4pESXYnF2wI6JApJ3X16aKqE3lgmENsryGtXygD4p8Gr57xtFe4UHSb4
         QCEBbi74KRV25N9oWFTx4TNW1QUDEDxJbwOJpVYohYcT0KMA4lZ0ov4nqkHF8ijo+Gya
         mtN5AAcFRujZQKUR7IJtFFjfe3xdFNylG8CijyZ6dI7G3uTQcW7AGIOkZjCdCaRcVT7f
         Uy506NKmAuZFtfeoo5BrCTzkeM/MRXeG6a3C3Ta5u5olBzAd9esfG9UZDfPoMTIc90jD
         5oTw==
X-Gm-Message-State: AC+VfDzBJZLVfTNIvyflOkUGjiirowoeJhliG+wdctHQWUZfqF3Nx40m
	u7LneMH47H4/siUnJo4EXyo1kJhRRnKPjfjvSEr8E2HOD81tmByXeSPQJzd/KfGhAbp224xxwc+
	KO+ey8sJBCTWGplJhBY6S
X-Received: by 2002:a7b:cb4d:0:b0:3f9:b17a:cb61 with SMTP id v13-20020a7bcb4d000000b003f9b17acb61mr14118014wmj.13.1688513609686;
        Tue, 04 Jul 2023 16:33:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oSNue88FePJzmOEk4Bqio+XxvPYnKACghZTixemR5QnwEnid0A1q6bnfFLewsGCaLxBQBcw==
X-Received: by 2002:a7b:cb4d:0:b0:3f9:b17a:cb61 with SMTP id v13-20020a7bcb4d000000b003f9b17acb61mr14117999wmj.13.1688513609211;
        Tue, 04 Jul 2023 16:33:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fbca05faa9sm425231wmi.24.2023.07.04.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:33:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3D45DBC1185; Wed,  5 Jul 2023 01:33:28 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
 kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
In-Reply-To: <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
 <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jul 2023 01:33:28 +0200
Message-ID: <87pm57b6bb.fsf@toke.dk>
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

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Jun 30, 2023 at 01:15:47AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>=20
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
>>=20
>> So a colleague pointed out today that the Seccomp Notify functionality
>> would be a way to achieve your stated goal of allowing unprivileged
>> containers to (selectively) perform bpf() syscall operations. Christian
>> Brauner has a pretty nice writeup of the functionality here:
>> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-=
unprivileged-container-development
>
> I'm amazed you read this. :)

I found it quite an enjoyable read, actually :)

> The seccomp notifier comes with a lot of caveats. I think it would be
> impractical if not infeasible to handle bpf() delegation.

Right, thank you for chiming in and explaining the context. I replied
elsewhere in the thread on the content, so let's not fork the discussion
any more than we have to...

-Toke


