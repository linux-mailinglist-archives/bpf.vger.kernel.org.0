Return-Path: <bpf+bounces-77900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA0CF61C3
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 01:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA0330533B0
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC791E0B9C;
	Tue,  6 Jan 2026 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VExAqKcZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0261A3166
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660706; cv=none; b=phMjgqrKzs5OtnTQT0B+859fWjjUVXel6qizcH/faJDE8cLtSO+5dp5p0bxgapItOhYgNr0sx+o/FhjlpxXEw8gLBaK4uQHH/57x2ztvEomyqSsfPt2vqrlxpWbhKKPVqWfuLpi5NqDhTiJ1dCZSYO4mpo/GwlzpevP996VUZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660706; c=relaxed/simple;
	bh=UnDJNkCi/bg3d+KVoXoKsgv2gDGGiQ++BntTusyBhag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n483HBjriI8RAeDducv1yPEhMmmHX3J2plttMrh6EZkFYqUX9BciyIsSwkBQakj1bt81FpZOT6UfsMV6MYsYry0sZ5tDkjXOGijKXIPPsnLF9ztEBtZjzrapFXnm4CDPdRiW77Z+B/LVqu0ie4WrpRlzU0n5j7XWpqp9qdMm6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VExAqKcZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so3706835e9.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 16:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767660703; x=1768265503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnDJNkCi/bg3d+KVoXoKsgv2gDGGiQ++BntTusyBhag=;
        b=VExAqKcZB92l0qCCaaY1auheeEyR1bOLyPJw4eNfa4oInI/b+2ewVMNlaFpF+RW4zx
         XSe1RCYi40RSTTdp+0Rc/dcFj5/Dz9N7+HrB4BpvqqWtaAedJGU2S/smRguDsZD8iZf2
         CIHVkqZXbXnI+REN+Zb1jA78guRu2MQgNY8HrS87jzBIOH40WR+/56iRCOZ2+GuH3xp3
         861MFw+5/kiXauWDNdkj4pzKh9Dub7cKTkVzJ7amBxc0solHecS9V2xmfsxTJIAjMXx/
         Rb28e84jvRvO2FU5772z1e9rcQNW8ARzDB+x4LzEf4mvI++SaDMO47FYBb6wDyg6WWrx
         KzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660703; x=1768265503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnDJNkCi/bg3d+KVoXoKsgv2gDGGiQ++BntTusyBhag=;
        b=fgeMDH2uBR52hAoxRAKXO5I0lQ7BY5tjdmNB3oYEvrdL9ZonSP6ovzBO4l+Fc2u/XB
         LY63ZIy1dhGg2o2y6CM5TU7bED0QI+S5wztweG5lJd8fOeWtKUoRy8lt7JfyqnZDstdb
         97rfedoFNDksPET/2232i8Q5bNi4iVU32W5r0w1ToKQe5wNEsezN0P6GxHXNBX0q9AEn
         hcAJIcn3NoLQvgP5K157sk/dgnUXTD3NaLoAK5ut2M1JBQqshdfnapVhOXG5TLkmn3ie
         wco58BE+tnIc3ecB3bUYyjrQP2hMxcFjtZTETCblNj+26VqEwEdh16KauavaKYHhSsxb
         xlTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1gi0+LOVe4Y24JXGnUg20EVFw1en7ZjVSKPLCVJVpiTHHmDz8hq9GGn2RtAVEx1Jp+z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IFwRrC6UbMYeK9zLD0xfb0wSfprQ5g1KT79U+odEbOIWQdhy
	6pY+GRqN5R0SEUGQMyOuRtqJCsv2CuYpRHwtYOrHABo4/+62pJ61TSu0jK8+hBymDHx16v00sqz
	k2i7c6KfhZH14xcLYiWpmY7yLKAXRVd0=
X-Gm-Gg: AY/fxX6JxFKN08AXfvdSa8bmsCLZh2kA5JSAGfR3sbACh9mHFMfRXQSBFEXX5mWPhuN
	mLgpBO2xTC0oo/eVEzEM52uipTw/NIRtCYRwvgD8t8FkzGK2EOj4AZUjHIbV15zYU/YxAKL8A2U
	iDLkTi7xi53Sl26kKpLXK6z/hthwOd0dXzGCpNZiilnUhG1j1Kq2Sdnqna98DOgd4EfN+mSwqZ6
	YLxre7FofXQv/57FbvFVik449mxayeOYzAclYjJKy9EJVS2nJIUeL3kcpaHRV0TA3EUUPqn4EBn
	5r7FeZdWPsHaomGSWS//YQSORDQK
