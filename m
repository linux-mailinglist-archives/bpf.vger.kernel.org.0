Return-Path: <bpf+bounces-60202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819CAD3F10
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642FC3A5468
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBC1E8338;
	Tue, 10 Jun 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FuSvHggU"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB22241131;
	Tue, 10 Jun 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573291; cv=none; b=O5lOugp0qW7l/ckmmg5GhkBR6n7Yb5eEeVyzU7pARy2OJbDouMgxPe3l0J1CXDpNj9nocOwrE2hePWIWeeRfsNwFlef7S+8y8yAHktF/iMWiSeTjCF3NSG2BDmFCFjNuT3cJlZYjQOUDrawZq+htLQHf45mw7NLpK4jf03f5I68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573291; c=relaxed/simple;
	bh=MbD/u28BR8ERLB/j8X2W/jdes+afjbjp7ZuEE/CdZZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TgUYS+IE9GRWF+KBjxGYx6JYl3n6GJrWVWqlzndp9cYQsm2xkaeqn6BojtMGzHrqWFV55EVLJ1crUraNqaTQoegN9RZ3FrzyFmi2pQStVwem7ny7oKIR5smv9tM4Ds0ZU1jEjw41HQI/wIhD4fev4c41+zmzOpjCq2b91XtcA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FuSvHggU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09B9F211759C;
	Tue, 10 Jun 2025 09:34:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09B9F211759C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749573288;
	bh=wvIiAiIzAXXqVw6oYEs0WaX0Ysoflu42+b7kSlPUEsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FuSvHggU/4ILCtF7737bncbcEaZNkN86T9SOifu1CpgEMIUQYyfEQ4ml3OV8cVEdz
	 TV5ePTD+k9/IEvpacXc5AHMyks17M33K0AxJlBNUl8l6nYmsuYlVmik0y4j3om4liy
	 uwQOWM9QTf4f9RQ1s1lvp/3EtT5GUbcnn7at591w=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 11/12] bpftool: Add support for signing BPF programs
In-Reply-To: <CACYkzJ7Mh=VV0FDsfWZbWBcdC6qLdVp4RDbnoMM_Fb4LW7t4=Q@mail.gmail.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-12-kpsingh@kernel.org>
 <b2a0c3d722c78de38ffa2664f71654a422d77121.camel@HansenPartnership.com>
 <CACYkzJ7Mh=VV0FDsfWZbWBcdC6qLdVp4RDbnoMM_Fb4LW7t4=Q@mail.gmail.com>
Date: Tue, 10 Jun 2025 09:34:46 -0700
Message-ID: <87zfeflfmh.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Sun, Jun 8, 2025 at 4:03=E2=80=AFPM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> [+keyrings]
>> On Sat, 2025-06-07 at 01:29 +0200, KP Singh wrote:
>> [...]
>> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> > index f010295350be..e1dbbca91e34 100644
>> > --- a/tools/bpf/bpftool/prog.c
>> > +++ b/tools/bpf/bpftool/prog.c
>> > @@ -23,6 +23,7 @@
>> >  #include <linux/err.h>
>> >  #include <linux/perf_event.h>
>> >  #include <linux/sizes.h>
>> > +#include <linux/keyctl.h>
>> >
>> >  #include <bpf/bpf.h>
>> >  #include <bpf/btf.h>
>> > @@ -1875,6 +1876,8 @@ static int try_loader(struct gen_loader_opts
>> > *gen)
>> >  {
>> >       struct bpf_load_and_run_opts opts =3D {};
>> >       struct bpf_loader_ctx *ctx;
>> > +     char sig_buf[MAX_SIG_SIZE];
>> > +     __u8 prog_sha[SHA256_DIGEST_LENGTH];
>> >       int ctx_sz =3D sizeof(*ctx) + 64 * max(sizeof(struct
>> > bpf_map_desc),
>> >                                            sizeof(struct
>> > bpf_prog_desc));
>> >       int log_buf_sz =3D (1u << 24) - 1;
>> > @@ -1898,6 +1901,24 @@ static int try_loader(struct gen_loader_opts
>> > *gen)
>> >       opts.insns =3D gen->insns;
>> >       opts.insns_sz =3D gen->insns_sz;
>> >       fds_before =3D count_open_fds();
>> > +
>> > +     if (sign_progs) {
>> > +             opts.excl_prog_hash =3D prog_sha;
>> > +             opts.excl_prog_hash_sz =3D sizeof(prog_sha);
>> > +             opts.signature =3D sig_buf;
>> > +             opts.signature_sz =3D MAX_SIG_SIZE;
>> > +             opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
>> > +
>>
>> This looks wrong on a couple of levels.  Firstly, if you want system
>> level integrity you can't search the session keyring because any
>> process can join (subject to keyring permissions) and the owner, who is
>> presumably the one inserting the bpf program, can add any key they
>> like.
>>
>
> Wanting system level integrity is a security policy question, so this
> is something that needs to be implemented at the security layer, the
> LSM can deny the keys / keyring IDs they don't trust.  Session
> keyrings are for sure useful for delegated signing of BPF programs
> when dynamically generated.
>
>> The other problem with this scheme is that the keyring_id itself has no
>> checked integrity, which means that even if a script was marked as
>
> If an attacker can modify a binary that has permissions to load BPF
> programs and update the keyring ID then we have other issues. So, this
> does not work in independence, signed BPF programs do not really make
> sense without trusted execution).
>

Untrusted userspace/root is precisely the issue I solved with previous
patchsets for this effort. Signed BPF programs absolutely work without
trusted execution.

-blaise

>> system keyring only anyone can binary edit the user space program to
>> change it to their preferred keyring and it will still work.  If you
>> want variable keyrings, they should surely be part of the validated
>> policy.
>
> The policy is what I expect to be implemented in the LSM layer. A
> variable keyring ID is a critical part of the UAPI to create different
> "rings of trust" e.g. LSM can enforce that network programs can be
> loaded with a derived key, and have a different keyring for
> unprivileged BPF programs.
>
> This patch implements the signing support, not the security policy for it.
>
> - KP
>
>>
>> Regards,
>>
>> James
>>

