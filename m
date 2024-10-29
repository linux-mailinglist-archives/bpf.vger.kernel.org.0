Return-Path: <bpf+bounces-43422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F091F9B5528
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13641F23A0C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23266207A1B;
	Tue, 29 Oct 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoCG6/nU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E620820A;
	Tue, 29 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237752; cv=none; b=F+yxsJtqr8gRNSVYMLlI+fm+M8tR0Q/5r80YKM+kXZtUM9alYwA7uvbhJRLxucF2PJll4fxzTm/CUYIriB5cKFpW1FBJAMQaMtwbCyyDYqlaXMCjio863t5Ph6msn75IZUN+bLPU3GlApS0W/rcAW3ZKWpN8yTIulQb2ZvqrcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237752; c=relaxed/simple;
	bh=2hdEGImrtIWyPZpvykwCLVFsfsDtbtJ26Dc/FC7TOCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfpFMsNhGFdABwSqepIYYCAjb3myEnJyDCn9ZoZewl99QLrtojbCJReIc08L4x7eqRMgyNOg0nBL9m+SYr/EY3VI0/Ub44zsLZzNZ8k8ZQQCQkTtkce0ubCDkCdR8SRyXMhSj4jkpzsL7jv6R8NUogddY/XDc061GxiMUJVQrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoCG6/nU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea051d04caso23367917b3.0;
        Tue, 29 Oct 2024 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730237750; x=1730842550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FifTdZFU+NbYPEQufcgUJzwkx+ETBVCZzNVdM2zITc=;
        b=SoCG6/nU1RZBMTL+Kgd3S8VrhspDAl48/4W4IR7+19mA7+yQWJiWczzKcdW3opqH2j
         bfbuPmS9vlcJS1uJsrinLMDSi5OMtiOissE5357H+lBP04jlvnjtVTJOUUfjYaUe1iZG
         ay+Q1r1E+fghBnW8tO4N3t+OimakPc6KDphYr+VyY/fp7UDkC3LdkGN6/ZKJNVB7GUR/
         cKcogphbtZ6+PgTUqjQ3iaeGZ8j5XWV2zuFHV6nZrPsgrO63Aw8v8UmOq8ukI0P8fb1/
         ZTq2Ahc/QAzVEmir7J2EiXvfAs05AqR1UYADLwNr99Fx3PMvD2hxh7cpIqRO+NYGESey
         bzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237750; x=1730842550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FifTdZFU+NbYPEQufcgUJzwkx+ETBVCZzNVdM2zITc=;
        b=YZTEqycxAp+3fQ39NS4O9GekBwwQ/W4Q7gPgyShYsmuItrG3UBHPf46H2ap4oNkx0y
         7uh3IIlbQ4mPsIx5TCVd6uIaZMqsgx3nQviYb+OEhc0NGnaeGoJru9QEUD/YhVlXG6KT
         J8JwBxffnuWRw4uX298lg0E6m5yJgsRnG3RTh6aX7uQp/I7KBB74QejrUqcF0gbnecXV
         vlNwkDEtkeYyQn6F0VIhVSTL9FWlk8pXEFFO7tj4nL3Kc0ChIMRIlJku2qZYjESThj6x
         qGeXVRguBQ5z7vNsEeB2nTxuF7H5mIq8gfevPu0V35l1cK/KWnXcpyNyv9cQ7j0yGXmO
         jV3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsfVqnxme+ZQkKRsrArs0RUFoa0/J1e6Wl6z50xVw+YzECfHctZYsJN/RekSXvDcTxuUu6i+QkFP7yCbsY@vger.kernel.org, AJvYcCW5HKJUZH391v0pG2pRNZyzN8wb2uKSwRAQZ81gEyrJSWmwrqDY5VFNl2GOcgaGqhPDHenQG7nw@vger.kernel.org, AJvYcCWanuwyqcnowiPuKAHA8yO0OplZNcI/o8sEq6Z7GGo4m2U9bjtIctin7rFnAaT9kE3uRHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymuMbT3gMzXWTeDaLFYhjn2W5Tk4Afh/dVyK4MIBA1TBJTcKyf
	Nj2Vd1ADMJkH8PfICQHlM8yDBcElrGq7bA9HB9awkRMLHKxWQiDLiZNwGiY5DXoWBWKhps3+UA7
	u2X4/xd0csDDF65YFbLezcsRuSHo=
X-Google-Smtp-Source: AGHT+IERNHe6GdQDhUCH/QMI4NVanUrXn/lehSJw9XrUiMRCfwRofHTRr8xbL8Y1Qc7SUaaYl1TpEH0vK6m4xhiyiHE=
X-Received: by 2002:a05:690c:fc7:b0:6dd:ce14:a245 with SMTP id
 00721157ae682-6e9d891bd97mr137336927b3.6.1730237749882; Tue, 29 Oct 2024
 14:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019071149.81696-1-danielyangkang@gmail.com> <9b6bc5f1-9e10-4bf1-a6b0-bb6178d771b0@intel.com>
In-Reply-To: <9b6bc5f1-9e10-4bf1-a6b0-bb6178d771b0@intel.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 29 Oct 2024 14:34:55 -0700
Message-ID: <CAGiJo8RzhDgfP9hcND4fGjtA4RRGhZVdxWmJmXas_azuxwqZaA@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:41=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
> > +     if (unlikely(skb->len < dev->min_header_len ||
> > +                  skb_mac_header_len(skb) < dev->min_header_len ||
> > +                  skb_mac_header_len(skb) > dev->hard_header_len)) {
> > +             kfree_skb(skb);
> > +             return -ERANGE;
> > +     }
>
> I believe this should go under IS_ENABLED(CONFIG_KMSAN) or
> CONFIG_DEBUG_NET or so to not affect the regular configurations.
> Or does this fix some real bug?

Well in my opinion, an infoleak is still an infoleak. But, this would
likely not get triggered as long as an skb with a properly initialized
eth header is passed into the bpf_clone_redirect function. We could
initialize the memory to 0 but the performance hit would be too much.
If the bpf_clone_redirect() function cannot be called from user space
with user-crafted skbs as input, I don't think this is really an issue
and we can just put it under the macros to get rid of the syzbot
error.

- Daniel

