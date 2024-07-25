Return-Path: <bpf+bounces-35638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4B93C1FD
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC26D1F215AB
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFB1993A7;
	Thu, 25 Jul 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXvhDNfP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CC14277
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910479; cv=none; b=LWl294mIGeTH3fmrMoAaiUedXu977XBddHZVU1uvMHU8ZgGrh/G0WyeLLg1c6xBlCL2jRnCVlnpblrhu3lQi7y6VuDOKcpu1SdkfM40vKu0whYpo9X5p6qnWIc8gcqWEuoMhxhv1u+UgPE7tJFesxViK1mQn6LOm6A4PNUdW+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910479; c=relaxed/simple;
	bh=bYfTJU5J3Xf7irM5LsWIHFhtBBuZJjmB0SNRjxdSLBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfDEjc9x+HbkWkFFmd/Ptg0p8EndW1VJvKCEoiA/JEPsStJkYlzYGzIbywQ0QG0cdoKK36lO3BcknVDA9J9vJIg24eiDqpW0ZjAHA94juy/2q4c2+DztraNoyNXz7QrN5Lm6L8355XtnvIAj6QhtehiCYUuy+7JpVtpU95zBv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXvhDNfP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=valU9uUKvIoSYUW1dOd+x8hjHVmEom8zV+x/SaQos/c=;
	b=LXvhDNfPNUBzHUp08LU+ezbzwj0rBMHsare+wnxCZ66ydjFSr8WQHjG88zkkOHSSbzfa9R
	uNszBfRgOHPD4p7pdPOA8Wgi85k7uZcE/T5i/XQYrWi5TcGeyy8RuHCjs2BbbKsd7C5d+8
	1Hj3H12vka+103u22dZiRu30r3Kl2ss=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-ZIhSlqFMOQKfuiW6Od8sig-1; Thu, 25 Jul 2024 08:27:54 -0400
X-MC-Unique: ZIhSlqFMOQKfuiW6Od8sig-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-650fccfd1dfso22635797b3.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910474; x=1722515274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=valU9uUKvIoSYUW1dOd+x8hjHVmEom8zV+x/SaQos/c=;
        b=qYR53gSIn0v5TFwJFOmvpGs/OF+k+D+246RzOgitXtsopfmSWuehtBHNfhC4K5umiD
         sjN7bwv3VRQX59qFlqUec3rx8uTqbWJCLpaLwxgriFOrx22H6WYcum6gZZ0pNo5kgi0f
         q4c9MUuLkHmylKARAX4quugOz4HUGvlG+3KCMQPLjmW1eHWex9PSSHHYsFOK2QW90l1Y
         C25DdJyTHe+SxKpXcRNKbhCJkOCzXQ+iKCncTUDOFkNF3jH2S+HLdGhZDzW9CjlnS1w7
         Bj21p8OCFDkN8r8DU29qABuEoe7pwY33Q4AlDWEI00ZAm/8h2eT9RTeCbkbHKfmjgCvA
         pIaw==
X-Forwarded-Encrypted: i=1; AJvYcCUOJ5LdzJhHd4SLlv1e4DLr1f/PUMujt+Mv+jF43j1u4Z1FfJGNjDKjOz6yyqgvtXMyLj0oj2Syel0KkSXUHPW2emJA
X-Gm-Message-State: AOJu0YxjA/Ye31JPJkejyyBiU6AjRbE8FvPf1FKbMONUbuwIQoWrscTz
	RWd+iv+qrq3Ng+mauV2WQf1DuLbtRhRBapnVWscXO+Lqu2WS416HuEw2TUPhq3zvIFO5qnsJzpV
	YzESca9gKrcoRTjGPvB4vst4QLL/06lyFnxFvzWlOKkFbTisjQFc+1Qn3bmfD70TXKUBq0OxKQk
	rFl4Daa/gGC14anNDqMK2UNc44
X-Received: by 2002:a05:690c:660e:b0:65f:cd49:44a1 with SMTP id 00721157ae682-675b9e4fed9mr20001267b3.22.1721910474143;
        Thu, 25 Jul 2024 05:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfhOFKdYQHB23Bh2erfYZQ8hsK7ZBQwiqtto4T1nCTiJ2mBqudhVqOYcqhJlMSXSROfevyjivclJTD+EgSgc=
X-Received: by 2002:a05:690c:660e:b0:65f:cd49:44a1 with SMTP id
 00721157ae682-675b9e4fed9mr20001097b3.22.1721910473811; Thu, 25 Jul 2024
 05:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net> <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com> <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com> <87v80uol97.fsf@toke.dk>
