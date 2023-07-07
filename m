Return-Path: <bpf+bounces-4498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850F74B952
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3394D281937
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C417ACA;
	Fri,  7 Jul 2023 22:00:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1910977
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 22:00:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B9D2107
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688767215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNM5Xhxq9hB8uIga0I9P4P+njOlk1EObq/xkZxhcTnY=;
	b=biFl7kFN6QiMEtIUfugnSQ6yEMMK7xVrLJJKur8FgCiPkqahzyeH0YHPJADy14jpKu+ZN6
	aEfw9u6RY57zceYRq/2I8ESoOjpZ1DsQzEvzRm1I/enZeXXAX8FOY4kzfUG6XV/BiyRy4g
	EQthtKQVN2QlnmXBOqx8MX5N+CUAoV4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-x4TF-6jRNMmq_6nBAtzM3w-1; Fri, 07 Jul 2023 18:00:13 -0400
X-MC-Unique: x4TF-6jRNMmq_6nBAtzM3w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9928b4f1612so162809666b.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 15:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767212; x=1691359212;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNM5Xhxq9hB8uIga0I9P4P+njOlk1EObq/xkZxhcTnY=;
        b=epB0EukT2+segSjnKeuS4LtgeH239Z/LSx0Nds3+FbsFlTNp6MVkMyI5gMr3I+UCYn
         1eOP/XB3aPY6QLDPO22jYh7HIRPPFVB8qllYxvlW5RcLkYELZJCAuP5kHAwneakmXujN
         dsFMa0bdgdzLsyKw/YBWhJMjUhwpu+93LhXwl1yK/BnY8TdLAVAwVAxNU3OlFtxJc4k/
         Jb7wUn1U6dTD0GxJSnIam0Z5OU+zQxXcFWMnf6gF1G0vuEXlZFt0AZAzt9PP79qirl83
         ZU/+0X3S3weM1LIL8NUvaauuKWMvqV/CpqWk4mueuP6b2XULk+i1ggP3NtJFCb6n9Aqa
         Hwjg==
X-Gm-Message-State: ABy/qLZ+3V0s34CcmEWo7rxzg4Vwah7iPjBlHV4lAg6bS8cBhxlL7UX2
	DiTxym2/2YC8bUvUUf5frqXJHUvyniGX1vUteNab2dc6zkYaFxkrHXIxxkXyGtnP7ZN865ikHSE
	SL7X3fL8ve533
X-Received: by 2002:a17:906:77db:b0:993:cefe:e00f with SMTP id m27-20020a17090677db00b00993cefee00fmr2604408ejn.15.1688767212351;
        Fri, 07 Jul 2023 15:00:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMRd1qV3OZ9Ks1pnYvJe/S3n1L28nMas7i4JmK/uOIVAbNQWfUeESXgz0FSTOd3eszwAvkEA==
X-Received: by 2002:a17:906:77db:b0:993:cefe:e00f with SMTP id m27-20020a17090677db00b00993cefee00fmr2604395ejn.15.1688767211928;
        Fri, 07 Jul 2023 15:00:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qq2-20020a17090720c200b0098860721959sm2656277ejb.198.2023.07.07.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:00:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0ECB3C597FA; Sat,  8 Jul 2023 00:00:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <CAEf4BzZAeSKYOgHq5UTgPp+=z7bm6Fr5=OFC9Efr0aj4uVbaAQ@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
 <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk>
 <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
 <87lefrhnyk.fsf@toke.dk>
 <CAEf4BzZAeSKYOgHq5UTgPp+=z7bm6Fr5=OFC9Efr0aj4uVbaAQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 08 Jul 2023 00:00:10 +0200
Message-ID: <87pm53fklx.fsf@toke.dk>
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

