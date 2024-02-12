Return-Path: <bpf+bounces-21741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5C8519EB
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5063F1F23A65
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158281E89B;
	Mon, 12 Feb 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmoOeKE6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E833D556
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756411; cv=none; b=f3IjLM+nd7S77HZOABg8x0R8P2VRO8pogJmLn7bGi5gYwIS37IBNO2H3qVkiH5EC6+C26w4OhzQRTTk5nCNL90ECtF0iNCcgx70CVoAFq8xQbJZjOdptX8ZjFplfBbbPvIWXWvYMiXO7mI3usgUPwNZ/1BEUXBxzO9GtvHJiTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756411; c=relaxed/simple;
	bh=QWlpJo/u28zbvtFZiOVhP4gmO6tgsx8Svvj/m/UceQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUJprI/dUq81AaDUZ13urB2olpDovtzY+wk+xc+dGtS7zTX3r68H7BZE493cSexQpEKaJGmk+FBxMiLjNiOgG2SrelhEWNvxueBVXvniNy7dBu6XRHJBTUl4iD8n3UT+PgDU+uieOFiaSZZWkwXx8z8q26iIf8hO8dODGqJv+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmoOeKE6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c025d5329dso644571e0c.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707756409; x=1708361209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRXn/FUJo0zSJV/2Z37t00jW3IhiZQ+iY89HCa4SXyU=;
        b=kmoOeKE6t+Z5ovHUUv/lHY9AxJok2wp/tLnix8RvS5BOPV3St3hb5+5+1RcY2P/E/h
         aoi2bBIBZ/qKrZhywvKUiMcKjAmurJciNne1xkDRExWicJ+hLsoGcvVpQ2AAlwmR3+tU
         YTVbkjRQEnzcWRtv+y5uMVryN8wZF2bWyV38EREBwaZPrh4fk64bUtFPgCVyPeYFe5NN
         w30Cr8/K5QsHA3nyHS5+Plxc/ewha6JJV7BNB0ZdomWa6DrE/V8kKwHvPN8ho3uoGsEX
         0V9EVuLEVotaBGj1mjhRUAgNFnqB3AuwYOhbQueYBdIK8xzvGaFUgwRsI4RBcbyUACJx
         buMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756409; x=1708361209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRXn/FUJo0zSJV/2Z37t00jW3IhiZQ+iY89HCa4SXyU=;
        b=SZNG+xN0ZwNTnMIsST1IXILU3pAasQ0Jo3w1L7q3oVBioEUTyBR7qOeDjbsEvcJ0ta
         2yMFMdesLxuuweCiVEqZCAQLxelcotImOzIaZ0D3fKTZKuygdzYu6vOQdQai7pipTSrc
         R+bbEjq5tYZUFxZdMyOqyA0Xd7dkUFEjQmiNhpMqITsCR0TYipx5HdgCW0UusCajQHHn
         k1RQzoUgcV7WM303nzxa8lcFElda1BXQjt7MzWS7qvhRMvIgIqBSjxhpAaL3q7tETltH
         s1T7dDxahhTukT6yYAlIxXqgmY5WHMkf0f30NO8D3DM77rm3aK0UdMgPqXp/IWpfT3UB
         nRtg==
X-Gm-Message-State: AOJu0YyVdTKajjYvzvY5YtuKrcRUBs03BIENmqZO/4t5BeVHyrVMdI5f
	gXfi8qCwsHc+d2Xmdoo7yrWe40jN6juGzYsTQxSQ2vCSh/1PHZnNEQybumunVS5sXya2lVjGb9g
	f+f5zJ3mrVXQhetk3wBM6/l7yXBDbXbOuT+akJkhhrr9AnV1h6izg
X-Google-Smtp-Source: AGHT+IGEMCUC//0mufdABjhuguz+ryk6Jwy1GNDMmhncW4elR+FX66C7DfE0W8a0kIMU1PXV8huv/kucVI6x0WCM8XA=
X-Received: by 2002:a1f:6281:0:b0:4c0:2182:3cdc with SMTP id
 w123-20020a1f6281000000b004c021823cdcmr3893610vkb.1.1707756408741; Mon, 12
 Feb 2024 08:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
 <ZcUx0QdwW4FEDjTl@google.com> <7efb192b-4eb5-4e25-a52f-54add200de1a@linux.ibm.com>
In-Reply-To: <7efb192b-4eb5-4e25-a52f-54add200de1a@linux.ibm.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 12 Feb 2024 08:46:35 -0800
Message-ID: <CAKH8qBvRGjjLrT_cRagR=v++tokgtdQJgjQasZPApgAx05+ViQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, void@manifault.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 1:56=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
>
>
> On 09/02/24 1:26 am, Stanislav Fomichev wrote:
> > On 02/08, Hari Bathini wrote:
> >> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
> >> warning:
> >>
> >>    "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
> >>
> >> Fix it by adding the appropriate #ifdef.
> >
> > Can you explain a bit more on why CONFIG_BPF_JIT is appropriate here?
> > kernel/bpf/cpumask.c seems to be gated by CONFIG_BPF_SYSCALL.
> > So presumably all those symbols should be still compiled in with !CONFI=
G_BPF_JIT?
>
> Actually, CONFIG_BPF_JIT is the precondition for cpumask.c
> where bpf_cpumask structure is defined.
>
>    ifeq ($(CONFIG_BPF_JIT),y)
>    obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_struct_ops.o
>    obj-$(CONFIG_BPF_SYSCALL) +=3D cpumask.o
>    obj-${CONFIG_BPF_LSM} +=3D bpf_lsm.o
>    endif

Ah, good point!

Acked-by: Stanislav Fomichev <sdf@google.com>

