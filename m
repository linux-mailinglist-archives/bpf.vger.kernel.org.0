Return-Path: <bpf+bounces-43188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C176F9B0FAE
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EC82859EE
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566E20F3F1;
	Fri, 25 Oct 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLzuIP0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3E1925AB;
	Fri, 25 Oct 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887600; cv=none; b=g+bYb5oJpPOqorFmTQhEZtMq8lhrmu41w6WAubOyTM4bArFXU0hXWgDjEbg25a+oSq1iQFEfM1of5jFRl/3r1DL68ULTulG2uMoFUadHQKz8jjazPSo62PuBjzmPh+pUcUpdgUzZwD1Ty/DsEdLgtIY8n/fVNWx4mlfIPz6BmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887600; c=relaxed/simple;
	bh=6bEB+fOAxemniSq2AOxH1E8k8vt5JlgBNTBAEA9MkPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/EWzxhHTMNzGlGcbmKIq9TYMdL3KYIS++br1rQ9A0JfroaeQTyx1hlgesuRpF2cLmd+acCB+QwlI2mhdY5CQb/Z5isYotV+4MoT3FvH7vLkpku+uqFQNtorrr6ndsNuR+IP1LWBXz88aDIJ4ThHovewv/ji2VwlXJ/K6P7kDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLzuIP0J; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso1542548a12.3;
        Fri, 25 Oct 2024 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729887598; x=1730492398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwAacIoxGRryugNg3Ug4s/B37w29xw8Rkn/6bDM4ggw=;
        b=SLzuIP0JOBPCd3240s2LnxXhvvt1+4FBwdylN74TZyU+8rs5jJloFv9YlaHMsbXFfI
         mW5V+M5DrpqjoO8VU4KVYefITX5rSVnYXxromyUdEce2RQX3tnmytdabuuD5oYsvlDCx
         n8JYogQKvK/KOEGqN4Fb4k9AKjuxY6zAJWP/DA8VtXXiOGhC3OMDVo6ma4xmwa8+nSzf
         8Db23Z92CMquDQsaOV5f4Uh2uDKjbPoaY4PB4AL/ThH+Wu5LNyas/xYqevCwGHkAaAGo
         RW/sZRYaccCzLXpHdYcAfs/4jbUIeIzKEdLEcXS2Qm7VMqnY5/9rISscDavkycZ4ZZJ6
         IgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887598; x=1730492398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwAacIoxGRryugNg3Ug4s/B37w29xw8Rkn/6bDM4ggw=;
        b=VIED58ozuncQouJMr9hv/LbUq4NOuW/nGNlpX9nfKwIJzWlUQczyzOakXmS9OMXGlF
         1Avw+aDwIDos3As2jmjLELviZ6vE8OkYIKmXCWhxJWOdIEmbV6XuIh/3W6Ql32WjSF6G
         VCigYkVPOhKXwzdvnSN71e2h1RkzKa0roJuqEclRSFAWjB8cic36GT7z1PFkefUFr/hy
         0+ADqHA8p21JVJz4Xu5VtnIXbZhJ/Imx07BKIBidZkMNTIpPLnVkmLY/Sh7a5gO7h0OK
         DAp1NxLq5XRv2HoDSjw96WWSi4JWVjkr/7sfMPHhk7joNJhs9O7SaAcbdIgs0P6ROoWH
         ej4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQoSpWWI31UUA0wCm32Z6+cknMcB0e/NgUZ68HqGqUigQxr/VWrvdf39w1dx8v2OHGbmU=@vger.kernel.org, AJvYcCXEKo8cdkvoHHptvSxuoH3twnnlvIKr/7+EqWqY2Xr99+LBgC1oihHNPccCWTSvtpj+817t/cwwmcaC1Ddj@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1XWUNLA+lriJL6jrbfCZuw20Up4Ny6g1Q6Bn/bkLBPYDmB3v
	CzVBodGxHpKO3RFYrxbjz253dOZj1g5U7pO5SFh44imPRpBNz77TOWRoSIJGH+3MKFNuvUvVKlN
	InaoLZQqHgcUazs7mik+f8daqrZk=
X-Google-Smtp-Source: AGHT+IF7JtHK/NhfJ1ZeXfobMUVTu833hYdHCxDwYjfinfXTnLgdEOiO4KgfIPDbamPbnEC3c73SQUC0hcBtNe+8WEs=
X-Received: by 2002:a05:6a21:1706:b0:1d2:eb91:c0c1 with SMTP id
 adf61e73a8af0-1d9a851d42cmr555179637.42.1729887597886; Fri, 25 Oct 2024
 13:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
 <20241025150102.2930213-1-jrife@google.com>
In-Reply-To: <20241025150102.2930213-1-jrife@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 13:19:46 -0700
Message-ID: <CAEf4BzbCT5wmYWF2N8wU-FtujYvmQpb_3zN3v797KScUhxUFEw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Jordan Rife <jrife@google.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	alexei.starovoitov@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, namhyung@kernel.org, paulmck@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:01=E2=80=AFAM Jordan Rife <jrife@google.com> wrot=
e:
>
> > One solution might be to teach BPF raw tracepoint link to recognize
> > sleepable tracepoints, and then go through cal_rcu_task_trace ->
> > call_rcu chain instead of normal call_rcu. Similarly, for such cases
> > we'd need to do the same chain for underlying BPF program, even if BPF
> > program itself is not sleepable.
>
> I don't suppose that tracepoints could themselves be marked as sleepable
> (e.g. a new 'sleepable' member of `struct tracepoint`), which could be
> checked when initializing or freeing the link? Something like this,
>
> static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
> {
>         struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
>         bpf_prog_put(aux->prog);
> }
>
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
>         const struct bpf_link_ops *ops =3D link->ops;
>         bool sleepable =3D false;
>
> +       if (ops->attachment_is_sleepable)
> +               sleepable =3D ops->attachment_is_sleepable(link);
> +
>         bpf_link_free_id(link->id);
>         if (link->prog) {
> -               sleepable =3D link->prog->sleepable;
> +               sleepable =3D sleepable || link->prog->sleepable;
>                 /* detach BPF program, clean up used resources */
>                 ops->release(link);
> -               bpf_prog_put(link->prog);
> +               if (sleepable)
> +                       call_rcu_tasks_trace(&link->prog->aux->rcu,
> +                                            bpf_link_defer_bpf_prog_put)=
;
> +               else
> +                       bpf_prog_put(link->prog);
>         }
>         if (ops->dealloc_deferred) {
>                 /* schedule BPF link deallocation; if underlying BPF prog=
ram
>         ...
>  }
>
> static bool bpf_raw_tp_link_attachment_is_sleepable(struct bpf_link *link=
)
> {
>         struct bpf_raw_tp_link *raw_tp =3D
>                 container_of(link, struct bpf_raw_tp_link, link);
>
>         return raw_tp->btp->tp->sleepable;
> }
>
> where if the attachment point of the link is sleepable as with BPF raw
> syscall tracepoints then wait for the RCU tasks trace grace period
> to elapse before freeing up the program and link.

Yes, that's the direction I'm leaning towards (though implementation
details would be different, I don't think we need
attachment_is_sleepable callback). I replied to Mathieu's patch, I'll
try to do fixes for the BPF side next week, hope that works.

>
> -Jordan

