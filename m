Return-Path: <bpf+bounces-15952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F837FA885
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6A281589
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFCB3BB43;
	Mon, 27 Nov 2023 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztI4LteM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEC94
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:02:35 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso6428528a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701108155; x=1701712955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFwrRNgtpndmD04FXQMHozSeJLAywA1viHEPTr71Fbg=;
        b=ztI4LteMfKv0pzjDX81SCosYHecMXVgkLLPLhUE/3IvBjiJNry0KB3oajRxTyYTqk9
         9Fi6y6dtCM9RAz1B0P2UqbUP3I4ijiMZOh9SqhpCYeDZbZGZM0NgcgnolAsK/hx+QF9a
         r3UC6L9b5Vbnk93Qj8dTC3lVhg6kV51ctu01gQ6jK5IcWTuv2AIx9VrbBFJYXkQX/lMx
         451P2R+6NtqM8zps2beBEeLT1xTr1sQED4ceqqhqmh65EfU89AiAsEl3ee2InpZIWqXq
         f5/Y8OSSDnEC4tYra+nDjgSQwr2We4peU6o/q+bU0+qQ1lGrikB+eEfitHge0l2tZsTH
         HuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108155; x=1701712955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFwrRNgtpndmD04FXQMHozSeJLAywA1viHEPTr71Fbg=;
        b=o3S5gcbWexyB6oqaMrEwQTQe/D8XmLey+f4Io7RPOIapUXA1fNLClL+nkCrQbETDe7
         h8zoHhbJjPD1PHEEXKWPbuYi5/Sl1+1oJvDPObN12a3DFFwAt7JNcyhHtiJcQf/C/TfI
         hw82rYbZJdiTjEFRFPn0rRpxYk4Y6MU+JFF1Nl49NSKlB1eOBy4k6yz7GG26fu9BkBrd
         U7KD/kMAjBHOcxbeMkiozuZOuX/nUowLx/0dLPJQnHE3XqzG/OZaYE1lK3mJEmMGp7qW
         doBOhw6h+WaaVUP9GtOcZSKUAYqyoG924uFyJKT09YJvNKYFKYxGD2j+Pq7O4t2vZAhF
         bZoQ==
X-Gm-Message-State: AOJu0YzfTl+6jeXiRPLMKFM+JnG+BXoh4FbUnguMO9mGh06OKLECXBEn
	LAg/Pvjun+oRa2K1ByGEe6vM+Yg=
X-Google-Smtp-Source: AGHT+IF0Ktuax4/b1gwrJF1jhmkhSIP2ZPNN/R4F84pSb5TVnM5FbvcjEW6I/TDXKIp/4M15PoanjBo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:d488:b0:285:8a40:8f04 with SMTP id
 s8-20020a17090ad48800b002858a408f04mr2391872pju.7.1701108155386; Mon, 27 Nov
 2023 10:02:35 -0800 (PST)
Date: Mon, 27 Nov 2023 10:02:33 -0800
In-Reply-To: <402e2e7a-c01c-4aad-8ca2-0dd40282820e@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122222335.1799186-1-sdf@google.com> <402e2e7a-c01c-4aad-8ca2-0dd40282820e@isovalent.com>
Message-ID: <ZWTZucxHSw6wovwi@google.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: mark orphaned programs during
 prog show
From: Stanislav Fomichev <sdf@google.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/23, Quentin Monnet wrote:
> 2023-11-22 22:23 UTC+0000 ~ Stanislav Fomichev <sdf@google.com>
> > Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> > and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> > idr when the offloaded/bound netdev goes away. I was supposed to
> > take a look and check in [0], but apparently I did not.
> > 
> > Martin points out it might be useful to keep it that way for
> > observability sake, but we at least need to mark those programs as
> > unusable.
> > 
> > Mark those programs as 'orphaned' and keep printing the list when
> > we encounter ENODEV.
> > 
> > 0: unspec  tag 0000000000000000
> >         xlated 0B  not jited  memlock 4096B orphaned
> > 
> > [0]: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
> > 
> > Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/bpf/bpftool/prog.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 7ec4f5671e7a..a4f23692c187 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> 
> > @@ -554,6 +555,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
> >  		printf("  memlock %sB", memlock);
> >  	free(memlock);
> >  
> > +	if (orphaned)
> > +		printf(" orphaned");
> 
> Please use a double space at the beginning of "  orphaned" here, this is
> what we do elsewhere in bpftool to make the different fields easier to
> dissociate visually (given that some contain multiple words).
> 
> Looks good otherwise. Thanks!

Sure, will do, thanks!

