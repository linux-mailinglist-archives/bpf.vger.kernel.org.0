Return-Path: <bpf+bounces-63211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CFB04326
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A77A7B53D0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F926280A;
	Mon, 14 Jul 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtLXO0RF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D79259C84
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505914; cv=none; b=O1vy5p2///1NfvgogMqGzz7go9uyiNpoVc19wtS2euuT9LBZxvcGUQSimarY/ahgHiL8+mBE3wdQfRiSyf4nOLiXc2e+gHLNbxOaBs1tXiWHYZMerPnWyydk9IcH8bkOB/MUynRpc4V+34uqaSHI1xWOyR3eyc/zAbXA4UWIcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505914; c=relaxed/simple;
	bh=CGhlYq8wXeWBEKovkGfjqv82yQMO+zr3WmoFQXK8ly4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4aWuI6d0iWJEJR5Og1SSrfjFln4mqIPJhgCLyRval/bGExN2ZLj4KM3rIiiLY1B5PMeoMiFUTYAu/WimUkobiNojTWsEUXJSaX5VxdwtjWp1+RgmlpaqYH147eDezrG+Zs5zcma5A6SZDLZ13aF/REjYoH+Yz1EMpbSDdpaqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtLXO0RF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2547797f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752505910; x=1753110710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvcpUlyel1+FPtjiWxfwwEg8xeHoJEF2b9kZhpsAhI0=;
        b=RtLXO0RFXl0ikFzjUSU3hl84gjajg8QR4AqxDIHXoQeHip8JBB6lWuHarXpfvfKZhD
         qOL3mSiMcwYHyeNhzPo7j+GWeS1MT7SNZ+dQUo0m1HZo6MIZYAjP3JAHkaVyRc845qDM
         wGa23Wu0vaOvjLnQudA+eNDrUZQ6QjlflUGEcxOpr0VutaXbjMOUPfXA/zP3AQE2XEi+
         pWaNRbfbCQZ2QK+ZMbwPTL5yTcyskAWBK71bECAahueJWqWHLwad0RXBbb7VQOQKSAvC
         2vCls+0DrDMc0KiJG1LUSe07eBm+d1TZ2I+dPgeCWqGD1YzA2k6zO7y4zJNl0nn5IBCF
         gF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505910; x=1753110710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvcpUlyel1+FPtjiWxfwwEg8xeHoJEF2b9kZhpsAhI0=;
        b=QahlekRXeobi/TxlUqbutju4IXi7OFVfvLslRPXQvjLfzeQzo/JPvzZne+t+0LSlv9
         AsiYg/Se9z4HoHydYUAFh4mTiKUOciUqV09HES54Z2qQlWwu92HQzofY2shBWRby9lt0
         jClYfHiz79tOA0nX4oIUv1VFIpK865a7VEk2QnoSWbu/7QFdcizivMCBuO67tK7uQTFy
         HWvoI8K/jp19pdFiDHDjTo5lG77MH66G85xXRsTjRlsj36vza5qmO8J10jKmhUedVzDc
         FY3TRaYutFGt0lR4grZcVLNd2gieEMtHc9ixgYxDqTustCXwTwd2LclJ5S3ou3ok/pzP
         hoJg==
X-Forwarded-Encrypted: i=1; AJvYcCUGFP+D/Vs/wTVuNosHf5Ps1RsTy8UPkpvR/B59hdBKNvdZ5qWuCM/57TieywODzZKgMhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4cYn8JT4vBRoxT1j5bSHJnb9NfyRBl0p1FzTnhWqGcWKk8eT
	s1MCpMfDduNK/rjvXfDnRofxKsimTI+6+gDYxURzKCZgTzlDEmP600IY0AilntNbzQfTJc/pfYr
	tx7ZGM872MdhTTKmsMqRrq2Wb7KVl5LmQ7g==
X-Gm-Gg: ASbGncv8O0BqHruqDeWkqItfMmL24oXP9kmql9Pt0I+jN04kgdma3StZHHtNOWlpbp0
	z5e0/Zgi9MnjdvoOqlzztcKaW1kWeIlExR/Ee45Soacdyz/gAj8YUKom3biOfBH9aHS+YpA3qYt
	+VA3MxNvU8KldGym2KBqwBBb+Jbx4UXCA8RSEmll/xNQSWhLG9N3W1Mken1VwA/9oPRYwvec8rC
	eER3RGCMKk5Rnn3iQeLoiA=
X-Google-Smtp-Source: AGHT+IFB6H2IOaB7pkrODTyDoT4qwJcZmnrAuLaG3zh/+sVI73E1DOVAPkixwy8CmQG/Fu7VNPJjsMFe/O8HxxhVEIY=
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b5f18dc957mr9769203f8f.46.1752505910294; Mon, 14 Jul 2025
 08:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3D54K6bt5J7Mdk2WdX1ixCaR3o5k99Hz2u8mzMxNRpKA8-ag@mail.gmail.com>
In-Reply-To: <CAL3D54K6bt5J7Mdk2WdX1ixCaR3o5k99Hz2u8mzMxNRpKA8-ag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 08:11:38 -0700
X-Gm-Features: Ac12FXxYP9ltVULomP1C7DNWAEKHBBP4dCc_clK6Prg0YxpJ6pudGJM_DS-nL1I
Message-ID: <CAADnVQLrXcrwLhc7Tq2TojWqb6F4epDoH9Ae0OQaTQN8ckzmsQ@mail.gmail.com>
Subject: Re: Potential bug, uncorrectly accepted cyclyc program by the eBPF verifier
To: Cinthya Celina Tamayo Gonzalez <cinthya.tgonzalez@imtlucca.it>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:31=E2=80=AFAM Cinthya Celina Tamayo Gonzalez
<cinthya.tgonzalez@imtlucca.it> wrote:
>
> The detailed description:
>
>  During my academic research, I discovered a way to reconstruct a cyclic =
eBPF program at the LLVM level that is incorrectly accepted by the verifier=
, even though such a program should be rejected. I have included the releva=
nt code samples and the commands used to reproduce the behavior below.
>
> This is the source code in C, which I saved this program as ''forprogram.=
c'':
>
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> SEC("tracepoint/syscalls/sys_enter_openat")
> int trace_for_loop(void *ctx) {
>     int i =3D 0;
>     int sum =3D 0;
>
>     while (i <=3D 10) {
>         sum +=3D i;
>         i++;
>     }
>
>     return sum;
> }

I see nothing wrong with the program. The loop terminates and
the verifier sees it.
Why do you think it should be rejected?

