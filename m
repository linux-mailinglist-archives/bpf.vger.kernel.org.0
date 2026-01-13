Return-Path: <bpf+bounces-78780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D05D1BB98
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F0C3056571
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694C36BCC2;
	Tue, 13 Jan 2026 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy31lwlG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533736AB65
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346827; cv=none; b=jdDCh12iMU/p36VNhzvkcgQKNAVYKAQy6i3w9na0BhdtFP9IevsbsVT7Zzj00u2XoF885Pft8iaP9iws1eq0ofq7/Bje3dCsS8GDX6SbeOXEgh7OmIfNMj4a/dJRtr9HWzjPltZcIaZoItDflXbdyHR+KEwQ2TPgr2py8GkKCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346827; c=relaxed/simple;
	bh=PQjxtvb69+p85Hb04eIo6x789En0DT9HhMnHggq9OYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stgbKVy2fGM2z/dBeHqeXdRMnxFW3dfu2CzZqn4uJbqzznfuCmSM/81XbYw63l98+WJZRBBT9B+o+kK/JZCNQwa0evPNwZb/TljWIweRurhheJKI2A81cR/LUk3sTxYYmTIDxlPWUjL32swtyYT3yy9spyaHE57DwegXL38JaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy31lwlG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee2715254so2155765e9.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768346824; x=1768951624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIxHGmAm1SZZrcYdW9mVCY8ENSWv9Idzn4C9R7aSfY4=;
        b=Fy31lwlGaZHGmOHrhxI5bBsSxLwIFeYcVT+VJubSHgHpJczxz0mPpgbY+nDfnJKNwX
         gTJDnbW0wDxtZy3Qn40QeTKhzjNTnU/MlHQ8K82q0PcYfgWVnQeeeo47wxT1q66fBBfF
         BR7qiL72/CQ6aREj1aaUvHhHIS+TSqjnYJuyZCEvjZH2yEzc4pBKlQJcvmSqzyCJ0qcp
         Db23pTOG8CeTwHHo/118DAlcblJJ3t9Jq/BJwkTe1aWqaGiyQYl8XpcJsZoJpQ7jecfS
         zj+fjS9LbTUarMFaDYM3fpbRqMN5GDcYMdhy4wdJ3a+qIRAffvSpP3x9u+sAeCB9NWHH
         F/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346824; x=1768951624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIxHGmAm1SZZrcYdW9mVCY8ENSWv9Idzn4C9R7aSfY4=;
        b=t0H9C+fl+/Z45wKkyjAJi6heFOAN2CZKem4rqSTO7bozihA0wjvsXixc76qgW21YJP
         BR1AVCYalS9up07iphdTiVxBRY+u6bK9h1QXSn7CKQ/QGVPUcW/Wdq04X4JI08FEDh0v
         XyB2Q6a/96f6ymyM3seUAEWY8osXgaV8ClJwr+Yi11wu1eOvu+TJxLvefyHx70AokOUH
         dMOVh89b6HBZa2fF5U2nybiEtFQ3Mh0G4Re0IyqRzkVH90LWFSHLG6DCDBANfzDYOdeH
         +lCIgVl+2oIiMI+ZC5v/v4HWnRgptFLgpq+uj+nx08NDYUsbOHrwvr/09HzMF2+Ui552
         zR8A==
X-Forwarded-Encrypted: i=1; AJvYcCX6qNj7rTuoYPFSGvCUHxLfFNNdwrOBrUZOZ/8zLk7oIk6whuZFcaD9va+GEyDP58SjPxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVJ+ZNwEX6K1HJsoUxeaFv7dI+/h/X18/MkDUylVdtjxHLAuC
	leZLpZJ0xD1IVW5d15T5v1tUV5L78MUx2xgrSEKE5ilbSuixJFWTo2JRFIaM21suxG2ZkITQpIK
	sLS3K6EB2FGU9WZLdPN9JHEIyW1pSjww=
X-Gm-Gg: AY/fxX7vjjeztstaa4Wdcijp2FHDTIQVN6RcO3Oc6IzaHcKwGbKyQSU/VrR6QUFx5wH
	gg1fw6GrCEbw3RB4LmssDDSphyGmnAzAYmB3CHFrJ3m5V/o+/ULOLsR/jnyeF91y9KIUYHB1Tkx
	AHNOoucZvazyipzO1sLwbNXbhTAQ/ZwUH/ofE17Hkk1d6T3QozUW3P4Zg2CwBThUmzVFxxxfpNe
	n9Nm1XSKWMsXUQXIUfwsd6LMaBHIccpwxvJJrQzAw6KaNTzkTg3PBrgwaYtBe7rap9RK0lvwDcm
	NrzDv7KDF50G8lxKPe6DBgw6Ef6x
X-Received: by 2002:a5d:64c5:0:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-4342c501a57mr685880f8f.26.1768346824132; Tue, 13 Jan 2026
 15:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz> <20260113183604.ykHFYvV2@linutronix.de>
In-Reply-To: <20260113183604.ykHFYvV2@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:26:53 -0800
X-Gm-Features: AZwV_Qg0xd2SuSeZtzkfObEmnG4DkzskoYODoJFcrxj4bx-h7Wvm-bafCffVqCQ
Message-ID: <CAADnVQK0Y2ha--EndLUfk_7n8na9CfnTpvqPMYbH07+MTJ9UpA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/20] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:36=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-12 16:17:00 [+0100], Vlastimil Babka wrote:
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5727,6 +5742,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t g=
fp_flags, int node)
> >                */
> >               return NULL;
> >
> > +     ret =3D alloc_from_pcs(s, alloc_gfp, node);
> > +     if (ret)
> > +             goto success;
>
> I'm sorry if I am slow but this actually should actually allow
> kmalloc_nolock() allocations on PREEMPT_RT from atomic context. I am
> mentioning this because of the patch which removes the nmi+hardirq
> condtion (https://lore.kernel.org/all/20260113150639.48407-1-swarajgaikwa=
d1925@gmail.com)

Right. With sheaves kmalloc_nolock() on RT will be more reliable.

