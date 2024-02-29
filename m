Return-Path: <bpf+bounces-22976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A21886BCD9
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52D0B221A2
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1BA23;
	Thu, 29 Feb 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xw4YBchw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B61102
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166711; cv=none; b=WLh447X9/IdZE2tjlE8Mm/B5XCUlXVzYVOZRcTBaYEDj459nW0/z0elF/pnoiS+lLm4ft9JoThvqCUE/bO0v2DKWYRD4Vl5eWPnwZnHwGPKc+S8L6fq3icpUQnmrswXn78Ee1o1kNpL88u9YqP/Ale330V+TkJJiDel14LBR/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166711; c=relaxed/simple;
	bh=Qs9gzZdD6kIR4+pjbjQ1x7dn/jESOCEv1sBJEvFeoeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq+wv8UlMsNHx6c87iW69gPkF7VewAA+VeOlpYi3iLGztKd9wI/OUrp4LSbCPNLBdvJb5YrT/lp8pEQ2DUX5K7g4RpLGNV42xb6NsTTBG37Et4cImLO3FI19ahohXvxaVKGN2XotqfVDWDp7PnypQ6tMoab20arLAC6yZaWP7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xw4YBchw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc744f54d0so92255ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709166709; x=1709771509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWAW1LP6E25hygXHWcS7ZVejXqpVXuIN70MzR/qe/Fo=;
        b=xw4YBchwxKuv/z61dGLLVq2Nmh6zumRE2ZtGEHE/64fA4Yqh84pu5alvzgQQHqAIpc
         nc3dN64rh498HMyadMkiiWpItPmFPKJFhDXQ0nyl6cSN9TrXNJOVk9HRWRxptybgjo7S
         NRyys5PxCYBkPff1v3ZU3scSWzzonsMyX7tHRvmMniL4fGyebTIusY3sAJpAr1tbU+zY
         3U+fNU4PyxTL2HMjkRR0ygSF9V4HE0Rk9iBJqKOkcOWDMFAGi2K16D0brsK/dklMM2G+
         gJeTgrMDgEpNLO0rm2TaAex8BfdtWmN3NKLlYiuadRJk4rW32ojziZzl5tU1LQbGKqna
         h+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166709; x=1709771509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWAW1LP6E25hygXHWcS7ZVejXqpVXuIN70MzR/qe/Fo=;
        b=t0DmF4p3I9e/LaSG4El+2FigjLO2qXQ/uPfGiOl2ApuIfsEMOI8d+d20W8vmfwCqBR
         C3qX8lBwrFi0atbQ3VRfCG++RJac9q5qT30gQLs7UAfDXAzb6iq3ixp9Q2WTzhiH0onz
         x3Fx9t7PO9kT5zkUxKF3YEQVR+B1jtxF8GeZiK2TuYiSoFAAbla2/2PKJcBT0ridrTsO
         6xAflIMDJPS3pzKCu6YbEWoTVbreY3gcQl+Ta7KKyIxCLElhKdRzM0izNpGNl1PRjUXB
         tnpaEOEgz1cNyklO5++wyV9SsVzbH6CfVRYa8HccouHc5A+Z1wm3uwVtC63kgDJksYYP
         d5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVEJHxhliTxUEsTNbq3b8W3PXOwUpvfLw1jroTuwwAhFBj3iuca7Ieqdizopm8ymfOG8QXlLhtLhir/oh5Z6cHPllCm
X-Gm-Message-State: AOJu0YxaiRdcT4hF0r03AHh+09jkfQqyAQDU6Wd2pSs+tYRCue12Gu5Y
	DkJ3uPVaob2Wf1yw4FOTOk82VIdu7hsxD73tY5nMJ6Nzf5aJ28ekbMupYrzofLV4ENGBTf3uhCx
	5JCz6kNo/SPzIfUya+6+PUJTiv/TpmchKFbyU
