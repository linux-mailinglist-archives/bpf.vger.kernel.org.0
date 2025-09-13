Return-Path: <bpf+bounces-68292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F1B562C0
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A025638C3
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C624A069;
	Sat, 13 Sep 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6/ybEKl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E1211C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791987; cv=none; b=IAigAj94baDS6MXFMSU1XYyd1mP36SjQ3MTBloWLYUAMbxigMTOQdv9S38XGMrZRT5kZ+xMPQBMVtu4ebX7N5/1c4IrPwqSeulHVpjErqhsXlE5VJxzQ22aNi2ZLVqslzmAUxmBwi4beaNxSyWdn/HtmkfNTUWeTab2TOgYHIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791987; c=relaxed/simple;
	bh=N8N+RJ+ObaB+kCreEt0gCTYULid9eKCxwBpEZHr15TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9DzpJRYOBFHSLltgh9tDpApNa+p08gSDq5rpeUNN+9YsurEYbb8x4+MfrDS9yFi4iUX/UgA6DpIqJLPkTUn2zniWHOYOLEzlW4oepXe4nuDhLn+QPerrCE3Nit6uQYyaTAU5EnsjkkbAOCyMiNxaX1x+ARLlGh4y8B71kE65EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6/ybEKl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dce6eed889so2650067f8f.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757791984; x=1758396784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sizvjSt25eLM8aHMOZhFO98ZZhlegOQj3g/A7OA4RLI=;
        b=Y6/ybEKlhuR3wBD6iHKNQEgs8wc7ANTho52uD8eWhWf0ndIvzS1irgG1mWtqb8+7S3
         f3kvhpXwcOMrFqaGC8zZawEd2NtY4dehZ38xiyYcoBXRdNk8hnyvZ3L32gNlmd78DNSX
         As0VchccoBzKW/IW/7tNdfK891p2692qpPtcfbBf7U7B+X5s+5/mE7Zv+ZuZx3xrgia5
         udu0lFfTgn31U0C57WROlb/wzAWh/5PtrBKi8Zn9gdNp4DOeEVw0R0U8CLHG+YISLbNA
         7sQjWDwD7DQuMLDy7GdghhiPI+RiK27L3CvhWADmuUzMwYHxLKu202Sutk1MzN3GaCM+
         Jo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757791984; x=1758396784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sizvjSt25eLM8aHMOZhFO98ZZhlegOQj3g/A7OA4RLI=;
        b=OcmjrsLu60FeQzz3nOPIRlWmJp/PhEStk3+q6ZEObSInDJLAArZ1dHFH+FR2OYXmM2
         FD6pQQbsI16wNJ2adnmap1/lTqj2tAj/y4XkpI1ifWgI0uDytSsymZNMzbBfWgp/yBes
         OOEw9EilDkRrE1tJf9veb8HjmOTET3ucQYd9LaYIGeE2cU7H+uD6dSye4j33vhXV4UW0
         AC4pyLquUFQIWq36mk52/aLBwBUelDd3vITmUWvYql2cMsPXvkOAGh+bgeBZOLMbWmDb
         ChrtaOSOupkfCyixwhEzZW5zvwUrolUWMfjZzltkdGftLToCa5RI2HRo85mu5/6tjTMo
         zjIA==
X-Gm-Message-State: AOJu0Yz3GxfELGxzE7O3LSKWOcX6p7jYVhYpclvli/wDF1AmwoYFWGMM
	M6ktWZSOwzpe02j58ek6UrNnNuxDhLpo5ch3KtaAlSScFXl83ft7jvKU
X-Gm-Gg: ASbGncv7MpaEMPfGOLyTHg8iwmzt3uNXTfUl1HPJcgsQ3ZoKywjEO7OBC+SWbwHGAmN
	ruE6GH+L0sYSNEyUbNT81I4yUHGUwqVanBVACL6NAhsOpFH3SMtdRWs7kU+I8voNXwhHWSeeAtE
	UHx1Fo0Hrfl++Y2soNOfBgH3XqbHzz0Qj0rNeuWVu2lGR64c4FLnVYg3soXFApPH6An9S6FVLEd
	N3bgA5K8wkhoL1Qpx9K57igTySb64GP7yvCpkUZa3DdFGFdAGyho+ah8QJOywVRHEogE3WHgZx+
	o0Ljm29NZamLjjeVP/cMLIDPkZS9fXyeTBv2EzLSUkA3V28OsJHPa9QKoarf+l0ZML0mlWIW0Ny
	5nlKxhIgCRo54eZUSGiG40N6d/KwF5ZPbIRDEJMq0qqw=
