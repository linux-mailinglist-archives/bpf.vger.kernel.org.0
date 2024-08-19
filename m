Return-Path: <bpf+bounces-37546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F9957654
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 23:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF7E1C23A09
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F51591E8;
	Mon, 19 Aug 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I38PCLAF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30092C18C
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101519; cv=none; b=gROOHczHa56UtDiOx0yKNYgTjzRL6BYXMQlBJMqGVq3LC8NGbAKhmdDTtxDWhGUtuzPNaIn6iAYbYZhvsPISrXcKL8S7mPX69P098eOV0Xmv65tBcTwF4dv5CQvE17HEWtGwK7BS/H6arUjvb/Yvg2Df530K5aZql2hEALFVSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101519; c=relaxed/simple;
	bh=tDtTndB8XbZsJoQ0GArymifVR67+tD7sLWcgBoAVeqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueQJVMxfGBiPp9Eq/1ije3eRfyuDpXurQ/Je15eP8pnxvXBJdjtT48SNdT7QRZeoyjL1beYPXc0tKFaslNnV0Nc50v1PL2VI64ZTqkZCoFwFGu4ITEk/mcdm6An2nNZMZ2PKs9nofek++7IYMPItQiY64c+RWBcIi+uXXAJJIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I38PCLAF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201ed196debso37610065ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724101517; x=1724706317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8sfGIHnoCrv7gRGYWfskQGNLwCg0wV/qMS5wUyjTGs=;
        b=I38PCLAFou/CikDnj9S53PXbT5b6aQz5pN8kQ3Ky3vY/PCjluKBVWDoMLdwQjfn0dY
         9hdeEZ25NqqmFy/LEeP7LYkiiiKOOuDpQK6WzzBrs2FJ4JW/9E2WiwwXDZSYUBtNGyOZ
         yJ+EKO0X84ij6ezIeL3iAEvNWx8rGU4HOYf3jecUqly48KYb+H5jjWHsfekvYfXC8UQa
         3Ko4puteVpIpDD05GqRfyRlh6iRNl2Hgn4uuIMOm96eHom+xrbPWihN9leNyxpUdDXlg
         KCFglaqWiaTn9ElAbE53mGUH9IxWmXBOzPKQGsCnba3vcQUnTyuJyiFU8xd9Moy5pXHa
         kjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101517; x=1724706317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8sfGIHnoCrv7gRGYWfskQGNLwCg0wV/qMS5wUyjTGs=;
        b=JwTjdYQJZnnXJhwRHnZH9O0hvvMPOuSmtrcNC22kwludvBR4N1LLVl0MSOR9g0CEvz
         GfGy2sFx+nm5dlTm4e8W3sKV4xlJpQDMCPuRifuqDBcB3+cpv8xP0QM0ElbiEw0eTTPw
         Am4J1VaZSpgUVV42gkU6XiFxsvlDv3j9O3h6M6viFgHn9Qn/iN5Qbxlxhg+WLDOLCCLX
         ShG914a2E8sp37v+ieNdBOllfzXQvf0JKpvz9FWI3LOibcp3UaGkiXRLBGJEhrNcceJf
         0rWzlFXa1SJDfP3aYggtKRJ1F4MQk7tp0/Rd4Q1mIgl5yanIxYNAOOdrnQvkbCYQAMlB
         ezDg==
X-Gm-Message-State: AOJu0YwYtKIfv1k61zMEOU1LASJUI7f9Qi23c0iSJ6CmY5NRCyCnMw0L
	bLBqdLL6jITtfd5IRVQn7Y2zEFjtHlhC68Sk4Luarhqos5nI5olm/8+yoUMLyrttjCe+orCUuVm
	eqsP6QNwnj2sBXWYAIkPuDpAutOo=
X-Google-Smtp-Source: AGHT+IHx1UZOCgu9TsVlqilWvokw5yj0xxACAZeiSWHeQis7UbhRloHbPtA4o9DK36THgD5dFlDNkyszZyv59QsPGVE=
X-Received: by 2002:a17:90a:ce11:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2d3dfc29dabmr11552791a91.1.1724101517058; Mon, 19 Aug 2024
 14:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-3-eddyz87@gmail.com>
 <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com> <f1b9590c9aae4bc8fdc3a23abf4bf96525d881ac.camel@gmail.com>
In-Reply-To: <f1b9590c9aae4bc8fdc3a23abf4bf96525d881ac.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 14:05:05 -0700
Message-ID: <CAEf4BzY3_5Mwqu-KQY3gf0V6E7VMszXqPy8fk7=6B+ndKgJ1eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
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
> Sorry, I missed this detail on Thursday.
> The $$($(TRUNNER_BASE_NAME)-LDLIBS) thing is needed to avoid linking
> LLVM dependencies for test_maps. Still, I can remove it if you think
> this does not matter.
>

I don't think it does, let's keep it simple.

> > > +
> > >  # some X.test.o files have runtime dependencies on Y.bpf.o files
> > >  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
> > >
> > > @@ -636,7 +681,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)=
                   \
> > >                              $(TRUNNER_BPFTOOL)                      =
   \
> > >                              | $(TRUNNER_BINARY)-extras
> > >         $$(call msg,BINARY,,$$@)
> > > -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$=
@
> > > +       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LD=
FLAGS) -o $$@
> > >         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o =
$$@
> > >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)=
bpftool \
> > >                    $(OUTPUT)/$(if $2,$2/)bpftool
>
> [...]
>

