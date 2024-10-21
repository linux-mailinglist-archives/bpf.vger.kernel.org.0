Return-Path: <bpf+bounces-42668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B327D9A70E2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 19:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748A4281D62
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C91EBFFD;
	Mon, 21 Oct 2024 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k45W+BAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B01E3780;
	Mon, 21 Oct 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531106; cv=none; b=i7xEM7q8f6nQWcHujK+tw+IEa+Yo1a48nfyxFi3sXBBJH1LG7VhkmNHlj0nPUDJKM4E7r+TJGEoAOD6j9h0SxJLm5+bQ8Ud1ahdt15U1hHrB+46IQqgYQLoDy0L6zw151aEBt8+uoPd1j7TSAjLMKxlmD/sJWSUZxrZhMk874xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531106; c=relaxed/simple;
	bh=V7TFdLX2hJz506Bk2w4njaCkNtCSH4Ab/bCQMimnPR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3nT0GrwPWHdpSzkOcB6a/XL7aTXgW4iIwmWfJugxA0yQRuF9Jw7gqfHaLJYz6GHr8PQVMfAPBfs7K+gWDPuWRmmITF3WHl8Sal4rlDBBHpqcgTd54pM6elmRxLEZWmRXMnYqdgsiukZNN7KwXcbJ90TUZyTf0qa0Z5POIgdM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k45W+BAr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db54269325so3671334a12.2;
        Mon, 21 Oct 2024 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729531104; x=1730135904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7TFdLX2hJz506Bk2w4njaCkNtCSH4Ab/bCQMimnPR4=;
        b=k45W+BAr9sYS2lSfTtB+2DQUElMXCp/mxWzY8dFoqfqt6ql4jGiPHWJxUlBtkk3RMN
         s/kDO2iWykCuKg7Yzrjq3braWBM8neeNVxHL0K+DNuBicdtKV3lnnG2n/shW/Dc1ZuDI
         Frk2cLa3Zrr36pHPYCoSuaBW2Hifyl6yErNxM0+MQQJcTSy2hAMSjLoaIUq+67BK4mGK
         eEObe64XQaQO9VR7NfY+nTX75yKITdGmv5/DLXGDwQgkD1qBYoF1yPAf0QN8SkXpB+DY
         JPAWIP4ZQzsT69uD/FLPSyGElO/JxRQFJcT9XtotHmdcBCLbZd54Mfq9o3d3/YU624Pb
         ie2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531104; x=1730135904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7TFdLX2hJz506Bk2w4njaCkNtCSH4Ab/bCQMimnPR4=;
        b=sMELOA2X9k53ss41KDnj90wQwwiHmPur2j6s2clZUsXRhcHTUThkbY8YAuCVqS1vjJ
         RqOFj7Ac8yJVJzWbow5sdtwsdSUoAOZZxXFyoTzLEbMhVLrA0h6yrUBWOIgVcOoLZb5B
         Z5C7WWgMMQqiyG2VOI0X5u5oxmd87ZGFMMxaqDEXZdNdHHAURKURSwEQkU86A1G/PcIB
         Hnj0B5uWbphRvrwiLLL2YBKxb/IHpzDCnyoB9s1aHwr7SrlBc1PW+PxAQ0sUY5UTCq2T
         SIYTvhtqfWAdaszFTm3eQDSD/ZWVQlViygkdvPdEs/nLwBDnoB2UVntZzLBaIJSJLx6s
         KV9A==
X-Forwarded-Encrypted: i=1; AJvYcCULx8tsrs7o60/G2ADJQ5oLT1oDtJh68SBT6riD9AJolrC4eabZHPw+06GPciFQELnv5ToEKvmFTI49ewgIgVDPLQ==@vger.kernel.org, AJvYcCVHD8dFXRUS2OApzcKU6488QPviJsMwymEq8ZvMDofCSnQY3ZPXJcX0YalRHr3f6ybgo7xvbOnd5WNzhEw6+BVw6ddq@vger.kernel.org, AJvYcCWxjVr0SO+Sk3bOSR3PJG44G8hZAxLch1RHhOt44/0DcKDZHkMzjtpkHxdGO4duDcj3fiMEqDnCPTmFeb+k@vger.kernel.org, AJvYcCXgKwBtcNDck7o8TAGxwhLqep8x5/Tk2wbkVr/HOKKPvGKb4KBWq870dzVnn9/EETjffbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8gijyE/bKUuj8z49cniU0Z+p+32gS7ouujBBkr/aNL8wLkX5
	0O1ua1/8BM5/Y9vaVJoShhjU/zr7hqlCWEGiqfCAi7tFYRLvT8ZhuejHvczoVO/SbxF0XzAe+n+
	+8mSXbMsPMgOlK202jq/mcLYrO9A=
X-Google-Smtp-Source: AGHT+IEtjRnzsFF0rccF8dhsyizMIfwjKbdz+eyx5/1jxrXi2lAdRxwdwQPa2usdahgePbWs7gtMmySSeSiKkVlwd2E=
X-Received: by 2002:a05:6a21:6711:b0:1d9:261c:5937 with SMTP id
 adf61e73a8af0-1d92c59992cmr15712304637.33.1729531103939; Mon, 21 Oct 2024
 10:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815014629.2685155-1-liaochang1@huawei.com>
 <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com> <20240915151803.GD27726@redhat.com>
 <c5765c03-a584-3527-8ca4-54b646f49433@huawei.com> <CAEf4BzbWLf3K4C7GT58nXZ0FJfnoeCdLeRvKtwA76oM9Jdm7jg@mail.gmail.com>
 <e62dbebc-d366-453a-b305-67f50baeff05@huawei.com>
In-Reply-To: <e62dbebc-d366-453a-b305-67f50baeff05@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 10:18:11 -0700
Message-ID: <CAEf4BzYUdPJrgy1Dqinxk5ATPxA8WCTzQW3QcWobZpXjiYDZNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:43=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/10/12 3:34, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Sep 17, 2024 at 7:05=E2=80=AFPM Liao, Chang <liaochang1@huawei.=
com> wrote:
> >>
> >> Hi, Peter and Masami
> >>
> >> I look forward to your inputs on these series. Andrii has proven they =
are
> >> hepful for uprobe scalability.
> >>
> >> Thanks.
> >>
> >> =E5=9C=A8 2024/9/15 23:18, Oleg Nesterov =E5=86=99=E9=81=93:
> >>> Hi Liao,
> >>>
> >>> On 09/14, Liao, Chang wrote:
> >>>>
> >>>> Hi, Oleg
> >>>>
> >>>> Kindly ping.
> >>>>
> >>>> This series have been pending for a month. Is thre any issue I overl=
ook?
> >>>
> >>> Well, I have already acked both patches.
> >>>
> >>> Please resend them to Peter/Masami, with my acks included.
> >>>
> >
> > Hey Liao,
> >
> > I didn't see v4 from you for this patch set with Oleg's acks. Did you
> > get a chance to rebase, add acks, and send the latest version?
>
> Andrii,
>
> I am ready to send v4 based on the latest kernel from next tree. Otherwis=
e,
> I haven't heard back from any of maintainers except Oleg, so I'm a bit un=
sure
> if I should make further changes to this series.
>

Let's just rebase to the latest tip/perf/core and resend with Oleg's
ack. Hopefully this should be enough.

> >
> >>> Oleg.
> >>>
> >>>
> >>
> >> --
> >> BR
> >> Liao, Chang
>
> --
> BR
> Liao, Chang
>

