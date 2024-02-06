Return-Path: <bpf+bounces-21264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354084AC0F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 03:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17AA1F2463A
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 02:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048556B64;
	Tue,  6 Feb 2024 02:13:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A456B65;
	Tue,  6 Feb 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185584; cv=none; b=KnGYZItBA4Xqpbfs80y0fktIZa5oytCnHkCAOoR3rNIQ4WkW6uLyYVssKjzVOWc+wl+NSRczg6MgBwulwSITOgO1epXoYOOlHQZZNC486zJTFtfaANiURQYJ8NMt3GF/tEdmAXBCaSfhvNvc4CYWTBXkTD4QK82vVNlWTjPTKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185584; c=relaxed/simple;
	bh=bs/ur/xiB+EKXQSIm4/pErFIuws9bv1BgqZoNxClTT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krhpB/feyL2G/BtRsCjVVs5QQ795vAwJkD0/Uos9Yywn5FSIthQzdLinMcSW7faa0Sc6ZSXSMeuRmivsDj5VHxs6+ciMdDNWpRxnmIHRvrEeuHI+nf9AUNOPKlaHrp8uks25cwWpgNK6BuL8Rj7qQA3P4AR+dW/n6bTW+t0XSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4476655a12.1;
        Mon, 05 Feb 2024 18:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185582; x=1707790382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTAyl5iKOFA0ikqjI1lmw6AmuPGoKHG8xJSD/r8dg+4=;
        b=lB45QgIWh0gsXfWvptPQgjq4wPGoEgC7nR3PgTO1BK45Scx2nRr5EK787Zk/ZeE2fl
         UwBnLgK4Ilq8eO0gUoTLRSsVb75TpDg5Q1DpX5yd76EBeq2ALKNBRlCeuxQXC7DrYlgt
         PPDwIH3UunHlpaZnHSIoBYJviZrUGkoaImxq1zEoT51i3xkLjkG5wVaq8mU/SDcju85Z
         AL1Xh4iKJa6Q9cENPi1qND6q6Dx+CbvkdfiaZwrjBD+Na054iSPe8IMNQbgXsq7hok3C
         /jL1RDKExNfWY88Cydfk0reNZelVcEX9PIQh0tyZmnSfunhTOOPyAcSKQ5MMPo2FFNxY
         F+Pg==
X-Gm-Message-State: AOJu0YyT11PiQYbwT+d92h2sdubCPa+j/TJtV0ego4e2VvD12TBdSO7B
	jgDGDGqMiOIPlbuV1UAtqwD94N2YJgjS6xnVnZFfdXycBrckQEw76tDes9TwegESEnWVne71/z1
	JKQf6He0wuzwpwU8MCzGVh9QpayY=
X-Google-Smtp-Source: AGHT+IGDb6iQTUWs9BOothXuSb/aiVn8KF27r5Fivt/1qfUFGuDtcyXcnRyNdG1Al1jAcC5DU7YBRZMcb1n1Vm4pF9s=
X-Received: by 2002:a05:6a20:1ea5:b0:19c:53e4:e67f with SMTP id
 dl37-20020a056a201ea500b0019c53e4e67fmr280535pzb.15.1707185581779; Mon, 05
 Feb 2024 18:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f15f0df1-92be-4bc9-82a2-1d8fa3275dd7@web.de> <daf2172a-8d54-4097-acf3-cc539fe281e5@web.de>
In-Reply-To: <daf2172a-8d54-4097-acf3-cc539fe281e5@web.de>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 18:12:50 -0800
Message-ID: <CAM9d7ciHGv9s92Yz4VuFUhuN9HCHe=Bq7dMD_XSBTkg1+tYw+w@mail.gmail.com>
Subject: Re: [RFC] perf: Reconsider an error code selection in bpf_map__fprintf()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Christy Lee <christylee@fb.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin KaFai Lau <kafai@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	YueHaibing <yuehaibing@huawei.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 1, 2024 at 10:49=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > A null pointer check is performed for the input parameter =E2=80=9Cmap=
=E2=80=9D.
> > It looks suspicious that the function =E2=80=9CPTR_ERR=E2=80=9D is appl=
ied then for
> > a corresponding return statement.
>
> Are contributions also by YueHaibing still waiting on further development=
 considerations?
>
> [PATCH -next] perf: Fix pass 0 to PTR_ERR
> https://lore.kernel.org/lkml/20220611040719.8160-1-yuehaibing@huawei.com/
> https://lkml.org/lkml/2022/6/11/3

I think we dropped the bpf-loader and it seems bpf_map.[ch] is
leftover.  I don't see any users of bpf_map__fprintf() in the tree.
Maybe we can drop it too.

Thanks,
Namhyung

