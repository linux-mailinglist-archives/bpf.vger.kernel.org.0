Return-Path: <bpf+bounces-42152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD559A01B1
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291891F24DD4
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 06:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DD18E37D;
	Wed, 16 Oct 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2VF0+RX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A184549;
	Wed, 16 Oct 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061142; cv=none; b=tqgJKuP8Ev0jYM/TAC3eNXenCkz5PCONawurBzmQZo2u5twOSAEm9YbdM6fObGru31Hk2Ne+R1dfsL3YCifcgFVOSrVoo0CoQtvEmlebS3/y1uUd4Mk2rXEaeOVymeu/0MnPhnDuCVDKXLCxkc+MRMlSRlggGnWk3Qyn/e6HupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061142; c=relaxed/simple;
	bh=oSDymd/H9f0BSefS46X3kDjbWgANSIiIaU3cmbWb+zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPa3OJ9CLN5IgUbOSSK3BGzmJd2dPLZMCnX39KnoY9wxynZ19+9eJnX699iubJKLwFwqjK49GJLV66J2RZNJRsCVsnGJTRPInJFH6jDtuKEuwYXBVNcBDaBhZXjzfrQFbIj0h5dnyLEcklZKee32u5SYOOPEadQOV2V1c4kIZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2VF0+RX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8354845c5dcso266997639f.0;
        Tue, 15 Oct 2024 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729061140; x=1729665940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSDymd/H9f0BSefS46X3kDjbWgANSIiIaU3cmbWb+zk=;
        b=P2VF0+RXW8XNuy4YXuSJ4onXtm4MTReR0b0sC2k4lHw9A+KFtiMpmuvpxa0slv0bYp
         3iI9kMydnwdsTv2DjMVZgSH/lqWNDn8kSRnN8imbuaAPAa4FfUqlWIWXs7CI5ty1QbZQ
         nzUmEtrWxdkL4jD/rry8LzLalkpHLcH2bpB5TRxmiCABp6x2/8vr0vHRAm1CVjsh6a2n
         RrwoSu5/DZqWgCafqvidxO1NFK14LSApqWn+hN8IBIGQ9L6obJp90rPWR7Lk0/rSvGVM
         HqMPPqZs1xLsn5yCCZbQ3x9ybjmaeshUF6De8TZjFY7AVoRBvhGwWXdpiPNDiKtK7xMi
         rVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061140; x=1729665940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSDymd/H9f0BSefS46X3kDjbWgANSIiIaU3cmbWb+zk=;
        b=fKVpdjeJcK8Fg3O9wO7RnbNilJjIDl+Y5ay1pMShnUy0xeYI/ABFtEOlmsXnuo8kFZ
         U8wZzKx87cNd9RI/uIQcSuJRvNpxyKH/bwrPbFOllJ29q2A13ye3C0xYDAbQUZWU7Clg
         dRYZrYuYl5Gt9zGZOM6qsHNUaMA4DMkGhrdwfcGYU6Dnca726Z3T34QLMNYTmcBUejY0
         13W56n3E/Pyn+Uu4AeATzM22uqzWOur+f0MdeaZcIyVQkqSjZamyMBvvnd2r5EWJGeIR
         +O5BGbq67aCcd/6ZmAwL2KgRHi/PWqLnConFrUda6uQ+nYKyokvCStwQdx8s1nfPhiDm
         Sgfg==
X-Forwarded-Encrypted: i=1; AJvYcCW/y4jbH/wdMM3yYRvUyeNSrvLsPbBh1L0ucG1w0wiIjLY0i0rgSNQP1+513a+Up8I4FVUUJE9B@vger.kernel.org, AJvYcCXFn5L0Ab3hFKxD++hvYQSfkE2vZ2IQG1yM10Qpw9HSuF8+7EiJW7XV3UB12ciUKlRHnjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP2h0Ci8Ud1/Cl5E2Ak2199zgygXnFl4N765XPRJpRRjQfS+c
	dnz6+Zr+uJet90HAPtlPp6mD1ma6/3/32Dbkjjk7gDBNcMEOKESQxFOJUSX67bmI7f88GfAENAH
	7mON0qG2FA0NBwgWKhp39wl2thTU=
X-Google-Smtp-Source: AGHT+IElicXmF1lXRk1mDOq2/f6GFR9GDxeNlaVtgK4wko074sZk0NvO9jxG//ZbQ+ONd9rXHiGuUaKBYtXa1jRo/3A=
X-Received: by 2002:a05:6e02:b26:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a3dc4f640amr28938865ab.22.1729061140318; Tue, 15 Oct 2024
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com> <49a87125-d5bd-4b8d-964e-0d745e9e669b@linux.dev>
In-Reply-To: <49a87125-d5bd-4b8d-964e-0d745e9e669b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 14:45:04 +0800
Message-ID: <CAL+tcoC5QLfpAuJrZxUPbaaK68pGKD31vuohi=NcXghe+uRpZA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:31=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/15/24 6:04 PM, Jason Xing wrote:
> > To be honest, I considered how to disable the static key. Like you
> > said, I failed to find a good chance that I can accurately disable it.
>
> It at least needs to be disabled whenever that bpf prog got detached.
>
> >
> >> The bpf prog may be detached also. (IF) it ends up staying with the
> >> cgroup/sockops interface, it should depend on the existing static key =
in
> >> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
>
> > Are you suggesting that we need to remove the current static key? In
> > the previous thread, the reason why Willem came up with this idea is,
> > I think, to avoid affect the non-bpf timestamping feature.
>
> Take a look at cgroup_bpf_enabled(CGROUP_SOCK_OPS). There is a static key=
. I am
> saying to use that existing key. afaict, the newly added bpf_tstamp_contr=
ol key
> is mainly an optimization. Yes, cgroup_bpf_enabled(CGROUP_SOCK_OPS) is le=
ss
> granular but it has the needed accounting to disable whenever the bpf pro=
g got
> detached, so better just reuse the cgroup_bpf_enabled(CGROUP_SOCK_OPS).

Good suggestion. Good thing is that I don't need to figure out a
proper place to disable it any more. I can directly use
cgroup_bpf_enabled(CGROUP_SOCK_OPS) to test if the timestamp should be
printed with BPF program loaded.

BTW, I found that we don't implement how to disable the ip4_min_ttl
static key. Sometimes, I'm confused whether we have to disable it at a
certain time.

Thanks,
Jason

