Return-Path: <bpf+bounces-73111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4AC238A1
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3F7D4E5F14
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A79F32937C;
	Fri, 31 Oct 2025 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyj/WAxb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228D25DAFF
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895472; cv=none; b=i/HRuDnLvq0EuN1Aa9gTUMZ/2IAffK26WznIGkx/RVy9EsH2QynvsdjT4FUJk6SjYWhIiXI3kAhezvLvuAd4k67fel/s2vdC+rC0JYTar1ecYGDiB/BQamFpkBOV6CHJFnd1vsAg6BXhFw7L6gh0R7PHmroROAGMm///E2i+8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895472; c=relaxed/simple;
	bh=RQAsL7W4SrBCWD8Zvq4GpLme9aTC7gxkasfO3q6a1Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVvcn3dJFhR8gknebZdJF7a+V4fL5eYwMjGbWdhvFYalpYaRstM2DbYWhiUOA/1rZDdQUx99wRYZZ+qqmWzSSzLGa4S+F+aJ3RZD1tIWNHUn6SEmhEKhAWvEN2ZnhNnneWvQZbd5Zo/0aCj+kQteJ3nmpPSr+8cHzuk/jxB5bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyj/WAxb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429b85c3880so1730777f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761895469; x=1762500269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cRIIXxAqGe0HFnekqUVOYnuhj86EWw8qI/psy6BMl5Q=;
        b=Gyj/WAxb1obKZvXSMBjh6BAKiL9zdo/ZxInx4voLVnhGCxgk4+CsjazFpZ24blU2b2
         q9o7WYWyEwCw15sjAKUmJtS7hZcbkjNIdCtJgqdbntxxI4pzBmZNTY2BlK3LChHsr/ij
         pl8ww7pYuhAyjopeJjG8PIm4VRZWZN1Z2PPwi0Bu8NFxelQoimm3EPYuFTp6Jc/GJjwU
         38i8J37jtundFVZ9cZh01MNS5We2zHE7irctbev1KzMHqsaYS24/HMS2a2z0d7qNyvnL
         27pPQtTCO2hCKRVRTfXGPuXE2I2Rsvhrza6AkwlDefpHLebpDg6hhPUtEsF46xVFlhh9
         qcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761895469; x=1762500269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRIIXxAqGe0HFnekqUVOYnuhj86EWw8qI/psy6BMl5Q=;
        b=YAx+GRFiE76Bbajih6qY5G8Fv0w+ZD12mQ8qcex8VlTNqnfqOGebGkPROyyWBXeH2X
         QaCVW2ck1R9vkSP4a3NpZS0R9qhF8nOSZp2NfCYupqxZXVbCJbzvo4eH5jn3l9ZQBrZ1
         KIxMbuu1Juecji3isC132QvvzFIeBFmWvyN6AXDmAWOajukxMJEezZSQRNVsTocou4bg
         1DHkJ24ebECF0A2+8zr5h+VVPFUJNxPTmJFl9uTSDFvWxZywiCJ59hm7rukggYqsSoKp
         q4AoNHavgz/M4N1kvAJ4pqR5NySnwPMmFWorBp9DRA7mlyGgQV9jgRwnWqBf3+013ZBG
         KvhQ==
X-Gm-Message-State: AOJu0YxwJ596/9Z7qRKZCMnYMPYDfLbpy2sWeybrdjBwfe7ss99z8U67
	R6KYUfIxigdCJkEJOgONAaw4mKDOoqoNjIDHZib9KCk2ktwr5gJTixApZ2i/BA==
X-Gm-Gg: ASbGnctvwHeUMOKZQbB1TWz8GYakoAqeiHTVeCZeJoi0IpmHyMumrq+ucdIYaxpd3tk
	ib5QUMyI+hznigiqzumzgbf6Hq0h6mao84F44m41udMbwBVSnbBQNliwCFL49rVTobzEWoPhq7h
	RhGU6ApNb0htuB9YP1l1nNFGVGW0nGE9T4tQKaV6KJykourxtMI7HMWSPyuzRCOYIARMnfSoZSw
	FPF232JkD6zPwoCWFEEXJyE2rFCDiUqatJalxzaxJFuucGZgp0UFAx6iSPeODmF8LZk8MEF+UWF
	a7lqZL7RWi4shTeSzOlqLiEpHuzvN8H0JsV6dFwLNYUe63Ld1pqB9bvFydxhitQDVW0O/zcHbdi
	bwm3Pn14I4lAYXLHZSFSYChijuDStCHT27agj/6QLAXmjTl+FEL+D609gjOoGrnbBh+sFVeWX7R
	C/ZdYsBw0ixg==
