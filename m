Return-Path: <bpf+bounces-21499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC184DF79
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12241C26B3D
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA46F075;
	Thu,  8 Feb 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="RpawQ/8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE96F09C
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390680; cv=none; b=a1Z6Sv085QJvbw6pJhtJN2iYOH8rrDA2y3H7+fDZ0GXTX8wtyCyAI4piDIMv6XxTt4Ua0E9lK4WaOp3CWg2HLvRskhnmoCSmU/J+DDI4Iynp4IXRE9stiZCV4EEd6RCunObuTKK1jEEOmp3O2Kf2HMSM0Zu5Yf7hn1jSNxGs9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390680; c=relaxed/simple;
	bh=SfsTIEYF5nz9Cb0cxRhXXrzdoVThlSmayIKOjaXCU0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soMbm0Ge6EfkW3dZ99Jr85pmuDvBKsA3/Nq8HriIiu2KBvOs6dqY4Smz6lSi7Na+/uP8yqRN2+PSsPmekGT96Ejzz1HY/9b2Fo95AlNDoaOMeOrsIGOn4R24wLyf4GbasFr0pFOhzRD2dv+YfTmDCs1nBKlrYxy5YRbhvhLFdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=RpawQ/8o; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so1178402f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 03:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1707390677; x=1707995477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLungcIawGR5RKZ1xMpgR9j3eOWGEPnwLuycn02votM=;
        b=RpawQ/8oT8gls/l3m+ceJKysw+6JB9qLq27xuNPKInyfFMyQA7a51OUYasfKZViDEK
         OFUT1Cci5OWxs64oRbRg9+xsmrFDhIqim4MFoGyvHKLPhzXg45sZ/Vw3pS9InLTYcrhG
         1rKBzrVPv+02mRaU3FScNsoSBu3SS9c2fHy+vJaA92bifZfUj3L/krhvjovNRkBRX3hQ
         Q/WjU55SQmwEAS3f9dZBeaBy5nHLZ6ov+LnXjO6ZjzZvOXduDl8PJZnYiImwpIAipCiP
         wBLOsynW/yXJ+0jhDaL9S3BqG6fWpHP6ZDks4OB9NlrWxG0f4lpCDwpgNBAC8CFtW5Dv
         lHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390677; x=1707995477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLungcIawGR5RKZ1xMpgR9j3eOWGEPnwLuycn02votM=;
        b=KQ3KDdfjU7JJYEz56+H9Y2ZF34lcR3FyNGXBoT91alFw8vU/54KwpIRUO560rMY1bZ
         p+OmmWX8ynLoGKEr/o80hPqBXnBZLR/my2/JKl/8tkgNrGWcz8p3Itid6X+EE8fJZQgR
         cnhsMtAhEAFlfCMplfWj4y0w2FBvjH22fFMiMQO8D71W5yGcncIIvnZvPe/FA/Rmt2lS
         Kv7ekMajVzO++Vwa7HXARAwerZVaHCtXaGZzgZkYJuX/gWswqVdwM+AT1IH+48upLPza
         rEDga7vNTKyduc16raQZSzoelqXA9G5Qf4McSddXlQ2iU00IJcEfcYkKomfArV2x03MH
         4RaA==
X-Forwarded-Encrypted: i=1; AJvYcCWbqlfMm/IdzQQpLppoSypX2iKBg3JlkN4pyZ2jbvZhI5hybCPtbJzNS0z+Ca6Hy68jXBUcVARiPJlyHEQEEQc0dsd6
X-Gm-Message-State: AOJu0YxXxFHlLwlaTXQYIDqBmeSwpgiv7Hk9w2CFWUS93eLaesCPaYer
	pNQIEN6tD9WPHbPC9NuMy8KJfDNasPeQMGAY1ncI5fPj/S26IhSH+tOud4ryY/yZEJVm+bHvHBo
	Qxro=
