Return-Path: <bpf+bounces-42039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AF99EFE1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07A71C22BDA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E91C4A1C;
	Tue, 15 Oct 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDdxwMsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38ED1C4A12
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003275; cv=none; b=Gq+pZpXD0SWvG03FdHAMirWITyBzXlC8UMpBcsusevrT4xvI820ulVc5AaG3NHf5XJECFBqfiycMMn2Jse/Ivb0QnA4NmcSGWxIJx6ya/JEVJ9F/uEs6NxsKzONROftOq6pRlX351skpXWzdMXYy6673CWLAQs3Lqkhf43+y88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003275; c=relaxed/simple;
	bh=8ow5wP/mn0ncThSfiHu3EB5HqwE9Dbay19JG2/LTK54=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=gI7XUChUwJLihI0Ze4fqOUGm2eohGNuS8Q/869QFOX7fcXjnjwVVMcKf0utn9IkoWAdTlcsIplBBAwf6l1xhxFJQZeaPUZOHl/6PR9RhC3opyjZt1OLBmSmk3kAtGAwXqQKBM1gY8uwsfEYaJd7nP1sRv7ViG/1tjP4/kyQOdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDdxwMsZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3421420e87.3
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003272; x=1729608072; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E04Wt70gCPfdrbDDBhgqtHoh8UDQrtuOQDeWeuAc9JM=;
        b=VDdxwMsZMfHAOYIKfi7VzUa7Atcl6Zz7bdZjYAqz52yWhF77dx8ZDighlMqVjEMA4S
         wgLa0BmRSjvjcoMyf5MMwQdYAEJG1l/0Eb7hW7+XL1VQDnPg5FUP3Qw5oIPZZaS6fug2
         Lgz4nof/CMzs8sAwCLgUH9+GofL4A++IfwpmtbiE9G/waTrxZZgx/+tTGNNm0sWvD0rU
         BcEU6m5sAgFI9kT75dc5LBEFGDjRVZhPJPFv6i3SSIbnj2hrflO0x0L1nUUHmbWgp5Jq
         TCR+YXkMdGKy+fZa0CSeASSX5DGsuZTHuvdGKhLOkR6WqybVQgVY8hhxgvIcfVsRF30r
         gRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003272; x=1729608072;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E04Wt70gCPfdrbDDBhgqtHoh8UDQrtuOQDeWeuAc9JM=;
        b=YkoVVFlxYbswkF77/OqYNX8/e/8oYqBJeIGsyZQljbUW1+YpBPXu/AFFx+mt4xD8to
         fYAg/oCnxV6j3EZnWcXKdK0t0wshy6NTCAQlb1Ztjp61gusQLOcXwBB05zJm5TBdvvqf
         ftGEf6mmPGN//hlHirbmGF5I3nTlbVxHDDqD2A91hzSD0TPVHKVwz7QwTAJ1YG+u78mH
         KmVz3RhldRtQqvjKbq97mOlUxIEezgMjSSveeQJjcj+yxZ2/IJ41pgl368v4vN1Dhk+6
         T2PcFNhPMA2qX5xB13kQ2Ved7J2EX2T4NS27wdvGAsPE9xzvDX1QoptRGVn2Bp0dsS5n
         Xc5Q==
X-Gm-Message-State: AOJu0Ywt7k7mpaN3AAAMLlgJvwhDDk1Gb15YE0apClQSXCk7+GB+71ut
	YM3PDMf5Iu1vlCncTq3aS1kaLYJcJ0GaypOoUcaZm1MOVFDSqaBMh3ikzw==
X-Google-Smtp-Source: AGHT+IHYdylSCF/IAMJoW3S6xSFtozxEQcyzmvfQW6NaRAreDpB3SgEvbKPHLFoyKlOfcGjcPNjTWQ==
X-Received: by 2002:a05:6512:220b:b0:539:f886:31da with SMTP id 2adb3069b0e04-53a03f826eemr483812e87.53.1729003271628;
        Tue, 15 Oct 2024 07:41:11 -0700 (PDT)
Received: from laptop ([2001:690:2100:1016:576:27d2:def3:e2df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314bf61016sm2962935e9.28.2024.10.15.07.41.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2024 07:41:11 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:41:07 +0100
From: =?utf-8?Q?Sebasti=C3=A3o_Amaro?= <sebassamaro97@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "=?utf-8?Q?bpf=40vger.kernel.org?=" <bpf@vger.kernel.org>
Message-ID: <E98EFBE1-4BBF-41DC-8EF2-E511B2695D4A@getmailspring.com>
In-Reply-To: <CAEf4BzY0cG0xCOeGZxrDqiYMw==QCJMgWHyKK6eVO4y6vM-GPQ@mail.gmail.com>
References: <CAEf4BzY0cG0xCOeGZxrDqiYMw==QCJMgWHyKK6eVO4y6vM-GPQ@mail.gmail.com>
Subject: Re: Maximum amount of uprobes and uprobe and uprobe_ret
 relation
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
Sorry for the late response, setting the rlimit worked.
Hmm, that makes sense.
Thank you for the reply=21

On Oct 1 2024, at 9:13 pm, Andrii Nakryiko <andrii.nakryiko=40gmail.com> =
wrote:

> On Thu, Sep 19, 2024 at 5:13=E2=80=AFPM Sebasti=C3=A3o Amaro
> <sebassamaro97=40gmail.com> wrote:
>> =20
>> Hi everyone=21
>> I have two questions related to user function probes:
>> =46irstly, I am trying to have a process attach more than 1024 uprobes=
,
>> however, I am getting the error: =22failed to create BP=46 link for
>> perf=5Fevent =46D 1023: -24 (Too many open files)=22 even after changi=
ng
>> ulimit -n to 4096  github issue=5B1=5D.
> =20
> See =5B0=5D, it might be that =60ulimit -n=60 isn't really changing the=
 limit
> for your process or something. To be 100% sure I'd do
> setrlimit(RLIMIT=5FNO=46ILE, ...) from inside the process to verify.
> =20
>  =5B0=5D https://unix.stackexchange.com/questions/8945/how-can-i-increa=
se-open-files-limit-for-all-processes
> =20
>> Secondly, I am running some tests with uprobe and uprobe=5Fret in mult=
iple
>> functions in the redis binary, but I am noticing that when counting th=
e
>> times the uprobes and uprobes=5Fret are called, in the end they do not=

>> match 1 to 1. Either individually (a uprobe/uprobe=5Fret in the same
>> function), or the total sum. Is this a predictable behaviour=3F
>> I am tracing several functions in such as =5B2=5D.
> =20
> Attachment is not atomic, so you might get some uprobes attached
> before corresponding uretprobe is attached, and vice versa. So counts
> might not match 1:1 during attachment and detachment.
> =20
>> =20
>> =5B1=5Dhttps://github.com/libbpf/libbpf-rs/issues/942
>> =5B2=5Dhttps://github.com/redis/redis/blob/3a3cacfefabf8ced79b44816931=
9ce49cca2bfb7/src/rdb.c=23L1782
>> =20
>> Thank you, and Best Regards,
>> Sebasti=C3=A3o Amaro
>> =20
> 

