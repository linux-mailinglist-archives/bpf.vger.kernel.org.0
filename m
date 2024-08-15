Return-Path: <bpf+bounces-37316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC16953D1F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FA22874E0
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561114A639;
	Thu, 15 Aug 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UigrvZgE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7237703
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759478; cv=none; b=PoOR7o3uZMnLWXRhL4D0cpAq8p7qal4gdZuLOahv60Id2+wSaMXMjsrceoIocmQVRC3hayuWKZe/B1alaNDo/wvdf1Goure2lJ4CQp2wsVrEZVF7xsp0jYY9sCWKGE3Wv4WXUgoZggmi7Mswgh5T2syYkRrgAEVJXOV3A1ldK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759478; c=relaxed/simple;
	bh=mUGGYKV6WImkLyo9NLjiPsvjw3N1aj+6L/5OZ0xAZgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q97Pd7Xn5qYv9/R0IN+yysAO0C1gUxFPQJYgs9oGefmGJpzdrQYOFYkHSaNxIu417OuTAqfOggq8hEHHJUpqKSNpWAfCD+PnjjSENi0aQ7BPY4sGNeDqkshwZggXI8qYsq7vvhd4fCgDiuzldhMb4tVQ41lzI0x4ykkwhKvyryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UigrvZgE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1076157a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759476; x=1724364276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X315hqtUKxBbZ1gph054pwnJ67rbJuGprADhFxWXqM=;
        b=UigrvZgE6x3eX1mEgv73hNvohLCmRBT/57HZCn8X83KKcvst2NxUyL/G1inWt85OtW
         SZBbEY4q6gR/u8+TVrSdsgDXvqzZllBn1zN3AtPF9YScTA99JV/5GtpwRi9vk9ZoRtBK
         c0Cenh3mBQFSGFn7uLchQFiKn1GYYjNCbOGPH2U/YvZxvWfcpBgsPXC2Yk7tgcuUxPp5
         4nglFrEissAgPHlEGU+o73s+0Y+L4ucjhC1WKhe4tucAQXqQQJXu07grMjTj+RLlLfLX
         p92QPL4H4AYG4pQLNQW/hlZi8BF8Ft9basUdAG+HlYk7B5OYSQJ6CPorj0ApM0wP6DsW
         yZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759476; x=1724364276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X315hqtUKxBbZ1gph054pwnJ67rbJuGprADhFxWXqM=;
        b=t9fxLhr/tWgS8QIiLxoSFaGRBhqGSdej9yj9e1vLNuV77R7ATf/HbIjs6uG9dqHkmn
         8FxjGTWsWEEQ6RlK2rha8el4idZtm8pQLzplTB/oItJ0vunfwreUQWbLVDbPDXGiW2j9
         SQEOUsnR1o1bhGcsyGmRNJXfkxFv4/Xo8ge+ecMSOn3gHKp7po4GZQb9YWevxkBDWQus
         ud7hfRX6v7W6ByVDc4GVNJshZHPaB5gfXZU8Pwq5DmJozanCmz42tdRui2PcEzj0Z9fE
         hZ7nuNeRHo8TMCKXmcXLLRd9gHAfj5V6Qr2lzgbQPqRrLT5mi6gLgrqMjkxaUgE/BngS
         e7Xg==
X-Gm-Message-State: AOJu0YxvXdJHOp86GNGLi+VKiVkDcpBK4HP4F2JNqN+wL0mMloEIFbpS
	1WNY2+aVbmMPAywF7o00YAQ8YZL4KuSDDOOnUbhdOJknJTICaQ7F1BgpWUhjWI7w9btuKPf/kaL
	wCrLTlVU6933+kzkn1EihZuYgb5U=
X-Google-Smtp-Source: AGHT+IHfFnGU0DGtoIW7FaL7wbVj/loKKQ6RtnvyiJFOmozcTWAv7H15TAnGKewfKsj/lAUTJKXTc14okOGoQLuPK8o=
X-Received: by 2002:a17:90a:134d:b0:2cf:c2da:771d with SMTP id
 98e67ed59e1d1-2d3dfc88359mr1281650a91.25.1723759475882; Thu, 15 Aug 2024
 15:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-3-eddyz87@gmail.com>
 <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com> <875815624e852e09f926696175ffd6eb6fe1cbf3.camel@gmail.com>
In-Reply-To: <875815624e852e09f926696175ffd6eb6fe1cbf3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:04:23 -0700
Message-ID: <CAEf4BzbLHjkhZOaHwLWo0Vf9pJjGCAq_LFo17HobPwW9D4qUfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 14:06 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
> > >         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
> > >  endif
> > >
> > > +$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS +=3D $$($(TRUNNER_BASE_NAME)-LDL=
IBS)
> > > +$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $$($(TRUNNER_BASE_NAME)-LD=
FLAGS)
> >
> > is there any reason why you need to have this blah-LDFLAGS convention
> > and then applying that with extra pass, instead of just writing
> >
> > $(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $(LLVM_LDFLAGS)
> >
> > I'm not sure I understand the need for extra logical hops to do this
>
> No real reason, that's how it is organized in bpftool makefile,
> monkey see, monkey do. Will combine to have single LDFLAGS change.

I think such an approach makes sense for Linux kernel where there is a
Kbuild system of conventions and you mostly don't write real Makefile
statements (just declaratively specifying a few bits here and there).
But that's not the case for BPF selftests (and not for bpftool, but
that's a separate discussion), so extra hops just make everything
harder to follow, IMO.

>
> [...]
>

