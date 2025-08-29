Return-Path: <bpf+bounces-67025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC6B3C23D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C6317B280
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257CF341ADC;
	Fri, 29 Aug 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwYnzDEq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449721019E
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490905; cv=none; b=o0eDBJfpbowHIs/KtGMTtnWLwM+Q6gTOpFURHuvKf7mlRHJt8qv/lUxaki1vsfZCwnxEAq321IB8JCjnuqMHCitCrqKNXeGkAR5XMpOynLdTXeEHLAlbg387/uE4yD8xhPLEMo01rjkadRJTpnacBGaBx0hY49kgHm4Q8hcUKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490905; c=relaxed/simple;
	bh=HDx5V/8//nfyMVU5SRKPwg4PNtnxi2/Sb1ZsnReyUZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJYRD6Hoe0IjT+B7beo7CaJv27UrYI8MtTiTiVu7a+xVdJtvvCAnUw6un5w8fZiwBB/tdroBwR0gD0hyhitesSQXydLgOsCveI/IxQW53edZSYrqaY4oeL/6+Cnaw9Hs0BFK8ceCOJTVeU6P5rwe79XR1zc/zKWp7M5SI4THHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwYnzDEq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d19699240dso78396f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756490902; x=1757095702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3m1WKlrX9nvL/osiO3b+5+qfn+hUxZ6/K0vc2cIJY4=;
        b=SwYnzDEq7IN2Stem39w0qnwv1o1BASg9tNpHN9Bg6jr7co9L3XLidoi0CaWhpmp4dN
         ErmJVkUrqSVyqLpHrfXCrxJY4EN2V/+L+cM3Lo8pU5jyoKbaHdNkX/HlbTxuDqTzRBWm
         tJl2Mnr2nx3uKfkeJy0Nn1eiPFWn0k1bjjVk15b5Tm0Dy34izoVBmYdVH11ZOtPP9pm7
         3hmt3nPKZPUJNQ8M13cfDxnkKmo7ZdCCWZiqqbLsbGL7HrcE21ybzQECHtVvyUROxQqF
         xYnkchqfVggLtUgCTfKkAfsYQj9jYwmZkfe21oxdIyGSOkQ2RlAJAXtqnYiK8lyQPHK+
         xA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756490902; x=1757095702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3m1WKlrX9nvL/osiO3b+5+qfn+hUxZ6/K0vc2cIJY4=;
        b=rhbiogblKX1yvJlxXN5fSfvbfza0SO107RoN82peU9B3aIC/6r+KgF+s7e1hiCq6i9
         MSCTcFz84oDcAEysbDuG7Ux6B+SXMtMlT9xxnHCG5KIcbaJ6Kv7V6iLOadW2Wg8lRyN3
         OZCoJVWURTfPJsiHvUyPtMhAwPzABx1ISaeS/NdzTG9yIkB5PNM8pi5pN/GXCirlO4ta
         ++0QgNAzj1lP7d/RmsyCcHgZyGExxjlAo+OKR/qTb3pNPgOakHXEZJmhEk819kDzBww5
         mFhZIPBZF8MU2udUGgDCpHt93OhuNAm2ZEa/CMVnFQpMAcyv75M5loHa+OWRKxql2AnK
         a7hg==
X-Forwarded-Encrypted: i=1; AJvYcCX8IQwnZOcn68ePcM5SbN/cYrH10xG6upcNzvpMBRiaQQyNPGGG8OKcKSs3F7D+mUWVm4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzej6E/G6O+0ZcGrJZP7G50bqL1ZTNUv+xGzorSklLga8G6jm+p
	ITGHH00Fr1hC469RVKidvbJ3sSZXipV3+sdBHlHIHurpu0JrOGmurOUXCO5y/V8OGfgwFN04Q+4
	ykKLWMlI6LVUQVXwH+x2hcJ7WxNegcYQ=
X-Gm-Gg: ASbGncsDw1VBRkC5M9E5/yq1coEjyv7XLRxOQg/v8Fl8wGGXnV+9zqaxDYxAH4LvZ24
	lbw3jvAxhuuohgkX10DWX3+eAQsMk9wEnoH0loedBDKXExz4c5b9sFevf2K5jElKeIEbjhFZmDp
	83L7xdSpPf+OlcT4ABJu0AyFBvY8APx8/m8OLnyY9yF8Lt8caZuP4lTFitO5rivdZuLGAJMtM8U
	1MnjTuVvro8iZdaJU9kISGEkImNxlsDrKC1pglvGBn6
X-Google-Smtp-Source: AGHT+IGqGLkEQYsla+jQbVU/AAnKjwHT2ZHXQpkP0G1N9mNtXicPSBpmlOUiyTXmMPS4ZT0WfMjeJ9AyKv47vXu7ql0=
X-Received: by 2002:a05:6000:4022:b0:3c6:c737:d39f with SMTP id
 ffacd0b85a97d-3cbb15c9d73mr11831539f8f.3.1756490902240; Fri, 29 Aug 2025
 11:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev> <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev> <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
 <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev> <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>
 <8ab6e14b-e639-413e-91cc-56dc02d1a4fb@paulmck-laptop> <42f91ff0-b7bf-4ab8-90fe-4ce42eb6bb75@gmail.com>
In-Reply-To: <42f91ff0-b7bf-4ab8-90fe-4ce42eb6bb75@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Aug 2025 11:08:07 -0700
X-Gm-Features: Ac12FXynhZc4samTZi22jwTv2WGnug99HdFlcfLD2Hym8uSLOEzF501mjopBo4s
Message-ID: <CAADnVQL=c4B3yT18DfFP9ecgd3BL6HvnUU31Wcn0in_3+a--=g@mail.gmail.com>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
To: Leon Hwang <hffilwlqm@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 7:21=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> >
> >> Independently it would be good to make noinstr/notrace to include __cp=
uidle
> >> functions. I think right now it's allowed to attach to default_idle()
> >> which is causing issues.
>
> Nope.
> ./bpfsnoop -k 'default_idle' -k '__cpuidle' --show-func-proto
> void default_idle();

hmm. indeed.

Jiri,

why do we still have this in selftest ?

static bool skip_entry(char *name)
{
        /*
         * We attach to almost all kernel functions and some of them
         * will cause 'suspicious RCU usage' when fprobe is attached
         * to them. Filter out the current culprits - arch_cpu_idle
         * default_idle and rcu_* functions.
         */
        if (!strcmp(name, "arch_cpu_idle"))
                return true;
        if (!strcmp(name, "default_idle"))
                return true;

