Return-Path: <bpf+bounces-69262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084AB92C1B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 21:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF7D1905AD7
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD823164B4;
	Mon, 22 Sep 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnuSbsmv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AC2D739F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568636; cv=none; b=KU1bnIklWQe8PCVygwuJrQPyDISgOsvWBNsEdC+uQowSKq5aJVEl9J2F3ldTEkzCVCag+XtzDZNLnV9dsXCg6SMATL3n5OqT61yZ1asRszHKjccj8zmywhFORmP3x0KtphQRh/AViYGbkzWzwKGBCO9yVrIlXffsfK9/EY2uYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568636; c=relaxed/simple;
	bh=LvKHJW6iDa//JoIyoTM3NYfh8xhZuv6wwpmLeRi828k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy2w6Yk7A21mwmYQa2VPTd45d+rhEmNtNHRTdAOzQjT0cVAJcO4xY7GTdT6DrQIOhxVOQnG170Ky8304fdvS0palbROtmO0CIK6WgmxL5xEECcI3hqn9IIlD1DqEoMUHubOfVf90+tXdIC9JDpXDJ3Vm2Nv/E1d0p1UlVWMJbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnuSbsmv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so2957224f8f.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758568633; x=1759173433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m2XqxnGjrspvC9W/YBnJP5cm4TXFPvfZMqevIq9yP3I=;
        b=HnuSbsmvddQ5Ty5zcEr7mIhp+MtfG/XBc0Me/kL9f2PN+eT1gWvSOnS8zAB/6SeZOv
         ObtlOnuLEUG/FAUDHt/FUrdOLTkBdsuqrtQfBpyfmCUeqtO6wylbf5ihrfw6I6zDqOox
         MIudlSW7RRiZZX/oknvVvP1tqMEURy1YHQsr+ItOiAEpaqNCZJB0aZGhBpPxmzbKsdlN
         M92qFCapFA8eD0mFfDszodPt7mYLimYd4ocQvK2txDJRcPZ7mOMOIAuJ7s3TlN5pOfnv
         dwXm8SFSueGAzP+r+c1ih1M3QvAkDfOQjlz2txoCFKCmdY1oYaLQofot99CfIRFV3R2T
         Ma4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758568633; x=1759173433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2XqxnGjrspvC9W/YBnJP5cm4TXFPvfZMqevIq9yP3I=;
        b=jc2eDIX/0bJyNYfyy4c5SiMZocaD+WPSy4i+z6gsiNemyEqPj6tyd7juVZsGVjQ7JK
         zcrpLsyr4UGvUsJ/Cjdre/fZJZx/kizXaeCqVuq7tpGrjGbKEA0j2pGgRCmp8jbp+y5j
         3NDrOihJwgjRntYdrBRLOJNhfZcLsW28IJfIr7p+e074ee2iiM6ecoMSnfPx9Vv9ldVh
         +7m7WrNvmEW0kBh71txROhjvDhZZtjpusiAQumzSr5PdEPRbCO3ZQtuDBZsMLxPpMenq
         Rl2w8LDSslMCmqZTLhg4jr9Bh0To3hcXpjIqCsIupbDFXKteEkxGvzuFIkscZcffENJg
         kFTA==
X-Gm-Message-State: AOJu0YziqGz0B45WEnx+lQwYQioh2l1ch/caim3tZVG8sKXYYU9BV/rN
	DqwoRSwD2ZkyD0zNEVY4Os0JQaXcOw8Y3ycShY7wMo8W4jyd3Lq6urDi
X-Gm-Gg: ASbGnctWoO4+pk2Ekdts+Tr0y+3/l/8hpCnox8acSdQawjadSIvt2LVoEquTqJkBLPW
	Y6bphlPC9p3wvGNpajP8pDBxayb3xYZefhRe/az8WQO7m9ucL9od2IkOMbW696c+TBks8BLeG4v
	cXcDIl/O7vAdEwnAAIUyfWoEDUWOAIH3fGETgpSmMD4hVppwt2wJ8QJWG+33dkIp+1oGON/jDlo
	oWWNA0uAePi74a1CbjfosVBmAsZv3SMcT1K/YgVk17OTKLUPcFufEvohvv/gDcHHLVMBSxcYu60
	qa/ZYwQRca9PNjSNjfOrkMIyEHbYVcKhmMXy/dihIuIg6x0q7VYDLa0Lyj12HIt+eG/8baJz6PP
	HT+RzJwYM8GyOT0Z7e+Y1QMHsRw1YCjME
X-Google-Smtp-Source: AGHT+IEuSH5XJ+D5YwRlblH9T/G/7S4Wi6hWseFIOkCh9Z1IBR0gj0LclHggWLTqsWZ28JfxMrWdkA==
X-Received: by 2002:a5d:5f89:0:b0:3ee:11d1:29e5 with SMTP id ffacd0b85a97d-3ee8481fdf2mr11268989f8f.33.1758568632808;
        Mon, 22 Sep 2025 12:17:12 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f1549285c9sm13980017f8f.52.2025.09.22.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:17:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:23:14 +0000
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
Message-ID: <aNGiIgC7+t+YIM8j@mail.gmail.com>
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
> This mechanism can be used or 1-1 can be established by the kernel
> internally.

I've actually first did it via frozen, and then removed it after Andrii's
comments. Will get it back and remove all other mutexes

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

ok

