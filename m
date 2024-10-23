Return-Path: <bpf+bounces-42942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6E9AD37A
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053991C221A1
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C51CF5C3;
	Wed, 23 Oct 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwfqqfvq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C11611E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706558; cv=none; b=DSRVg57rww5iR3ueoJsgUTAXhpVdXyM+rAgTK+yELcRZgh+Hm2cGFSj3nlQ9Xip+aUxuviAoHGa7kfWe1YhyANdmPKj/0+C56RrTp7gOXN0ftQW6jpA7yMyzukB0/qkN1K0hznybxEg4ugtUdwvO0O7NOM0eOv2t69QbMlW8up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706558; c=relaxed/simple;
	bh=58110rjj8ECAUjdcyv2HyATkBBPuWe9HFNCgJryXqm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKP5PPIyChKLdyLO5L1+4Rk+SqVich1raWfoDgUEgEd7MYQ21ZGCSADh2ZPb+GFjJGe8PX02Z7z8vePH1eWFeU0F1rbijWcOReqe2mwMWNTvK4xOGp42iEMyO5yIH6QMxl24+tujVGtuw+L2ZdAmYKvoMsHLXARnXBlbGEuH/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwfqqfvq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so91365b3a.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729706556; x=1730311356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58110rjj8ECAUjdcyv2HyATkBBPuWe9HFNCgJryXqm0=;
        b=NwfqqfvqxfnWTPQ1H13GdhHpn26tYP4ptPI1ZNc9FWjTROOABaFTyBBCZEfPYct1Gk
         pvv5n89zORx6CRuW8tV4kDFOYto2PRhiHgmd3gljfdJYyYlrRhI0MPBnoUDAyRvf7YYP
         Qe3tl2HOyU6c1ptdwKNwzXwG41SfdY3Ysk8SlcaTMBY3+RDHY7GRGh7+4zDTHq1G8o3O
         kXSrlCDva6vmCZbbMeGjUQxLaP9vsHohQ7AJxJxHXioQzGd56JYxQUZyly8P+WTHGSfP
         Us5lLl5ShQyvTMME25wrrThp3MyVcmiavEyK++wTZQqeiHuup0fPE1uAr90dui5QPjzS
         01Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706556; x=1730311356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58110rjj8ECAUjdcyv2HyATkBBPuWe9HFNCgJryXqm0=;
        b=fniY6cfIZeKRhCFSg1g+MZMFb1RKf+cqtX/vr4kuOnaBu7/+bn6IPU7kxZ77nwuWKv
         k4VDMKTUJaaej2G48XC5j67lU97cr4VILAiZsEgTnTFMs+U4rkkjdzPvtwlOWZsxDhuI
         uF6OdqbOL2YNJAbvbcX0iGPoIRT925BObk8zPWwhcKgQlY0BtLEnMJV78bYsDav9k53f
         wdtYe032tBwVSyRDquRZGKqvGgPkhyZts6kbugzCmVU+c+q61U+RoCoFcVdEwfcHmljC
         1ucs//mekAceXysoPhQp+pFQVdOsxC/d3b+1MLVDBvrtV+0MlldafKqNTtc4jUYff31Z
         DChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHWUnMFarM6GsCIueh3RQ2QuICmKKqPWlcXt4EW6dOzwVUO2lh4lfWYDEjUR1x4wCMBEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrHo1AKyyWQ2jceb0aND13dBOuEDpv8VzVw6bsSxJK4dv3FxG
	g9pT0XnXsDpijDMW+noQXQ3DWMOOoZ8R6xwrN8mRcQfcQ7lk6lJM
X-Google-Smtp-Source: AGHT+IH6QjsjBSKD9mCtltVbV/RHqSrIkkjJ4a7eg/mJVW2M1Lq7/86gsqtsHK7KtsAh4KouAtU6QQ==
X-Received: by 2002:a05:6a00:1256:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-72030bd4ba9mr4596958b3a.28.1729706556268;
        Wed, 23 Oct 2024 11:02:36 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:8d0d:a476:ef4f:e44b? ([2620:10d:c090:600::1:eba9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313a10sm6645156b3a.38.2024.10.23.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:02:35 -0700 (PDT)
Message-ID: <2d7f4edc50e8f99241273cfd7ab614dba0a3bb56.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to
 128 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>,  houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 23 Oct 2024 11:02:32 -0700
In-Reply-To: <CAEf4BzY4qqxaEtqSkav9h9=M7b4+swH-x+g5aNFyyJdSUUHtNw@mail.gmail.com>
References: <20241023022752.172005-1-houtao@huaweicloud.com>
	 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
	 <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
	 <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
	 <CAEf4Bzbyz0+mKQZ+nM0X0RVb-z4F0e1idu1mg=EG31TMWwaiyw@mail.gmail.com>
	 <103921223376b39aaed144d1238d77e8c729a66c.camel@gmail.com>
	 <CAEf4BzY4qqxaEtqSkav9h9=M7b4+swH-x+g5aNFyyJdSUUHtNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 10:44 -0700, Andrii Nakryiko wrote:

[...]

> > If we drop this +40 bytes slack space everything else should work as
> > expected.
>=20
> I'd be OK with that.

Andrii, Hou,

Discussed this with Alexei off-list.
The decision is to drop the 40 bytes extension.
I'll send a patch today.

