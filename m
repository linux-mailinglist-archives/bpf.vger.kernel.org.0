Return-Path: <bpf+bounces-51883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA1A3ACC3
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 00:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1886E1897875
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E61DE3BB;
	Tue, 18 Feb 2025 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpiZto3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB521B4137;
	Tue, 18 Feb 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922344; cv=none; b=iJRucZnn/OFbVr63E0Zp3m1K5fgWdS8Zz1hohGjq0zSMESbJVf5S7qTn/a5gwOOkd7d4lxMglW0VKrH3vglP7dOTEjyc536eSOVar4/Q3xHYWhN3VlXew25YWYXP7ojrSBjpsUDv8Yq283HMapllD7cDJoAx7vz7eTDse14b8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922344; c=relaxed/simple;
	bh=65VBNt0S7qZziB7bTMy0CHcTCMWGqCIh1ZfJXgUuat4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMLCC/XJHNKNDJP+DIZUuu8/QCMlTnFqW5pxDjLt5+H+wdMbDNcQMUxzKSBF8RB6ukEjK1LH613Xnjmv52N8v+p2xcWqIUEH6ODiGmXOJhJOc5Trv4qyJ+gAP37thnJ+hMJNarm2gpAuZkkh2BvHmf9pSzrXRLwo8YMnsncMk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpiZto3g; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85527b814abso99794639f.1;
        Tue, 18 Feb 2025 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739922342; x=1740527142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65VBNt0S7qZziB7bTMy0CHcTCMWGqCIh1ZfJXgUuat4=;
        b=JpiZto3gV4c3e/F23yGjMq0pVx9Q8K9HHaQjxmG+t38h7GrcGZUQBxT5UaxGnr5i1S
         Q+mGE7W8XOoWzekgmd5KMMoED9WiZycZIhPecl04f5j9XHYlNZVGlMG0+KMXYJliq5mJ
         X1YPJHUj0yjSsWKa7C6Ow23ZGvSCPRINV3MuwJgp/Hr4xr2D6dgZpXgezZqFSkGUdny0
         nqqT2cDKtpP6cWwl1mbrmvDcaCIpaQNR5GLFZRTKoEIM5LMtU6vzLVKfbluZ+t+Ggg0T
         DJ0m1PogOoLMRNoq30XVjotfScGTxtwZwGBwEAAFpiSpUmQ4Ck1r4WrDMdO2ZeuoGdM5
         551A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922342; x=1740527142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65VBNt0S7qZziB7bTMy0CHcTCMWGqCIh1ZfJXgUuat4=;
        b=iHe7U1mN10PGH7OYbP5RuHIVkaQzltS7gMaGg7Y5aJfqxfDSaBcmU2ClNt6aagg56a
         7uPilxW7ntVZx+DaojyqYJbX9oK6InHICLRJUfH5awzKy2xY+4BDL3gDwpNceB68stya
         I/6ul+n8sEywnApAJ05wfH5SvZwS2meUWk4s+SJdbbSsDmQWE2CXTVCUZ26Ce9QssHQt
         JR2k5jOE+0Wgw9a3ZmdfSNE5h0Ki1VVUVPCvK9REcuStgxHJBROVPi5XNuBGyz5prgNH
         gYHmuA8876EReYWbIH0MwJed68niRyc1dpMA5f8fAqEV/xDLWi10T8YhkXZP7CY9hLet
         8u5g==
X-Forwarded-Encrypted: i=1; AJvYcCVDY3uCycg5OWu4xZa3Cn06Ble094498BGoTyfnR2ddaY7Tjqbz0Dv+z/UzS40GGqc6zbyrB47v@vger.kernel.org, AJvYcCVYFEUnX6EWu8BjuGL8wdIol0vOx6pDBQBYwpCiqg+EubAn8fpEQTSm6ESRdjMBqFHb+8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQ5HjJIVst2B/tzConSfJPOHDS7KB9IXqkaac+Yf2sUzZsmd1
	vqvVN4qBtT/kPi42V4sQqX0djE+4iSHvc/ubpdMT1EKhsR6brCdghga+HhClF6KzPdnMOa2rEl7
	5l8iYqDN7n2me3jA46UIC/nLFkN4=
X-Gm-Gg: ASbGnctp+EP7LreCzUUPbbtwcBfjpKnOPxzug4I+AJyp3L1CJnKx5WRWfEY7qrwW8Sw
	GjWFjNEvLsNAlG1LYP3EOLifvY0CNiZiyD3Oy4M16b0lIgj5T14VDfPe/9ikBPJukjCZ7ayWx
X-Google-Smtp-Source: AGHT+IFzStReaQhv2B5fXmhtQ+bREG70OmQ2LxBw0rnKHSoSCAbjDOI8BdfT5/XMwDa/mWQloj/8aUG45KyE8Dm+5pg=
X-Received: by 2002:a05:6e02:12c3:b0:3d1:946c:e69b with SMTP id
 e9e14a558f8ab-3d28078ed3fmr122244955ab.8.1739922342074; Tue, 18 Feb 2025
 15:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
 <20250217034245.11063-2-kerneljasonxing@gmail.com> <4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
In-Reply-To: <4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 07:45:06 +0800
X-Gm-Features: AWEUYZnULHAhxi8CqVdrcZGL07pkdVVOjws9rWNrxPS7rgEfJdoQH8QriCUSnV0
Message-ID: <CAL+tcoANZ5MZFoqcB3d_G-BWuL=04165QpZeePLxfukDDo7Ldg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:38=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/16/25 7:42 PM, Jason Xing wrote:
> > Add minimum value definition as the lower bound of RTO MAX
> > set by users. No functional changes here.
>
> If it is no-op, why it is needed? The commit message didn't explain it ei=
ther.
> I also cannot guess how patch 2 depends on patch 1.

It's more of a cleanup patch :)

Thanks,
Jason

