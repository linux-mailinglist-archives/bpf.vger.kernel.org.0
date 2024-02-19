Return-Path: <bpf+bounces-22237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C6859EBA
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F273B1C2216C
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4322323;
	Mon, 19 Feb 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKwVkQen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE2210E1
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332504; cv=none; b=dcO8LvQiYCTvwZe7C0fN0RPxxwm9+TfRwAMgVmFemUBL+WluWGa98d/qITRRCXJZwY7ISWkEsJYUHZ8dUn14zLrl1PvqKk84PM8EcTidw1HrtlwjAijfDSvh0fxUR7WKmWTGTA01VXXWu17Mn4hQOvOlB7Bq5oeO2af7lyGkCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332504; c=relaxed/simple;
	bh=lh7mBzf1pZSqsd0AX/fXi/mWa+dp9wInxWKrXlUhSXg=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJ/vfbgYsj6nNu1oIM1TXoU9Tod5iDgq8D61P5nU0JqCe5S7e393bNb3JJN65KnWgGtyUViEFn9uhxoesALQGTp/4Babv94zGvI37iXtNGCHiDoq5dS9FrCeczrHJMOL+AZrKRJsslRWUmbAVcbx1ESUnGRliW1k+BMGQQxLcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKwVkQen; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso20641241fa.2
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 00:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708332500; x=1708937300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lh7mBzf1pZSqsd0AX/fXi/mWa+dp9wInxWKrXlUhSXg=;
        b=BKwVkQenuFWcA/w5TQmtydEVH49Luqxb9t+UGcbhC0ipGZzar/Ki96ngEqJW6g9yiW
         CTRggqk54kilgKu+gLN8WmHbnIk/GmZ279TPNbRKhWSi4hjN2LoMVy1lAZpBes7TBp5T
         qLplkKoQ4Po+9H5MagcSGnYAdkxquUijeSIDp7sE3IyfUONWmgAwICfMaHkmOzUkAehX
         hzIYid4AnSmwECFJQb4OOCK5fhq/llNAAaJBt4XPstPuDrMFJuDNg60o8tMcrscPolM9
         X7oL8kjq2SXgs+4k7DqJjdHx671llFLpFyfg3YK8rZqTVYXCVVP9eTQZDMPqCynOazG/
         E9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332500; x=1708937300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh7mBzf1pZSqsd0AX/fXi/mWa+dp9wInxWKrXlUhSXg=;
        b=PJEXHGugK7h5EKSqrH3KmB2wtyg5dA/WG/nEY+UV+FXWK4y5eDyQ6IrTLy0OuP4xc9
         uvdpioo0B8qh2gwjuRhRxO0FkNVYljjL0WeQlVTVItFAwVGZgH/wvj0c4SW2YjC9TUeL
         KQHhd5Yov2xiMVQ2nG1Tjo23jVupBclunJpa357lWNl+9PGRw/yKOkbRfbLlYrcvHypy
         QChjXkPPAXsH1gL2GurF8UTLO0L32ciecaOc1pGMTUtukw4do9Y2i6jjopg1NRAKV6Dq
         pklz862AwOGZJjgU/Z2/Ipuxxw2gZWWkT25Cmg9Gw1fo1bBx9VuaOovudz78a7ah7NSY
         0Qbw==
X-Gm-Message-State: AOJu0YynVBJouBirezIPx6uUmzuaNzmfIzhJDZ9aRQIy5QX4p/gIwYZ+
	10TS38fI6mFLhJ5wakc7AG5rTyNyyFv+VWXAU8I/fzRv7B0/3f4U
X-Google-Smtp-Source: AGHT+IG+l5DrnthykROuFvqPggu33vcLBY2+/al7CnWS5nX0an0O615ep05Y7WWXlXGCScZWsw7E1g==
X-Received: by 2002:a2e:9ada:0:b0:2d2:3b6b:2d11 with SMTP id p26-20020a2e9ada000000b002d23b6b2d11mr1010048ljj.8.1708332500110;
        Mon, 19 Feb 2024 00:48:20 -0800 (PST)
Received: from 192.168.10.34 ([39.45.172.107])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b0033d1f25b798sm9319779wrb.82.2024.02.19.00.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:48:19 -0800 (PST)
From: Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Google-Original-From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
Message-ID: <41193af3bd250b9e1e4a52e6699fdbe59027270d.camel@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Discuss more features + use cases for
 sched_ext
To: David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, joel@joelfernandes.org, htejun@kernel.org, 
 schatzberg.dan@gmail.com, andrea.righi@canonical.com,
 davemarchevsky@meta.com,  changwoo@igalia.com, julia.lawall@inria.fr,
 himadrispandya@gmail.com
Date: Mon, 19 Feb 2024 13:48:39 +0500
In-Reply-To: <20240126215908.GA28575@maniforge>
References: <20240126215908.GA28575@maniforge>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 15:59 -0600, David Vernet wrote:
> Hello,
>=20
> A few more use cases have emerged for sched_ext that are not yet
> supported that I wanted to discuss in the BPF track. Specifically:
>=20
> - EAS: Energy Aware Scheduling
>=20
> While firmware ultimately controls the frequency of a core, the kernel
> does provide frequency scaling knobs such as EPP. It could be useful for
> BPF schedulers to have control over these knobs to e.g. hint that
> certain cores should keep a lower frequency and operate as E cores.
> This could have applications in battery-aware devices, or in other
> contexts where applications have e.g. latency-sensitive
> compute-intensive workloads.
The current scheduler must already be using the frequency scaling
knobs. Can sched_ext use those knobs directly with hint from userspace
easily?

>=20
> - Componentized schedulers
>=20
> Scheduler implementations today largely have to reinvent the wheel. For
> example, if you want to implement a load balancer in rust, you need to
> add the necessary fields to the BPF program for tracking load / duty
> cycle, and then parse and consume them from the rust side. That's pretty
> suboptimal though, as the actual load balancing algorithm itself is
> essentially the exact same. The challenge here is that the feature
> requires both BPF and user space components to work together. It's not
> enough to ship a rust crate -- you need to also ship a BPF object file
> that your program can link against. And what should the API look like on
> both ends? Should rust / BPF have to call into functions to get load
> balancing? Or should it be automatically packaged and implemented?
This seems like a really nice idea. If we build a kind of library
where different components of a schedule are already available, the
researchers can just focus on one component and improve it. This could
bring long term benefits to schedulers based on sched_ext. This
flexibility wasn't possible before for the scheduler.

>=20
> There are a lot of ways that we can approach this, and it probably
> warrants discussing in some more detail.
>=20
> If anybody else has ideas on things they'd like to discuss; either
> sched_ext features that are missing, or scheduling ideas that we could
> try to implement but just haven't yet, please feel free to share.
>=20
> Thanks,
> David


