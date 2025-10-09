Return-Path: <bpf+bounces-70703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB0BCB1E0
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E86C64E768D
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B4286D62;
	Thu,  9 Oct 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz8SruKs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F312868AC
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049512; cv=none; b=bxZrt53Ui/88cDorw5NhHFL64yDQDRKlXSsA3alaPuKFFFIxQePLP9ZHDjMKIAaP8T7peTmx2a+x12HbDPg0nU6UJN3r+cGTZkZ0VhH7TJk82Jsq2ALPkVf6sIbM6fwesHeUtEph4TZWU/EzJQRIvnLNhGJHkPsV84z4HSXU1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049512; c=relaxed/simple;
	bh=SGVEequXzpQlmwTnv/DQGNo4OQhhE2kPDPP0GHhqP8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9MYHEWj1j1mGHnVjWLPFbelrdVKoADLWO3burQIM9tQCLkTtgAnNFSXEk0kXJSmiA/JP+jx/WL+1V9piM3xEs7SGeGPT5VjJDg/fjcpA/um6pj4wc6Ur9ZEX6iRvw+Hg2v6tv+hc8//VihspEojomTSFvId9FqcxFBFfIZleJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz8SruKs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so14184595e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049509; x=1760654309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=Rz8SruKsvbo3GP6qvQqm/H5fGnIxTFL+QdUNxiZGydcmoZ4p9ZB0hY3Ljj2witUzD4
         YKxRV4q/50E4BoeilQ2gTyaon1zVZuWykLv4AqrH0er2hKatB3dfWVgi128TZyGBigtS
         XjJOBivxGatOhY9qUhZdu/eGr534iramARvS8A9sWXF3BrIkG1WQO7cHknUCSyqSb/4w
         du/CxixrRnaTPuCb4Ltl2Nx9Y8pkx+WYAVCi0IPDpzCaPs/9Cun/JVgoKNR5JB3bc2aQ
         09IVxI3ykgcHSJgM8T/iGmyVFKHzxP4Zvhp8Qh0uO2o4hE4w1CAsXjwgQY9XII4yqgWI
         Mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049509; x=1760654309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=qnJ2CyVUC5ZmK9ZGTsimQ7KCp7KbkPbsrBUk6Y4IiNbyzSBQMlqpO3ERus1uTtTCNQ
         b7F8faUBWv+zLpF+QUOfidbKodikS85nUw6HNS5cZw6foX8V+1l4gYmXU4u5MaQLQ64l
         j3jxu85eAUFvDg3tOC9fbELgko6LTNqC+IHU9DtaPtwAMk2L6+i48Dd7I4lzYImNREbv
         gC9AUiUdSF+cb6bACFsUxGbHqwesrEfKbeaaVS5H/q+EFxVpeKq2D0PxcYW4OA6Lm+yS
         ReaveUcwus8leNKsaxHYnmq17sX507vTxNyjQzvvQB5sQMdwATYYKo51YJSjaLFe1f5i
         0A3g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4VqdRYT47Jf9bSX5pizY4vu49sCBzR2Yd6PJkIxesV8NUuRIEI9Q+HS7T6R/7iqZyx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxm/GrIyR7CdapjOnwj+SjqOaTrTSxeWVUi/XTOmpWZvee+Mty
	NMWBy22yXaXnH5503hKFuxnUnxiDA97I+d5cgWBEHYPh/7I+CumlpWmrUsekHEXpQhG3ZCifKUm
	GhJUMuyykgaE94jKGZdHt5ce7581IiqU=
X-Gm-Gg: ASbGncsNYgO4ufnwDF//xYzbf/EUIBmtrgw6UAg9b95CB2SKZiL/C6UtIrB2aYvbI+V
	0GcUIAvO7R+gW80xWkScGy7YYQ5cuQZ9jCZLKqnIB70TDGDTsu3UdtfnpvdBG7rsfb6dQ2XLwnB
	YS09aLCuVOIB2RkqhNESZWh0VKg8DY0Gd3qhSbB+Xwa99wPMAWeAVY1W6T3sG/qaq14VtHUZuwa
	F7AnmOG8gDTZt1J5mQKMcmTdMDItU+yz73MsnYs5C9hXmqTcaJWz4cmBVYUKxyfrU9j/HfBVlQ=
X-Google-Smtp-Source: AGHT+IHCGAek9aLYnqO6h6qsaegIprBP2JhFgyiNZ2Akv0snlWVmDL6rPA/XdN2zodvDo8rNlXjq2b+YANheSLZaO04=
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id
 5b1f17b1804b1-46fa9af8f39mr64662065e9.23.1760049508783; Thu, 09 Oct 2025
 15:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com> <20251009222836.1433789-1-listout@listout.xyz>
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 15:38:17 -0700
X-Gm-Features: AS18NWCOSO6I5mHnXsHQEv_1ULrRUw4sT_HIqjSgrJz_CypEeQ9hbJFdbnIG9cI
Message-ID: <CAADnVQKbmTgwXf5WvXACKUNbzs8r+Cvgx6KyyD7Xq1SOL9gLmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid sleeping in invalid context during
 sock_map_delete_elem path
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:29=E2=80=AFPM Brahmajit Das <listout@listout.xyz> =
wrote:
>
> #syz test
>
> The syzkaller report exposed a BUG: =E2=80=9Csleeping function called fro=
m
> invalid context=E2=80=9D in sock_map_delete_elem, which happens when
> `bpf_test_timer_enter()` disables preemption but the delete path later
> invokes a sleeping function while still in that context. Specifically:
>
> - The crash trace shows `bpf_test_timer_enter()` acquiring a
>   preempt_disable path (via t->mode =3D=3D NO_PREEMPT), but the symmetric
>   release path always calls migrate_enable(), mismatching the earlier
>   disable.
> - As a result, preemption remains disabled across the
>   sock_map_delete_elem path, leading to a sleeping call under an invalid
>   context. :contentReference[oaicite:0]{index=3D0}
>
> To fix this, normalize the disable/enable pairing: always use
> migrate_disable()/migrate_enable() regardless of t->mode. This ensures
> that we never remain with preemption disabled unintentionally when
> entering the delete path, and avoids invalid-context sleeping.
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  net/bpf/test_run.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..07ffe7d92c1c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer=
 *t)
>         __acquires(rcu)
>  {
>         rcu_read_lock();
> -       if (t->mode =3D=3D NO_PREEMPT)
> -               preempt_disable();
> -       else
> -               migrate_disable();
> +       migrate_disable();

pls search previous thread on this subject.

pw-bot: cr

