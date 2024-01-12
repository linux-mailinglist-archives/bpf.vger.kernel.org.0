Return-Path: <bpf+bounces-19465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877E82C527
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2328635D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AE17C9B;
	Fri, 12 Jan 2024 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBxhJ3sR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E11AAAA;
	Fri, 12 Jan 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed85ec5b5so5501576276.3;
        Fri, 12 Jan 2024 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082541; x=1705687341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8dTLTTQWQauPVmA7N7Cgw9w08I3I6pmEcifcj/7RQ0=;
        b=FBxhJ3sR5h2CfOu7FhqI6P/tigDGMcFX8RSTI+dGMMJjj7NhrMJ/QJFko/b2udD6ht
         jOH2TcSV6P3QeOsChlVyMsBTWD+V/GgeDYV+tcBM2MNEI1PIqNY9xQYPrCbV65cWNQcB
         VsJMgt7nL1tw1kG3KFs0QDibqMBrpRSqoQlVjCUP2PnE3J6MiTj4FDQ7ySdh9pKrbuXq
         p0dTwdhp8FhTbTJQEqMl96nxLdAeCrjFt4bzXRN9V4+43kdGrUjYj6164bKlKmMZye0D
         A7DVSAX5+jLdgF4zZhTBrCHFo8bqigUji3he8VJG9SXvo9KUhrCnLMLWU8hWm5O3qSgl
         kBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082541; x=1705687341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8dTLTTQWQauPVmA7N7Cgw9w08I3I6pmEcifcj/7RQ0=;
        b=JhLzVgZ7gBo7oMkRFMwz2VFsOpVM2WKRDv5SBmesB/Nu//jY3GTJZt5WwMUq5VPv1h
         F25f59lF75PujLWVLglIzM5Nd8l3mt9cqgpIfUMLthfgYvwDpn5Ou99MIXfBemgOQAi7
         TmheybEWoQurJAn6qkh2qDelljf04hwIILCMSkoH06WRrCR8nTPMcSha82ngOrzafYnF
         jQVaYgqXBsN2mXCa5oE3NPVsJy9N9Z5kWrL+GuY99r331YAOlxzza69A91idIkNP98Am
         XrFPc+p8RJzLdJXj/XIPAr3sSUSjsagPxJhoumffyz5cANjwuBd7HVSiACkZdLG9gpzn
         vKTw==
X-Gm-Message-State: AOJu0YzgqQSfxXG6HBXpUCp4uu3oPY9ld35ohdzO+cEwwVullDzCkk2H
	8TacYhJBlzbPWgKZPVL4l7bVMbTnYNrH8Gl0VQ==
X-Google-Smtp-Source: AGHT+IE8VVnO9ZHkTOH6uJMBFKQmimo6ZZatvIvy4HtMQLKns5zvqi6y2sps2th9o5CjM2M469UEfiaWfKmR9rsK9po=
X-Received: by 2002:a25:ce43:0:b0:dbd:c1ef:8fb5 with SMTP id
 x64-20020a25ce43000000b00dbdc1ef8fb5mr835203ybe.51.1705082540645; Fri, 12 Jan
 2024 10:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112152011.6264-1-sunhao.th@gmail.com> <CAADnVQK4S2roFHP6W+PwT6+CjcCaUVzTHGHs39bwZPU00PEh8w@mail.gmail.com>
In-Reply-To: <CAADnVQK4S2roFHP6W+PwT6+CjcCaUVzTHGHs39bwZPU00PEh8w@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Fri, 12 Jan 2024 19:02:09 +0100
Message-ID: <CACkBjsaO126d1tb-6GpPe62dkqfT7ZynhkWW_WzCaz1AHiY1Tg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 6:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 12, 2024 at 7:20=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wro=
te:
> >
> > For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> > for validation. However, variable offset ptr alu is not prohibited
> > for this ptr kind. So the variable offset is not checked.
>
> Why resend v3?
> What changed from v2?

Nothing changes in the first patch, the tests in the second patch are
reformatted
with a proper number of tabs after each instruction. Forgot to add changelo=
gs.

