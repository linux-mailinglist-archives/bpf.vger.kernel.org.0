Return-Path: <bpf+bounces-30860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0738D3D5B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0942836DB
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790291A0B13;
	Wed, 29 May 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2OadvfJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681A13DB9F;
	Wed, 29 May 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003406; cv=none; b=dIZcSufo/V8NVIemfc1cwFixKSWiYUUG5LKjZJ0gpnm5ngFwIerwj5UC5+yUPyJs03GrCyqaE1pYa4acVtAObaIgqNBfnXRApYhgthWEpkH0JEcUFLF33RMA//+hBQCD6KiQfM4SdnAXq4HXAq132RMBo9+1AotKZmLQeQsJibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003406; c=relaxed/simple;
	bh=18fR52IAgMh259ZAMQQuaorP+DAd2ZN9ZaPUdgLSpPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaF8rs9cZb3DpV9ovbtHxWrCHeU6Zba26GtSQ1Un6q5jUMSzjAYFoNgHrkY97SPPWbE1U3a7pMQEzRLF8NEeuPU8cVfVliGjR3pK6spMEgcxjCAjCTdHWO3ZJHDsX+CVs3FxWgbuLZmwlZ03LTDn3YqvgkSaqkFrubjva4bV7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2OadvfJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so2038889f8f.3;
        Wed, 29 May 2024 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717003403; x=1717608203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oTlJu6nFvobrmRIU2tbUcCs8hZRqj/c25H324zaAeU=;
        b=V2OadvfJCFcyYMxlz1eGDUKoL/Mn3eAKXzgnBwrJHtajSjMrv1JKmL+cI4i1LE1eRs
         e1xzK/ykcr4jhwjUUpuTf30XLl5qsTDBfe7gryyxtJolGfR8pX1SikPJXv631BZ6DtDm
         KGZh9Qs/Fx9HsVQnUJc6gt9N53tGTS+N+V2LaJFHyl4ESIBdnKQ/XkIBWZaZUwUgpsoZ
         ps82CqkBwSx2+3ZvulsdwwPWMudHaQTYEOZuUQzl64CzyIIegQDVUHSu5+HMubNwQo+b
         vBRYniAqZY2hKGNAsgLDUsu+hYebo/9TT5cxtSQkJtCXGrDHC+EhzSs8MsqALjtAeINM
         4guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003403; x=1717608203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oTlJu6nFvobrmRIU2tbUcCs8hZRqj/c25H324zaAeU=;
        b=vChhCvO6UuxoeYzJsZSiQNKQsAJGf9hCaC/oIeBTXAyZ86okL8rVmhtX4Wbvq+UCdY
         DaoJtntEwitYfY7bIVZXxD/IURc4VMxV4b5zgTUTlvMYXxwelvPt08P1xbR1fv8tsWgO
         pO86oMoI5Ha/zWH1U2GUd2kPLYBHQFgPeCFuJ9zbX1Z//jhHPO1LzPufy3Q4vph37fAw
         ObzYrf1UgVKsxpCMM8eWEAvo3Isydg7gt7az52NRfa9urYcqJxL05GtoB/vRUvZgWWdc
         s/Coi4phCWC6+AOteLmhkq+boXRfQlhYxzkQKMxl1fYsLTqVMsf6KYirrRBmn4vwj9Jy
         +DtA==
X-Forwarded-Encrypted: i=1; AJvYcCWcaJ/BAyALl8qxAblak3BNtD8khXtU367VqqTxfNFcHpbnKfRVl5MDx7lkHIpcIk2wKAqTEDqxKyISmaoszCrQ2vI14hEaIgEOyBTr9FzM3B899qlfYZziOQQGFfV7kGyR
X-Gm-Message-State: AOJu0YzGSFk8nN0vu50wB6lo5Hjpl0lq4hAXBR8CwSuqNaiOk/qddm4k
	yFC1hX/jeyUBMxcfsn0m7FpP+vGcGF5Er9CcKp8ZveGNN3Rq9YAtExpPDNG0U1Iikt3Dl0Kj8uH
	QdzSQtbvw5g0mnGwU1yWPl70io0S2rw==
X-Google-Smtp-Source: AGHT+IGpW3zz43rA4mJN32yG/mGPPz6Xbo2I0jI9HaXGLdQA/pEkhjf2SNyyGfCB0NB/wOtg8hevfpqijFim0ZGYt6c=
X-Received: by 2002:adf:fa82:0:b0:354:df9f:1010 with SMTP id
 ffacd0b85a97d-35529d31074mr10209426f8f.24.1717003402564; Wed, 29 May 2024
 10:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529065311.1218230-1-namhyung@kernel.org> <Zlbn3DOGrzHlw95h@krava>
 <CAM9d7ci0g+ObA7w-tXU9cyjzRUFgXjZ4b9Atx2+oV4Anhraeyg@mail.gmail.com>
In-Reply-To: <CAM9d7ci0g+ObA7w-tXU9cyjzRUFgXjZ4b9Atx2+oV4Anhraeyg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 10:23:10 -0700
Message-ID: <CAADnVQ+qqx8=WjpMjZyqzCb+02zpw9=wVAwWfyHL_O4Xpadukw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Allocate bpf_event_entry with node info
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Aleksei Shchekotikhin <alekseis@google.com>, Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Jiri,
>
> On Wed, May 29, 2024 at 1:31=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, May 28, 2024 at 11:53:11PM -0700, Namhyung Kim wrote:
> > > It was reported that accessing perf_event map entry caused pretty hig=
h
> > > LLC misses in get_map_perf_counter().  As reading perf_event is allow=
ed
> > > for the local CPU only, I think we can use the target CPU of the even=
t
> > > as hint for the allocation like in perf_event_alloc() so that the eve=
nt
> > > and the entry can be in the same node at least.
> >
> > looks good, is there any profile to prove the gain?
>
> No, at this point.  I'm not sure if it'd help LLC hit ratio but
> I think it should improve the memory latency.

I have the same concern as Jiri.
Without numbers this is just a code churn.
Does this patch really make a difference?
Without numbers maintainers would have to believe the "just trust me" part.
So..
pw-bot: cr

