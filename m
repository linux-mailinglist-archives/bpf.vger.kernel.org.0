Return-Path: <bpf+bounces-17306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB980B1F6
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373B31C20A46
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D11386;
	Sat,  9 Dec 2023 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPYgmZPV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2B10F8
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:05:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so4690635e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 20:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702094737; x=1702699537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhjv9JVRcp4B0sN7iEHH+04vAhxB/t82MZ9unhbON6o=;
        b=DPYgmZPV8HQhvAUsxbk7jae1VRVTfkt4jchpO2yMuiK6Uxr711f6RjrpS0SSFM8KAX
         tiOZ5utj35b1w3mEVCQQ6ZPt7cZVqCgZEf/vyM6zZFv4sBen7G6gJsgYSuKVO+y7CitI
         v+dpVImzUU1s3hm6iozgCZS1jVTf7OOnIwWYCHzHc7x3Wnu7lg0QsZj9uVggqwR3rpIk
         pQxhwFSB1vp/PteS8uXXd7/5yoJoGynILah8DQWAvpvPRJhqsj/mmwX7A0uTT0h0m4W1
         bdNy2+qzWxEHkEsNoIEshBNFqBIx42ArBnkvyIbBnM1+dbb49WwGxsJCq5dgsyWsBaRF
         Hw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702094737; x=1702699537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhjv9JVRcp4B0sN7iEHH+04vAhxB/t82MZ9unhbON6o=;
        b=lYRGDvoerQEVNIyXbnFqzt1Uo08QZGYGSktY/0gUen7SrD1pZtww1TPCRcCJli3JZB
         6aq6vKLjCKDRxj/Ls6NrJg2L7gDOn0/WyJZXRt/0cqa/QOYKc7i0ZeqW0fNbG+fpQf3K
         672nfv0P1uC3dVpcGKSUke13wKAXPTh0rlD+gqXfaz59A3+9trLM0RUyTNzGnIanbr0G
         OZxeOZmobCNaO0s5N5Q54E5ubCek9KGMznELEhPlDVyyZpescH2sUcws7mxKeik/kiTs
         e5PIXg/V/q1KFlMaOdmwR7P1RBlEAHGPYBh4ooN8iMEbNEpCzlEw1XDX/vxYpLFI9Adq
         H+iA==
X-Gm-Message-State: AOJu0YxAaPddDLvC8QtgSnb28K064u01nZsi5J95JzmrTXysyxaRZJMb
	qylnWLrFJksO59aBBLxtvPT59QVhYDiGWvxqOWU=
X-Google-Smtp-Source: AGHT+IE9mwK4rL3PfbrUuf8k9cexhA/PxtojFLzK8qLUzZtKwHwKOxHGTRNgUJAfZn4cfINscxpvfwozqtxulk8b4kQ=
X-Received: by 2002:a05:600c:5026:b0:40c:7a1:b2db with SMTP id
 n38-20020a05600c502600b0040c07a1b2dbmr214200wmr.377.1702094736715; Fri, 08
 Dec 2023 20:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
In-Reply-To: <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 20:05:25 -0800
Message-ID: <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> I feel like embedding some sort of ID inside the instruction is very..
> unusual, shall we say?

yeah. no magic numbers inside insns pls.

I don't like JA_CFG name, since I read CFG as control flow graph,
while you probably meant CFG as configurable.
How about BPF_JA_OR_NOP ?
Then in combination with BPF_JMP or BPF_JMP32 modifier
the insn->off|imm will be used.
1st bit in src_reg can indicate the default action: nop or jmp.
In asm it may look like asm("goto_or_nop +5")

> 2. bpf_static_branch_{likely,unlikely}() macro accepts a reference to
> one such special global variable and and instructs compiler to emit
> relocation between static key variable and JMP_CFG instruction.
>
> Libbpf will properly update these relocations during static linking
> and subprog rearrangement, just like we do it for map references
> today.

Right. libbpf has RELO_SUBPROG_ADDR.
This new relo will be pretty much that.
And we have proper C syntax for taking an address: &&label.
The bpf_static_branch macro can use it.
We wanted to add it for a long time to support proper
switch() and jmp tables.

I don't like IDs and new map type for this.
The macro can have 'branch_name' as one of the arguments and
it will populate addresses of insns into "name.static_branch" section.

From libbpf pov it will be yet another global section which
is represented as a traditional bpf array of one element.
No extra handling on the libbpf side.

The question is how to represent the "address" of the insn.
I think 4 byte prog_id + 4 byte insn_idx will do.

Then bpf prog can pass such "address" into bpf_static_branch_enable/disable
kfunc.

The user space can iterate over 8 byte "addresses"
in that 1 element array map and call BPF_STATIC_BRANCH_ENABLE/DISABLE
syscall cmds.
We can have a helper on libbpf side for that.

I see no need to introduce a new map type just to reuse map_update_elem cmd=
.

