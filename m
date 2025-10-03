Return-Path: <bpf+bounces-70322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44937BB7D98
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E1347C0E
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F22DC774;
	Fri,  3 Oct 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jU2jVPkk"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B42D46A1;
	Fri,  3 Oct 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515260; cv=none; b=tjUH4N7mOpGIzmCzbrW7pW1ScqykYY8GA3tGk4iLVl3K6/WVD0Jg9yAUMNYeJzGVHKioeWM2paXcTQRhXU14FH7MKjkt/fp9XKRov8nCkUyeDCfUYqZM9FI/izsiYN/bPoE76ErO19PMCiqXjb69zWuqhYPK6cAyqHQEHIrVYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515260; c=relaxed/simple;
	bh=yUrgQcSQzrZ5Ta9Vf3S5xvsgcx6/DiVNWzNo/n0L8KM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdIH9BMjVOBP/jtUJgpBPo82XAAEhzhgv5joPue6dz6MgwCuaVwHdKCV0uRS4VW+Nx9QURjkYhnGJyr5gWXXmilzWbefUCPp+z1AbQCqoZVva5M5DsEqLOUbnolWWLc8XA9/0ukKM3DfYUA+aR6I2h8+DLQDk3pNWjI38JlSe1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jU2jVPkk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id E4B3A2119CC3;
	Fri,  3 Oct 2025 11:14:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4B3A2119CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759515257;
	bh=Qctu12DZ/u25F+IcVR/hU6aQU6NIYzIeD1je2vjJPI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jU2jVPkkFknlQuUQHDxjxlB8aIROnUHxQpFbnskDwWqvY2sPN9TrNeEQd3Xx0e8zz
	 GH2Cb+9SPS68TyQ454JTfvu7cb9iaGID0mjLP6/Es6NyhNPgbzO7xMSKLn6VFwMqi0
	 wdtuQe3gXuQCbQpz8k3CK9R2SyNOJFY1TWp95bLo=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, ast@kernel.org,
 james.bottomley@hansenpartnership.com, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, kys@microsoft.com,
 daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com,
 qmo@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
In-Reply-To: <CACYkzJ7F6ax2AcWNFxnAkyVb26Dr2mwdBnW=HFVFeJ1pC-BObg@mail.gmail.com>
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <871pnlysx1.fsf@microsoft.com>
 <CACYkzJ7F6ax2AcWNFxnAkyVb26Dr2mwdBnW=HFVFeJ1pC-BObg@mail.gmail.com>
Date: Fri, 03 Oct 2025 11:14:15 -0700
Message-ID: <87y0pryhs8.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Thu, Oct 2, 2025 at 10:01=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> KP Singh <kpsingh@kernel.org> writes:
>>
>> > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
>> >>
>> >
>> > [...]
>> >
>>
>> [...]
>>
>> I am confident that Paul will address your remaining points. However, I
>> would like to clarify a few factual inaccuracies outlined below.
>>
>> >
>> > Blaise's implementation fails on any modern BPF programs since
>> > programs use more than one map, BTF information and kernel functions.
>> >
>>
>> If you read the patch series you'd see that it supports verification of
>> any number of maps. If you've identified an issue with map verification,
>> please share the details and I=E2=80=99ll address it.
>>
>
> I am sorry but this does not work, the UAPI here is
>
> + /* Pointer to a buffer containing the maps used in the signature
> + * hash chain of the BPF program.
> + */
> + __aligned_u64   signature_maps;
> + /* Size of the signature maps buffer. */
> + __u32 signature_maps_size;
>
> This needs to be generically applicable and it's not, What happens if
> the program is not a loader program / when the instruction buffer is
> stable?
>

The map array is fully configurable by the signer. Signing any or all
maps is optional. If the instruction buffer is stable, the signer can
generate the signature without maps and the caller passes zero in
those fields.

> If you really want the property that all of the content is signed and
> verified within the kernel,

That's what code signing is.=20

