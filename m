Return-Path: <bpf+bounces-47199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA09F5EB5
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEAC7A53E7
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F71552E4;
	Wed, 18 Dec 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8qLoPWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1828EA
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734503866; cv=none; b=cnP73lGqU5hJO9F+WePzw/qhaCjdh5F3gvVh0CnIBGwMeCsvZV0sHf654NoIi3oiTxJ8q5Sal6vfwQZx4iBuVUWrRxlENbv0LxCXw5LVczBg2BLw+OAVIXnB1f8x9wWr6aZPPqx9JGEvZqp4v8gwY4DsVPvxIrrmUscwTdtZy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734503866; c=relaxed/simple;
	bh=t8Mk3izOcHmuKvHbpqkUDiWbVNW0WzoRhTWnOD8p5lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuMBrgxA84/HoDzlueBJdsEupRFF+mv+1s567WGRaae39BeXg6Y5cHnel1OXUBDqs4tS9MMw6UfWq224TdWxlCt5Dl9T9LX850M77TmZfCd7U1zfAeO0qNKckN4/Ey08r1RASShp1+DYdZVmKZJ1Q54zjSvX6VCxjyJ9vplheCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8qLoPWn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863494591bso3270867f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 22:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734503863; x=1735108663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8Mk3izOcHmuKvHbpqkUDiWbVNW0WzoRhTWnOD8p5lk=;
        b=F8qLoPWn5M+4BVAIA5HXPighYctFWGxWWV7dzeA0YBf78FW+/8yIiAGdxq6PLpEuaG
         HCxMFFdG0hhzKFILLUg1jrG3HJ2ur1dA6ZJTstbFqhq9BlKOIeBFE++CIrNKUXh6UoLq
         fIaGMZnCPkTANAHrn3SDbNM1n7h0iQNG2JIUfdtMdrofXeDJD77idf6oWaYybuKLAUvv
         lGIXSyHe9x9Xwwacr9h0bs2/dTjj0ydbxqzGz0xE/9zbVgQHD/Wc4yv4hOTjMdZapdy5
         IY60jCXqz+6r/HuxOUIzvCNbrZmhvNjEQygCvH81dzjwc0IzA0GULKeNRYx3/O9DvMdr
         SBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734503863; x=1735108663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8Mk3izOcHmuKvHbpqkUDiWbVNW0WzoRhTWnOD8p5lk=;
        b=QCEPdJYswa6j3bG7IVXxVFsjK1n6xzI3HZciRJUSOeVSDYqHcRzym1hJspAs7hg9lQ
         2gGfmOPZm7eGtHyRdWoloTH80bQEpGT+Mdz3z0MJDCGWsjK5g+9Z7rsrSwFv4RABaFL2
         7ykMV5+BiYUwlA8aTGs5lnfn8Wz+RYqTOCU91mfxUzjx4EE1DSXmEkhr5NVRi0bPpXIq
         weEyQyjAgPAxHO3U0ZR8naot5WmobksQZ8nlTvTKPrwaG8KDPmkRS02NoXmIQ/KTiJ+l
         bTKIp33J+F1Kk+C9b2M0cjidYLwcxRg5hURDiUSyqrk38g9xWjExC9EOF944mGWE9RQj
         dhVQ==
X-Gm-Message-State: AOJu0YyFVwBjX/Mlv+nJTjJr32judL5IQI4Dq8FdJxA7kZuoMYzFEzT1
	r/Vj5Oq/mbc5w+EjNrs6Pv7z381TJg4z7zRNwo6Nv1iJm6mWPFN0tnszr9hVN6pjEbpBA7eQF85
	w6iqSa4KyMeF4I6w6wEhXyW6SJFQ=
X-Gm-Gg: ASbGnctzNqxi0YEsp2lWKKHJXcbDWjJF+oOy5C/u79lZvBuvU64da7N9bbXSkncWl/o
	hyDgy5cRcCcC9d1KtvKzevOZ5eg0TqFJk+NEYN+KeUHH9RE/V3mxNEA==
X-Google-Smtp-Source: AGHT+IElSBAJP50/md8YE2jcJ9Pr1Z0TrOnyzymBXoutCc/dlicjAbt8FCGAg7sKIl5ioTOa7sI+QErzdQfe/wIgSN4=
X-Received: by 2002:a5d:64a9:0:b0:386:4034:f9a0 with SMTP id
 ffacd0b85a97d-388e4db7e85mr1033780f8f.52.1734503862370; Tue, 17 Dec 2024
 22:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
 <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com> <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com>
In-Reply-To: <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 22:37:30 -0800
Message-ID: <CAADnVQJwcd=PsdxcipiN8VeJh2UhSv3uzHkX5E5RuLK2vfdSHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> What I mean is, functions like __free_unref_page() and
> free_unref_page_commit() now accept fpi_flags, but any flags other
> than FPI_TRYLOCK are essentially ignored, also not very clear.

They're not ignored. They are just not useful in this context.
The code rules over comment. If you have a concrete suggestion on
how to improve the comment please say so.

