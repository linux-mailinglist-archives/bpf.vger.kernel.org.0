Return-Path: <bpf+bounces-30872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA18D4081
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B84B222A3
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6793184132;
	Wed, 29 May 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLGYPJ6M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC11667EB
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019443; cv=none; b=sMiknufxQeuYBs6v3t6ZXDCCG6M6j8HV1hxSWVV0Yfxvm53Bq7Q4EDW5KqSddOf6Zn0Mzo/AYetNfFT45xXMvdOwBVRW04STe/qNc2wI+iOPkoTZKNZBchH2TZDVH4ALOB0RC/Llzojm6F+L3VlXggbZ9V4Ib0MGU1JOAIVCHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019443; c=relaxed/simple;
	bh=HDt/SwJgaA8DQijmQbR4itWqz+hRobVzyPiyQOG6C3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdKD7USXFlYv3q/aqxUSOfsqf3SVAUSGZB7psTO5LxLf/OyWOPdqhrwANB8FAZT/67bg6aS9YoLCUz4mscYM4PZ72RB+Au8452xYvjJzN2bZOyCkEMU833xP+kl7ZUW+fA+3C2Ms+XdtifjGSby2zEzmcfjY8qk7+FYcFOsaJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLGYPJ6M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42121d28664so2332315e9.2
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717019440; x=1717624240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDt/SwJgaA8DQijmQbR4itWqz+hRobVzyPiyQOG6C3Y=;
        b=OLGYPJ6MjXDfmTVx36SP9orOyO1yBG0YP+ZV6Im14Xvugs9NjtxT6hlp0j7v+MgjWj
         W4zUwQD/AkMXwHrUd2kw7N12uNdt0Q9RKDOwIf+hxEmFNUwfAHDdgfk3inqz5c7+YpIm
         i0ujTH7/xnDgfYH4y00f0J0VhGyGinYw1JUIwwhA9dn+wFbO8fhnYYJSiCKB3Ovx1afl
         vL4pD86UdoVf7F4SRDwLVFCEjiIYTVLvfYYEzUMIKfOPPTlHj4/xhzsSANT1hz/E9DGL
         NW56GpOhyi4TH1lKZ8ynOVTePT2cKImTqG/eGJbk1x8+SnZJ2EYG7X0z+GaAvlibxDOD
         ylhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019440; x=1717624240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDt/SwJgaA8DQijmQbR4itWqz+hRobVzyPiyQOG6C3Y=;
        b=GM+/vucCo/vVqNKKHl20Z1kWMg5j8ZmQYp5mpgiO8yec0PQ/ZTNl9EUFN25riSlf3i
         7vpMa8EKE43J6AObuONwdkNkaT346cB+B4WHbk5dK5M7kE9gUB/uyWGcMos0mHLrVNHA
         9PkaKc4lmkUegtGslITpPbZLdlPyEzUZFrC3PI1zUARlaQ+nRnuTeyZVNRIa2ZSpU5eR
         LfxDrnZrVESlF3V0pd/+AdBCTJC72cpVtg2a/vAACuPemXm+Xr+opohjmvC0/Sgpu735
         9UqtTnh+3g0H3/HVRM4XGttboc0Nn956ErxfeC3TbvFFvNQzrbZUElIWjIFclAlld3Ss
         epgw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4uxxaxiooTbdunlGLSmgFcTr+WEeKhZ0XNBteKh2lPHN4osdZnQeTrl0NTSKry+lz8BWS7wqfOYJkM4Uxg/qmlak
X-Gm-Message-State: AOJu0Yz/h2knLbwVyQtFuOxTl7UlPhKHVtblk/rpydJYx8fKyJdBdSUs
	PH6Hc9WFwWM0JJH/6Yfp147KHA191GViLijaGFqopOv3xerKJAmAWJxNe9WVvbxAF5DgiCUfSNZ
	G0rOORXK/HGWG63JQpjdM0FIpCvw=
X-Google-Smtp-Source: AGHT+IHjEul8SnZfmgWviB8QxQ+t+hzJ1yrQ26tCZkA7ooDWlZc8hqPe+eaiPDIga6/wsy/VjIkcFAc4Z+kcoafhHYY=
X-Received: by 2002:a05:600c:4ecd:b0:420:1fd2:e611 with SMTP id
 5b1f17b1804b1-421279294dcmr3550335e9.27.1717019440196; Wed, 29 May 2024
 14:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
 <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com> <CAE5sdEhnHEsfHRTEY-JUvc15wpXB1LK_OCQWN8KTeU=Xt8E2DA@mail.gmail.com>
In-Reply-To: <CAE5sdEhnHEsfHRTEY-JUvc15wpXB1LK_OCQWN8KTeU=Xt8E2DA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 14:50:29 -0700
Message-ID: <CAADnVQ+PM3htCksKHp0uN8k0Ke-v-j2K4xPPrxtuWZNyeDAZWA@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	pgovind2@uci.edu, "hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:46=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Wed, 29 May 2024 at 16:20, Alexei Starovoitov
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
> >
>
> Hi,
>
> This will still not resolve the deadlock caused due to nested bpf
> programs, wouldn't it be nice to resolve using per_cpu variable like
> in hashmap.

Yes. That's orthogonal and still necessary.

