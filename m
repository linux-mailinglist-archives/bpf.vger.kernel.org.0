Return-Path: <bpf+bounces-62011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61FAF0529
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FF64A6E9C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F262266571;
	Tue,  1 Jul 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1DwpLOQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524B1D07BA;
	Tue,  1 Jul 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403318; cv=none; b=bprTDriZCjZqyYH0kCVnxBQuF+KWk0k8CWU5PAM5+VtyfWiznplH4pRrnDIEWEdJEQ83+fXpXSW0ZzP9Vj1X3kPw3heWzvaUoc3WT3AfQcB8ZcaP1ObxzO+REjrROGRo3uSAAWfeqppInSmyLrETZHGMhGk14CzDULk4h3iLBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403318; c=relaxed/simple;
	bh=PbdKLwPjiGNGvVPwvdPD6XkqZigYiv+OD0jrVchgHK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvaItJskHBy0ReWg0N+axSNaqdwhrZ9albUv6c/qu6AzEHcxk1cFCJoU1mLPvO2HGsql0g8QFi/6+cOniQ04JFSXtgDuft1coTJFlhWApsRxO2JnIGho9YvET9chLdlwf9MHrjLk00LYHAPt+zHYWwKSC1gWvj8jZF57dmWehl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1DwpLOQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so5197421a91.3;
        Tue, 01 Jul 2025 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751403316; x=1752008116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5/gSIdBycEnulz31iGrVtP4/IFTvyrluwTtgJGa3VM=;
        b=D1DwpLOQ5iVb/4wJm7HM2Hj0PQqHcujwKvGGwas15KJDuGG4heD+UONPNKkKVbZ9XN
         EKZ0GgUtuH9gWfmgXXnL5idTj1zBEagiBOFTwuWoqjbG1aouNiUHW/iNSet1pJvuDVdg
         GoQS4Z8HujMBWnb2xrko1qCOwwTW1mbDX7rRBGTJTXeJhW/JQecd5BayJaQMAIDnKzZA
         pTv9Yk4Pv/fUgKf8cAegx6c8IZoeOjgNM8OI3fi1E15nnVLl1kx7UI5/4+FtovXqqinf
         +RhP+5tkQSYtqqa3d9m1tdbpHTpQKJxrGbT4SZnNz5X2atXxU0ovAWFS5rigkvL+sA62
         RyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751403316; x=1752008116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5/gSIdBycEnulz31iGrVtP4/IFTvyrluwTtgJGa3VM=;
        b=PFd/Vefj9VXpa9G3gs80bLytKk05q0nf2/Evh0O3aKt7FfFlWgtIzSB3ZThUJvdOot
         KE549iVoWP9N4lQbodKoCmqgqN+fqbj2144xJ4/601819j8tJVdOE3pwHurproeR/r+r
         nCHtIIEzaff4vwRNDsq8ligssK16vOT/vSiwTKnpFvrjit0eqshKc3EmBRQz301xmBl2
         GzbHRLIMXa8+F5g80nzj7GbgXIh8jxqvHw6lcTzQihL1f+yF3l9rSi4cnldHYjC4AR+B
         76QsUc/pvWdEk34ReLIAREN//FF+4ay94qT2raYhxQIX6RbvRgWbjK/RGrWmkqEihDON
         PaRw==
X-Forwarded-Encrypted: i=1; AJvYcCUVoCxfxyeWVSIGcK+EglOEuQOpmGCqbeByL0vH3cKah7sV8Dab/b4YKC8ZD7Ew7ImAjeFzLdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYh+4t9IJ3lyyqKIqbLUUYSKCiic6RXB25gwOhQfPKn1rx4+rf
	p7kwP5pRxgX3ofx16QuyF8zS1KUyBuJ4nQXlaIaOmlOGr2bR2EPPxfraz3H+ftNnUVxKsh2fUDg
	G6X/nI/eMq/dVWIcdwK23ZklNLCoPZqE=
X-Gm-Gg: ASbGnctfAXdTxGAwAt0No1XPUxjr5nEtxCTuTrzrn98mK93J0JA187iVf/6B65x9we4
	Q6F1CiKSw1jAo9+kID36yYGEi4GmVEMSZjfbHb9rgaXDpL4PhihxzZmx/Jp1PHiwTaTgHNWZSRc
	1i5o4YhjJXBFSSdVU4/jBx6C0cKsFp89VAOIWjKlcNLBzU70N7qMLITNpkQic=
X-Google-Smtp-Source: AGHT+IFPdFAba3ESpCCnWZ+7mE545RmsnnQm5i/o9pUEe+j5srWeYpQVx6E0cF7gVUbogNFRJbGFUesHvJR4ZLo00HQ=
X-Received: by 2002:a17:90b:2784:b0:313:20d2:c99b with SMTP id
 98e67ed59e1d1-31a90b97277mr532067a91.9.1751403316114; Tue, 01 Jul 2025
 13:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
 <20250630-skb-metadata-thru-dynptr-v1-1-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-1-f17da13625d8@cloudflare.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:55:01 -0700
X-Gm-Features: Ac12FXwgNx8P50L5QBWYHcus2XJksf04FElJKzeOZZrJNyKNbT36HVv1JZUY-uI
Message-ID: <CAEf4Bza_=HUKT6_sxrO=xC37DGyTgnvKtqd9Zdmq-crbtdTYSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/13] bpf: Ignore dynptr offset in skb data access
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 8:23=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Prepare to use (struct bpf_dynptr)->offset to distinguish between an skb
> dynptr for the payload vs the metadata area.
>
> ptr->offset is always set to zero by bpf_dynptr_from_skb(). We don't need
> to account for it on access.

Huh?.. What about bpf_dynptr_adjust()? This is a wrong approach to
have some magical offset values.

More general question about your patch set: is there ever a need to
work with both metadata and data as one area of memory (i.e., copying
both metadata and data in the same single operation, or setting it as
one thing?). If not, why not have two different dynptrs, one for data
(what we have today) and one exclusively for packet's metadata?

>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  kernel/bpf/helpers.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

[...]

