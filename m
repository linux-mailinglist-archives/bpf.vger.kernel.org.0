Return-Path: <bpf+bounces-76760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D8CC50C9
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EC13026B04
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E8133556A;
	Tue, 16 Dec 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1vH+mNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB45330D30
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915139; cv=none; b=WF216I1NzRsldeA5PXpDf7xPGB3s6rpnBP7vubF3LwOSAhNWTnxNqOouIe4gPmFjVfKspKoteuVS0mOQz8rLUvc8Olf2iYHvukk+kE0M/6i4K10+AfC8cQ79xbosqp02VpaYoqAw5TYf11GQ8Pmn4at4r6Vx11srmpP4JNMu0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915139; c=relaxed/simple;
	bh=xD9fvKR6R0xx2QkLJFssk7C8mFDrIQ+I8tOfGVgWHR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+PAkSOuO60WSFjx7mOpAosWEgMcrLj8nFJenM7zONF7SE4xexFhI7L4NS9ctbbFVOrlpqaVAD0tXobuk3fJzOf1Z7XwNbHEg1gAcqsy4PEBnvoZwAwKne2HodSkcdejsikIvG7N+0ARIEVTxq6m6uwz1GnTbhtYR4wrIDcuBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1vH+mNy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so4736705b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915137; x=1766519937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HcHHcKfq8+aPeSsV2fUtc8qlv3Uw4dEWKUNLIt5sOdE=;
        b=X1vH+mNyb8Yi6JNhR+AcoKD+iDEP97amJvPC5QcKTd6tcJDSttMEDiSg5yLn3N3TEu
         vqY7ujQf3VymzwAqol2RzLORVcIbfb79dF/G8u7S97t+S4wItwQr88gM2/z2Ed99b88i
         93kQTbpvKrbMl4x0zWt6yEPyowzCJFqU0BoRPOzHDpxAWJuEw7GMAqRPCdCuS1aaHhra
         p7uaHvkqAtSuZcyKuASEbRGZlIHRUFlbtalHS74qx7QqpZRDZHKn8uu1IfGvh2cJJdbA
         S/exDJuK8wuBBrhiC4oFxfNpSWps3AJTdrIp8+ozUDhc70M56Px2LRIyl/akjbBQjMjY
         j4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915137; x=1766519937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcHHcKfq8+aPeSsV2fUtc8qlv3Uw4dEWKUNLIt5sOdE=;
        b=iof+z5Y7ZWvATd8Rr6AlTybTVZod6vJNQtl/c5lGR4UPYVwkW0LR/pUFhQGigA6peT
         48uYa/SiHKy4V0dOeMtuWfFC1Nq/apje/zlARXNKR0GeahbP4UqZZAwfy/Dr3DVOP9rn
         ksxG0lHmwuhFtvIQTQxBcwmN68TGUc7eJZ+NbucZyo/jQ3k8wzPQEo4tAD6B4tU0otrQ
         Ub4T7jMHeImmHDDrtAdzLqRAhPu9be9Ohhpqa2spzA2wHvNCJQqIAx99dx3Lno/8xoSl
         7W+3YS5WcvqbkyIGMo85+5R6p/wt1mY4nBxaYHBr9s4nP7Kqf7dMKqLBzcZ9OnCXbAN9
         sDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtlMQxbwYxHDlsCd2tR1cFlQF/PpHZbUhKcz6Oj3X9G+AiyqbzAJnKhLZsi+gQyLkFhUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEF7347I5caiXdQ2Im00GbWTpIPrKzlYuRgjH2RmG0kBaXQP49
	W5y+PME0082dyCQFvyQL+a7LnnsgKk4ux/peNOp8nOvcc3xrrBkhjdps
X-Gm-Gg: AY/fxX6OpdpTLhJPj3ISixkG7rx9Erydkv4rLK8+/YLb+CHlmzrpnmCAPhnhX5o24Uj
	FQYkabHILcXa4Gjc9yKo0gbtahpRJnf61nRhI30DXD7y+cCyChYIMv+tbGc7pHBclFfKCAunKfb
	4yrEaWH6pvJ2W4BdOubprd/EEJ68dLguQOgLJxqMmwg1Avi4Jax2GojZcPteZsqd7JJYqg2UJb8
	DbiPiiULiMNQZZdaAioeLM97YSNAzEKCTXm4S/aVuy0CkQXCHQyw4p3MZSQFK8Z5D7/QxZVZLKK
	0/7b+FEAs6OvxygPf/U5cScPQpy0vRBe1/p1nyQ2jacI7/z18TbgCU1cEpTaghwoN/KIWn6Jb2y
	Wfg/h70Xh6KrltPnVhky0v2hqYmVKGiw86GEWVv52IHMSrCSRrpXC/fj1hRx5P+yFnNkJDaY5Rs
	p5BRAGWJPM
X-Google-Smtp-Source: AGHT+IFv3ODhtSb0L+Le4kdFabV0AVBP3s2kdKANWYCxJqYIXKs1TDVLinxkpxuMI7zbj41ORdFabA==
X-Received: by 2002:a05:6a00:4a0c:b0:7f7:2a77:7567 with SMTP id d2e1a72fcca58-7f72a777764mr9145729b3a.15.1765915137200;
        Tue, 16 Dec 2025 11:58:57 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbc0be691sm348016b3a.58.2025.12.16.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:58:56 -0800 (PST)
Message-ID: <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	qmo@kernel.org,
 ihor.solodrai@linux.dev, dwarves@vger.kernel.org, 	bpf@vger.kernel.org,
 ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 11:58:53 -0800
In-Reply-To: <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:42 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >=20
> > On 16/12/2025 06:07, Eduard Zingerman wrote:
> > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > >=20
> > > [...]
> > >=20
> > > > @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type =
*t)
> > > >      case BTF_KIND_DECL_TAG:
> > > >              return base_size + sizeof(struct btf_decl_tag);
> > > >      default:
> > > > -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> > > > -            return -EINVAL;
> > > > +            return btf_type_size_unknown(btf, t);
> > > >      }
> > > >  }
> > > >=20
> > >=20
> > > That's a matter of personal preference, of-course, but it seems to me
> > > that using `kind_layouts` table from your next patch for size
> > > computation for all kinds would be a bit more elegant.
> > >=20
> > > Also, a question, should BTF validation check sizes for known kinds
> > > and reject kind layout sections if those sizes differ from expected?
> > >=20
> >=20
> > yeah, I'd say we'd need your second suggestion for the first to be safe=
,
> > and it seems worthwhile doing both I think. Thanks!
>=20
> ... but we will just blindly trust layout for unknown kinds, though?
> So it's a bit inconsistent. I'd say let's keep it simple and don't
> overdo the checking? btf_sanity_check() will validate that all known
> kinds are well-formed, isn't that sufficient to ensure that subsequent
> use of BTF data in libbpf won't crash? If some tool generated a subtly
> invalid layout section which otherwise preserves BTF data
> correctness... I don't know, this seems fine. The goal of sanity
> checking is just to prevent more checks in all different places that
> will subsequently rely on IDs being valid, and stuff like that. If
> layout info is wrong for known kinds, so be it, we are not using that
> information anyways.

Ignoring layout information for known kinds can lead to weird
scenarios: e.g. suppose type size is N, but kind layout specifies that
it is M > N, and the tool generating BTF uses M to actually layout the
binary data. We are being a bit inconsistent with such encoding.

