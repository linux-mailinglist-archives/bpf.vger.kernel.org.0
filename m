Return-Path: <bpf+bounces-66557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17CB36F8F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687947B4864
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6FF3081BC;
	Tue, 26 Aug 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk+5RUR/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B021CA1C
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224563; cv=none; b=iUlw2DMj159oIDifQwn1PSPRvE9vhyqgvxShczm1dOLXJhqYq8hUEF0kLg7xNy1v20Tr3k0B2nYJMGKOaWm4MVWSaLYAFuf2eT9lpaORmi0boPpIPnU2bn44VBvjcgRwDkr0sxL8vx2Aphr+Aoh2WqWAcXFAGgGAcJ5SzN3oBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224563; c=relaxed/simple;
	bh=zHqD1tnfOus6RrMhPlhcngpbfo+Lu4WSuJ/IJhrCWHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvqLVN/VoWUsUZMwdDy2yKB5VBCJldLrpJEDWM/cp7Rt3Vy3OzvLlY7OyffyW0OlhDqqVs1u2yziGoryq4tSIsOD/0RH4TcHHnkGuBzehqdAOM2+fGpL05fCgf0HTINvN/hwpYSQoIVIY13aY1EXciH9Xim6jidNG+ietuRF6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk+5RUR/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so48111115e9.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756224560; x=1756829360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvGuvisTAsNwEdG7fcgY8wL1+KWNZ8cH4WX2PTFNj3w=;
        b=Lk+5RUR/uEmFIqhFiyL2J3rD6xQubwUSLA9LukSXWkguX3SD355R9MkAgGeXLq/crn
         7IGbwFANWoTcP1hDZ0jYvxRZM9avGCPJ9MHTL2CNLPb8vJXM3AlAg9CAZYkeegIillgH
         iR6EtaSoyU2ekSQ53NESFC8wq6YsxfhvzhnnMUJxY9BOv1MoVKrnP2i4TkMOETPq1tpY
         Co/uuz15qB9SDD2S7JuGkh37SQKTKrnuO6PKB1aW2lGAecm8Hx5HuR3EWr22U+64tAtI
         e3U00fvjyLHNpNxZQ0TWmbgd/rVeYbp3Dh4rg45mYCzV1WRmbHUBYlxvxS734qu2XYMH
         J6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224560; x=1756829360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvGuvisTAsNwEdG7fcgY8wL1+KWNZ8cH4WX2PTFNj3w=;
        b=BwBww3X34D89xe79f7/UIHK4SD/J4zH5OUxFGhHJEpmClqWa8iRSrBfkDz3O0uYDaY
         F6xfZ5nJvH6bRvhokVidcyRgzluE71cl9Hfdk5D88c1//adFXj97/W1Go89squnqvBCY
         cCDfYJUc/clbW2fWqMUQMgzIPfIE3mjNW58P0daKdkTzhBdCAIlgAIsPwTgNPTNj5yWn
         9xfjEeEiBbXVnaxsHQmceyW0+cn87Ec87CzXs7i7ONw9Do8PgxZwr+JjZX6gX2Bpz4Dx
         v4chLqyyLChwuKUiZnGTV2eEOODjGC4qUa6zfFnApaBfXjJTnS6mBP/n1fp9YIKDb+Cc
         b/vA==
X-Gm-Message-State: AOJu0Yx6BELtrTA693/4SWWQ0OKVXJXUXbjI9lxIZTOHv1gfDOakhtgr
	mosNuuwnt84VugHB2JCKobDhJqjqs5R0JsLzzBRHn6UgN5ZuQ3YOmprm
X-Gm-Gg: ASbGnct5zLU3lzjMXE0cSosJ9QgwBJXfoAGiG9SHJaj5eOyag6CE+cLxlyvdT6QhjSy
	t38Z5mU6nH2ka6Yl0G/Mrc/co3sI0ywc06fuBv+XoIu8b3swBUFk4CL4MlDy0Ydig623Xm5CFVs
	JHiTF86LPKrOVmQX0xcy0zR/on7jp7NHdZW597y78t50mECfGjzY+atBzIxeuTEiNmuVWVHwclw
	dXgYxLCWiP/jzauS5tEiX5m3dtiLIMp6sdyzEP2kUC/w7pqYhRmgDngYbDEp2Hfyve6ZUoqF0qF
	rEg1zEjdXxrtUPlJ+gZSvneJ7+ZaMMP2CGEzqvMu6ayRbHsjzuGHU0/W+AUAPOXaUWF4R6ti+Xz
	x2CVdVA8tafBAE2O94ovtLZD3xwcAQ307GQ==
X-Google-Smtp-Source: AGHT+IFogSDQYYWZq3hiTS6e2AAompH7CAy18yL924Hjii6dlavlWRYCwJt8u7B8gtMFrCDbN3DDRg==
X-Received: by 2002:a05:600c:1d23:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45b648f7ddcmr42186875e9.22.1756224559408;
        Tue, 26 Aug 2025 09:09:19 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1483sm16642600f8f.50.2025.08.26.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:09:18 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:15:25 +0000
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
Message-ID: <aK3dnUhX2aYw6//s@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com>
 <69306a9742679ae8439fab4b415e3ca86683e61d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69306a9742679ae8439fab4b415e3ca86683e61d.camel@gmail.com>

On 25/08/25 05:06PM, Eduard Zingerman wrote:
> On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fe4fc5438678..a5f04544c09c 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [...]
> 
> > @@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
> >  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
> >  }
> >  
> > +static int create_jt_map(struct bpf_object *obj, int off, int size, int adjust_off)
> > +{
> > +	static union bpf_attr attr = {
> > +		.map_type = BPF_MAP_TYPE_INSN_ARRAY,
> > +		.key_size = 4,
> > +		.value_size = sizeof(struct bpf_insn_array_value),
> > +		.max_entries = 0,
> > +	};
> > +	struct bpf_insn_array_value val = {};
> > +	int map_fd;
> > +	int err;
> > +	__u32 i;
> > +	__u32 *jt;
> > +
> > +	attr.max_entries = size / 8;
> > +
> > +	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> > +	if (map_fd < 0)
> > +		return map_fd;
> > +
> > +	jt = (__u32 *)(obj->efile.jumptables_data.d_buf + off);
>   	     ^^^^^^^^^
>     Jump table entries are u64 now, e.g. see test case:
>     https://github.com/llvm/llvm-project/blob/39dc3c41e459e6c847c1e45e7e93c53aaf74c1de/llvm/test/CodeGen/BPF/jump_table_swith_stmt.ll#L68
> 
> [...]

Yes, thanks, I will change it to u64. (Just in case, it works now
because the code happens to work properly on little-endian: it uses
jt[2*i] for i-th element.)

> > @@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
> 
> [...]
> 
> >  static int
> >  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
> > -				struct bpf_program *subprog)
> > +		struct bpf_program *subprog)
> >  {
> > -       struct bpf_insn *insns;
> > -       size_t new_cnt;
> > -       int err;
> > +	struct bpf_insn *insns;
> > +	size_t new_cnt;
> > +	int err;
> 
> Could you please extract spaces vs tabs fix for this function as a separate commit?
> Just to make diff easier to read.
> 
> [...]

Sure, sorry, I haven't noticed it.

