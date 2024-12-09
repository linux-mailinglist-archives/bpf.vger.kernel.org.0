Return-Path: <bpf+bounces-46417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BB9E9DA6
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145B91635DA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956A1B395A;
	Mon,  9 Dec 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3JhlLHl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767201ACECC
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767039; cv=none; b=cSUsq3taEXupiJEJ0mdg/k2yKAZlUVOb73sn68JUlyCHjJVUlaCngA4LVT1Y+JH144EemGy1Xc6wSF5q1hOygb3IAT3Nx1VqANps32YvO8ESpgrtA1BrJqg7KK8vNaSATHTMcr3yVuj8wLL6kn4hLzJvnHGugWtLRsVp84f7oS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767039; c=relaxed/simple;
	bh=kLu8zhBKrjQeEw6PT/9EU40QfusMkYT50h+gb47rLB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmCgAYWIjMYllm22AqHOLYQZCHaXt01OFJa9JrppFEN1ggYaUaR+sAyd15WYrIRma9zRzo0m/aiobfKK4Y/lcRBbtZqcXAh//ssUvYbS717QOPrhHs7d3s6GwqB+zlIi0fyuodpfO7i4dkzRLiVmCpx0bPcwrxiqGPhYWoc7+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3JhlLHl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725abf74334so3897815b3a.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767038; x=1734371838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5n/GJUP8u32IG793f+vPd5jdHzCsfPeiMmS0fDeebs=;
        b=A3JhlLHl+qi7u06M3pI5zJrXvHn+pq1xLjNhVfMJWjn2h3rKlW39Xog34N2ck5SSz9
         KXQrldfI8CacDKuAMxqGpSh3Eg6S8TmpgPxb1cHudtGDM80CmPlWi//C08rUTDJxYnKF
         mpeP3rZ2Q8A/PMv0KraXjl9zNOl0qYdJli+SIBhVgI5n+mvFAxdk4YX1ijwnJl+uT0hM
         wLcd9jBLFuEuhYZCai2Oq+4uz1ekUx1ElFzF58jI/46gMUCkLjzNYxldGQcbJVTDruA7
         R6456KvWEtwAsRuPctLfvIF3ENDyBE3CBo6TheS5eZJJ2h5LXLMMfIVIAiF3HDk7Uclz
         9LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767038; x=1734371838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5n/GJUP8u32IG793f+vPd5jdHzCsfPeiMmS0fDeebs=;
        b=FsKy3wp6PrkoOqu1s0mqPmygm4iy5bGD5HAizMAgxnsulF7yg8Y5bu87B2hEpzXS/E
         eY/9Cux0aQu9Y5KndkOqVf9FdgkARTV3VE7K8H0wzN5pcRrGdS/Byf9zZbZJ2LQZn84z
         MSMYpD8HhEz7Ot40LonvXSJsFpsD7WxhQW4UAK98Hm2kyjyuAsPx7HS7e/YAJDylPGUR
         /hqOKJv9R+19OXbhoLM4X06I02QdPhEhqUvfHIFMlaiyRzhUoLET+uVeJ7KHg25db9ea
         OiKhE93xIMyrRlS48fQjwYy+k5hcVVeaW7dNezKmfgOR+SbLvt1pGiOumgc4C7ooyiiO
         iZLQ==
X-Gm-Message-State: AOJu0YwB+7Bej5N8zgDXO/P1NtB75q+pJYHS36V1wJrpHxALDKsbEuNz
	+RkJdxXYdRkAvwveL5icHw27VPQ+O8/2J58v1R1sTz7UKb5WDbQp09VP+A==
X-Gm-Gg: ASbGnctUhTVhQblBzn9OhGcDyYb0p0ixNSA/2rbdwzXbeWBkmo7Z64ZipEeY6T6DcIH
	WXqCymRr/a1sQTnBE+HID0gstbnV2XQpgdXD46FOom7wtDdNTqbshIEg2Znq8a2FOjobXQ9LWNn
	tClmLynhxiR/FsSRx/onEyHgIzgaeJz3SA43BduAels2OHLiw+oGZ5+Ee8FGyfgsodX+lmm303b
	n2Q5b8flkVuTgPs55QRQ0VI04tRt+2xznq5MGQHYDnaBpE=
