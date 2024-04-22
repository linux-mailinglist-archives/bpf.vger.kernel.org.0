Return-Path: <bpf+bounces-27481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9178AD63F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC3B1C20B24
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730F1C6B7;
	Mon, 22 Apr 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbzWU88C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAC18EB1
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819585; cv=none; b=jvNGswEIOETVncVur9PLq5aS2n3DZ3BshWDCpRuqqMD46C13uuKQaVV6Vxs9D6AwkRwWWrRVuZ28vJvRbiP1KcknUUEJSK1nLvJOBLIhGtPg0EUUyRkQgUzyS7OmeD2oq9tM6DicS8wktlLyrU+DAa53MDamduUKlTAgOct6gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819585; c=relaxed/simple;
	bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5jvn0pF4Em7F743T+H1TrY6+Ft3ywSqNm4kwtgBIIZvZ+m/O40Sfyqs13EJTQtmGLj9Hh7x/JVNq8AyJObYBCosie5nyZNdeCkwmLnqwhGSOpMqgzrT+9DVzHiJG8Sk6I03BzyVbYtEnqyyAPP54rCuT0MZjhM0z7BCAOFvVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbzWU88C; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so39381cf.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713819582; x=1714424382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=mbzWU88CFNzYso5y3z5u0Y7gx+04dJRwteJm/Hx7ACnQ/V62GydtY5pYvdxn0tJE9j
         J4dazF7HgDQ9euLkxTPEPc+vOF27vdPqiKmzaUnD4onpIlsXIXYOecG5km7ogSX3tjmw
         WXXfnqC6OIKl77hqQHI/Abf42JvRBemo0s9xSgpzrKxqx/kSUTPPJTZDrJ53gAiDKtCJ
         W/2mXwzO6zGIHiOnPAEoKLKAr1STrw46B0RXBM1HDkxwbIi2TRhpXSAXeEpWJi+b90+t
         pF9U6pGLKCCZcrGOOCtiiAU3mE0nyaV/JSh5dHzBchvBsvuUtrHQrpCSVx9Vn86A+mPe
         PVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819582; x=1714424382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=ng7qkusKf3iE1uFCQVRqbnSDR8r7ri04vYjiEMaZsxc+D8bwnXqYbAV/pk4vg9iuHB
         kxIFnyhC/xEo3EkSvcy8SXvJAhaafon2G3fe/8MAVRq6qUCF8LaFUe8uXuikOZWeKDkk
         0T7RcW9++tF74moCSsRIxvnrjJBigwna6rpGcIPz/k63/GfNOVzitVDE4ihlb1t9/1J/
         PcNpP3LpHgVgo50mXTFS0qJ41s6rO2AvAgv7gs0Ec5/AR/BS6e84D/l7VlQ9y/hbwc+b
         0haQ7tqnqjn/JmuATRcDsul+RO6QKkweAaXcs9/pwf9QH6CxoL4kj9kk6d3aToYDL9Cw
         jztA==
X-Forwarded-Encrypted: i=1; AJvYcCVNKUQ/KYq+YA4DIux5moqBllUc2qWv+rIpakfW1B5LniWTcSqyWIWJ1B3anwmBghhV+lGc2l8o8GzOTlXSd2A19yYN
X-Gm-Message-State: AOJu0YxUdiamjQa3hzOKCc1Y3dTWSmB5EmmWH6VZNnaorA3IGwvEB9aj
	WhJ3k171dLFNt+vWIL8ScVgI6IteJdTYaM0vgRWymaHKgOvgrmNouyL2jtMqHBEJfCzM6/efYzH
	XuY7HwpZXlDlMtF8O5xvJ/kVag7Jr1Pn66TEP
X-Google-Smtp-Source: AGHT+IFWv3vY24WCXnrPQ0IXbKt//pYLn/SVsr2ulzPtbd7T/FKDLeYs0qIX73iBiD1osziDXA7eh7+i5RjT8f9m8Qw=
X-Received: by 2002:ac8:748f:0:b0:437:6b79:c9ff with SMTP id
 v15-20020ac8748f000000b004376b79c9ffmr83042qtq.10.1713819581839; Mon, 22 Apr
 2024 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com> <ZhgvE7i9HGGar1eX@x1>
 <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com> <ZibOs-_ASLcZrnFa@x1>
In-Reply-To: <ZibOs-_ASLcZrnFa@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 13:59:27 -0700
Message-ID: <CAP-5=fXwkrPuWBTedUxjc=2GyDwPsTA75RAyN+nj4iHSFozRwg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 22, 2024 at 01:06:46PM -0700, Namhyung Kim wrote:
> > On Thu, Apr 11, 2024 at 11:42=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> > > > 12 more patches from:
> > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@googl=
e.com/
> > > > a near half year old adventure in trying to lower perf's dynamic
> > > > memory use. Bits like the memory overhead of opendir are on the
> > > > sidelines for now, too much fighting over how
> > > > distributions/C-libraries present getdents. These changes are more
> > > > good old fashioned replace an rb-tree with a sorted array and add
> > > > reference count tracking.
> > > >
> > > > The changes migrate dsos code, the collection of dso structs, more
> > > > into the dsos.c/dsos.h files. As with maps and threads, this is don=
e
> > > > so the internals can be changed - replacing a linked list (for fast
> > > > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > > > array. The complexity of operations remain roughly the same, althou=
gh
> > > > iterating an array is likely faster than iterating a linked list, t=
he
> > > > memory usage is at least reduce by half.
> > >
> > > Got the first 5 patches, would be nice if more people could review it=
,
> > > I'll try and get back to is soon.
> >
> > For the series:
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> It is not applying right now, I've just merged with torvalds/master and
> I'm running build tests now, will push to tmp.perf-tools-next right now.

Ok, do you want me to rebase on tmp.perf-tools-next?

Thanks,
Ian

> - Arnaldo

