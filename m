Return-Path: <bpf+bounces-40758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776298D3FD
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CB51C21455
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8311D0403;
	Wed,  2 Oct 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEJ26v0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB91CFEB6;
	Wed,  2 Oct 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874428; cv=none; b=K9RjLWlFps0rGAdflxd1zjGABNeLpfAGiI/WJvmx5DqRXOvIeMW9pyl1Yjl4LiBa73ruN69bPPKycKIJW1IXOQhT55KOakIgcIvb9xi65VNxsVwaLWTCU4S1GVgG3LXeSbQood8IBrFQSlpoiG5Lf9MCxa4GhUkbezQLsxEKSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874428; c=relaxed/simple;
	bh=PdiaWzjKc3YZ0zvSnU1T6hsdaug6T5Jb4ECaAj0kg2Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozZGGiYiVlxZ9og0ut1wKxSTPBQLDQuKq+UrdoyZAtiyhvRlVyVdYUsuXEPvC5tx3JD96dmhUZZHTpVDd0TsEFbqbvFLAvd05xHb2sJD2hMr8/wKH5YLww/kdg10DhSw9aN/alyxSkA7iQLMNmYsMgMeDFg7RmYUi8TMvTGZU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEJ26v0o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ce9644daaso2399698f8f.3;
        Wed, 02 Oct 2024 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727874425; x=1728479225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jiLpO2LIzGeokn1CddyjdGdFLkciGmQR/pFJr7C61qY=;
        b=IEJ26v0oF1vOBdSp8uLhrU0/cQlKpXdrm0eInWCBpMEqK+gSsT0FSxwnraxGYwo41C
         Ch04BOKXo2s1a9ksYoMFinLFcFNggvJc74KQHDnMXphuFrb3oyUf8+SzVLjl53LfqL8z
         +ywT1WotSQPHPcmpDEu7BPAFySj2xN/pLnpFWqD7ZALzeilvGQQfF39J80fV7a6j1oXN
         JAHZNgEZOmhdS1j7UxNI0eNejRzFk18rmlnV88a0+5U+jAq1MgDW6Qx1CiBJ7KUwCyfw
         shBIjGGKfQcLOduJBB7188HB13ZCUV73MKhLm9idwUvDz/hIX+4AoBZ7DRv1aiM4oRgN
         QtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874425; x=1728479225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiLpO2LIzGeokn1CddyjdGdFLkciGmQR/pFJr7C61qY=;
        b=j535CEsw1nbb67ZS/zvbb87dZisV78JMRzFbZiOWo+vtUHUuhabOHueA1OiQ3yG6I1
         2i6LT7hvPe1hhCrW0YQeoh84Ny/ZUV6Va6OQS/5iaX4FLMB9jzgWLJj0ZsGfhkLSrYwr
         tKwLzmxjz1maxI4ry9LJZTlt6S74ORFS8hOUcieHhg/hFtsw12kMf0OXMbtj4B+ThvgQ
         AJjwbeN7llVKhfAzNm6xEPNc9ZBFEbWwkfSfjd4KCovVnb3BC6JtiIrl5cFFids3M9Qf
         tZ3d/kEI32urU1T6ax5QX7wFYgeBWIUsMK/guzsv9/iVI1K1YU+zC9t2Qd+eLWcd2U8I
         idxA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQ5T36qfnMbov74AmM799BV+9fD93zkPAdEElyobQvKgN+r/o945j9E9ALqeHKqyVt+o=@vger.kernel.org, AJvYcCXIqYgMWWnY6X/xmjhMak+CSRmquO1aj2+5xj7xe/rFzMs6bYKeHumMgyjpSLsz6+ZzS3qph/qIm28LSvtn4biR4sNx@vger.kernel.org, AJvYcCXfqgybo5L0PdFIE8MIId2e+mpFtdFBlKtvkgSngG/3b1efPZ8axycaCPcMsIjbGXgVzmdYhHvjvLZgYd9Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNOKd88X8K7RykMEpr7obwtQZTXEeyxDBBpauDEZ2mvL7MKRO
	/YHU2baW245QAZ+dFJqd59h4qUdZgq3MAbIg9UuXBlH4uT8jGMKQ
X-Google-Smtp-Source: AGHT+IFvUQGLTK3mwFd9k/XNyNp9mvclUiRzhseX4jAWM+SjGgC/PgZP6XH2xA2azHLq57np1Ooi8w==
X-Received: by 2002:a5d:494e:0:b0:37c:ccb5:4eff with SMTP id ffacd0b85a97d-37cfb8aa940mr1861932f8f.12.1727874424973;
        Wed, 02 Oct 2024 06:07:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm13854117f8f.106.2024.10.02.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:07:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Oct 2024 15:07:02 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 03/13] bpf: Add support for uprobe multi
 session attach
Message-ID: <Zv1FdjGzPf4KhtzP@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-4-jolsa@kernel.org>
 <CAEf4BzZfy1H2O-uY3x9X7ScsJTXHgqjZkcP7A0tMmhmvubF-nw@mail.gmail.com>
 <Zvv2gciCj-0mAnat@krava>
 <CAEf4BzaRrg_=scWTt1X7fvB+4wxUiiQUOCPvvtWgL4_rwr+2CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaRrg_=scWTt1X7fvB+4wxUiiQUOCPvvtWgL4_rwr+2CQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 10:11:13AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 1, 2024 at 6:17 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Sep 30, 2024 at 02:36:08PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > >  struct bpf_uprobe_multi_link {
> > > > @@ -3248,9 +3260,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> > > >                           __u64 *data)
> > > >  {
> > > >         struct bpf_uprobe *uprobe;
> > > > +       int ret;
> > > >
> > > >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > > > -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > > > +       ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > > > +       if (uprobe->session)
> > > > +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> > > > +       return ret;
> > >
> > > isn't this a bug that BPF program can return arbitrary value here and,
> > > e.g., request uprobe unregistration?
> > >
> > > Let's return 0, unless uprobe->session? (it would be good to move that
> > > into a separate patch with Fixes)
> >
> > yea there's no use case for uprobe multi user, so let's return
> > 0 as you suggest
> >
> > >
> > > >  }
> > > >
> > > >  static int
> > > > @@ -3260,6 +3276,12 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
> > > >         struct bpf_uprobe *uprobe;
> > > >
> > > >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > > > +       /*
> > > > +        * There's chance we could get called with NULL data if we registered uprobe
> > > > +        * after it hit entry but before it hit return probe, just ignore it.
> > > > +        */
> > > > +       if (uprobe->session && !data)
> > > > +               return 0;
> > >
> > > why can't handle_uretprobe_chain() do this check instead? We know when
> > > we are dealing with session uprobe/uretprobe, so we can filter out
> > > these spurious calls, no?
> >
> > right, now that we decide session based on presence of both callbacks
> > we have that info in here handle_uretprobe_chain.. but let's still check
> > it for sanity and warn? like
> >
> >         if (WARN_ON_ONCE(uprobe->session && !data))
> 
> You mean to check this *additionally* in uprobe_multi_link_handler(),
> after core uprobe code already filtered that condition out? It won't
> hurt, but I'm not sure I see the point?

yes, it's cross subsytem call so just to be on safe side for future,
but I don't insist

jirka

