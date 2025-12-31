Return-Path: <bpf+bounces-77640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322ECCEC813
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E7C3009F5F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50A30BF59;
	Wed, 31 Dec 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKTgpYLh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957A3090DE
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210267; cv=none; b=UmZSOL64c18F5YbxlyH/3vsdu5CHFVvShP1sxlFG7oxBluKonNPUdj5jCBd+FwCim79xE1/jJcIgTSmC2LAnXdmVRYw3ZaHIWREe6x1ZIIDUdba7IffSugQynVbsmhLCeliJli3TyzvhUyD1xvVZBKjrL0HAjFTOyZDzikYh3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210267; c=relaxed/simple;
	bh=byLPraVNeufU6ZcQupnPf9723CvZJQP/rTMoouG682A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcyG3us9QL+2p0l3Fd9bvD8R5cZ8fZMPoj/ToHQQ9XfKopabSmg6c1K1rpMDcVLr9Dt0ClmM+HrrrHOGUda55E3XO8kINAj/stzfPKzeP/6YfdBwG47dGRAlyj3Rg8tEWCMK20yEorB8ZgLyBjI8TGC2zdpZygoVx6ywwMiGXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKTgpYLh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b8e5d1611so14147307a12.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767210264; x=1767815064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q1UtvBySidDF79vcdaxCxEYDKvTIyoYuq1C6vHutn8=;
        b=OKTgpYLhuOLJ1HyeqB9FaG/y7BOjbZcQaFTZH3W2+XMvZR6vBKNcKBFell1a9sXHff
         n5SmWIQDKkEDD1v/R4q9DyHWRMbCrCqootKj3tCLPktuni7n2s50ckGsV4ZjK+mdpi1V
         ZeZ/19i80DVCucis8IQRsslg8hAZVgf9taWj4IjKpem3Ewn/G8nR/CBtl1202OSZ5sOq
         oJQWf0s0fMMrRccOLGyUFYVZ1lcO9onfhGkNzXNfY4B04lHv+8HyK9dUAjE16yADer/f
         pa9fv65sDcxA3/xRUxK/6ym9DA8a9AYX1Pehd7J70oFyw15XnzcoYe8ApknoEuaO7USK
         ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210264; x=1767815064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8q1UtvBySidDF79vcdaxCxEYDKvTIyoYuq1C6vHutn8=;
        b=X8zk/To4hFY3Ws+s8GzdFaspYZHf2ZO834DvWPKXwjLzqSK9xKH6AHvrlPx6ZuxWp8
         ZB1XA/PpYLlF1MYoTEKTvad5Zu7MIHJgLXBTWU/k+4aXQXD3QRfu6+YT2nMZD0RRj4Ef
         aOKZ0XjYOY+ilonttYeVFYsjQ/xKIQ7nXhyE59ipHsGIke0iA+tRn6MyxfQ3iJBz2mf2
         JltH8ERxEC5AlqRPO8hsfkSNpfCpZsGRZIG8bEdKpS3Uyb/TXgT93kC1x2P+CvlOtf1p
         epnBJX6jgC67Irw7nSe/WotKM0iBclpfya+AM3z3+dNVVbzEQWn3Ukspd3QJuyFxJ5vH
         2vAg==
X-Gm-Message-State: AOJu0YxCdcXoLnF3PYX38Parp4H5JsKYgoijwsagb+BKE5ibWTgtPRiz
	NpcmuaOP8W+Nmyze7xPXLV2j4ftf2yMiUNK2rFNrxxWjNMgnC5gK41axPZ7ds9hZzsOVueJOvo8
	Rzt8ufLQih4fJYSUU/zCyDv6bAY6RF0M=
X-Gm-Gg: AY/fxX4NCTxrhOSgrjK4URNVYPt4CAN0AmPc3YL5R7joDbizrbBtFNQKBE4naQ/5WM3
	QXLJjFCbfQYUNORcyRyQyukcTINF6z+4u0IuCS6TjPG7PkzxYKZWdcYD+XB43jOh/bAjZmZ8toL
	PFA0TWql0UmzX49n421A2OOJ9DFkewW+iuiGKjpPfUo5okO0Y78tCKS1/mufc+DQ6LzBIBekHhN
	QvGSK1x1Ce42dxvfgSQOVSalV22DZ/nljRMrutSL4Jus/G5eavCITEoxpmVB/kYpVGY7Y7vDqR9
	tHg67dOzsPM=
X-Google-Smtp-Source: AGHT+IG5xfIsWDASyXF/NvM/9klXnjJqU7biAGucIa4rSYAcKSLohV4yKWabP6b4nl/R87HH+ovn7sTqxLSRCFyrVTs=
X-Received: by 2002:a17:907:d0c:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b80371a3da2mr3972859866b.37.1767210263545; Wed, 31 Dec 2025
 11:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-6-puranjay@kernel.org>
 <158a0c1b46418130cd8e3a7b67775f3bd00caa16.camel@gmail.com>
In-Reply-To: <158a0c1b46418130cd8e3a7b67775f3bd00caa16.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 31 Dec 2025 19:44:12 +0000
X-Gm-Features: AQt7F2qa8kvZoLKwbpKIUVUaP8BOcxbh5jtonyzR6CnIqpRadrsrhvWwX9L06gc
Message-ID: <CANk7y0gt3NSQooG4FactYh-q7bD9zf77B6ZiQg4nEhNAq1ro-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] selftests: bpf: Update failure message
 for rbtree_fail
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 7:27=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > The rbtree_api_use_unchecked_remove_retval() selftest passes a pointer
> > received from bpf_rbtree_remove() to bpf_rbtree_add() without checking
> > for NULL, this was earlier caught by __check_ptr_off_reg() in the
> > verifier. Now the verifier assumes every kfunc only takes trusted point=
er
> > arguments, so it catches this NULL pointer earlier in the path and
> > provides a more accurate failure message.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/te=
sting/selftests/bpf/progs/rbtree_fail.c
> > index 4acb6af2dfe3..70b7baf9304b 100644
> > --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > @@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
> >  }
> >
> >  SEC("?tc")
> > -__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=3D16 =
disallowed")
> > +__failure __msg("Possibly NULL pointer passed to trusted arg1")
> >  long rbtree_api_use_unchecked_remove_retval(void *ctx)
> >  {
> >       struct bpf_rb_node *res;
>
> Do you happen to know how did it infer off=3D16 for R2?
> From the test I would infer that the off is zero.

I thought about that too,

struct node_data {
    long key;
    long data;
    struct bpf_rb_node node;
};

the node is at an offset of 16 and bpf_rbtree_remove() returns the
pointer to this node.

