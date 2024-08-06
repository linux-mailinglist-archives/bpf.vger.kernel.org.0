Return-Path: <bpf+bounces-36442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0B9487D9
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 05:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D08284DC3
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2116BFC7;
	Tue,  6 Aug 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vt6hGsg8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF558ABC
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913813; cv=none; b=mkWP28NRZo+AvRpx/IESEkkX6Xzln5DielhptRa0ZCRXsx+ZNtHbbhQRABP4JiDMsAKqBegpLjTkW73eHkVWIAZHP/n2I1SIsktoVn6fVGR18QodxomN6/TCS9X56wCz8UYKdkf97JPqfiq18MQMoYFOWdBkomlgcNoQ551Gedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913813; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/yfMsE+UMnAWCrdJtGTrxHIGok8gijREnxQhmivWym+ZihF1VbeDaI6nY35R0wd2WP6NLbPx7Svh9uNC4+N+Y3MpEJik/XQy1gadI1gIPqev4vyrTY/OPoEW7iQpS72aM27eGZQlQoQSTitX7vpTdGRpyxdWzLdPs79pJ0Rtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vt6hGsg8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f024f468bso95777e87.1
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913810; x=1723518610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=Vt6hGsg8tkeVi0W2Xbo+GM0jM3j+HYRG6Rox3/TRTDwNVT7wkm0brw7CzdCMhxmcsN
         MmuzchUm9+i9yxsf5mvvEzdvyi5lHBRu2duGKq+cLF3CTfXvpcKJZZ80UApX+EByeqc8
         eR7SUZtjdP4hZ7kCBKuGIb3jVFoeyp+g92EiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913810; x=1723518610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=mR5hLXDKEX3528RdpLVaRAe5kBgZkVu0C8xBRy+0d/Uv/0WRd/cMyB0ZnwwiO01nFp
         h6j6ueHrhJzPXoIgr3dHioieGO1fF3w0PKX8r0PowGgmOVi8dD5KI2dxu4Pm4urYbEHo
         YUGHZaKBU8xwKaUTpKmKX22eZXDw5hODurDvvuezoLDEeFZ070N4qkUGZu74/WCJEiVU
         GN3blN/fW+piWGfweeCI7Q2KdQcuBo2r0xH0AFbht4Bis/iJKh+cAyrjMNbwt9f1OSsS
         QxgBmvmcry2uWbP/QmZZFW/ouumNtX4wZ4Vo+l1Y/hEviDMT9qA21Y/0W3zp6H4ZL9la
         z4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjyAX6w+e3fP67ljcDT2vXcez2+ek/Lja/OXVYa8WbZV+Z2an9W7VW13x8ysDO8f4ytgAy8iy7P2F/K/LljZaCdd3+
X-Gm-Message-State: AOJu0YwpBoBAVWBFpspzXcYavGltR3XOwk/UZJTHNqouEYsXVwkR+kBf
	0SPSOpcLIUSWuo0WWABwy+F0GLVPUzn18IIbcnE4zRXll9cGJFRObUsxMSUn5x6BLDybajcSai9
	0ei9iWA==
X-Google-Smtp-Source: AGHT+IFxk0CWK20NEnCJIAnD1HpTAf7D5IBVXCNn10GuUU30jz4poaRR4vapTiysJO80Bd0wjNS9kw==
X-Received: by 2002:a05:6512:3105:b0:530:c323:46a8 with SMTP id 2adb3069b0e04-530c32346e8mr5145300e87.23.1722913809797;
        Mon, 05 Aug 2024 20:10:09 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42825sm511574166b.123.2024.08.05.20.10.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso5295166b.0
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW3X0KUQEVQIeMIEEszpcLlA0At5zqx2bpb3ucBU3h6vKdVPqrvZrGddtxksUMTtOST0bLHbYImrnRCCY7SEB2ElgO
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus

