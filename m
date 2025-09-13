Return-Path: <bpf+bounces-68287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436CB55D21
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 03:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25869B624E0
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5C19258E;
	Sat, 13 Sep 2025 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERTNmwdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638A1548C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725992; cv=none; b=IEl+4eMHY3I1nM8B0FTX7shGb3AqupbvRnoMy4LRv6pAPaghzteNR9fKqbntXJcjaRe36nmP9kvZhjEJi5OVzJnooP/dDd9Ss44MuEFgFut/jC4Mq6BUhMeQC3qh84AGV8AF9e/qm/bDbpDr4bBQ0RL1mTaKbG0wwWHmnV7NEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725992; c=relaxed/simple;
	bh=H4EUXzuwG8g5dEWMNxsaodZcDZGKV08nehR5jB3hgkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYHWqmAmpC1OkGz80+Oyx6LfQvy+zbGJ9Hbn0b07L74NsiCoNjPcg1+xTwXLHJoWrKju6/IHhjbYfnCTyW73jTanuFn4gnbVMrmNk53o41IhNJFdbNIR2WGGE4W4g61m1Sy3oJubbqTwkeAiXyo9nZxb87N1oWPblx5YyfPHebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERTNmwdq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so816376f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725990; x=1758330790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4EUXzuwG8g5dEWMNxsaodZcDZGKV08nehR5jB3hgkY=;
        b=ERTNmwdqvfcHYL8OaOa4ZBtmBH8J7QoqmGjyzKnM371imqby0nDrpvwkuao+egKqS8
         u/hMAKaFwgxT9JgM3LnAdG1RnpEJlS3/t5uGIuMNrPL0R4n2zBkW+t1AJt7Fkyzr1eUw
         G8V+m0ZPknlSvHfpj+OJ7gPiFuQLt5Do9NvuHNUOOO0BTchPRlnVqFvhU7rHgO1HqfEM
         L00oRHlpM3omjR/QEQNDv7Td4Y8BUWCgnR9BOLfFpOYsXJCYsxIpdoqpZoyi84AfP9ny
         0f1nRFhPpVXmetJb4+0bUbnSirFcDHg289UzU1sCom2vKWSZbt9Wro8lc6ndX/pBbUSf
         ffaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725990; x=1758330790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4EUXzuwG8g5dEWMNxsaodZcDZGKV08nehR5jB3hgkY=;
        b=lF+C01eddca2/DaRCc9I88dAlfviRJWwSMhuPC5shi+AgBj3R1U3ygt/tGL2xnYRfV
         XVSu0F6NkZAUFuzMAEeIYhkFmrO1awfHEV0I5aQxCQyDZkj9bW2di9ijXq1CnzeGZJpF
         /kg9rI8mzZTxizALotYRLdAfLAbcxlXkRYnbDJZ2t+NWsgOCRxbW5JlYcW0xcq2AJUi4
         XEujxdjiRlA9pf8BTSTWVZ5Jl78a47nvuXsjg8GpDlqBWU+CN9/vHWP6SYv8NZeMLXpQ
         8WfQJDuRfrJ06bBAwisi/A9SfirqHkPvWJaVXWzX4XwYcCiBHQUzyt1wtMJFL7PLtt71
         ienA==
X-Forwarded-Encrypted: i=1; AJvYcCWiIKyiTi7RJ3hNSEsaf0L7XbtnRTnsRusNi0WC8JURrZAV/suBykL1fHpCGudtZ3pEmC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGfQhOMJW6uYIDr+XaL5GG1/UkpVUqo4A+dObvvF7j//XxY/8
	L+sxy4yzWpOvJHZiNVj41Tu9GINGOCr1SH0wUM+SAx1SShIq3+W1Rw3ZClY/gOSpLdZZKPwJ5rW
	VlTpIf0uS70LwYb6fkNVMxix1mfHPvbM=
X-Gm-Gg: ASbGncsBqNHpsfnEp/Q4ljoqsPSfXNM7EidABsAgnG4y06ERN0Jync+2Bb12N5Loypm
	1D3jqGj9qPZP1mr97l0jx7m8Qmw84GeslP4l/F/z1ILZdRhsbiq/q0Z+87OsykE2Kn0kOQhWpsu
	qUcoyUKHyUHJdeVjikkVk0yfjSFGW6Eqj8487yuWjYPV1mK8ZvXFVWTmyUCxswcpKuZU7wVXfAj
	M6zmw6TkuvDpMgPn2CnYivkWiw/AOnLXZ4uSpsFI4IR3+k=
X-Google-Smtp-Source: AGHT+IHQusnaWyzqi7z8+SdxxYqLwbP5wSVWYadYvwZ5P+qVKkcPKQAbJQ22ri0ioQfEz6fWXRvmCABTnZivxFQqR5g=
X-Received: by 2002:a05:6000:26c6:b0:3cf:3f1:acd8 with SMTP id
 ffacd0b85a97d-3e765a2367emr4974884f8f.28.1757725989506; Fri, 12 Sep 2025
 18:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
 <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
 <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
 <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x> <CAJuCfpHJEUypV2HWRHqE598kr-1Nz_DokMz_UgrUnq8YkFcb9w@mail.gmail.com>
In-Reply-To: <CAJuCfpHJEUypV2HWRHqE598kr-1Nz_DokMz_UgrUnq8YkFcb9w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 18:12:58 -0700
X-Gm-Features: AS18NWAQ_JVZ6ksw_Ihjl7aesVBJtv75f6ANMQoytxQD4Xbw-t5oGghb1fY5kzY
Message-ID: <CAADnVQJQo6+AwJ_LxARVu37J-5T-7tyn1kA5hMVDGDfEyjF6mQ@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:36=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> > > > Suren is
> > > > fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). With t=
his
> > > > patch, I think, that condition will need to be changed again.
> > >
> > > That's orthogonal and I'm not convinced it's correct.
> > > slab_obj_exts() is doing the right thing. afaict.
> >
> > Currently we have
> >
> > VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS))
> >
> > but it should be (before your patch) something like:
> >
> > VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS | OBJEXTS_A=
LLOC_FAIL)))
> >
> > After your patch, hmmm, the previous one would be right again and the
> > newer one will be the same as the previous due to aliasing. This patch
> > doesn't need to touch that VM_BUG. Older kernels will need to move to
> > the second condition though.
>
> Correct. Currently slab_obj_exts() will issue a warning when (obj_exts
> =3D=3D OBJEXTS_ALLOC_FAIL), which is a perfectly valid state indicating
> that previous allocation of the vector failed due to memory
> exhaustion. Changing that warning to:
>
> VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
> OBJEXTS_ALLOC_FAIL)))
>
> will correctly avoid this warning and after your change will still
> work. (MEMCG_DATA_OBJEXTS | OBJEXTS_ALLOC_FAIL) when
> (MEMCG_DATA_OBJEXTS =3D=3D OBJEXTS_ALLOC_FAIL) is technically unnecessary
> but is good for documenting the conditions we are checking.

I see what you mean. I feel the comment in slab_obj_exts()
that explains all that would be better long term than decipher
from C code. Both are fine, I guess.

