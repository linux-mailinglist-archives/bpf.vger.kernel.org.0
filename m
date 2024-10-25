Return-Path: <bpf+bounces-43173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8489B09A9
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40151C2433D
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD0502BE;
	Fri, 25 Oct 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+N/mrO8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB557082B
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873165; cv=none; b=S5S/COkrxqc7kZyJCHt25UpuRKTgFducCK8xHjk8z1CTvrXWvsz1GhDZiFL4ixRxG9OwhjuHYIArziNGZ9EP4oKy75z5f2gMONX7T3yNwpieBIcyAdkTahto/YP9rsGlTa8lZDhlDJ3m68CbictzzHN5LwfbGmCqk1QaZSDokpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873165; c=relaxed/simple;
	bh=qWapmQa1kZa8GEryAH2SeIGlGi5S9jf91pxqEKDeEfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1+cXLlQ75KAVTHpVp7CPQvSAFZkhXt3+zbGAxWp2+kps2frR4InZo+/HwhNPnLdljJFLUknsdneMz7c4BSsoxbLo9hVWsxvyFN/RL2dXeGOllqwhuqXjKXDeVng5qN5OHz77bJronw74T+ZHgjuPKN0FIQFM/JvreBO3hq4lBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+N/mrO8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1893014f8f.3
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729873161; x=1730477961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19CYgwqKOv3msI1cSbV/dACLNQSGB0laeuKSj0Zl1FM=;
        b=H+N/mrO86YmgzTO45LPrxHVLD/jCbuWPTQBLGUj/IxSp4VicAzPHzZPfCiKzA9l8xp
         gfR3TMqq+DrCtNdQMCCXvgFiVMUlpnfisUT5RwRKAYrzrXz29raOMDuQAmwpFbQmNWw+
         AUEdUDch8G68ePpyGfJd7B1ZdqdDcCYgAS0A/Wik3fBkshxlSpRCgVrS/IJTKm5YVThg
         HC0ulTw/sHdGlfkQ3Y6hYW6v4lTF5snuhYZdTkq77fg8RCHtEdGovNt9BCIN8jh39ynU
         0z4qOcsIoLLbAIkdfo7wDHwlLCGWYUFx6oASy6CZ/GsfM3KbUEpLByFS9Hw4bUp6+wxH
         y98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873161; x=1730477961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19CYgwqKOv3msI1cSbV/dACLNQSGB0laeuKSj0Zl1FM=;
        b=ucpjUHtTApQx5mFc4khdLvoH7uGIImtjPi9/3QaarxW7ejfUG2lKnyMbUxgJ5if5Ma
         YgO3X8kL7DHln96RbsT0+CNRe8oXLh0S7RPjfLfRf13UFbF1mFrk4dyKrG0opxgDYR94
         qalQa+NukL8lW9Rp45LbOeor/RL8tD+fVp1bkltoQTUUBgF4ys6Trc3L9B1eCzTciZIW
         s9xj1UtASYkqr0xyFdIlKNgctUxrqgU92TaU0JFrwV2wMI0W/2DAYzsPSfhG8KC2iKXN
         iLx7cj+HFM0TPWuk8tV02OYeiNNgnKLsDkZoSrBo/XEfzH6/3xm6NjrA57LsorJhung5
         glIA==
X-Forwarded-Encrypted: i=1; AJvYcCU/aDAtGv24a/aH9uu/Ny5XJ20WPWd/Sr3+yJTlXh73htuPrW4EqYmEnwodBNEIBkATJIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyij+awg72Vr6FjfcFR9lSSxX7Yn8Uo4uJCrUthck2E93dfHPvf
	MGIYJoAwBL+pTJWEF3uOJZ22kh+4rn7yl2NvPcSGWsmghStF85p3GbPwKuPp6l6AZT7ecXf5IPf
	ZG2UNQcilPQWlK8TrzDFfbWTeVKI=
X-Google-Smtp-Source: AGHT+IH7TMTlotIk/Zy1fVju6UO15VyCyI8v7mFU+xjG2iWkY4L92rrPWnknH2ymjpFqhz+QHtnWW/eyeTWTz4UmWc4=
X-Received: by 2002:a5d:514d:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37efcf7be3emr8557593f8f.38.1729873161073; Fri, 25 Oct 2024
 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com> <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com> <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
 <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com> <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com>
In-Reply-To: <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 09:19:08 -0700
Message-ID: <CAADnVQLmSKATXzi+++hGpk0i-UiOKk8qt9N2CGBkznCRVr=qcQ@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/10/2024 17:09, Alexei Starovoitov wrote:
> > On Thu, Oct 24, 2024 at 4:26=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >>>
> >>> The good news is that already happens, provided you have the updated
> >>> pahole to handle distilled base generation. After building selftests =
I see
> >>>
> >>> $ objdump -h bpf_testmod.ko |grep BTF
> >>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002=
c50
> >>>  2**0
> >>>  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e=
048
> >>>  2**0
> >>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  00071=
73c
> >>>  2**0
> >>>
> >>
> >> Indeed, after updating to the latest pahole master now I get
> >> .BTF.base, very nice.
> >
> > I pulled the latest pahole, rebuilt everything,
> > but still cannot get it to generate BTF.base.
> >
> > Any special trick needed?
>
> Hmm, should just work for bpf_testmod.ko as long as "pahole
> --supported_btf_features" reports "distilled_base" among the set of
> features. scripts/Makefile.btf should add that feature if KBUILD_EXTMOD
> is set, as it should be in the case of building bpf_testmod.ko. I'll
> double-check at my end with latest bpf-next, but it was working
> yesterday for me.

There must be something else necessary:

pahole -J -j --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_t=
ag,optimized_func,consistent_func,decl_tag_kfuncs
--lang_exclude=3Drust --btf_features=3Ddistilled_base --btf_base vmlinux
.../bpf/bpf_testmod/bpf_testmod.ko; .../resolve_btfids -b vmlinux
.../selftests/bpf/bpf_testmod/bpf_testmod.ko;

objdump -h .../testing/selftests/bpf/bpf_testmod/bpf_testmod.ko|grep BTF
  7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00001d94  2=
**0
 50 .BTF          00002ea7  0000000000000000  0000000000000000  00062e30  2=
**0

