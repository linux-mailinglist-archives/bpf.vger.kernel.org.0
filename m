Return-Path: <bpf+bounces-58636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B86ABEA86
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 05:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934DD1B61001
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685522F746;
	Wed, 21 May 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN3WaTEq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0722F3A8
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799610; cv=none; b=ggWz1YIkaIMHh44rneP4xB/OzROXe3PbghkHCjPXMMloMliHRFkWjMqbnrT9LHUKUz+4KeEoy8wLN1MQ3GRwAApfgzS1ageD2la94zuwfdZ3TqtbUq55cIkHRdlf4CnUSbUwXC4n2v9Gk3umkEDay7wAmLJ8doiinvMbBpLJq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799610; c=relaxed/simple;
	bh=uoDEMrNtNl3uiTS1SuiY9P3+mVnaJbzCqQ63YQEBwVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJBPB6lwr+ApG2HFbY9C+/kEnQCaGz7+ssWMPa593jSn+5+wXayzt9+iFB6m/ApidR0hJnfX9egYgBC3XdEO8GCILtuc3ZvC9XGbPKWEY8kbjWx5r3WA/bYrFawLapOggnUnaKqI6z6E/4S+a5/sHzZo/f1h9givk6t/sjELeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN3WaTEq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8d4375aa5so22089666d6.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747799608; x=1748404408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoDEMrNtNl3uiTS1SuiY9P3+mVnaJbzCqQ63YQEBwVM=;
        b=GN3WaTEqvdV2PZ8zIU3mcfKdH4bwr2vTxf39jKoovEqbeaewZQZHHKfagYy8PWtE9o
         qY9ltFCxSHojVFR0H8HDa454aTEOMd9zgTe7h5YML49fJ9YsD7VDhYcprQswB7zFUXbi
         rLEJD9NEOTqZeht5ApTpGMClUuyXAXTSU7SQxFDmRBrAv1dbQIa2erRPgu7M+MxBD+KD
         DsIQjObZQ8IJ2iXOTIqWzOH/quPIotLLPvK9MJlwMBEburQU6LANfNHs15PMEM1BK/wS
         gL1tF7sKrY7gVjyXiLuc78nRyteuDfRSOG0AVL9CKPgXv/80hh5Vyjmc7MrvxVqJS4oo
         6MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747799608; x=1748404408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoDEMrNtNl3uiTS1SuiY9P3+mVnaJbzCqQ63YQEBwVM=;
        b=llBy9IS/A9guqpDH2doKrue054ZCdbUZDj+jsYhdqY1qioLxUrlXcWEZ1SpW0rwYQY
         EjJ7yvdoRESyFW+IRWCyq49VCE1VJAwTyaYMmWU3mYmw4X/AWzTXrrOYWmTHm7iGKRjF
         Y0OJcFiaG7uMZ1rRiGUl4l6lc77hc82aWPdcTm+pnR7pBOJiYKVPutxZ4Mofn2wIctSE
         HQll5sUL8Y7SYhN1VkcHu6E/OaIoCSsRUdLFOrTCAgAVOmOAMYM3yW29GIKsGtbxSU0j
         shPY4s5+WJEKs09BdYT5JujVa/qFGQ+lWBjqwR6wNcBKC1AB+XeMZN7VgF+t7CtP2Az5
         vJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVfzxlgwZDgV1jnn7in0YPEJiBN/uWWfFCEUyMn7TjNp4YNlsn5UQEcspSVaj2yYbVTZg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvnvpoLk1tpVwCy6CnNvJ44ow89r7gN523tJLsWO9wBtgP4Nr
	ny1FPFaVGBef8Nm1s1B2yokulA/FxFVn0MaeNnKQjR9AcywJVYwwO7b6dLXCuz62L/wvpiXJ/3l
	UcWBlAJCX9BPlvytas/OblgiXbqofI/0=
X-Gm-Gg: ASbGncvfEXd0wALzBNWDO+QobfdbPDzj2gzve74M1VMv3S/h3YJlnXRPhYzNobF+6h4
	DBSPD/q4G0jSyss1rwz0s1MLdWjagzDubQ51SPipBsFZGTJ0JQuCl95tZ9J8aTBR1iGeN7BgGIP
	YzQoOJnQXPgJTuUBoCW0IG61L/6p6Xn65dFQ==
X-Google-Smtp-Source: AGHT+IFcQlxq0eUE8N8L1qHNgjaGjhBVw5YFAczWuK8oG9DqiErGcQ/iSHjYgzACN2Xb04quJyUiQ7jCrQ/jgv7zepk=
X-Received: by 2002:ad4:4ee4:0:b0:6f8:a825:adea with SMTP id
 6a1803df08f44-6f8b088bd2fmr357041056d6.15.1747799607817; Tue, 20 May 2025
 20:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
 <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local> <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
 <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local>
