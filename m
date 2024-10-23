Return-Path: <bpf+bounces-42965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA769AD852
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045841F2263B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C41FDFA1;
	Wed, 23 Oct 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU6pxzv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2E1990C4
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724884; cv=none; b=nPE+dvZt1Awxq5JNwUr4piaP8b3dm1HrF2peYaKxFimWPyW3kVfoAOTs+4xFuYUron/Zn0S44ejbaDdKIt8kJd0DXVmWEXISHpzJ8lIvEjEwKq8JvjNP8kL3Gvt6QXMPi+Gxxvbe7tNOQ9Wt3+p5KSAX9tWV+pjWWY+69xCcBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724884; c=relaxed/simple;
	bh=DzLE49ibICaABEhYDoi/xSKlJ5ilVQo4WJVvQV6PN40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRgz6zRGW4eKFT11qJ+XcfPfKi3EoJ0+B7UNq5jfXrkfakSYyn0kMreVASsVEPI8X+vRayBWL5ZY+ZAzpgWOEAFKrNX2JeSOA8E+bkjOP6mZfg5sO+4dYjTv1oXBFZpn+f8+Ks4/5kV1tye2bQnL5fRrGUYPakjnL/xcJEhXfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU6pxzv2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431481433bdso2624445e9.3
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729724881; x=1730329681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzLE49ibICaABEhYDoi/xSKlJ5ilVQo4WJVvQV6PN40=;
        b=UU6pxzv2uGTJ5tPXQlZ+02H+1z/btnRfawITrP0+EdioP+DMed0bfCysoZgq6id3Vj
         E1rbtqU2VWQsS98Z07cgfR5CpjybWTQrXWE8Cd7gy5O/xum1IkPSxcYG2hjMLH59Ao98
         8eLomiSE4io8+Q1tuoN1AHnUn15GqlavwNXVZeRuhrM1PJ21Zr38i9gpefjICF9E30Eo
         DzvubCpyS7a7Ly0i7dZAI5KNQPXuO0UBMyP7ubbWOo4WZX0KWzGPOtoOcqdmsxomP9Xs
         X72HXJzFtyUjqpIPWW6L1oDenCcGCwndNWskkhJTKkojCBIlB/5JZF+Y/s4r8DR8cmC0
         WzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729724881; x=1730329681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzLE49ibICaABEhYDoi/xSKlJ5ilVQo4WJVvQV6PN40=;
        b=C8Dmzw4YQBabPu0K0B7ylcer7Q1Fc88BEBnVmtnp3Cw17zUxiufCenFwITVP8/4Xi6
         XQDRY10NTqBLMHRaPnDC2A2K5L4yGKhOFdrW/Bz5/1AvCFod1kfMStW7oBkuQ7hiMbe8
         oMw60B+lN6wYculpMJUoZZP1DtfbxnWr/6e+BthnvuxocPURWgD2QvrI9oj/RqpFXiOR
         pH4UbX2aOsrCGF/q62iPDXlCu9bBFqtTY4d81ArY/cE2E1FllM3EtUJHq05yn+cZQO3V
         b2fd02zCezsqj1CyKm+mKVX8hVuDACsqO7A8LMFxOuks22sdyCdKKLph1IZXdDqA3oJ5
         VKug==
X-Forwarded-Encrypted: i=1; AJvYcCX3rU2TrWLuaiezUhRa5C0Rv5Bg9ZQwnAYa+4O2UrZq2m4oUn9Bz6rPGCaERG0u7MqmfHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoC/JHjIv/eQMk20ENbd581g+YxLDHC8xDuFl/zsMHYIePnhKk
	rFzN1RooUD+PU0VATwH+p3fTEsvu1TarwV0I4dMRzP5mRqDPonQv9pAqFTi1ZedErEZKZtq3bAw
	m+7wwClN8hKEvQCmFAJvMmCOH8n0=
X-Google-Smtp-Source: AGHT+IEqflbTjP6KCIgdVwN9KAx3/xfD/N6qYtIAfo+2AXhjFOg68lICkt/n+oXQKA92J1lJkSEXXhCIaDBQNbpbHaU=
X-Received: by 2002:a05:600c:1d1c:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-431841b2026mr33234965e9.30.1729724880571; Wed, 23 Oct 2024
 16:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191400.2105605-1-yonghong.song@linux.dev> <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
 <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev> <CAADnVQLEy+VXVeP96DK=U8wTL7Yj_=bTuxz5FBcVgDT346-2qA@mail.gmail.com>
 <ZxlkA7AiHJkG8r9M@slm.duckdns.org>
In-Reply-To: <ZxlkA7AiHJkG8r9M@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2024 16:07:49 -0700
Message-ID: <CAADnVQJLmBuzMJAp5h-QAcO1zvbuBUkprib3HZ7nUAfTeHGAug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct ops programs
To: Tejun Heo <tj@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Oct 22, 2024 at 01:19:58PM -0700, Alexei Starovoitov wrote:
> > > The __nullable argument tagging request was originally from sched_ext=
 but I also
> > > don't see its usage in-tree for now.
> >
> > ok. Let's sync up with Tejun whether they have plans to use it.
>
> Yeah, in sched_ext_ops.dispatch(s32 cpu, struct task_struct *prev), @prev
> can be NULL and right now if a BPF scheduler derefs without checking for
> NULL, it can trigger kernel crash, I think, so it needs __nullable taggin=
g.

I see. The following should do it:
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3cd7c50a51c5..82bef41d7eae 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5492,7 +5492,7 @@ static int bpf_scx_validate(void *kdata)
 static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64
wake_flags) { return -EINVAL; }
 static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
 static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
-static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
+static void dispatch_stub(s32 prev_cpu, struct task_struct *p__nullable) {=
}