X-Google-Smtp-Source: AGHT+IFsm09XMMy3/eHazsWO9AJ89KR2h/Hcnu5odXTcjlP0n5Av8J51HesIMPUDaMAfe2UCw9ccRqZtFsv1GxPz3wE=
X-Received: by 2002:a17:903:244b:b0:1db:e78f:4ce9 with SMTP id
 l11-20020a170903244b00b001dbe78f4ce9mr50558pls.24.1709166708693; Wed, 28 Feb
 2024 16:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
 <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
 <Zd41Nltnoen0cPYX@x1> <CAP-5=fWv25WgY82ZY3V1erUvCb+jdhLd_d91p4akjqFgynvAgg@mail.gmail.com>
 <CAM9d7cjJTf_yed9nwXZkBPr6u6NH5n+V+u0m6Zgsc1JBy_LdyA@mail.gmail.com>
 <CAP-5=fWKdp7rf+v7t_T_0tU0OxQO9R2g+ZH7Ag7HgyBbGT3-nQ@mail.gmail.com> <CAM9d7cj-kxaQc18QG_cd6EzsDbk7vmhYqg-XzCV+g5oi9Giwww@mail.gmail.com>
In-Reply-To: <CAM9d7cj-kxaQc18QG_cd6EzsDbk7vmhYqg-XzCV+g5oi9Giwww@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Feb 2024 16:31:34 -0800
Message-ID: <CAP-5=fUHbjC60L0GwFWaM15LZLDsC-pWwyWZNjE3B67zvpKGmQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Feb 27, 2024 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Feb 27, 2024 at 10:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 1:42=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> > > > > > I can see some other differences like machine__findnew_thread()
> > > > > > which I think is due to the locking change.  Maybe we can fix t=
he
> > > > > > problem before moving the code and let the code move simple.
> > > > >
> > > > > I was going to suggest that, agreed.
> > > > >
> > > > > We may start doing a refactoring, then find a bug, at that point =
we
> > > > > first fix the problem them go back to refactoring.
> > > >
> > > > Sure I do this all the time. Your typical complaint on the v+1 patc=
h
> > > > set is to move the bug fixes to the front of the changes. On the v+=
2
> > > > patch set the bug fixes get applied but not the rest of the patch
> > > > series, etc.
> > > >
> > > > Here we are refactoring code for an rb-tree implementation of threa=
ds
> > > > and worrying about its correctness. There's no indication it's not
> > > > correct, it is largely copy and paste, there is also good evidence =
in
> > > > the locking disciple it is more correct. The next patch deletes tha=
t
> > > > implementation, replacing it with a hash table. Were I not trying t=
o
> > > > break things apart I could squash those 2 patches together, but I'v=
e
> > > > tried to do the right thing. Now we're trying to micro correct, bre=
ak
> > > > apart, etc. a state that gets deleted. A reviewer could equally
> > > > criticise this being 2 changes rather than 1, and the cognitive loa=
d
> > > > of having to look at code that gets deleted. At some point it is a
> > > > judgement call, and I think this patch is actually the right size. =
I
> > > > think what is missing here is some motivation in the commit message=
 to
> > > > the findnew refactoring and so I'll add that.
> > >
> > > I'm not against your approach and actually appreciate your effort
> > > to split rb-tree refactoring and hash table introduction.  What I'm
> > > asking is just to separate out the code moving.  I think you can do
> > > whatever you want in the current file.  Once you have the final code
> > > you can move it to its own file exactly the same.  When I look at thi=
s
> > > commit, say a few years later, I won't expect a commit that says
> > > moving something to a new file has other changes.
> >
> > The problem is that the code in machine treats the threads lock as if
> > it is a lock in machine. So there is __machine__findnew_thread which
> > implies the thread lock is held. This change is making threads its own
> > separate concept/collection and the lock belongs with that collection.
> > Most of the implementation of threads__findnew matches
> > __machine__findnew_thread, so we may be able to engineer a smaller
> > line diff by moving "__machine__findnew_thread" code into threads.c,
> > then renaming it to build the collection, etc. We could also build the
> > threads collection inside of machine and then in a separate change
> > move it to threads.[ch].  In the commit history this seems muddier
> > than just splitting out threads as a collection. Also, some of the API
> > design choices are motivated more by the hash table implementation of
> > the next patch than trying to have a good rbtree abstracted collection
> > of threads. Essentially it'd be engineering a collection of threads
> > but only with a view to delete it in the next patch. I don't think it
> > would be for the best and the commit history for deleted code is
> > unlikely to be looked upon.
>
> I think the conversation is repeating. :)  Why not do this?
>
> 1. refactor threads code in machine.c and fix the locking
> 2. move threads code to its own file
> 3. use hash table in threads

Step 3 is patch 5 in this series. I can split this patch into steps 1
and 2 as you say in v3. I'm not sure why step 2 is going to be of any
use as the code will match that of step 1, code that the next patch
then deletes. Anyway, it's a plan for v3.

Thanks,
Ian

> Thanks,
> Namhyung

