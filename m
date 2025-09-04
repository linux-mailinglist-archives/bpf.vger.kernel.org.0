Return-Path: <bpf+bounces-67383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C58B42FAC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A037C1FE7
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921622264BA;
	Thu,  4 Sep 2025 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYAUG+LA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEE222562;
	Thu,  4 Sep 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952255; cv=none; b=MdT5/Trt7W8F7Df3PIHjbj/AhiGqECLLBbAK4PC5+/j2HDeo/dzRthaaVGl0oPR7MMAbAqoE0SHBOKynOWWGs+nadfqeFB3oaU4gdDHlkoth7j1pwenJKUedo1Gd+Aua/Plw9+2s0lKfB24sLQx/y3M+MADQHhguRAxE/2pfM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952255; c=relaxed/simple;
	bh=dfEq33pg5RPWYU+MZejY0GaRTOzyoGIGlFQEEOCv3Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKIfWxMTWiFHp/aEFGe+b1sTOwytc/XYDpmMcE2YYRtGBJg+lbmCjdr8KHoIkoV/Z7+f7RgEmkpejhywmHNHf7OtAFSlAVWQGXQPpe/SsGo2CjNZxweBrDGjz47yG/Nq6CaFvZKbJ94LhO/0wbnLZ7ZAWjlfSPxWGhYmWkIC0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYAUG+LA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso2906965e9.1;
        Wed, 03 Sep 2025 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952251; x=1757557051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEXO6a2Zbwf2FjjjQvWrZz/nh8JyplzRJyF84IyVjJ4=;
        b=EYAUG+LAmq0gn4htHQwfxtN4Ppxn1oYx84NSSzSVDCfpAnIsXDyuV2RhRDNL1O0FvI
         WJwTPGf+MTtkxc43irnckJ7n1zRvtXe96hpqA1Hvpj536OL0CQZoXkT8fjZQMwdQnnvb
         SadsFL4comvMvtxQ3kN7bujhcipwTHs/ua7XbZd9ywwzUuSKEaydr07gOdcfHPlMFgca
         on0G8Xe2xlaVhAVIfiASNim9seQva+BcnRkxg0Am2+YJ26x/oA5mm981dy10Sd4lVVUQ
         wTmE/WEfJkqIro9zNLdMVaFEsKlMgJpR0hUsMZyjFhHKnO6iPKQaaqLgBl+t/lHkEOUQ
         NUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952251; x=1757557051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEXO6a2Zbwf2FjjjQvWrZz/nh8JyplzRJyF84IyVjJ4=;
        b=OfkSncHqwLwPLC/schMqKHyInXJsxnt5kY9xfwT7OFA3Jupyf5Gu4D7GZMsjCcucr4
         apc0we6c9dcQdW2zLnqKdihdWsXG9s1fThPgl6Pk0x2F7XDPnCXnhVkaVcH+fj94SsOA
         qlKLqRMsSQVLOdP5AEEKPF0upbu4CUQVFyeag+cmMzMyH64SjQOLoi993hRI7Bksac6w
         PGu1jzT1piFERBSZdxsfYFeiaa1pzQxso3TbiudBc4uvwymv8qcgzyToRkzGO47ISaoN
         PzCzif1fUgaUGay72fgYoIDfQAJlVjgCRRudmoKySaCIRwLaxyjpgzZlVqdOPkDLI0yW
         iJJw==
X-Forwarded-Encrypted: i=1; AJvYcCUQqblS/ZbTN2JqEynjgLD58qXqn6M2gXl+djzFy9H6K1V2kz13ARNSdE9MkCiNSozdRtA=@vger.kernel.org, AJvYcCWxaxKXpfMp2zN7FNkVKkiVqudEmoxgf3Km2/bN4VO4cYY10TYk2/QFyXwdA/A3O0/y2u0kodO5BJ5x9I9x@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvpK1Lx0GdSlWUQ+dgWTZut2K+sqG15+iqE+Ltr5mILI8dwR4
	f9mcPS0w9srht+HreqpTmFhwtR8WwVLfQRJJRTyAw3aj0c0x11sBnWBLrDNizVALb9mxEaW2iY3
	ITXYeLSm/g52KRpUT+Xfph0yKB6R0O4Y=
