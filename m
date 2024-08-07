Return-Path: <bpf+bounces-36591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 409C394AEEC
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCBB1F22845
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7513D291;
	Wed,  7 Aug 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3WnMR57"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9913D630;
	Wed,  7 Aug 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051903; cv=none; b=hMDmftbDiNE4O8Ufde4RoN4Dklquv/sYWuzMdkCuEPZacIw1+4NVDoZXSeUPeo2gzphBnz/VPs6A4rg2QnRT/C6kq+vzz9sZl8zlnJ/fMnScbzLpY85/iTkbPi86vDJWTyBeNE/fkGxrCwPKArY2vNXroy037cNteBoGHLx1+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051903; c=relaxed/simple;
	bh=uflYueoD1tLlX3GuEa822CoPP05fKD2n7yhiqlNCizU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ7dD9bvxQv+9Cz3dYPHXamifuX4LU0fsGGniKVpWfyXlWrxrEYGuEsFMu2tlaEmnGk1EF1UBglPyVkSZkqp9dpwhwJnYKSYr/qjsxq1a+0TPfiIUkwoQUQGnNpjVUbmGn2V/ElUG2gqpUlC0o05nVD/uSdAfbFpWefkskYDYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3WnMR57; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cfdafdb914so124996a91.2;
        Wed, 07 Aug 2024 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723051898; x=1723656698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d7J/4yEruzV5At/gWizedTK39nzWjVwsfpwk6woQGA=;
        b=C3WnMR57kK+FTOyfKN5/9NMVuoMsnD8q3ZtqdVNvNV4bD9iJTkRBG8ltQipTmfCQBl
         hZvUkQZJ+eLNq0vQJ69ST4W6CwgC1T6mWtl4GXsfhG6+1nR9zTuNvMxOnPZp5W4eqhmz
         lh6eepMB51TOUmqin8BnaKHEsVMadXHaNBRoukIIpU7pKShksTa+l4uwPc2iho0DLdQz
         670yNkNlRPNX3NHvL1Vb3L/RAfSTdEIZR6oqo0b7MjSIL8WA3J5rK8zyabAJyj2h/yUy
         Ik0dVhVUmKWsw/euPCGoA34CLCWp7ygp3DreMTTS+a5Gq1NP2rKCwXmgXDXkt65tjWcG
         YtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723051898; x=1723656698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d7J/4yEruzV5At/gWizedTK39nzWjVwsfpwk6woQGA=;
        b=gL0BLluG8UhnIDLStvQ37ijAkHZ5wmywgPIMg6xP2BYB5EwM/aVljPNynbJLo+Jdj7
         zxs707LeLiuWRoPKij+9kheYw3loRvTSCbfgC+MPjpJKg8AdvsFC0XnsZ72Ngl3rTUJs
         ruBB8IathGsxlnRSFric2ztWDF70AQBXkNAI4hHBMMmZmgZ9+RdClS7ybtmtrbj1SexN
         WDSGi5az6VpKFe0skdvpXR44286+qnRDa3LcYP9kxL+EGC2aF90a7RHk/BxJzuzGRiSI
         gkH8Ps8jwTa+ELC7dr+XEeU5MNk5TXWD+TiTMW6Um2Z9QhJo2wc6PvrFDNI7K0nl/413
         AxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeaceAqbXA7+YvYB2vT8kUv2F5YaSxJw1RjEuuwR5HBck+qJORy60y0G8R57+xjeTa24eO83O7dMLXaVaTqz6oGJrd8pI7Lt1rZrR3ljDqeYXb7clPWqMgMWAleeoQctEQ48VCi7nAuRJ7kSSOBHBYK42DEv6QoScSSAsFcqOtE38tBb36
X-Gm-Message-State: AOJu0YyMjC9YNDTBruMB4l2K+D9QhMZv+sMqLguy5071Rxl89oJArqzF
	dEEG1RGBTLwgtB/4fL+5KR47uqDo8CJmjncAu/2H/0JC0V4VRDkVDXkv1jQ+dP9CiNYJ991mxKv
	8g1KIr+7TeJzus9McxM6Ngb6cU24=
X-Google-Smtp-Source: AGHT+IFDuDk2NdEDJnyKuXgLW1ptdEIOeOcF8bxBtoUxJzofHGVHtX12rlUAP9/UEpI2QqIJP7Iql/MwpGUcY2sxX1g=
X-Received: by 2002:a17:90b:4b91:b0:2ca:7e87:15ea with SMTP id
 98e67ed59e1d1-2cff9513044mr18575294a91.34.1723051897642; Wed, 07 Aug 2024
 10:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240807132922.GC27715@redhat.com>
 <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com> <20240807171113.GD27715@redhat.com>
In-Reply-To: <20240807171113.GD27715@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 10:31:25 -0700
Message-ID: <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
To: Oleg Nesterov <oleg@redhat.com>, Liao Chang <liaochang1@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:11=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/07, Andrii Nakryiko wrote:
> >
> > Yes, I was waiting for more of Peter's comments, but I guess I'll just
> > send a v2 today.
>
> OK,
>
> > I'll probably include the SRCU+timeout logic for
> > return_instances, and maybe lockless VMA parts as well.
>
> Well, feel free to do what you think right, but perhaps it would be
> better to push this series first? at least 1-4.

Ok, I can send those first 4 patches first and hopefully we can land
them soon and move to the next part. I just also wrote up details
about that crash in rb_find_rcu().

>
> As for lockless VMA. To me this needs more discussions. I didn't read

We are still discussing, feel free to join the conversation.

> your conversation with Peter and Suren carefully, but I too have some
> concerns. Most probably I am wrong, and until I saw this thread I didn't
> even know that vm_area_free() uses call_rcu() if CONFIG_PER_VMA_LOCK,
> but still.
>
> > > As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)
> >
> > Honestly curious, why the preference?
>
> Well, you can safely ignore me, but since you have asked ;)
>
> I understand what SRCU does, and years ago I even understood (I hope)
> the implementation. More or less the same for rcu_tasks. But as for
> the _trace flavour, I simply fail to understand its semantics.

Ok, I won't try to repeat Paul's explanations. If you are curious you
can find them in comments to my previous batch register/unregister API
patches.

>
> > BTW, while you are here :) What can you say about
> > current->sighand->siglock use in handle_singlestep()?
>
> It should die, and this looks simple. I disagree with the patches
> from Liao, see the
> https://lore.kernel.org/all/20240801082407.1618451-1-liaochang1@huawei.co=
m/
> thread, but I agree with the intent.

I wasn't aware of this patch, thanks for mentioning it. Strange that
me or at least bpf@vger.kernel.org wasn't CC'ed.

Liao, please cc bpf@ mailing list for future patches like that.

>
> IMO, we need a simple "bool restore_sigpending" in uprobe_task, it will m=
ake the
> necessary changes really simple.

The simpler the better, I can't comment on correctness as I don't
understand the logic well enough. Are you going to send a patch with
your bool flag proposal?

>
> (To clarify. In fact I think that a new TIF_ or even PF_ flag makes more =
sense,
>  afaics it can have more users. But I don't think that uprobes can provid=
e enough
>  justification for that right now)
>
> Oleg.
>