> please explore approaches to make the
> instruction buffer stable or feel free to deny any programs that do
> relocations at load time for whatever "strict" security policy that
> you want to implement.
>
> Please stop pursuing this extension as it adds cruft to the UAPI
> that's too specific, encodes the hash chain in the kernel and we won't
> need in the future.
>

If your primary complaint at this point is UAPI bloat, we'd be happy to
rework the configurable hash-chain patch to use the existing signature
buffer provided in your patchset.=20

>> [...]
>>
>> >> conventions around the placement of LSM hooks, this "halfway" approach
>> >> makes it difficult for LSMs to log anything about the signature status
>> >> of a BPF program being loaded, or use the signature status in any type
>> >> of access decision.  This is important for a number of user groups
>> >> that use LSM based security policies as a way to help reason about the
>> >> security properties of a system, as KP's scheme would require the
>> >> users to analyze the signature verification code in every BPF light
>> >> skeleton they authorize as well as the LSM policy in order to reason
>> >> about the security mechanisms involved in BPF program loading.
>> >>
>> >> Blaise's signature scheme also has the nice property that BPF ELF
>> >> objects created using his scheme are backwards compatible with
>> >> existing released kernels that do not support any BPF signature
>> >> verification schemes, of course without any signature verification.
>> >> Loading a BPF ELF object using KP's signature scheme will likely fail
>> >> when loaded on existing released kernels.
>> >
>> > This does not make any sense. The ELF format and the way loaders like
>> > libbpf interpret it, has nothing to do with the kernel or UAPI.
>> >
>>
>> We signed a program with your upstream tools and it failed to load on a
>> vanilla kernel 6.16. The loader in your patchset is intepreting the
>> first few fields of struct bpf_map as a byte array containing a sha256
>> digest on older kernels.
>
> We can convert BPF_OBJ_GET_INFO_BY_FD to be called from loader
> programs to not rely on the struct field. and or libbbf can call
> BPF_OBJ_GET_INFO_BY_FD to check if map_get_hash is supported before it
> generates the hash check.
>
> You should not expect bpftool -S -k -i to work on older kernels but it
> should error out if the options are passed.
>

`bpftool gen` shouldn't have a priori knowledge of the target kernel
version.=20

-blaise


> - KP
>
>>
>> -blaise
>>
>>
>> > I had given detailed feedback to Blaise in
>> > https://lore.kernel.org/bpf/CACYkzJ6yNjFOTzC04uOuCmFn=3D+51_ie2tB9_x-u=
2xbcO=3DyobTw@mail.gmail.com/
>> > mentions also why we don't want any additional UAPI.
>> >
>> > You keep mentioning having visibility  in the LSM code and I again
>> > ask, to implement what specific security policy and there is no clear
>> > answer? On a system where you would like to only allow signed BPF
>> > programs, you can purely deny any programs where the signature is not
>> > provided and this can be implemented today.
>> >
>> > Stable programs work as it is, programs that require runtime
>> > relocation work with loader programs. We don't want to add more UAPI
>> > as, in the future, it's quite possible that we can make the
>> > instruction buffer stable.
>> >
>> > - KP
>> >
>> >>
>> >> [1] https://lore.kernel.org/linux-security-module/CAADnVQ+C2KNR1ryRtB=
GOZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com/
>> >> [2] https://lore.kernel.org/linux-security-module/CAHC9VhRjKV4AbSgqb4=
J_-xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com/
>> >> [3] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@micr=
osoft.com/
>> >> [4] https://lore.kernel.org/linux-security-module/20250909162345.5698=
89-2-bboscaccy@linux.microsoft.com/
>> >> [5] https://lore.kernel.org/linux-security-module/20250926203111.1305=
999-1-bboscaccy@linux.microsoft.com/
>> >> [6] https://lore.kernel.org/linux-security-module/20250929213520.1821=
223-1-bboscaccy@linux.microsoft.com/
>> >>
>> >> --
>> >> paul-moore.com

