Return-Path: <bpf+bounces-42937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD79AD30C
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F6F282D13
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1071CEEAA;
	Wed, 23 Oct 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv0UpDwb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB14087C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705479; cv=none; b=uXuWMO6lOWTfiZ5j5SQdVsO31KumVGq/WBzhlNq6ehF6qTuD3z7408xu0IlshXK02sr/M717zO87d5QyVqZZ5Ap9eywcDyODZQ5jd26A3znznVbwl0EkbuM6I4vhJpufatbF41cY5ViczAnrfeFHCNgSuqPHyIW+3HOP2lWPoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705479; c=relaxed/simple;
	bh=SXiVYAA4bGqtfkCcvSKGzGe+xHJJkMGd01+BlkhPw6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPPqAr3BO3btvF3EOJz9XnjLpO4jqlebI7u6/0NI8orOSe2jHZFHL2pQY3co4rBgRcuJYGny2izbIIV74nXHHrJdy289VuP0WPYtKDDcp1P1bZLpSek/e6oZYMOTpmwXgY667F/wbhpMUfQIUDz5qJTarjMfpUAdNz6IaLbbNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv0UpDwb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so76712b3a.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705477; x=1730310277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXiVYAA4bGqtfkCcvSKGzGe+xHJJkMGd01+BlkhPw6U=;
        b=Gv0UpDwbMCoXbqtEf+fDQ1hxqdf4Ul+Y92JxP+k3wqmKFBkAyhMyA9+I1+4zBOxr2X
         1bMuYOTZwr62ORgYsmMxqMmz91ye+wxAgubJGOxh5oEO+VpNtyyKR1CliFUMnroaf7hw
         AyQhN2BCZaBcpplR/BnVFGxXKQqJsE5D2ybLHDE4AtBVFD8sD0JVBX6en5pvD8EYLW1e
         6NlViEfnLGNn10Su/1qIlwYEg1GOhRtydqygdxexBH48uqjsidAxYBgYd+8Dq5BmoE+8
         0gOsM0ZSktxsZ8G87Ho8yuqIDrx7PGP8XL2LuvEruUNBVaILEUxxC5HzFgoz1wEGzPII
         OzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705477; x=1730310277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXiVYAA4bGqtfkCcvSKGzGe+xHJJkMGd01+BlkhPw6U=;
        b=BcJLq/Wm7d6ZQRSXWFbMZqZLdCkxa7Bq+snHt1Yaga8TbdhTPKpimMjoECbkFZuHMM
         y/wTkN4sKW0qESgsrnAJxvT+FpgX43jHS8ncdOE0p6wuL03jH/ds2OEGh3raGrMGrXPJ
         0T47C+kpmh2ll7FHRV7NZcA+M/vZtvpsmpfPitNMX7filHxZNUH68diIlotGnrM/gYJi
         Ru6H/ra9MYVuZLEyxKQOwdAYI9JEo3MIvAJq1IVFZ1Evte3tvR2TwH4LU3o8DyZWvqz6
         e+Ls6YAFdPJagS8I3jvrhNHrMBpZuMOV6kf9KUGQb4bu4O9abXT/ar41hvi+o3aNkH68
         ixug==
X-Forwarded-Encrypted: i=1; AJvYcCXzQP0omW7/QcvV+uFwBniKhbH4eO+fRpcnX8wCHqsjEJRDvLip8T0Bk5mrT4xagSc1hvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EtfHwEF8U3h/t40NIa7qfWr01WtilMwWj2rAhIbBcyaY708g
	k0N0c3NlFkfEO5MQ1v50aAPaKV5CAY2d6LFb6bdPo/c8Z6o/Ar0SBurNRCp390pxc2s2HPvPud3
	LgajuZY/Tgj1q2Cc+fXN+DLOEaPM=
X-Google-Smtp-Source: AGHT+IEbVp7yY2PoGcPbt6nj90/9HDTpvoHmKbT61FdLcaYBmwNS0CNNP8M2WDZJ76qJWWsb1iZcUpsd+MyBOYFURiY=
X-Received: by 2002:a05:6a00:190e:b0:71e:4786:98ee with SMTP id
 d2e1a72fcca58-72030cafd23mr4975592b3a.21.1729705477400; Wed, 23 Oct 2024
 10:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023022752.172005-1-houtao@huaweicloud.com>
 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
 <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
 <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
 <CAEf4Bzbyz0+mKQZ+nM0X0RVb-z4F0e1idu1mg=EG31TMWwaiyw@mail.gmail.com> <103921223376b39aaed144d1238d77e8c729a66c.camel@gmail.com>
In-Reply-To: <103921223376b39aaed144d1238d77e8c729a66c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:44:24 -0700
Message-ID: <CAEf4BzY4qqxaEtqSkav9h9=M7b4+swH-x+g5aNFyyJdSUUHtNw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to 128 bits
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:37=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-10-23 at 10:33 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Using two u64s to describe stack slot mask is really-really
> > inconvenient.
>
> Yes
>
> > and increases memory usage by quite a lot. Given we intend to have
> > insn_history for each instruction soon, I'd keep stack size at max
> > of 512 bytes, even with bpf_fastcall.
>
> By 8mb for 1M instructions program.
>
> > Is it possible?
>
> If we drop this +40 bytes slack space everything else should work as
> expected.

I'd be OK with that.

