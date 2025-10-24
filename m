Return-Path: <bpf+bounces-72157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37DC08191
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD03BA8A8
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0B52F999F;
	Fri, 24 Oct 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDWPNKfn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125B2F8BD1
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338648; cv=none; b=iCyJ1XqveSlkMD0lIMZzrHrdJQnvvvH5EgyeJLd87jcfr5A1AmF+KVQF0FOHt5OcHRyfCjAosg3PuUNPRbCiOZR+OXaTYI5kRXmaL4o66dZwQbXNFrsR99zyOZ5fdDOckWnKmqPLnZhriiilUUqDMogOUErLCsCahheDrJvXfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338648; c=relaxed/simple;
	bh=RNvLYaINM6n6Q8orahjUExiUrP2C5m6sUpUU/3kkhqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq9kpifhOkHZo1FB4RevVzQMkeTZ4X0ClF4Nk83Nhx7f1FGBkusSbDLyHuyq8aovf5u8QDwtJQaTXWgJr+D4MxUtBNcQk0O7GOT3o9tnjFk+32aZFpbiwCVDTHcjpMYZDnCH5mVJtWVujRmdReebnZ5s70ROHY/7WomEJjrm2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDWPNKfn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-421851bca51so2220903f8f.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338644; x=1761943444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=PDWPNKfnvOhNrpgNr1ziFcM03mI+9YAvFLQAzHSj3aDY34JkaBkH9tC3AFFMKPOP9K
         9kQNxp2nOcYfiKGF5kvvnNuR5x/AXJVMoI64cH7TWP5IIYvqRJ4QO5Pt2WJEwvhuDFAZ
         5iVb5lbJPASH5XKtCHouixKHVfroqrcwCWERpMIpoWCSz+mpZc0Nu7ElmVOlpyfpDyHv
         5kd8b8HdQWoNyl2h+KlslQW21M+sY7ZhWNQ1QbIjZgTn/Eae8UpDtQ+5FaFYY81E1p3i
         FHHcYD7OJztPzUefeU8NF9+eiw2KO6YXqunXYNlMvWJraKDjeK5SVp6VxI0h2Oo+kZLL
         OHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338644; x=1761943444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=VqY0B9PLoh7s2pAgNVl7utvkivm3JqyPnEckd14QUivCHb/FEDa3S3BA4dBhamldXr
         8PQVarK1w3lHpG/tHzOURUVZOE0HTvRvDxazX85XiSKXWmb3kcOgvYASs/E9IaOR5Cg+
         bgPKcJpKnfGQxEJg4qsYPfjHK00jCtQjSZCs3fJFFjnL1ndA1fDcfun2JW7+CLBkgtIz
         ay8S8d5YIY0lwZd9hZQce+VmacPrlM2iLRysFJ2/XkI8DdMbcXzsnIw3aBs2zZjADQ1z
         53rXwPJOk6zREWKa3Q/rpmyMjPTmggRBwdvn5EBF+8t9Ir0le/aaQDawam8vxEwQBJ3A
         zQvg==
X-Forwarded-Encrypted: i=1; AJvYcCX/SoVhVRc6Es4K9OHuBaOupGS2Q5jloC3yFgDGdBkpHyMLpGZm3fqBFqWVgj/QpNWxCwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGlTGBMOvBhoaVqhSyHwLyQrrpbSe4HzZdJZkPOnskkdg+F0nu
	I28Otouq5ZLNWgtenxTMF5Yz7YzCj5PEKOvjCSUwP85BAX8tui6ICAHO9sZiK6C6uGwtNM5ulYE
	EndhTO90/ZZwb/h1vWHrlmMU4n7ZSyvQ=
X-Gm-Gg: ASbGnctO2/PH49pTpPd0TsCMrXhRhwOvnQRJ+9RHqnYhxMjJcNn6A+Y23LqdcmsT86u
	riOF984jmef4jfl+Gv2kalJQz5Najeebm0Uh7oatuGSewpLNYUAvg80HuO7OAhMRjEJ6KIkPVuE
	ciF0YdEdpopkM562VygoM0WpCa8Rq46dtan9vE4EjktDlTEuM7+WoK+z9W+RrJlgZ5kGVtHWUOT
	SE4IFN3Yr9l9+TVb/sfLJiiQ810oX40s9mCx/r04oZNGNVoSwQy2k/uLH65B0Hl9oQmONnyR0eN
	Sn+WFQ00wmiVvp8g/VavTpRJ700d
X-Google-Smtp-Source: AGHT+IGLFt1YCHWbNyJyaEpr+22LPb9d3Q1kWYq7cFolvy1jDcRdvp0v3rx52ay4vxC3D1vRjgD3rmqs6Qx2J3gTPG4=
X-Received: by 2002:a05:6000:26d2:b0:429:8a81:3f4d with SMTP id
 ffacd0b85a97d-4299075ca93mr3213632f8f.63.1761338643874; Fri, 24 Oct 2025
 13:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 13:43:52 -0700
X-Gm-Features: AWmQ_bnqGo3VhvdnD4VDhLrtr6dWJQ16k-K7Ue44kfB0ODJ6fAEdUY4Nt58fKuE
Message-ID: <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
> @@ -5599,21 +5429,18 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>                 new.inuse -=3D cnt;
>                 if ((!new.inuse || !prior) && !was_frozen) {
>                         /* Needs to be taken off a list */
> -                       if (!kmem_cache_has_cpu_partial(s) || prior) {

I'm struggling to convince myself that it's correct.
Losing '|| prior' means that we will be grabbing
this "speculative" spin_lock much more often.
While before the change we need spin_lock only when
slab was partially empty
(assuming cpu_partial was on for caches where performance matters).

Also what about later check:
if (prior && !on_node_partial) {
       spin_unlock_irqrestore(&n->list_lock, flags);
       return;
}
and
if (unlikely(!prior)) {
                add_partial(n, slab, DEACTIVATE_TO_TAIL);

Say, new.inuse =3D=3D 0 then 'n' will be set,
do we lose the slab?
Because before the change it would be added to put_cpu_partial() ?

but... since AI didn't find any bugs here, I must be wrong :)

