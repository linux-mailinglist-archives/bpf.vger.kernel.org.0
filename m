Return-Path: <bpf+bounces-79304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2DD336A0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEDD730987BB
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2BD339861;
	Fri, 16 Jan 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke2MAOqB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5F265CDD
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579953; cv=pass; b=kn1Dk3ZToGF/kDxa4IeoQd5ZW4YWRT7esu8v0UFSYmlNB0j7LwRAVDeForEy+1YG4SdFBDsc4b01t+P2gK9pnQKUak9TKbuxaQdaqDf/8vA/XY5XhCSAk4ugL/e1j9JNg0EGDZAyWEt0+K7IFpKXFmnMImG1ScweS3PNHB380qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579953; c=relaxed/simple;
	bh=YOXYJJ6qAebWhk/UtOfqF0dCndYck9WMi8FVfb6+cqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz9cI8zGHCUCpGYmo6M5OasGi30Rp92gXasjMEOS7hAK9h4sYCEBSB8C06WYf4tejS8pCQZPtTCcbXm4r+wL9JNplPJOmvKhlckJxjDJliiqNjD8N+6XFW+SMa9+V467XfPl0bnxEkDvO4k3So1uCWUVvIsC5U91xtS5WOJXePk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke2MAOqB; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1214908f8f.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768579951; cv=none;
        d=google.com; s=arc-20240605;
        b=EnBlGCOq+IIuTIcj8ydTiAUapBNST75EMYWqv+VzFb9Dhsorl5bSILtdG4iXruXmq6
         JvIMLCMIy6tOCEAKWnfPFZSYubiPRp8d2h1xFvo0lCIzsK1b9Bqjom9kx0N0IcVjH/gR
         ildYVPzkXCebqalHmb4vYhPDlFOXXOwJ69Y06fXGhf4aAtzdpEyxW5i7Z1wU/ytQWgbX
         V9dHCEMNHhHdXAPekiODxpNF/JdVdidVkjcN/ERlJpk/hvOUHqYik34X40FeK3D87NFI
         KhJPMfVRXpZZPyRqjWx7OOGBovKQTqP6wpKQXSPDBQQyXGzRQL14dysZZ8QVVwpdCN3P
         rlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gbv+mgZCGZLs4ziLC7+esXaCguwHnT3zQFaKXRoIwZ0=;
        fh=SNHh2Oz7RF+JlQYpLSkVdSjQJ5FnqPvKRuaAVMCuhLw=;
        b=I+o2ga6PZZybbSIZ+3GQWAu+svRGqAYlQ9KICUXp6urym6L7ZQ71NJfK89uKw53rr4
         9iRrA7ZbG2NZKXrokZBc+eG11kyeTMvCH29MZrp2MtwMoJDQ5uwuhXkCrZaPXinikipA
         umjnBckSCeZNKh/FAJLy+HpfiZYIqGQ+ej0QyTaBvm/8d1rf0QmUuKsY9VBpJMQmwuhJ
         d3h2HONY4C6MK154Du3KTAyrNtG93i0lrgHW6sUiAzvZy+tHXpU/M7YFohGVzt9FSnkU
         5Jc6pxeinaX57wjHOAYUlaMSLeARpY7q8e+upWZ6rVV2QMJ177Qz2jvXa60QbNibmhkv
         BPPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768579950; x=1769184750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbv+mgZCGZLs4ziLC7+esXaCguwHnT3zQFaKXRoIwZ0=;
        b=ke2MAOqBJtei6J2Ty1W5gG3ocp3eg8PBNbxMGA/qiQdZnRAmsc5yuFV5NJ+SOxWo/N
         JVL0So7yNmGR18B+M1wPRRXtupU6d9wQWwxzHg1TY25SjLAGvLWuGwGQo7BmAAsoyxvP
         qNr2uMRli8zmQ6h31KrYkNeOsZSNLiV8yC3Vs+2yFWOYzQ8A24m0PLmj3XSqTVMX2pEn
         TxIIEEm0D3bUFjl+eWOXEuwUrvEFo6kX7cICY18SQdan1bctJuYYvA4RU7CP9l3u7scb
         5QNzLYqa80Hrh6ZAVPElB4hwfNwZDZYv7CuZ7rExvZsnm4InUKTuLZjY6WK7OzcTPv1p
         L+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579951; x=1769184751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gbv+mgZCGZLs4ziLC7+esXaCguwHnT3zQFaKXRoIwZ0=;
        b=mP+pX6gnu/ljrFyqyllu2KDKOVZmXUqQK72ESzGS+biQ938yYSWppokG07E2PXmNTq
         ULuXA87JGb7AE3hSx6Jf1qaU4IwwadE+2hfZ7/8SCCmZD4j5ki1BEQCzZ8SEWvEYYur0
         OCcNPfBZrV9LVY4g8QghqHLKTk8apeWzs/N4473UoQ2NnMjgMh1k8/XXLqUsB4t7S4JO
         TFDg2sZVnyXl6jRXnY++a2PFOYmnHaaioxDEieQ21W89C5The5eWZYt4EzjXPdICBNxX
         v8WkCvnT9wZ+z2pB3PGUoEKwdMxhRAU2AQkX1hP5poTrF7GZjCVdNy5JH4tZhq0SIdKm
         pqiw==
X-Forwarded-Encrypted: i=1; AJvYcCVHC9H/TDw/OcpYf4n+5ozpRytfHtugGtp8e/1DvqX1VZvcdqm2imnxk/b5ap0mM2yhC38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTDdpAFRV5kmit5pFhbTgtFS4hkfYQtu5XzTXXaxTmjTcSsSg
	h32d3JAwhEtuB3Obe+ss/TRc2NAsxn5LNhkhIi//DhVvn8u7C39MjmHor1zSBBddDhmRJgstjBm
	zeSywm1Yp5g1fByiwU0tLcZhd6QhgQPg=
