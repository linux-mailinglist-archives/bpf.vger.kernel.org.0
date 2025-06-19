Return-Path: <bpf+bounces-61116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D0AE0E3F
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593E61BC6E19
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9562459F3;
	Thu, 19 Jun 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw3kOlWV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF30E85B
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362719; cv=none; b=rRqAqcTMXSgdA8LigSnWqKX+/THSHxrl9hkuTBIgy66Oo5CCKlB8jwJYSu4sfTAptSv55tp3fBHlUSqYKsfzPEigvGtprnKcIBq7bMCziN+4dWJtqQc5gH1mxnnA1G6pa7u0eAnEV1E7MH54tIgv676emEMwYssj3eSl1pjzRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362719; c=relaxed/simple;
	bh=kCFZEhEZojh6JGtF6pntCUJAATLgVcUtcFl1+ViUfLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdNiXaKt7bICskyNAbn0rI9rnQ73q38YreEyv7yXOTUWmE8TnZQCaC75cxrnNuOGQARO6JapDp1c7btNxgQssvpQhtuN6Pxe5GsGojRu8xEZgmSKb4mE8E0Ial0548PSJxwftY/f9oQN5eqJ+/dI2ZG5DC8ImfQaKacRJTsQs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw3kOlWV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45348bff79fso13475465e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750362715; x=1750967515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vxD8w1ZuVhnZzpV5jHKu0JNplaPxCVJm8dvajlVLWOA=;
        b=Tw3kOlWVL2avslr8wyCJDvhQGp7/fbiW/B6n+TWxqWucMcLw9PD9Yy9DUR/K5pCo7U
         p0liNF2HQiUCgGDanky7RsLqWyfDc5GLV4FOd9fQvtm0RvzT/M3GEweI1EqzunnGOAQ7
         RUxejVzZrpb87VS+bp2Me83ToCX2hGE0bEfVhbOnTmUCwTAkgzuJJ1LWqkizlgeLpcH+
         apbijgTt4o27rzpxyqZuSZELsbv9TBqbCJc9QNdMlzjgqtPrIqKVz/pRguqeKVhj1r/K
         xbvWwveyWFzsHsk4/qcKMGrjzO4fXYk54d/kSFqljUW3G9dGYbYiz+0SZu5UHiBSxspH
         eCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362715; x=1750967515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxD8w1ZuVhnZzpV5jHKu0JNplaPxCVJm8dvajlVLWOA=;
        b=WbRVrs78IgopUx/J59/svLszFgTJ5tbdWRq6ifg7DcoJTeGJJWlHVsK1oymiCkQdu5
         2dcY5WnjdzAYCNRguOJVbOKCSWU7un9kh8pw6b0ujnYlsuDzKxTtv/zfQ+0LPdmllWPh
         Fgb8RFcFZjIiAFz9XbXKm9EdXBJ5RrdWFddgIozYP4PT5nt/PHLEuZEf95cet0lG0bmo
         fG8zkZlSyIwi6FfJ82zIzzilFMSVrcXJcFNDJONT5vXavr8ynC5Qf0YKrOE04ZXigEOb
         aoYiQsPsYIBo5e6TNE7PgShhtyd8/jb6xC2wKXMoUE+Kl9UrjGK0QXLZcVD445WMNqnA
         sEEg==
X-Gm-Message-State: AOJu0YwKtU1aCA6oN05JP/H2iZKzWwie+Qkb8FZBpmt1qgLY6HyQTN+Y
	hqr2FEqq/CsfnuPTwoI5VGBX4Y12IQ3fjQKIvd5HMkeXA7E2QTc2LxODkFFYzw==
X-Gm-Gg: ASbGncuDuAQYkluvXjRQroVQF8lm139BzjAAlsZg5Y1viCd7P0gLzo1QvG80hZCb2Ir
	+NddUFClKmY5yOOyaogjQ7sahy3gmnjB9boJOxeauqJyCHgZD7VVxxGUHYFrPhvws7U+Gm+PHxE
	ptePatFWysl8qGnKKYkPkDmm/9GOnVfMM899ltMDYvUF+l3bWIbNf2Wq6kr2ZFUzogwDGwThQmz
	AWLpzU7DtKT7/x2bmRB8dpxa3gQcqApztO12+3vF+I5Cfh1ukcrqY1c7aUeGkRjqp3wjIa8OHzh
	riRrx+p4Hyd0M64+YcM/GHIZ+4hf/n1zSsZOqEF5CYxtwCMPllG9H8PF/tcAUkwIh/iQF+jD8A=
	=
