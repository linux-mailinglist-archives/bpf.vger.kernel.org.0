Return-Path: <bpf+bounces-69364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155FB9551D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1343BABBA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68A320CC1;
	Tue, 23 Sep 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BImwYBQE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A52E2DC1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620999; cv=none; b=LhbSjt50kKAbonnBoUfLh8/ywLnEzxQ0EWCKpw2ZHCR7Gr/5Adxm1BNrRKkswfYJPSesKqG/OB6kRnSv9vrqB/tl9SBKitKr1/MQop2HnIpEGjwAtlKsG42g/AF/ozKhiU3CMghqOrvAPUgsjitGsUd6llBjvZpgzs7tpE4tpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620999; c=relaxed/simple;
	bh=VXHZkezM8PfXpz6ZD+la/LiAx1P9SR4xuxnmq1B86mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjlpCLYwm6DkKNd4Nfv/dDGaAyDs+EUHLd2Gf9zW6oecdlf5DEKgYsTSmyIoYH/nSKbWUovtjZ8zOL7tPkmuUy6J/tXzvfX5iiuNeRWFnZjfonQBBFfBe+kE4hxajhurASQE/KJNp8EOniEkH5Ji61P20AiXnTJ5ezM+HbBRdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BImwYBQE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4121921f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620995; x=1759225795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VEy+ONr+6sNw87YqJhqZchL9JFCmPi6e+LiBJyvIh6E=;
        b=BImwYBQE3qcMopm5bQleOJnz8KN8//O+VG7k3VyNBHRZ77ucQkf5QuJs5w1JMZxBoh
         MmScNEiX8cYP9gwF7lA2RuhE7KxVaaniNgRNGdI9hiqBp5BDiH0hlbI25LBXfAaJgKbr
         +kXED8RjzktLA9omuHkA8+i2gpBApQN1q/uupRt5GzoiVp/yYPOH1JYiJF5si6haU5Tm
         lMnm9OSRu+tgWjWjQzZ9N0xML60Vp4/l0cvNKhlq+9x6wlb1xljZVeY+QVQXW5MupjJV
         DQoSmEOLeK+ie8U5mIsK/BDGOFld11bJSS7BIj1twr5aDlJ5t8f7z1bkToS1twS5e3hN
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620995; x=1759225795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEy+ONr+6sNw87YqJhqZchL9JFCmPi6e+LiBJyvIh6E=;
        b=tRQbpu61XL7ym9r+SccLPlwpFwACXShIqnOEJxWpeTHBSA6FJvIL8uG+TY0xGg+GVL
         8CAtZEHNR+G5H/kgaDwsTwbqVR12hWdRVHhB5ldcygCpbOatzw/GZiK+Px7Mc+PyM+dp
         DX4P3EU05Ubv+QV9J6o/vHxwn0n1OX5EfhvAUUSIM+JOnwNo2IcQNVM/9EjKruHl0LTp
         QKK6fdcYr05ar54RYi9coC4j00mc0Hb7TzRILPh6+pC1btasuIXeiN4PWHilEEsNyXz3
         jfDt/VFxJ7/SG+5cddZdMKj6lCBT9kFTtdJWp+oI8CpTAzho5/bYDJanHmlgu6hPSdHE
         d4nw==
X-Gm-Message-State: AOJu0Yx+f3pMDrKrR2ZkEHymQPCD9ooX5XDIbmGsdyI2OK6Ni2vCfb+b
	YzdlMNtKMRMPW4Y+c1l8P3mGSQBVhN19Ng6wtjTZuZkddU4rY5SxKcz/
X-Gm-Gg: ASbGnctkC+pBBTiyuIcwwPeIcr3+mH+J0kpoPfz6OkuG6JPVigcXEzXw23wBt9v2dCi
	I7cl/bhAwIIinWcftq35wgTTApbqqcylP+ACa6R3GCoO6psA2iEu+ktHdmoWM2+v4jo4c3883Ct
	MY2CdlZ9x2gBITNieK7Gm7schkL3qqvcZrJHBGbrLNITNhxTu0ah+P+b1YqKRqTFXF0bNWw4axM
	I+zVg+pERtFyCXXw4ts8Hcpop7RhcwAC8JQQ+VqmvZ455l4tdPDECN+QdH2KZ9PE8LeY4hdn8fX
	qjnM3PFf8XFPnXVhzmWChVSByZEAu3JkNj9fv0pyLYHa63o8uUFOz/ReKuzDLU5FPKRKK0K49Lk
	Ml5h4ii1mV4ySaX92UyZ7vRsADtNWWNFd
