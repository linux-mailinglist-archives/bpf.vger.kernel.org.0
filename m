Return-Path: <bpf+bounces-22031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980F8554F2
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 22:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5981F27213
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15813F007;
	Wed, 14 Feb 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zZUZLQkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9F13DBA7
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946620; cv=none; b=WwI3JGUUUlqIThXIpX0+W3NtW1yiEJGvgFg9s7J/Hy8KOzyAksg8/NgexAaVG2D4NhlhqPYLWTQ81TJ/PSkhbW1odHYvLXIM/KOXorgo5y637GwF6OYMaSv2Yc1/s7TGEuq8M4V3ynLYo57j0lWvs1zWK2EoYhB62vVWVt1JRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946620; c=relaxed/simple;
	bh=8NTIdvfdUShCf6KiTT4xVJr3A6EVG7UAZSouPXwWvFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMahB8y1IzfFT4LtpZlgDhGtkmZNhby+4+tNBDX0VtEcP/Qk1jpI9MtyX9EuGSKO0ELYICPGQVBw4esuyCzXNhPMRwN+xxLzP7qqHKvm0M/SyPNxRl+Bh+fydYwXspWOdTgFQEixSBiBz/eHd+qeDEepmZdLNR5cGDkFZxi+FNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zZUZLQkh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1db61f7ebcbso11085ad.0
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946618; x=1708551418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm+3lAjNKCUXMK2MWRX3aA9k1EZES8aqndD5uWRzKz4=;
        b=zZUZLQkhf/CogbGFIeK5zRCFwghXNPXzycZM/MtAFgXa2PlMR9+LHRRjTejEL82o66
         1/CDPdgLTmdv5u+cpLtgUWKmFSIvGUYm2r1PxSmRTMmDIuBQq3G94PHMGpsITbCs1x48
         YMg1/EDTJ3Xd2zJSevQ6zG1byffgP2NXyiOadttSROhU+dVeqBS1vj4nE1lDr/A2T8bE
         GNwpGCtwesf6t4pENX0FH6QGoW2hGYmsJgcYltE2/VpsjWolzEKrC+5CHa4UnjOKEVSV
         MutFRk1jW68cx4gfnTZQAAmEUxVpqihr5uuzUSGROC1ttOqnO/IAHgfNebtmgsAE3aNW
         ZKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946618; x=1708551418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm+3lAjNKCUXMK2MWRX3aA9k1EZES8aqndD5uWRzKz4=;
        b=jo+j+s8DX78y4jqrOsmuLnBRuQ3lxYJSVoGnH1xuSv0nusOM/ocr4XfZHT6OmRn3Hg
         Ef+2WJrI4gv3YgjX1trBEsImcKCz0a/r2BWZzq0jKYLbOD4NscbaIRib+hhMmDjlhLJ1
         DKWLRzCsQo5cvi1QQXKnzl9ZgKju5p06/lpDanl5eg+94jO6n0+yU0erOBbjXkRmv5AR
         HjWevfX1rf3/+IJtWAEiQM86meraAGZWunfkIU1Lh7A15dsGVXZYoptufJ7+P7vAG773
         /BbcdXsYorG6Ynbrf7NqNvvmpz2v2T0bFuiqVJyvrSHKVCSR3+DFS7ye38kT/Z+st+B3
         gxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTIbg4jqoPbYQpmEfogR78jWpJ75VoJDo4c5IpIS4NcRk/px38zNehsdRyXa2Y0YqD51OiFPGlLD+GC5Eo/CDBhxdu
X-Gm-Message-State: AOJu0YwemRuTzfI+0NT394dMgdweee6b1VCpN46DYYkDBrXyB7EuGUDF
	vODgzCBx6CYFqba2RCfCL4wq/TFI0oAhivSRj37eCRIFdtjyllRjy+R+WuivEsApe7ZUQROFSo5
	FQzOSWfCNH7xfUA7+FFQPeCIyET0hSCWKWm5W
X-Google-Smtp-Source: AGHT+IEGLkc+Vg1BB8RNbFLPcn9sA2EgZUBHfDxP0H0iDn+vMm3xC36CC6KY+0zBUA64/i36/KFEaMcOA8knBoDpJss=
X-Received: by 2002:a17:903:2053:b0:1da:292b:cf94 with SMTP id
 q19-20020a170903205300b001da292bcf94mr397991pla.4.1707946617972; Wed, 14 Feb
 2024 13:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1> <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
 <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 13:36:46 -0800
Message-ID: <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > threads") made the iteration of thread tids unordered. The perf tra=
ce
> > > > --summary output sorts and prints each hash bucket, rather than all
> > > > threads globally. Change this behavior by turn all threads into a
> > > > list, sort the list by number of trace events then by tids, finally
> > > > print the list. This also allows the rbtree in threads to be not
> > > > accessed outside of machine.
> > >
> > > Can you please provide a refresh of the output that is changed by you=
r patch?
> >
> > Hmm.. looks like perf trace record has broken and doesn't produce
> > output in newer perfs. It works on 6.5 and so a bisect is necessary.
>
> Bisect result:
> ```
> 9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
> commit 9925495d96efc14d885ba66c5696f664fe0e663c
> Author: Ian Rogers <irogers@google.com>
> Date:   Thu Sep 14 14:19:45 2023 -0700
>
>    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> ...
> https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
> ```
>
> Now to do the bisect with BUILD_BPF_SKEL=3D1 on each make.

This looks better (how could I be at fault :-) ):
```
1836480429d173c01664a633b61e525b13d41a2a is the first bad commit
commit 1836480429d173c01664a633b61e525b13d41a2a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Aug 16 13:53:26 2023 -0300

   perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter
using &=3D sizeof(saddr)
...
   Cc: Adrian Hunter <adrian.hunter@intel.com>
   Cc: Ian Rogers <irogers@google.com>
   Cc: Jiri Olsa <jolsa@kernel.org>
   Cc: Namhyung Kim <namhyung@kernel.org>
   Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
```
No LKML link.

Thanks,
Ian

