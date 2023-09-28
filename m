Return-Path: <bpf+bounces-11059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A724B7B2528
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 098C1B20B6B
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6C516D6;
	Thu, 28 Sep 2023 18:21:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F3513C5
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 18:21:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12EAC
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695925294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zZ41cSzjRu3bJc+WDINtVKvVybFu1pLOZpQDJBuPVE=;
	b=jGNdC6Nr2D+867pdXQgWvrvtpeHgNtamd1kkl0P9nLNZPlNuMnvKCQDWvHJ7MikHPiTSz2
	03dXypHsp1MYBtIRO7pYfBifSnhznLNEmBlZraiMhYgNLNfrUeBRYJs+uoTqvw04EJOrZ4
	8qY89lvSZrrkHoKbO1cmNe7eNJfIfBk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-4Qo0fTTSPD6tbnxbACCLaQ-1; Thu, 28 Sep 2023 14:21:33 -0400
X-MC-Unique: 4Qo0fTTSPD6tbnxbACCLaQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5344aaf2703so5820224a12.0
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925292; x=1696530092;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zZ41cSzjRu3bJc+WDINtVKvVybFu1pLOZpQDJBuPVE=;
        b=NezJny+jRAocbRC5hGQLdC0ZII4SVFgXyWK9+Xi4qj8ouHZpAulzUmjBgR91W5DRiv
         n6PDedvgnAJIPFHZctzlngb5uyiLMaRz7oRwc2T0rFacAPYPfEGjNHjEK1P+8ts8Iaq2
         XAhS8FkUCxcC5UgVv1GxefDj0Rc/ib9AOCCBfITjYP8B0Mt1dy7758Wg2jGAesLhkkQH
         Ljd3ViZdvRzKb6fnJBjbeybUV+mE2xdlafjupehjlUJDybO/EJYpIyNrzL3/Ecx4Zmrj
         jeq5zDgAvW2gC240QL86IXqJYZ049/Tz/e1hi64ogRXubCRAYLzEe+Vr5iwa3ABwjdmb
         9q2g==
X-Gm-Message-State: AOJu0YxKNtgt3A/mm9q5xAqWW+ARgT5bZY394whwtmWeObK8XWzrw7xx
	DCCZkikB1d1IPVZkNAepLIAY+aRpPRfY6j+Pm4s9JbvdLYBRVy+ixubQazrEaH2h0ODbMmTLRir
	KhU/ins4J1oSZ
X-Received: by 2002:aa7:da44:0:b0:533:6ef4:9f5b with SMTP id w4-20020aa7da44000000b005336ef49f5bmr1937859eds.6.1695925292244;
        Thu, 28 Sep 2023 11:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi0b2IwoJImDYTWWoWgBL6bFFl5v4abaoc5p+0nJnB9ExBGii9Zlo7ETHCQkSRzsOZEEU2Aw==
X-Received: by 2002:aa7:da44:0:b0:533:6ef4:9f5b with SMTP id w4-20020aa7da44000000b005336ef49f5bmr1937845eds.6.1695925291820;
        Thu, 28 Sep 2023 11:21:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7cccf000000b0053691cacd95sm139441edt.87.2023.09.28.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 11:21:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 08D0EE263F8; Thu, 28 Sep 2023 20:21:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Christian Brauner <brauner@kernel.org>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, "Eric W. Biederman"
 <ebiederm@xmission.com>, David Ahern <dsahern@kernel.org>
Subject: Re: Persisting mounts between 'ip netns' invocations
In-Reply-To: <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
 <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Sep 2023 20:21:28 +0200
