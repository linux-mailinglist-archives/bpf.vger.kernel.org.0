Return-Path: <bpf+bounces-30871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304648D4080
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C035428467F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E6169AD7;
	Wed, 29 May 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTqw4oSc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBF2770C
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019422; cv=none; b=rm8UYxFlsm/nJXV1dgrwF5vIb9oUwO8ekq+5i3+z7QBT4gj9Ia7F8yJJBdvyCCQ+pO3dv3IOhNYcab89vgI2Tau/OWsJGvOzA5PYEu8772jbI+mYU7uR1dtLJtFqnFRQGKTMuyT461u6PwFURa18zD6U9j9t0vAqkA68vPZhK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019422; c=relaxed/simple;
	bh=Y6/bJWcxudcsb+Qv/8T7DVeODV20Uh5V7vz7MtPvdZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUDRxz13Qhqpt8NDlTWCLIUo/VhQtNUS1UOcj+zW0eKuySXtdkjPVbu++Eu5DqXBTnkZoZQP+YVuQT58wG99TAOUgbPiavDvpovU7TysWi2ob0FSQMXwc0YmNbputbncHK8phMGPvq+iyDtKa+qtsz9bFNc3zqhvuUGIAACu7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTqw4oSc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354ba5663c9so222714f8f.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717019419; x=1717624219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h6laPxfM5KYRHU7mhapNiVmAUeGmAR2xWOhCTcUrBY=;
        b=TTqw4oScQKQ6JYxdtbclNGHUHxeMy3Fsdo7Cdc32zrUVf5XMi83NKpai+THmPLku29
         Tr2CwCFyOzkODnROIeRSBA4+9cpXRwZG8xm22dNrNBTkHmRlf4slIgKveqrhmcJ7QU+k
         VZENqzeTrAtqPQhs6g7JX1m+KAb8kfqCmWoVXuVPlQK90v9U3vXBwWGUd+wl+wpeYo2W
         SEwQ71OOdfqyhgkGG5IH/fpWnBXcM3NgsV4RWlcTuw17HGBb3MIwGdy1vg4t9TE3rymJ
         Zt9wFymQVu7Z+UwnWbzqMxFGAovbeUVFzjO4KovDZjl6OnrLZydezlxmn1CUjVFQk2db
         aGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019419; x=1717624219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h6laPxfM5KYRHU7mhapNiVmAUeGmAR2xWOhCTcUrBY=;
        b=Qg1mcrV/Ql7djQyrpS9ObjqFYJRH+tTD+dY7hBoHG0LM6P1TwiPWH5zFa1p20pMLpk
         wH5NgWx3bEIPXv/3A4vTTz3jhd0FGfLogMiPfxhH5rzIZAG47ta2qSky7p5zBZv1jC/I
         DfGri+0fL06FfeF1+1mUwSa17z5Uhx7l1FitpUPA9xvsVH/rHkNDcVu9ssrzdg3eKbDK
         iN3tE7ercihys3nP4tY9Jv+Ihl4cIWIfSQ/H9NGwJ1XvGvwSOu+jKJ+7zILw7CU7BVNz
         1fPOiZgkaS8/noheBzQZAvIIevRrvZxdvZS0ZvBZxjVBH2dRdvvmKArOo6CXFSK4FQEx
         LetQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrJbRCKth/sCSgj2UNpbof4p8hrkZ72AIakd3Jg6S1hP1x44JnIJTXxCjmw34yEADbv+L8zSR7pmDnTDbDZMkk+n6o
X-Gm-Message-State: AOJu0YxIm07gJOr00V2B2E13KzW9MsOQQ6RxPiY8+v31IOJvJLdk2ay/
	rmJl7Q2L6xuCuaTAuIPKgkp0LpkJkgOJYc9gYeAJbnLf25JIXo0ifXhnnCeSiwIMZbTMFbvVvKG
	PEz2Rlo7dA3uZ56pQ5PepPRYJ95A=
X-Google-Smtp-Source: AGHT+IHJ+Aa+s/POPS55IMh6QGc3t8ROg7GXesEbCa9giAY9Ej0wKioTaNhP38lC47NZChpGJAZbpcl2dPSpPedwHw0=
X-Received: by 2002:adf:8bda:0:b0:355:175a:363f with SMTP id
 ffacd0b85a97d-35dc00c6abamr199734f8f.63.1717019419067; Wed, 29 May 2024
 14:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
 <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com> <CAMB2axPh4T-8yH-S+BryxQ3vp1Cpjrf1Zgv8rbbo2m+zRML+Dw@mail.gmail.com>
In-Reply-To: <CAMB2axPh4T-8yH-S+BryxQ3vp1Cpjrf1Zgv8rbbo2m+zRML+Dw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 14:50:07 -0700
Message-ID: <CAADnVQLm-OQAsxbocyfBcEiXnuE+pMGW1eM_W+58s4yDHEtOZw@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, pgovind2@uci.edu, 
	"hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:46=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, May 29, 2024 at 2:20=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, May 29, 2024 at 8:53=E2=80=AFAM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Hello,
> > >
> > > We are developing a tool to perform static analysis on the bpf
> > > subsystem to detect locking violations. Our tool reported the
> > > spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() that
> > > could be called from an NMI. If a bpf program holding the lock is
> > > interrupted by the same program in NMI, a deadlock can happen. The
> > > report was generated for kernel version 6.6-rc4, however, we believe
> > > this should still exist in the latest kernel.
> >
> > Fix it similar to
> > https://lore.kernel.org/all/20230911132815.717240-1-toke@redhat.com/
> > ?
>
> I applied the similar fixing approach to trie->lock, and then I found
> the two other locks mentioned earlier. My feeling is that there might
> not be a use case to justify doing trylocks in memcg and rcu. If you
> think the approach below is okay. I can send a fixing patch.
>
> trie_update_elem() {
> +        if (in_nmi())
> +                return -EBUSY;
> }

That's too crude. Trylock is less surprising.
re: other locks (memcg and rcu).
I think it's time to switch the whole lpm map to bpf_mem_alloc like we
did for the hash table.

