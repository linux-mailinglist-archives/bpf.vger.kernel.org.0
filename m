Return-Path: <bpf+bounces-14529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CF7E60DB
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0CBB20DED
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8437155;
	Wed,  8 Nov 2023 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAt2XJNR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DD18E07
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:11:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510752127
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699485063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zBhCsl+J9XuFKJwNU+AckeR5uKVYWw4Qceb+g+hq/k=;
	b=XAt2XJNRdMwe7LAqGRHCQz4cjef1tRX8q8GhI7z0o7hdmlo0qeIrjVP4kNflnr37KHO8DY
	2NdGpv0rm4sbSQjtL9Mk/noHXWU3D/sZKWcIRvKyjJLg3B0jodLgPyb76059DMJK1fcyuh
	aOzO3S8lScf2R2sifgzrRo/tuqBh9to=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-yfl8_aarOOm4Zyc3JGTQhg-1; Wed, 08 Nov 2023 18:11:02 -0500
X-MC-Unique: yfl8_aarOOm4Zyc3JGTQhg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e1fb0308d6so17475266b.1
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699485060; x=1700089860;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7zBhCsl+J9XuFKJwNU+AckeR5uKVYWw4Qceb+g+hq/k=;
        b=GCFjxOUdIMVHuusDcmxnICR74Z6g5slotEXkh5TA1VKdzW4mxegOUfwGPqtGKhUS1a
         p/9wo8w3QuozVCyA8NBJJvsVqBD3HL9ZTerzSN4dGi6KbWSsR61jsZZO1z9hwAVyu4ZJ
         XUolFhc8RIOcgeXKuxMWOTTE8yQKUkw9wOhzlSgDvtjbfFCYKzyOeGmlvdpFCb0mpPZ7
         wFOmrfIE2IbK22a7yo9Hiqxp3tTH7FJuZBd8TccV21GZRJ6AZMZS0MVBNNemcgo4wYMh
         bptps5uc1VkdQlNwxyZ4c9MJsNVHB9px+pdBef0cgvnETtu1EbXm3k9BJN/vJ8e5cgos
         0S2g==
X-Gm-Message-State: AOJu0YxAs5CyBvIZ3k3R1IRiuVYi5yJCbk5S6epzYM1685G6xLT++y+i
	cKSSZpO9iB4aJJg9gyb4e/Gicbag3LpmFE5cpj5WmE+u+DLRmFmZxiOcGLNGm77iXfto2OOyUxV
	tW/v+ESdmpqWqo3lZpt4h
X-Received: by 2002:a17:907:3f17:b0:9b3:308:d045 with SMTP id hq23-20020a1709073f1700b009b30308d045mr3130120ejc.46.1699485060542;
        Wed, 08 Nov 2023 15:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgT5SEAwLzC5r/BVkOQGnVjCHOESssbnCbCYt42mXA7+rcpol8Z1ymofhy8h2p7zzk10z75A==
X-Received: by 2002:a17:907:3f17:b0:9b3:308:d045 with SMTP id hq23-20020a1709073f1700b009b30308d045mr3130105ejc.46.1699485060207;
        Wed, 08 Nov 2023 15:11:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709067e1600b009ddaa2183d4sm1681156ejr.42.2023.11.08.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:10:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8E1EBEE6EBE; Thu,  9 Nov 2023 00:10:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: Re: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
In-Reply-To: <fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
References: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
 <87h6lxy3zq.fsf@toke.dk> <fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 09 Nov 2023 00:10:59 +0100
Message-ID: <871qczx2m4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Nelson, Shannon" <shannon.nelson@amd.com> writes:

> On 11/7/2023 7:31 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> "Nelson, Shannon" <shannon.nelson@amd.com> writes:
>>=20
>>> While testing new code to support XDP in the ionic driver we found that
>>> we could panic the kernel by running a bind/unbind loop on the target
>>> interface of an xdp_redirect action.  Obviously this is a stress test
>>> that is abusing the system, but it does point to a window of opportunity
>>> in bq_enqueue() and bq_xmit_all().  I believe that while the validity of
>>> the target interface has been checked in __xdp_enqueue(), the interface
>>> can be unbound by the time either bq_enqueue() or bq_xmit_all() tries to
>>> use the interface.  There is no locking or reference taken on the
>>> interface to hold it in place before the target=E2=80=99s ndo_xdp_xmit(=
) is called.
>>>
>>> Below is a stack trace that our tester captured while running our test
>>> code on a RHEL 9.2 kernel =E2=80=93 yes, I know, unpublished driver cod=
e on a
>>> non-upstream kernel.  But if you look at the current upstream code in
>>> kernel/bpf/devmap.c I think you can see what we ran into.
>>>
>>> Other than telling users to not abuse the system with a bind/unbind
>>> loop, is there something we can do to limit the potential pain here?
>>> Without knowing what interfaces might be targeted by the users=E2=80=99=
 XDP
>>> programs, is there a step the originating driver can do to take
>>> precautions?  Did we simply miss a step in the driver, or is this an
>>> actual problem in the devmap code?
>>=20
>> Sounds like a driver bug :)
>
> Entirely possible, wouldn't be our first ... :-)
>
>>=20
>> The XDP redirect flow guarantees that all outstanding packets are
>> flushed within a single NAPI cycle, as documented here:
>> https://docs.kernel.org/bpf/redirect.html
>>=20
>> So basically, the driver should be doing a two-step teardown: remove
>> global visibility of the resource in question, wait for all concurrent
>> users to finish, and *then* free the data structure. This corresponds to
>> the usual RCU protection: resources should be kept alive until all
>> concurrent RCU critical sections have exited on all CPUs. So if your
>> driver is removing an interface's data structure without waiting for
>> concurrent NAPI cycles to finish, that's a bug in the driver.
>>=20
>> This kind of thing is what the synchronize_net() function is for; for a
>> usage example, see veth_napi_del_range(). My guess would be that you're
>> missing this as part of your driver teardown flow?
>
> Essentially, the first thing we do in the remove function is to call=20
> unregister_netdev(), which has synchronize_net() in the path, so I don't=
=20
> think this is missing from our scenario, but thanks for the hint, I'll=20
> keep this in mind.  I do see there are a couple of net drivers that are=20
> more aggressive about calling it directly in some other parts of the=20
> logic - I don't think that has a bearing on this issue, but I'll keep it=
=20
> in mind.

Hmm, right, in fact unregister_netdev() has two such synchronize_net()
calls. The XDP queue is only guaranteed to be flushed after the second
one of those, though, and there's an 'ndo_uninit()' callback in-between
them. So I don't suppose your driver implements that ndo and does
something there that could cause the crash you're seeing?

Otherwise, the one thing I can think of is that maybe it can be related
to the fact that synchronize_net() turns into a
synchronize_rcu_expedited() if the rtnl lock is held (which it is in
this case if you're calling the parameter-less unregister_netdev()). I'm
not quite sure I grok the expedited wait thing, but it should be pretty
easy to check if this is the cause by making a change like the one below
and seeing if the issue goes away.

-Toke

diff --git a/net/core/dev.c b/net/core/dev.c
index e28a18e7069b..1a035a5f0b0e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10932,7 +10932,7 @@ void synchronize_net(void)
 {
        might_sleep();
        if (rtnl_is_locked())
-               synchronize_rcu_expedited();
+               synchronize_rcu();
        else
                synchronize_rcu();
 }