> On Fri, Jul 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > Having it as a separate single-purpose FS seems cleaner, because we
>> >> > have use cases where we'd have one BPF FS instance created for a
>> >> > container by our container manager, and then exposing a few separate
>> >> > tokens with different sets of allowed functionality. E.g., one for
>> >> > main intended workload, another for some BPF-based observability
>> >> > tools, maybe yet another for more heavy-weight tools like bpftrace =
for
>> >> > extra debugging. In the debugging case our container infrastructure
>> >> > will be "evacuating" any other workloads on the same host to avoid
>> >> > unnecessary consequences. The point is to not disturb
>> >> > workload-under-human-debugging as much as possible, so we'd like to
>> >> > keep userns intact, which is why mounting extra (more permissive) B=
PF
>> >> > token inside already running containers is an important considerati=
on.
>> >>
>> >> This example (as well as Yafang's in the sibling subthread) makes it
>> >> even more apparent to me that it would be better with a model where t=
he
>> >> userspace policy daemon can just make decisions on each call directly,
>> >> instead of mucking about with different tokens with different embedded
>> >> permissions. Why not go that route (see my other reply for details on
>> >> what I mean)?
>> >
>> > I don't know how you arrived at this conclusion,
>>
>> Because it makes it apparent that you're basically building a policy
>> engine in the kernel with this...
>
> I disagree that this is a policy engine in the kernel. It's a building
> block for delegation and enforcement. The policy itself is implemented
> in user-space by a privileged process that decides when to issue BPF
> tokens and of which configuration. And, optionally and if necessary,
> further restricting using BPF LSM in a more fine-grained and dynamic
> way.

Right, and I'm saying that it's too coarse-grained to be a proper
building block in its own right. As evidenced by the need for adding an
LSM on top to do anything fine-grained; a task which is decidedly
non-trivial to get right, BTW. Which means that the path of least
resistance is going to be to just grant a token and not bother with the
LSM, thus ending up with this being a giant foot gun from a security
PoV.

>> > but we've debated BPF proxying and separate service at length, there
>> > is no point in going on another round here.
>>
>> You had some objections to explicit proxying via RPC calls; I suggested
>> a way of avoiding that by keeping the kernel in the loop, which you have
>
> I thought we settled the seccomp notify proposal?

Your objection to that was that it was too much of a hack to read all
the target process memory (etc) from the policy daemon, which I
acknowledged and suggested a way of keeping the kernel in the loop so it
can take responsibility for the gnarly bits while still allowing
userspace to actually make the decision:

https://lore.kernel.org/r/87v8ezb6x5.fsf@toke.dk

(Last two paragraphs). Maybe that message just got lost somewhere on its
way to your inbox?

>> not responded to. If you're just going to go ahead with your solution
>> over any objections you could just have stated so from the beginning and
>> saved us all a lot of time :/
>
> It would also be good to understand that yours is but one of the
> opinions. If you read the thread carefully you'll see that other
> people have differing opinions. And yours doesn't necessarily have to
> be the deciding one.
>
> I appreciate the feedback, but I don't appreciate the expectation that
> your feedback is binding in any way.

I'm not expecting veto rights, I'm objecting to being ignored. The way
this development process is *supposed* to work (as far as I'm concerned)
is that someone proposes a patch series, the community provides
feedback, and discussion proceeds until there's at least rough consensus
that the solution we've arrived at is the right way forward.

If you're going to cut that process short and just pick and choose which
comments are worth addressing and which are not, I can't stop you,
obviously; but at least do me the favour of being up front about it so I
can stop wasting my time trying to be constructive.

Anyhow, I guess this point is moot for this discussion since I'm about
to leave for vacation for four weeks and won't be able to follow up on
this. Apologies for the bad timing :/ I'll ping some RH folks and try to
get them to keep an eye on this while I'm away...

>> Can we at least put this thing behind a kconfig option, so we can turn
>> it off in distro kernels?
>
> Why can't distro disable this in some more dynamic way, though? With
> existing LSM mechanism, sysctl, whatever? I think it would be useful
> to let users have control over this and decide for themselves without
> having to rebuild a custom kernel.

A sysctl similar to the existing one for unprivileged BPF would be fine
as well. If an LSM ends up being the only way to control it, though,
that will carry so much operational overhead for us to get to a working
state that it'll most likely be simpler to just patch it out of the
kernel.

-Toke


