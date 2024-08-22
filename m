Return-Path: <bpf+bounces-37879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A519995BC98
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47C51C23158
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937F1CDFC7;
	Thu, 22 Aug 2024 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brDJ/g9g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC71CEAA5;
	Thu, 22 Aug 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345983; cv=none; b=UESZxJy7SeEmp7RoWmg/JjcSW6c0nebNVIphs6nSzRm63hcGJ95wh9/7YhfjgXyCJkPt4Q9a/8HRSh1nloho6ltNo8vXfODYWXjU+AHH3hHPK8XqrYUhR5FQRVDECBSvWdcvpwzVmBSPInOsZ/fNHzJCcGb2kFr124XsJWTVNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345983; c=relaxed/simple;
	bh=YWGlspSU4TxFPxrvBNBjl8a3wkDXJajJpWcCzd/ehkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHazDk0uhB4n6g3Wgx4gHTGlPstmihca1Bx9gRw0sCC9SUtjQvGsgw1zT75AY8LlfryjllUumfH4pHsRxjTEEt7FClmMQdjpObhQaiKR/f6B/4DsfVbjA4LecdTlt2V4b98jfMRRNQTqN5eS6dGVfY0l3S4mWpH64YTDg/AIpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brDJ/g9g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20223b5c1c0so9638335ad.2;
        Thu, 22 Aug 2024 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345981; x=1724950781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1QyWs8fwaiHTqcav5Inx6vs/UZ87QiYkIE4fUFV/YQ=;
        b=brDJ/g9gy2ldCPmLVA7yM17GKaBdiP/UmBv4hYfGF48/oQBeHLabyolfHNG7Ce8Em3
         oCjRV5OVUSoYjACHvuChBs8jxsFBQTzdo2fcHc9jkJjcWO/ZKyIWJp0aT8Pl9Xfr7fNz
         YzGUGKTmrJZOQEMwF8rD94dAn2iz5G7gxvNk7Bu5285KGjB3rCQSgWge7X0PupMiUzCe
         WNMZjO6b6uwvJsr69GA5sIhjlO14y8g1W0rSJ+YkDURg+C8STSVYvtE3oY19QN+qF5B9
         cOuCU0GUMHfuGYQNStsZtiMD/WJ6c2mKY1Z6E/XFlGVOp2AOIgUFBFUBZUXp7IgP8wJ8
         qYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345981; x=1724950781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1QyWs8fwaiHTqcav5Inx6vs/UZ87QiYkIE4fUFV/YQ=;
        b=kmEQFB/6exTEa690/htExTvecImSosg3PgwyjKRKmKkyNUKXqkMJ+6zfyBWumuRxNY
         otNo8BPO8aNJ2AtssFUamjF4x9KiNt1JCSwfTBFJhFsRd09eC+2uFTugjTR2QQY7EjSG
         XqUk9l11vZcLO2SY+E7n8dyolERO8i8ELICWpgzu4VpbNPyoyQAALFrZwnu+JosfZABi
         IspgspGJ5r2ynHotTNR2FfuWX/ZWfvFcjCtquYkPnTQzonJhRGYtpgh6tPf9lOcVDVHf
         C17g+s1sqFIZNW/pb4MIWsL1sbZdPTK7ZKBq1YKuAInz3XH1NOr4SHw+UMfQlQXcXprS
         BQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXlZ7sNd8p5qe1OkokLCrOEjTPWiNaBC3XCJXy7lcwDiXxI9Kslm5sYwOLAtCd1yzAvOejCUM5VzjRTUAJ@vger.kernel.org, AJvYcCVzv19+5BZnLDRg6KDltMZ2LeT19iLkskjkArf1Eb9t2ujSJqIyPEzISDzmgkFDJjifshY=@vger.kernel.org, AJvYcCWX4QoTBhNPr5SqQsA2/vXdOe8kSmNYMy6PysKnWtbc9OH00cQujZk2RwmrdkMT8KMBcoABy7192vpd3daDMLsvzIcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OBmXk+BLJsBHNNmxmnZ3fF9GSkklGr9D87DX+wxDW/hyaSwl
	w445X4OHTh+y9cyYwrN87eE6Linivb5aoq0yl6BjPPQ1ITkc3ggwTg9perl+RLNjvJ80pYTAqBk
	RFsDhtb0Rn6ymoaXwtENz4nnl34Q=
X-Google-Smtp-Source: AGHT+IFVaeRmZ4B8Kf0yi9/jkvJQM5UIqKnx5lAPNwm9PjfCF+priLscW++esQqsFO5l8fCVLB+f35Ce6QU80a3GQq8=
X-Received: by 2002:a17:90a:8a8e:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d5e9fc9af3mr7215837a91.27.1724345981232; Thu, 22 Aug 2024
 09:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-5-andrii@kernel.org>
 <ZsdJuwIuJ-KFA6Rz@krava>
In-Reply-To: <ZsdJuwIuJ-KFA6Rz@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 09:59:29 -0700
Message-ID: <CAEf4Bzb-1na=S9+XVpEpmtDE4mJLQRywZJ6wB8JyN++2Si6Pgw@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:22=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Aug 12, 2024 at 09:29:08PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > @@ -1125,18 +1103,31 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > -             err =3D -ENOENT;
> > -     } else {
> > -             err =3D register_for_each_vma(uprobe, NULL);
> > -             /* TODO : cant unregister? schedule a worker thread */
> > -             if (unlikely(err))
> > -                     uprobe_warn(current, "unregister, leaking uprobe"=
);
> > -     }
> > +
> > +     list_del_rcu(&uc->cons_node);
>
> hi,
> I'm using this patchset as base for my changes and stumbled on this today=
,
> I'm probably missing something, but should we keep the 'uprobe->consumer_=
rwsem'
> lock around the list_del_rcu?
>

Note that original code also didn't take consumer_rwsem, but rather
kept register_rwsem (which we still use).

There is a bit of mix of using register_rwsem and consumer_rwsem for
working with consumer list. Code hints at this as being undesirable
and "temporary", but you know, it's not broken :)

Anyways, my point is that we didn't change the behavior, this should
be fine. That _rcu() in list_del_rcu() is not about lockless
modification of the list, but rather modification in such a way as to
keep lockless RCU-protected *readers* correct. It just does some more
memory barrier/release operations more carefully.

> jirka
>
>
> > +     err =3D register_for_each_vma(uprobe, NULL);
> > +
> >       up_write(&uprobe->register_rwsem);
> >
> > -     if (!err)
> > -             put_uprobe(uprobe);
> > +     /* TODO : cant unregister? schedule a worker thread */
> > +     if (unlikely(err)) {
> > +             uprobe_warn(current, "unregister, leaking uprobe");
> > +             goto out_sync;
> > +     }
> > +
> > +     put_uprobe(uprobe);
> > +

