Return-Path: <bpf+bounces-46410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20519E9C2A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B74B280E95
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624714F9EE;
	Mon,  9 Dec 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyx79l9M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE814B087
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763234; cv=none; b=rmnTR6r7odGEQwNqCdz+7t99tDfVWxP7a0J1iWYZJaVVAgM/iytmgukEE1EZs9rf2KGzwEQTh0yHJwOUkYkittlpJbxhI4mM0NIvnM+jy45muMycHhqkmroY9jyWNcf5k+gNAnGkqDghxIk7ASfGy8HsxIby5AO3t1l9Es8SmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763234; c=relaxed/simple;
	bh=aV2NHYGYZdGhNs6mRGtTqtCLSWQ7JYDEr3TheIATDz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut2zOKbRb6khYOJmYcv3UGRPATQOQGBTi/FGqiPN66llYjF02pgzuCaBor9dnDovnCILqU4sxZ2S+VVRNjmCcWHCL9wNpJzVk9lMTVI+lvA3k+LUxSmbLMe4YT5AwqG7i9eeg3+bk7MY1rScuLNDUSyhJCXmeaMKMBJBiEEfsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyx79l9M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1737823f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763231; x=1734368031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//oDK+P0PwVINvQ9TsTw8hKynWreE+f3jvZRaCHCPdQ=;
        b=Kyx79l9Mq+pcLJGBztRIgwJ72OSZf+RKJF8X6ByXYdZIdp6YCSLbwzicC8ACsXAoJ9
         HWtVovP7/lvGXGP1s/gJoprFA08C6OxDBhXiecGzsV52XHUYsLMx/1q0WgPrv+pwLX6/
         ZBKjbNhAZQCXbnYLZAww4b/2QCkNjhv+j2O3ZNEq/GYoZUPx1x1aN8UK2ajUKy/AacMu
         CVbtrAaMos3SEmxqEDoMRJN+mzgIbK7Jwx5tHhIAGlGvZUwnHpv1FdFFypdpMtHSiQzR
         Re0HVOnrdNI0ZrKHHS4kiEqKPxdeUhGEMu0tMopfO/1Whg73+hp2iB4T2l39W/LYGzNH
         3qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763231; x=1734368031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//oDK+P0PwVINvQ9TsTw8hKynWreE+f3jvZRaCHCPdQ=;
        b=ErFRkN4WPpTxvrx3/zPwT/D+D7qJQ8r4OpRzmEKbQUaswIom/0ThIwioqWthFGTBVG
         pIzPr02O/sF1dnoYuG96d/72s+2ozVr85eN4A5xt08SukFHc0/6x8ht0uCVB9ItIaBqB
         uNMmnQ9FYz29uy1Ok+pmOErlJWMDFXpgzcyOWpnuEsT6/op9ZFeA7zJBgnZIXpm154D6
         JeCVKQYpPJwpb49z1bmDVtWHEABb+nS3FZo6q12eCYrF0cDyJy6iBwpjPGhbUe/hg6M0
         rYu1XchlFd0bQlSKRkGRjQ0hzD3MftGYHaIDr9M3Oa69qHu8JZ7bMcP3IUFs6/4rjCAf
         wJ8Q==
X-Gm-Message-State: AOJu0YyiuQBreqiW+fu3SCd5OBIDl31fb3jhDbZYI0PJaKxoDo4LbZjG
	tKNflFXbKVTsok31V3KoJ0mOjP6kqhWl+Go8hX/RAlTVs3SSYzvJTnMKbQVCq5JFHo2D1fONVD2
	ztm+DWODHVuYG+DTgRrMe/QzsdNs=
X-Gm-Gg: ASbGncs0mFuRBxV0DJeZW9n3hstjobw23tajkZEv4xp8scpZ/tB5U2gp1keDL44CgOf
	K1hIr9ZxPjf/z2NYxvGJRZn7tcZtPUIvhkciqe4obssaSyNc=