In-Reply-To: <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 May 2025 11:52:51 +0800
X-Gm-Features: AX0GCFsQiqwqPYpFbmkGryZtx4RlrFVoaExvt1HQ3km2SfRmfgGlGLfR69VDGME
Message-ID: <CALOAHbCFTSKr4yvGKhjK9tA0peBNusFpJ=NoT4tnCzEe2p-oEw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 9:45=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, May 20, 2025 at 08:06:21PM +0800, Yafang Shao wrote:
> > On Tue, May 20, 2025 at 5:49=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, May 20, 2025 at 11:43:11AM +0200, David Hildenbrand wrote:
> > > > > Conclusion
> > > > > ----------
> > > > >
> > > > > Introducing a new "bpf" mode for BPF-based per-task THP adjustmen=
ts is the
> > > > > most effective solution for our requirements. This approach repre=
sents a
> > > > > small but meaningful step toward making THP truly usable=E2=80=94=
and manageable=E2=80=94in
> > > > > production environments.
> > > > A new "bpf" mode sounds way too special.
> > > >
> > > > We currently have:
> > > >
> > > > never -> never
> > > > madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
> > > > always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE
> > > >
> > > > Whatever new mode we add, it should honor PR_SET_THP_DISABLE +
> > > > MADV_NOHUGEPAGE.
> > > >
> > > > So, if we want another way to enable things, it would live between =
"never"
> > > > and "madvise".
> > > >
> > > > I'm wondering how we could make that generic: likely we want this n=
ew
> > > > mechanism to *not* be triggerable by the process itself (madvise).
> > > >
> > > > I am not convinced bpf is the answer here ...
> > >
> > > Agreed.
> > >
> > > I am also very concerned with us inserting BPF bits here - are we not=
 then
> > > ensuring that we cannot in any way move towards a future where we
> > > 'automagically' determine what to do?
> > >
> > > I don't know what is claimed about BPF, but it strikes me that we're
> > > establishing a permanent uABI (uAPI?) if we do that and essentially
> > > promising that THP will continue to operate in a fashion similar to h=
ow it
> > > does now.
> > >
> > > While BPF is a wonderful technology, I thik we have to be very very c=
areful
> > > about inserting it in places that consist of -implementation details-=
 that
> > > we in mm already are planning to move away from.
> > >
> > > It's one thing adding BPF in the oomk (simple interface, unlikely to
> > > change, doesn't really constrain us) or the scheduler (again the hook=
s are
> > > by nature reasonably stable), it's quite another sticking it in the h=
eart
> > > of a part of mm that is undergoing _constant_ change, partly as evide=
nced
> > > by the sheer number of series related to THP that are currently on-li=
st.
> > >
> > > So while BPF may be the best solution for your needs _right now_, we =
need
> > > be concerned with how things affect the kernel in the future.
> > >
> > > I think we really do have to tread very carefully here.
> >
> > I totally agree with you that the key point here is how to define the
> > API. As I replied to David, I believe we have two fundamental
> > principles to adjust the THP policies:
> > 1. Selective Benefit: Some tasks benefit from THP, while others do not.
> > 2. Conditional Safety: THP allocation is safe under certain conditions
> > but not others.
> >
> > Therefore, I believe we can define these APIs based on the established
> > principles - everything else constitutes implementation details, even
> > if core MM internals need to change.
>
> But if we're looking to make the concept of THP go away, we really need t=
o
> go further than this.
>
> The second we have 'bpf program that figures out whether THP should be
> used' we are permanently tied to the idea of THP on/off being a thing.
>
> I mean any future stuff that makes THP more automagic will probably invol=
ve
> having new modes for the legacy THP
> /sys/kernel/mm/transparent_hugepage/enabled and
> /sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled
>
> But if people are super reliant on this stuff it's potentially really
> limiting.
>
> I think you said in another post here that you were toying with the notio=
n
> of exposing somehow the madvise() interface and having that be the 'stabl=
e
> API' of sorts?

Yes, I have a BPF program that hooks into madvise() to selectively
enforce THP policies=E2=80=94allowing it for certain tasks while blocking i=
t
for others. However, this violates the semantic guarantee of
madvise(). For instance, if a user sees THP configured in madvise
mode, they=E2=80=99d expect madvise() to reliably enable it. But with this =
BPF
logic, such calls might silently fail, creating inconsistency. This is
why we propose introducing a dedicated BPF-controlled mode, or
alternatively extending the semantics of the existing "never" mode.

--=20
Regards
Yafang

