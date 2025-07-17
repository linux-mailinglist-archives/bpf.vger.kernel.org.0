Return-Path: <bpf+bounces-63501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1FB08148
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B263B7ED1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0264689;
	Thu, 17 Jul 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKm5mkZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00773383;
	Thu, 17 Jul 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710847; cv=none; b=PZqpIPi2HOvK9l/hEErnok8MmwgGP8WvhyZRsRCj/+nobnmc863J0U4HWtUfCi66LsJSrZtWiJ3ZXE+34vop24ANqkgm/jB99hdAkzwY1avxjjXU+UkXqEK3CT63+XOE4CS3VcdsKXtmAB19A8RVsws7L8h7GGCtQFnEQfynKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710847; c=relaxed/simple;
	bh=7PNLvffZz9wq/z7znuh9ALNFlKr4Fj/PhZkGv9rgmN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IghuODqd7ioEF+e5swC4QDI3VIeKtaTJZyLPHIHMMJbkuUAYWA1ibkyv2oTZr+0DAv9b/4fdda3mJHXifnQ8BgoyKzSQ7F0WIhKdLnBy3c+n2eH4D/IAWn5KBdbL+yjwmEb1hrofLLYpn0/sfbH0wpXk7S+z/5nfBxP7O61Tico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKm5mkZc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8760d31bd35so16860939f.2;
        Wed, 16 Jul 2025 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752710845; x=1753315645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PNLvffZz9wq/z7znuh9ALNFlKr4Fj/PhZkGv9rgmN8=;
        b=bKm5mkZcmDkDCL7EUBAAybxzhIGeXf2qRGKwa1NDG96z5AlZXk1RrE6SD5Ee7xj0kk
         nciRKOwKdsjcLxVLUA5BEizdJ1Twbahd+CuoADM8PqrBaXMRnPfjIMlKtMPt4tq6W6Rv
         FkzHXU/wBh0mEv8cgOmzuDgsxxClyTq+ZcRD7wAXClJEzjBoKi2EOVRgGZjWGLZd7dW+
         ExVSD+kNDX2wc6JiDbReqIlCCcUr+DQQYXNeuP2HMxmrJTzidmm8Ol3hfzKUcTdJuPxG
         1IgEkUCZ6tGexbZP9nrVFLS23tngtXOL+slFyD2oTrs9ws7sDQS62BRzF7oQ2XxgJkSH
         e6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752710845; x=1753315645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PNLvffZz9wq/z7znuh9ALNFlKr4Fj/PhZkGv9rgmN8=;
        b=VgEMHrdGW4ZxGNFadMxisbBUeNmtj4iXS3MNdf+t246rDt/YC+mfrVBBu19QvECtIu
         bZEVJZ1LYV2tvIRX3F28NXMwLeFU1aorJydQV5l3BV8IpIv6EburrSBW1Z3Vv/cij6NR
         4Fa04BpNIYDfsX+cBwAXKeFE9NYV3q3av3gt7c94NP+bCezcXaI+uzu3P28Pc6vLueh/
         LQoSr4gd+Ge/9rU+pUTt2YvY8afXyiN9JgvE3cm15PQ7g6WGtPaWMxFHtIhIeBH5sGQ2
         gtj+g5FXzqlw7/BIFgElSO5JKEucMqOE2E++YyoJQXDSRAPkeCMf1m1V5+GQOpZCshw/
         Jg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5TpGMD3dkVQtKyG6jPkCJML+bq4yx0uBstaOt1lmeaDzfMpoEpvbAlNR/Nv9VkWh0YYFkETtO@vger.kernel.org, AJvYcCW59cq/RwtP5deUJK5OkF+uzuVaJLOzZOFAb14wKfpsM9aa+0FE01LAlbTkefC85VrY6eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3HBRN/r9QgQBFKjUeD8AvLkvrJp8qekBd/q5J40ez5FSlFMJ
	wJlsJgkJGLjZ64AM+wo4mbzAOR3SAzfC4gMRlJrpvNl0KvaP1RBhxHFwtTYRWrczlNx/A5lT8Cm
	LexvNa6zoasjzlVzed1BIkkje0L+SAQE=
X-Gm-Gg: ASbGncsiFGkKpgYYUIeXkQXOyl5KPx3m6zYFTK5vCwtq1mTgOiFkfMvS0UnHRkpstBG
	l4hZTyrgyTGAVtDxbE41YBXqVlrC2VmQgTJIhI8pD/bu3CzlBgxz4VVLhcpKdGXzr+MLqchk8v0
	YoDc93CgWvmFN7mATf4tnkPfGo3Ts0ECkdGYriNs1q+dfmmZlLtt8tQfKfKnJcsiYlNDH/nfW9H
	4t7ku4=
X-Google-Smtp-Source: AGHT+IErWytnVp4cjd63CCocY8p1VRIFfQz7pe0IXhkkxVZrY7KxdYicyLPjlysmN69DCtaUrB2rjS89R/NGSx74erw=
X-Received: by 2002:a05:6602:1696:b0:874:e108:8e3a with SMTP id
 ca18e2360f4ac-879c093ab71mr708579539f.12.1752710844930; Wed, 16 Jul 2025
 17:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
 <20250716145645.194db702@kernel.org> <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
 <20250716164312.40a18d2f@kernel.org>
In-Reply-To: <20250716164312.40a18d2f@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Jul 2025 08:06:48 +0800
X-Gm-Features: Ac12FXwfJCFR4GQuQSBgpVS_10CC17D0YvmQCpQbf1193DUyAe0a_jTdHWEdslw
Message-ID: <CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 7:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Jul 2025 07:37:42 +0800 Jason Xing wrote:
> > On Thu, Jul 17, 2025 at 5:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Wed, 16 Jul 2025 20:27:25 +0800 Jason Xing wrote:
> > > > This patch only does one thing that removes validate_xmit_skb_list(=
)
> > > > for xsk.
> > >
> > > Please no, I understand that it's fun to optimize the fallback paths
> > > but it increases the complexity of the stack.
> >
> > Are you suggesting to remove this description? And I see you marked it
> > as 'rejected', so it seems that I should use the V1 patch which
> > doesn't increase the complexity.
>
> No, I'm questioning optimizing the copy mode AF_XDP in the first place.

Yesterday, Stan asked me the same question, but the zerocopy for me is
obviously not qualified for deployment right now. Let me rephrase a
bit:

1) There are still many VMs that don't support zerocopy in the real world.
2) Some old drivers have various unknown problems. I posted one at
https://lore.kernel.org/all/CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_=
-Q3g@mail.gmail.com/

To be honest, this patch really only does one thing as the commit
says. It might look very complex, but if readers take a deep look they
will find only one removal of that validation for xsk in the hot path.
Nothing more and nothing less. So IMHO, it doesn't bring more complex
codes here.

And removal of one validation indeed contributes to the transmission.
I believe there remain a number of applications using copy mode
currently. And maintainers of xsk don't regard copy mode as orphaned,
right?

Jakub, if you can, please don't mark it as rejected. Thanks.

Thanks,
Jason

