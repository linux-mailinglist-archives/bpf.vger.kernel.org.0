Return-Path: <bpf+bounces-17494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9380E717
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA6282B94
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7BE5812D;
	Tue, 12 Dec 2023 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NtMqXUEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D8D5
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:09:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1e116f2072so1105855266b.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702372190; x=1702976990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AxuhzJDaqiozcr9ogD+ICUzwng0WsNv4cVcMaeKZKvg=;
        b=NtMqXUEwxcn1cKR+oQC+grILGrWawmDC5zSKHa1vrnt5PMyzzp9d2BiF+wkuMwAAWU
         2n3rKjHB/3TKazdopXiFWJ7kZ7ts/ZrAoLznWBv4kl74XVeBHhUbZBSIJ/Pip80+Bh1v
         htJrrLlvXxsvUhCCCBmSb0H1TPNIMRf6LcLyyzGB26QIEIZjhSO6APzDf52pnDI+zQ6v
         2fAFsf5J+HMEPKHFlCtLbfr7E8PuHkPN2VuqTdX6DE74/dhfgpuQa3gW5i+kvHXOqejU
         BkYHl2N4DizQOxw7Vzkke49tkUbFR0j/TUGZ/O3O1nkrTnmfMqwVZsyLTQkmfDKEVNmZ
         Psog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372190; x=1702976990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxuhzJDaqiozcr9ogD+ICUzwng0WsNv4cVcMaeKZKvg=;
        b=q1ykJlB8h1XGXmYaxyu1pKSggcSVRmu3j2SRgT96tv3DOX5v+bzAD+emSpxtC7BCOm
         nqGAEBqrupjqaou91HILNvd6ClIASWiL2naunkT5eWz/8/rjuOv/jO0idGWzMqPUpuoj
         vrnBwfU318+KQExmTtSFnhim1oLZ5UwlU4eAIIeoRQJKnLyCN14nUdxWumZpsnZmK/Qm
         iN5GKNalubiHi6AG79yOvqoJTShqE7nL+Q2ZqeaZxGGmfABg978TFbSnKwwdTHZ+LLu6
         tdEC0D5rHRqRMihO08rPffixWN8miF70iDSMvXuR7WRT7VL4H+9QqakgL3AXdZyhPy5A
         Ufyg==
X-Gm-Message-State: AOJu0YxbeuRnpf52a/KKZ95G6+5TlYQuLdc0kj/C0xNrDDIMDXzKROIm
	jASr9BZ0+zZSSLpqZCLHhMjNDQ==
X-Google-Smtp-Source: AGHT+IGsqFZ4GLBPOZ/9k+uuE7jSaiBU0jpY5wN6cJGczb6CZ9aO7kAWroeDbvH3rTKUOPMAtcE5wg==
X-Received: by 2002:a17:906:101e:b0:a01:ae9a:c1d3 with SMTP id 30-20020a170906101e00b00a01ae9ac1d3mr6155162ejm.11.1702372190308;
        Tue, 12 Dec 2023 01:09:50 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id hu19-20020a170907a09300b00a0ad580e1b6sm5886622ejc.48.2023.12.12.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:09:49 -0800 (PST)
Date: Tue, 12 Dec 2023 09:06:23 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Message-ID: <ZXgijyliXqG6/CR7@zh-lab-node-5>
References: <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
 <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
 <CAADnVQLvduKOxNWgruC0TUOzxVVg-Bp8RButfN9nWgQ_DdCC2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvduKOxNWgruC0TUOzxVVg-Bp8RButfN9nWgQ_DdCC2A@mail.gmail.com>

On Mon, Dec 11, 2023 at 11:08:59AM -0800, Alexei Starovoitov wrote:
> On Mon, Dec 11, 2023 at 9:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> >
> > This looks for me that two bits aren't enough, and the third is
> > required, as the second bit seems to be overloaded:
> >
> >   * bit 1 indicates that this is a "JA_MAYBE"
> >   * bit 2 indicates a jump or nop (i.e., the current state)
> >
> > However, we also need another bit which indicates what to do with the
> > instruction when we issue [an abstract] command
> >
> >   flip_branch_on_or_off(branch, 0/1)
> >
> > Without this information (and in the absense of external meta-data on
> > how to patch the branch) we can't determine what a given (BPF, not
> > jitted) program currently does. For example, if we issue
> >
> >   flip_branch_on_or_off(branch, 0)
> >
> > then we can't reflect this in the xlated program by setting the second
> > bit to jmp/off. Again, JITted program is fine, but it will be
> > desynchronized from xlated in term of logic (some instructions will be
> > mapped as NOP -> x86_JUMP, others as NOP -> x86_NOP).
> 
> Not following the need for the 3rd bit.
> The 2nd bit is not only the initial state, but the current state too.
> 
> when user space does static_branch_enable it will set the 2nd bit to 1
> (if it wasn't set) and will text_poke_bp the code.
> xlated will be always in sync with JITed.
> No ambiguity.

Ok, from BPF arch perspective this can work with two bits (not for
practical purposes though, IMO, see my next e-mail). On the lowest
level we have this magic jump instruction

  JA[SRC_REG=1] +OFF    # jits to a NOP
  JA[SRC_REG=3] +OFF    # jits to a JUMP

Then we have a primitive kfunc

  static_branch_set(prog, branch, bool on)

Which sets the second bit and pokes jitted code.  (Maybe it doesn't
set the actual bit in xlated due to read-only memory, as you've
mentioned below.) You're right that this is unambiguous.

> An annoying part is that bpf insn stream is read only, so we cannot
> really write that 2nd bit. We can virtually write it.
> Seeing nop or jmp in JITed code would mean the bit is 0 or 1.
> So xlated dump will report it.

If we can poke jitted x86 code, then we might poke prog->insnsi in the
same way as well? Besides, on architectures where static keys may be
of interest we don't use interpreter, so maybe this is ok to poke
insnsi (and make it rw) after all?

> Separately the kernel doesn't have static_branch_switch/flip command.
> It's only enable or disable. I think it's better to keep it the same way.