X-Google-Smtp-Source: AGHT+IGJUYyPsPa9+6YQGtWgJ+bX8QvYuK7R2tJc9vrr0Osf09V7TSe+2nc1QaKfCkRJi2VjBaU+6g==
X-Received: by 2002:a05:6000:4009:b0:3e7:42e5:63dd with SMTP id ffacd0b85a97d-3e765a044c5mr7054833f8f.56.1757791983671;
        Sat, 13 Sep 2025 12:33:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm5231032f8f.48.2025.09.13.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:02 -0700 (PDT)
Date: Sat, 13 Sep 2025 19:38:58 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aMXIUnU7QY3mWtFy@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-11-a.s.protopopov@gmail.com>
 <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaZxoz+=_uycH=6rO3U548TF7K8v5zKukDSJjWUgEXSSw@mail.gmail.com>

On 25/08/20 05:20PM, Andrii Nakryiko wrote:
> On Sat, Aug 16, 2025 at 11:02 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > For v5 instruction set, LLVM now is allowed to generate indirect
> > jumps for switch statements and for 'goto *rX' assembly. Every such a
> > jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
> > -Sr ...`):
> >
> >        0:       r2 = 0x0 ll
> >                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
> >
> > Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
> >
> >     Symbol table:
> >        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
> >
> > The -bpf-min-jump-table-entries llvm option may be used to control
> > the minimal size of a switch which will be converted to an indirect
> > jumps.
> >
> > The code generated by LLVM for a switch will look, approximately,
> > like this:
> >
> >     0: rX <- jump_table_x[i]
> >     2: rX <<= 3
> >     3: gotox *rX
> >
> > Right now there is no robust way to associate the jump with the
> > corresponding map, so libbpf doesn't insert map file descriptor
> > inside the gotox instruction.
> 

[...]

> 
> > +               err = bpf_map_update_elem(map_fd, &i, &val, 0);
> > +               if (err) {
> > +                       close(map_fd);
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       err = bpf_map_freeze(map_fd);
> > +       if (err) {
> > +               close(map_fd);
> > +               return err;
> > +       }
> > +
> > +       return map_fd;
> > +}
> > +
> > +static int subprog_insn_off(struct bpf_program *prog, int insn_idx)
> > +{
> > +       int i;
> > +
> > +       for (i = prog->subprog_cnt - 1; i >= 0; i--)
> > +               if (insn_idx >= prog->subprog_offset[i])
> > +                       return prog->subprog_offset[i] - prog->subprog_sec_offst[i];
> 
> I feel like this whole subprog_offset and subprog_sec_offst shouldn't
> be even necessary.
> 
> Check bpf_object__relocate(). I'm not sure why this was done this way
> that we go across all programs in phases, doing code relocation first,
> then data relocation later (across all programs again). I might be
> forgetting some details, but if we change this to do all the
> relocation for each program one at a time, then all this information
> that you explicitly record is already recorded in
> subprog->sub_insn_off and you can use it until we start relocating
> another entry-point program. Can you give it a try?
> 
> So basically the structure will be:
> 
> for (i = 0; i < obj->nr_programs; i++) {
>    prog = ...
>    if (prog_is_subprog(...))
>        continue;
>    if (!prog->autoload)
>        continue;
>    bpf_object__relocate_calls()
>    /* that exception callback handling */
>    bpf_object__relocate_data()
>    bpf_program_fixup_func_info()
> }
> 
> It feels like this should work because there cannot be
> interdependencies between entry programs.

So turns out that the reason why it is separate is given in the commit which
introduced this separation, see b12688267280b223256c8cf912486577d3adce25
(So I kept this part of my patch the same in v2.)

[...]

