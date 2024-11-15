Return-Path: <bpf+bounces-44919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266219CD5AE
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C560B1F224EC
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CF152E02;
	Fri, 15 Nov 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMHRh65V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93F224FA
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639802; cv=none; b=aYxVbTmKrC1sWWJmZ4MqcB77+26GwKF7evCNmY39q+7vZF6/z7qbnVpBk3cO1CCpTUCpEYpWrvbT2unJBsq0R+1AQVjLEofH1dw01FO6JmxnJaTsyPpTXBQoufH1zQEAyOGBSUgLQQH3eUzhVlrp4odkAx607uzeYbk8xLyk5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639802; c=relaxed/simple;
	bh=5/DqZm0Q2iz1pxagzTnfBgixa2Eo0ONRtA+isN47VrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua7qLjAksqlSX1SMFFm9yBjanhlgzLr2mPXn858QWg224F4rUON+ptgSNyj/j6lLKnRkS6H/3J/gdzLJzghjE8wVWE2Ysbvt9C/ur6JrJd6RscfdVNnYkUU6xByiVHvg96gkQhZK65pev9ZkgSSMGp8w3YK4tKzPtBvSR4Y8pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMHRh65V; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea0bd709c0so912770a91.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731639800; x=1732244600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr4lxaW+o/nH0OrXDJ0SbbVKChDYQ7Bhj6M06pqIxUM=;
        b=WMHRh65VRivlqhs4WnH2lDuyINye+ODgqLwEEFQ7GlsV0h6HqNBHaPqkbOPK17KgDk
         6B0xIUgFWTiUSbqZWRFgFrF0GIhlgRVAU6/Dmr4jXNdsLcfEELrSQuOd8H5QIJn7cKzL
         BSFI21dZinzPVKMCzDoEvEhcQGVAvwq+3Wp5SPHpqdHq8P++4kRsmZ6Qzjfkzqv0mhCU
         DMztuTNv8UGQMqYGSowAMXHSxGpOBxYX3faWTSe0YsBtHluLeH41k8E0Rwag/9IuycBH
         CIADr83JmRwXTds6sfaneiVljmYpX+YHAdedLylVwxOWzd0ItWHjyh5Fb7uoa5LXr0PF
         Bq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731639800; x=1732244600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr4lxaW+o/nH0OrXDJ0SbbVKChDYQ7Bhj6M06pqIxUM=;
        b=CevH8m0iqrS5l7DA6wLjUuKEbyVjhAjBb/bw00Nvt12hbg+xzR3eb0jY5j0vcKLBPL
         PWUuBbuq9d6yMuHgidnMWV0h/Xwh3pzxhr95KpTZM849kUlYOPAbx0vyqZuUZRM7P7oL
         DiFFnaMjIj00D1jHH1jUtHxMU6C6w3VKq59AL0YdSjAGIsyR21uNdk0497I0/cxjTh6R
         /QfGorjlfoSTRus/ZeGteKN+g5O9IzjAJdS8O1dGjKdbNlGmzfKmGhbWplgwdPM+TQ99
         yVCXDBJJxItOgFrY8DqIV+0jVDToSC5LNp09TW0erbpj+IypiHD4whzk+nLTgHbfu/nJ
         jKlQ==
X-Gm-Message-State: AOJu0Yxn55UfNQka/ashTMZTPBM5Z3V/F3DXSFoyNRtRLU7cznRg6/X2
	PwDsaLgiZm/sQwgNvrw2QPeMlhl6awn0Eju03h3a9mqmUhFinmAeenbUNsqAFgZ1gcUCQcsxgoh
	hsMxf4MZWXa/8QRYfgayyUqkc/UE=
X-Google-Smtp-Source: AGHT+IFWApdMCsbLgG9kiNJuFNWTAhSmoIaOZ/Nr7imKkVJ2KK3cYkAhdG5YYer+BQgHvFDng0W0EC1nriNVRu0vl2E=
X-Received: by 2002:a17:90a:e70c:b0:2e2:ba35:356e with SMTP id
 98e67ed59e1d1-2ea15515b34mr1769255a91.17.1731639799852; Thu, 14 Nov 2024
 19:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
 <CAEf4Bza57teg+vOc_P2Fk02gEFPY69u7yPRzksr4GRVvS7o1Cg@mail.gmail.com> <da1040939abff53c84bcd3a6dc7b7bd6ebdcea58.camel@gmail.com>
In-Reply-To: <da1040939abff53c84bcd3a6dc7b7bd6ebdcea58.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 19:03:07 -0800
Message-ID: <CAEf4BzYvV_jSivZva8Be_5GZLE2AwOWJBnnLQn4YJ0Dkq54x6A@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-11-14 at 16:19 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > I was also always hoping that we'll eventually optimize the following p=
attern:
> >
> > r1 =3D *(global var)
> > if r1 =3D=3D 1 /* always 1 or 0 */
> >    goto +...
> > ...
> >
> >
> > This is extremely common with .rodata global variables, and while the
> > branches are dead code eliminated, memory reads are not. Not sure how
> > involved it would be to do this.
>
> Could you please elaborate a bit.
> For a simple test like below compiler replaces 'flag' with 1,
> so no action is needed from verifier:
>
>     const int flag =3D 1;

now change this to actual .rodata global variable"

const volatile int flag =3D 1;

>
>     SEC("socket")
>     __success
>     __xlated("foobar")
>     int rodata_test(void *ctx)
>     {
>         if (flag)
>                 return 1;
>         return 0;
>     }
>