In-Reply-To: <87v80uol97.fsf@toke.dk>
From: Samuel Dobron <sdobron@redhat.com>
Date: Thu, 25 Jul 2024 14:27:43 +0200
Message-ID: <CA+h3auNx4jTALyhYAm9w6xaObnTvyCAMp7pNTOym5jcX5rJz=A@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"hawk@kernel.org" <hawk@kernel.org>, "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirming that this is just mlx5 issue, intel is fine.

I just did a quick test with disabled[0] Spectre v2 mitigations.
The performance remains the same, no difference at all.

Sam.

[0]:
$ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
Vulnerable; IBPB: disabled; STIBP: disabled; PBRSB-eIBRS: Vulnerable;
BHI: Vulnerable

On Wed, Jul 24, 2024 at 5:48=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Carolina Jubran <cjubran@nvidia.com> writes:
>
> > On 22/07/2024 12:26, Dragos Tatulea wrote:
> >> On Sun, 2024-06-30 at 14:43 +0300, Tariq Toukan wrote:
> >>>
> >>> On 21/06/2024 15:35, Samuel Dobron wrote:
> >>>> Hey all,
> >>>>
> >>>> Yeah, we do tests for ELN kernels [1] on a regular basis. Since
> >>>> ~January of this year.
> >>>>
> >>>> As already mentioned, mlx5 is the only driver affected by this regre=
ssion.
> >>>> Unfortunately, I think Jesper is actually hitting 2 regressions we n=
oticed,
> >>>> the one already mentioned by Toke, another one [0] has been reported
> >>>> in early February.
> >>>> Btw. issue mentioned by Toke has been moved to Jira, see [5].
> >>>>
> >>>> Not sure all of you are able to see the content of [0], Jira says it=
's
> >>>> RH-confidental.
> >>>> So, I am not sure how much I can share without being fired :D. Anywa=
y,
> >>>> affected kernels have been released a while ago, so anyone can find =
it
> >>>> on its own.
> >>>> Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
> >>>> don't have data for any other XDP mode) in kernel-5.14 compared to
> >>>> previous builds.
> >>>>
> >>>>   From tests history, I can see (most likely) the same improvement
> >>>> on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
> >>>> (partially) fixed?
> >>>>
> >>>> For earlier 6.10. kernels we don't have data due to [3] (there is re=
gression on
> >>>> XDP_DROP as well, but I believe it's turbo-boost issue, as I mention=
ed
> >>>> in issue).
> >>>> So if you want to run tests on 6.10. please see [3].
> >>>>
> >>>> Summary XDP_DROP+mlx5@25G:
> >>>> kernel       pps
> >>>> <5.14        20.5M        baseline
> >>>>> =3D5.14      19M           [0]
> >>>> <6.4          19-20M      baseline for ELN kernels
> >>>>> =3D6.4        15M           [4 and 5] (mentioned by Toke)
> >>>
> >>> + @Dragos
> >>>
> >>> That's about when we added several changes to the RX datapath.
> >>> Most relevant are:
> >>> - Fully removing the in-driver RX page-cache.
> >>> - Refactoring to support XDP multi-buffer.
> >>>
> >>> We tested XDP performance before submission, I don't recall we notice=
d
> >>> such a degradation.
> >>
> >> Adding Carolina to post her analysis on this.
> >
> > Hey everyone,
> >
> > After investigating the issue, it seems the performance degradation is
> > linked to the commit "x86/bugs: Report Intel retbleed vulnerability"
> > (6ad0ad2bf8a67).
>
> Hmm, that commit is from June 2022, and according to Samuel's tests,
> this issue was introduced sometime between commits b6dad5178cea and
> 40f71e7cd3c6 (both of which are dated in June 2023). Besides, if it was
> a retbleed mitigation issue, that would affect other drivers as well,
> no? Our testing only shows this regression on mlx5, not on the intel
> drivers.
>
>
> >>> I'll check with Dragos as he probably has these reports.
> >>>
> >> We only noticed a 6% degradation for XDP_XDROP.
> >>
> >> https://lore.kernel.org/netdev/b6fcfa8b-c2b3-8a92-fb6e-0760d5f6f5ff@re=
dhat.com/T/
>
> That message mentions that "This will be handled in a different patch
> series by adding support for multi-packet per page." - did that ever go
> in?
>
> -Toke
>