X-Gm-Gg: AY/fxX6tiCWJceNsszzt22W2PgxzIG7iTB9Mb+jG6y8ippMYTLJ5tg8L7c8CUHZGsnP
	WJznyv+H0nN1OuZKSV77WgqrZfeGHebfZfCyKQ/0z6s6hE+3mBqnyEGlj/j+Ay68AptaHxr1v6j
	GpUxYZjqdIQzreecRXesqsr8LoRxceC6/cYpxAGRupq5EBLGBWrjwMgSGg3dPSupj/S8zH412Az
	0rhNeknYgPN2Fu2xHOcsCP2v2lyVGrOn6al8YOYZ9ZmU3cFlsyyelHGUNUXFF2ypsdKcYRRCTXL
	taZ7KG4NLa+7XnsmqrCGGtOJzzgMLzBkQVQ+ERhCq75Fmjr9W76IUwQqfS+9oFpp3i8q987AZQs
	M9eufyf/H5uTEZg==
X-Received: by 2002:a05:6000:25c7:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4356a024907mr5067963f8f.5.1768579950386; Fri, 16 Jan 2026
 08:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com> <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
In-Reply-To: <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Jan 2026 08:12:19 -0800
X-Gm-Features: AZwV_QgF97B7SsHhIJy1jtkTeO5Iba5XPFk6AcvyMJZrlxWOoYUdgl0HtLvqX4Y
Message-ID: <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 7:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 11:55=E2=80=AFPM Matt Bobrowski
> <mattbobrowski@google.com> wrote:
> >
> > On Thu, Jan 15, 2026 at 08:54:42PM -0800, Roman Gushchin wrote:
> > >
> > > > With the BPF verifier now treating pointers to struct types returne=
d
> > > > from BPF kfuncs as implicitly trusted by default, there is no need =
for
> > > > bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.
> > >
> > > > bpf_get_root_mem_cgroup() does not acquire any references, but rath=
er
> > > > simply returns a NULL pointer or a pointer to a struct mem_cgroup
> > > > object that is valid for the entire lifetime of the kernel.
> > >
> > > > This simplifies BPF programs using this kfunc by removing the
> > > > requirement to pair the call with bpf_put_mem_cgroup().
> > >
> > > It's actually the opposite: having the get semantics (which is also
> > > suggested by the name) allows to treat the root memory cgroup exactly
> > > as any other. And it makes the code much simpler, otherwise you
> > > need to have these ugly checks across the codebase:
> > >       if (memcg !=3D root_mem_cgroup)
> > >               css_put(&memcg->css);
> >
> > I mean, you're certainly not forced to do this. But, I do also see
> > what you mean.
> >
> > > This is why __all__ memcg && cgroup code follows this principle and t=
he
> > > hides the special handling of the root memory cgroup within
> > > css_get()/css_put().
> > >
> > > I wasn't cc'ed on this series, otherwise I'd nack this patch.
> > > If the overhead of an extra kfunc call is a concern here (which I
> > > doubt), we can introduce a non-acquire bpf_root_mem_cgroup()
> > > version.
> > >
> > > And I strongly suggest to revert this change.
> >
> > Apologies, I honestly thought I did CC you on this series. Don't know
> > what happened with that. Anyway, I'm totally OK with reverting this
> > patch and keeping bpf_get_root_mem_cgroup() with KF_ACQUIRE
> > semantics. bpf_get_root_mem_cgroup() was selected as it was the very
> > first BPF kfunc that came to mind where implicit trusted pointer
> > semantics should be applied by the BPF verifier.
> >
> > Notably, the follow up selftest patch [0] will also need to be
> > reverted if so as it relies on bpf_get_root_mem_cgroup() without
> > KF_ACQUIRE. We can probably
> >
> > [0] https://lore.kernel.org/bpf/20260113083949.2502978-2-mattbobrowski@=
google.com/T/#mfa14fb83b3350c25f961fd43dc4df9b25d00c5f5
>
> Instead of revert of two patches, let's revert one and replace
> with test kfunc that 2nd patch can use.
>
> tbh I don't think it's a big deal in practice.
> Kernel code working with cgroups might be different than bpf.
> I'm not sure what was the use case for bpf_get_root_mem_cgroup().
>
> Roman,
> please share your protype bpf code for oom, so it's easier to see
> why non-acquire semantics for bpf_get_root_mem_cgroup() are problematic.

Actually, thinking more about it, bpf_get_root_mem_cgroup() should NOT have
an acquire semantics, otherwise you cannot even implement:

static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
{
        return (memcg =3D=3D root_mem_cgroup);
}

without ugliness:

static inline bool bpf_mem_cgroup_is_root(struct mem_cgroup *memcg)
{
        struct mem_cgroup *root_memcg =3D bpf_get_root_mem_cgroup();
        bool ret =3D memcg =3D=3D root_memcg;

        bpf_put_mem_cgroup(root_memcg);
        return ret;
}

If pattern memcg !=3D root_mem_cgroup happens often above 'put' overhead
will hurt performance.


More thoughts...
maybe we should teach the verifier to expose
struct mem_cgroup *root_mem_cgroup;
as a trusted pointer and remove this kfunc.
Also gate the whole feature by CONFIG_MEMCG.
Check for !=3D NULL after every memcg_get will cause ugly code
and runtime penalty for a rare case of !config_memcg.

