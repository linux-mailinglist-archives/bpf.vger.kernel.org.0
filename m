Return-Path: <bpf+bounces-67389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B65B430BB
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 06:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3694188E076
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADD1F4625;
	Thu,  4 Sep 2025 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxURWg7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18313DBA0
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958480; cv=none; b=ZeGY5+mgFclN65LRM01/5XS/oZBVPhP35bZaU5dlV8LQ79kdVNKlM6Zn2IW1pHZoUY8ryqz3wJ8BbPgj3xD4US4cujsNQ+6U2vqq32lVEePEuoMBoXiJXJ7OWz8c/b7FtVmnXWvnzHl+ShTEdrb0zEzuPPRlpkaRdRPYAZqMaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958480; c=relaxed/simple;
	bh=9ecCb5k23kdQD7FSyh2xDrUXRPWpiNf0J1rc8EvnBU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJhXbtkv4NlTLzZQ4HAuwV/fAh2Og8TfrP6Fo8g2GS2d5abjKVj92DkbFRoYBbKgLeq5gVhgAcWaYCTWreVLoFJJf6fq1249ffGWguW1McHWH9c0Pj63MqdsBL7/822sgGYMZ2KxQcrbpIDn2DhnjSRAtPAB8olEk8SXfKrFBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxURWg7O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24ab15b6f09so100835ad.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 21:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756958478; x=1757563278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g3ywYVZGLxYsoA1E31Iij5OuQohLC+0kY73+oCsJjI=;
        b=VxURWg7O1sF/2N0V37n1rvB7dfWCSDao15U6bEEO/3gus++Isw8WaTFc2SQKLpmWKG
         6JJmS1+EDE1w/pVJbVr5BiUQtrEw+2xI69ZEki6foWLqju7zMo+2Jk6Qt+lYSgdSmimQ
         HJpcYa+Iv6p5aM3oBeX327qXev0KSnc4RYyxYDvKGWrrTq3Lqn3Eelvv5tz1RJ6jqwYU
         TilSPCaJpmLRg8ryjJwT2H44LjdMD0BiV9Ci8+u5k8iDQlmPLUPEFtst22rxH4Sb0v/o
         oP93lU0D0DFo8zo/S6sdrz5Oo9q08Q1O2XqCIodzW9/ullSQtl6HhY+FBPayjNEVwK6l
         ZGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756958478; x=1757563278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g3ywYVZGLxYsoA1E31Iij5OuQohLC+0kY73+oCsJjI=;
        b=HQnblavYqA629cA9O9PMCP9AziKJoZvT20Hx+DeV7CKI+iiqm7T9u+rQzaqA4itDJP
         0U4Rf+nO/ac7wLMTL7UV5ymNWoEYmW32yOEoGrvlFa3+aawur1Xvwv4jgOT0daqo1mQd
         T/GM6DUijfHHjdh3UgLV20jdt6b2S9JevmS0TL/JWPtCKGTX//KVx0cl9k2VvFKlhEEl
         pUEVUu99LsY4+kQR1EUzPGMY5EuwhjtiVY1c6g3QhNOQ709Gjv9cmwnFeDUnjmgTbwzK
         Juw4QDIgdSlgbL7uUSU1KyA6w/HP0bTs1k5RKSYbhyVGR7V3kWJEBo3nD75h2Il+Iyfc
         Zqdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZKDlGDTLV5oRM9iiutfiIguMRrTOM1f+ygkOM7IDcIUantZ2M16RzmwhGERqImdG+ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyizUJsAbTX8i0Is3eEcDTg8he5i7UvKScVM6yzKM5VCCQecApS
	OcjZs/CaOv5mjxG63VMQl2AymSYZSPNxnomlFsPzLkHd5O2VTWBNR4xHoVh8a9UboeXQkHGzXxo
	F+j9osDWgL5P23OadgtNZtV9ErHW/L5Jg9Q+UkvRx