X-Google-Smtp-Source: AGHT+IHLglhKgGocjyASmxuHjCTXorDnJQviSvZscEK+ECro+sNP403bwwSTnK3jlrz/BP6zJBxqmQ==
X-Received: by 2002:a5d:4523:0:b0:33b:1ac8:aebe with SMTP id j3-20020a5d4523000000b0033b1ac8aebemr6662615wra.44.1707390676816;
        Thu, 08 Feb 2024 03:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHzJunG4+ST11GIvcMB8h3tle36jsYY7zgo/0qCBKRzD55dhnillPU8IXnK8FKdmWEK8JKx3zGXb2FdjWvZDqHJ3jV+v/wF6RQCYALFkgULtbvUFMuUQLR74c1RYCDgqsitzevdpgq5Q5cDCP9PKUC48y2HvkmIVgzoU+sweCCxpojhsOF4z4GGh3Xmm/ESnDRAs5XRA9zHBQ4BDASYoHjEqvfKQvSSjDReEGfNyItJCtD/OqDk1RRrlBwLAiCZEWpBBBeMeprzG4EnIn2UbBbEl1OQtEeMLOfz03t0Es7LI8ceymmW2w=
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe70e000000b0033b4b4a216asm3367529wrm.14.2024.02.08.03.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:11:16 -0800 (PST)
Date: Thu, 8 Feb 2024 11:05:10 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
Message-ID: <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
 <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
 <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>

On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 6, 2024 at 2:08 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > >         };
> > > >         /* an array of original indexes for all xlated instructions */
> > > >         u32 *orig_idx;
> > > > +       /* for every xlated instruction point to all generated jited
> > > > +        * instructions, if allocated
> > > > +        */
> > > > +       struct {
> > > > +               u32 off;        /* local offset in the jitted code */
> > > > +               u32 len;        /* the total len of generated jit code */
> > > > +       } *xlated_to_jit;
> > >
> > > Simply put Nack to this approach.
> > >
> > > Patches 2 and 3 add an extreme amount of memory overhead.
> > >
> > > As we discussed during office hours we need a "pointer to insn" concept
> > > aka "index on insn".
> > > The verifier would need to track that such things exist and adjust
> > > indices of insns when patching affects those indices.
> > >
> > > For every static branch there will be one such "pointer to insn".
> > > Different algorithms can be used to keep them correct.
> > > The simplest 'lets iterate over all such pointers and update them'
> > > during patch_insn() may even be ok to start.
> > >
> > > Such "pointer to insn" won't add any memory overhead.
> > > When patch+jit is done all such "pointer to insn" are fixed value.
> >
> > Ok, thanks for looking, this makes sense.
> 
> Before jumping into coding I think it would be good to discuss
> the design first.
> I'm thinking such "address of insn" will be similar to
> existing "address of subprog",
> which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> "address of insn" would be a bit more involved to track
> during JIT and likely trivial during insn patching,
> since we're already doing imm adjustment for pseudo_func.
> So that part of design is straightforward.
> Implementation in the kernel and libbpf can copy paste from pseudo_func too.

To implement the "primitive version" of static branches, where the
only API is `static_branch_update(xlated off, on/off)` the only
requirement is to build `xlated -> jitted` mapping (which is done
in JIT, after the verification). This can be done in a simplified
version of this patch, without xlated->orig mapping and with
xlated->jit mapping only done to gotol_or_nop instructions.

The "address of insn" appears when we want to provide a more
higher-level API when some object (in user-space or in kernel) keeps
track of one or more gotol_or_nop instructions so that after the
program load this controlling object has a list of xlated offsets.
But this would be a follow-up to the initial static branches patch.

> The question is whether such "address of insn" should be allowed
> in the data section. If so, we need to brainstorm how to
> do it cleanly.
> We had various hacks for similar things in the past. Like prog_array.
> Let's not repeat such mistakes.

So, data section is required for implementing jump tables? Like,
to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
corresponding "ptr to insn" object for every occurence of &&label,
which will be adjusted during verification.
Looks to me like this one doesn't require any more API than specifying
a list of &&label occurencies on program load.

For "static keys" though (a feature on top of this patch series) we
need to have access to the corresponding set of adjusted pointers.

Isn't this enough to add something like an array of

  struct insn_ptr {
      u32 type; /* LABEL, STATIC_BRANCH,... */
      u32 insn_off; /* original offset on load */
      union {
          struct label {...};
          struct st_branch { u32 key_id, ..};
      };
  };

to load attrs and then get the xlated list after the program is
loaded? Then no new maps/APIs are needed and this can be extended.

