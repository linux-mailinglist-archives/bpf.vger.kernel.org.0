Return-Path: <bpf+bounces-70238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E1BB5110
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 22:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAF9F4E4816
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2E287245;
	Thu,  2 Oct 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ojrX/WZJ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F329CE1;
	Thu,  2 Oct 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435295; cv=none; b=b0b/97V2gAF8zLO+YUMEgCqKvHLVKlUILTYEWGN6BNqIzgUwlw1ySov3hHbAnTWXrUPYE4U3IFW3BnsWQLloAuqGNIrq8K3NH+zYHd5/4y/5PjBBfKQ7wD/8SeUFZ5GVtD5tyn/x2MvI2lCIBVvjT41cfUOnj8kwRg9TvvP259k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435295; c=relaxed/simple;
	bh=j5/wsnm0ZL2eU5rOJpuLber2On3pdd7fhYcfRp/o0NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jLgEO1YLjFGlJ4moaxGBSW125kKVHsaicJpL+L6rXiqcTcdOWcPrIPwid6E8g4ueGCxwOhPd1EiDyyhkbillkvcYnKk3BR3hvDzO76lRzPfQkvMdPakZ1/GwkdpVIx8mBwcxLQlZpn7cllFBIGlsuO4Z32nyz66ApM95lH+Uu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ojrX/WZJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35EA4211B7BD;
	Thu,  2 Oct 2025 13:01:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35EA4211B7BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759435293;
	bh=Udmkclfo3YBk1sYNXKqJn8vhYwLfj3OgpLdf2bcPKes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ojrX/WZJtpEHhk0p9KnCT9mG1jZ5Qes+FSNM+IyP6gDehtpJO6algIlUHoXKGuSm+
	 j18xq1ml8z9Mj9LwW+bRpkbpNEweZ0OJnxTyFc1D98xKIVud60vUBhynQWFuSsWw6n
	 3VDM2uRj69PXKchgwKJnVSc5oIFIFQ4G1LBrFhPM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org,
 james.bottomley@hansenpartnership.com, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, kys@microsoft.com,
 daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com,
 qmo@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
In-Reply-To: <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
Date: Thu, 02 Oct 2025 13:01:30 -0700
Message-ID: <871pnlysx1.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>>
>
> [...]
>

[...]

I am confident that Paul will address your remaining points. However, I
would like to clarify a few factual inaccuracies outlined below.

>
> Blaise's implementation fails on any modern BPF programs since
> programs use more than one map, BTF information and kernel functions.
>

If you read the patch series you'd see that it supports verification of
any number of maps. If you've identified an issue with map verification,
please share the details and I=E2=80=99ll address it.


[...]

>> conventions around the placement of LSM hooks, this "halfway" approach
>> makes it difficult for LSMs to log anything about the signature status
>> of a BPF program being loaded, or use the signature status in any type
>> of access decision.  This is important for a number of user groups
>> that use LSM based security policies as a way to help reason about the
>> security properties of a system, as KP's scheme would require the
>> users to analyze the signature verification code in every BPF light
>> skeleton they authorize as well as the LSM policy in order to reason
>> about the security mechanisms involved in BPF program loading.
>>
>> Blaise's signature scheme also has the nice property that BPF ELF
>> objects created using his scheme are backwards compatible with
>> existing released kernels that do not support any BPF signature
>> verification schemes, of course without any signature verification.
>> Loading a BPF ELF object using KP's signature scheme will likely fail
>> when loaded on existing released kernels.
>
> This does not make any sense. The ELF format and the way loaders like
> libbpf interpret it, has nothing to do with the kernel or UAPI.
>

We signed a program with your upstream tools and it failed to load on a
vanilla kernel 6.16. The loader in your patchset is intepreting the
first few fields of struct bpf_map as a byte array containing a sha256
digest on older kernels.

-blaise


> I had given detailed feedback to Blaise in
> https://lore.kernel.org/bpf/CACYkzJ6yNjFOTzC04uOuCmFn=3D+51_ie2tB9_x-u2xb=
cO=3DyobTw@mail.gmail.com/
> mentions also why we don't want any additional UAPI.
>
> You keep mentioning having visibility  in the LSM code and I again
> ask, to implement what specific security policy and there is no clear
> answer? On a system where you would like to only allow signed BPF
> programs, you can purely deny any programs where the signature is not
> provided and this can be implemented today.
>
> Stable programs work as it is, programs that require runtime
> relocation work with loader programs. We don't want to add more UAPI
> as, in the future, it's quite possible that we can make the
> instruction buffer stable.
>
> - KP
>
>>
>> [1] https://lore.kernel.org/linux-security-module/CAADnVQ+C2KNR1ryRtBGOZ=
TNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com/
>> [2] https://lore.kernel.org/linux-security-module/CAHC9VhRjKV4AbSgqb4J_-=
xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com/
>> [3] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microso=
ft.com/
>> [4] https://lore.kernel.org/linux-security-module/20250909162345.569889-=
2-bboscaccy@linux.microsoft.com/
>> [5] https://lore.kernel.org/linux-security-module/20250926203111.1305999=
-1-bboscaccy@linux.microsoft.com/
>> [6] https://lore.kernel.org/linux-security-module/20250929213520.1821223=
-1-bboscaccy@linux.microsoft.com/
>>
>> --
>> paul-moore.com

