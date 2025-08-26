Return-Path: <bpf+bounces-66573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F3B370B4
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E58E7B31EB
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6D34DCD8;
	Tue, 26 Aug 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b51njneY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6D1DE8BE
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226710; cv=none; b=R9/gfCv6vxIxZYHY4tONNytgq9EsIouH3mDWROu4KXuRHWRdssS8qRXDS++f2E50G2bdSQ5A/zLsaqKvGtJZ9lwMk3bHrqcstQE4KbL5slp4zdKNy/Yl2qgbHR8MkxYyRfC9kfCPWPkrO5YHDm9pqLTwNdZy+MEqm/Il8f8GN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226710; c=relaxed/simple;
	bh=K67HHsqS10w7CWM+gHTiC8Jpf+p9ff8KSlpyrAyBy0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHAbYrzvcrngPgxJD5b/awaDKmdEw5xIb7GVT4Oi5Xa+8/mfPNoZwqaW7q329R8l2rRx+UkoaP9Gegxsvx5HnyNapaHulO2JG1ZBhDnbN4NjV0kBHQi4gYVzEhwg6qgXNxgWr/48J/HwR6lJIAgqZPXBHkEBlYpPmKV45srB7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b51njneY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso3192632f8f.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226707; x=1756831507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kw5AXMWs0JlpJCreWdITnB7vfBuVng0JfHQfyw1bfzs=;
        b=b51njneY5+qlZwb15Us5DzqSRANkrvX0/GSSia3Oq6OUFaZ/RgPANNNMoP2mLDuibb
         ALEP52SRCrH67RHVQa5/szDYJ8r+LAY5yklTUp//tjtyhnbzW8/kr1zcRPZZZYEdtJet
         KYFKK70mJ5Ao4Vya5UZMbe0O128tVZFlnxIb/4PtrGUrl1YSEiokUHuuxlFBPaJBsGKT
         18WnQqqg31jM70q+nwq3onZOaXqg9JI6qLEDAfUGXc86xdJQ179qx2dQfFijF/kPOdUP
         yVIqvg4TIdocI2OtXhQV3yL+ojBqgDmgAXciRzy/S5XhD7bpPoAVcdwNuFqaPJHrYBKL
         Wvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226707; x=1756831507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw5AXMWs0JlpJCreWdITnB7vfBuVng0JfHQfyw1bfzs=;
        b=FiCn95VVo99kV0n86Idcm7GJtAEIsgpXqMEdxpmpkTBzSYzkH0t2FpffPwC20x0v4f
         BvblT4mzsIfYipTbmp//zI4S7MpZNRMIMKdGp0VCPeUXNyeVw5snX3ExfopjveV3DeQz
         0U1SJ0O5hZrtySPBu/oPci0i4QPRi0VQyFmVKzzQocQVDvIUQ3AV4yG/8fnSW4O2bK3f
         7MIpCI35mcQHbku2f54FSwBI6lgGp8I9sO2rAOLjOhDae1hkWWZUK0Lv0lkB4cOeBVYz
         FFx95QFn8lsvrApo9TeHvDkS1Z+oiJe91TYTTAoo4Bj6BzCxYeMYOfZYMsYRdLDUXVB1
         yAwA==
X-Gm-Message-State: AOJu0YyLUlqD+zDk/yyxn/c7T9jaRilzBUqU1q8gbntoFC31vZbWxrfS
	vJiOxQHVpxIMsIUPROvsB/UY4nVEpwpQt1fqG3GeTBVc6xKpPOUqRz6NvtS5YA==
X-Gm-Gg: ASbGncskBITFwj348duV7q7ZbO2mkRa3jpA1eHGrhLCU2332tKJt62kyn2XAkqzRhJ4
	ayRtmZHGtR1bBTwlYFfEwoRqtILc3XHdObAKKCrS3kmV1W+4Okkjq7ot1LnmlokYVeJB36sStT/
	nWZn6xkOj/PSfB8rDlaMhYMXO+JfGl8NJfjb/QtX5gEr8WEOZ6saiw8xZ8YzB2WJgb94Iif3f62
	w1TLS7tQEesb+zu1kY4dry2GuABbA9DnUl4WHWnJ5KHOgwf5zZ7MGL4PWQb1abSGH/bPwj7yJop
	VnsRwtAH0x8/yuqwEDCPzl1UMOQjal7gP+ZXvFn1GVjbjwHYd8Yx7e1S1JqPz0owxwZnd+DCLi/
	lwlwnuuCo79tumr9LY2ewBSwu1/u9qxIpBA==
