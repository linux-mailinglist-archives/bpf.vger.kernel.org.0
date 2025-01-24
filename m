Return-Path: <bpf+bounces-49653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83CA1B0BA
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBDE1887847
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 07:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7B1DAC9D;
	Fri, 24 Jan 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6BH0LuT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9133998
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702799; cv=none; b=iwIEo0p+6YOQ26ZHo6TkN1q9wpIMu1sGNRolTpY3ucumOS8fhaDwbX5RlMakuHuCpaEiIFRrhPGWQ6NHyOTfRKdxOMekG6AF7cJ44QaseZTemFIipq8wBF5iMa0xk3rI9XRDDTO9w4iWaSbZyXf/J37LUhVN//3OHvaQqKr98MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702799; c=relaxed/simple;
	bh=P8o7x1AcZLiKxFj6ZIABvHf3FeCju9jiEw8AE2/INKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECxMgl/VjYDIYzwjclThoxe9b2DJTYQAYWoCcXjRl82buyG5vSnunzZ6Z0wfkenymhDu9owQmku1d9BEYL9LqhZ8xOoTUAG8558DikAdjDX0FxUSXWMrVRnQ7JbgBALToJTECacdqp2FrhVrYarUdhmW8jlo37iPdUny7uxX3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6BH0LuT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fa7301ae86so410207eaf.3
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 23:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737702797; x=1738307597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3QOuz8w13GxhdNN5JTO9t1jxLB10P03IjCINFX8oOJU=;
        b=R6BH0LuTZ85KcWApUU4ybuocI4GTjLQL8QRiJFTL/D9OOlTMHV+p4YFJjsA/FVEBvr
         BGy2BjcxX8uLHQupa86hUyRred92DAM0av4T58FeBzEUNcYBl3ziBvi9zPLIHQObX73i
         s5VNxoQ/GgAZ/xRQY5avbcXMBMoPhT8HLlLASCGb8HqOMFc5bCNiU+qrSjmyIkQr0rHc
         BJCPBuoXITwRrGC5rUXzZKVcvjK4K3x41riLuMGJLkLQ/ehAnYc7PlLJwvKshJquWw0E
         6OHuQaLvh58oge5ZokzwJ3aP9xRWgQofW7SaeksGxSL8JLocsrj55WmXC8RJM9hGlbUQ
         tRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737702797; x=1738307597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QOuz8w13GxhdNN5JTO9t1jxLB10P03IjCINFX8oOJU=;
        b=TxRnVC2Nl5N6mvhUd1UjjPNwjWnyzH657G1UA0jSqIcy7kDWx1WsXOc+ynsoy3tKvT
         Njz15I9Vu1IEuVypQMdtrNDxZX7Q/0yLGHmo2fNSUagTAJDtA4b91LRIRWMpmwEUTT/1
         ovFLr6CnY2DdgSNeKgynlT4JBZ8CEuRveEmTPsf8kaIkDHd9CTMyrctBYUB5LCvMTZDd
         E4PGphu6vCkWp7cV1+v3lrk1WjEue9E0C4Lxy0Gaiu+2s8YwQtuDI0OnZCz37TZWQtPK
         +J6b1aspLtyf9cA1MiXNW1RTfQ7/RRLBUxwQ6kLZNNhCaxIGtAHkD8k1X2aBCFHy3Wua
         rRCA==
X-Gm-Message-State: AOJu0YyLFYweoQVM6bGaI8fbPQXrzt4+IoD2P7gONGF+psUrwOfZVmcv
	o41mxnmH7XZ/haJXOeMfvCnX/5qGI/i5L1uJC1CYqroy6aXCKDElDhba4fXWxP3OCKxwZkBdmps
	3VhB2cH7aGMKMqm+y01PcbgisKTo=
X-Gm-Gg: ASbGncu6Y3AuXk3d9TjCn/Uu+b3mt4DqjuOBxJLRWvHwSpq5Ic5FBswPV3dSTgOpmAL
	isnA2DR/jdWKN7xTxpI7O0a29bagNJlUopiUU8Y5VWnRQ2MtGe/CDpn0YumBT
X-Google-Smtp-Source: AGHT+IF3eEOfQr0VareiyuYaGdxF5NKVmCGnswJYc2OMS1nXbLPlCZ3xvL3Osz9/SgYgdBvd2H9QX76CIlD02Di8GMA=
X-Received: by 2002:a05:6871:a4c7:b0:296:e6d9:a2e1 with SMTP id
 586e51a60fabf-2b1c08bb0f6mr16323529fac.11.1737702797162; Thu, 23 Jan 2025
 23:13:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
 <a36556ee79898a0ccfaec42e1c70ba5593b1887f.camel@gmail.com>
In-Reply-To: <a36556ee79898a0ccfaec42e1c70ba5593b1887f.camel@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 24 Jan 2025 07:13:06 +0000
X-Gm-Features: AWEUYZlQgyKxmQucaih5hE4XNU7tIBkIgXBY83N4OgnpNlo77DZDP-Au4DFBoGI
Message-ID: <CA+XhMqx=k+KYK1CrGY2VzWsW3UYHR5PYRkyRDo0wEjht9CkTgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1]
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi sorry for not responding earlier I realised by myself going through
the reading submission process and rereading my patch, it was not
correct/useful.

Cheers.


On Fri, 24 Jan 2025 at 02:17, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2025-01-21 at 16:50 +0000, David CARLIER wrote:
> > libbpf.c memory leaks fixes proposal.
>
> Hi David,
>
> please take a look at the documentation regarding sending kernel patches:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> In particular:
> - the email should be in plain text
> - subject should be present
> - the patch itself is a part of the email, not an attachment.
>
> About the change itself, why do you think there is a resource leak?
> Here is a fragment of bpf_program__attach_kprobe_opts:
>
>         link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
>         err = libbpf_get_error(link);
>         if (err) {
> -               close(pfd);
> +               bpf_link__destroy(link);
>                 pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe",
>                         func_name, offset,
>                         errstr(err));
>                 goto err_clean_legacy;
>         }
>
> When libbpf_get_error returns a non-zero value the `link`
> is either an error value or null, so bpf_link__destroy
> has nothing to work with.

