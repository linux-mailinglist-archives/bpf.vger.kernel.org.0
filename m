Return-Path: <bpf+bounces-69219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B5B919AE
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F82C422B05
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207A1A239D;
	Mon, 22 Sep 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWMt7fj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26942AA6
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550261; cv=none; b=VMiotjK40fbDm4ZdsuQDZVgrT6mjqIQvKjISwyzBQJSWNKBDoOlSZOHJFNs+qtDBgtkiVOfuxy1xrlWIlF+iAsnxvYdRMgJIhX79dC12s/RGf9k+KyQMeJ3ew06GB5Q665iauSQJaegPo3MXv0OKIP3I5FolT2fVJFhia48A7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550261; c=relaxed/simple;
	bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCNe755lY5+mbycsVa+AXbDQhmOm366+BHzDJMqkbX5WXHsRP0Uz/saJ03h25BAo3YiExoJJOIfbkrJYJGV7yk88bhma4grfg6hm0KSDZM/Ix66JY8/ExB19DcrMgU+28+aorfZ/LloJl2+d+9f5IaTQoKqZshB+Rjf23Y8YiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWMt7fj3; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-ea5bcc26849so3286963276.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758550259; x=1759155059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
        b=XWMt7fj39vU8t34Vq6XztEwf8qbKcfWyAIecuYVaApochod81YcP9nbSpq2eko3oJr
         1N2MCr9gTFD947xt5sdBfyY2Zri7pLxi3hFw7TRqD4BzESw8W+HhHY8hGc4UOMX7qfoz
         VjQkwbSSClk65dmnUjH5esFRXrrfRQ4gMAjuVLqGjQHrKiwJr0q3q4HUJJ5GOsE03I3I
         GMeRYhSxDPkoERtX1+Zd0W/2vX81ePe3cQ+1BML63z6Nm1jw1AsgjIcIcQHVWC2hooFf
         4VN4yDL4ZPQbtCb1zZ2KejOqrdgEHrzKUGWIviTanQmQBr3djhX2pHklYXc6V70PvBd1
         W48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550259; x=1759155059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
        b=HTcrit5pYypt9ShOpezvN0IqwwTxJqTjhBLdcNM737ulT9hMnV180YWNhk9svCbXNR
         IJs26MJW8JPxszoMvFuZ4BfobbFAI7NYYWBH6ZqFAtbB6CeNICffh9qq/A4ufBYY7NCh
         347YgpYfougpRr3YBTQn1NtMSBevqIAkSut8zhLiWRaPOeV4p8fG9MtdKtbuoA38d0mx
         UQp4eupGPMoFCJZktvuK0+wlP5/71V9G+xjnSJd7v5PakeIOY0amKgKQUjHizPxc3QbZ
         hT9J9agejCW4ahvzzjcRbUrb69EXMWNDmmS4pyULM6fxzIQFGKW6VDgcgsTwHQLI4+bo
         ge4g==
X-Forwarded-Encrypted: i=1; AJvYcCUUs6baQN+hP6y0+IiG9odcrgEp+n/iD2XeKeEP1kdg4mA4k+8+IvvzeCfuk0u2T+G3zXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrsQBVkPvv1uxFxzoW9kknIqZLXeSD+KO8zzpGDDXlTUgJi73
	sj4psF0fv128pFL8O56kwJu8p60/Ogid5s/tenR8q03HBSMUNy6sDtuXApaHhbmK0VADRjUCuaR
	+uvuBwh+qByXS+wVRX9QzuHGk/L6PTs0=
X-Gm-Gg: ASbGncvegKyxruHFH7S+6bjG3Mmky+R4kHq2uOMxP8TWp0Vs85lj+P26KCEFJNlcge0
	/mKsjFJc22OqiT2unpa1mAvVsmK5eB0FByCljemFyDs79l2GC2smUgtGhJCQdpZCvhTth1cs+4G
	5p7C+6NKVpNw4/EtDnvI8wF+3JII2r/iXAzJ29g/jy9OoKIRwDGLVyS2DMlQcitWTVIHyXtslsn
	4YbP3k=
X-Google-Smtp-Source: AGHT+IFJzannJGdG0U/xTsTeep3q5OsJ2aVW353S/liXxsa4qbfagG/H+I3ZslMdOqGQa0hUJ2OFr0JeEIz8m/TPPLc=
X-Received: by 2002:a05:6902:2b90:b0:eae:e869:7c1d with SMTP id
 3f1490d57ef6-eaee8697e34mr4628048276.51.1758550259329; Mon, 22 Sep 2025
 07:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn> <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
In-Reply-To: <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 22 Sep 2025 22:10:48 +0800
X-Gm-Features: AS18NWBlqc_FP-SWeeZCKNLtFTPzs5iuu6l_5C6HkEcL7Ve0M-pNng3gsAfS8eU
Message-ID: <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Song Liu <song@kernel.org>
Cc: jolsa@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > Therefore, we can store the "is_return" to the last bit of the "data",
> > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
>
> Does this really save anything? AFAICT, bpf_session_run_ctx is
> only allocated on the stack. Therefore, we don't save any memory
> unless there is potential risk of stack overflow.

Hi, Song. My original intention is to save the usage of the
stack to prevent potential stack overflow, especially when we
trace all the kernel functions with kprobe-multi.

The most thing for me is that the unaligned field in the struct
looks very awkward, and it consumes 8-bytes only for a bit.

>
> OTOH, this last-bit logic is confusing and error prone. I would argue
> against this type of optimization.

Ah, you are right about this part. It does make the code more
confusing :/

Thanks!
Menglong Dong

>
> Thanks,
> Song

