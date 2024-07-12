Return-Path: <bpf+bounces-34694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED693016C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D568A1F23221
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29C2482C1;
	Fri, 12 Jul 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hePgEzVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243A32C8E;
	Fri, 12 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818382; cv=none; b=PY+qE2PKFe8DSEzxWBJ38rAV80sTbvO4XlcNt0yA8G3ebkY84331PQsRbxWzqQ5pJhAfv4O146GDFQQXt+l4SMgP53oMVjf1deXa0x7gNBH5THI5OePJG7NGWyKXNH6+ReF6CKnSeYPPKP8MEE9U0SoX18wBH/DM469ItxWCaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818382; c=relaxed/simple;
	bh=BXxasLL2dSiVoNp3qZuBOAuYRWfKuW7KBSh1o5r3EH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku/KtHFMuMztppTdZORAuObY3qtto0Yy5Xtr/JPKsRdoOYSjbQBw+NYvBcgKwVH5BgdS2bFEsYD//qoUhY1ubdm/s3IR1zud7VFIe0guRS4tQg4g7AWWgfqm3bbD0JwSVKk3R98ITEdYnuqWkbNRR5TLbWeYO0C4YNHH0NLyI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hePgEzVT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c980b08b4bso1917258a91.1;
        Fri, 12 Jul 2024 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720818380; x=1721423180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otj7B7h+dOv/dHqdgyGNrdLcl7BUozT2O9Id54ZPVNo=;
        b=hePgEzVT3H01+ur1ODVcSdxh1dNg53nG3q3yWiIU4gZguqKpYF1vo2QLVLd+BRApgo
         g3ex9bW4zcJ+vEkrvA3XTp1oBtA3atQYqKcg/gHdqJ7tswj7bomtJAIhySCgWX+YDUiM
         pfe7+Ok8ROwFMJkWl1+kffX4pmg5Dcz41rJO+FIrrRTebFdqo0zdJYCgMqdlYS/2vMHT
         eBlgJBTbwoqNXg1wqjtcy7J2htTS3y5tr2i3SBYFdnkaAG1AWbzRKFm4a1Wtie2sxEsg
         O4P9c3VIO35DbLOB8zBdgy4/TG6Vv0umRw3qWD6Pt2deuGo8bHP0ndBBCcmtDUv2aa9n
         OU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818380; x=1721423180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otj7B7h+dOv/dHqdgyGNrdLcl7BUozT2O9Id54ZPVNo=;
        b=oNOR/rFz1rY6soNjni8gHBFRSHDtz3YdOs5OssbMX4Ud8OrMQ2KLRIE/B/4h/XGq+G
         XXEv0d2WMRyzlAuWkLVH75PR0739d7jPd8GkMbgqxKqP/f6Nq9H8/YxhYdWrknBdn2zx
         +qZXG0OMHibJkMBRPz1CKQjq/fvjgXQ6JXVXQxPvoiJzt8nualSus93IfAzVRYQ2jyGz
         vBUlI/um9VC46N919m1UuqOh4NVTBgwgU1atk/sppHjo7IVQ1UWABx2CkHYPQP+/St27
         VUW12iCmt1KvoTE++hHaAt5v/zs4YQgSDej7+w7+IYP2WOYusUlR6mM0cKs3rWWSB9R3
         ZpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3XJhukMiCER0o0RGcZvXXayQ/QakyDkj660g6lhaZ51TGnPYPcvIo84c6FbOUht0ZOj6H73lAkgSja3OLDB7uhpATS2Sb0fuOspItK8QDt0Eof/+NM8WNuGL3goW4A5mdxDl3S/Tk1JrtRkL15MezecbEaPmgegotHsCaUsQDxc9TbX3
X-Gm-Message-State: AOJu0YwqFveUJLR/aQn7kzUs4OVQNndpMaegHalGwVi2Si0CdH8yEMDe
	zupMb+tKUN1i6DquhButjndmHkMaw1Aq1myAgUaq1rdg+qQOvESyAVLG4AlULzfDs9cwaXMolIJ
	TN5up0HCxnel2OV2PbE8zAQAzkus=
X-Google-Smtp-Source: AGHT+IESUNbr3fMnFylMWVGExO3I59c3mocYvhlsB63I4RZCwKOm32acU5VnVGf+GzudJ3nJOGfvpHC/6+xdmZ51+9g=
X-Received: by 2002:a17:90b:238a:b0:2c8:143d:f22b with SMTP id
 98e67ed59e1d1-2ca35d54733mr10446026a91.42.1720818380076; Fri, 12 Jul 2024
 14:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110400.880800153@infradead.org>
In-Reply-To: <20240711110400.880800153@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:06:08 -0700
Message-ID: <CAEf4BzZUVe-dQNcb1VQbEcN4kBFOYrFOB537q4Vhtpm_ebL9aQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf/uprobe: SRCU-ify uprobe->consumer list
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf@vger, please cc bpf ML for the next revision, these changes are
very relevant there as well, thanks

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> With handle_swbp() hitting concurrently on (all) CPUs the
> uprobe->register_rwsem can get very contended. Add an SRCU instance to
> cover the consumer list and consumer lifetime.
>
> Since the consumer are externally embedded structures, unregister will
> have to suffer a synchronize_srcu().
>
> A notably complication is the UPROBE_HANDLER_REMOVE logic which can
> race against uprobe_register() such that it might want to remove a
> freshly installer handler that didn't get called. In order to close
> this hole, a seqcount is added. With that, the removal path can tell
> if anything changed and bail out of the removal.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/uprobes.c |   60 ++++++++++++++++++++++++++++++++++++++++-=
-------
>  1 file changed, 50 insertions(+), 10 deletions(-)
>

[...]

> @@ -800,7 +808,7 @@ static bool consumer_del(struct uprobe *
>         down_write(&uprobe->consumer_rwsem);
>         for (con =3D &uprobe->consumers; *con; con =3D &(*con)->next) {
>                 if (*con =3D=3D uc) {
> -                       *con =3D uc->next;
> +                       WRITE_ONCE(*con, uc->next);

I have a dumb and mechanical question.

Above in consumer_add() you are doing WRITE_ONCE() for uc->next
assignment, but rcu_assign_pointer() for uprobe->consumers. Here, you
are doing WRITE_ONCE() for the same operation, if it so happens that
uc =3D=3D *con =3D=3D uprobe->consumers. So is rcu_assign_pointer() necessa=
ry
in consumer_addr()? If yes, we should have it here as well, no? And if
not, why bother with it in consumer_add()?

>                         ret =3D true;
>                         break;
>                 }
> @@ -1139,9 +1147,13 @@ void uprobe_unregister(struct inode *ino
>                 return;
>
>         down_write(&uprobe->register_rwsem);
> +       raw_write_seqcount_begin(&uprobe->register_seq);
>         __uprobe_unregister(uprobe, uc);
> +       raw_write_seqcount_end(&uprobe->register_seq);
>         up_write(&uprobe->register_rwsem);
>         put_uprobe(uprobe);
> +
> +       synchronize_srcu(&uprobes_srcu);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);

[...]

