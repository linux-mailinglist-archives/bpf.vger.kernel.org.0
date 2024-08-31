Return-Path: <bpf+bounces-38671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283A96738B
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 00:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BCD1C20F76
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0F17F4E5;
	Sat, 31 Aug 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kET/rtR0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B23C30;
	Sat, 31 Aug 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725141975; cv=none; b=HWQvKHMuu2jfmFG7sCJ5jWgs5QZvjmOqouG+6MDKFkfEi4dHk/Bi3lQL8x8ihrKaoeyp4atGcH98TwgRnXzdCKMr7n6Wk7yTBScNxDJ9TlVeEr5K8I6PiepAFb4ns/RtWV6vISrfL3uO6I5XePEtYaKkjkmOfi9276nFIWhSiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725141975; c=relaxed/simple;
	bh=SaG4v2YnHLzt1RXp0KJ5QG8OnHu3vxxOvQ8JcKO+Bw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuOwQvsajR+1hWEaGf6g0BOtWwnEQzt7ja8+LcxuJctvjnhlY1cQKWF946VtZMnVWo/7amaEva6cprBy5OrdoXJSEDYPdEoMY5+ZeyFEPZsB+XPoPLwoFQ8r0+IZTGR3Hp6d8EWggOkiw6v3Jr4X0BLdaIYVyWjdSckAU+4QYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kET/rtR0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374bd0da617so613426f8f.3;
        Sat, 31 Aug 2024 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725141972; x=1725746772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHiTRjE5wPqafGdsOpFQFAP5aZVxpmACA5LO9Bj0aoQ=;
        b=kET/rtR0aB4AU+Feptbn8K6nUO2NxQwGjIXQp6Flw/AdkbrDXy84/xTyr5CDHT0GhT
         p2E3Mta2imZe/ip8JTa+xFvWLANGpRww5MZ9C6v80d4kGThkIlX2hLqO1iHlz2+pjwsM
         s85+nNfvKHkOeo72sP4et8YwwhlfdCLNcDgxXj9Wv0jOtTNGp0FUIgm/gIOIU4f7Xedt
         T/VuGSOWZtVKDeJfl8WYTOsMpednbCSwJXz05gVgtyT8amd8mDILdGOE5480V7ZDDRB9
         yzHlelkvELkXTE2MoU3hJOArjDp8Wos0eMFHZJ7O/nrAdupEj/950crlM70CADDdoUPl
         15AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725141972; x=1725746772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHiTRjE5wPqafGdsOpFQFAP5aZVxpmACA5LO9Bj0aoQ=;
        b=U6pazPXYooTS9GlbthRAOfgTmzzb0bo/JJfZXpfrb3nMO0ROwxrWcKTkFLVMVcez0t
         e7Pndj+ddpBCrQ3ykAcjY/orWMu2mCtn4hXSfWL4oKy5tmcTAham2JOFYNREkzARZO9U
         JJ5pQAVyl0K9H4uKUhib5DS0Qx4sHvz9W1o673pDl+s++qTpL2/zOoBaipN4AtojGv3w
         m5Qizf6iub3q7cgka/FqkJZGAQ8bsuB5n2RP22IkuKzRMSihzTZYR/wsOuUrin+EZ4er
         keIW9zPu68yF9QPVUlbvhg/oiqZUhyMsgYtiB83NTwM5f2cNna9BgtpUIaoPQgDvjlfb
         tO7w==
X-Forwarded-Encrypted: i=1; AJvYcCV4JbiarnCld94YfbvxxdASJuXsppdTba3Z2zRskinfYj21NxWl+fEadG5ZAk9JIk292eNeq8U+@vger.kernel.org, AJvYcCVYTKZysqq2fwEQSPr/v33cM74YuAkQ4CG0qwKX4FA3rNj6QjINK98ce7sU9tWLoCyt1MT2HsJvAySrtm0b@vger.kernel.org, AJvYcCXuwtz24na0pEsJ8flBGKfEb/W639rD5BdF7PCq7XAcN7WLe4DI1/VXWHxisPLBWraMlkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhTQnVQKL1oc+KQaHt1wSxMOC7Nhcl7b1G0lfSRIVNV/PhHDU
	E9YpEmFalDieaQ+V6HRCkLQy4fzQt2KIvtUY13OnQ0k20kxLzR/73mZm7duZkN3ZylIawUWXwiu
	iOtdTRB4Kxzcr9M/PNbEkxs7ZAUg=
X-Google-Smtp-Source: AGHT+IElcSjXVcepALYdR4g4ZBYS52ra8HL1nFrQuNIj918KyHcB0GxmzUlRohlXi6yN7dyNwTT9La4BHx8mt28MpUE=
X-Received: by 2002:adf:e5cb:0:b0:368:526d:41d8 with SMTP id
 ffacd0b85a97d-374bceb003fmr2076156f8f.23.1725141971473; Sat, 31 Aug 2024
 15:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com> <ZtKOAKlNalVLIz2E@mini-arch>
In-Reply-To: <ZtKOAKlNalVLIz2E@mini-arch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Aug 2024 15:06:00 -0700
Message-ID: <CAADnVQKF=o6q2FzssEy9-jmye7+DB=S58KD8=dh=aRR5QTpJrA@mail.gmail.com>
Subject: Re: [PATCH net v5] bpf, net: Fix a potential race in do_sock_getsockopt()
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Tze-nan Wu <Tze-nan.Wu@mediatek.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	wsd_upstream <wsd_upstream@mediatek.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mediatek@lists.infradead.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	=?UTF-8?B?Q2hlbi1ZYW8gQ2hhbmcgKOW8teemjuiAgCk=?= <chen-yao.chang@mediatek.com>, 
	Yanghui Li <yanghui.li@mediatek.com>, Cheng-Jui Wang <cheng-jui.wang@mediatek.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:29=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> On 08/30, Tze-nan Wu wrote:
> > There's a potential race when `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` i=
s
> > false during the execution of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`, but
> > becomes true when `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is called.
> > This inconsistency can lead to `BPF_CGROUP_RUN_PROG_GETSOCKOPT` receivi=
ng
> > an "-EFAULT" from `__cgroup_bpf_run_filter_getsockopt(max_optlen=3D0)`.
> > Scenario shown as below:
> >
> >            `process A`                      `process B`
> >            -----------                      ------------
> >   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
> >                                             enable CGROUP_GETSOCKOPT
> >   BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
> >
> > To resolve this, remove the `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` macro an=
d
> > directly uses `copy_from_sockptr` to ensure that `max_optlen` is always
> > set before `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is invoked.
> >
> > Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> > Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> > Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> > Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> > Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> > Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Considering it's rc6 I was debating whether it's net/bpf or -next
material, but could argue either way.

Tze-nan,
if I recall you were saying it affects android boot ?
If so please describe such details in the commit log next time.

Acked-by: Alexei Starovoitov <ast@kernel.org>

Kuba,
feel free to take it into net if you think it's an appropriate fix.

