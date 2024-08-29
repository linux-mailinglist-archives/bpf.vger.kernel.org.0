Return-Path: <bpf+bounces-38447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5204964DDA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AA21F21F7C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743AF1BAECE;
	Thu, 29 Aug 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb9OFmzR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE91BA88A;
	Thu, 29 Aug 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956687; cv=none; b=TQXAYVpdWOFu3J/B6LRmpbJMi0KGjvJw2oIwwunIByPsuSlL/qZeU28goszbfIwOI5AjjaUR3Hb3QxUUjaN0eR8vvKmgG3FzDUnRNobIWhAezBOVPJrV27sdJX7UcU5LJNf7s0NmhubvEzVg0PqYaLh7+G+lC//wDz5LeuyeGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956687; c=relaxed/simple;
	bh=kn6kId+WElwQbJomtHV8/JDSRr2Vt/uvyhu71qrhJIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBf1693SmHrisB3YRFYsFJvoF0lbrWOpPZVGpC5/aNPgQniYRZG+QhuJUXv4lpy2wCazOoZfVp95aDOkwLIyXyLJVQCPFHI96GLYGBJONNXPHPBlcX3p7tFnXgxk6MlJgDOqeamiSgnbGjsuvZbvf88h5QEmmA2z335J4tJ5mhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb9OFmzR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3718c176ed7so622253f8f.2;
        Thu, 29 Aug 2024 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724956684; x=1725561484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A8H3hn9t/qDw+QP/avd33PJtlpDZ3DcFKIA/WZ8eDE=;
        b=bb9OFmzRqYzNqCZQaPqSA0+x1zs0X5lSuroWCwz9E8mE/E97QvAimGn4rFqOH9uNQb
         Q1g6UBG9zDNzmebSorYatDCkIugvxxnD976w4/H8lEL9+UvzdxMrpAkjtgvZjL9H4fiZ
         vb9Tl2TKNppBRazo62ozn56J35dFyP1u9JbHG5lEsshe6RSWO8mZillU5K0Fof6bNDMR
         I07tRPH7bt+dz24hEV9E5F2VXerCNN09BWrAlBL40ilVZwcZTjjSkI9B/BJeJqPyakWo
         Lyp3lisGXWKKuUzMswSnmgjJkn7P6RlO/Yd4vISQTm7UQCz2RjUb0ZXC59a59dY6MmLk
         /f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956684; x=1725561484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A8H3hn9t/qDw+QP/avd33PJtlpDZ3DcFKIA/WZ8eDE=;
        b=Y032HFtVyc45nXkUVV5va5CegbmdOAMfSEmWNa5tv+xj+hETqJ6lZkJwoUZdo4baOG
         Ndqxs2eZHLjsYhE4tcqJNCPP6p8F6ONOl3+CDSTnZT0mCRhn88B9JXyPHyp7cqECKrjh
         zQ7k5LJWBHlSPivslHjY0oOUJiXAtoiPNab/IZL9vovFhgBN/JVYvrh8VDwNTihU8nwX
         PbUK1mhHa4v4vrs1LHe1qPe+o3+YBVi+tjANET11M1EFMh/XPtpJPuJ1WrwZfI7Tpbnk
         bUZRud3eEbt7as86/pL7xim28MFlwQuHgxAhP3QjTzqsVLBMNNW/ELOJAkDA0IHMCfXP
         inhA==
X-Forwarded-Encrypted: i=1; AJvYcCUQS6zWJvcYxnG6ixv9kYbls/0xrX+sMmN3mrRlFkdj20LsesqEBQx8KLtsy9qG9BQ7FhtO/saA5rcSw+lS@vger.kernel.org, AJvYcCWMqGEE7Rf/ix855uTL9rcIZ1WWAWQNEfq2SNiPc5Re4NsHrKAFGza4OHwNF4l2Y/nNbak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCalo9gE5nrThf6/+ldgHh/1t4IuCb2sHkxocIq7fbo+r/+2X
	ebYZMSDFdNqNVmInFxJPpJYhwVaLl7J67fYLcyMfr7HWOgGjFgjVRSMaQ2aus/rs9xBUEoIxmkp
	hYPO9G/LRamG9px+u36yhfLcjbTg=
X-Google-Smtp-Source: AGHT+IEpycbQ0gGT9DmLqoX/3ROWtk622CylKyxWyGjJ8NxhSqRwXh3B5yOCS7cg08e/Ywg1tr9bu4/+OWlp25bkJQY=
X-Received: by 2002:a05:6000:1802:b0:371:a844:d326 with SMTP id
 ffacd0b85a97d-3749b57febemr2595945f8f.43.1724956683502; Thu, 29 Aug 2024
 11:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Aug 2024 11:37:51 -0700
Message-ID: <CAADnVQ+P=j0MTkyDD0vYcaqU-qqdE_+mi+gDaqDsLqTXWNPHwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Make the pointer returned by iter
 next method valid
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:45=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
>                 if (prev_st)
> @@ -12860,6 +12867,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                         /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>                         regs[BPF_REG_0].id =3D ++env->id_gen;
>                 }
> +
> +               if (is_iter_next_kfunc(&meta) && base_type(regs[BPF_REG_0=
].type) !=3D PTR_TO_MEM) {

The !=3D PTR_TO_MEM part is a bit ugly.

Why not do it in {} scope right above?
Just move it up by a few lines?
Right after regs[BPF_REG_0].type =3D PTR_TO_BTF_ID;

