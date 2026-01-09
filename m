Return-Path: <bpf+bounces-78376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1BD0C200
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67E5730131D9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0109035E55E;
	Fri,  9 Jan 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1rWaxoj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4184218845
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988706; cv=none; b=FttUGxy53XcXVkosp0UW7Et593boYvhobvCXrPShhDqPCRO1F6wnfzsAViahBcs/M0RHIz7aUDEi071IY+q8XRh5ibCjc9lo5f9/mSStd+OJwGWne21feDEOBAFdCHsaHaLogGre4sSGwhdVvswP0tTPsgbTnJ97PWChSKK8jLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988706; c=relaxed/simple;
	bh=N4mI29kLpsMIsx6SXly8DxbxF9Em3XWcDPorGzytv50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVhUIzRJFGRkvc0EYiiXejsxDFYfHPAUYXU/oxjanhuWHyI5g2VD4rgMQ3xqs6mVKDyVn8F6zDt+HoPpsrQq0vq4biplOgCKFf6ZHqdW3bURgd5+KmFuPqCrpwIVzfP/qFdmOnEP/PN6E45Gs7satPCv+Wmko/b1YsTjBkxzMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1rWaxoj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2359413f8f.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767988703; x=1768593503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QMmqijmW5OEj9rhjII4BzCWp+Fe1yVoyJR9EVAR0Ao=;
        b=D1rWaxojD+iNYfTchLan/Zqt1m/LgCZLa/uvlGCGOaANqvlJN5C3Cox1oex36CeQs7
         M8DPEIp0FVDFuc/fDEHoJ/kPlB8k8w5jxwtTtel8F31Drakwx5rVwZ73G/GEZXRVudOQ
         exPNdu6dCINiiUv8PYQ+ga9dKBLKAnR90D7UnERzolUeO6oHnHbhm+MiWBMoBPVb4YFi
         aYSN2pCLRQUFZXEjmBupw0Lfqwe9Dz0PYz5b6HPrEY8nso0pSTQgiLjVrPHynv35ZW6g
         ahYTVoTypXeKjWJmTzybHFt82Vj4Ax4WBP6O1J0DAA/gcqdvh3CRbN0PEEVKUFpY4haw
         ZwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988703; x=1768593503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QMmqijmW5OEj9rhjII4BzCWp+Fe1yVoyJR9EVAR0Ao=;
        b=w/eOHy0i9R4iae416Dcu9Pr4tgiGqCpmMG4ZYB0IU1YsUiWl90HfXAuSLMDSaj5EwE
         2M+ntHGcr9dc18rfld9qk5etmuOye/Qs+6D11Is90NE1IgNvp3mSS3fwfNTG2Jao4Rou
         IRwPI/2dyf2V/5yGgBkJeCZt9nm3d/vnX/AAZfD3zHoyykRUqvaRY+9aM/BVxAXQlyUr
         UkFZUDQ7b+xgAgs37FTrv3LWt0lQujZYJ/O2u432/JbproaMZGmC8wNGj+1lIdV4HpjT
         zfKtHf0zL/0uskIBKoFhKHZ0BaZswpEbH39j5iwJl2h4NXz75w37lCts/hxigvloG0ov
         uSbg==
X-Forwarded-Encrypted: i=1; AJvYcCWnffbzbbWYlUoByZPmTVNspB2UW96jUjuNT0cyYdOWBApWjuTWZLqTWPFOeOtb9gBMzTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRll1JXuSNfpmx8Nog11oHcdGzhUTu5HXNJ7r4Jjs1IJwHSu+z
	TqiELD7JgHDe2sT+d92YgiPa0Ngu53Dlj2OgEkQb8h0GJdnBiJNSMr+yMRoZDKyH10+jVfkSPst
	VgJ2i0NvES502PTl9pLhvLFZ5bUWaZg8=
X-Gm-Gg: AY/fxX5O74o8g7ajKsV8G2z0LgnwMGJM27Achmg0LVWVU7a/B4sSGaA8VnBEEozfdns
	8LrvVKYdIsQAPXQD+nGWgNK0CWHwVhymS8psXPh+EB8fgZSK7nSy+0s1bgem18B7yisYUeRYkv/
	VqA8ykmibXwAQOMoL+zTZHnhCaS/9axjGq35H6gq2lsIfLRXshrK2APf4R1GAWpNGCvosO+siNK
	zNhDqFQSE+ViK9w2WeW74TYKHy+H//F+MrDwC2gxsqMHvnpJSXU9dTaaMoNlS0HtTljUZ7SKsQY
	jcAPjAJ9wOtuPagqwmbe+YCPeajXDrFHAB4sevI=
X-Google-Smtp-Source: AGHT+IH31/5/AxLt/GFD0JXqk5ipU8sqfkp5h+qHZjIKs/6CrSBkE8wuiyerR6wM7rrW0+Av3p0KHNxlHiPDHCtG/oI=
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-432c37c1462mr11155555f8f.55.1767988703249; Fri, 09 Jan 2026
 11:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-9-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-9-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 11:58:11 -0800
X-Gm-Features: AZwV_QhLHY-bzxGEAgmV-qRTyW82SDVPwuXlSXHHrs1ojOutmV1JrhtE-366It8
Message-ID: <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:50=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, =
struct bpf_task_work *tw,
> +                                             void *map__map, bpf_task_wo=
rk_callback_t callback,
> +                                             struct bpf_prog_aux *aux)
> +{
> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux, =
TWA_SIGNAL);
> +}
> +
>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *t=
ask,
>                                                    struct bpf_task_work *=
tw, void *map__map,
>                                                    bpf_task_work_callback=
_t callback,
>                                                    void *aux__prog)
>  {
> -       return bpf_task_work_schedule(task, tw, map__map, callback, aux__=
prog, TWA_SIGNAL);
> +       return bpf_task_work_schedule_signal(task, tw, map__map, callback=
, aux__prog);
>  }

I thought we decided that _impl() will not be marked as __bpf_kfunc
and will not be in BTF_ID(func, _impl).
We can mark it as __weak noinline and it will be in kallsyms.
That's all we need for the verifier and resolve_btfid, no?

Sorry, it's been a long time. I must have forgotten something.

