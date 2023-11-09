Return-Path: <bpf+bounces-14595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B777E6E18
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63CC1C20A54
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0320B0E;
	Thu,  9 Nov 2023 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ges3WO3O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B210EE
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:56:04 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C8D5A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:56:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3313263888dso561415f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699545362; x=1700150162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LhvZRh/NTi7DvaOLH1nOCRc0Brj6OwHogMfgsAr1no=;
        b=ges3WO3OKuXbO83NgONqS8e9MiLJoKfF0sI28O0ZGFOPJQYk5B+hBOdatwnDgtCEhV
         wBroxlefJRTHpbWAYc/sVtwMvurJZIvdqlS7e6qgZQ4KFnqaDFiH6AJNmiVXEhKeYhEx
         5Py74RvZsvDpm18T7s6u1qVlTyQBoM8R951GiPgEVLCzRN+6xXAvsApkjlmC1pSM4Mjt
         5uOVP4jpJLQkAvR1cC2BdsNckwURjZPCo+6i9VaytBOPj38RlPNa+W7lCrV6k7gVxR87
         36mOcon8Qih+yiSKUiJE4mdLgSRSFy6nYLn0lle5aRuHTgr9KUj9ih6iIsCuDgAeZDRT
         EtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699545362; x=1700150162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LhvZRh/NTi7DvaOLH1nOCRc0Brj6OwHogMfgsAr1no=;
        b=FxzXiTnpGRqQTAa7bnKhvOOXnRdo7mt7f2Bq9aMj2CD21UQMYNUk51NFYAnw4BCfBk
         N9DZgmptK6OC3a9pnEuIeWtp6h8JJLPrP6Bqww4fJJ8Vm/GDJRJD0leMR2mTJHnFZaTo
         krrhiKJSAnZE7bN76tdD9VFXoLmBisyljJw1l5D0CHpxnJnvvFzBBrBObE9nDyvwWt9T
         dcEkh0YdHSZjBDNKRkoygdyhjI5Gwqzi4wcNtWBXNQ/0STEBPD3vzGZwAq5Pn2ERRveI
         McHzj4YHl1v4XqUsc3NBLKd5DcD5UQh73yG5KvK8qSkbmZexQcLTDU0eJsmzyUAi5xcO
         3q8w==
X-Gm-Message-State: AOJu0YwGns8icYAXvDpljcnGjYandvDFOAqeFDPKXMjMK9OZ7uOoWox3
	X/htgfEjryAp0F1ih/xUxeUJPXYIF+ZdbecKTM0=
X-Google-Smtp-Source: AGHT+IFINkt1mC3v5meaNpXKtJpsr2WBz1+UvexW8uvud1RrokmvXmS62Yzwwnjcm+mcF4PaKJOp4MbfEQZpfhR+YNs=
X-Received: by 2002:a05:6000:705:b0:32f:b190:ab69 with SMTP id
 bs5-20020a056000070500b0032fb190ab69mr4518211wrb.71.1699545362152; Thu, 09
 Nov 2023 07:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com> <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
In-Reply-To: <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 07:55:50 -0800
Message-ID: <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr() helpers
To: Hou Tao <houtao@huaweicloud.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 11:26=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 11/9/2023 2:36 PM, Martin KaFai Lau wrote:
> > On 11/7/23 6:06=E2=80=AFAM, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
> >> saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
> >> pointer saved in map-in-map. These two helpers will be used by the
> >> following patches to fix the use-after-free problems for map-in-map.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>   kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++=
++
> >>   kernel/bpf/map_in_map.h | 11 +++++++--
> >>   2 files changed, 60 insertions(+), 2 deletions(-)
> >>
> >>
> SNIP
> >> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
> >> +{
> >> +    struct bpf_inner_map_element *element =3D ptr;
> >> +
> >> +    /* Do bpf_map_put() after a RCU grace period and a tasks trace
> >> +     * RCU grace period, so it is certain that the bpf program which =
is
> >> +     * manipulating the map now has exited when bpf_map_put() is
> >> called.
> >> +     */
> >> +    if (need_defer)
> >
> > "need_defer" should only happen from the syscall cmd? Instead of
> > adding rcu_head to each element, how about
> > "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
>
> No. I have tried the method before, but it didn't work due to dead-lock
> (will mention that in commit message in v2). The reason is that bpf
> syscall program may also do map update through sys_bpf helper. Because
> bpf syscall program is running with sleep-able context and has
> rcu_read_lock_trace being held, so call synchronize_rcu_mult(call_rcu,
> call_rcu_tasks) will lead to dead-lock.

Dead-lock? why?

I think it's legal to do call_rcu_tasks_trace() while inside RCU CS
or RCU tasks trace CS.