X-Google-Smtp-Source: AGHT+IGZY4HUrKfVc+tGQmZk9LoMHljYihs+CUGrYxV05piiGp78VIyWCiu6ToPrdfkJD4bC498evA==
X-Received: by 2002:a05:6000:2289:b0:3fd:eb15:772 with SMTP id ffacd0b85a97d-405c3e27483mr1668163f8f.9.1758620995187;
        Tue, 23 Sep 2025 02:49:55 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm23170124f8f.21.2025.09.23.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:49:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:55:54 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
Message-ID: <aNJuqgX9ZvULVDS4@mail.gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com>
 <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com>
 <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
 <aNGJT6IosAI7HP+B@mail.gmail.com>
 <CAADnVQJ=qN+x9vTwU=yskvwoe7vAqe=c7U6nLaKmP1u+jn0s3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ=qN+x9vTwU=yskvwoe7vAqe=c7U6nLaKmP1u+jn0s3w@mail.gmail.com>

On 25/09/22 10:57AM, Alexei Starovoitov wrote:
> On Mon, Sep 22, 2025 at 10:31 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/09/22 09:16AM, Alexei Starovoitov wrote:
> > > On Mon, Sep 22, 2025 at 3:32 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > > > > +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
> > > > > > +{
> > > > > > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > > > > > +       int i;
> > > > > > +
> > > > > > +       if (!valid_offsets(insn_array, prog))
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * There can be only one program using the map
> > > > > > +        */
> > > > > > +       mutex_lock(&insn_array->state_mutex);
> > > > > > +       if (insn_array->state != INSN_ARRAY_STATE_FREE) {
> > > > > > +               mutex_unlock(&insn_array->state_mutex);
> > > > > > +               return -EBUSY;
> > > > > > +       }
> > > > > > +       insn_array->state = INSN_ARRAY_STATE_INIT;
> > > > > > +       mutex_unlock(&insn_array->state_mutex);
> > > > >
> > > > > only verifier calls this helpers, no?
> > > > > Why all the mutexes here and below ?
> > > > > All the mutexes is a big red flag to me.
> > > > > Will stop any further comments here.
> > > >
> > > > Mutex came here from the future patch for static keys.
> > > > I will see how to rewrite this with just an atomic state.
> > >
> > > I don't follow. Who will be calling them other than the verifier?
> > > Some kfunc? I couldn't find that in the patch set.
> > > If so, add synchronization logic in the patch set that
> > > actually needs it. This one doesn't not. So don't add
> > > any mutex or atomics here.
> >
> > The usage of this map is as follows:
> >
> >   1. A user creates it and fills in the values using the map_update_element (syscall)
> >   2. Then the program is loaded
> >
> > The map <-> program is 1:1 relation, so I want to prevent users from
> >
> >   1. Updating the map after the program started loading
> >   2. Allowing two programs to use the same map (while, say, loading simultaneously)
> 
> Then the user space should freeze the map after updating and
> before loading.
> As far as 1-1 relation, we just landed exclusive map support
> that ties a map to one specific program.

AFAICS, this api is not applicable here, as it says "this map can
only be used with the program with sha256 hash X", but nothing
prevents users from loading, say, 2 same programs with the same map.

Are you ok with just this for 1:1 correspondance:

    if (atomic64_fetch_add_unless(&insn_array->used, 1, 1))
        return -EBUSY;

> This mechanism can be used or 1-1 can be established by the kernel
> internally.
> 
> > At the same time I want map to be reusable for the same program for the case
> > when the program failed to load and is reloaded with the log buffer.
> > So there should be some synchronisation mechanism.
> >
> > (In future patchset, the bpf(STATIC_KEY_UPDATE) syscall needs to execute. It
> > needs to be sure that the map was successfully loaded with the program. But
> > you're right that this doesn't make sense to leak part of this patch into this
> > patchset.)
> 
> Even when that bit will be available it won't be modifying the map.
> At best it will flip flag or bit whether the branch is nop or jmp.
> I still don't see a need for mutexes.