Message-ID: <87il7ucg5z.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Sep 28, 2023 at 11:54:23AM +0200, Nicolas Dichtel wrote:
>> + Eric
>>=20
>> Le 28/09/2023 =C3=A0 10:29, Toke H=C3=B8iland-J=C3=B8rgensen a =C3=A9cri=
t=C2=A0:
>> > Hi everyone
>> >=20
>> > I recently ran into this problem again, and so I figured I'd ask if
>> > anyone has any good idea how to solve it:
>> >=20
>> > When running a command through 'ip netns exec', iproute2 will
>> > "helpfully" create a new mount namespace and remount /sys inside it,
>> > AFAICT to make sure /sys/class/net/* refers to the right devices inside
>> > the namespace. This makes sense, but unfortunately it has the side
>> > effect that no mount commands executed inside the ns persist. In
>> > particular, this makes it difficult to work with bpffs; even when
>> > mounting a bpffs inside the ns, it will disappear along with the
>> > namespace as soon as the process exits.
>> >=20
>> > To illustrate:
>> >=20
>> > # ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
>> > # ip netns exec <nsname> ls /sys/fs/bpf
>> > <nothing>
>> >=20
>> > This happens because namespaces are cleaned up as soon as they have no
>> > processes, unless they are persisted by some other means. For the
>> > network namespace itself, iproute2 will bind mount /proc/self/ns/net to
>> > /var/run/netns/<nsname> (in the root mount namespace) to persist the
>> > namespace. I tried implementing something similar for the mount
>> > namespace, but that doesn't work; I can't manually bind mount the 'mnt'
>> > ns reference either:
>> >=20
>> > # mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
>> > mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superbloc=
k on /proc/104444/ns/mnt, missing codepage or helper program, or other erro=
r.
>> >        dmesg(1) may have more information after failed mount system ca=
ll.
>> >=20
>> > When running strace on that mount command, it seems the move_mount()
>> > syscall returns EINVAL, which, AFAICT, is because the mount namespace
>> > file references itself as its namespace, which means it can't be
>> > bind-mounted into the containing mount namespace.
>> >=20
>> > So, my question is, how to overcome this limitation? I know it's
>> > possible to get a reference to the namespace of a running process, but
>> > there is no guarantee there is any processes running inside the
>> > namespace (hence the persisting bind mount for the netns). So is there
>> > some other way to persist the mount namespace reference, so we can pick
>> > it back up on the next 'ip netns' invocation?
>> >=20
>> > Hoping someone has a good idea :)
>> We ran into similar problems. The only solution we found was to use nsen=
ter
>> instead of 'ip netns exec'.
>>=20
>> To be able to bind mount a mount namespace on a file, the directory of t=
his file
>> should be private. For example:
>>=20
>> mkdir -p /run/foo
>> mount --make-rshared /
>> mount --bind /run/foo /run/foo
>> mount --make-private /run/foo
>> touch /run/foo/ns
>> unshare --mount --propagation=3Dslave -- sh -c 'yes $$ 2>/dev/null' | {
>>         read -r pid &&
>>         mount --bind /proc/$pid/ns/mnt /run/foo/ns
>> }
>> nsenter --mount=3D/run/foo/ns ls /
>>=20
>> But this doesn't work under 'ip netns exec'.
>
> Afaiu, each ip netns exec invocation allocates a new mount namespace.
> If you run multiple concurrent ip netns exec command and leave them
> around then they all get a separate mount namespace. Not sure what the
> design behind that was. So even if you could persist the mount namespace
> of one there's still no way for ip netns exec to pick that up iiuc.
>
> So imho, the solution is to change ip netns exec to persist a mount
> namespace and netns namespace pair. unshare does this easily via:
>
> sudo mkdir /run/mntns
> sudo mount --bind /run/mntns /run/mntns
> sudo mount --make-slave /run/mntns
>
> sudo mkdir /run/netns
>
> sudo touch /run/mntns/mnt1
> sudo touch /run/netns/net1
>
> sudo unshare --mount=3D/run/mntns/mnt1 --net=3D/run/netns/net1 true
>
> So I'd probably patch iproute2.

Patching iproute2 is what I'm trying to do - sorry if that wasn't clear :)

However, I couldn't get it to work. I think it's probably because I was
missing the bind-to-self/--make-slave dance on the containing folder, as
Nicolas pointed out. Will play around with that a bit more, thanks for
the pointers both of you!

-Toke