X-Google-Smtp-Source: AGHT+IGgPRJmEcfAW9xLqZFuXfiKsw+aMpMean7ijywVxqKnjpqeZNLrwAJoeeqBk/neJXPH5ZqR4A==
X-Received: by 2002:a05:6000:381:b0:3c4:2a56:14db with SMTP id ffacd0b85a97d-3c5dd8aa758mr13568699f8f.41.1756226706792;
        Tue, 26 Aug 2025 09:45:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc18f762b1sm1175778f8f.65.2025.08.26.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:45:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:51:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aK3mAGopUQX6T2z4@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com>
 <69306a9742679ae8439fab4b415e3ca86683e61d.camel@gmail.com>
 <aK3dnUhX2aYw6//s@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK3dnUhX2aYw6//s@mail.gmail.com>

On 25/08/26 04:15PM, Anton Protopopov wrote:
> On 25/08/25 05:06PM, Eduard Zingerman wrote:
> > On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> > 
> > [...]
> > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index fe4fc5438678..a5f04544c09c 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > 
> > [...]
> > 
> > > @@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
> > >  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
> > >  }
> > >  
> > > +static int create_jt_map(struct bpf_object *obj, int off, int size, int adjust_off)
> > > +{
> > > +	static union bpf_attr attr = {
> > > +		.map_type = BPF_MAP_TYPE_INSN_ARRAY,
> > > +		.key_size = 4,
> > > +		.value_size = sizeof(struct bpf_insn_array_value),
> > > +		.max_entries = 0,
> > > +	};
> > > +	struct bpf_insn_array_value val = {};
> > > +	int map_fd;
> > > +	int err;
> > > +	__u32 i;
> > > +	__u32 *jt;
> > > +
> > > +	attr.max_entries = size / 8;
> > > +
> > > +	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> > > +	if (map_fd < 0)
> > > +		return map_fd;
> > > +
> > > +	jt = (__u32 *)(obj->efile.jumptables_data.d_buf + off);
> >   	     ^^^^^^^^^
> >     Jump table entries are u64 now, e.g. see test case:
> >     https://github.com/llvm/llvm-project/blob/39dc3c41e459e6c847c1e45e7e93c53aaf74c1de/llvm/test/CodeGen/BPF/jump_table_swith_stmt.ll#L68
> > 
> > [...]
> 
> Yes, thanks, I will change it to u64. (Just in case, it works now
> because the code happens to work properly on little-endian: it uses
> jt[2*i] for i-th element.)
> 
> > > @@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
> > 
> > [...]
> > 
> > >  static int
> > >  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
> > > -				struct bpf_program *subprog)
> > > +		struct bpf_program *subprog)
> > >  {
> > > -       struct bpf_insn *insns;
> > > -       size_t new_cnt;
> > > -       int err;
> > > +	struct bpf_insn *insns;
> > > +	size_t new_cnt;
> > > +	int err;
> > 
> > Could you please extract spaces vs tabs fix for this function as a separate commit?
> > Just to make diff easier to read.
> > 
> > [...]
> 
> Sure, sorry, I haven't noticed it.

Just in case, this chunk is

@@ -6418,6 +6524,17 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
        err = append_subprog_relos(main_prog, subprog);
        if (err)
                return err;
+
+       /* Save subprogram offsets */
+       if (main_prog->subprog_cnt == ARRAY_SIZE(main_prog->subprog_sec_off)) {
+               pr_warn("prog '%s': number of subprogs exceeds %zu\n",
+                       main_prog->name, ARRAY_SIZE(main_prog->subprog_sec_off));
+               return -E2BIG;
+       }
+       main_prog->subprog_sec_off[main_prog->subprog_cnt] = subprog->sec_insn_off;
+       main_prog->subprog_off[main_prog->subprog_cnt] = subprog->sub_insn_off;
+       main_prog->subprog_cnt += 1;
+
        return 0;
 }

(In v2 it will either change to realloc vs. static allocation, or disappear.)

