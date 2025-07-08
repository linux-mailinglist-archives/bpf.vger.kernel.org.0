Return-Path: <bpf+bounces-62600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A2AFBFF9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF571AA595D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0921A443;
	Tue,  8 Jul 2025 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLMVbUv8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE91D7995;
	Tue,  8 Jul 2025 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938022; cv=none; b=LXwEs4pUUyZc6huk1p41qmMKD+Ql9JnKAMSD6w/efsWTKoK1zLHBJiN5xmJ9tLguv/tXLbw9mcAw+uThDCw8R3vC1DgQ18ZmZEzSX3hi0Rt6JV1qS9F/+WYC0fOhP3nRelyCpJNrAgs+W9kMa2FYi0sMLrQgV5WqT3NHxaZ4v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938022; c=relaxed/simple;
	bh=ZnHGHq5ave43TgeRkggMe4AbYvBY/2cd3kmyH5EdkC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+sdBUe7qcG0AcGesfMm9HljrfqjfoKHXfWQQ6UZ6bcQP2xsD6n6Tr/65Mo+2nV4MM5wUEGGlm7k4LZQckf3XLnR29M0XCP5FMeNvAtr3LJhyxetszrXztWL2DRpH3LaUAlCWdpvbGYD7WaB7BMLAdwJ2zPhRU3qourcFvHfOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLMVbUv8; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e740a09eae0so3807931276.1;
        Mon, 07 Jul 2025 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751938020; x=1752542820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnHGHq5ave43TgeRkggMe4AbYvBY/2cd3kmyH5EdkC8=;
        b=CLMVbUv8R3ULGr7gR/4ei0aKM1+o72pJr2A9j3pX4t/6lEh1j+ZQsfaLGAFRBN5KTa
         B4YBT/Y9f4yVgpZDyH8BGFSl5g68ThSsbfXjNnfcdgwhf/yLaSq6uZei/qWejK1U/q/3
         /Z8HIdWfETYijbc9IH3lB9OQ0YoY0F23gmwwcSYrpWHN2fcNq8317hdeU9ApzFJJgVqe
         04sXb5sB67AWpvf8sndSueIGRk9PCvcLZT1Vkfm2IIvJcQBPSQlXWftctGEOlJg+8zt1
         XJhzZLRT5cXpODK9hcoKJsIEvSAAafkksTrNYEDCea2c/vuPCLdGsPn+kqQ9nhgeULXs
         5nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938020; x=1752542820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnHGHq5ave43TgeRkggMe4AbYvBY/2cd3kmyH5EdkC8=;
        b=rpEFDWjzZKXZzxEGm3jH8Qu7epwcsA0DLdgCKIK9vr0AQxSK5ahj8c8Q+eGaYmvffI
         UfVWgaP/ETuy+moRW4N7sK4z5aJPKH/gzMrvOFwjUK+i1mrtGcRFXwVzOK5KY3F3HSvE
         j0Sd+xlawaNercEtFuigqwJEyPKCi6oomIppTsmMM/6sDUVWY46JfJxTsS7TK5wUVrq8
         qvdqaTIZ1vKgKPQm7Janwd8Sy5woYBQdx5q4qnZfyr8ybWSxsKEG6P1nQMheQGgoHy8J
         8xKdBSotw5lZ4kbI5DFe9ivnvdHALnp3LvMG1241NfEkbNY2AXNwjgXArtW6NNbuPAbN
         Kh7w==
