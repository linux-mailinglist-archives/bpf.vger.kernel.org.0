Return-Path: <bpf+bounces-46378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1709E8C55
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 08:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013E12818CE
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7721516A;
	Mon,  9 Dec 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5tuTC2K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27838215074
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730020; cv=none; b=PhCDE0hhY9sWzkr+zzkJoMU5/16eKmheKyzejgR9+1vrapug30iIA7kNbWcrDcPpdXvdD0wXFuoKwxRWwHOCVxf35grprVjJAPS+E2WhNOq4TmZ2ZiZZcS2i/udxolo8AL7VqjIpsICUatR9SiyjdZOfKF3OropFFci8AlVnKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730020; c=relaxed/simple;
	bh=7OEimS525jP5rBN3jsu3eq+HxHtnoyyruw311a16oPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+t+4zyo8boSDcNmbMbMyLo8ZHYqPkJnVJ2o+8adFkwButfePWdGLOm7F8go1y443JkWLR6FKoxRFWqHqRMxExcymwDAbehV3WVnGS7XjQJwwsYp/e/O/fIE/FakBCqHYByXJc5OZU+L20EHg3NJaMhqo1sq3p3RIUSOf8G1we4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5tuTC2K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so5492865ad.1
        for <bpf@vger.kernel.org>; Sun, 08 Dec 2024 23:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733730018; x=1734334818; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bRKGs+11xz3XeCBOPUrewhfBJnkIjIpqfLWL7cHIFwY=;
        b=f5tuTC2KgJ6Q/alo9W0N0VWOg4iVuQg3NbRBMdgArFL/stHd14WDHQ1ZGjaJaE9eY3
         Oo8YpIWAnwrNViobr5ORcdzUB43NND2y6L1/bRb6PDZIwA8iTY5jyJjpETDn7Yn4hBe3
         Q3F+1YqvivHLi+TAGshkntdt+iedi/Z9Yo1DwnV23+62E+aa/OxzOgkbpHqvlvEcLXkm
         zIAp9v1cGLITez1HA4vpHyoCoAEEIVTF9S7DIjvzcs2JqfteIJq+Gd42rwe6ONyODuu3
         /jSzJdW9v9doB4k3xOY3EQIZO2nKXtxiki4bxwxAM0goYuYJw1ccBRBw5rrP8tF98SgY
         HDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730018; x=1734334818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRKGs+11xz3XeCBOPUrewhfBJnkIjIpqfLWL7cHIFwY=;
        b=rHmbFzJx/Pbp44yEC7t5OHv2HdGtW7s2QmgylZAaPpWZL8hCNUMJCz2nE79FMBXknC
         JbbgWieND4d/BA1IzzUF+lloBtXu9QOPtgt7mJs9hwPAa8gbQKmgPz+NXfVwA9BFRG0h
         PG7rLML0pTDjIdjiTAdIRWrsctwYbouIOVaCIrqalpyWkVoRJ7mFEYTlgGmmN5Qpk3xC
         ZQ4gfDoZtiamcw0o7v7Ut74leOzitPthCZ0E4TXBALQnuwl7hsFQwfa7AnKI8paMVjSK
         WZNdSumwIt0DTKMiURvj/7Z3MyWp7iQ5bmNegyJk0IioV/2bHQZHmVWU1aEkqf/GiHwH
         T4GQ==
X-Gm-Message-State: AOJu0YzB9hF4ZJ2swnSa8L6lPZUY0obPcbaO9rOEtTcS+Wc+AJPqUREo
	Zvdom+KTPswNgCM5/mzI5sLNWQrtQmCnrtNu1OTvr+1nHAjPWvPD
X-Gm-Gg: ASbGncsaYjaffP7ma+tvxHrTp9dM9P6Xr+kgXciLIZh6zc9hiS4wdMLx53rA0KQTooN
	1Ehql09pnophCMyv7/VEYcUcSXxg+hHEUY6+e1+tAFDDR7yNPSvKkvDBEKps4uM64T/A7/VTKxQ
	++KA0s6EcXMuF4kongPd6x5jQiygiyLDkk96UYOuQ76H+pX057BBYxClLeUXz+Y913/JAeJmAVd
	k6U0GgnJpXB+U1ZoIOw5zx4hP5vX5h3b6khZX2gM2l1ciY=