X-Google-Smtp-Source: AGHT+IGRVuoSJMOI+CDhhAGzg0TWtiqIBeZfnrxaJIqPzHAnSzRAQhr7G4J0svlVw0jXugQGgHaRsbpVIhsMKo0Cygo=
X-Received: by 2002:a05:600c:a113:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-47d7f0a7336mr10731465e9.36.1767660702484; Mon, 05 Jan 2026
 16:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com> <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com> <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
In-Reply-To: <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 16:51:31 -0800
X-Gm-Features: AQt7F2q7Mb7N57eroU0mHgkFf7yIF7CSgmqN1VJp3QZ9cFoXlGhHEOHIMp2KOy4
Message-ID: <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 4:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > On 22/12/2025 19:03, Alexei Starovoitov wrote:
> > > On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > >>
> > >>>
> > >>> Hold on. I'm missing how libbpf will sanitize things for older kern=
els?
> > >>
> > >> The sanitization we can get from layout info is for handling a kerne=
l built with
> > >> newer kernel/module BTF. The userspace tooling (libbpf and others) d=
oes not fully
> > >> understand it due to the presence of new kinds. In such a case layou=
t data gives us
> > >> info to parse it by providing info on kind layout, and libbpf can sa=
nitize it
> > >> to be usable for some cases (where the type graph is not fatally com=
promised
> > >> by the lack of a kind). This will always be somewhat limited, but it
> > >> does provide more usability than we have today.
> > >
> > > I'm even more confused now. libbpf will sanitize BTF for the sake of
> > > user space? That's not something it ever did. libbpf sanitizes BTF
> > > only to
> >
> > Right; it's an extension of the sanitization concept from what it does =
today.
> > Today we sanitize newer _program_ BTF to ensure it is acceptable to a k=
ernel which
> > lacks specific aspects of that BTF; the goal here is to support some si=
mple sanitization
> > of the newer _kernel_ BTF by libbpf to help tools (that know about kind=
 layout but may lack
> > latest kind info kernel has) to make that kernel BTF usable.
>
> Wait, is that really a goal? I get why Alexei is confused now :)
>
> I think we should stick to libbpf sanitizing only BPF program's BTFs
> for the sake of loading it into the kernel. If some user space tool is
> trying to work with kernel BTF that has BTF features that tool doesn't
> support, then we only have two reasonable options: a) tool just fails
> to process that BTF altogether or b) the tool is smart enough to
> utilize BTF layout information to know which BTF types it can safely
> skip (that's where those flags I argue for would be useful). In both
> cases libbpf's btf__parse() will succeed because libbpf can utilize
> layout info to construct a lookup table for btf__type_by_id(). And
> libbpf doesn't need to do anything beyond that, IMO.
>
> We'll teach bpftool to dump as much of BTF as possible (I mean
> `bpftool btf dump file`), so it's possible to get an idea of what part
> of BTF is not supported and show those that we know about. We could
> teach btf_dump to ignore those types that are "safe modifier-like
> reference kind" (as marked with that flag I proposed earlier), so that
> `format c` works as well (though I wouldn't recommend using such
> output as a proper vmlinux.h, users should update bpftool ASAP for
> such use cases).
>
> As far as the kernel is concerned, BTF layout is not used and should
> not be used or trusted (it can be "spoofed" by the user). It can
> validate it for sanity, but that's pretty much it. Other than that, if
> the kernel doesn't *completely* understand every single piece of BTF,
> it should reject it (and that's also why libbpf should sanitize BPF
> object's BTF, of course).

+1 to all of the above, except ok-to-skip flag, since I feel
it will cause more bike sheding and arguing whether a particular
new addition to BTF is skippable or not. Like upcoming location info.
Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
Skippable? One might argue that they are while they are mandatory
for some other use case.
Looking at it differently, if the kernel is old and cannot understand that
BTF feature the libbpf has to sanitize it no matter skippable or not.
While from btf__parse() pov it also doesn't matter.
btf_new()->btf_parse_hdr() will remember kind layout,
and btf_parse_type_sec() can construct the index for the whole thing
with layout info,
while btf_validate_type() has to warn about unknown kind regardless
of skippable flag. The tool (bpftool or else) needs to yell when
final vmlinux.h is incomplete. Skipping printing modifier-like decl_tag
is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
though one might argue that they are.

Also let's not call btf__parse() process with layout info
as a sanitization. Sanitization is the word to describe actual replacement
of unrecognized kind with a known kind. Here btf__parse() won't be
mangling it. Who knows, maybe btf_dumper (in bpftool or else)
understands the kind, though libbpf's btf__parse() does not.