X-Gm-Gg: ASbGnctcE8vm17gV+ey4bWDhqn7M9WkyOIAyqJSlKHzkQtvwkZgonPf93LCsyJC2s5r
	t+1TYUh36tNYWadp6AYujoeu87HOtqhnJTmoAPJ8gs0TWz/gHrQ+PA0uOqNPqZfLhcfX2vUiEbq
	lO5km9W78C9NBOlf6CSohyp0RC3y7YkCvE1OT6pYuFkmyZCY3T7uHI3g4kRgdJ4wWevYvrupQOa
	Q71RlDtghbd+xw+wtnbp3O/DSI=
X-Google-Smtp-Source: AGHT+IEucFAzbOUprN6RbQjE2A1w5RXXBRygrH8X6Gi1kmVxoRGSUtgkwQPskre97AkaDSZkj7jk+bag3t78rQH5NIE=
X-Received: by 2002:a5d:5f54:0:b0:3dc:eb5:503b with SMTP id
 ffacd0b85a97d-3dc0eb55556mr5059825f8f.56.1756952251222; Wed, 03 Sep 2025
 19:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903172453.645226-1-irogers@google.com>
In-Reply-To: <20250903172453.645226-1-irogers@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 19:17:19 -0700
X-Gm-Features: Ac12FXybvkGllEktLdh83Sl6bEn2X0A1lHy4ppRVSr0CioZpWZvihXjYlQAkABc
Message-ID: <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:25=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Recently diagnosing a regression [1] would have been easier if struct
> bpf_prog_info had some comments explaining its usage. As I found it
> hard to generate comments for some parts of the struct,q what is here is =
a

"struct,q" ??

> mix of mostly hand written, but some AI written, comments.
>
> [1] https://lore.kernel.org/lkml/CAP-5=3DfWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEk=
QES-1ZZTrgf8Q@mail.gmail.com/

The perf bug looks unrelated.
It's not worth it to put this kind of info in the commit log.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/bpf.h | 187 ++++++++++++++++++++++++++++++++++++++-

In general, yeah, it could use a doc,
but tools/...bpf.h must be updated at the same time to keep them in sync.