X-Google-Smtp-Source: AGHT+IEBZMiKw9VTjiyJn1rSTUnskM4ddSz3pK3iSqVbxQ4CFM4PzIS/5pXQDOMYifJQd+7jiH0kQg==
X-Received: by 2002:a5d:5e8e:0:b0:429:bc93:9da8 with SMTP id ffacd0b85a97d-429bd6a65f8mr2096584f8f.32.1761895469014;
        Fri, 31 Oct 2025 00:24:29 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e03d0sm1999933f8f.26.2025.10.31.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:24:28 -0700 (PDT)
Date: Fri, 31 Oct 2025 07:30:56 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v8 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQRlsLUgKtEMdUPO@mail.gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-9-a.s.protopopov@gmail.com>
 <CAEf4BzZok5fsX4BjhrwNB5CNQGVFCRM+M2TFhHu3x98bC1pOkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZok5fsX4BjhrwNB5CNQGVFCRM+M2TFhHu3x98bC1pOkg@mail.gmail.com>

On 25/10/30 02:00PM, Andrii Nakryiko wrote:
> On Tue, Oct 28, 2025 at 7:15 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > For v4 instruction set LLVM is allowed to generate indirect jumps for
> > switch statements and for 'goto *rX' assembly. Every such a jump will
> > be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
> >
> >        0:       r2 = 0x0 ll
> >                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> >
> > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> >
> >     Symbol table:
> >        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
> >
> > The -bpf-min-jump-table-entries llvm option may be used to control the
> > minimal size of a switch which will be converted to an indirect jumps.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c          | 249 +++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/libbpf_internal.h |   4 +
> >  tools/lib/bpf/libbpf_probes.c   |   4 +
> >  tools/lib/bpf/linker.c          |   9 +-
> >  4 files changed, 263 insertions(+), 3 deletions(-)
> >
> 
> [...]
> 
> > @@ -738,6 +758,16 @@ struct bpf_object {
> >         void *arena_data;
> >         size_t arena_data_sz;
> >
> > +       void *jumptables_data;
> > +       size_t jumptables_data_sz;
> > +
> > +       struct {
> > +               struct bpf_program *prog;
> 
> It bit us many times already when we stored direct bpf_program/bpf_map
> pointers inside bpf_object (because depending on when those pointers
> are taken they might be invalidated when we add another prog/map). I'm
> too lazy to figure out if this can be a problem for this particular
> case, but I think it would be more consistent and safer to store
> program index and just look up struct bpf_program * (it's just an
> array, quick and easy).
> 
> Consider that for a follow up, if this patch set lands as is.

Ok, thanks, I will take a look.

> > +               int sym_off;
> > +               int fd;
> > +       } *jumptable_maps;
> > +       size_t jumptable_map_cnt;
> > +
> >         struct kern_feature_cache *feat_cache;
> >         char *token_path;
> >         int token_fd;
> 
> [...]
> 
> > +static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off, int map_fd)
> > +{
> > +       size_t new_cnt = obj->jumptable_map_cnt + 1;
> > +       size_t size = sizeof(obj->jumptable_maps[0]);
> > +       void *tmp;
> > +
> > +       tmp = libbpf_reallocarray(obj->jumptable_maps, new_cnt, size);
> > +       if (!tmp)
> > +               return -ENOMEM;
> > +
> > +       obj->jumptable_maps = tmp;
> > +       obj->jumptable_maps[new_cnt - 1].prog = prog;
> > +       obj->jumptable_maps[new_cnt - 1].sym_off = sym_off;
> > +       obj->jumptable_maps[new_cnt - 1].fd = map_fd;
> > +       obj->jumptable_map_cnt = new_cnt;
> 
> nit: I'd go with `size_t cnt = obj->jumptable_map_cnt`, use `cnt + 1`
> for reallocarray, and just `cnt` everywhere else. Then just canonical
> `obj->jumptable_map_cnt++;` at the end.
> 
> minor, but if you get a chance, consider this

will do

> > +
> > +       return 0;
> > +}
> > +
> > +static int find_subprog_idx(struct bpf_program *prog, int insn_idx)
> > +{
> > +       int i;
> > +
> > +       for (i = prog->subprog_cnt - 1; i >= 0; i--) {
> > +               if (insn_idx >= prog->subprogs[i].sub_insn_off)
> > +                       return i;
> > +       }
> > +
> > +       return -1;
> > +}
> > +
> > +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
> > +{
> > +       const __u32 jt_entry_size = 8;
> > +       int sym_off = relo->sym_off;
> > +       int jt_size = relo->sym_size;
> > +       __u32 max_entries = jt_size / jt_entry_size;
> > +       __u32 value_size = sizeof(struct bpf_insn_array_value);
> > +       struct bpf_insn_array_value val = {};
> > +       int subprog_idx;
> > +       int map_fd, err;
> > +       __u64 insn_off;
> > +       __u64 *jt;
> > +       __u32 i;
> > +
> > +       map_fd = find_jt_map(obj, prog, sym_off);
> > +       if (map_fd >= 0)
> > +               return map_fd;
> > +
> > +       if (sym_off % jt_entry_size) {
> > +               pr_warn("jumptable start %d should be multiple of %u\n",
> > +                       sym_off, jt_entry_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (jt_size % jt_entry_size) {
> > +               pr_warn("jumptable size %d should be multiple of %u\n",
> > +                       jt_size, jt_entry_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> > +                               4, value_size, max_entries, NULL);
> > +       if (map_fd < 0)
> > +               return map_fd;
> > +
> > +       if (!obj->jumptables_data) {
> > +               pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> 
> I commend you for using `map '.jumptables':` logging prefix  to follow
> libbpf-wide consistent map-related logging style. I'd just like to
> commend you on all other pr_warn in this function, if you know what I
> mean ;)

Yep, will do

> > +               err = -EINVAL;
> > +               goto err_close;
> > +       }
> > +       if (sym_off + jt_size > obj->jumptables_data_sz) {
> > +               pr_warn("jumptables_data size is %zd, trying to access %d\n",
> > +                       obj->jumptables_data_sz, sym_off + jt_size);
> > +               err = -EINVAL;
> > +               goto err_close;
> > +       }
> > +
> > +       subprog_idx = -1; /* main program */
> > +       if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
> > +               pr_warn("invalid instruction index %d\n", relo->insn_idx);
> > +               err = -EINVAL;
> > +               goto err_close;
> > +       }
> > +       if (prog->subprogs)
> > +               subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> > +
> > +       jt = (__u64 *)(obj->jumptables_data + sym_off);
> > +       for (i = 0; i < max_entries; i++) {
> > +               /*
> > +                * The offset should be made to be relative to the beginning of
> > +                * the main function, not the subfunction.
> > +                */
> > +               insn_off = jt[i]/sizeof(struct bpf_insn);
> > +               if (subprog_idx >= 0) {
> > +                       insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> > +                       insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> > +               } else {
> > +                       insn_off -= prog->sec_insn_off;
> > +               }
> > +
> > +               /*
> > +                * LLVM-generated jump tables contain u64 records, however
> > +                * should contain values that fit in u32.
> > +                */
> > +               if (insn_off > UINT32_MAX) {
> > +                       pr_warn("invalid jump table value 0x%llx at offset %d\n",
> 
> we will most probably get compiler warnings about %llx (same for
> %lld/%llu, of course) and using __u64 (because %l or %ll for __u64 is
> platform dependent, if I'm not mistaken). In most (all?) other places
> we explicitly cast to (long long) as a mitigation.

Ok, thanks, I will fix this

> > +                               jt[i], sym_off + i);
> > +                       err = -EINVAL;
> > +                       goto err_close;
> > +               }
> > +
> > +               val.orig_off = insn_off;
> > +               err = bpf_map_update_elem(map_fd, &i, &val, 0);
> > +               if (err)
> > +                       goto err_close;
> > +       }
> > +
> > +       err = bpf_map_freeze(map_fd);
> > +       if (err)
> > +               goto err_close;
> > +
> > +       err = add_jt_map(obj, prog, sym_off, map_fd);
> > +       if (err)
> > +               goto err_close;
> > +
> > +       return map_fd;
> > +
> > +err_close:
> > +       close(map_fd);
> > +       return err;
> > +}
> > +
> >  /* Relocate data references within program code:
> >   *  - map references;
> >   *  - global variable references;
> > @@ -6235,6 +6434,20 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> >                 case RELO_CORE:
> >                         /* will be handled by bpf_program_record_relos() */
> >                         break;
> > +               case RELO_INSN_ARRAY: {
> > +                       int map_fd;
> > +
> > +                       map_fd = create_jt_map(obj, prog, relo);
> > +                       if (map_fd < 0) {
> > +                               pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n",
> > +                                               prog->name, i, relo->sym_off);
> 
> nit: make sure to align second row with first arg in the first row

ok

> > +                               return map_fd;
> > +                       }
> > +                       insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
> > +                       insn->imm = map_fd;
> > +                       insn->off = 0;
> > +               }
> > +                       break;
> >                 default:
> >                         pr_warn("prog '%s': relo #%d: bad relo type %d\n",
> >                                 prog->name, i, relo->type);
> > @@ -6432,6 +6645,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
> >         return 0;
> >  }
> >
> > +static int save_subprog_offsets(struct bpf_program *main_prog, struct bpf_program *subprog)
> > +{
> > +       size_t size = sizeof(main_prog->subprogs[0]);
> > +       int new_cnt = main_prog->subprog_cnt + 1;
> > +       void *tmp;
> > +
> > +       tmp = libbpf_reallocarray(main_prog->subprogs, new_cnt, size);
> > +       if (!tmp)
> > +               return -ENOMEM;
> > +
> > +       main_prog->subprogs = tmp;
> > +       main_prog->subprogs[new_cnt - 1].sec_insn_off = subprog->sec_insn_off;
> > +       main_prog->subprogs[new_cnt - 1].sub_insn_off = subprog->sub_insn_off;
> > +       main_prog->subprog_cnt = new_cnt;
> > +
> 
> ditto about new_cnt, cnt would be nicer and shorter, imo

ok

> > +       return 0;
> > +}
> > +
> >  static int
> >  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
> >                                 struct bpf_program *subprog)
> > @@ -6461,6 +6692,15 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
> >         err = append_subprog_relos(main_prog, subprog);
> >         if (err)
> >                 return err;
> > +
> > +       /* Save subprogram offsets */
> 
> yeah, that's what "save_subprog_offset" literally implies, what value
> does this comment provide?

will remove, thanks

> > +       err = save_subprog_offsets(main_prog, subprog);
> > +       if (err) {
> > +               pr_warn("prog '%s': failed to add subprog offsets: %s\n",
> > +                       main_prog->name, errstr(err));
> > +               return err;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -9228,6 +9468,13 @@ void bpf_object__close(struct bpf_object *obj)
> >
> >         zfree(&obj->arena_data);
> >
> > +       zfree(&obj->jumptables_data);
> > +       obj->jumptables_data_sz = 0;
> > +
> > +       for (i = 0; i < obj->jumptable_map_cnt; i++)
> > +               close(obj->jumptable_maps[i].fd);
> > +       zfree(&obj->jumptable_maps);
> > +
> >         free(obj);
> >  }
> >
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 35b2527bedec..93bc39bd1307 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -74,6 +74,10 @@
> >  #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
> >  #endif
> >
> > +#ifndef JUMPTABLES_SEC
> 
> do we expect this definition to come from somewhere else as well?

No, just copy-pasted from the other defines above. I will remove it.

> > +#define JUMPTABLES_SEC ".jumptables"
> > +#endif
> > +
> >  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> >         ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> >  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
> 
> [...]