X-Google-Smtp-Source: AGHT+IGYYts0lJXv27kayZwGPmNQZ3BPlkRjBp0YgLtoCXHppt790Z6JvJP/PnJwyMOYgEC5WcEv7iCw3A1my+iFVpQ=
X-Received: by 2002:a05:6000:1a88:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-386453d658fmr1016343f8f.18.1733763230470; Mon, 09 Dec 2024
 08:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206040307.568065-1-eddyz87@gmail.com> <20241206040307.568065-4-eddyz87@gmail.com>
 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com> <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
In-Reply-To: <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Dec 2024 08:53:39 -0800
Message-ID: <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global functions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 11:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-12-06 at 12:43 -0800, Alexei Starovoitov wrote:
> > On Thu, Dec 5, 2024 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index f4290c179bee..48b7b2eeb7e2 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -659,6 +659,7 @@ struct bpf_subprog_info {
> > >         bool args_cached: 1;
> > >         /* true if bpf_fastcall stack region is used by functions tha=
t can't be inlined */
> > >         bool keep_fastcall_stack: 1;
> > > +       bool changes_pkt_data: 1;
> >
> > since freplace was brought up in the other thread.
> > Let's fix it all in one patch.
> > I think propagating changes_pkt_data flag into prog_aux and
> > into map->owner should do it.
> > The handling will be similar to existing xdp_has_frags.
> >
> > Otherwise tail_call from static subprog will have the same issue.
> > xdp_has_frags compatibility requires equality. All progs either
> > have it or don't.
> > changes_pkt_data flag doesn't need to be that strict:
> > A prog with changes_pkt_data can be freplaced by prog without
> > and tailcall into prog without it.
> > But not the other way around.
>
> I tried implementing this in:
> https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
>
> The freplace part is simple and works as intended.
>
> The tail call part won't work with check_cfg() based approach and
> needs global functions traversal reordering Andrii talked about.
> This is so, because of the need to inspect the value of register R1,
> passed to the tail call helper, in order to check map owner's properties.
>
> If the rules are simplified to consider each tail call such that
> packet pointers are invalidated, the test case
> tailcalls/tailcall_freplace fails. Here is how it looks:
>
>     // tc_bpf2bpf.c
>     __noinline                             freplace
>     int subprog_tc(struct __sk_buff *skb) <--------.
>     {                                              |
>         int ret =3D 1;                               |
>                                                    |
>         __sink(skb);                               |
>         __sink(ret);                               |
>         return ret;                                |
>     }                                              |
>                                                    |
>     SEC("tc")                                      |
>     int entry_tc(struct __sk_buff *skb)            |
>     {                                              |
>         return subprog_tc(skb);                    |
>     }                                              |
>                                                    |
>     // tailcall_freplace.c                         |
>     struct {                                       |
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);     |
>         __uint(max_entries, 1);                    |
>         __uint(key_size, sizeof(__u32));           |
>         __uint(value_size, sizeof(__u32));         |
>     } jmp_table SEC(".maps");                      |
>                                                    |
>     int count =3D 0;                                 |
>                                                    |
>     SEC("freplace")                                |
>     int entry_freplace(struct __sk_buff *skb) -----'
>     {
>         count++;
>         bpf_tail_call_static(skb, &jmp_table, 0);
>         return count;
>     }

hmm. none of the above changes pkt_data, so it should be allowed.
The prog doesn't read skb->data either.
So I don't quite see the problem.

> Here 'entry_freplace' is assumed to invalidate packet data because of
> the bpf_tail_call_static(), and thus it can't replace 'subprog_tc'.
> There is an option to add a dummy call to bpf_skb_pull_data(),
> but this operation is not a noop, as far as I can tell.

skb_pull is not, but there are plenty that are practically nop helpers.
bpf_helper_changes_pkt_data() lists them all.
Like bpf_xdp_adjust_meta(xdp, 0)

> Same situation was discussed in the sub-thread regarding use of tags.
> (Note: because of the tail calls, some form of changes_pkt_data effect
>  propagation similar to one done in check_cfg() would be needed with
>  tags as well. That, or tags would be needed not only for global
>  sub-programs but also for BPF_MAP_TYPE_PROG_ARRAY maps).

nack to tags approach.

>
> ---
>
> I'll continue with global sub-programs traversal reordering and share
> the implementation on Monday, to facilitate further discussion.
>

