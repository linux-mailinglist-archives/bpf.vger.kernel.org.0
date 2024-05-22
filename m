Return-Path: <bpf+bounces-30333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204698CC84D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46942817E8
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752B146A69;
	Wed, 22 May 2024 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6qAolW7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3021BF2A
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414898; cv=none; b=n2FCfJUt8rMW9KK/b8TKBfhvUawTd4Wc3UVFt+kd1NLUZZmECdpoHpDwko6gnSR+hCcGR7wD+KxfSsyuqRtKoy4w2VQ+TXqOzW73w3ul78U5JVnzHh2KUY5NtkxNDRaD/5knpzcux+8AYq9axzvxpm+Zv7JcYEf9f9Iqvo5Sutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414898; c=relaxed/simple;
	bh=d2jIFu4KbfWYVWjh9HnFb/jvGF1J3I6Xs6fPNB7rWnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lh0nCuA9Ze86Dxujk712HjbVxWzAlYCBY+/qSnpFaDXXElZdk+Sc/etn7Ocp1wUwj4xMfzalaWUL79uqrkmCNnUWRuO2Ni4ciXfglNK63X3URzm9hk/XfNtvAazgIoJPIlXoKckuJOxtCOtxZldEvLvTF8g03dMCKy+D2xsz/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6qAolW7; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36c96441a41so26438955ab.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716414896; x=1717019696; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Se7xI3yk1WXbQvliYKcH+++1hiS92tc0W9LzHgVaP/E=;
        b=C6qAolW7UsAIp59TsZwKAmMnGfGK1lf9j6FLNvJImaGqyoqdcIPhKUf5qlj3fWj3hv
         NolYQBr3l1XGinJXCjXguYEmyvWEhbqCA+sqfjgaykriKv+CT3mZbQCaWV0VDqBGfJyR
         6Ky7Xbsv0y+2Ge+nDXLKHC1PFccQkSCNuapj+k5VlGNC4mm7Dmlq8foY8IPNIlWMKqMb
         KYLq7RVr7+eNAfvDt4kbc9kuJ9XVzVuczjBHNakYLNafF50myLHJXwkjEla+F9arjSwf
         Vkdg6x13MX0N+28RUPTiZ4V27u+83gC3Qn93q14vj6eNjt9oCnECLfSWCBk3p6eQbPVn
         ilMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716414896; x=1717019696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Se7xI3yk1WXbQvliYKcH+++1hiS92tc0W9LzHgVaP/E=;
        b=V+HDWtvJCG2hJgSku1uE0f6Zb/f8Y3ArINqJCUaiGgjRglf/H7WFuPmE89GK1hcTK5
         0DEypdMfpacJyf39iBrTP3g1Anw1sJrRnjmUoj5iImxuSKTyXoIY+RSTLFjoNhP77AjZ
         7/IHHTSX9vAepmH6gvp4hydYL47qJQnFLurqkBqNUmEZtmbBokNB1JK0+UDQxl6+JSwE
         s1YE/BJ54h8s42Vm+dmRdcMS5Bl6XFvRQstmSYtpJB/FNbmjzTu2nZU3ojMJGWKEl9gR
         8zdMnlPfgsWjKjgskTU5U5i9VT+lkLNzSn3NDYiM7FBKv1aQDojRQKYGikMcwnsbTEkb
         1iWA==
X-Gm-Message-State: AOJu0YzYXiKyl5paEsWQ++Nxq6x3wVEUTQJJyk9mef7/oaJwa/wYFeN5
	p8A7tA7+OScMq0wCM4byOxibr9Hejrec0b+zqly2h8bthNuouDm/
X-Google-Smtp-Source: AGHT+IHDlY+SXyOgcrZMO1+evDk8uRHqoPsaEtJuMrgv85sLZ/TM5kw3zI2k7SGw7I/ijjHqIT0VUQ==
X-Received: by 2002:a05:6e02:12cd:b0:36c:5023:232c with SMTP id e9e14a558f8ab-371fbdf55ebmr45170715ab.22.1716414896632;
        Wed, 22 May 2024 14:54:56 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665c0sm22889176b3a.3.2024.05.22.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:54:56 -0700 (PDT)
Message-ID: <2b64287f18f11fc5d9e8a8c834da6d010a92e5b1.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded
 iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Wed, 22 May 2024 14:54:55 -0700
In-Reply-To: <CAADnVQJ_c0XTsNY_bfHL0qWfzpEdgy+-mJ1oqtHVppvxA2_TCw@mail.gmail.com>
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
	 <78fa1f7e442579a968a99b00230c6aa0f280679d.camel@gmail.com>
	 <CAADnVQJ_c0XTsNY_bfHL0qWfzpEdgy+-mJ1oqtHVppvxA2_TCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 14:13 -0700, Alexei Starovoitov wrote:

[...]

> Agree with this conclusion.
> As discussed offlist we can add a check that
> Si->parent->parent...->parent =3D=3D Sk.
> to make the algorithm "by the book".
> I'll play with that.

Actually, I don't think this is necessary, here is the code for
update_loop_entry():

    static void update_loop_entry(struct bpf_verifier_state *cur,
                                  struct bpf_verifier_state *hdr)
    {
            struct bpf_verifier_state *cur1, *hdr1;

            cur1 =3D get_loop_entry(cur) ?: cur;
            hdr1 =3D get_loop_entry(hdr) ?: hdr;
            if (hdr1->branches && hdr1->dfs_depth <=3D cur1->dfs_depth) {
                    cur->loop_entry =3D hdr;
                    hdr->used_as_loop_entry =3D true;
            }
    }
   =20
It relies on the following properties:
- every state in the current DFS path (except current)
  has branches > 0;
- states not in the DFS path are either:
  - in explored_states, are fully explored and have branches =3D=3D 0;
  - in env->stack, are not yet explored and have branches =3D=3D 0
    (and also not reachable from is_state_visited()).

So, I don't think there is a need to check that hdr1 is in the parent
chain for cur1.

