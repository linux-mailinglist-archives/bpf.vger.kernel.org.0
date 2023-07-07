Return-Path: <bpf+bounces-4425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3C74B177
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843AC281769
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE2C8CE;
	Fri,  7 Jul 2023 13:04:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7372F4D
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:04:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDA10C
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688735096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spbb5kMkZNfk5QvmXSW5ZU2UZzQF7gxn+0EuFzvWeok=;
	b=PDUzlGdYD/JMpEuoEh40wRebmtK/fBglzA1gE/4NlvAo0gmUKx5fHG/us1Dplao1bkO8xg
	t/7zwIGg8vTt1Z2Y53UxfCCPoImePD8YXObMUo2f/4Xtb+AsgBqz1rxnxXvKM+GlM2/9aW
	UV1ODMV+2ASTDhgf3ULCmjJqyV3ygbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-ovpxmJRWO8aVm5jL0_lGPw-1; Fri, 07 Jul 2023 09:04:55 -0400
X-MC-Unique: ovpxmJRWO8aVm5jL0_lGPw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso1875675e9.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 06:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735094; x=1691327094;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spbb5kMkZNfk5QvmXSW5ZU2UZzQF7gxn+0EuFzvWeok=;
        b=fy/01/YI2Vz3weAaaytXNmcY7t6EUlgwjIpHiOa85BGW3KFq2wtnCCYUyC+uOrOggA
         J2X8cZsYZ9rslf3pngLepFEWqLKu/2t1ujaLDI47dWLraJYBSVvkmI5GJfPmnBLyYlly
         pgOq/VPjgkVgoVMrmBROkpHm2ou5wky6fMNDPNqeKGVyDk13CHClhpep7Vu7xbdwec1c
         jswJ9CnmMxtcwGhGPo2AMvvVDz8+mm+5mE9BN8LK8ZSIkz5THXtVQPIV/7xgmoGNr57B
         dHGjkT3mCviIJtajkWD7L+ayguH28Elg0uyoF7v6WTlqc8HygfE27ZCAa4F3zOfeyaer
         7PLw==
X-Gm-Message-State: ABy/qLYdmezMhCjDSb6mJPGJIlcwJwkNMFSPRPg8kgL6eEGh75PsXDOh
	xE6P1h5FOjbQNI+tN6Qa4p0QV26/+aRXi8wn1SHbpXdiEPBAH0tmKoLq/jtIE1nSUjzPYnJtvuV
	bvsMBvsCxVo6g
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2850683wmc.33.1688735093858;
        Fri, 07 Jul 2023 06:04:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF90VvveDFzTN1MQrOvnaykAYXVLdJCvIKpc9PxsXc0M8lpyZ+5l5tClUkOMEubknZgQtjM4A==
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2850660wmc.33.1688735093412;
        Fri, 07 Jul 2023 06:04:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003fbc9b9699dsm2381013wma.45.2023.07.07.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:04:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7F015C59720; Fri,  7 Jul 2023 15:04:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
 <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk>
 <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Jul 2023 15:04:51 +0200
Message-ID: <87lefrhnyk.fsf@toke.dk>
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

> On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > Having it as a separate single-purpose FS seems cleaner, because we
>> > have use cases where we'd have one BPF FS instance created for a
>> > container by our container manager, and then exposing a few separate
>> > tokens with different sets of allowed functionality. E.g., one for
>> > main intended workload, another for some BPF-based observability
>> > tools, maybe yet another for more heavy-weight tools like bpftrace for
>> > extra debugging. In the debugging case our container infrastructure
>> > will be "evacuating" any other workloads on the same host to avoid
>> > unnecessary consequences. The point is to not disturb
>> > workload-under-human-debugging as much as possible, so we'd like to
>> > keep userns intact, which is why mounting extra (more permissive) BPF
>> > token inside already running containers is an important consideration.
>>
>> This example (as well as Yafang's in the sibling subthread) makes it
>> even more apparent to me that it would be better with a model where the
>> userspace policy daemon can just make decisions on each call directly,
>> instead of mucking about with different tokens with different embedded
>> permissions. Why not go that route (see my other reply for details on
>> what I mean)?
>
> I don't know how you arrived at this conclusion,

Because it makes it apparent that you're basically building a policy
engine in the kernel with this...

> but we've debated BPF proxying and separate service at length, there
> is no point in going on another round here.

You had some objections to explicit proxying via RPC calls; I suggested
a way of avoiding that by keeping the kernel in the loop, which you have
not responded to. If you're just going to go ahead with your solution
over any objections you could just have stated so from the beginning and
saved us all a lot of time :/

Can we at least put this thing behind a kconfig option, so we can turn
it off in distro kernels?

> Per-call decisions can be achieved nicely by employing BPF LSM in a
> restrictive manner on top of BPF token (or no token, if you are ok
> without user namespaces).

Building a deficient security delegation mechanism and saying "you can
patch things up using an LSM" is a terrible design, though. Also, this
still means you have to implement all the policy checks in the kernel
(just in BPF) which is awkward at best.

-Toke


