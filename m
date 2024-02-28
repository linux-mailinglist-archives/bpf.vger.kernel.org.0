Return-Path: <bpf+bounces-22847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5C86A8E7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949361C22EB9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E224A1C;
	Wed, 28 Feb 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZYrrHdo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593D23749
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105062; cv=none; b=iWTPvpgRygziKTQbeF0XIV13NBBbpfw1um4/eAzQqjYsRAZakrL8quEkz8iPR6ffaZHdBpMHlAqKfYBz3syjAdTSgFl4db+j8R1l4TS97fdMnFJfLT6E2Ia+riV7wlHYrSBUK1R884KZp7g7UJIZBWiwg6ndptzIZEI/uveCp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105062; c=relaxed/simple;
	bh=J3BiMHmFAZRHHxjaye1fO3ickIhjsdiGhoo6deKUkG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOj24Oqh5jtGI/Nht8/+o3BeTBf4dkqSrov/YImFAvbxSIO2Gt9/dptEg+GmUIPoQFcCrT8cu+pOQL2PO8jjI5H+RL5DdGYSsMx8r3G22Si4Hk3oNxHTxybLngY9eGfdFJan8xWAAqYg22QwyauNvkTQZWBF20PZzfG4LrxRa/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZYrrHdo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3653e1240e3so98255ab.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709105060; x=1709709860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHnvaXANsC8wB5A9Pi5iZo7i69i6rzWp1vJRqsOF55o=;
        b=DZYrrHdozaK4bx3oRMsJGBZaj4ZVy8K72pUsBh8GV2oT+GN7XR/L+wKoGDAungc5iX
         Jkse0b3bsooq+6pdDkuLNQxe26+fHoVSATFlOBsp0EkC2ufY8iysQo8Vj+GBzeXgsjbR
         gdISeCY86roTbIa7WM/4MJzlaIJ01VynjlxZGARL+omgQCuwm9alWa5dr7K5BsKMq8n1
         kq0R++e/uemSuaKyc8GGDCtnag2IVf9fORaL9NDdUpzTuYOT81K93fO0Xg/E7SRDc65y
         sEz+Zkq9Y7dYPfsgB6odwjTAdwffvpjoUFFZdeiKdGxiP1yORo8zbKc3Au83Fx6LAC8o
         tOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105060; x=1709709860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHnvaXANsC8wB5A9Pi5iZo7i69i6rzWp1vJRqsOF55o=;
        b=Zm53Ux3AOPmoFEO7JAe4T77NBcNUqizb1koBDKZMnn+zgyCXC193oqNVCW6yuC0YAj
         FsKuh5+4vOF194AUsM+a+R680gWQh+xRTArrlm8ORpurHLpsfS9gtcqfvi6qLD9afzjC
         +8Lu7LefOxuyw0fLdVmnIZ3CEVure/zJRHSMTIgA/n8x3/kCx6sDG2yPhYJmmgjxYoz+
         oxmMPbx/1VCpv11Kw2B7qKRTxgVtUEDXEQHvJlbJXBNmnQirqAy4t5psK3jGhXFYg1sR
         IlTNi8BeL6CEMtb51Q1ZKPMnqragyVQe8Yff3OBohSw8Y9OBK5FHymxRooGFm2IuXb2m
         O00w==
X-Forwarded-Encrypted: i=1; AJvYcCVP7rtUX1e5KLiwtcpu7eWZuljaHV9PAyXDIOXAoZXS1uxd+ZvvlXMx0Oxx4WGDJbLR4kAFEXMAdZOlUbgUtclQWpsU
X-Gm-Message-State: AOJu0YwGTwp67C8KobhnXSJIoYgkJcB+tTxOXcIcwGc+1lB9+1O158GK
	s/hwSyFw0gdZQpkyFaYZMDC2GWJUtNmw6UIiTYsR5/hBPpWNc1242KSvHlMgYUAlh3U8ujdCZSy
	gHjsE0ca5Z2bR7SYfm8sbuHbGEV+8aGEg23u4
X-Google-Smtp-Source: AGHT+IHkLDbLWAgusw2nK94xGjYsaUw7+RGfP0DkNFb5aCzX98qVfoDFTra6SUiapVaXaZsf9lCDoJmc1+/jVZTtfXM=
X-Received: by 2002:a92:2902:0:b0:363:c7c0:49bc with SMTP id
 l2-20020a922902000000b00363c7c049bcmr14863ilg.27.1709105059805; Tue, 27 Feb
 2024 23:24:19 -0800 (PST)
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
In-Reply-To: <CAM9d7cjJTf_yed9nwXZkBPr6u6NH5n+V+u0m6Zgsc1JBy_LdyA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 23:24:05 -0800
Message-ID: <CAP-5=fWKdp7rf+v7t_T_0tU0OxQO9R2g+ZH7Ag7HgyBbGT3-nQ@mail.gmail.com>
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

On Tue, Feb 27, 2024 at 10:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Feb 27, 2024 at 1:42=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> > > > I can see some other differences like machine__findnew_thread()
> > > > which I think is due to the locking change.  Maybe we can fix the
> > > > problem before moving the code and let the code move simple.
> > >
> > > I was going to suggest that, agreed.
> > >
> > > We may start doing a refactoring, then find a bug, at that point we
> > > first fix the problem them go back to refactoring.
> >
> > Sure I do this all the time. Your typical complaint on the v+1 patch
> > set is to move the bug fixes to the front of the changes. On the v+2
> > patch set the bug fixes get applied but not the rest of the patch
> > series, etc.
> >
> > Here we are refactoring code for an rb-tree implementation of threads
> > and worrying about its correctness. There's no indication it's not
> > correct, it is largely copy and paste, there is also good evidence in
> > the locking disciple it is more correct. The next patch deletes that
> > implementation, replacing it with a hash table. Were I not trying to
> > break things apart I could squash those 2 patches together, but I've
> > tried to do the right thing. Now we're trying to micro correct, break
> > apart, etc. a state that gets deleted. A reviewer could equally
> > criticise this being 2 changes rather than 1, and the cognitive load
> > of having to look at code that gets deleted. At some point it is a
> > judgement call, and I think this patch is actually the right size. I
> > think what is missing here is some motivation in the commit message to
> > the findnew refactoring and so I'll add that.
>
> I'm not against your approach and actually appreciate your effort
> to split rb-tree refactoring and hash table introduction.  What I'm
> asking is just to separate out the code moving.  I think you can do
> whatever you want in the current file.  Once you have the final code
> you can move it to its own file exactly the same.  When I look at this
> commit, say a few years later, I won't expect a commit that says
> moving something to a new file has other changes.

The problem is that the code in machine treats the threads lock as if
it is a lock in machine. So there is __machine__findnew_thread which
implies the thread lock is held. This change is making threads its own
separate concept/collection and the lock belongs with that collection.
Most of the implementation of threads__findnew matches
__machine__findnew_thread, so we may be able to engineer a smaller
line diff by moving "__machine__findnew_thread" code into threads.c,
then renaming it to build the collection, etc. We could also build the
threads collection inside of machine and then in a separate change
move it to threads.[ch].  In the commit history this seems muddier
than just splitting out threads as a collection. Also, some of the API
design choices are motivated more by the hash table implementation of
the next patch than trying to have a good rbtree abstracted collection
of threads. Essentially it'd be engineering a collection of threads
but only with a view to delete it in the next patch. I don't think it
would be for the best and the commit history for deleted code is
unlikely to be looked upon.

Thanks,
Ian

> Thanks,
> Namhyung

