Return-Path: <bpf+bounces-48891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6096CA116AF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101AA16219C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6F38FAD;
	Wed, 15 Jan 2025 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKJB1OYX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3235952;
	Wed, 15 Jan 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905021; cv=none; b=dQWZOPruVaV2kN4SAg2GF8A572ugPszLxfwPvg7PW8FsCW0qdwCnjqK572w0xYxx0NGWipAWj00FAOCX8f/bL4M1HM+OsbHs0MS46U7oD91rEciBNn7dC20NMiBVGzLSBIwRbJ6W/Hji/DXDf7Li5PFSSUiTiykHbV9zzVGVjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905021; c=relaxed/simple;
	bh=VlL2fuH1xcTEylsDJgq8x2460ruCRLeTPR7D/8O+vXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIVvikRoyoP7kuWIEKr23FV/dK3M73xxDxs7kGPxum9WNIiJsD7n6ARgMb6moAEB98bNWB0lnTFEvHyeacPt6WPM328uZQHjSu42/3Zp5HMP2/iUmCHqiEKHx1wX1vqotPISLD3QNp+JU0iJlrh27bGk1DKU6mNIc5J2qcSM5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKJB1OYX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so3176607f8f.2;
        Tue, 14 Jan 2025 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736905018; x=1737509818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ1zBqhNu/8YjuTWSvGlB+uuuXiyLyxUTjhwIcvniK8=;
        b=OKJB1OYXfJn12XVGl4bKs2W7faMwTQSkqbzpunX88lv4EL1bu0lDc70ESaH//cfVGl
         RUYrmXI4N+rFuDSIiZfzG1xw/zS/wpI8NExWF9z18WQhCNDi1GdkswFuiV10Gz9aDKKf
         dsDtxOB9rOs7q90I5HEK6KUZq0TWzonYswfvf3CIEzOMPxpNBZoZ9kcYYExKnEhavK0P
         y9KC4dPmh9jQ/Us7Ouqkoz71x1cc2zkb9ylPO/qqpMBrtDG2Ql87GOhOjICIAYFEeuAc
         TE0g7mUX2irnTpqK3IJcUkr9OOGvpDAjKgqByCIBea7SYLyLBc8GXMfPro9P0pFavtH+
         l4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736905018; x=1737509818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZ1zBqhNu/8YjuTWSvGlB+uuuXiyLyxUTjhwIcvniK8=;
        b=QREsO1ZEoOXQQO2G6hMRR+fsv0wBV3Rk/TQgq3TMd7IdDAeHwRfY/ZNj1p49vL+Lj7
         yJmb5hHS1f00Ld2l0wxhLlI1J9qmR45w6oD6X4JdXjurVRZYYlX84v28kQ3A/lJWsQMq
         Zzfo/TEhsUxYj19Gkhb84oOjldPS1AHNUHuJv5Rb0Pj9+eLbGxynUPoYnAowmh5uwb6a
         NZyvhg39m79sPNtl6fQr/q0lxFtqsr/NVLk5TBBueloiCUUN1R6d45oMNtLR056N80kw
         QCFhPtROLGSOotfJkP2Hmy0a+M3xAlMVESL4zV5GS3xdZUYjNC2nQvs5e0hncCWuCqro
         /Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCXuSaXnxkDz0lSL4lzWKBlNVIm6DMHp07U9luC/nrByE297Id9MwqqkVe7fC8LdtjLHewVgErY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuoqeHXLBELUzwKVoJnby1zKV+BeEW+hkmOCDXZSijs0N8dOR
	WBhXhXFQq5W9xv5SUZvKJUIAMDKw1TRWIz9gjdeDb5w1J3LlhLX2dmwWNqxzUm0mC5Jypk2jGF5
	9e3MrCzQhrjWdt3YQ2mPgMjkondc=
X-Gm-Gg: ASbGnctOBTw7qTPssR9iL1C7pjKYXp0iPfPbyI/zB5WTg0NbYeWWpw9FFS75NyqvzVP
	ePBXjpvIG7xEFv8jkJqy0vWTLNBZkL6DMuUZ9LMcy8vWfKNKKatt9fQ==