X-Google-Smtp-Source: AGHT+IHq6bn25dbIHh16PhIBK58J4GiMsGv5Gun1wTfRb3wwYYhJL/kgGPqEj/+murue9nTK81yR/g==
X-Received: by 2002:a05:600c:4686:b0:450:cfe1:a827 with SMTP id 5b1f17b1804b1-453659f4fa0mr436095e9.31.1750362714301;
        Thu, 19 Jun 2025 12:51:54 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a27sm36740255e9.31.2025.06.19.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 12:51:53 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:57:34 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 5/9] bpf, x86: add support for indirect jumps
Message-ID: <aFRrrmlzQQQsjIpV@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-6-a.s.protopopov@gmail.com>
 <CAADnVQJGgLNENh15Bp==Ui0GxL1_iwgZ1vHkFTGp9xtO8n_XNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJGgLNENh15Bp==Ui0GxL1_iwgZ1vHkFTGp9xtO8n_XNg@mail.gmail.com>

On 25/06/17 08:06PM, Alexei Starovoitov wrote:
> On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Add support for a new instruction
> >
> >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=fd(M)
> >
> > which does an indirect jump to a location stored in Rx. The map M
> > is an instruction set map containing all possible targets for this
> > particular jump.
> >
> > On the jump the register Rx should have type PTR_TO_INSN. This new
> > type assures that the Rx register contains a value (or a range of
> > values) loaded from the map M. Typically, this will be done like this
> > The code above could have been generated for a switch statement with
> > (e.g., this could be a switch statement compiled with LLVM):
> >
> >     0:   r3 = r1                    # "switch (r3)"
> >     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
> >     2:   r3 <<= 0x3                 # r3 is void*, point to an address
> >     3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
> 
> Something doesn't add up.
> Since you made libbpf to tag this ld_imm64 as BPF_PSEUDO_MAP_VALUE
> which insn (map key) does it point to ?
> In case of global data it's key==0.
> Here it's 1st element of insn_array ?
> 
> >     5:   r1 += r3                   # r1 inherits boundaries from r3
> >     6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
> >     7:   gotox r1[,imm=fd(M)]       # verifier checks that M == r1->map_ptr
> >
> > On building the jump graph, and the static analysis, a new function
> > of the INSN_SET is used: bpf_insn_set_iter_xlated_offset(map, n).
> > It lets to iterate over unique slots in an instruction set (equal
> > items can be generated, e.g., for a sparse jump table for a switch,
> > where not all possible branches are taken).
> >
> > Instruction (3) above loads an address of the first element of the
> > map. From BPF point of view, the map is a jump table in native
> > architecture, e.g., an array of jump targets. This patch allows
> > to grab such an address and then later to adjust an offset, like in
> > instruction (5). A value of such type can be dereferenced once to
> > create a PTR_TO_INSN, see instruction (6).
> >
> > When building the config, the high 16 bytes of the insn_state are
> > used, so this patch (theoretically) supports jump tables of up to
> > 2^16 slots.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c  |   7 ++
> >  include/linux/bpf.h          |   2 +
> >  include/linux/bpf_verifier.h |   4 +
> >  kernel/bpf/bpf_insn_set.c    |  71 ++++++++++++-
> >  kernel/bpf/core.c            |   2 +
> >  kernel/bpf/verifier.c        | 198 ++++++++++++++++++++++++++++++++++-
> >  6 files changed, 278 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 37dc83d91832..d20f6775605d 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2520,6 +2520,13 @@ st:                      if (is_imm8(insn->off))
> >
> >                         break;
> >
> > +               case BPF_JMP | BPF_JA | BPF_X:
> > +               case BPF_JMP32 | BPF_JA | BPF_X:
> > +                       emit_indirect_jump(&prog,
> > +                                          reg2hex[insn->dst_reg],
> > +                                          is_ereg(insn->dst_reg),
> > +                                          image + addrs[i - 1]);
> > +                       break;
> >                 case BPF_JMP | BPF_JA:
> >                 case BPF_JMP32 | BPF_JA:
> >                         if (BPF_CLASS(insn->code) == BPF_JMP) {
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 008bcd44c60e..3c5eaea2b476 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -952,6 +952,7 @@ enum bpf_reg_type {
> >         PTR_TO_ARENA,
> >         PTR_TO_BUF,              /* reg points to a read/write buffer */
> >         PTR_TO_FUNC,             /* reg points to a bpf program function */
> > +       PTR_TO_INSN,             /* reg points to a bpf program instruction */
> >         CONST_PTR_TO_DYNPTR,     /* reg points to a const struct bpf_dynptr */
> >         __BPF_REG_TYPE_MAX,
> >
> > @@ -3601,6 +3602,7 @@ int bpf_insn_set_ready(struct bpf_map *map);
> >  void bpf_insn_set_release(struct bpf_map *map);
> >  void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> >  void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> > +int bpf_insn_set_iter_xlated_offset(struct bpf_map *map, u32 iter_no);
> >
> >  struct bpf_insn_ptr {
> >         void *jitted_ip;
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 84b5e6b25c52..80d9afcca488 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -229,6 +229,10 @@ struct bpf_reg_state {
> >         enum bpf_reg_liveness live;
> >         /* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
> >         bool precise;
> > +
> > +       /* Used to track boundaries of a PTR_TO_INSN */
> > +       u32 min_index;
> > +       u32 max_index;
> 
> This is no go. We cannot grow bpf_reg_state.
> Find a way to reuse fields without increasing the size.

See my comment below, next to "Why bother consuming memory".

> >  };
> >
> >  enum bpf_stack_slot_type {
> > diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> > index c20e99327118..316cecad60a9 100644
> > --- a/kernel/bpf/bpf_insn_set.c
> > +++ b/kernel/bpf/bpf_insn_set.c
> > @@ -9,6 +9,8 @@ struct bpf_insn_set {
> >         struct bpf_map map;
> >         struct mutex state_mutex;
> >         int state;
> > +       u32 **unique_offsets;
> > +       u32 unique_offsets_cnt;
> >         long *ips;
> >         DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> >  };
> > @@ -50,6 +52,7 @@ static void insn_set_free(struct bpf_map *map)
> >  {
> >         struct bpf_insn_set *insn_set = cast_insn_set(map);
> >
> > +       kfree(insn_set->unique_offsets);
> >         kfree(insn_set->ips);
> >         bpf_map_area_free(insn_set);
> >  }
> > @@ -69,6 +72,12 @@ static struct bpf_map *insn_set_alloc(union bpf_attr *attr)
> >                 return ERR_PTR(-ENOMEM);
> >         }
> >
> > +       insn_set->unique_offsets = kzalloc(sizeof(long) * attr->max_entries, GFP_KERNEL);
> > +       if (!insn_set->unique_offsets) {
> > +               insn_set_free(&insn_set->map);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> >         bpf_map_init_from_attr(&insn_set->map, attr);
> >
> >         mutex_init(&insn_set->state_mutex);
> > @@ -165,10 +174,25 @@ static u64 insn_set_mem_usage(const struct bpf_map *map)
> >         u64 extra_size = 0;
> >
> >         extra_size += sizeof(long) * map->max_entries; /* insn_set->ips */
> > +       extra_size += 4 * map->max_entries; /* insn_set->unique_offsets */
> >
> >         return insn_set_alloc_size(map->max_entries) + extra_size;
> >  }
> >
> > +static int insn_set_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> > +{
> > +       struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +
> > +       /* for now, just reject all such loads */
> > +       if (off > 0)
> > +               return -EINVAL;
> 
> I bet it's easy enough to make llvm generate such code,
> so this needs to be supported sooner than later.

Ok, makes sense, will add to the list for the next version.

> > +
> > +       /* from BPF's point of view, this map is a jump table */
> > +       *imm = (unsigned long)insn_set->ips;
> > +
> > +       return 0;
> > +}
> > +
> >  BTF_ID_LIST_SINGLE(insn_set_btf_ids, struct, bpf_insn_set)
> >
> >  const struct bpf_map_ops insn_set_map_ops = {
> > @@ -181,6 +205,7 @@ const struct bpf_map_ops insn_set_map_ops = {
> >         .map_delete_elem = insn_set_delete_elem,
> >         .map_check_btf = insn_set_check_btf,
> >         .map_mem_usage = insn_set_mem_usage,
> > +       .map_direct_value_addr = insn_set_map_direct_value_addr,
> >         .map_btf_id = &insn_set_btf_ids[0],
> >  };
> >
> > @@ -217,6 +242,37 @@ static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
> >         return true;
> >  }
> >
> > +static int cmp_unique_offsets(const void *a, const void *b)
> > +{
> > +       return *(u32 *)a - *(u32 *)b;
> > +}
> > +
> > +static int bpf_insn_set_init_unique_offsets(struct bpf_insn_set *insn_set)
> > +{
> > +       u32 cnt = insn_set->map.max_entries, ucnt = 1;
> > +       u32 **off = insn_set->unique_offsets;
> > +       int i;
> > +
> > +       /* [0,3,2,4,6,5,5,5,1,1,0,0] */
> > +       for (i = 0; i < cnt; i++)
> > +               off[i] = &insn_set->ptrs[i].user_value.xlated_off;
> > +
> > +       /* [0,0,0,1,1,2,3,4,5,5,5,6] */
> > +       sort(off, cnt, sizeof(off[0]), cmp_unique_offsets, NULL);
> > +
> > +       /*
> > +        * [0,1,2,3,4,5,6,x,x,x,x,x]
> > +        *  \.........../
> > +        *    unique_offsets_cnt
> > +        */
> > +       for (i = 1; i < cnt; i++)
> > +               if (*off[i] != *off[ucnt-1])
> > +                       off[ucnt++] = off[i];
> > +
> > +       insn_set->unique_offsets_cnt = ucnt;
> > +       return 0;
> > +}
> 
> 
> Why bother with this optimization in the kernel?
> Shouldn't libbpf give unique already?

So, in a _running_ program, an array may contain non-unique elements.
Example:

  switch(i) {
  case 0:
   ...
  case 2:
   ...
  case 4:
   ...
  default:
   ...
  }

LLVM will generate a jump table of size 6 , check that i <= 5,
and point slots 1 and 3 with a jump to "default".

But during the verification, this is not needed to take all the
branches, thus the "unique" array in kernel.

> > +
> >  int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
> >  {
> >         struct bpf_insn_set *insn_set = cast_insn_set(map);
> > @@ -247,7 +303,10 @@ int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
> >         for (i = 0; i < map->max_entries; i++)
> >                 insn_set->ptrs[i].user_value.xlated_off = insn_set->ptrs[i].orig_xlated_off;
> >
> > -       return 0;
> > +       /*
> > +        * Prepare a set of unique offsets
> > +        */
> > +       return bpf_insn_set_init_unique_offsets(insn_set);
> >  }
> >
> >  int bpf_insn_set_ready(struct bpf_map *map)
> > @@ -336,3 +395,13 @@ void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> >                 }
> >         }
> >  }
> > +
> > +int bpf_insn_set_iter_xlated_offset(struct bpf_map *map, u32 iter_no)
> > +{
> > +       struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +
> > +       if (iter_no >= insn_set->unique_offsets_cnt)
> > +               return -ENOENT;
> > +
> > +       return *insn_set->unique_offsets[iter_no];
> > +}
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index e536a34a32c8..058f5f463b74 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1706,6 +1706,8 @@ bool bpf_opcode_in_insntable(u8 code)
> >                 [BPF_LD | BPF_IND | BPF_B] = true,
> >                 [BPF_LD | BPF_IND | BPF_H] = true,
> >                 [BPF_LD | BPF_IND | BPF_W] = true,
> > +               [BPF_JMP | BPF_JA | BPF_X] = true,
> > +               [BPF_JMP32 | BPF_JA | BPF_X] = true,
> >                 [BPF_JMP | BPF_JCOND] = true,
> >         };
> >  #undef BPF_INSN_3_TBL
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8ac9a0b5af53..fba553f844f1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
> >  static void specialize_kfunc(struct bpf_verifier_env *env,
> >                              u32 func_id, u16 offset, unsigned long *addr);
> >  static bool is_trusted_reg(const struct bpf_reg_state *reg);
> > +static int add_used_map(struct bpf_verifier_env *env, int fd, struct bpf_map **map_ptr);
> >
> >  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> >  {
> > @@ -5648,6 +5649,19 @@ static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
> >         return 0;
> >  }
> >
> > +static int check_insn_set_mem_access(struct bpf_verifier_env *env,
> > +                                    const struct bpf_map *map,
> > +                                    int off, int size, u32 mem_size)
> > +{
> > +       if ((off < 0) || (off % sizeof(long)) || (off/sizeof(long) >= map->max_entries))
> > +               return -EACCES;
> > +
> > +       if (mem_size != 8 || size != 8)
> > +               return -EACCES;
> > +
> > +       return 0;
> > +}
> > +
> >  /* check read/write into memory region (e.g., map value, ringbuf sample, etc) */
> >  static int __check_mem_access(struct bpf_verifier_env *env, int regno,
> >                               int off, int size, u32 mem_size,
> > @@ -5666,6 +5680,10 @@ static int __check_mem_access(struct bpf_verifier_env *env, int regno,
> >                         mem_size, off, size);
> >                 break;
> >         case PTR_TO_MAP_VALUE:
> > +               if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_SET &&
> > +                   check_insn_set_mem_access(env, reg->map_ptr, off, size, mem_size) == 0)
> > +                       return 0;
> 
> Don't hack it like this.
> If you're reusing PTR_TO_MAP_VALUE for this then set mem_size correctly
> early on.

