Return-Path: <bpf+bounces-30829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5A8D343F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251DA286B8F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123517B424;
	Wed, 29 May 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccRFyXOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1D15DBC0
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977686; cv=none; b=m96XxTn6PhueY/PnTLY59WlFF+dj8/WakvlASV+3LNBpJGAmY34PjYmjc8VmvZFah7IWBrvF9x7kn6C2KBvmqIBF6UytISLntXAiDDmybzrYNUTeeCYCEr8p9da8OxR9qQT7y4mZwIcdwZuhQgSJhH8pHH8bXbQ1AS7amVCNzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977686; c=relaxed/simple;
	bh=PnMMPJNlGCXjx2mAeDTcdg14RoBIyI4IbqcFjCZ6lbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8XXn5RpkR5DghuPup02U/c1lIybIZ8IwMSPPGjft2KlPzSp9pE4UXBUzfTo2jQnXjYIxT396ity+Z5zGylD3AdUHObn0zi9V4VGMq1U1Wi58dd0gQtppNGocntKJQLdhTR7Gm3qbVrLR4bFRRzntDmhWm4KJ4pDZow5xQhiLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccRFyXOU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0fso15021835ad.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716977684; x=1717582484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrqehvxEp888QKYB3uy52xIp9PtPU0fZhwgF6biSdJw=;
        b=ccRFyXOU0pkJOXMpk1J25hELZzT5wQkovUQwmYpRD3rqe8FbGPCy403HwgFH/LVOFd
         aot25kaLfNtIHlMxxDfGXskcGvE+bswGefunhFi73JKAgU13AXfxrGwa9Bjj+rfmD1d+
         XX01/Ydoyb+CYIe/ceOhAwud0yJSf3j6sJLc+6eEV2I8a2ShUIcK0TRCJ4SF7q/vPzSj
         CxUMgtdrtKzAIr0iAtX/JUqJFcaOOcBGKFzGfMJorI/AR7gi1HIktxrdGyF70qb+VhJL
         uj0TJ4mLBtzM1FZ7ftyLWzOqPv+OqPOn+6dCaxPzxfCbK3Fq0cCB2WWgJ1Re/qObiaUX
         BzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977684; x=1717582484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrqehvxEp888QKYB3uy52xIp9PtPU0fZhwgF6biSdJw=;
        b=eIR9VsL45zadvjCbqukP05eeW2iPH8w/wN9tnn/iM7TbodnlZoKCKwf+flMhbcTy4P
         Hk8fOIOJdWXXPqryU0Osd4adDnVUrBYhpTi65UI18xmwO1SrP0PPYt0tC8jBxA2K65BV
         XmpKimiJeBfkL31bx6oiT458TcP4+Pskp4NGsTrztjhJVEQOeA55/VsACYHsW5CCUJZ1
         y8D9Rn0WZuaPlcXP4EyUd5+7lji0Htrjl987Mu9oPzDANkSgu7PN+IJYCCUZX5dMe6OX
         lXXWpo3a9pt5h/n8F4JkKn6rLk8mYH/jHhEe4zqMtaIsxbUrN9df05vxyvPV+Mr75ZkK
         /5KA==
X-Gm-Message-State: AOJu0Yy62xWyrmsPCpLcDApIAm2P5w2TeIgaXSiZIJO2a3MaOiJyY6zk
	v/6VhVorFdlq1IdxxRPsSDM8XFUoK+mGoCH17PFEqpHOkByY2sh9Wv5Baw==
X-Google-Smtp-Source: AGHT+IF0SahXo4qKFx2T9xCUdIAQP0ZjZx5/vw7gQaYjIUAGb13LWq1+aq/M3Nq729lwLJp6aY2++w==
X-Received: by 2002:a17:903:234e:b0:1f4:56c2:a233 with SMTP id d9443c01a7336-1f456c2a747mr146507115ad.27.1716977684381;
        Wed, 29 May 2024 03:14:44 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9dd375sm95629965ad.288.2024.05.29.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:14:43 -0700 (PDT)
Message-ID: <62cf34743e05aacfc754fbb84a0e1eeba14e76d2.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Wed, 29 May 2024 03:14:43 -0700
In-Reply-To: <CAADnVQKczx0pNt7f8vYmknyg7cBxrr8raOpVKmxfnSjT3UO1OQ@mail.gmail.com>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
	 <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
	 <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
	 <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com>
	 <a8612f7bada4cf00d47e74c1507f9ad262e8a08f.camel@gmail.com>
	 <CAADnVQKczx0pNt7f8vYmknyg7cBxrr8raOpVKmxfnSjT3UO1OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 20:22 -0700, Alexei Starovoitov wrote:

[...]

>=20

> > However, below is an example where if comparison is BPF_X.
> > Note that I obfuscated constant 5 as a volatile variable.
> > And here is what happens when verifier rejects the program:
>=20
> Sounds pretty much like: doctor it hurts when I do that.

Well, the point is not in the volatile variable but in the BPF_X
comparison instruction. The bound might a size of some buffer,
e.g. encoded like this:

struct foo {
  int *items;
  int max_items; // suppose this is 5 for some verification path
};               // and 7 for another.

And you don't need bpf_for specifically, an outer loop with
can_loop should also lead to get_loop_entry(...) being non-NULL.

> > +      volatile unsigned long five =3D 5;
> > +      unsigned long sum =3D 0, i =3D 0;
> > +      struct bpf_iter_num it;
> > +      int *v;
> > +
> > +      bpf_iter_num_new(&it, 0, 10);
> > +      while ((v =3D bpf_iter_num_next(&it))) {
> > +              if (i < five)
> > +                      sum +=3D arr[i++];
>=20
> If you're saying that the verifier should accept that
> no matter what then I have to disagree.
> Not interested in avoiding issues in programs that
> are actively looking to explore a verifier implementation detail.

I don't think that this is a very exotic pattern,
such code could be written if one has a buffer with a dynamic bound
and seeks to fill it with items from some collection applying filtering.

I do not insist that varifier should accept such programs,
but since we are going for heuristics to do the widening,
I think we should try and figure out a few examples when
heuristics breaks, just to understand if that is ok.=20