X-Google-Smtp-Source: AGHT+IG/d7yRdlm6CcdQ50iTRiPwB4ws7QiQCNTFwHPLV7DE0dkhD8ccTFWbuwiLuaSTIKFwR0IXLw==
X-Received: by 2002:a05:6a00:b47:b0:725:f4c6:6b72 with SMTP id d2e1a72fcca58-725f4c66eaemr3688380b3a.25.1733767037406;
        Mon, 09 Dec 2024 09:57:17 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eafb9ea1sm2550929b3a.78.2024.12.09.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:57:16 -0800 (PST)
Message-ID: <58dbb0671ad59507e45c3f5ff50da66b0f8bd36e.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Date: Mon, 09 Dec 2024 09:57:12 -0800
In-Reply-To: <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
	 <20241206040307.568065-4-eddyz87@gmail.com>
	 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
	 <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
	 <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 08:53 -0800, Alexei Starovoitov wrote:

[...]

> >=20
> >     // tc_bpf2bpf.c
> >     __noinline                             freplace
> >     int subprog_tc(struct __sk_buff *skb) <--------.
> >     {                                              |
> >         int ret =3D 1;                               |
> >                                                    |
> >         __sink(skb);                               |
> >         __sink(ret);                               |
> >         return ret;                                |
> >     }                                              |
> >                                                    |
> >     SEC("tc")                                      |
> >     int entry_tc(struct __sk_buff *skb)            |
> >     {                                              |
> >         return subprog_tc(skb);                    |
> >     }                                              |
> >                                                    |
> >     // tailcall_freplace.c                         |
> >     struct {                                       |
> >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);     |
> >         __uint(max_entries, 1);                    |
> >         __uint(key_size, sizeof(__u32));           |
> >         __uint(value_size, sizeof(__u32));         |
> >     } jmp_table SEC(".maps");                      |
> >                                                    |
> >     int count =3D 0;                                 |
> >                                                    |
> >     SEC("freplace")                                |
> >     int entry_freplace(struct __sk_buff *skb) -----'
> >     {
> >         count++;
> >         bpf_tail_call_static(skb, &jmp_table, 0);
> >         return count;
> >     }
>=20
> hmm. none of the above changes pkt_data, so it should be allowed.
> The prog doesn't read skb->data either.
> So I don't quite see the problem.

The problem is when I use simplified rule: "every tail call changes packet =
data",
as a substitute for proper map content effects tracking.

If map content effects are tracked, there should be no problems
verifying this program. However, that can't be done in check_cfg(),
as it does not track register values, and register value is needed to
identify the map. Hence, mechanics with "in-line" global sub-program
traversal is needed (as described by Andrii):
- during a regular verification pass get to a global sub-program call:
  - if sub-program had not been visited yet, verify it completely
    and compute changes_pkt_data effect;
  - continue from the call-site using the computed effect;
- during a regular verification pass get to a tail call:
  - check the map pointed to by R1 to see whether it has
    changes_pkt_data effect.

> > Here 'entry_freplace' is assumed to invalidate packet data because of
> > the bpf_tail_call_static(), and thus it can't replace 'subprog_tc'.
> > There is an option to add a dummy call to bpf_skb_pull_data(),
> > but this operation is not a noop, as far as I can tell.
>=20
> skb_pull is not, but there are plenty that are practically nop helpers.
> bpf_helper_changes_pkt_data() lists them all.
> Like bpf_xdp_adjust_meta(xdp, 0)
>=20
> > Same situation was discussed in the sub-thread regarding use of tags.
> > (Note: because of the tail calls, some form of changes_pkt_data effect
> >  propagation similar to one done in check_cfg() would be needed with
> >  tags as well. That, or tags would be needed not only for global
> >  sub-programs but also for BPF_MAP_TYPE_PROG_ARRAY maps).
>=20
> nack to tags approach.

Understood.


