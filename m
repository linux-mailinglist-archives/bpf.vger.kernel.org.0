Return-Path: <bpf+bounces-30870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2F8D4078
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5BE1C21B67
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DEC181BA9;
	Wed, 29 May 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MepJxsml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAA139588
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019221; cv=none; b=e2rFE9tDrECj/dn2jZoNq9fUO5YHym5K/ZYVsrleJ6gT85JQMOq8+Jyqhe74y8s5ymcqSnFqhrSuaJGEMUNFkzdVLWmUtYNO4xIYICtwwWkRud6i/qH1c31NJTORLL896zoW9Z9L86fTCDxSWNoejHNK9ao2C+Ucmgn1PvHiGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019221; c=relaxed/simple;
	bh=bZpf9VTSfBz8htfeBs+s3brHEXUpuArUAPIgOCaA62M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIPah1uaZ0X+0KAYX5x2SSfDxL971G+H+zBva2vs2YIKaQVW/bX5IX35sIn7jqaKUI5btKnpd4ifTNiUjbnS0hQ94+oogfy4CsF4PuUgw7Jn8pKIpMgIXXY1CPpy/gx7tJL1kVYctOVaWlUURBMtTgfpLorEHLJ4I6qE6Uqdse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MepJxsml; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48b91377babso79199137.2
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717019219; x=1717624019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZpf9VTSfBz8htfeBs+s3brHEXUpuArUAPIgOCaA62M=;
        b=MepJxsmlLa7wTaXG1r/kACBG4HvPk/L/h79HJjDeaUvmNdC17uyMBW958IC4ow+Atg
         B5eotJXWIqP6evpCQdRJqOErbfknLKbPcST1Vfn5EBgGQkuEotiTMo/+sj3Lz1KMMGIA
         QTomvDPYD+tan4VglAtzqcjFmoTYqXiFkrcD84FJMbAOs3HO2b14+Npt6z+8l+x2rnA4
         OKtL4dUmPVcRTX+S2ITD9K6NWYyTgr/d4SBeR7h8F7LzAx5WNIL7NJsWzBQ0zFQBvlpf
         55ITtHISBisnIvRD8UbAX6vY1giw5PREWGFlDswLePDIYZXFgJ4OvCv0GmkKZ3mPVOxP
         HFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019219; x=1717624019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZpf9VTSfBz8htfeBs+s3brHEXUpuArUAPIgOCaA62M=;
        b=jLoMjjEo2IWdtW0ljC/wXLjNcTvVSqHZCRTsc2Pop6VwTdSk24vzjqrWsmXq7OJC7L
         ZKKNbee8nbZxeS+mYT/KuPpDY8f1eDMA9ydgAsotlrzwv9vwsrBsVqqze5eXW7cHVsXv
         fRfq2yJQ5VfC2A9ZqX8pDce2l5ckWNu8xzJYgpZyTVYd/Bt46yqV/vW5ELCTQwclSY+a
         558xVish2JXgu5ALIZARItZu2DmVtkYWMkLk8V2rO5w49sVWFwlPa+9SEYBMTOG/6Qfh
         At5rqjCn/hIYhKOVq4sNzlB+ZUwA1wFP1xDCjw9nfUnw01l2w40ze0jmSEpd6dxi9mbb
         eJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUP5vvEEKJyLL6cpmcB0b+FneCVsCVYAi3XjxZuf4K7/z5Qo0eCySDBNZrlSF5rm2CQxpgshh6TfqSCs3QVILR1PX15
X-Gm-Message-State: AOJu0YzA+Gu0fbhQELW+8ekmotZGEvIX0A7iLuYUHSUDj1ZVCAP4Wl2r
	echc/sejo2jJtWT18CLEvxA2lVz2Up2QSTp0fh4br0pBJ/xlCels3ofymA6PUoG0ppEj9GkprBF
	vY+VpXEcZ3rXyvrgUbn4oUTc5XnU=
X-Google-Smtp-Source: AGHT+IFK7GiFV1ci8Ybvb8zxZTtu27n2PBpnBkY0rUp0BjEo4VVHg1dWoSHbkTQMoaBs0BQIWNayD3oHzpkj9BRkwTU=
X-Received: by 2002:a67:fa17:0:b0:48b:a17a:5fe3 with SMTP id
 ada2fe7eead31-48baea1af40mr440097137.16.1717019219097; Wed, 29 May 2024
 14:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
 <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
In-Reply-To: <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 29 May 2024 16:46:48 -0500
Message-ID: <CAE5sdEhnHEsfHRTEY-JUvc15wpXB1LK_OCQWN8KTeU=Xt8E2DA@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	pgovind2@uci.edu, "hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 at 16:20, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 29, 2024 at 8:53=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Hello,
> >
> > We are developing a tool to perform static analysis on the bpf
> > subsystem to detect locking violations. Our tool reported the
> > spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() that
> > could be called from an NMI. If a bpf program holding the lock is
> > interrupted by the same program in NMI, a deadlock can happen. The
> > report was generated for kernel version 6.6-rc4, however, we believe
> > this should still exist in the latest kernel.
>
> Fix it similar to
> https://lore.kernel.org/all/20230911132815.717240-1-toke@redhat.com/
> ?
>

Hi,

This will still not resolve the deadlock caused due to nested bpf
programs, wouldn't it be nice to resolve using per_cpu variable like
in hashmap.

