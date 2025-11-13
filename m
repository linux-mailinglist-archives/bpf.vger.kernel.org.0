Return-Path: <bpf+bounces-74421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261FC58C9B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6EC5006A3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902933590BA;
	Thu, 13 Nov 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BHgmJ2EB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AB3570B0
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050697; cv=none; b=UGoOyXXzi7Hp7CvPDFlqUCnjPqxsyzQ01HAow1XiQJPqNUXpW1HEKwLOVf4ATQa64OZSEjBWVbqWIE6CVMFYyrbgGx7W6sd45wKuoAi3JfMkwZc+ARXTI6c16pbvjfGuFnLpidKp5MJZLHO0zm0m0/aEQg2sKcLQe3TZFjUnBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050697; c=relaxed/simple;
	bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A37bNs5fYZhogS19q6zXwWgGYRlWZS4XLnudZDSD0AcwWVqtqdrRXoX28d+GTWAu9BaV43xd7N6DnL3CEDgH5l2FbwJquk5BX8zIRaa6kYBKA/+CQuJ8DJjJZzmFO1X1KlLYiBirOFC8pWD/p8IBt7bhtaVlSNdjnVCwEdsrj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BHgmJ2EB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e393c4a8aso787238d50.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763050694; x=1763655494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
        b=BHgmJ2EBDTpWPP3qkTbIn3JsDcrP1jC8Q6Jr4p3td2XPEwjqZw07xbruvQpZpCcIZr
         draiyokg9vqA+fy9C3r4pWFHZidfHaMH+KEn1nYGrKY51d0OYDMLTzkSdiAoy2p4VJrR
         QKES+l/CWxbj4iSlZuq1OJMdoyclTxgdTQnmT44qSFrqYE1iNZawrTGh29SbEsJ9hvGa
         pDQB4rnTPZHXKrhaMcHePum4hYw/ITHf5/hgcC5ATYar3gs8fSbdB5fs3Db1X40aA1tW
         sNpICo163DCMiIYx9jIrHLn/onyQRs77pH28suIOeGylRcdeqz+dnktA9D6ID7FCwP03
         2HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050694; x=1763655494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
        b=BI0STFLpoob5H9Pc0sw4P6tVX7kP7vq6H0PbYaO5OrILC47OiDlOgvjoIDu61qa7ge
         Xp6ZolHPi/r70TGK+HiTjCv1xNlSfyzbDQiBdGTXH99exW3fPnpDsoP60Czx0BruLwj+
         H1rwaU/uxRfpxcTplE7THqoVAhUs96en/IL5eiR6wLaDs5HjJtPebh711eJMV5ur5QS8
         NMSpHkdUETix+eCgL+PnVf3PEx0eQJ4Q92Fk2VaNLg45OhH4nFvwYTI3hRscEqDVbvSZ
         zzyfFR87aQslp0GqpRuV7U4tfYAV6rOkUebCB2L9mp3VqupRgNyj4q9sD/ifquWcaGe8
         gwjw==
X-Forwarded-Encrypted: i=1; AJvYcCWqhPUK5UcwTaigii9v15FLrboF/N3k5jIBrSeht5d4meHq+kpBHZzHuhDO5phvxfweUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/e9oqXdg1UYCIP/W8N35DEG/CNzCZHAdgqQpWN7gx8gJOQIz
	GkFRqYcpdgoUa7eq0rIf1ic4xeag9oevtUqwMWvVgK2b2cPYFHGTK/mRJcUXtfKgzlZVMZuOk0b
	azSCwMvEWNZ9sdzLRWOrpgeIGTZlGuqhDGFlhQ9en/UusWBOpHcGV1yYu
X-Gm-Gg: ASbGncv4uqHQrtt52Odehx3ddYubZsIEbfR/LueAI6TmLwibGASNNSOM6xtUcavYLxn
	wwXdHJ/gd6wJ/4syUOBeXi+87RXMJYIRq/IPFPQi4YriTF3CsFIyJ6tXZa8SN1BzJtqFLZk9/rm
	uQcSb6R4BSb8dCWuuvhKQVpZx8K2e7gbsX/4JC8+gPOuYxIFF4AC9Mm2nGf7sejBwCwA9Hn7T3o
	v02V0wmXVtt9O8Yb37+D0DE9LITotULiv9Oh+xMAvkHco9XRSVIkchpGgcnAstD+SAJ
X-Google-Smtp-Source: AGHT+IGErZ56xqXDc0nriOIEwuDATL/9+5vVIOypV8eSxeuhuE8+8bWn/vQNaQxp2XxkJyi+X1ZRT16TEpBMSe2+Uy8=
X-Received: by 2002:a05:690e:7c2:b0:63e:2250:2210 with SMTP id
 956f58d0204a3-64101b6b517mr4235182d50.59.1763050694408; Thu, 13 Nov 2025
 08:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112125516.1563021-1-edumazet@google.com>
In-Reply-To: <20251112125516.1563021-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 13 Nov 2025 13:18:03 -0300
X-Gm-Features: AWmQ_bkVSq9BKbnWo9UgM0P7k_nK_I88bNwebCnPmmkKyuAty0FVOlVCN-1dcZI
Message-ID: <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
Subject: Re: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot found that cls_bpf_classify() is able to change
> tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop().
>
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop =
net/core/skbuff.c:1189 [inline]
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x=
76/0x170 net/core/skbuff.c:1214
>
> struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
> Extend qdisc control block with tc control block"), which added a wrong
> interaction with db58ba459202 ("bpf: wire in data and data_end for
> cls_act_bpf").
>
> drop_reason was added later.
>
> Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
> storage colliding with BPF data_meta/data_end.
>
> Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc contr=
ol block")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GAE@=
google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Paul Blakey <paulb@nvidia.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Thanks!