X-Google-Smtp-Source: AGHT+IFNVKrEG07Oh4aKq0trG+lkeIbzm5glw8K4NXky40kSpLNrt9VEHcDoqOSvCd4367LWrZjCyw==
X-Received: by 2002:a17:902:dad2:b0:216:3466:7414 with SMTP id d9443c01a7336-21634667ae2mr105834045ad.44.1733730018357;
        Sun, 08 Dec 2024 23:40:18 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216360ef920sm26183355ad.71.2024.12.08.23.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:40:17 -0800 (PST)
Message-ID: <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Date: Sun, 08 Dec 2024 23:40:13 -0800
In-Reply-To: <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
	 <20241206040307.568065-4-eddyz87@gmail.com>
	 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 12:43 -0800, Alexei Starovoitov wrote:
> On Thu, Dec 5, 2024 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index f4290c179bee..48b7b2eeb7e2 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -659,6 +659,7 @@ struct bpf_subprog_info {
> >         bool args_cached: 1;
> >         /* true if bpf_fastcall stack region is used by functions that =
can't be inlined */
> >         bool keep_fastcall_stack: 1;
> > +       bool changes_pkt_data: 1;
>
> since freplace was brought up in the other thread.
> Let's fix it all in one patch.
> I think propagating changes_pkt_data flag into prog_aux and
> into map->owner should do it.
> The handling will be similar to existing xdp_has_frags.
>
> Otherwise tail_call from static subprog will have the same issue.
> xdp_has_frags compatibility requires equality. All progs either
> have it or don't.
> changes_pkt_data flag doesn't need to be that strict:
> A prog with changes_pkt_data can be freplaced by prog without
> and tailcall into prog without it.
> But not the other way around.

I tried implementing this in:
https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug

The freplace part is simple and works as intended.

The tail call part won't work with check_cfg() based approach and
needs global functions traversal reordering Andrii talked about.
This is so, because of the need to inspect the value of register R1,
passed to the tail call helper, in order to check map owner's properties.

If the rules are simplified to consider each tail call such that
packet pointers are invalidated, the test case
tailcalls/tailcall_freplace fails. Here is how it looks:

    // tc_bpf2bpf.c
    __noinline                             freplace
    int subprog_tc(struct __sk_buff *skb) <--------.
    {                                              |
    	int ret =3D 1;                               |
                                                   |
    	__sink(skb);                               |
    	__sink(ret);                               |
    	return ret;                                |
    }                                              |
                                                   |
    SEC("tc")                                      |
    int entry_tc(struct __sk_buff *skb)            |
    {                                              |
    	return subprog_tc(skb);                    |
    }                                              |
                                                   |
    // tailcall_freplace.c                         |
    struct {                                       |
    	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);     |
    	__uint(max_entries, 1);                    |
    	__uint(key_size, sizeof(__u32));           |
    	__uint(value_size, sizeof(__u32));         |
    } jmp_table SEC(".maps");                      |
                                                   |
    int count =3D 0;                                 |
                                                   |
    SEC("freplace")                                |
    int entry_freplace(struct __sk_buff *skb) -----'
    {
    	count++;
    	bpf_tail_call_static(skb, &jmp_table, 0);
    	return count;
    }

Here 'entry_freplace' is assumed to invalidate packet data because of
the bpf_tail_call_static(), and thus it can't replace 'subprog_tc'.
There is an option to add a dummy call to bpf_skb_pull_data(),
but this operation is not a noop, as far as I can tell.

Same situation was discussed in the sub-thread regarding use of tags.
(Note: because of the tail calls, some form of changes_pkt_data effect
 propagation similar to one done in check_cfg() would be needed with
 tags as well. That, or tags would be needed not only for global
 sub-programs but also for BPF_MAP_TYPE_PROG_ARRAY maps).

---

I'll continue with global sub-programs traversal reordering and share
the implementation on Monday, to facilitate further discussion.