>  1 file changed, 186 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382..008b559dc5c5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6607,45 +6607,230 @@ struct sk_reuseport_md {
>
>  #define BPF_TAG_SIZE   8
>
> +/**
> + * struct bpf_prog_info - Information about a BPF program.
> + *
> + * This structure is used by the bpf(BPF_OBJ_GET_INFO_BY_FD) syscall to =
retrieve
> + * metadata about a loaded BPF program. When values like the jited_prog_=
insns
> + * are desired typically two syscalls will be made, the first to determi=
ne the
> + * length of the buffers and the second with buffers for the syscall to =
fill
> + * in. The variables within the struct are ordered to minimize padding.
> + */

"to minimize padding" ?! Do you see holes in the struct?

>  struct bpf_prog_info {
> +       /**
> +        * @type: The type of the BPF program (e.g.,
> +        * BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_KPROBE). This defin=
es
> +        * where the program can be attached.
> +        */
>         __u32 type;
> +       /**
> +        * @id: A unique, kernel-assigned ID for the loaded BPF program.
> +        */

I wouldn't call it unique. It's 32-bit and can be reused
if somebody loads/unloads 4B bpf progs.

>         __u32 id;
> +       /**
> +        * @tag: A user-defined tag for the program, often a hash of the
> +        * object file it came from. Size is BPF_TAG_SIZE (8 bytes).
> +        */

That is just wrong. It's your job to check AI imaginations.

>         __u8  tag[BPF_TAG_SIZE];
> +       /**
> +        * @jited_prog_len: As an in argument this is the length of the
> +        * jited_prog_insns buffer. As an out argument, the length of the
> +        * JIT-compiled (native machine code) program image in bytes.
> +        */
>         __u32 jited_prog_len;
> +       /**
> +        * @xlated_prog_len: As an in argument this is the length of the
> +        * xlated_prog_insns buffer. As an out argument, the length of th=
e
> +        * translated BPF bytecode in bytes, after the verifier has poten=
tially
> +        * modified it. 'xlated' is short for 'translated'.
> +        */
>         __u32 xlated_prog_len;
> +       /**
> +        * @jited_prog_insns: When 0 (NULL) this is ignored by the kernel=
. When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * jited_prog_len(s) worth of JIT-compiled machine code instructi=
ons into
> +        * the buffer.
> +        */
>         __aligned_u64 jited_prog_insns;
> +       /**
> +        * @xlated_prog_insns: When 0 (NULL) this is ignored by the kerne=
l. When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * xlated_prog_len(s) worth of translated, after BPF verification=
, BPF
> +        * bytecode into the buffer.
> +        */
>         __aligned_u64 xlated_prog_insns;
> -       __u64 load_time;        /* ns since boottime */
> +       /**
> +        * @load_time: The timestamp (in nanoseconds since boot time) whe=
n the
> +        * program was loaded into the kernel.
> +        */
> +       __u64 load_time;
> +       /**
> +        * @created_by_uid: The user ID of the process that loaded this p=
rogram.
> +        */
>         __u32 created_by_uid;
> +       /**
> +        * @nr_map_ids: As an in argument this is the length of the map_i=
ds
> +        * buffer in sizes of u32 (4 bytes). As an out argument, the numb=
er of
> +        * BPF maps used by this BPF program.
> +        */
>         __u32 nr_map_ids;
> +       /**
> +        * @map_ids: When 0 (NULL) this is ignored by the kernel. When no=
n-zero
> +        * a pointer to a buffer is expected and the kernel will write
> +        * nr_map_ids(s) worth of u32 kernel allocated BPF map id values =
into the
> +        * buffer.
> +        */
>         __aligned_u64 map_ids;
> +       /**
> +        * @name: The name of the program, as specified in the ELF object=
 file.
> +        * The max length is BPF_OBJ_NAME_LEN (16 characters).
> +        */

This is generally not true. bpf prog may not come from ELF.

>         char name[BPF_OBJ_NAME_LEN];
> +       /**
> +        * @ifindex: If the program is attached to a network device (netd=
ev),
> +        * this field holds the interface index.
> +        */
>         __u32 ifindex;
> +       /**
> +        * @gpl_compatible: A flag indicating if the program is compatibl=
e with
> +        * a GPL license. This is important for using certain GPL-only he=
lpers.
> +        */
>         __u32 gpl_compatible:1;
>         __u32 :31; /* alignment pad */
> +       /**
> +        * @netns_dev: The device identifier of the network namespace the
> +        * program is attached to.
> +        */
>         __u64 netns_dev;
> +       /**
> +        * @netns_ino: The inode number of the network namespace the prog=
ram is
> +        * attached to.
> +        */
>         __u64 netns_ino;
> +       /**
> +        * @nr_jited_ksyms: As an in argument this is the length of the
> +        * jited_ksyms buffer in sizes of u64 (8 bytes). As an out argume=
nt, the
> +        * number of kernel symbols that the BPF program calls.
> +        */
>         __u32 nr_jited_ksyms;
> +       /**
> +        * @nr_jited_func_lens: As an in argument this is the length of t=
he
> +        * jited_func_lens buffer in sizes of u32 (4 bytes). As an out ar=
gument,
> +        * the number of distinct functions within the JIT-ed program.
> +        */
>         __u32 nr_jited_func_lens;
> +       /**
> +        * @jited_ksyms: When 0 (NULL) this is ignored by the kernel. Whe=
n
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_jited_ksyms(s) worth of addresses of kernel symbols into th=
e u64
> +        * buffer.
> +        */
>         __aligned_u64 jited_ksyms;
> +       /**
> +        * @jited_func_lens: When 0 (NULL) this is ignored by the kernel.=
 When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_jited_func_lens(s) worth of lengths into the u32 buffer.
> +        */
>         __aligned_u64 jited_func_lens;
> +       /**
> +        * @btf_id: The ID of the BTF (BPF Type Format) object associated=
 with
> +        * this program, which contains type information for debugging an=
d
> +        * introspection.
> +        */
>         __u32 btf_id;
> +       /**
> +        * @func_info_rec_size: The size in bytes of a single `bpf_func_i=
nfo`
> +        * record.
> +        */
>         __u32 func_info_rec_size;
> +       /**
> +        * @func_info: When 0 (NULL) this is ignored by the kernel. When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_func_info(s) worth of func_info_rec_size values.
> +        */
>         __aligned_u64 func_info;
> +       /**
> +        * @nr_func_info: As an in argument this is the length of the fun=
c_info
> +        * buffer in sizes of func_info_rec_size. As an out argument, the=
 number
> +        * of `bpf_func_info` records available.
> +        */
>         __u32 nr_func_info;
> +       /**
> +        * @nr_line_info: As an in argument this is the length of the lin=
e_info
> +        * buffer in sizes of line_info_rec_size. As an out argument, the=
 number
> +        * of `bpf_line_info` records, which map BPF instructions to sour=
ce code
> +        * lines.
> +        */
>         __u32 nr_line_info;
> +       /**
> +        * @line_info: When 0 (NULL) this is ignored by the kernel. When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_line_info(s) worth of line_info_rec_size values.
> +        */
>         __aligned_u64 line_info;
> +       /**
> +        * @jited_line_info: When 0 (NULL) this is ignored by the kernel.=
 When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_jited_line_info(s) worth of jited_line_info_rec_size values=
.
> +        */
>         __aligned_u64 jited_line_info;
> +       /**
> +        * @nr_line_info: As an in argument this is the length of the
> +        * jited_line_info buffer in sizes of jited_line_info_rec_size. A=
s an
> +        * out argument, the number of `bpf_line_info` records, which map=
 JIT-ed
> +        * instructions to source code lines.
> +        */
>         __u32 nr_jited_line_info;
> +       /**
> +        * @line_info_rec_size: The size in bytes of a `bpf_line_info` re=
cord.
> +        */
>         __u32 line_info_rec_size;
> +       /**
> +        * @jited_line_info_rec_size: The size in bytes of a `bpf_line_in=
fo`
> +        * record for JIT-ed code.
> +        */
>         __u32 jited_line_info_rec_size;
> +       /**
> +        * @nr_prog_tags: As an in argument this is the length of the pro=
g_tags
> +        * buffer in sizes of BPF_TAG_SIZE (8 bytes). As an out argument,=
 the
> +        * number of program tags, which are hashes of programs that this
> +        * program can tail-call.
> +        */

what? number of progs that prog can tail-call ?!

What AI LLM did you use?

Please share, so we can tell everyone to avoid it at all cost.

>         __u32 nr_prog_tags;
> +       /**
> +        * @prog_tags: When 0 (NULL) this is ignored by the kernel. When
> +        * non-zero a pointer to a buffer is expected and the kernel will=
 write
> +        * nr_prog_tags(s) worth of BPF_TAG_SIZE values.
> +        */

wrong again.

>         __aligned_u64 prog_tags;
> +       /**
> +        * @run_time_ns: The total accumulated execution time of the prog=
ram in
> +        * nanoseconds.
> +        */

Missing critical detail that the kernel doesn't keep counting it all the ti=
me.

>         __u64 run_time_ns;
> +       /**
> +        * @run_cnt: The total number of times the program has been execu=
ted.
> +        */

ditto

>         __u64 run_cnt;
> +       /**
> +        * @recursion_misses: The number of failed tail calls due to reac=
hing
> +        * the recursion limit.
> +        */
>         __u64 recursion_misses;
> +       /**
> +        * @verified_insns: The number of instructions processed by the
> +        * verifier.
> +        */

The comment needs to be expanded.

>         __u32 verified_insns;
> +       /**
> +        * @attach_btf_obj_id: If attached via BTF (e.g., fentry/fexit), =
this is
> +        * the BTF object ID of the target object (e.g., kernel vmlinux).
> +        */

"e.g. kernel vmlinux"...
sigh.
Don't use this LLM.

pw-bot: cr

