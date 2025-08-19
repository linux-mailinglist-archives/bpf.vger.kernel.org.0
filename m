Return-Path: <bpf+bounces-65961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F65B2B766
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAD45800AC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAB2D2488;
	Tue, 19 Aug 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loHp7Fv8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E52C3271
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573031; cv=none; b=V1OYYH5YDVlzv4lDTcnhuTFPL7G3dEFvOBTZKzspWp5mDPPpXmGSOK8/SaJo1H7Vj+mU21tLdWTP1y/KtONk1bBHhfX/Wkchzj3KQ6S62Mc1XJ3L6CCwVt+stQrwDhVd2pCkfGbTjSapaAM+0PPO7IoExZU0L1sIlYn30s8chYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573031; c=relaxed/simple;
	bh=m5VCNL1/0YV/STjNRhh3aiUK6qfTPuuXF1dmujeztH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQBh6hAYUdlagpQFjIDk7lY3G8hRzdI14ou9zSXbk1BEYwgtNx7LFS8MIxRb94oKcweU5gqy/qI4galsX7g1wz43oQulIgmzLtUt1H6Rbd1TM5gRLg6iLAILd2d+bfAV3Hf28kcFOKA/HG0qLXP5o77V6HFByI3Hmgs8YDj8Efo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loHp7Fv8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a88ddb1a2so46852516d6.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755573028; x=1756177828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlF8oOFw6XxGZWbqs616E6b8Wbjg0aG0kr/OcFVHWbk=;
        b=loHp7Fv89AOXN9kbrvb5CGaadjlbMyI1Zrcv+oWevx7ry4okQCtJR6KOy3UsLbcpmr
         rt4Ym0SBXTgnhFubicNWP/2LXqVoU0RAz1Gpf0bC41NBd8CC84h53XTNYGP1AYq4yq8m
         GDqDJX0b8BBZKIZIdIT0hCqKvAxRtdPorfbVxMvIfsNUyD+WaFOcULtvRJl6FFjnNfJk
         4anz0n2unGRVdPraTIn5cHrmOQGBV+pAiLgCZzrWAhak5jKeNQxkbNGVR0GsdwmkAPV5
         aJTItkCEqpEptHxmgObYkdVpL180uljNKITfb7SQmSAHRsxVY22cyX03hBS2S74LNMi0
         2wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755573028; x=1756177828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlF8oOFw6XxGZWbqs616E6b8Wbjg0aG0kr/OcFVHWbk=;
        b=ZaOEvz2c4VVKaCT7UrgLkhMHiYp9QUZVPubMVHMtOEod6V/0m+dI35yVaqIxm7kCSD
         66YgPNJStUQxGrsGcFQQnRVhUiZpIcG4QlfOkljiwWj+ucA6RXNiySQfVTmyfa7eCm3L
         7BknYv8vJsfhG9TZmqpg0l2Cc9GgJKn86NrBwmlrQXJWjxPy0Ws94555HnGbDvlYKBH0
         O7Gzsd7tzZH0EscSIql0JlIzFyg/fWeN6SN3sm5VpoliHCBCQMWmi5/i7sT3WJoRtRbk
         tV8aPNKzgyKMrzYZg1QXKrnzHaLSPrBzu+PdmarAWUAWItXzMHyn4VoOxmgPA/YEXA1f
         sm2g==
X-Forwarded-Encrypted: i=1; AJvYcCU/l07zXskGQ9O11EV37XOsbSrgeE5uxUB/oFrlTcG+zygRNIFG/u1my1Od4eli3GVuZhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG72w+xMfR8SLO/5UdBWTSoSD7JtF44v/2pErTrYTxvyJQBO+
	8KqhRyu1JPs8pkBSw0Rp+dNLUW26f4Re8QT1dGKglUmQO32ky0Kmky7NgCpAqz1TRHIvLGe3MsA
	NKF0EUlS+nNEP41zDPd/GACenIB/C86M=
X-Gm-Gg: ASbGncuDdWWPqzDLmWcwyZZs5ka82LFOQSL8yfLCVUM/KWmewEHVsBKwhWYha8LsOP+
	N/N3zvRxH1ws69EdjBlmiXV4mtrhPgJxvOLbkvj5nSBDyNcq8bexlwWJiS5aQ71Gv0rr3+9mGps
	EnZWXndn3h8AodJFd7heORPxYh3s7zQ8hpqdYu0S0uRdsboNL7tTgH1jgcB4unRmAWwAKrHdygw
	JqxmRAbyHCQ5pr3qbs=
X-Google-Smtp-Source: AGHT+IEjssY9TNgGBYwnGqAIFrlBD7U7+PHQXDd3di0Id42cdDzL0pUiM51hDPDptU10GrTwCxGXlg0VYTykSF0vkHQ=
X-Received: by 2002:ad4:5def:0:b0:704:85af:1973 with SMTP id
 6a1803df08f44-70c7f5589femr8632396d6.12.1755573028438; Mon, 18 Aug 2025
 20:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818055510.968-1-laoar.shao@gmail.com> <20250818055510.968-6-laoar.shao@gmail.com>
 <8e1ed2ae-bc2b-4ffc-81cd-61ad6878ad0d@gmail.com>
In-Reply-To: <8e1ed2ae-bc2b-4ffc-81cd-61ad6878ad0d@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 11:09:51 +0800
X-Gm-Features: Ac12FXzRz22-_pmy1O8cYb4B3Gq0gNgmyf9HCpPLwxhFVkyv90Hkfo4odtuh_e4
Message-ID: <CALOAHbCnBBOC_YVGNEEdYrLOBhAqOddA8WKDU88p8uZQStqSbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 mm-new 5/5] selftest/bpf: add selftest for BPF
 based THP order seletection
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:00=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 18/08/2025 06:55, Yafang Shao wrote:
> > This self-test verifies that PMD-mapped THP allocation is restricted in
> > page faults for tasks within a specific cgroup, while still permitting
> > THP allocation via khugepaged.
> >
> > Since THP allocation depends on various factors (e.g., system memory
> > pressure), using the actual allocated THP size for validation is
> > unreliable. Instead, we check the return value of get_suggested_order()=
,
> > which indicates whether the system intends to allocate a THP, regardles=
s of
> > whether the allocation ultimately succeeds.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   3 +
> >  .../selftests/bpf/prog_tests/thp_adjust.c     | 224 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_thp_adjust.c     |  76 ++++++
> >  .../bpf/progs/test_thp_adjust_failure.c       |  25 ++
> >  4 files changed, 328 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_f=
ailure.c
> >
>
> I think would be good to add selftests to make sure the bpf programs are =
working
> after fork/exec as intended.

Good suggestion. I will add a self test for it.

--=20
Regards
Yafang

