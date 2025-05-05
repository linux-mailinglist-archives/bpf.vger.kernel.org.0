Return-Path: <bpf+bounces-57364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77D6AA9C3B
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0F43A90E2
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123226C3A1;
	Mon,  5 May 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW1HvhUY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DF5680;
	Mon,  5 May 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472044; cv=none; b=KP3JpqOBgwtLWNsmfNkaTYbgtYpgJfBnq92IKSYqkJMJSi7rwjjZDv3K26b+tE7IaoHdtdi0MnzgQT1ktbSLCXPTZZHyAwXabC/P+12hbYyAnq7lY8unQirOipwe8cHr5F1sAMh6SS+RLzVF5qvAxk/xvqoY2tWgv4sfvLWXwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472044; c=relaxed/simple;
	bh=vqfJRz76qOGMTug9Dsl9SlsPQ9bphoJEQXzI0zUFy+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4bENZ8ymVfXixbcMytAasSde9vyTZblU+VzRzOOXdkRQUdwysUjmSFvg+YL+Lsr7neWUADMYmvxCnk7RJTPDbcxuUrQ8Ukt2RIwyg7kmL3KjM0Y8vQ6+/Shr5U3N6n7Ey/GQDuvTkjlTCiESo8CkFpt5i+aed82mbp3sMaQcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW1HvhUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0215C4CEEE;
	Mon,  5 May 2025 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746472043;
	bh=vqfJRz76qOGMTug9Dsl9SlsPQ9bphoJEQXzI0zUFy+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tW1HvhUYwBQ69ioNvUFyz+Z45F2irfI4DT9uIX2zviWAgL5QQg9/VcJcLwN2b/aqD
	 XDpU5Zf1ZIXbItaLDRkzRhqhTIgVhIi3jmF3g2CDqG382rm03JgiYVUvkLHy1T1SVH
	 LAeZsZOv06wKNoVJoLTCTfZvkPlAz0aNw7gDh3hIfJvPxMLXmt6sSyPIIkXJ0S4Q+6
	 Xuxuz44wZHhfHwbb4xdD40alCXw2fwlPOlDPi88BSPXnx9At2Xfolbrd8WpuJ9TaaB
	 61wDYxLg3rq6Xg8aqx8OKUc+A+CmEBzO5H6yFhb0m3o42ADDojTX7zAv3KGW/1dprt
	 F5Iqy5uQH7xqQ==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ed16ce246bso29749246d6.3;
        Mon, 05 May 2025 12:07:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU92oYQIXG1cuIaBel1kKCrSz7hKsmHnsZjUauUsprdpw/v9s1Sr0+b2sESPMr0grUTMHg=@vger.kernel.org, AJvYcCUD7Mj6aC9qipFqufW1gfhRkGCRSxbw6zK/ipbVIltzwp6e/XV6DwXwtLZf6PYRecXrs91IidaoewpA5ZFA@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFZmV9dkdWoQ1ZHqy+2gIXgUr7xsW5UeJ7imIxSIVcT/G/kz+
	flJKSOEIqgHxXYGab/vK9vw83EZxJxyw1AEvtHQN75JZb19ZH6+o4TEQgTL/zTb7R3jC9AMiukT
	M0K4oR+KzTYwh3HxZ4wB5kkgbG1M=
X-Google-Smtp-Source: AGHT+IHCL/d7IrXY6eSaBJwkIU61ihp+ML6ju2++oRMY0MUZB89re6lzTdDXcCWojTsmBW/dQVFoTd/Nqm67lMEISOw=
X-Received: by 2002:a05:6214:2aa8:b0:6e8:f88f:b96b with SMTP id
 6a1803df08f44-6f528c3b4bdmr135125396d6.9.1746472042769; Mon, 05 May 2025
 12:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
In-Reply-To: <20250505063918.3320164-1-senozhatsky@chromium.org>
From: Song Liu <song@kernel.org>
Date: Mon, 5 May 2025 12:07:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7-jkU+KiunvZw9-NsxT+7ohcHQtJ6JSXNU4aDPxJLWwQ@mail.gmail.com>
X-Gm-Features: ATxdqUEdXhXI6eVxR1y6oLxvMCJbDnISwsMYKrKRyKVBkveFgoB-h7kU9DAkSA4
Message-ID: <CAPhsuW7-jkU+KiunvZw9-NsxT+7ohcHQtJ6JSXNU4aDPxJLWwQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 11:40=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> bpf_msleep_interruptible() puts a calling context into an
> interruptible sleep.  This function is expected to be used
> for testing only (perhaps in conjunction with fault-injection)
> to simulate various execution delays or timeouts.

Please keep in mind that BPF programs run in not sleepable
contexts, including NMIs. Maybe udelay() is a better option?

Thanks,
Song