X-Gm-Gg: ASbGncs5imEsERrvUo+oJRbK+sStuoG5/Gn4QGDdqGwzbM8TLguHQ0lQfX+TAtxthED
	WWo7FxiqiybYgKGP4TPHOXsG0fsdkx+zd2dQEwGzX5cn0lDjPGTp1XNSDgCA1RA7iUMNts2g532
	p2KTKCHDyPfZJka8IyC4882rTCj+9lO3Ik3xvlJevPbdypposCvQZXXfQkGH3shjgPnVWx5Hxih
	Qr0j7LB3WT92KQj3LeLDcFZEQ==
X-Google-Smtp-Source: AGHT+IHufRb3l7jEZAkp3gSFf10hWovvnfiu7raHd48RwLeLLBj7+UdMllXDmpcoSVSPrOhbZD03exh6gblQQTX5j4k=
X-Received: by 2002:a17:903:f8e:b0:24a:fcbd:db49 with SMTP id
 d9443c01a7336-24ccaf744e3mr1175355ad.10.1756958477328; Wed, 03 Sep 2025
 21:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903172453.645226-1-irogers@google.com> <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
In-Reply-To: <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 21:01:06 -0700
X-Gm-Features: Ac12FXwRTj2a3bLzplKorMCDtwJaOwkhgKkF9vQrMEaDseIgsAXsXUNsOfH_nhQ
Message-ID: <CAP-5=fUm0-f6CW1DNKWK0Zv_4Hzqe5oV+d4ajhd3+XMdxXvu2Q@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 3, 2025 at 10:25=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Recently diagnosing a regression [1] would have been easier if struct
> > bpf_prog_info had some comments explaining its usage. As I found it
> > hard to generate comments for some parts of the struct,q what is here i=
s a
>
> "struct,q" ??

Apologies, typo on pressing the 'q'.

>
>
> > mix of mostly hand written, but some AI written, comments.
> >
> > [1] https://lore.kernel.org/lkml/CAP-5=3DfWJQcmUOP7MuCA2ihKnDAHUCOBLkQF=
EkQES-1ZZTrgf8Q@mail.gmail.com/
>
> The perf bug looks unrelated.
> It's not worth it to put this kind of info in the commit log.

Feedback from people working on perf was that the bpf_prog_info (the
struct used after freed) was insufficient to understand how it worked.
For example, the implied nature of the u64 pointer values. If they
were non-zero (say just uninitialized) then the syscall would more
than likely return EFAULT which would seem to imply the bpf_prog_info
was incorrect and not things it points to. Anyway, I'm easy about
removing context from the patch.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/bpf.h | 187 ++++++++++++++++++++++++++++++++++++++-
>
> In general, yeah, it could use a doc,
> but tools/...bpf.h must be updated at the same time to keep them in sync.

It must, be we generally update the kernel version first and then sync
to tools. I didn't want to make the series overly spammy. The perf
build warns of things being out of sync here (bpf.h isn't currently
included):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/check-headers.sh?h=3Dperf-tools-next

