Return-Path: <bpf+bounces-54352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87DA6816B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 01:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA7C7A8BCE
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664C17BD9;
	Wed, 19 Mar 2025 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MbRFQQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAB3595A
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343833; cv=none; b=G2WdPqyzkWJ2MDN7Ad4BaALPPcdJZ8N6cqH/Xb5QkU6mvETCnnC0bQuNVKrOV/QD2bZbZ5O45eaQboXbB5RJ47LOsFHawl3D3JBHiQKde3cesn+zZtnBNRi9aZ21LLzEAXoHw++QTl6GvKaLZwS7auphtycQYO236AOkq1jKVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343833; c=relaxed/simple;
	bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S42IcFCLJYDVsiY22i4bJ9oBUngbbZUpjKy85k6Da+sxLROH6ptNRFhoEdvbxLoPKBwXokW6fjCOeFSUjpMh2noWzlJ5/u92zBsyfMSGduOUIrPLu4QiJGcFLITkYf22ZrETIr1qA5GV0qvBekNB8+zvd+PGum4VP+XTI4VN5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MbRFQQP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso2516a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742343830; x=1742948630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
        b=2MbRFQQPzYQNDM5acnz+Hy9SKzLzS8kWrfKRwcWMY4mNdNTWeSm9LLc2vkEcO9EJpu
         mnA6qQsG0ROqzmZUCSTGzeb8zsFNMXRXI2N9fPx4PzZ4Hh+cMuoZ8ZrE4jduk/oq8xoM
         pivibmP8gY704WHSFNstOkB7KjYZvvhtQ0NM68hz6asxL28eB8aP0riulQVEcbAanUyF
         Ol6VID6UHiWFlDCAmUhVM9yspdmzaTuTNwLJm2FCz2Y39x05fnZhNdQ6THKP3A5HGQsq
         hh23ejJMd9iuynmWr0mxOuKiSrxSdo0lsTko8BNl7htSsAKmuygmEqFhWxzWmBSRYZdY
         SIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343830; x=1742948630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
        b=K9tW91uEAfJyw4UCPqsQXn2jdRm6GO/oUhDz0hxt6CX1nM19nCrWad3Xnpat7Nx8vL
         GsttbltHKzvXqN2qQW0rDMTGR3/tcy3KuST96ZPSkPi3NK5XtuTQlsb7EKrwbnmm9/3Y
         Ct+Fl05C9sYRQPr9V8mXNBLXK682Hk8Mq2kWOk9u0CHk085B9uD4s/zqaVaG0XTmI0Sh
         1gq+y96QcfUfo9mGbx96Fq00WGRq80MD1TekRXsSdEACpG43uHj1lrot+/6GPx/b1VNp
         0ocqcLeyS36HAfsP/01Mz+95tFyedIgPTJkf6kIZCReeaJSdhnCq7jpsm6wTgdYiDmN6
         Gpzw==
X-Forwarded-Encrypted: i=1; AJvYcCU79lrukR+azhrgxNUxBo+is0oy1zvIJPCd9Bhzuq3MK1gHd7bzFA8N3TC6kKTvpKKIH5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBYBVa3Oj0y2ofWze3zbn7VSbGYYm3VJErw9osT1uHtJr2Ohs
	md1SIJr6pkfNNx56os1KoBBlzjjD7c7SCgBJSybVooKWXCt622lZ54eVd+jHGz5apeCO0uOIP5u
	wS1dSjf4BV3UtnvHrNDCkhqNf5RICjvIbIAcYAXH12JIiXplDtw==
X-Gm-Gg: ASbGncu0A01FJjEaQkLJTiINUqgAjGkunLRmqNnYBD2AIkRHvO7ms5UxMuRoZ5DE4r6
	roGrE8d1Y1CJ81kbz+K2mA/9vCUGVbcwJ/H8VFCtuW8xwwEyTv1V2OaycJEku4a/poy+x5fNocv
	esBAKp3gkhufH+DKVCyOTn060rEpM4ABdVcp4GXGws5ov+vNjcxnJ1AQ5AVsE=
X-Google-Smtp-Source: AGHT+IGAg3gm6xcgEvpldHOk0wiidpIISM3GLbGX3jslKDaq2dx3VyAOsINBeODpxJOtk3JmOsjXiOlZ3gFLsRxiSPg=
X-Received: by 2002:a05:6402:b69:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5eb81b8c191mr22972a12.3.1742343829794; Tue, 18 Mar 2025
 17:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com> <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
In-Reply-To: <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 18 Mar 2025 17:23:38 -0700
X-Gm-Features: AQ5f1JrOgO-zOChED-mTj4S7Sre5dsbE5gJlbFB8WjWgHzHsbNPXnhw507shlS0
Message-ID: <CADKFtnThYT4Jp1Nio8iW+uEdj8+khGmAYaLxW-w5LO4tnLZdkA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

> imo, this is not a problem for bpf. The bpf prog has access to many fields of a
> udp_sock (ip addresses, ports, state...etc) to make the right decision. The bpf
> prog can decide if that rehashed socket needs to be bpf_sock_destroy(), e.g. the
> saddr in this case because of inet_reset_saddr(sk) before the rehash. From the
> bpf prog's pov, the rehashed udp_sock is not much different from a new udp_sock
> getting added from the userspace into the later bucket.

As a user of BPF iterators, I would, and did, find this behavior quite
surprising. If BPF iterators make no promises about visiting each
thing exactly once, then should that be made explicit somewhere (maybe
it already is?)? I think the natural thing for a user is to assume
that an iterator will only visit each "thing" once and to write their
code accordingly. Using my example from before, counting the number of
sockets I destroyed, needs to be implemented differently if I might
revisit the same socket during iteration by explicitly filtering for
duplicates inside the BPF program (possibly by filtering out sockets
where the state is TCP_CLOSE, for example) or userspace. While in this
particular example it isn't all that important if I get the count
wrong, how do we know other users of BPF iterators won't make the same
assumption where repeats matter more? I still think it would be nice
if iterators themselves guaranteed exactly-once semantics but
understand if this isn't the direction you want BPF iterators to go.

-Jordan