Ok, I will see how to make this less hacky. I believe I added the
exception not becase the mem_size, but becaus of "off" (currently,
direct memory access is only allowed to maps of size 1).

> >                 verbose(env, "invalid access to map value, value_size=%d off=%d size=%d\n",
> >                         mem_size, off, size);
> >                 break;
> > @@ -7713,12 +7731,18 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
> >                              bool allow_trust_mismatch);
> >
> > +static bool map_is_insn_set(struct bpf_map *map)
> > +{
> > +       return map && map->map_type == BPF_MAP_TYPE_INSN_SET;
> > +}
> > +
> >  static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                           bool strict_alignment_once, bool is_ldsx,
> >                           bool allow_trust_mismatch, const char *ctx)
> >  {
> >         struct bpf_reg_state *regs = cur_regs(env);
> >         enum bpf_reg_type src_reg_type;
> > +       struct bpf_map *map_ptr_copy = NULL;
> >         int err;
> >
> >         /* check src operand */
> > @@ -7733,6 +7757,9 @@ static int /(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >
> >         src_reg_type = regs[insn->src_reg].type;
> >
> > +       if (src_reg_type == PTR_TO_MAP_VALUE && map_is_insn_set(regs[insn->src_reg].map_ptr))
> > +               map_ptr_copy = regs[insn->src_reg].map_ptr;
> > +
> >         /* Check if (src_reg + off) is readable. The state of dst_reg will be
> >          * updated by this call.
> >          */
> > @@ -7743,6 +7770,13 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                                        allow_trust_mismatch);
> >         err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
> >
> > +       if (map_ptr_copy) {
> > +               regs[insn->dst_reg].type = PTR_TO_INSN;
> > +               regs[insn->dst_reg].map_ptr = map_ptr_copy;
> > +               regs[insn->dst_reg].min_index = regs[insn->src_reg].min_index;
> > +               regs[insn->dst_reg].max_index = regs[insn->src_reg].max_index;
> > +       }
> 
> Not pretty. Let's add another argument to map_direct_value_addr()
> and pass regs[value_regno] to it,
> so that callback can set the reg.type correctly instead
> of defaulting to SCALAR_VALUE like it does today.
> 
> Then the callback for insn_array will set it to PTR_TO_INSN.

But here we're dereferencing it. We need to have different types for

    rx = ldimm64 map # "ptr_to_map_value"
    rx *= rx         # PTR_TO_INSN

this is required to 1) make sure that it actually was dereferenced
and 2) that it was only dereferenced once.

