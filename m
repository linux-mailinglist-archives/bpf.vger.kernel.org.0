Return-Path: <bpf+bounces-14310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223237E2D3C
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533FE1C2040B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC42906;
	Mon,  6 Nov 2023 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJLWxG9P"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DA2F41
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 19:52:05 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17222125
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 11:52:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c3aec5f326so1186947166b.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699300322; x=1699905122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz6Fxb92TtgxJ87j2zenm0gC8JcICK9q4/7S6rpM/V4=;
        b=aJLWxG9PDwMNdWCi6t0SfjdE5blskELEnb6EBbCLOrI0jD5yhpVoG0EXrXtD23JpVO
         uM5lJ/0pyfy+0h2VveUrqub/HpeKoI6FQ2rxp92oIFOdbISBhznBva2IQYgqyj9iLhzO
         ayEpisJGU2liHdHbOQQPOA3k6Fc/zrnYMmbrC+v6JKN+Pg9RqLaBKPDK3reSx+8ON898
         J/scCXItyegPgqAAcpd1O3+OrDFO3FeUiA+Hcl7Fr1SufJ0KT05LpN1PAriIBhn/8qo/
         7Q8bhTlXYUUmxT/QKh3egJoT8C/fxitBQTyybH5nUyaZJ5RIj9KM/8GuDLz4O4mjhDOM
         1UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699300322; x=1699905122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz6Fxb92TtgxJ87j2zenm0gC8JcICK9q4/7S6rpM/V4=;
        b=Zkz8bMDlX7FVE+EXdyMRucVMIASOxqq2ClTdbsrYuC/rNAPbAPzSceNGpevQ4A1mWu
         fpM6uymRg2XIJanM2gNMwSEkRLvD7fFw80TwYsqi9D1OO7A4kx8wl6M+S1Ja0tELG42k
         QyfGPYVhzV7rtC6A983A7cREoikOYeAENDJIb9dsoUp1X2mYVnI3rtUrJRmpygbkbVo5
         YtmiDDRXWSJrrVVBCO4tiEhqcekSRkunLDOxyMDqLs6ipSd7SzjGvrKCVC3c0XiaY6x3
         oO2Ld+u9+87mTPwPv/91Br+96+52gIc4P7rqZIiijUDGbzK5HkU4WyeEyEyfa6UeuTJy
         FF7g==
X-Gm-Message-State: AOJu0Yx0k2vmUIzJI/3SAIqSsEh5XTR/73bpDCjhtOt0tw+6M3CRVq2N
	Yqctv2Xz8rB0hpSEG7bjpwVA0zaHAtAmG2O3vimEDhPX
X-Google-Smtp-Source: AGHT+IGY/L0H/YfOVeAt/STs4/1g0sbXKvzCtdQ4W4rgyCGN1oJ3UYViZW+0TfQHt5mDJ7gGIp+FPhTHw0FaAlDcaJ8=
X-Received: by 2002:a17:907:3da0:b0:9ae:5df2:2291 with SMTP id
 he32-20020a1709073da000b009ae5df22291mr456587ejc.1.1699300322356; Mon, 06 Nov
 2023 11:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABfcHotwAEFraonQVhra82kzDK_3sFRqjQRg-WeVyzKkZHmJ5w@mail.gmail.com>
 <CAEf4Bzab7_N4s_+gJr9u_k+gU8XKkfmcnO7vGTGO4wD_kUZ+yA@mail.gmail.com> <CABfcHou1zjOCQ_RtWDiUcpGaX8ABfXwk=1PVS1MZoznPRTKRvQ@mail.gmail.com>
In-Reply-To: <CABfcHou1zjOCQ_RtWDiUcpGaX8ABfXwk=1PVS1MZoznPRTKRvQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 11:51:51 -0800
Message-ID: <CAEf4BzYrz6Fu-gbZ5h+y9XWHYTU-REvcFk6mgOiCky95t1UoHg@mail.gmail.com>
Subject: Re: Need help in bpf exec hook for execsnoop command
To: sunilhasbe@gmail.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:57=E2=80=AFAM sunil hasbe <sunilhasbe@gmail.com> w=
rote:
>
> > Check what error bpf_probe_read_user() returns. If it's -EFAULT, then
> > it's probably the case that user memory is not physically present in
> > memory and needs to be paged in, which is not allowed for
> > non-sleepable BPF programs. So you'd need to make use of
> > bpf_copy_from_user() and use sleepable BPF programs.
>
> Hi Andrii,
>
> We have tried using bpf_probe_read_user and it does not seem to be
> returning any error, instead it returns 0. We are using a

if bpf_probe_read_user() didn't return an error, then read data should
be valid. If that data is all zeros (empty string?), then I guess env
is empty. I don't know why, you'd need to debug this, but this isn't
an BPF issue, most probably.

> non-sleepable bpf program.
> This looks like a very special case where it is unable to fetch a few
> arguments. This is the same
> behaviour in opensnoop as well. We have tested the test on the 6.2
> kernel as well and seeing the
> same behaviour.
>
> Do you suggest any alternative method to capture arguments in the ebpf
> hooks? Or should we file
> a bug in the kernel ebpf subsystem?

