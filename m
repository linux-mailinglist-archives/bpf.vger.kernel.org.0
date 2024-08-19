Return-Path: <bpf+bounces-37540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143129574B2
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6843B21704
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D61DD39E;
	Mon, 19 Aug 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFcbSndd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA11DD382
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096729; cv=none; b=duw9VRpg7jZ8y5iUEwb/uA1mvsA/wAgJdY2HuXQV51CzERN1nave6Qvw9tOnyU42oK+x2sXaD9NKuWgxGSnfgoMFerwwX6rE0CzdHvtj7qtX59GdFm1URnpBZoJ9Xm+RRpFr9K5qcs7Ilivntv4Wz/RFK18vJzK6MX+mKWpHEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096729; c=relaxed/simple;
	bh=fbXlU6TG9gCDk8nilGxMnsoFHdjQKX8TJfsvRWN5g0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rj0G6fA0MmniVLYSjg2QtP/RZLywmV2r8kANChMEa6IeeXwkGBruCuW9o7o6iq9p6NTrk4Q6GY9waksDCaeI7cOoB5o1wdVVo/NOAkg1UzrUwIAyArHQ4qCJ4reb3XMj3wTf2SIZnuGDd32N/Efa0X51S6QU+MmCJxwrVkUb1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFcbSndd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-713eeb4e4bcso1274139b3a.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724096727; x=1724701527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=te/ndpC8zPT5qJZLJDjHBWvAsuVTBu1S9VaR9uPMijk=;
        b=DFcbSnddZQ53KrytxTh+OTTaCTfWsUh3PLYOQB/bpFEtq2si/fJOIbG5LTKUU8iM7X
         KmgJxM37/Q2sdIbcQbEiLCDUMmCSPEz8RE1uHEUPtPUqi/f3dfL4wGOGynerxfO2DsQG
         vtg2JtVAQf5QcsP1pV+8bL+bTEhlm82yEmW4kPWLCoK6gVruvHs7PEnsO0JmQKr+M8yM
         drvI7v035onGGKpDGCEVIhRlg8D/8noeRhRJB0deYnUIbPMoe5cJDtGuf/Y5xBvCbKpi
         DKhGFLff6xBDzRBBCGqzU1hRdwunxkVuo2DfoYuM7Z/R4mxtO/x/UiVpcbANlW7L3MsF
         fdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096727; x=1724701527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te/ndpC8zPT5qJZLJDjHBWvAsuVTBu1S9VaR9uPMijk=;
        b=se3567MErfJVHmDwHRnQnIWN5Vb0MoywglobLCCQrcdfRnfO714Qnt7+yZ4OAcjLb7
         /F9DRgX3hcXegYamF66LiFKR0RM2+kTtNFYcWrgdSDA46zVfwuHYHlFQfdYGE8PzV7uN
         EIDBAH7ypVlyHUzW+xaG6bXWfFjdsSnNzt9y7DiMD/oe1I5XOq9scfe5QIbQCjsqAtXU
         Kq2OKgde+hQ2GzQqKwroyJzhIZpqwAjRDhQLM1WCdKY9Z4EABoa4ztX4Qa22XZ02C9J/
         /LDy6mE4/YbVvicruHdbJfcjaHEwo40NTanC0VtpSrfIFgI7jpUW2tXfUwjXhnarYMHr
         k1uw==
X-Gm-Message-State: AOJu0YwJLzIGZDHe+vDchwkR8MCOCBm17Df7NzBmu7mz3jIz9Rv2X7a8
	e54QAVA0kFBBsMhEVz1dCaapT7xQ3oK30Gj3/0JrIY/acugQIcxKzB7l1QeQ
X-Google-Smtp-Source: AGHT+IGcq2av8OJTwJNqBJZmCv1JNTflusiRR7dUO2ZvksgvGgjG2XzD9AxO90x7YrU2u/dFJgTXDQ==
X-Received: by 2002:a05:6a00:949a:b0:710:da27:f176 with SMTP id d2e1a72fcca58-713c4e371cbmr12618202b3a.12.1724096726856;
        Mon, 19 Aug 2024 12:45:26 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1888esm7177082b3a.149.2024.08.19.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:45:25 -0700 (PDT)
Message-ID: <f1b9590c9aae4bc8fdc3a23abf4bf96525d881ac.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Mon, 19 Aug 2024 12:45:20 -0700
In-Reply-To: <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-3-eddyz87@gmail.com>
	 <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:06 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
> >         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
> >  endif
> >=20
> > +$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS +=3D $$($(TRUNNER_BASE_NAME)-LDLIB=
S)
> > +$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $$($(TRUNNER_BASE_NAME)-LDFL=
AGS)
>=20
> is there any reason why you need to have this blah-LDFLAGS convention
> and then applying that with extra pass, instead of just writing
>=20
> $(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $(LLVM_LDFLAGS)
>=20
> I'm not sure I understand the need for extra logical hops to do this

Sorry, I missed this detail on Thursday.
The $$($(TRUNNER_BASE_NAME)-LDLIBS) thing is needed to avoid linking
LLVM dependencies for test_maps. Still, I can remove it if you think
this does not matter.

> > +
> >  # some X.test.o files have runtime dependencies on Y.bpf.o files
> >  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
> >=20
> > @@ -636,7 +681,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)  =
                 \
> >                              $(TRUNNER_BPFTOOL)                        =
 \
> >                              | $(TRUNNER_BINARY)-extras
> >         $$(call msg,BINARY,,$$@)
> > -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > +       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFL=
AGS) -o $$@
> >         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$=
@
> >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bp=
ftool \
> >                    $(OUTPUT)/$(if $2,$2/)bpftool

[...]