Or is this a different comment?

> 
> > +
> >         return err;
> >  }
> >
> > @@ -15296,6 +15330,22 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
> >                 return 0;
> >         }
> >
> > +       if (dst_reg->type == PTR_TO_MAP_VALUE && map_is_insn_set(dst_reg->map_ptr)) {
> > +               if (opcode != BPF_ADD) {
> > +                       verbose(env, "Operation %s on ptr to instruction set map is prohibited\n",
> > +                               bpf_alu_string[opcode >> 4]);
> > +                       return -EACCES;
> > +               }
> > +               src_reg = &regs[insn->src_reg];
> > +               if (src_reg->type != SCALAR_VALUE) {
> > +                       verbose(env, "Adding non-scalar R%d to an instruction ptr is prohibited\n",
> > +                               insn->src_reg);
> > +                       return -EACCES;
> > +               }
> 
> Here you need to check src_reg tnum to make sure it 8-byte aligned
> or I'm missing where it's done.
> 
> > +               dst_reg->min_index = src_reg->umin_value / sizeof(long);
> > +               dst_reg->max_index = src_reg->umax_value / sizeof(long);
> 
> Why bother consuming memory with these two fields if they are derivative ?

I've added it becase it becase when we do

    gotox rx

rx will actually have src_reg->umin_value=0, src_reg->umax_value=~0,
becase rx is "pointing to instruction", thus can actually have random
address. The proper umin/umax were correct before the rx was
dereferenced from a PTR_TO_MAP_VALUE.

As this patch is to be refactored, I will try to see if this can be
avoided to waste more memory.

> > +       }
> > +
> >         if (dst_reg->type != SCALAR_VALUE)
> >                 ptr_reg = dst_reg;
> >
> > @@ -16797,6 +16847,11 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >                         __mark_reg_unknown(env, dst_reg);
> >                         return 0;
> >                 }
> > +               if (map->map_type == BPF_MAP_TYPE_INSN_SET) {
> > +                       dst_reg->type = PTR_TO_MAP_VALUE;
> > +                       dst_reg->off = aux->map_off;
> > +                       return 0;
> > +               }
> >                 dst_reg->type = PTR_TO_MAP_VALUE;
> >                 dst_reg->off = aux->map_off;
> >                 WARN_ON_ONCE(map->max_entries != 1);
> 
> Instead of copy pasting two lines, make WARN conditional.

