Return-Path: <bpf+bounces-27469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018548AD599
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F3A1C20FC3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2215535D;
	Mon, 22 Apr 2024 20:07:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDA155388;
	Mon, 22 Apr 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816420; cv=none; b=udLl8RoBfSdITNkoiBSCSbhZsrsQ1pYl+F+iGsyGW30sxo25jNUvX0rYx4TMRaSJgrKHtIY4gd1G0X+H1CKCkGr3492WWQMGED5qTfUw33gLsnUvYEVxco+IY0/+ZWNPxeZiOqsV1bgFiWQKu96OedPw2Xw0nk+HK6Pz+ATG+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816420; c=relaxed/simple;
	bh=hJlEQvTvAW0uIRb0nxity/RgFXzSN13AzJrAIZ0mBQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6QDbhOkGzFNCzygm9wdSU0XCrsJThRC9Ia4Amkzu/C/hWLEd9/Aa6CLHEMVq9dNoR+6PErQ6TIiXnFCYjuzK0/+bo8VgQ+UxVjvDK271Zdc7+ZE2cQe5jT3gSEDEDAOI7qVJcpd4pqRNPHEDhsF/f+3TMWG5KfN8EBiKj63UKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so3147763a91.3;
        Mon, 22 Apr 2024 13:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816418; x=1714421218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJlEQvTvAW0uIRb0nxity/RgFXzSN13AzJrAIZ0mBQY=;
        b=jHHZfXxgzB23KzBL3KtygP+cTbFq8QVVKixR7n2eJvP9LreuqRlouCB22HtrDsJS4l
         WM8k/Mz2aRdz8WkDlSpo00ZtYNClU9c5F9+f0VhzKis590ZIUINVFzEXAUoSU1Pebgq1
         ASmwC2uBiECrk+FqKC8xPjEa37CXH1bAi5255tAQTDFnINP84DEj81EuMFFfiwoIcGPv
         +PP09upSqGclZMuJEOeMPwfVimVABOfjAaP1aMhsvzn6n0teyMeNhm4g6nGx2NkLwz5N
         IcyEfFRf1t9fxivBje3vPSW7r950wYBvfVQ1zMBRucsSAunGsZPYektgMP+9iuWa7yx+
         v9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYESW7tjaQyhJFuXZJRWp4hplmoTXAm16oYcF7H3PrnOprC+iGHpjV7edK/ajL84w4QVJ8FyRXQyG7Zvw3yqLpRsiHGB35hSq/QIHp2ttZLoie4S2hSUMBW0J5dqtHim32DXFsJAvYLvvc2gPJRCGqXi1y3dooTDAj9+4qzYq9U5NOcA==
X-Gm-Message-State: AOJu0Yw9aRd3yUjKaTm5F2FrLkFjQmylqwZ86bhQGrja8q6esLPRQy5y
	wXrsZN+r3COi/jVhSCiyEFboTiyT9wba1Fj811MarRsAclZpq0L8J/sGeVFAjUjnY64sH9vfuzI
	lAqpQtMsjAHRLmQpizsQB7F9uIbo=
X-Google-Smtp-Source: AGHT+IGaQxrqNUASyy5HfR0taKP1caDQBU0kXcttCZhLnz7UnGFyliyYwrffcEpx5FSLl0ydQJ5q47Fz9yt8aiBGIwA=
X-Received: by 2002:a17:90b:1e09:b0:2ad:dcad:b45f with SMTP id
 pg9-20020a17090b1e0900b002addcadb45fmr4054047pjb.13.1713816418179; Mon, 22
 Apr 2024 13:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com> <ZhgvE7i9HGGar1eX@x1>
In-Reply-To: <ZhgvE7i9HGGar1eX@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 13:06:46 -0700
Message-ID: <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
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

On Thu, Apr 11, 2024 at 11:42=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> > 12 more patches from:
> > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.co=
m/
> > a near half year old adventure in trying to lower perf's dynamic
> > memory use. Bits like the memory overhead of opendir are on the
> > sidelines for now, too much fighting over how
> > distributions/C-libraries present getdents. These changes are more
> > good old fashioned replace an rb-tree with a sorted array and add
> > reference count tracking.
> >
> > The changes migrate dsos code, the collection of dso structs, more
> > into the dsos.c/dsos.h files. As with maps and threads, this is done
> > so the internals can be changed - replacing a linked list (for fast
> > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > array. The complexity of operations remain roughly the same, although
> > iterating an array is likely faster than iterating a linked list, the
> > memory usage is at least reduce by half.
>
> Got the first 5 patches, would be nice if more people could review it,
> I'll try and get back to is soon.

For the series:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

