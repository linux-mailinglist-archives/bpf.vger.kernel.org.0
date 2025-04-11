Return-Path: <bpf+bounces-55763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727BA864B8
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4A8C1852
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC6230D14;
	Fri, 11 Apr 2025 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt0m0Eda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EE2367D4;
	Fri, 11 Apr 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392217; cv=none; b=tyDc4Cyjl/TeaS1H2+tTr54E5UVGMtBQyNrmDwtbK5O3vl8sDIxvQQvTJeJcmyZnpPFfpfUhvgT8MSZ3YEg7bOwqwvKu1sxSeml5xij8i8pHHb3MOmxY4dPALMd+Fsms6GYEDrwObwuHohAah/smI7DcoYMrskcfoy7xa3EtLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392217; c=relaxed/simple;
	bh=SMxvg8ovuok0lFjFhVxVAhPpM5aNbZwXvc5nxaWsdmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8LvNv0//sua/hQZqj3Yix8ZVMtAzGNg/w1rJhpKcEaH10EmjSF2Zd0v6toSj52wlpMeImRTg3nV4tTZqFIi1afWDaJSaOTeVevKy//miqedqDLIQ5DjS2GKJyJaiejtEhGElHXWkju3Awuh9sjU2TK10DVf2TZ8ubywLvdCp7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt0m0Eda; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so3547911a12.1;
        Fri, 11 Apr 2025 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744392212; x=1744997012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh2uW3J7zT8acfiEQVh/bxr3CJ0jGtOGgm4RS33x1Ig=;
        b=jt0m0EdafiaD9R5AhOoQmXWmWTJXOWEeTpvbTvFGapSHy27zA8aVI1xsAo6efmQQhX
         WIavn7/tSAxaKgAd1Ym+DzN9FNYgW8A5qEhIzHSlZshnyFYf/1KkQozqqdheHOi7xKev
         fr0foJ6hZGmum92Ka26Z7bcTfgFeoMz36Ntvqnj/llfDUOlFqFxA7TzK72bLh0O1pBhY
         hGcQSCfyS3WXGL7sNocjdBqkP90Wet9gR1UC4GCLOwdy6Rv2VITPdTaFy3j+FYdjKZp9
         IYJEkqm3fOkbMlLfT0uVSh8qabKGM3KKpiC57awY2XLwJE6wS7kb/Sioc5naCkMvDypN
         kCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392212; x=1744997012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh2uW3J7zT8acfiEQVh/bxr3CJ0jGtOGgm4RS33x1Ig=;
        b=wKF2F39vk3cWLIlRyNn0oBZnDj1Faj/kF+GolmiInho+JSH/J4eVBfXHcnfCaUFNQ/
         53FSJZAqOCuUByazrPhmxCnGWCknaLaUnVZTOKaM5wgeRCLB5eCkxoUBt0QSqIQqh3+P
         GmZDLfdd3/dRCf4q13axEQi1LB6hqOVObaHb6Ulm9GEXmYQ00dvgtet1yP8birS8ayQg
         1yUmj709xhRAjXbwxj48xZ02VxJYvC279PoJ4ESqIkJnb855H71eD+5SuXwFUXeJDkSR
         9VtpgLAHne2g7DwNojm130qG+L7yTu4DN0xKDTFUY+YWff3fANICNAri81tZAwEGLEcR
         W/0g==
X-Forwarded-Encrypted: i=1; AJvYcCWUTK2oB+w8a9bzMgI7wmROJB1jKtEm6cqvo4cv7IW9QnArVp3qLjnxfdaksmNqyTUo9k3EBGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrqwHq+fZ2Cj+qyZP0Xs2HOGc5rVOOSrKBydfn7qBhs0bJ8Jt
	0sa7Wi1m54YYnQR1DpOfxziyO90FViJbO7BhiWag1ENgE+dUvs3fgT2DUcAA71cFkYURMlwzXny
	NFWGKVNIm/8MGwg9R8tzwnAJF/18=
X-Gm-Gg: ASbGnctJ+6lrMRXX62mxzBDvhPVijEdJHfW7A6IIeXxhoTNjdtfccNG2fTcnl87XgVx
	7Jx4cpFRCruraduvyC/C7h+8CbIFjfALhvdB8vC0wmRCWulGqJFMg3ll+7wZFOlBLxr9xpBgE9T
	ceDUwyzW+TiZZZYAgBviKdidYtWsWFtnhsf+I2l8jn6wrILP8g18tei9S/
X-Google-Smtp-Source: AGHT+IFrSYM2ZtCJYF1N9NfRtuE5yjXPmwOHvxzTKSd0DMGd7gO8WUjG8Qi//a7OurnWquO1kOA7Ys9yFzCHgUahsi8=
X-Received: by 2002:a05:6402:524b:b0:5e5:bfab:524 with SMTP id
 4fb4d7f45d1cf-5f36f5253eamr2921389a12.3.1744392212314; Fri, 11 Apr 2025
 10:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
 <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
 <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com> <CAMB2axNbnOoHu6jdkt-59W6p59NjmO580kUw_g45rWG2TAH5mQ@mail.gmail.com>
In-Reply-To: <CAMB2axNbnOoHu6jdkt-59W6p59NjmO580kUw_g45rWG2TAH5mQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Apr 2025 19:22:55 +0200
X-Gm-Features: ATxdqUG_CI06-dfv09_SEutpifil7xp6JHzq_5njlkODp639SbWU8oDl2Leqfdw
Message-ID: <CAP01T75vzfeaM=DXhg1zhbj+6hK0u8fKOtZDiMLL1fnUM53u=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 at 19:18, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Fri, Apr 11, 2025 at 10:08=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 11 Apr 2025 at 18:59, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > On Fri, Apr 11, 2025 at 6:32=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote=
:
> > > > >
> > > > > From: Amery Hung <amery.hung@bytedance.com>
> > > > >
> > > > > Add basic kfuncs for working on skb in qdisc.
> > > > >
> > > > > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to rele=
ase
> > > > > a reference to an skb. However, bpf_qdisc_skb_drop() can only be =
called
> > > > > in .enqueue where a to_free skb list is available from kernel to =
defer
> > > > > the release. bpf_kfree_skb() should be used elsewhere. It is also=
 used
> > > > > in bpf_obj_free_fields() when cleaning up skb in maps and collect=
ions.
> > > > >
> > > > > bpf_skb_get_hash() returns the flow hash of an skb, which can be =
used
> > > > > to build flow-based queueing algorithms.
> > > > >
> > > > > Finally, allow users to create read-only dynptr via bpf_dynptr_fr=
om_skb().
> > > > >
> > > > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > > > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > > > ---
> > > >
> > > > How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
> > > >
> > >
> > > Good question...
> > >
> > > Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
> > > the ref_obj_id of the object underlying a dynptr?
> > >
> > > Then, in release_reference(), in addition to finding ref_obj_id in
> > > registers, verifier will also search stack slots and invalidate all
> > > dynptrs with the ref_obj_id.
> > >
> > > Does this sound like a feasible solution?
> >
> > Yes, though I talked with Andrii and he has better ideas for doing
> > this generically, but for now I think we can make this fix as a
> > stopgap.
>
> Sounds good. Just making sure I am not doing redundant work, you will
> send the fix you made, right?
>

Yes.

> Thanks,
> Amery
>
> > I will add a fixes tag, asked the question because I had the same
> > question when implementing a similar pattern for my patch, and was
> > wondering how you solved it.
> >
> > I made a similar fix to what you described for now.
> >
> > >
> > > > >  [...]

