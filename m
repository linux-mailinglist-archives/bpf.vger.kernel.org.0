Return-Path: <bpf+bounces-60069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DACAD22FB
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767D116A6A3
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043792139B0;
	Mon,  9 Jun 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VymgnPd1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF843D544;
	Mon,  9 Jun 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484318; cv=none; b=HNAs0Hq8elU5nOEC9OS3FWjmXCScM5t3RtFdGkVPgbOWwXiyvmm2Ops6CfdjEkMSW6ZsJZHrCdEW0gNbooRJSgwOTvhhFEgQD1mobhzjLBy8Qy5yySsPeGIGe6fmbqaCfwjymQ5fe4myGTTO+rhSW0G7Gc7iORuf2oJMEaR70f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484318; c=relaxed/simple;
	bh=s64BLmWnfaM1vIhzNh+zo4arXIAPHhvLNQvOr3AmvR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPWrqjR+zNgCREvmmHBclmEJuYnD5r5Gr0DsYtJ7mf+gcTC+8oBwNr4m+Hpiz+afq47WFoXCwjYe2qtS+JfyuA0jOJ5D0Ew2ntGZzoFIbdgxE+MtJ0E/ZooHJadQoDXIKDD0SccG2cOBEIyddfakn+uVg0jKMtWXbzoX7ywYmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VymgnPd1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so1154144f8f.3;
        Mon, 09 Jun 2025 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749484315; x=1750089115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clLX/uroe3gYLiyc0WLjLQGuYII2RVMuYJR/xVsDYms=;
        b=VymgnPd1hrTWPWk6XMjidMbbTOr0cPXyG73wc32uPCef1TWrqQeJ4LekgyEm1v6Per
         9nlxhbU6vnsjSiyLBx7Ao4v63SORcPnAvYDfkAcFyIUugtjds2YF+6ISyPYhsPFrNEBI
         0fINMkrNWQ8UB4d3/Tsg6YD9Wbt1qEwTPBJtA9byDsRyeVcRJ7PAK1mIwqvQGXIGLZ8a
         T9jULR+d5/Mx/q8eF38hWtT/lKna5C/UwO0Xb6+N8mzmjWYQbM0ZMHynu6zBS0ELFwhQ
         Hw7tVQZglipjkV4QISaPxs7MJG3pEo1EgpkQs3K/Fqqguz78FWQ+9IgDyvYUoVrcKIUA
         l8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749484315; x=1750089115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clLX/uroe3gYLiyc0WLjLQGuYII2RVMuYJR/xVsDYms=;
        b=FXx+cvPcE4jlgcaVb7rCFIhpWyuoqhOntkRIqeGTBzqxKlC0WYcZ83zn9gxWKGociz
         RP57fGpnwGcsyUitpspJnOHrq0ZrsQTr9tsX0fGV6nIDz5B8Q7AXz7tckB6UF3zJE1si
         ufvUNVk0FtKEnkw4K3Ugna4d5gUijNnLTg4g1NhUvjvu+1UTbAWhgtir6rOuSab4Q1DE
         cF6fHlnCgU3+loPl6vbQXw9mJqnpO5PmDxZeZs5iBpSwVC/r11bVKDwf/azuPuCdbYr6
         YdoNWgQEFXQLoLLISC9beHavIEBkQe9meCo9jAHlm61HflLhvVOD0jJd71UcITnXCYWR
         ACew==
X-Forwarded-Encrypted: i=1; AJvYcCV7ukApb3P8J1c7tQ+ClRvmcQfOPyTfSnHPUcMhpjwkAgbC9Sdyr/dbEPCircXMxWSvxms=@vger.kernel.org, AJvYcCVM9KLYnv2UrOBITJe1ewWckMsyLoWy4qRXKNtW9vU1KkWZpg+ZmJ3AfPbxLGKIMFX2Ez14dNNu@vger.kernel.org, AJvYcCXXbh87K+4GrbJXIYruwfTEDX2as1dZ3H5Kcgos6zeLt/Qe44ek4QPnpCWfzL2inQ55hHsXu+azGsDssF/x@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNC3N6auAC4ACuank9W58yi6pEHRj7m6ilz6E0zV9F5ZH5yLF
	9Ch2E1Np0khf8Y8DDoBV+8XD8uVYizhgHvrl9Cz0B+aBetf92c+T633qWaaRTkipLJt5Qo5WuQ1
	lso9hfQ38Yp2wZItpdH2AIAKzzUbcpys=
X-Gm-Gg: ASbGnctypgm2pt7fTBVcQjnBJTuZOyl4oDr6ZtbYa3zrAnhCDFCZaPVZlXLpzCv/eaA
	pfyFRtwng2Zp0tR46Ks4qlWbIJEgb9QQOpq1SinGNAqs/jpwINpUkh+GYb4JFr4rebgfRH4V3B5
	lPEkKcPAYunZN8620kmiwvV84IvBO/C15Es2mnUnGqT9UG3m5a1hBPetWK3l375g==
X-Google-Smtp-Source: AGHT+IGd/auF1dsHAeUUw3cW1bqncv0x0TPUZfk6gX2HXWg3VCovHGbOFafUUgThYO8/qWtAKPskOQF/zRIGnx35G/E=
X-Received: by 2002:a05:6000:1acb:b0:3a4:ebc4:45a9 with SMTP id
 ffacd0b85a97d-3a531ca80ecmr10296668f8f.19.1749484314421; Mon, 09 Jun 2025
 08:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
In-Reply-To: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 08:51:42 -0700
X-Gm-Features: AX0GCFvpkGJzjbMKyAFdZWIDTS0SQLwEme5a3oVOV4gg4DU8ivK2rKsAOzMMG_4
Message-ID: <CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix RCU usage in bpf_get_cgroup_classid_curr
 helper
To: Charalampos Mitrodimas <charmitro@posteo.net>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, Tejun Heo <tj@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 8:35=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
> types") made bpf_get_cgroup_classid_curr helper available to all BPF
> program types.  This helper used __task_get_classid() which calls
> task_cls_state() that requires rcu_read_lock_bh_held().
>
> This triggers an RCU warning when called from BPF syscall programs
> which run under rcu_read_lock_trace():
>
>   WARNING: suspicious RCU usage
>   6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>   -----------------------------
>   net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usag=
e!
>
> Fix this by replacing __task_get_classid() with task_cls_classid()
> which handles RCU locking internally using regular rcu_read_lock() and
> is safe to call from any context.
>
> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed0ec
> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd834884=
50edad4e129bdac 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_pop_data=
_proto =3D {
>  #ifdef CONFIG_CGROUP_NET_CLASSID
>  BPF_CALL_0(bpf_get_cgroup_classid_curr)
>  {
> -       return __task_get_classid(current);
> +       return task_cls_classid(current);
>  }

Daniel added this helper in
commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from v2 hook=
s")
with intention to use it from networking hooks.

But task_cls_classid() has
        if (in_interrupt())
                return 0;

which will trigger in softirq and tc hooks.
So this might break Daniel's use case.

Daniel,
ptal.