Ok.

> > @@ -17552,6 +17607,62 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> >         return 0;
> >  }
> >
> > +#define SET_HIGH(STATE, LAST)  STATE = (STATE & 0xffffU) | ((LAST) << 16)
> > +#define GET_HIGH(STATE)                ((u16)((STATE) >> 16))
> > +
> > +static int gotox_sanity_check(struct bpf_verifier_env *env, int from, int to)
> > +{
> > +       /* TBD: check that to belongs to the same BPF function && whatever else */
> > +
> > +       return 0;
> > +}
> > +
> > +static int push_goto_x_edge(int t, struct bpf_verifier_env *env, struct bpf_map *map)
> > +{
> > +       int *insn_stack = env->cfg.insn_stack;
> > +       int *insn_state = env->cfg.insn_state;
> > +       u16 prev_edge = GET_HIGH(insn_state[t]);
> > +       int err;
> > +       int w;
> > +
> > +       w = bpf_insn_set_iter_xlated_offset(map, prev_edge);
> 
> I don't quite understand the algorithm.
> Pls expand the comment.

When we reach a `gotox rx`, rx can contain a pointer to instruction
loaded from a map M. The verifier needs to try to jump to any
possible location in the map.  The bpf_insn_set_iter_xlated_offset()
helps to start from M[0] and iterate over the unique elements in that
set R defined above.

> Also insn_successors() needs to support gotox as well.
> It's used by liveness and by scc.

Oh, sure, thanks.

> > +       if (w == -ENOENT)
> > +               return DONE_EXPLORING;
> > +       else if (w < 0)
> > +               return w;
> > +
> > +       err = gotox_sanity_check(env, t, w);
> > +       if (err)
> > +               return err;
> > +
> > +       mark_prune_point(env, t);
> > +
> > +       if (env->cfg.cur_stack >= env->prog->len)
> > +               return -E2BIG;
> > +       insn_stack[env->cfg.cur_stack++] = w;
> > +
> > +       mark_jmp_point(env, w);
> > +
> > +       SET_HIGH(insn_state[t], prev_edge + 1);
> > +       return KEEP_EXPLORING;
> > +}
> > +
> > +/* "conditional jump with N edges" */
> > +static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd)
> > +{
> > +       struct bpf_map *map;
> > +       int ret;
> > +
> > +       ret = add_used_map(env, fd, &map);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (map->map_type != BPF_MAP_TYPE_INSN_SET)
> > +               return -EINVAL;
> > +
> > +       return push_goto_x_edge(t, env, map);
> > +}
> > +
> >  /* Visits the instruction at index t and returns one of the following:
> >   *  < 0 - an error occurred
> >   *  DONE_EXPLORING - the instruction was fully explored
> > @@ -17642,8 +17753,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
> >                 return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
> >
> >         case BPF_JA:
> > -               if (BPF_SRC(insn->code) != BPF_K)
> > -                       return -EINVAL;
> > +               if (BPF_SRC(insn->code) == BPF_X)
> > +                       return visit_goto_x_insn(t, env, insn->imm);
> 
> There should be a check somewhere that checks that insn->imm ==
> insn_array_map_fd is the same map during the main pass of the
> verifier.

The check is below.

> >
> >                 if (BPF_CLASS(insn->code) == BPF_JMP)
> >                         off = insn->off;
> > @@ -17674,6 +17785,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
> >         }
> >  }
> >
> > +static bool insn_is_gotox(struct bpf_insn *insn)
> > +{
> > +       return BPF_CLASS(insn->code) == BPF_JMP &&
> > +              BPF_OP(insn->code) == BPF_JA &&
> > +              BPF_SRC(insn->code) == BPF_X;
> > +}
> > +
> >  /* non-recursive depth-first-search to detect loops in BPF program
> >   * loop == back-edge in directed graph
> >   */
> > @@ -18786,11 +18904,22 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
> >                               struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
> >  {
> >         u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
> > +       struct bpf_insn *insn;
> >         u16 i;
> >
> >         if (old->callback_depth > cur->callback_depth)
> >                 return false;
> >
> > +       insn = &env->prog->insnsi[insn_idx];
> > +       if (insn_is_gotox(insn)) {
> 
> func_states_equal() shouldn't look back into insn_idx.
> It should use what's in bpf_func_state.

Ok, thanks.

> 
> > +               struct bpf_reg_state *old_dst = &old->regs[insn->dst_reg];
> > +               struct bpf_reg_state *cur_dst = &cur->regs[insn->dst_reg];
> > +
> > +               if (old_dst->min_index != cur_dst->min_index ||
> > +                   old_dst->max_index != cur_dst->max_index)
> > +                       return false;
> 
> Doesn't look right. It should properly compare two PTR_TO_INSN.

Ok, will fix.

> > +       }
> > +
> >         for (i = 0; i < MAX_BPF_REG; i++)
> >                 if (((1 << i) & live_regs) &&
> >                     !regsafe(env, &old->regs[i], &cur->regs[i],
> > @@ -19654,6 +19783,55 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >         return PROCESS_BPF_EXIT;
> >  }
> >
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > +{
> > +       struct bpf_verifier_state *other_branch;
> > +       struct bpf_reg_state *dst_reg;
> > +       struct bpf_map *map;
> > +       int xoff;
> > +       int err;
> > +       u32 i;
> > +
> > +       /* this map should already have been added */
> > +       err = add_used_map(env, insn->imm, &map);
> 
> Found that check.
> Let's not abuse add_used_map() for that.
> Remember map pointer during resolve_pseudo_ldimm64()
> in insn_aux_data for gotox insn.
> No need to call add_used_map() so late.

Yes, thanks, I wanted initially to add smth like find_used_map()
(thus the commen above), but saving in aux is better.

> > +       if (err < 0)
> > +               return err;
> > +
> > +       dst_reg = reg_state(env, insn->dst_reg);
> > +       if (dst_reg->type != PTR_TO_INSN) {
> > +               verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
> > +                               insn->dst_reg, dst_reg->type);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (dst_reg->map_ptr != map) {
> 
> and here it would compare dst_reg->map_ptr with env->used_maps[aux->map_index]

Yes, thanks.

> > +               verbose(env, "BPF_JA|BPF_X R%d was loaded from map id=%u, expected id=%u\n",
> > +                               insn->dst_reg, dst_reg->map_ptr->id, map->id);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (dst_reg->max_index >= map->max_entries)
> > +               return -EINVAL;
> > +
> > +       for (i = dst_reg->min_index + 1; i <= dst_reg->max_index; i++) {
> > +               xoff = bpf_insn_set_iter_xlated_offset(map, i);
> > +               if (xoff == -ENOENT)
> > +                       break;
> > +               if (xoff < 0)
> > +                       return xoff;
> > +
> > +               other_branch = push_stack(env, xoff, env->insn_idx, false);
> > +               if (!other_branch)
> > +                       return -EFAULT;
> > +       }
> > +
> > +       env->insn_idx = bpf_insn_set_iter_xlated_offset(map, dst_reg->min_index);
> > +       if (env->insn_idx < 0)
> > +               return env->insn_idx;
> > +
> > +       return 0;
> > +}
> > +
> >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >  {
> >         int err;
> > @@ -19756,6 +19934,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >
> >                         mark_reg_scratched(env, BPF_REG_0);
> >                 } else if (opcode == BPF_JA) {
> > +                       if (BPF_SRC(insn->code) == BPF_X)
> > +                               return check_indirect_jump(env, insn);
> > +
> >                         if (BPF_SRC(insn->code) != BPF_K ||
> >                             insn->src_reg != BPF_REG_0 ||
> >                             insn->dst_reg != BPF_REG_0 ||
> > @@ -20243,6 +20424,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                 case BPF_MAP_TYPE_QUEUE:
> >                 case BPF_MAP_TYPE_STACK:
> >                 case BPF_MAP_TYPE_ARENA:
> > +               case BPF_MAP_TYPE_INSN_SET:
> >                         break;
> >                 default:
> >                         verbose(env,
> > @@ -20330,10 +20512,11 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
> >   * its index.
> >   * Returns <0 on error, or >= 0 index, on success.
> >   */
> > -static int add_used_map(struct bpf_verifier_env *env, int fd)
> > +static int add_used_map(struct bpf_verifier_env *env, int fd, struct bpf_map **map_ptr)
> 
> no need.

Thanks, will revert.

> >  {
> >         struct bpf_map *map;
> >         CLASS(fd, f)(fd);
> > +       int ret;
> >
> >         map = __bpf_map_get(f);
> >         if (IS_ERR(map)) {
> > @@ -20341,7 +20524,10 @@ static int add_used_map(struct bpf_verifier_env *env, int fd)
> >                 return PTR_ERR(map);
> >         }
> >
> > -       return __add_used_map(env, map);
> > +       ret = __add_used_map(env, map);
> > +       if (ret >= 0 && map_ptr)
> > +               *map_ptr = map;
> > +       return ret;
> >  }
> >
> >  /* find and rewrite pseudo imm in ld_imm64 instructions:
> > @@ -20435,7 +20621,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
> >                                 break;
> >                         }
> >
> > -                       map_idx = add_used_map(env, fd);
> > +                       map_idx = add_used_map(env, fd, NULL);
> >                         if (map_idx < 0)
> >                                 return map_idx;
> >                         map = env->used_maps[map_idx];
> > @@ -21459,6 +21645,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
> >                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
> >                 func[i]->aux->arena = prog->aux->arena;
> > +               func[i]->aux->used_maps = env->used_maps;
> > +               func[i]->aux->used_map_cnt = env->used_map_cnt;
> >                 num_exentries = 0;
> >                 insn = func[i]->insnsi;
> >                 for (j = 0; j < func[i]->len; j++, insn++) {
> > --
> > 2.34.1
> >

