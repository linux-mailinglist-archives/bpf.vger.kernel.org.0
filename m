Return-Path: <bpf+bounces-65081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12701B1B8CB
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E018A66AA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89449292B4B;
	Tue,  5 Aug 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnPgiMYX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D1207A0B
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412598; cv=none; b=WvgzrJc9gghgiSJCQUrYOrxrokEOBYHKI8vrhGXVtHfjhzdk9mcAoISk9sFI1oJHt6oQy0pCQ5AOwRcsPNRYPcUkaqPJW67CzkFCtsOh7mqleOwJykg7iYfzYLGMrJ0v11bUB7ridH2dbSLQJ0DmSzqaY3rSIWgCQqTyZdFQRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412598; c=relaxed/simple;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrqjLZTTzGRjb3P5ilkauDxwweWmv0mZftMBEXHZArflLzfKIU3nwn0RGcdn6BwBO5+kuUnONLCCcauQsejplg+CDhmdfHTVSiwUufVmjp98ElQXYGkO1g937K13l1ciGifPmxCPj+Mxqw1bLkQ1boyInNnRXaIuaekVQ3ODveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnPgiMYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754412595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	b=GnPgiMYXqspWqdZ0rDy5VM2hJQVR23jFxKVgxiplHEkFeYWmsObra+mchNajB2gghWUsIg
	h1FYg21jNAB2Qj7opQd4IUlbLdJTaDe9lEfW+LRlE4dZ3s52AtXg+ShAdJwGub7CGMKFo6
	Xk6XFEGlhYA6gRf/xwQaQE3B2WlVS2g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-OdKsdKXcPqyoxZF1jpac2A-1; Tue, 05 Aug 2025 12:49:53 -0400
X-MC-Unique: OdKsdKXcPqyoxZF1jpac2A-1
X-Mimecast-MFC-AGG-ID: OdKsdKXcPqyoxZF1jpac2A_1754412593
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3c6b8c85dso34882585ab.1
        for <bpf@vger.kernel.org>; Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412593; x=1755017393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
        b=B6ZMb8CXi6YusTXm8WMhG6WlQxUJ40RUxJmPK1C3Es3nlsFo+8xPbkn4dJIA9uut1h
         4qIa2jdmYaRF4CSf2iwE3o6gzb7Se1iGwDWGuipSDI/sr7tuK0wuqi6eAxPvfbAYGziE
         vWj6jNO02+Zd/3QvKab6MfKDj3X+85JYVH7ZXgYuwXfmozmcUe7qBubxXL0SxNW2qwi8
         Hr5K6N9YM1C3FqMCp+6gIBnTFb9G1WPXbor5QaM5liJHLqkfhVifFkrLNdpxYXtO10Z/
         xU46YeMncRvQC5C24G8SQV5DfPfydE4BnqC9tr7iTykk030sJjrIfi/mSW9aWxTW95XW
         4tYA==
X-Forwarded-Encrypted: i=1; AJvYcCX+k3QRkQNhlFjgWrzaXUsLsMwEJ3rGWLZ9tJ/XO04s/R5TjsEHmkztJBrDWQfi+68xofk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3q9KjWHbY9lKkSCOodfXPwx8G7xMc6JbgtV0GBUizjBDPdWG
	UX5VW2Tj9x0ldcDT7nZPlqoUfyZBNdqb2ppCedJV9ex7XhhRL5pkv62xy5v0e3D/6Mq/7IgDPML
	a1dBuzg/wM48SecoT2z9JpzkYH6JAikKhqqhWgU+0wYQo2qv1ALrjBg==
X-Gm-Gg: ASbGnctre16ebDAQ0mht/8VELYuVyz5Aa7FZAN1NiRFti3LLBd1P1ej+6xL/IxnxPtZ
	JIqwF/Unn1rgiFthxpF6iH6SEKcAr7UKQCe7DoivFHLzvm9kWpnkTgsC8pwPOhGjU4FGHR+RG3+
	L+waZQIibfZf3y61UcV4kd84XV2W/gJvCb+jENDDf9HpCAFpYGQh9N9cWJp5osN3KSfbE+IMbgK
	f0+a3n2wfT45KFcMdzsJCR7ZitXCsdonlx5zfo+VUex0E1zxt0WiOR1S0gy/4A04jqXQIfe6B/4
	up3ps6SYqcKiMkmcu8PHKWdbfCjKeH/tBe0F0WQuZx0Ye380jRsEWjY8sPcUgAkF5WQTs+c=
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293423225ab.7.1754412593017;
        Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPZOoL5lfzhmEQ9P7S/kqjcyKFzOgHwdkMcJAPTqhlbXfksERnKXCLEw+tCLYbmu/SFyNjw==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293422335ab.7.1754412592444;
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55d5da1csm4057918173.65.2025.08.05.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Message-ID: <540bd149b88a543e306762fbf00c366a4f9670ce.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan
 Carpenter <dan.carpenter@linaro.org>,  Jan Stancek <jstancek@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 05 Aug 2025 11:49:50 -0500
In-Reply-To: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
	 <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
	 <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 10:03 +0300, Costa Shulyupin wrote:
> On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> > If you want, I could rebase that on this and use container_of() to for =
tool-
> > specific params... but then that adds complexity with the top and hist-
> > specific params, most of which are common between timerlat and osnoise
> > (and not merged by this patch).
> I=E2=80=99d appreciate it if you could rebase your patchset on top of thi=
s one.

OK.

> This patch is just the first; I=E2=80=99ve intentionally kept it minimal =
to
> ease integration.
> My goal is to refactor rtla and submit a series of follow-up patches
> to reduce code duplication.

I have consolidation patches that are just about ready to submit; I'll
try to get them polished and pushed soon.

> So we might want to just keep it simple with one big struct.
> This is a god object anti-pattern.

I know, but I was trying to weigh that against pragmatism and churn
reduction, at least for an initial refactoring -- particularly given
that my motivation was to make it easier to make a timerlat-specific
feature work on osnoise as well.

-Crystal