> >  1 file changed, 186 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 233de8677382..008b559dc5c5 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6607,45 +6607,230 @@ struct sk_reuseport_md {
> >
> >  #define BPF_TAG_SIZE   8
> >
> > +/**
> > + * struct bpf_prog_info - Information about a BPF program.
> > + *
> > + * This structure is used by the bpf(BPF_OBJ_GET_INFO_BY_FD) syscall t=
o retrieve
> > + * metadata about a loaded BPF program. When values like the jited_pro=
g_insns
> > + * are desired typically two syscalls will be made, the first to deter=
mine the
> > + * length of the buffers and the second with buffers for the syscall t=
o fill
> > + * in. The variables within the struct are ordered to minimize padding=
.
> > + */
>
> "to minimize padding" ?! Do you see holes in the struct?

I think you've read this the opposite way it is intended. Sometimes in
the struct there is adjacent:

__u32  nr_<foo>;
__aligned_u64 <foo>;

This is true for say map_ids and line_info. Sometimes the order is:

__aligned_u64 <foo>;
__u32  nr_<foo>;

This is true for jited_line_info. Sometimes things are spread apart
and sometimes there is an additional <foo>_rec_size which again may be
spread apart.

What this is trying to say is when looking for things relating to
<foo> keep searching the rest of the struct as the order has been made
to (I assume) minimize padding. I may be so bold as to say that not
grouping related variables in a struct is not general practice in C.

> >  struct bpf_prog_info {
> > +       /**
> > +        * @type: The type of the BPF program (e.g.,
> > +        * BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_KPROBE). This def=
ines
> > +        * where the program can be attached.
> > +        */
> >         __u32 type;
> > +       /**
> > +        * @id: A unique, kernel-assigned ID for the loaded BPF program=
.
> > +        */
>
> I wouldn't call it unique. It's 32-bit and can be reused
> if somebody loads/unloads 4B bpf progs.

Perhaps clarifying that the ID can be reused in the case of a program
being unloaded and loaded.

> >         __u32 id;
> > +       /**
> > +        * @tag: A user-defined tag for the program, often a hash of th=
e
> > +        * object file it came from. Size is BPF_TAG_SIZE (8 bytes).
> > +        */
>
> That is just wrong. It's your job to check AI imaginations.

Tbh, I don't know what a "tag" is supposed to be nor did I find the
name intention revealing. This is very much the reason I'm subjecting
myself to this ordeal. I recall hashing of BPF instructions post
verification making them not useful for identification being mentioned
to me at one point, so hey AI your guess is as good as mine. Could you
help clarify what the definition should be?

> >         __u8  tag[BPF_TAG_SIZE];
> > +       /**
> > +        * @jited_prog_len: As an in argument this is the length of the
> > +        * jited_prog_insns buffer. As an out argument, the length of t=
he
> > +        * JIT-compiled (native machine code) program image in bytes.
> > +        */
> >         __u32 jited_prog_len;
> > +       /**
> > +        * @xlated_prog_len: As an in argument this is the length of th=
e
> > +        * xlated_prog_insns buffer. As an out argument, the length of =
the
> > +        * translated BPF bytecode in bytes, after the verifier has pot=
entially
> > +        * modified it. 'xlated' is short for 'translated'.
> > +        */
> >         __u32 xlated_prog_len;
> > +       /**
> > +        * @jited_prog_insns: When 0 (NULL) this is ignored by the kern=
el. When
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * jited_prog_len(s) worth of JIT-compiled machine code instruc=
tions into
> > +        * the buffer.
> > +        */
> >         __aligned_u64 jited_prog_insns;
> > +       /**
> > +        * @xlated_prog_insns: When 0 (NULL) this is ignored by the ker=
nel. When
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * xlated_prog_len(s) worth of translated, after BPF verificati=
on, BPF
> > +        * bytecode into the buffer.
> > +        */
> >         __aligned_u64 xlated_prog_insns;
> > -       __u64 load_time;        /* ns since boottime */
> > +       /**
> > +        * @load_time: The timestamp (in nanoseconds since boot time) w=
hen the
> > +        * program was loaded into the kernel.
> > +        */
> > +       __u64 load_time;
> > +       /**
> > +        * @created_by_uid: The user ID of the process that loaded this=
 program.
> > +        */
> >         __u32 created_by_uid;
> > +       /**
> > +        * @nr_map_ids: As an in argument this is the length of the map=
_ids
> > +        * buffer in sizes of u32 (4 bytes). As an out argument, the nu=
mber of
> > +        * BPF maps used by this BPF program.
> > +        */
> >         __u32 nr_map_ids;
> > +       /**
> > +        * @map_ids: When 0 (NULL) this is ignored by the kernel. When =
non-zero
> > +        * a pointer to a buffer is expected and the kernel will write
> > +        * nr_map_ids(s) worth of u32 kernel allocated BPF map id value=
s into the
> > +        * buffer.
> > +        */
> >         __aligned_u64 map_ids;
> > +       /**
> > +        * @name: The name of the program, as specified in the ELF obje=
ct file.
> > +        * The max length is BPF_OBJ_NAME_LEN (16 characters).
> > +        */
>
> This is generally not true. bpf prog may not come from ELF.

Thanks, I can clarify this.

> >         char name[BPF_OBJ_NAME_LEN];
> > +       /**
> > +        * @ifindex: If the program is attached to a network device (ne=
tdev),
> > +        * this field holds the interface index.
> > +        */
> >         __u32 ifindex;
> > +       /**
> > +        * @gpl_compatible: A flag indicating if the program is compati=
ble with
> > +        * a GPL license. This is important for using certain GPL-only =
helpers.
> > +        */
> >         __u32 gpl_compatible:1;
> >         __u32 :31; /* alignment pad */
> > +       /**
> > +        * @netns_dev: The device identifier of the network namespace t=
he
> > +        * program is attached to.
> > +        */
> >         __u64 netns_dev;
> > +       /**
> > +        * @netns_ino: The inode number of the network namespace the pr=
ogram is
> > +        * attached to.
> > +        */
> >         __u64 netns_ino;
> > +       /**
> > +        * @nr_jited_ksyms: As an in argument this is the length of the
> > +        * jited_ksyms buffer in sizes of u64 (8 bytes). As an out argu=
ment, the
> > +        * number of kernel symbols that the BPF program calls.
> > +        */
> >         __u32 nr_jited_ksyms;
> > +       /**
> > +        * @nr_jited_func_lens: As an in argument this is the length of=
 the
> > +        * jited_func_lens buffer in sizes of u32 (4 bytes). As an out =
argument,
> > +        * the number of distinct functions within the JIT-ed program.
> > +        */
> >         __u32 nr_jited_func_lens;
> > +       /**
> > +        * @jited_ksyms: When 0 (NULL) this is ignored by the kernel. W=
hen
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_jited_ksyms(s) worth of addresses of kernel symbols into =
the u64
> > +        * buffer.
> > +        */
> >         __aligned_u64 jited_ksyms;

Fwiw, I don't know what a kernel symbol is in this context. Perf is
assuming they are only other BPF programs:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-event.c#n63
Similarly, why does perf assume nr_jited_ksym =3D=3D nr_prog_tags =3D=3D
nr_jited_func_lens :
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-event.c#n943
It'd be nice to have this invariant documented, and of course fix perf
if it isn't true. Of course the code has no comments and I'm sure I
must be an idiot for failing to understand this.

> > +       /**
> > +        * @jited_func_lens: When 0 (NULL) this is ignored by the kerne=
l. When
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_jited_func_lens(s) worth of lengths into the u32 buffer.
> > +        */
> >         __aligned_u64 jited_func_lens;
> > +       /**
> > +        * @btf_id: The ID of the BTF (BPF Type Format) object associat=
ed with
> > +        * this program, which contains type information for debugging =
and
> > +        * introspection.
> > +        */
> >         __u32 btf_id;
> > +       /**
> > +        * @func_info_rec_size: The size in bytes of a single `bpf_func=
_info`
> > +        * record.
> > +        */
> >         __u32 func_info_rec_size;
> > +       /**
> > +        * @func_info: When 0 (NULL) this is ignored by the kernel. Whe=
n
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_func_info(s) worth of func_info_rec_size values.
> > +        */
> >         __aligned_u64 func_info;
> > +       /**
> > +        * @nr_func_info: As an in argument this is the length of the f=
unc_info
> > +        * buffer in sizes of func_info_rec_size. As an out argument, t=
he number
> > +        * of `bpf_func_info` records available.
> > +        */
> >         __u32 nr_func_info;
> > +       /**
> > +        * @nr_line_info: As an in argument this is the length of the l=
ine_info
> > +        * buffer in sizes of line_info_rec_size. As an out argument, t=
he number
> > +        * of `bpf_line_info` records, which map BPF instructions to so=
urce code
> > +        * lines.
> > +        */
> >         __u32 nr_line_info;
> > +       /**
> > +        * @line_info: When 0 (NULL) this is ignored by the kernel. Whe=
n
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_line_info(s) worth of line_info_rec_size values.
> > +        */
> >         __aligned_u64 line_info;
> > +       /**
> > +        * @jited_line_info: When 0 (NULL) this is ignored by the kerne=
l. When
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_jited_line_info(s) worth of jited_line_info_rec_size valu=
es.
> > +        */
> >         __aligned_u64 jited_line_info;
> > +       /**
> > +        * @nr_line_info: As an in argument this is the length of the
> > +        * jited_line_info buffer in sizes of jited_line_info_rec_size.=
 As an
> > +        * out argument, the number of `bpf_line_info` records, which m=
ap JIT-ed
> > +        * instructions to source code lines.
> > +        */
> >         __u32 nr_jited_line_info;
> > +       /**
> > +        * @line_info_rec_size: The size in bytes of a `bpf_line_info` =
record.
> > +        */
> >         __u32 line_info_rec_size;
> > +       /**
> > +        * @jited_line_info_rec_size: The size in bytes of a `bpf_line_=
info`
> > +        * record for JIT-ed code.
> > +        */
> >         __u32 jited_line_info_rec_size;
> > +       /**
> > +        * @nr_prog_tags: As an in argument this is the length of the p=
rog_tags
> > +        * buffer in sizes of BPF_TAG_SIZE (8 bytes). As an out argumen=
t, the
> > +        * number of program tags, which are hashes of programs that th=
is
> > +        * program can tail-call.
> > +        */
>
> what? number of progs that prog can tail-call ?!
>
> What AI LLM did you use?
>
> Please share, so we can tell everyone to avoid it at all cost.

Sure, it was llama ;-)

Anyway, progs? Could this be any less intention revealing. I'd love a
proper definition.

> >         __u32 nr_prog_tags;
> > +       /**
> > +        * @prog_tags: When 0 (NULL) this is ignored by the kernel. Whe=
n
> > +        * non-zero a pointer to a buffer is expected and the kernel wi=
ll write
> > +        * nr_prog_tags(s) worth of BPF_TAG_SIZE values.
> > +        */
>
> wrong again.

Sure, could you provide a correction? I was trying to base what was
written here off of:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/bpf/syscall.c#n5121
a 300 line function successfully avoiding any comments.

> >         __aligned_u64 prog_tags;
> > +       /**
> > +        * @run_time_ns: The total accumulated execution time of the pr=
ogram in
> > +        * nanoseconds.
> > +        */
>
> Missing critical detail that the kernel doesn't keep counting it all the =
time.

I'm not sure what you mean by this? Do you think the comment is saying
that the run_time is the run_time since loading? But it says
"accumulated execution time" which would imply only time spent
executing. When is it not counting?

> >         __u64 run_time_ns;
> > +       /**
> > +        * @run_cnt: The total number of times the program has been exe=
cuted.
> > +        */
>
> ditto

Shouldn't the purpose of run_time_ns and run_cnt to be to calculate an
average run_time? If these are arbitrary values, what's the point?
Again, why isn't this explained? Thank you for helping me to try to
fix this. I'm also happy for others to fix this and this patch to be
completely ignored. It can be ignored in all scenarios, I was just
trying to be helpful to others and probably my future self at some
point.

> >         __u64 run_cnt;
> > +       /**
> > +        * @recursion_misses: The number of failed tail calls due to re=
aching
> > +        * the recursion limit.
> > +        */
> >         __u64 recursion_misses;
> > +       /**
> > +        * @verified_insns: The number of instructions processed by the
> > +        * verifier.
> > +        */
>
> The comment needs to be expanded.

Sure, suggestions?

> >         __u32 verified_insns;
> > +       /**
> > +        * @attach_btf_obj_id: If attached via BTF (e.g., fentry/fexit)=
, this is
> > +        * the BTF object ID of the target object (e.g., kernel vmlinux=
).
> > +        */
>
> "e.g. kernel vmlinux"...
> sigh.
> Don't use this LLM.

Use the well documented code instead! :-)

Thanks!
Ian

