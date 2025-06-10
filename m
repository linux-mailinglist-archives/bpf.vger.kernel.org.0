Return-Path: <bpf+bounces-60219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A1AD41CF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6213A3D35
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0146024679C;
	Tue, 10 Jun 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cQbpKaOa"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C7236429;
	Tue, 10 Jun 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579363; cv=none; b=Yy8yPT1WvSXnMx4jPyb42j8Jkt2UEQAnZGdSRlPfkUeZ7OxrzfDaKCLtqRdRe/wm9x9bCNbI5ejlGh9hmzDumH7F/LzDYo7WTTRLOocXMyhwppV7pFVxEpzr1w8ZiZqaP6OR5XKF1RJap2AbjfrW3pTSuDTyAGJnVAxco06VG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579363; c=relaxed/simple;
	bh=9fp7W+ilQi7LKO2vKSvuyyMXb9voxhG2ZetMSlcsxxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBBbOaJGkciHBh5h7iGFnKHFwgooeZpuN4xpWL+IX72pYOOC1M2UUQd/jWxOE9Q6y/hczZL4S5xXIXQzXFu+ix7sTxX+d4EymCc3DULNJOZA1tRKKSWyY3mp69f2ZJzwzpjom7/5APnn8WG4NiWbOiR2Ot8EHE0qPsF/2vWWHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cQbpKaOa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id DE971211759D;
	Tue, 10 Jun 2025 11:16:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE971211759D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749579361;
	bh=SFCxouW8bosm/IUtRADZwmLxWA1XsxpThmTh5x0wqlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cQbpKaOaHskP9do1I7m1ETHBen/GX0z+szCeBwT3k6x5r+r9rfSVWHnCxbkIdNWOc
	 JqX0Eoy+BP3p7qvWZFsugTNAvxoUtLRr4xMKhfaVMY5HBi+0cDsiHKwABGAKRNTzrF
	 3pcrfq0eUXOz7YMLtsPkAMpFXX4RvS0L8Db+WPJo=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the
 loader
In-Reply-To: <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com>
 <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
Date: Tue, 10 Jun 2025 11:15:59 -0700
Message-ID: <87o6uvlaxs.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

[...]

>>
>> The above code gets generated per-program and exists out-of-tree in a
>> very unreadable format in it's final form. I have general objections to
>> being forced to "trust" out-of-tree code, when it's demostrably trivial
>
> This is not out of tree. It's very much within the kernel tree.

No, it's not.

Running something like

bpftool gen skeleton -S -k <private_key> -i <identity_cert>
fentry_test.bpf.o

will yield a header file fentery_test.h or whatever. That header file
contains a customized and one-off version of the templated code in this
patch. That header file and the resultant loader it gets compiled into
exists out-of-tree.

>
>> to perform this check in-kernel, without impeding any of the other
>> stated use cases. There is no possible audit log nor LSM hook for these
>> operations. There is no way to know that this check was ever performed.
>>
>> Further, this check ends up happeing in an entirely different syscall,
>> the LSM layer and the end user may both see invalid programs successfully
>> being loaded into the kernel, that may fail mysteriously later.
>>
>> Also, this patch seems to rely on hacking into struct internals and
>> magic binary layouts.
>
> These magical binary layouts are BPF programs, as I mentioned, if you
> don't like this you (i.e an advanced user like Microsoft) can
> implement your own trusted loader in whatever format you like. We are
> not forcing you.
>
> If you really want to do it in the kernel, you can do it out of tree
> and maintain these patches (that's what "out of tree" actually means),
> this is not a direction the BPF maintainers are interested in as it
> does not meet the broader community's use-cases. We don=E2=80=99t want an
> unnecessary extension to the UAPI when some BPF programs do have
> stable instructions already (e.g. network) and some that can
> potentially have someday.
>

Yes, you are forcing us. Saying we are only allowed to use "trusted"
loaders, and that no one is allowed to have any in-kernel, in-tree code
that inspects user inputs or target programs directly is very
non-consentual on my end. This is a design mandate, being forced upon
other people, by you, with no concrete reasons, other than vague statements
around UAPI design, need or necessity.

-blaise

> RE The struct internals will be replaced by calling BPF_OBJ_GET_INFO
> directly from the loader program as I mentioned in the commit.=E2=80=9D
>
>
> - KP
>
>
>>
>> -blaise
>>
>> >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *a=
ttach_name,
>> >                                  enum bpf_attach_type type)
>> >  {
>> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> > index b6ee9870523a..084372fa54f4 100644
>> > --- a/tools/lib/bpf/libbpf.h
>> > +++ b/tools/lib/bpf/libbpf.h
>> > @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
>> >       const char *insns;
>> >       __u32 data_sz;
>> >       __u32 insns_sz;
>> > +     bool gen_hash;
>> >  };
>> >
>> > -#define gen_loader_opts__last_field insns_sz
>> > +#define gen_loader_opts__last_field gen_hash
>> >  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
>> >                                     struct gen_loader_opts *opts);
>> >
>> > --
>> > 2.43.0

