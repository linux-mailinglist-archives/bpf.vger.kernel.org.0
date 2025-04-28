Return-Path: <bpf+bounces-56874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F163EA9FCC5
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 00:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB731A869F8
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DA210F4D;
	Mon, 28 Apr 2025 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqPSRF+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE215687D;
	Mon, 28 Apr 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878366; cv=none; b=d6qEVFFfVjNbJ+C3UfYubyyTQViH+O9gYYKrRQkFVGt6rK+6G25EA9SkF14WGI1cpPFss9HDvB5yo6kOgWBpX1YeJZ2mFSbfs+1dqJWm6kie2x25TR+co6FWxyUYtdyabLNEClCjxQ0vHbKQ+GwHzQluLXNTTylUDHv2HDxL9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878366; c=relaxed/simple;
	bh=9ta4DJaVhpLrk8zTbnUw2pDF8ZL8lESUfxz6CGm59qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKA/+uW59mRsACTW+/rOnWx3tvjffqXWzlSll2kWCiYirMPfLq6iz0Je9scIMJZUePSleL4QSunfH5mrJZIAkXAnMPtJR6/wmu6iTSQZIbF6ilH4st/dT+4+aNu1vYCyOlNslPzWJqI4TFlGNZfBwEr16kWRLhuswP9xPs+2d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqPSRF+9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1efc4577so3089857f8f.0;
        Mon, 28 Apr 2025 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745878363; x=1746483163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6x9hW8tIQxDu42gUkc/45R7MiCd7hErxRq3fBIsFKT0=;
        b=ZqPSRF+9+UsVXGXKyF/YPmxmnrA3/o4QjxsDDf4N8A39JwgEGEY5ewZZe/MgRpMC9H
         fHcR2uH4AjOhe0J/Zs4Gz1aAOCINz0vrTcSIELTh3MDN62d/0XUjJIA6Iydp30Zq30yS
         tVoFMqsf8NPTZvnkYciH7xo221uwNBw/Ndcl2+HwI+djkRwkFBG9WXvFEIsrPu3IIe5H
         wMux/OpOmNWS7odkxU6yH2viORJpwnCvXZ6THPQA1mBo/gp3xm21zy6RCcTGQMloMVPF
         ChWvXaLI7Ph5CkyWRwDzDPFB0g3jODNaSeUKTRcQQiYvAIKYE3gmpf8SeSlg2xstSVNb
         fXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745878363; x=1746483163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6x9hW8tIQxDu42gUkc/45R7MiCd7hErxRq3fBIsFKT0=;
        b=e831fxok3v1bmkPO2Cy3W1zE6iifVhgEy6TE3fm0aYSPEKoJ9Ls3tnXiteepCBvD+P
         6hhRs0dFJukXbTZB3zIA2jxC0C4CVRGliCcIAgPyYh/3UaVeQsWF0aS7XvUpVJ9QlMkr
         oXDnkRa2RccDBVYAm6xHYJGej9Hvlf08ZhDMFmWf419jKVmChIsKHwtKz42TzU9ziKDQ
         BThNyCBm9U2x5o/bJw4Xpyvk28Cp350QaJjBhSnuEaOceirToJN3UHB42z9+/UkRwn8P
         pro22unk+9trbA+tdG3OJw0KSiR9jvtod5V0F104yDofLotx7cv4xhlTSf90ROdlC5Yc
         q6qA==
X-Forwarded-Encrypted: i=1; AJvYcCVt25sNac7pueikqxw10NOe8yz9DtwhsuR4DCKtmWzaQgL+18N/co1RP1nTK0LGVz2P1eU=@vger.kernel.org, AJvYcCXEHtxdotFFPnOl1feVZV1dsxGEA/n2zL16jVtMjeOZtk8YK3YKniMfUK+h3kUWyyMXa8KsEUB/BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQtuum8XX9GRTQcslPgs2WfCzvmuVIVHjsUzpJOup7Q2v/bvL
	mLtyIJa59Dt4GPTBuzkCnyzRj2tQFsl2MqQ3dhs/jhc3havbaj18lGCwlbXsgBzWHmOs9GijmCu
	dskacglHwBo7e6LX6/4yjcb6YFy0=
X-Gm-Gg: ASbGncuU429mymK3cRVJiXZRiLyaigiuogiyhgKMC3TmufwyV0mopjs0/d+Mcru5OLu
	tAaHW8aSA+ij8ytVeW8m8uOPnJwfZmKxp8V3wgvW31Pej0MkhAdgQv5HUOHdU6RScAZ0A0Wkk3F
	mmz8g5kCRVkplP9iM35CA03v1ozDOceD8dm8MKoeEiqIxWdpKT
X-Google-Smtp-Source: AGHT+IFXY9oLZdv+0ASZvt5YQPrkJxMiA0v56RHAfDxcbayXhXzO1nSrCsI9uzG9inhYaU2w68iznVUo3nL4wCr+/3k=
X-Received: by 2002:a05:6000:290b:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-3a08a3c977bmr612070f8f.59.1745878362632; Mon, 28 Apr 2025
 15:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
In-Reply-To: <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Apr 2025 15:12:30 -0700
X-Gm-Features: ATxdqUGDHkPAVe36PBqTL8vv9rSD1GEjx3LSXRvmGsG4bxvnJHVJdfRbLh1tphw
Message-ID: <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:21=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
>  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
>     <4bd06>   DW_AT_byte_size   : 8
>     <4bd07>   DW_AT_address_class: 2
>     <4bd08>   DW_AT_type        : <0x301cd>
>
> ...which points at an int
>
>  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
>     <301cf>   DW_AT_byte_size   : 4
>     <301d0>   DW_AT_encoding    : 5     (signed)
>     <301d1>   DW_AT_name        : int
>     <301d5>   DW_AT_name        : int
>
> ...but note the the DW_AT_address_class attribute in the latter case and
> the two DW_AT_name values. We don't use that address attribute in pahole
> as far as I can see, but it might be enough to cause problems.

DW_AT_address_class is there because it's an actual address space
qualifier in C. The dwarf is correct, but I thought pahole
will ignore it while converting to BTF, so it shouldn't matter
from dedup pov.

And since dedup is working for vmlinux BTF, I doubt there are CUs
where the same type is represented with different dwarf id-s.
Otherwise dedup wouldn't have worked for vmlinux.

DW_AT_name is concerning. Sounds like it's a gcc bug, but it
shouldn't be causing dedup issues for modules.

So what is the workaround?

We need to find it asap. Since at present we cannot build
kernels with gcc-14, since modules won't dedup BTF.
Hence a bunch of selftests/bpf are failing.
We want to upgrade BPF CI to gcc-14 to catch nginx-like issues,
but we cannot until this pahole/dedup issue is resolved.

