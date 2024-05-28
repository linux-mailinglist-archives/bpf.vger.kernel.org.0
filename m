Return-Path: <bpf+bounces-30758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF878D227A
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD11C22C3B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F71C68E;
	Tue, 28 May 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHJfibjK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65D17E8E6
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917405; cv=none; b=Div9qymdV5cc3GCceYtiKAu1DiDIKIglhUMXxX9dguUiLrX0gvlpKs4K2uNH/741j6iisoeK0oJu267dxaWMYoEUgrLrMRabyUCg/G7nWjpbziE5GfJbv+DxewCt8YkEak/cz4jhYX7A+JPMj+j+zFpLLbABVFP0RB+EM/aodoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917405; c=relaxed/simple;
	bh=SDIJuBOV5D7TPGjzAt5Zz3JTUBGaBIPlFRdauQnVL0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwi14j2+Mc4PV/uUOPsDfGEIcYwv4SUireFMz0uey0BSBugxjiw8EWR0QJpqxAVopTnQ8eGeGi9T//QtIbuSwDq8ERsgoEoqHC5QBXrfpz6lg6lvC8BEoCwwKJ42zjXK7NRS4/C9NIvBLSzGIuPY9YyfNmNazdEnH+rW/k6ohE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHJfibjK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529648cd69dso241040e87.2
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716917402; x=1717522202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7OeA641zFpMpjc2geYL3Cgq7EpWyJRiF2B77FMBQKk=;
        b=BHJfibjKQKsPtix1P8GIMYxSqDuujDQIQ6DmSd0h+lh3AjrsIb63d5EudSdYoBJ8f1
         jUG2EL2Kz/l1Sw5swYWdvzd/qvod+B5CTs/62QXhgWbI+gZcXbmR1WF4E5uSonckaZVY
         0VKvfOb5JMvnYx6eJde9pF5+NXGT1XKTPcfOCje0aXcQScFhsH4h88SMA/IE/zzorNQR
         hpkXwYgDUh1NxaUXu+msEAR9ftmBYvgIfoV8jGIA34cUZaULQbnlcyStOOHhJAT+novv
         psmFhU0QI+YODaHI8RsO+LzMh07JGyIqB5mLirUKy2bhhQ9LUARc/DaIfqE5Q3VOuIBi
         u3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917402; x=1717522202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7OeA641zFpMpjc2geYL3Cgq7EpWyJRiF2B77FMBQKk=;
        b=cxSwDcPHAB7psRB6d789gZtLUbKzKqa8Fsp1M+vB/ggNQGOS73I0pLKQpzl3O3Xqao
         pC5CXEHyFe355PCHl2k76TDSeQ6EiPWUlMmqh7mre7vpOPy3Yv3kBVmGKgVnYWPy+/Gi
         oCAQSH5I2ILIhYwVcg/ZgHqFB2eoLrXwv140g7YncWndpJVErI+61cnNo6W46vurcbOs
         1dYpsmfsce2GmKfL3s+qW/WT2wSAkJrrZyrh3nUE29EGgLpbMct/7McVAEcr+vYSz/il
         Ss8YuFH8gr5fV6QzQdBnFSkny6PsJGGo77Ii2QB3ROH2f1ajaKRHfgWpgrfTquBYPs6r
         nJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEMJQdXACjqbu5de3CKkwURwLSgmk5ymEMLJ9UAHe+VeLuZdEont7v+LvZWaWXLXOCqOHxQoKVHFjFpKoUgJU+V+mT
X-Gm-Message-State: AOJu0Yw2kXJttdV3O8ghI8OODcbtc2bhgNvupZcCjjZ3RrUGHw0UOWpE
	409gtqGZi+SpKXUYAYiVrWx/n8U31GE3I590qUCSnfoNzjCqd5xlI0sW9HT/DqNrpaMbMuWYExy
	YiWVFUaHSxsYfdpiaVdCiORmjSP2znQgD
X-Google-Smtp-Source: AGHT+IH6mKa5yx1rre9qKe1AnXrjVEsskOmjedKaCWbuzXB+Ac4qx4PbU12UxZl9XoSi73QdzN2IVw0UBCgUm7mEDDg=
X-Received: by 2002:a05:6512:b10:b0:516:c5c2:cba8 with SMTP id
 2adb3069b0e04-52964eac446mr14770807e87.12.1716917402228; Tue, 28 May 2024
 10:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 10:29:47 -0700
Message-ID: <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
Subject: Re: [Bpf] Re: Writing into a ring buffer map from user space
To: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:32=E2=80=AFAM Shankar Seal
<Shankar.Seal=3D40microsoft.com@dmarc.ietf.org> wrote:
>
> Adding bpf@vger.kernel.org
>
> A common use case of an BPF ring buffer map to use as a queue of events g=
enerated by BPF programs that can be read in-order by user space applicatio=
ns. I have a scenario requirement for a user space application to write int=
o a ring buffer (or similar) map, such that events by BPF programs in kerne=
l and user space applications are interleaved in the order they were genera=
ted, that can be consumed by another user space application
>
> I would like to implement this new feature in the https://github.com/micr=
osoft/ebpf-for-windows project. But before I go ahead with the implementati=
on, I wanted to check if there is any way to accomplish this in Linux today=
? If not, is there any reason why this should not be done?

Yes, there is. See user_ring_buffer ([0], [1]).

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/prog_tests/user_ringbuf.c
  [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/progs/user_ringbuf_success.c

>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
>
>
> ________________________________
> From: Shankar Seal
> Sent: Tuesday, May 28, 2024 12:40 AM
> To: bpf@ietf.org <bpf@ietf.org>
> Subject: Writing into a ring buffer map from user space
>
>
> I have a scenario requirement for a user space application to write into =
a ring buffer eBPF map that I would like to implement in the https://github=
.com/microsoft/ebpf-for-windows project. Is there any way to accomplish thi=
s in Linux today? If not, is there any reason why this should not be done?
>
>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
>
>
> --
> Bpf mailing list -- bpf@ietf.org
> To unsubscribe send an email to bpf-leave@ietf.org