X-Google-Smtp-Source: AGHT+IEfhb5eoQMIzQKA4kgyO2g7pTqRXKlGCrl68JkqJIjHyUC7w/9MLKqWoohRLMWlZmg3/7Rrgk7c2GUTPY5MyrM=
X-Received: by 2002:a05:6000:18ac:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38a872f6ed6mr8868026f8f.1.1736905018159; Tue, 14 Jan 2025
 17:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109061901.2620825-1-houtao@huaweicloud.com> <20250109061901.2620825-5-houtao@huaweicloud.com>
In-Reply-To: <20250109061901.2620825-5-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Jan 2025 17:36:44 -0800
X-Gm-Features: AbW1kva5oR-Ri39ynxwMtvd3LaBw7qcztqogda1B7sW8_5W0yicXSDgGji7cMMY
Message-ID: <CAADnVQKPEPAt4rZiZ33WPpcZA9qiM5hogC4AyCN1r5d_B4Debw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Cancel the running bpf_timer through kworker
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> During the update procedure, when overwrite element in a pre-allocated
> htab, the freeing of old_element is protected by the bucket lock. The
> reason why the bucket lock is necessary is that the old_element has
> already been stashed in htab->extra_elems after alloc_htab_elem()
> returns. If freeing the old_element after the bucket lock is unlocked,
> the stashed element may be reused by concurrent update procedure and the
> freeing of old_element will run concurrently with the reuse of the
> old_element. However, the invocation of check_and_free_fields() may
> acquire a spin-lock which violates the lockdep rule because its caller
> has already held a raw-spin-lock (bucket lock). The following warning
> will be reported when such race happens:
>
>   BUG: scheduling while atomic: test_progs/676/0x00000003
>   3 locks held by test_progs/676:
>   #0: ffffffff864b0240 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_te=
st_run_syscall+0x2c0/0x830
>   #1: ffff88810e961188 (&htab->lockdep_key){....}-{2:2}, at: htab_map_upd=
ate_elem+0x306/0x1500
>   #2: ffff8881f4eac1b8 (&base->softirq_expiry_lock){....}-{2:2}, at: hrti=
mer_cancel_wait_running+0xe9/0x1b0
>   Modules linked in: bpf_testmod(O)
>   Preemption disabled at:
>   [<ffffffff817837a3>] htab_map_update_elem+0x293/0x1500
>   CPU: 0 UID: 0 PID: 676 Comm: test_progs Tainted: G ... 6.12.0+ #11
>   Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)...
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x70
>   dump_stack+0x10/0x20
>   __schedule_bug+0x120/0x170
>   __schedule+0x300c/0x4800
>   schedule_rtlock+0x37/0x60
>   rtlock_slowlock_locked+0x6d9/0x54c0
>   rt_spin_lock+0x168/0x230
>   hrtimer_cancel_wait_running+0xe9/0x1b0

Since this issue is limited to RT

#ifdef CONFIG_PREEMPT_RT
void hrtimer_cancel_wait_running(const struct hrtimer *timer);
#else
static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
{
        cpu_relax();
}
#endif

let's avoid overloading system_unbound_wq in !RT.


> -       if (this_cpu_read(hrtimer_running))
> -               queue_work(system_unbound_wq, &t->cb.delete_work);
> -       else
> -               bpf_timer_delete_work(&t->cb.delete_work);

keep this sync call on !RT,

> +       if (!this_cpu_read(hrtimer_running) && hrtimer_try_to_cancel(&t->=
timer) >=3D 0) {
> +               kfree_rcu(t, cb.rcu);
> +               return;
> +       }
> +
> +       /* The timer is running on current or other CPU. Use a kworker to=
 wait
> +        * for the completion of the timer instead of spinning on current=
 CPU
> +        * or trying to acquire a sleepable lock to wait for its completi=
on.
> +        */
> +       queue_work(system_unbound_wq, &t->cb.delete_work);

overloading system_unbound_wq even in !RT when hrtimer_running
is an issue to solve as well,
but let's not double down on the problem to avoid making things worse.

The rest looks good.
pw-bot: cr

