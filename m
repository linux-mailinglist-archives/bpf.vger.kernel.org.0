Return-Path: <bpf+bounces-77912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CACCF673D
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C40313CB5C
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F32C21EB;
	Tue,  6 Jan 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP0wzhJk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C923958A
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665760; cv=none; b=aTCQP5IGceUI5AeX9iHsHrkEX8UDfCGy1uXKlWq4n2QcYg8zmzIVPoYnUeQqW963Yx8sQL5TF32cvIewhjy07t3+1N28rzQBMQam4jXdxeof7aGUXXn3xny/3sJug89Czj2Lo1Et3WWnveH0LzrjtDd/GZdOBc+Jsll/RhmN66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665760; c=relaxed/simple;
	bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaK7EN7zpRZB6iXcBlxlQi65C5UgoLwpqeyhPBrPStsKjcHloLjaRauridILe3IWInKBVzo+zX8GNtgCKf9XW374oPex8/wU0+FlBs6uvQWOudBDauVOPZICVMnvhOHU6KAMSTB6PL79PhKxib35njtQ5N7ml+9bw7FSz3bW+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP0wzhJk; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640d4f2f13dso455879d50.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767665758; x=1768270558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
        b=TP0wzhJk0fOc613zkTf1C+Azm0ZkWKTc/8N3Xdu4eH4hZzZwr+vCSTfHqtWhdsmaD/
         bKzbeuaP72mGOz0nn5dQJfHqwiIXW/cTfALehvGEdAxqslJvKD8EH2A5uCM164OCGVNV
         CXCPoVzk5MMNhAx+5hPKYkv3rLE417MnBCz9A46Kfd8UNW0iuXHX/5Eb7S4iFn6cqQzZ
         5sQ03KsKa+SE2zGElvm1KFITwcYOvveNw53kKBSXklnfgsz4W4EvDQleXgywaTxOCzq4
         oKOOAU83QsDDSQ4nBy+TCiTHQj/2BLI6rgpW6j++/UZLSO6Pef90rq6YSfO5yBmU9VN8
         z9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665758; x=1768270558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
        b=mCI5Eme2uSovrvlIa4QODYlFXNeQs0x4brajR13gRJxCaMCrxZ+F1UZmlvvZriIi7R
         i89qKrGlLZeKd4tVaWWim1dSJrY20B3T2i20PGUll+qWvLG+VZNiZ9Y3FaI5mkal2Q/N
         F0xYAARGp+MZNGXXt6A+K115UQJCsxdkZXsaqKiLz38NQykKBFk/RJ8+yjML1Xl+G/3U
         TR684WPt1Lwz/FxEQtMngt6RqlbERkvsRNheVq+/AlYtm5dshpYmlJi79mSmq1hNVLeu
         MezuFgyGEOPJabfCAxHIb1267TGLeduQB3AP3q9JYxi7YRhCcnx6wix2YdIJtPOd81Sy
         7+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWqSsh4zg/V9ih+ZCmC7u/dytwYj3GGRivBJ/XMySxOnlHDeBYniM2dG/uhGh4KbV6w6zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGTOK4vQbcT7DW3w5A3o0kgThK2YAwVnZTsiejz2Odhn6keWL
	sWhbVRM+b98U7N3rMekjwQeDZAdIIM8QTDkIEpb89hxCn89HeDa6ERNICjYCruGN6XwY75Z4aml
	uakiy7OFq0+Bd+UzQPnDlYsycZJsqLwg=
X-Gm-Gg: AY/fxX4Kco5/LJgSFr5N2LJEOWFlai1b29YROEuVrx50cEpLvLLT3TFqND6FSaMwn5D
	8vGoBWE0Cdiwl34afA+ixIVj0YEkByRLxXSQCt7xPKqUS6oPJei3peEMVNEGBIBdoEyokK4nA6U
	rsLaKl/OiSUCmOrL7+x4cfa6kP35HPTG79lQL7GvlAp9pjV0/Bc40jDe/7ZMEGb7hXFREf77M0C
	JBjqJFDAYAUNaWcnHX3ctgyw5V/o+62hnaVXxj0/M97RlT5aPbtPqYMqbwgfWpaBLWVmUMxuwlZ
	TCTct7df
X-Google-Smtp-Source: AGHT+IEuoYm+bzvqZhk4qg/A4XrmfEhgVpnTZ0+iG9FOGEwqDlWTCZKfH2wbr1nFvQ4jU0oborf9p5hfIyPDSKcCa1s=
X-Received: by 2002:a05:690e:188f:b0:644:6f3c:11f3 with SMTP id
 956f58d0204a3-6470c85f217mr1377138d50.27.1767665757810; Mon, 05 Jan 2026
 18:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231184711.12163-1-sun.jian.kdev@gmail.com> <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
In-Reply-To: <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 6 Jan 2026 10:16:01 +0800
X-Gm-Features: AQt7F2pZTZFApaEXJLIPVtPv0XKDWKU5mlw01GM4QZNDB9Ur-GVrYMXHYBhMmoA
Message-ID: <CABFUUZHY-T0O9k2SQJOh8+JnJcc2PDJFxz7PAa_q0VVMbiNATg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix qdisc kfunc declarations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 5:34=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> Stop this spam.
> You keep ignoring earlier feedback.

Sorry. I misdiagnosed a local build/setup issue as a kernel bug. I=E2=80=99=
ll
stop sending patches and fix my setup first.

Thanks,
Sun

