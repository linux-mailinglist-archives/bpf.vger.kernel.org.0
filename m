Return-Path: <bpf+bounces-2589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68472FE0E
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C15281212
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9128F5A;
	Wed, 14 Jun 2023 12:12:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF79441
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 12:12:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF762717
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686744733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqI35d8McDvfvESnN6I+vtvR8s0ur8VarK3flkj92Do=;
	b=R59Iweht4svS8EqnBdisOtsnoOjjBRmgtxrYyVCHCRYwwnEuOBQ5H+09KHFoibMsDOVgh2
	FPXvtla4WoeynPTk+BlRPEFKNNHaLGFM6vhlYGP80hb9jKMxLjUOUe8S7efeHraBaWKzVR
	Dw5UvFndxzXJ6j/5HJ982urvHzCrZmI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-zh_PipwGPOOLsIvmppqnZg-1; Wed, 14 Jun 2023 08:12:12 -0400
X-MC-Unique: zh_PipwGPOOLsIvmppqnZg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977d0333523so76052566b.0
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 05:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744730; x=1689336730;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqI35d8McDvfvESnN6I+vtvR8s0ur8VarK3flkj92Do=;
        b=etqr/JZZ7YICzZ5574GsLyE+GClom8BPqRpI5cWFFhkhpi3Q+Ttqi4RUCk7OSINym1
         l/bvCnBbTG+6a702vqDLrHgtvlLIn0JzOgcdUdy3RaIgEnyd12Bwm+eE50o7EQB4eJjv
         U0QSCqFw9AefuTM9g1HN4haWsW31XrGe+q/BxftZ20xhbUgQKF3xN4TVSLeteomO2w/x
         7VpxrzMwHsx52EMkxmW0A/94dy+ANv5RFpGPwqfCJth3gEUlthc7Ywz5ppOv7VTTO69q
         4c+3ygGPd2AVBKhb40Hkljy6wqDNkcs5rKDAPRooIiaYJwBihlRgcCP2kr2h7m7ZLrmf
         X4uw==
X-Gm-Message-State: AC+VfDyQ7+ynH7f2BEoHl323UDpbINb6NpS8xuFKhPvmCbgRWJfiXjdR
	PZtF6FEZUco3GN1aQBYTF3EpyTG3+hLwOIJnmgIaCSxhYwE1mBbNqKVeoGjI4zT2fhZ/LTqhhzm
	ygugbopSO3wPTd9SzqHdj
X-Received: by 2002:a17:907:6d97:b0:973:d953:4bf7 with SMTP id sb23-20020a1709076d9700b00973d9534bf7mr17634815ejc.48.1686744730308;
        Wed, 14 Jun 2023 05:12:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Dy3Th2+3QKV30gEYSWV7XVPa+TAUXvwcdMExre+3DCvbHaQD3hXTisc5ZA8jGguvnDfQanw==
X-Received: by 2002:a17:907:6d97:b0:973:d953:4bf7 with SMTP id sb23-20020a1709076d9700b00973d9534bf7mr17634769ejc.48.1686744729596;
        Wed, 14 Jun 2023 05:12:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061cd700b0094f07545d40sm7867689ejh.220.2023.06.14.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:12:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 07E90BBEB67; Wed, 14 Jun 2023 14:06:02 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk>
 <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
 <87bkhlymyk.fsf@toke.dk>
 <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jun 2023 14:06:01 +0200
Message-ID: <874jnal046.fsf@toke.dk>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Jun 12, 2023 at 3:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@kernel.org> wrote:
>> >> >>
>> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
>> >> >>
>> >> >> > This patch set introduces new BPF object, BPF token, which allow=
s to delegate
>> >> >> > a subset of BPF functionality from privileged system-wide daemon=
 (e.g.,
>> >> >> > systemd or any other container manager) to a *trusted* unprivile=
ged
>> >> >> > application. Trust is the key here. This functionality is not ab=
out allowing
>> >> >> > unconditional unprivileged BPF usage. Establishing trust, though=
, is
>> >> >> > completely up to the discretion of respective privileged applica=
tion that
>> >> >> > would create a BPF token.
>> >> >>
>> >> >> I am not convinced that this token-based approach is a good way to=
 solve
>> >> >> this: having the delegation mechanism be one where you can basical=
ly
>> >> >> only grant a perpetual delegation with no way to retract it, no wa=
y to
>> >> >> check what exactly it's being used for, and that is transitive (ca=
n be
>> >> >> passed on to others with no restrictions) seems like a recipe for
>> >> >> disaster. I believe this was basically the point Casey was making =
as
>> >> >> well in response to v1.
>> >> >
>> >> > Most of this can be added, if we really need to. Ability to revoke =
BPF
>> >> > token is easy to implement (though of course it will apply only for
>> >> > subsequent operations). We can allocate ID for BPF token just like =
we
>> >> > do for BPF prog/map/link and let tools iterate and fetch information
>> >> > about it. As for controlling who's passing what and where, I don't
>> >> > think the situation is different for any other FD-based mechanism. =
You
>> >> > might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
>> >> > or BPF FS, and that application can keep doing the same to other
>> >> > processes.
>> >>
>> >> No, but every other fd-based mechanism is limited in scope. E.g., if =
you
>> >> pass a map fd that's one specific map that can be passed around, with=
 a
>> >> token it's all operations (of a specific type) which is way broader.
>> >
>> > It's not black and white. Once you have a BPF program FD, you can
>> > attach it many times, for example, and cause regressions. Sure, here
>> > we are talking about creating multiple BPF maps or loading multiple
>> > BPF programs, so it's wider in scope, but still, it's not that
>> > fundamentally different.
>>
>> Right, but the difference is that a single BPF program is a known
>> entity, so even if the application you pass the fd to can attach it
>> multiple times, it can't make it do new things (e.g., bpf_probe_read()
>> stuff it is not supposed to). Whereas with bpf_token you have no such
>> guarantee.
>
> Sure, I'm not claiming BPF token is just like passing BPF program FD
> around. My point is that anything in the kernel that is representable
> by FD can be passed around to an unintended process through
> SCM_RIGHTS. And if you want to have tighter control over who's passing
> what, you'd probably need LSM. But it's not a requirement.
>
> With BPF token it is important to trust the application you are
> passing BPF token to. This is not a mechanism to just freely pass
> around the ability to do BPF. You do it only to applications you
> control.

Trust is not binary, though. "Do I trust this application to perform
this specific action" is different from "do I trust this application to
perform any action in the future". A security mechanism should grant the
minimum required privileges required to perform the operation; this
token thing encourages (defaults to) broader grants, which is worrysome.

> With user namespaces, if we could grant CAP_BPF and co to use BPF,
> we'd do that. But we can't. BPF token at least gives us this
> opportunity.

If the use case is to punch holes in the user namespace isolation I feel
like that is better solved at the user namespace level than the BPF
subsystem level...

-Toke


(Ran out of time and I'm about to leave for PTO, so dropping the RPC
discussion for now)


