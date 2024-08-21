Return-Path: <bpf+bounces-37739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173E695A30F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84EE282B1E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DF2199FA9;
	Wed, 21 Aug 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUgAtvKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E913BAFA;
	Wed, 21 Aug 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258503; cv=none; b=HUFhApnePal+UpCJ53TRV2g2fihsajXPj8KGKeQzzQFpniRz7JEswSCwo2osSFd5M61/CqaTzYGtj4/GClbkSHmJPo6MWBh0UeGoWyf67YWWBHozHlH/ksBo8U/nXvqnu3/7DafkqP5xNU1t8yxeDWnldNC/OxIgEUyPTOwCVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258503; c=relaxed/simple;
	bh=nB6cf0hGAnV1nonJ98lxvd3qYEbep8dtOAOkjNAHOIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S47XlW4zZ9jla9fGYEahHDU99jZHE1jjEO+UCRmRiy2pyucat9ykKQGpoovrYOuPlLP0eng5UEstFjBJBmg4UR/7a9ZEev+YKS4vq/e8EnE8mNBUw0GHmCrNoNtc1vkl7P70dtoD2MxVmUeLyVTPPR5o/8MGUtFTONnR7aVuBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUgAtvKW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so4893835a91.0;
        Wed, 21 Aug 2024 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258501; x=1724863301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB6cf0hGAnV1nonJ98lxvd3qYEbep8dtOAOkjNAHOIY=;
        b=NUgAtvKWkX+NWXXqYAv1tiEA//12oLcFse9x4wZVWH4BbCSccvRZkF2K48eVcxcOsP
         JfT4w0yGqumiqKaeChdTDqvIK6hI/MG76eOvZyjP4kFm2KTcp4qAIg0acdkm1IeSAnWc
         Uj9QN1rM3xA5lZ+Z2Egs66VPAx2bXQnqEpj5jncvb6nSsiECjeI6Bf5i1TGA0wbKHHj8
         rfzGxCPuyl0d8Yv1s/D1A6V0GrRANpxx66m73X9gOi0fBot6zAQE+OWny2PBNkOZJOHq
         1sHdMZh1E3FWkcPeffOCjAjlo9YPQO2y4ae0ev2bfU8G1UAiV6TB8o96sxbO46YbG62B
         3eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258501; x=1724863301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB6cf0hGAnV1nonJ98lxvd3qYEbep8dtOAOkjNAHOIY=;
        b=blkp2Zw8CIX6bwlqY5nt7TDEmQTBSZ5nZQwiibPZirDNvYZz/NiM0h0bodWjuJBZ70
         1V1jxq7oOptV9LsihFG1611JZX3EJVTKOq8D3Cw8rc+pOhkm6vQpTeEgNGB/2GAqZdaE
         A4uGDdIq3REk9w8Et55sOYqOHrmvA84TmAfLy7++eI4UGwnTE0VHrIYqc4PDsxbvBgrS
         w3ZUK6UIe+lDGLZ0T1VFMbVkTtiesxCHkB4x9SXq1hpIsF9TRog+gPP8v1IBMH82SRfq
         nLI76aOiHq2KCGTRxg5FSfdL16/vORWA+40gI76WxITAs98elqdvOjl1U1YcqCalKxlP
         B1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUMwBbrsamSqJ/l6MB7M8LfVxxz6/5YGJyZ6Ave1kDXASw/QQ4z4sxwLQ49IzI6O46d1ojoMDF4/kBGbUkT+PvsBrvU@vger.kernel.org, AJvYcCVeZTsaD3Ltl2x957gh2dnCbn36GVbIdhBvnu9kuABxVRgv1yDfCnZHwIssR6s31IYgg78=@vger.kernel.org, AJvYcCX8DRWb0kd3F1GZBXbCF/5Nlgj6CrOUVDZ0miIHegOtBah1Dzr2G2oVAIGoK8Mrvvzriu0YWAoEn0wPvQ00@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyP9CE1lNEq3Yi3muM6mImP/2aj8/oWQdaWhtO3s1UA8VdOYg
	C1XVzHBXtrH/alJRaofYCzi9VaZEtiQ5aNyY587kWyVpcusDcb3rKDr1vrOK8JQg3Ti+wtzurBU
	zWLKHULDpXD+1J8ADDsqpN5+SA0U=
X-Google-Smtp-Source: AGHT+IEPusi6jNpTG5+GVt8xUA89NnFS0GpruNg/MdRii+4OtwWQWsbT86fkw/qpEFVb5KY0WAb5onVWWBLO10Ag5ek=
X-Received: by 2002:a17:90b:8cf:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d5e99cb32bmr3118652a91.5.1724258501110; Wed, 21 Aug 2024
 09:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240815132447.GA15970@redhat.com>
 <CAEf4BzaL4v-tvD9pzcNdnA29SOZbaezjKRRr=ba7_7B=tNBhdg@mail.gmail.com>
In-Reply-To: <CAEf4BzaL4v-tvD9pzcNdnA29SOZbaezjKRRr=ba7_7B=tNBhdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 09:41:29 -0700
Message-ID: <CAEf4Bzb4YzQ00n9BdJF6VUOPkAj6NG0P5cPcT38ZbMX8HUnFsA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] uprobes: RCU-protected hot path optimizations
To: peterz@infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 15, 2024 at 6:25=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 08/12, Andrii Nakryiko wrote:
> > >
> > > ( In addition to previously posted first 8 patches, I'm sending 5 mor=
e as an
> > > RFC for people to get the general gist of where this work heading and=
 what
> > > uprobe performance is now achievable. I think first 8 patches are rea=
dy to be
> > > applied and I'd appreciate early feedback on the remaining 5 ones.
> >
> > I didn't read the "RFC" patches yet, will try to do on weekend.
> >
> > As for 1-8, I failed to find any problem:
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >
>
> Great, thanks a lot for all the thorough reviews you've provided (and
> hopefully will keep providing ;).
>
> Peter, if you don't see any problems with first 8 patches, could you
> please apply them to tip/perf/core some time soon, so that subsequent
> work (SRCU+timeout and, separately, lockless VMA->inode->uprobe
> lookup) can be split into independent pieces and reviewed/landed
> separately? Thanks!

If there are no concerns about the first 8 patches (and Oleg doesn't
have any), it would be nice to apply them. The remaining two sets of
changes are parallelizable in terms of discussion and landing them
independently, so it would help to move the uprobe optimizations works
along nicely. Thank you!

