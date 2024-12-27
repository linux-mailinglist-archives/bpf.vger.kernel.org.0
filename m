Return-Path: <bpf+bounces-47651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB09FCFB7
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D8163BBB
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F23596E;
	Fri, 27 Dec 2024 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Shg4l+ga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18E28691
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735268659; cv=none; b=IswAcrZrV6Dy6idZW/KRvwVFcQQKU7o+ay10JF6aSgUqTmTfB/R4yUfaU7VhkfQxWr5oh0C+XejVf3Z+73JsuTEYQ7nnIq0tJeERoNxEsUFw6kuMtXXbhhx+HLdjAkXqv/eF+b5sS++tFI2m0q+aePqoXiyi8tqWvLV32ZICeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735268659; c=relaxed/simple;
	bh=ThQ9KV6K3n5aFJXUeKhastYFmKYHErpU1Qq4XCFqwn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRhDIbRcI4Xq7bW8HST+gkr8aWqNRPeguhfVwcDW5PnFHZDOppRVCemEndUbpiaOh65cgOydO3UfKDjPbg0ClWUnpjBUCDa9QSf5LsfdZxhKSpAwdl0FuxYDuRzY6fhxmP8CtqEgfFBT5AgUFuCN73IyxJ2/dE6Rm1f+Ug4jwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Shg4l+ga; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso9833873a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735268655; x=1735873455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIvsaxrrzusHG3DGldZGLiyb0altyr/HFAubLTJu3hY=;
        b=Shg4l+gaZ+/wWJxahcp/U4SJF9luwgCyLbmZyq9CTAQj3mB07fBIlsWXyh/kMsubu1
         6DBVLvwq+d2m4i/Zf+xw4rOTrYmQQkMWBXh0B/0GUMJuwYPVsnkyVxRgnqV0TDysbV+W
         Iv9KcXp1ZBMWBZ7Bx3BzcH7mE1DyyeWvPYjZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735268655; x=1735873455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIvsaxrrzusHG3DGldZGLiyb0altyr/HFAubLTJu3hY=;
        b=LreD9uxZU61wNZuddliD7oiLTo51lRSqfN2yaP/Tjqz8irbwqyfEC854UGuxZvhL2I
         IuJGspHhdugchbVLZtcQznkYQlHnEGYsR2vRXJfzK05tAPkf2xq5qINO/jZ1TBlFgXEq
         e8ZloamqYUEI6Nqxv+UzuYEEFTN3fkwFH2miUL0mQMN9hjSz5rAGQxeFDfTTmmFMicR4
         1QaxWV64HjuvBUfxpEE61XIIiFeB5Nx8Nw3wzWvm5mEb6nfQlnDiwsMEibDRhbhZk7CB
         C7fgrt5fCkfKsHczZSLz8nmwlYdXd3jDHAlxeefJPu70ME96JbBTLZdvOFJJwbZBXlED
         TSDw==
X-Forwarded-Encrypted: i=1; AJvYcCXyhBXBRuPl/UJWasYkskRolncvyLUP5QdQQFRKvh44bZjmUSYLYWb7T9g+xRMtreNNhIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi58d5HTzqIhp6dNq8TpgI7MAeFJdDqM2LvzTe4NnmVQ5cxwMH
	L8OMpdzFqx3ZPpiyzk6lcdhwtqgdgL/2cDNt4TkMj2Wz32pqalYujPa4Lds7SdXrhswVvvcvLdS
	o8DA=
X-Gm-Gg: ASbGnctjycbaPLlrMNjd2vLpfLV4hRV+QtsYK2/tV3cRiDKszY8JT1aq5yx4nVCadG3
	je8o9TVsYsn3DI3UiFHEkL3k2T2XzK23VsD3aAdP2vWwfsYLSgpLiBi8Yj7OJayp5u5rnNi3YTs
	0zGXkKBJHchuszhnT9k0eQUPHs+iRSKWDuM2W+2cpyNS3UDApOVTSI30ZVg/muUY5GxQ/eWgwjP
	C8GJouY8tRYNdoUA8YWj7gfHxUBOrL1PiaxcQusejODwMyqj91tEjyNKejad1Yox76hjDR3nFAQ
	fCOBK8vKO+3NgK3v/7Nks4azbfcGXN4=
X-Google-Smtp-Source: AGHT+IHRld6wNLVIC/0++u96QKXlAOGJiSZUYHq+WMvaMywEEI1T6L5OPqeCu6QG2yEzwhMxiqO21Q==
X-Received: by 2002:a05:6402:50c6:b0:5d0:e9de:5415 with SMTP id 4fb4d7f45d1cf-5d81dd90168mr21849884a12.14.1735268655418;
        Thu, 26 Dec 2024 19:04:15 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f192sm10377968a12.35.2024.12.26.19.04.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 19:04:14 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa67333f7d2so1019471466b.0
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 19:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqfoUpbL6THBGra1yoXZ0XxpvRLLBb7h1zazgTU9Or7tCe8woqS/Hg7BCMWYYHKEAdZJI=@vger.kernel.org
X-Received: by 2002:a17:907:7f24:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-aac334f1984mr1642418266b.47.1735268653379; Thu, 26 Dec 2024
 19:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
 <20241226211935.02d34076@batman.local.home> <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
In-Reply-To: <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 19:03:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5JZ62=FFZQi2=doEOwTf4sa=cO+iAFEvnwBr0o7687w@mail.gmail.com>
Message-ID: <CAHk-=wi5JZ62=FFZQi2=doEOwTf4sa=cO+iAFEvnwBr0o7687w@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 18:52, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> So, does the kallsyms patch set from Zheng Yejian fix the issues?

[ Me goes searching ]

Oh. Instead of adding size information, it seems to add fake "hole"
entries to the kallsyms.

And I guess that works too. It does feel a bit hacky, but at least
it's integrated with the kallsyms logic.

                Linus

