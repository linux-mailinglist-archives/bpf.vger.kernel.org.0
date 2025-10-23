Return-Path: <bpf+bounces-71945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C49C02332
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AF81886296
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F23396E5;
	Thu, 23 Oct 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxse0Xx0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266A33C520
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234169; cv=none; b=nKfVh8E864NHSPkvAJCUS8LGLD5kvpw8Z2FaMIGF8Dr5OQDM1wCm/DyZ6hdf4vch8xmnNOBUlbGUl5xCdZWoOLHW234ep5APdmqQSHH0vfnTiaAJ/EvPlRXHNAtCQLj9XFQXXcor/z8StgC6gmASSwSi6lnmDFEwbKI4/Ws1Kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234169; c=relaxed/simple;
	bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL5ggHkHgnEGlCrr3rs0+rcf0wk/MizpNc3oQKJup66kVde1BJoWwH8KKZPKCs9vPbSWrqCoj7I9QSUkKbrzMV4i1iGwT1ty1FoVQ42kUkFWS+X1NOxxIQCaWPVntKPMNDgoUGsAuDsPPsGDxo71BYFRTPNs3WkgtwwwtyWEMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxse0Xx0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so5723655e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234166; x=1761838966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
        b=Qxse0Xx0vrmoBcXp2XCcSG2yRPM2k9DmsP62D609Pa1iuIsvDBSk0wdybNGsqqzCfQ
         NcQb1cnWODKUlL+W+IVNV7Dn+U/XVb+wxbeLKZHXmUzt0wkNjvvAI9grfsHhuZk5b+Lp
         rOHoHrvvrzigN9RekQwkOoNP4cmw48l7uNz10GedHzCYPqWwrEqxQTDPDobH63rovtIy
         mNj66De5famlJZlvJCtB2VObAMv1bLchIsfMHLDO2BxltRJJtDGKvPOMg+o09q61Hy6T
         pipjOIppOo6BtKWdnSB5I/1iBIbb6YgMKGEywfs/JAVLgWBkiydq+sJ9eyFTw47N//7R
         quWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234166; x=1761838966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
        b=GV61NKZRlJxvT7HfA9lS9a0nRYe7toj46QgaxyQnoml+fsLDHMAmxEOOHRvC0Dp0a8
         RPAWa+tcOxsOWARddF6gEkhSBrQT7CiXgYM9shCy0lD1LS9D1rlkDK6TcXp5waFtYDBV
         WlA0qA2RYYPgg8UDY8bjaV2Skie5H9pJa1h24/tH8O5v707jr3Imo53fOsbffC85pB64
         g/iKTBea8aNk297IcKmC2kB3mp3E/wB4k7iUgERAEkeLQK1+0zCu1lkdInv1NyH+6OON
         0BMsgNbKy/GykhAmbMHx2dtMu5zEKxrE6fOhvR8VlqohW07A5LuaxCi060wYaQcB8/Am
         huDA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHNedx2FWgAOlqQ7WteDJYpXT60IUbiy60VgWaavjXEOo6BK5+41NQKIsVpvB6df1hpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAINVInB0yRjGJ3UPmTDUuLpEIM0MBQWJ35ZZnpxWL5evFos2t
	GdXI8jiJT1uCAY+u9iy2CAWwPYq/oAN4Za/XzmjzxX2DH+K2ACJeXUEC55aYgYqG3la/s7jmO3v
	wxwBHLZIqjlnXz9BKljF22Noxs8BfwDs=
X-Gm-Gg: ASbGncsK6KtXqp0B1WPSoQUaeMylZ4GHF8+pH9K/Np/avAZ+fSln6+Jc8RpkgvbsA46
	qc+Dqcm0SDulr8JJ+P/1JLCp5Oq59eZcgxtIGTzOUR8qfOTo6hpKZcypKau7t3KnhwT1YMmlmuD
	FddPBI69U4gR5mC+n9m9NzjHSu5X5cJe/J3p3rmchNlGC3fqZ1Ys2d/kyct0emqLdAwSSDNhgr8
	4EMbrpLDDuHR7JnHY1t6Orh6jItFK8/7UiMdqn5H2JnhhYqLLwUaIGQoQ8yehlDRdHp7Kh9c7YQ
	KmcqkYWAVLVa2If6599nwQ==
X-Google-Smtp-Source: AGHT+IFhow4QI7xwSMhlDLZ5U1ipuss1H6Ff92i8GV+W07OMa+jEx3VQ4ocR2Em4KUSzfNwGqYXyynb9DW8McUjIsPI=
X-Received: by 2002:a05:600c:37c7:b0:46d:3a07:73cd with SMTP id
 5b1f17b1804b1-4711790c31emr150922395e9.23.1761234165874; Thu, 23 Oct 2025
 08:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev> <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
 <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev> <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
In-Reply-To: <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 08:42:34 -0700
X-Gm-Features: AWmQ_blQXgPilzRH5-JKjp2M5ciDOClA5vPCYZnL9G8qXyDh5BpMORYPoCvzAh8
Message-ID: <CAADnVQKNpd8SCawQbW69ALWNZMoOvxwRbBQELqzh0P52iXG=kw@mail.gmail.com>
Subject: pahole next->master. Was: [PATCH bpf-next v1] selftests/bpf: Guard
 addr_space_cast code with __BPF_FEATURE_ADDR_SPACE_CAST
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>

>
> thanks, but version 1.30 didn't work in my tests - even pahole's master b=
ranch fails, only the next branch works...
>
>
> It seems that the 'old' pahole parses some kfuncs incorrectly, for exampl=
e bpf_dynptr_slice().

Alan,

the introduction of the 'next' branch screwed up the workflow for many peop=
le.
Let's remove it and merge everything into master.
People expect master branch to be the one where active development
is happening and the source of truth for the latest features.