X-Forwarded-Encrypted: i=1; AJvYcCUUIP013vqbm8LHBATyf09P+j0VsQ5C4SiRG0FkqqT9FQKLvaUGn99+vLjEDmH2mtPfIgfzu1ayPSCte09hN4v7xQ9g@vger.kernel.org, AJvYcCW6qAKiXFQVUyfcEdDnfim97uraetPdHJ89iOAIbboJG88dNT1fK/FxAdnl5BlttAfEsM9AfRqJQaiLbHaF@vger.kernel.org, AJvYcCWyQaGklmOkBIFIB1SLTpMtYFDkWrWy4tM2/iailpWyGyFLVZFaG1mH2WY+6x7H1JDN2DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4zPt2drBbD6UtVFJoDkfPXmL4flM29+SklKACAQPQycyHle5
	syIwGDKb+PRiQMu6+c8ej/rQxhlVHEnfsQeR7j1TiH0DYK0aVZUv4WUTTBZMr0EHQTQe36dSYte
	gmw7tEUI6jEX/TDF5hC4YGaRhf90TfAM=
X-Gm-Gg: ASbGncvLUTq+lHassNzbXbVrlMv+jqDixw6lCEeQYvRhdNYoLzdAgtmtvccXUNfYd9J
	dTEbUO8ALkNMhFXmzAvgxuZ3K0qfkhuHdnWz10vMArli8fbXtZQ2AQa8MVaowg7jMuy8dmCv+EI
	ZMOqEUVyInQRZHUdvdmkNwlgPKFlItyr0gSOaXB1OcNFTZRklYNzzKRg==
X-Google-Smtp-Source: AGHT+IFY3wzNKtaQguVQTil0Ca0KoFK2QmqIvuR6rvTE8CWKkzS5VL5K+RKdQ0zY8E9vc+8cWyhrzRqT7zSvMqyEW2Q=
X-Received: by 2002:a05:690c:62c6:b0:711:406f:7735 with SMTP id
 00721157ae682-717a0354ae5mr11951817b3.13.1751938019542; Mon, 07 Jul 2025
 18:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-5-dongml2@chinatelecom.cn> <20250703113001.099dc88f@batman.local.home>
 <CADxym3YaHGxQ7AORGka1CV+KpnPOknohP9a6zi=3RSPXYBKC-g@mail.gmail.com> <20250707145228.43c669f6@batman.local.home>
In-Reply-To: <20250707145228.43c669f6@batman.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 8 Jul 2025 09:26:01 +0800
X-Gm-Features: Ac12FXxOsvbZBNxpMFhzNmdcFK_HeDMzARKZQ8DIwrtX4f31LAL7qIMZmKAh3aM
Message-ID: <CADxym3YKAW=xt6vGfHLH+tdZCp6iV5va+WkCiS97cokSpuOXiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/18] ftrace: add reset_ftrace_direct_ips
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 4 Jul 2025 09:54:52 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > > What exactly do you mean by "reset"?
> >
> > It means to reset the filter hash of the ftrace_ops to ips. In
> > the origin logic, the filter hash of a direct ftrace_ops will not
> > be changed. However, in the tracing-multi case, there are
> > multi functions in the filter hash and can change. This function
> > is used to change the filter hash of a direct ftrace_ops.
>
> The above still doesn't make sense to me.
>
> Can you explain more what exactly you are doing at a higher level? To
> me "reset" means to set back to what it originally was (which usually
> is zero or nothing).

Yeah, with pleasure. When we need to update the functions to filter
for a ftrace_ops, we can use ftrace_set_filter_ips(), which is able to
add, remove and reset the functions to filter.

However, we don't have a function to do similar things for a direct
ftrace_ops. What reset_ftrace_direct_ips() do is the same as
ftrace_set_filter_ips() when the "reset" argument of it is 1, and that's
why I call it "reset". Or we can name it something else, such as "update"?

The use case is for the global trampoline. BPF global trampoline has
a direct ftrace_ops. When we attach new tracing-multi progs to the
new kernel functions, we need to add these functions to the ftrace_ops
of the bpf global trampoline.

The "reset_ftrace_direct_ips" can do both adding and removing things
for the direct ftrace_ops. We will get all the functions for the global
trampoline, and "reset" the functions to filter of the ftrace_ops to them.

Hoping I expressed it clearly :/

Thanks!
Menglong Dong



>
> -- Steve

