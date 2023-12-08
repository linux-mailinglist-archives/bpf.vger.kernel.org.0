Return-Path: <bpf+bounces-17270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8080B061
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222A41C20CD8
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2285AB8C;
	Fri,  8 Dec 2023 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZfpmqKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903010D2
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 15:07:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso1291475e9.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 15:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076878; x=1702681678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HyPV6XZ4YyJ4bRDU9tR0HEAmWlHTUYd8TifnLSrujeo=;
        b=WZfpmqKEnKd84iBuJJXHa/4hyXD3kT+GXu9gz2fb3HdqJ3mtZ6+Tui+MJl5G6ACmVO
         6aHHxNH6y04wyMJyQFEqtawVfjJaN3uKX1zUvdp79rv+ouqhW+b9pvEH37v02KugbiEN
         1xcADb9WTfa8FKS4ONjgIsCFFubbVV8NLESWzi2L8maE8CEO/CrxJaIPY0ZcbB/Knfxp
         YJqlyYTLrJW0E17//oBydAU+UcNfTMKUSrNKtkkbnYu62fl/VbN5z4mDQa6PGAMXF20p
         l1rb0hnRaYskgjOf4q06ADSvpkaicmZWo+OdgMHzDEmgfjQLUoAvEfDEiQkXo7uAIhp6
         V96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076878; x=1702681678;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyPV6XZ4YyJ4bRDU9tR0HEAmWlHTUYd8TifnLSrujeo=;
        b=fHd6PKZnF6y3UhEFn1BSEsXmu6apNIVsmrEqLCYQUXxA+3jdS+um9KusCP0nYy/FAb
         CCUnNC+0QDzLrhWUhJm2cJLCYXHAxtJKYr0iBl+DH2TTXxh+Nn371rCEORMPVcbD0ja/
         h3OcyHnCZ/0b9xKizVDilZNOcRCm5iqbuehglEzDKdKX+cO+kPD3rqjYvidOALr9Jx/f
         JwKfPExuQB/HA0XP7H+8o9b1CWRkBBmPreadFCXNUyxC/7ZD52gIDcv67IIUNqtjjHT2
         5P7dgpXnXxzQdeW4Hj+EFrmEmEOfKVYdFSnvMjNRpA1OP6/ku98rHe8mp8IYU0Z0dpiS
         ulKA==
X-Gm-Message-State: AOJu0Yxz65Oydo9aRIZcbF2wKnd06u/CssSRBnW6z6eQ8rCGjzM8L4R0
	iwbfwCMxMMLXNgnRTMOkrbk=
X-Google-Smtp-Source: AGHT+IE9nrbzs6kwS5K4VOleorerpTvTrFcgGCAL9xtYULb1b8FAEiJl8y47m2ByLKWeoB/t2gawlg==
X-Received: by 2002:a1c:7207:0:b0:40c:914:d2cf with SMTP id n7-20020a1c7207000000b0040c0914d2cfmr213084wmc.134.1702076878035;
        Fri, 08 Dec 2023 15:07:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040c03c3289bsm4195079wmb.37.2023.12.08.15.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 15:07:57 -0800 (PST)
Message-ID: <8e75bdce562e1b27dcaa3a7ede74339d23c3fca9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Anton Protopopov
	 <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
	 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf
	 <bpf@vger.kernel.org>
Date: Sat, 09 Dec 2023 01:07:56 +0200
In-Reply-To: <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
	 <20231206141030.1478753-7-aspsk@isovalent.com>
	 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
	 <ZXNCB5sEendzNj6+@zh-lab-node-5>
	 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 14:04 -0800, Andrii Nakryiko wrote:
[...]
> > However, if this is the only API we provide, then this makes user's lif=
e
> > hard, as they will have to keep track of ids, and programs used, and
> > mapping from "global" id to local ids for each program (when multiple
> > programs use the same static key, which is desirable). If we keep the
> > higher-level "map API", then this simplifies user's life: on a program =
load
> > a user can send a list of (local_id -> map) mappings, and then toggle a=
ll
> > the branches controlled by "a [global] static key" by either
> >=20
> >     bpf(MAP_UPDATE_ELEM, map, value)
> >=20
> > or
> >=20
> >     kfunc bpf_static_key_set(map, value)
> >=20
> > whatever is more useful. (I think that keeping the bpf(2) userspace API=
 is
> > worth doing it, as otherwise this, again, makes life harder: users woul=
d
> > have to recompile/update iterator programs if new programs using a stat=
ic
> > key are added, etc.)
> >=20
> > Libbpf can simplify life even more by automatically allocating local id=
s
> > and passing mappings to kernel for a program from the
> > `bpf_static_branch_{unlikely,likely}(&map)`, so that users don't ever t=
hing
> > about this, if don't want to. Again, no relocations are required here.
> >=20
> > So, to summarize:
> >=20
> >   * A new instruction BPF_JA_CFG[ID,FLAGS,OFFSET] where ID is local to =
the
> >     program, FLAGS is 0/1 for normal/inverse branches
> >=20
>=20
> +1 for a dedicated instruction

fwiw, if relocations are used instead of IDs the new instruction does
not have to be a control flow. It might be a mov that sets target
register to a value that verifier treats as unknown. At runtime this
mov could be patched to assign different values. Granted it would be
three instructions:

  mov rax, 0;
  cmp rax, 0;
  je ...
 =20
instead of one, but I don't believe there would noticeable performance
difference. On a plus side: even simpler verification, likely/unlikely
for free, no need to track if branch is inverted.

