Return-Path: <bpf+bounces-11018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED307B1600
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0308A2822C4
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910533991;
	Thu, 28 Sep 2023 08:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D2847B
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 08:29:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81413A
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695889766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=C2a6LqA41kHTYejtD6Zn0gAUZKMovtpeoJa3mXbkQMs=;
	b=IxGZb+C85uau7rrcTBRtYIOOEzpu5Dfe6Kr8FFHdYQrEFXkY2SyIZxO4s6PeMVLgFIEF8u
	1ObSAN3AnXoT3LUoA1qv102vEFSsJD4NcqMBhV86UNfUVuUnbmfGBf7LDDBHU1c27eLyF/
	2oCZlsDOGX9jG7CF743DaaqZwUjix0w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-T0FOaGmaNzeNeAwzM_VWTg-1; Thu, 28 Sep 2023 04:29:23 -0400
X-MC-Unique: T0FOaGmaNzeNeAwzM_VWTg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-533d8a785a5so7794643a12.3
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889762; x=1696494562;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2a6LqA41kHTYejtD6Zn0gAUZKMovtpeoJa3mXbkQMs=;
        b=L7X0vUv1BFuJaAdGeseTWvl6Uu5r3tiAM2XNX55n3mu53Eg+hdiTvqbXtZLw8jPJdv
         TqA1BrW7y1W/fsgH2KK3iteTEGcZBrDz4GvoYP3SMDUqOmtK2ciRAwlQpG3QDoaBAiD8
         THZ8l+FULXGht54mcNi6cVEGyvhdZSv/ErP42vUrzMdegFQ5pNqbpvlJqUIaj2kd8L4d
         k9P3eG6jSHJeRmtLeYH3l4Yrb0JOpZqYzl1Lp973Ajtb9BnN1hwgV3wtR/w+Zxo0NgfZ
         caKESmAdTszd0SieRaXlX03xe+JTFA2W3xRKVBDp1H8arPAZtmtYdwdNLAs3hdQhhRy4
         vrhA==
X-Gm-Message-State: AOJu0YwPgbV8q3QsAjcYqEUTwKWLDCmMRB6Vx9VH7ShTjI64fDfxvXT8
	UqO4Zn+bT5NJwUk9AmwV8e4R3wHnfhS4s2Tr+seU5yxNdcAgE7zBLg0h/S0PFlgBGnn0BAsh/S9
	7gy632o6+4iDV
X-Received: by 2002:aa7:cd74:0:b0:530:df47:f172 with SMTP id ca20-20020aa7cd74000000b00530df47f172mr560774edb.15.1695889762732;
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKLk8j/n8RrrFIlitg8C8yJoSVGCOYrRpk3kk1bte0swFS7RYyRzSEIwVZphn7atMruYMHzA==
X-Received: by 2002:aa7:cd74:0:b0:530:df47:f172 with SMTP id ca20-20020aa7cd74000000b00530df47f172mr560762edb.15.1695889762404;
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ds11-20020a0564021ccb00b00536368246afsm71580edb.50.2023.09.28.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 30896E262BB; Thu, 28 Sep 2023 10:29:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Persisting mounts between 'ip netns' invocations
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Sep 2023 10:29:07 +0200
Message-ID: <87a5t68zvw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi everyone

I recently ran into this problem again, and so I figured I'd ask if
anyone has any good idea how to solve it:

When running a command through 'ip netns exec', iproute2 will
"helpfully" create a new mount namespace and remount /sys inside it,
AFAICT to make sure /sys/class/net/* refers to the right devices inside
the namespace. This makes sense, but unfortunately it has the side
effect that no mount commands executed inside the ns persist. In
particular, this makes it difficult to work with bpffs; even when
mounting a bpffs inside the ns, it will disappear along with the
namespace as soon as the process exits.

To illustrate:

# ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
# ip netns exec <nsname> ls /sys/fs/bpf
<nothing>

This happens because namespaces are cleaned up as soon as they have no
processes, unless they are persisted by some other means. For the
network namespace itself, iproute2 will bind mount /proc/self/ns/net to
/var/run/netns/<nsname> (in the root mount namespace) to persist the
namespace. I tried implementing something similar for the mount
namespace, but that doesn't work; I can't manually bind mount the 'mnt'
ns reference either:

# mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

When running strace on that mount command, it seems the move_mount()
syscall returns EINVAL, which, AFAICT, is because the mount namespace
file references itself as its namespace, which means it can't be
bind-mounted into the containing mount namespace.

So, my question is, how to overcome this limitation? I know it's
possible to get a reference to the namespace of a running process, but
there is no guarantee there is any processes running inside the
namespace (hence the persisting bind mount for the netns). So is there
some other way to persist the mount namespace reference, so we can pick
it back up on the next 'ip netns' invocation?

Hoping someone has a good idea :)

-Toke


