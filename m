Return-Path: <bpf+bounces-36693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0694C336
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90540B253E4
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8D1917C6;
	Thu,  8 Aug 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1xzIK5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D3190676;
	Thu,  8 Aug 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136427; cv=none; b=K1ydGzTrnMPN5yeS5nDBfF0jA0jmt2UavauYHrAJz1g4UXFvz5nKLNIUpNfVz2lp8js4PBb2XYVv4FHOYVpAxgaNWGknkwDzkzR8JLbTeQ7o6rjEc3XB8dJTe2251o1dgCPKj7DiG49q+Vv7+uT34qRrEeqrvdpMuLH1h25d93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136427; c=relaxed/simple;
	bh=79E3I9rnh6cuexV59Tr1qEKnDOCpKpgureeRzYsAf+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7QkLsFArbkzbF/+QTzoOmZ5Vjm/hOoKOnGNO2KAiDXILeIB8yQyHLCvxNm1SrYAlydw0m338/9RP2oxTEET2u86MVdwcj44bav2wPLG5UWKtF5DaMRqhNYO3Gks8+A5o3ZnKM8OoFvOw7SelhX1ZAHfXHWe9bE6gXTp56Osis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1xzIK5C; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso960652a91.3;
        Thu, 08 Aug 2024 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723136424; x=1723741224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79E3I9rnh6cuexV59Tr1qEKnDOCpKpgureeRzYsAf+k=;
        b=l1xzIK5CfmtoUCLMnTLnxO6vSe3jc1dn8OWXYwj2yF93FmsRK0SFXdO0I6dJ1rYHDy
         QVQcooks/GhXykh9GC/f9k9g1cWjDkUwOx2IT9Ow3t5rvsDikPf9ffcpfnY1kByZIoX4
         wW7e8IpzEr+uCA5bvA4AN9QWP8qbCY3PmDunqMF1AuB7o6yydzuFNb77DMIiReTYNGxa
         PORBblKEBGObIfkFwAtn0zVhuf3KUEnWzlMSikwrHz7T5SzMmsLh0uchJ4FgNg2vuXVw
         Lf9xiIpEp6LJDDHL7I9WBxuu3zulY5RFrF0AGIhMblsKvJ5/kU2oiQUMDoJd3EiUaO5T
         fxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136424; x=1723741224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79E3I9rnh6cuexV59Tr1qEKnDOCpKpgureeRzYsAf+k=;
        b=a3FCH2dPdIjYQgdRvqhnvoPffBoPCJ1WuAo55Gx+joRPhdGzOJ6z+0i0dRQV/99xpG
         phCQwf2U0SwseBGgd3293OSI/RDY/YFhCmN2iLwfn0hJXI0En9cufhk7zdeimJUeEIYn
         750diUao6ZDVE1aX+elK6QThmju179rZnYuEoVXU4PYiAN7jiCJ8gzCwpCzUYaemDzHz
         KnGqo0Z86xEiYoyLe/wV5jRT3FYwLxax7hs3oMiBi7eHO/bQ3qTaItiYRHnhpkPXA+xi
         PCIAZc/qdGH7GQrCpf4gNIP4w1Lek6t0uflEYXakmr/+niuP9n3w46Pblivgt+l0AMu3
         Hvrg==
X-Forwarded-Encrypted: i=1; AJvYcCWDaF3Dat16tl+cdMZvRilXbfCqhHF8KNALDWsttISiUqCEUhAerQ8ykbGSYd34HA7O13OymvW9Zd3ViRyf3xOMP11QouYXKHp+0MSIAjpUSM5IDPl9UDN6mXJiU0yVAXuYhEgd1zhlcWrwRSnnn9VDOI/A0GETfLq6f4Zf5T5GpXu4mnCF
X-Gm-Message-State: AOJu0YwNkCnSPV9nW9UL6mUL0fEHTxyyrkk39RdvBXY9pUnETzwXrZn2
	ycpCe4NyHLv+AsHgzbaJcnjYZtcRjaoHCt8l/dhjnWU3ioC1K3TTWOZnu2qOD5sD9Oga8VqJ54T
	ndwseoheVftFx6qbE4gX+ZD0Sdzc=
X-Google-Smtp-Source: AGHT+IG4AjU8cd9c4BbwsbTHkh5tFspfHK00zOrkjggKt3MhV48RSKUD33NHjh4fqO9wSs2Puy2f8iyojyJtoPO/mFU=
X-Received: by 2002:a17:90b:4c89:b0:2c9:9eb3:8477 with SMTP id
 98e67ed59e1d1-2d1c33c0974mr2743943a91.16.1723136423922; Thu, 08 Aug 2024
 10:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-8-andrii@kernel.org>
 <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com> <20240808142916.GF8020@redhat.com>
In-Reply-To: <20240808142916.GF8020@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 10:00:12 -0700
Message-ID: <CAEf4BzYzbwqPD=8S3Vgjfwyju2dCO-3aOK-vXvM_EwsV_6faJA@mail.gmail.com>
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree lookup
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:29=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/07, Andrii Nakryiko wrote:
> >
> > So, any ideas how we can end up with "corrupted" root on lockless
> > lookup with rb_find_rcu()?
>
> I certainly can't help ;) I know ABSOLUTELY NOTHING about rb or any
> other tree.
>
> But,
>
> > This seems to be the very first lockless
> > RB-tree lookup use case in the tree,
>
> Well, latch_tree_find() is supposed to be rcu-safe afaics, and
> __lt_erase() is just rb_erase(). So it is not the 1st use case.
>
> See also the "Notes on lockless lookups" comment in lib/rbtree.c.
>
> So it seems that rb_erase() is supposed to be rcu-safe. However
> it uses __rb_change_child(), not __rb_change_child_rcu().
>

While trying to mitigate the crash locally I noticed
__rb_change_child() and changed manually all the cases to
__rb_change_child_rcu(). That didn't help :) But I think your guess
about sharing rcu and rb_node is the right now, so hopefully that will
solve the issue.

> Not that I think this can explain the problem, and on x86
> __smp_store_release() is just WRITE_ONCE, but looks confusing...
>
> Oleg.
>

