Return-Path: <bpf+bounces-54349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA28A68098
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 00:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F63B7BC0
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6621B9C9;
	Tue, 18 Mar 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LQ6ScVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA121B1AA
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339362; cv=none; b=oGHoigTR5Nms4HV7HlZjQt1MTkEyuOqFDqwiFYquliFR3kt3E8iELdV/kItcgeDqqK2j413+SSl+2Xoc9RIF0GQNUO7Z6UO5ZhiSnT5GfNJ3g4MHEwj43o7c6TvRajDsk4N1Nxr5nNe2Dh+fEQdr6DesYu4L/gmXnQ9spckxsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339362; c=relaxed/simple;
	bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N45AYWZQBp+pv7sGndWhrqrkOnpablHQtPhau+Y6l1d4ebhVJ7SuF0a7dhmA/32lH6MMhMZS8IQD2V1kLmhB9hyPDmpnZc/rgEHfvxAs/XseqtgGU9MipIaakluoMGlhDpXb4M8iDxm+Rlojk6tIz2RU9Gt0gnj4O67cnonxkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LQ6ScVA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso4514a12.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742339359; x=1742944159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
        b=1LQ6ScVAdyd4rbEFiHLne0XG0Juv9SuwjraC0cFjQAlxJbMeq+gVlVUIoiaXKbLzq0
         ngwlkQmnxEPT5fR3eqCY0QKgHQ/37fevs64Ls4svT11v9TqzSKahu7SXPdmBpSdiZS6z
         766Z4QIAvrt2x8hZOKQACfN1Hr+dv0fWfInNDjPqYtffHEqmBufvCXssi3Zvr6Diur0M
         ZHkP0yMNdypXNHTPGsJqGfTPdsANt4OOeIQ/BTRcLaz+PhJTIBVUPND5u455ThxoVdlW
         K6IQePQI2XjUc6iMAF01xixolsx3VIN3Kxkvx9OkNx24MHjMuLSLMuV6nsY92DHmSpbK
         XGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339359; x=1742944159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
        b=JEZt4UtHWwQREB3/rvqwVexR+6KKZOtlmCKLVOr/vrmriq+2MJLz4q3IAQY1a72INt
         Wi57zApb9xwH9ICBTJXqBEQXqLfKB39Pz15tzVPr7Z2GtfM0dRBaO4L73rJGOkcHNFP3
         +I85jtsh43dxkvE984KdNxTq+Qtk/5vSVoL8tuQICepUSkIua0rV2sDGQKr4IaAjrSqi
         L9wRcIUJyIcmKOpypf6Et3Nko/3T1KwWZAHqBXIFEFQl239mv103AVT0QyGdqAF9M33l
         JYv7T2WyI5OUJZEjp/yp+bayaTQdT4PMghB2C5XUyKoesbt7xSXtiTM0caUmumKvDL6H
         rf7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ye7iAc0u0pbsu5ZxmF4sY7YpaNokqD237LbgEYm4bjI4GrrQa5dymqR55uhTXa4mTLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw258FCsLq2s7bVlS1Sn+SRuq6rCFtzBdwjXuQRhJc3KkJ8jz9h
	oLP7NvvebOYO8ui0Yl9XbKL2uFQxn7dn7ysNFr7hsNmRQHBbLb7ktu+0AL/to/GW3UVJZ163+HS
	QgrHQeoLxXTMmce+jPf5jFlEKwZHOnuiuV1JAk4N4wooetBrOQA==
X-Gm-Gg: ASbGncuERYsvFeLjOFMx2fUvPOveI3s34jfD0WVmX8ClkfcxQJ8/teuKnLdF7puhzsZ
	OXyF28Y4LEYlg5fS7STawNeY7OLrg4zMYq/F46DBz2fQkYBaO9obHX6RhcYYslH7WNaOXyIwJJA
	3MD8qmURJFwz4PSwYN5DRMwrOQpjN/hJux1kmE5AqzgEHgvxMix9zgnMS36NFGw37wvJy55w==
X-Google-Smtp-Source: AGHT+IEsS9pm/A9P/V339kq6NeUBWm+ldWZJQGcdbNeUaYnUKDvIpT7RGPZFNexJOP13xEMNFsnOLbUAIuVUzdrZGq0=
X-Received: by 2002:a05:6402:1d35:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5eb7ed71195mr38522a12.4.1742339359123; Tue, 18 Mar 2025
 16:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
In-Reply-To: <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 18 Mar 2025 16:09:08 -0700
X-Gm-Features: AQ5f1Jo43ErVitqTSrfP6TrQUvNNw18_y7nhpcpHwmZNUAGOxPs9C8GthE5lCGI
Message-ID: <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

To add to this, I actually encountered some strange behavior today
where using bpf_sock_destroy actually /causes/ sockets to repeat
during iteration. In my environment, I just have one socket in a
network namespace with a socket iterator that destroys it. The
iterator visits the same socket twice and calls bpf_sock_destroy twice
as a result. In the UDP case (and maybe TCP, I haven't checked)
bpf_sock_destroy() can call udp_abort (sk->sk_prot->diag_destroy()) ->
__udp_disconnect() -> udp_v4_rehash() (sk->sk_prot->rehash(sk)) which
rehashes the socket and moves it to a new bucket. Depending on where a
socket lands, you may encounter it again as you progress through the
buckets. Doing some inspection with bpftrace seems to confirm this. As
opposed to the edge cases I described before, this is more likely. I
noticed this when I tried to use bpf_seq_write to write something for
every socket that got deleted for an accurate count at the end in
userspace which seems like a fairly valid use case.

Not sure the best way to avoid this. __udp_disconnect() sets
sk->sk_state to TCP_CLOSE, so filtering out sockets like that during
iteration would avoid repeating sockets you've destroyed, but may be a
bit course-grained; you could inadvertently skip other sockets that
you don't want to skip. The approach in the RFC would work, since you
could just avoid any sockets where abs(sk->sk_idx) > whatever the
table version was when you started iterating, basically iterating only
over what was in your initial "table snapshot", but maybe there's a
simpler approach.

-Jordan

