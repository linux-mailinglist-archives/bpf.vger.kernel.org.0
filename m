Return-Path: <bpf+bounces-51482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C20A3528E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4963AAD30
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56948472;
	Fri, 14 Feb 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUmcSg+H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4255228
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492394; cv=none; b=R+ZX9TNgxCwV29J+CiB8OWU/6+8w6U6BzxGAVgy+9vkazRiVYb7he0gTsezXa5p1SgYDFnNY5nGZGU2HbfMTGKSzCePQ+KPTFZ7Ti3CdkWwefkaroH1pz1LcuIz6xuDOoJxA90XNqII5TSg6NpHxKxIvmrUQeWw7TNDrQdJT1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492394; c=relaxed/simple;
	bh=IXprIKD+1AbwNIgM0zHvPlt0P6s/2p2cMH2AySuEB9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn2TqI8pqfuXsGHjzYeD034heV1VIIsMSxdKpMNtyxV1XUjSGE7IE03QgdLhI3N4F+0Yft6NumOoVYjsbNRNvkPwo1A/P9FJMfDziCBod6jOxqVgj6scBcMhrR5BUjtR8xvwiFmqqtSm+kfzU9sDJbtY/Pf8KH1xK4e4RT646yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUmcSg+H; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e4419a47887so1179251276.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739492391; x=1740097191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQWlcixpL1or2U4S/hZY/PaxKuC2sqx+9pK4FbnOBRw=;
        b=NUmcSg+H5L3Z2DaqJLr9kuKdB3Ev8vE9oyI61f3HHwjJIQMNnTeBsl9kdtY8ovqgSS
         +h3JIEWs5VOUNZI6bUlM+A5W+R0k3NsNNphtdmopBmWvfiGgZvTjYXpOFAOlnPpi7w/u
         O0a864QRRT14rBmH+h/5k2K7NhIHlUtNyCPG/PrYX0Qx1Am43Z7UAHHU8n0EcOxq9Pjr
         vdJdB8rbbrZdPYrdHWlEF1rKzJJdNILSCV38FZMTm1u8KScpThL3IbUjO0lZ3WJCfJso
         UY0otJBhm9rTKgme0Aop5gM4iFSEwyLYK9m396DpGnDYZyTJZb8kOOYFD5LPI1frUZpZ
         4OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739492391; x=1740097191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQWlcixpL1or2U4S/hZY/PaxKuC2sqx+9pK4FbnOBRw=;
        b=bTp2wITj2THXHdAOA9ifE24WIQw6TcOfYukRyJ4iOHcu7AVT0VlPQ4xp/T9T5ekQc6
         8o9veUgWZwghDW3Ew0PMVGXF8g6yHz0j5F6VCSknZ3LHxlQOVCi/B6dGpyhV7PRSLwHz
         VD0/LLmuOqc4F+XpoV+2dEwPJCwqtwD8eVO7+gLLdUFPLQy2OVsGF3h4yD0Mt7BV52R9
         7v0k+FLUmp2IQXdOtvlRovRYDV48rzJJCwldfU02ZMloEHPnvmVHCFzxIq7cM5QmZIak
         rFJ3D/56uElZBDhPlgq55hcSyHOqNfJ4VuCHQuL75GyEYK2Vjh0DIhYEfCYe+/9gPYC2
         f+rg==
X-Gm-Message-State: AOJu0YxOcgHUVwnIq+6aztyxQhV8eJsrKu4/GdljLZGelA2FpvxWDTQ+
	wpZ8vaHukM+UAZlgrtjBJyfbg+ZTnqB6h7gyS3GVF+I8DM8mw+SufMgAl6TCvyZoIjT8aMNfAqO
	9bm/+8V0gQfZlrXRmg2jEMYNQjq9dOWtDVa4=
X-Gm-Gg: ASbGnctkoXLtH2/pwM+cb96WZjgsqM/LNiXffrddi1yYKij9+fP/vgeXfzS9I+BeCTz
	SeEw1UzXThHTv+sPrr/rhkOYIe7VOj+1CxjOKxHYtt3IBI5NR571oZSauQDkGmFcjiTHrImTe
X-Google-Smtp-Source: AGHT+IHXhPkCbhpSA8NqwnUanrXRXOzf6rpZLZO2WnfDYBCq6sEFJWZpimU1we5Di3iut5I6l2eLaMLMr88flmI3MsA=
X-Received: by 2002:a05:6902:1409:b0:e57:37d5:e271 with SMTP id
 3f1490d57ef6-e5d9f1872cdmr8912150276.47.1739492391550; Thu, 13 Feb 2025
 16:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213233217.553258-1-ameryhung@gmail.com> <cfe7a83f-a2de-4157-8a43-abbe95968b05@linux.dev>
In-Reply-To: <cfe7a83f-a2de-4157-8a43-abbe95968b05@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 13 Feb 2025 16:19:39 -0800
X-Gm-Features: AWEUYZmGrbkebuByZ6Dctpq34ssSGjhSfk2RN3xIJOXfC4mXLD2P3BYJ_XaxK90
Message-ID: <CAMB2axPo5PKKEe3_7opjV4KftCqpDZo9m=iRZZ=g+mUqDeZzqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix stdout race condition in
 traffic monitor
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 3:32 PM, Amery Hung wrote:
> > Fix a race condition between the main test_progs thread and the traffic
> > monitoring thread. The traffic monitor thread tries to print a line
> > using multiple printf and use flockfile() to prevent the line from bein=
g
> > torn apart. Meanwhile, the main thread doing io redirection can reassig=
n
> > or close stdout when going through tests. A deadlock as shown below can
> > happen.
> >
> >         main                      traffic_monitor_thread
> >         =3D=3D=3D=3D                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >                                   show_transport()
> >                                   -> flockfile(stdout)
> >
> > stdio_hijack_init()
> > -> stdout =3D open_memstream(log_buf, log_cnt);
> >     ...
> >     env.subtest_state->stdout_saved =3D stdout;
> >
> >                                      ...
> >                                      funlockfile(stdout)
> > stdio_restore_cleanup()
> > -> fclose(env.subtest_state->stdout_saved);
>
> Great debugging.
>
> Does it mean that the main thread will start the next test before the
> traffic_monitor_thread has finished? Meaning the traffic_monitor_stop() d=
oes not
> wait for the traffic_monitor_thread somehow?

That part I think is fine. The race condition here happen between
subtests within the same "netns_new" scope. For example,
test_flow_dissector_skb_less_direct_attach.

>
> >
> > After the traffic monitor thread lock stdout, A new memstream can be
> > assigned to stdout by the main thread. Therefore, the traffic monitor
> > thread later will not be able to unlock the original stdout. As the
> > main thread tries to access the old stdout, it will hang indefinitely
> > as it is still locked by the traffic monitor thread.
> >
> > The deadlock can be reproduced by running test_progs repeatedly with
> > traffic monitor enabled:
> >
> > for ((i=3D1;i<=3D100;i++)); do
> >    ./test_progs -a flow_dissector_skb* -m '*'
> > done
> >
> > Fix this by only calling printf once and remove flockfile()/funlockfile=
().
>
> Yep. I agree this patch should be the better way to print the one-liner r=
egardless.
>

