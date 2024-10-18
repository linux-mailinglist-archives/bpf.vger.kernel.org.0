Return-Path: <bpf+bounces-42467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B79A47EA
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503071C208A0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C18205AD9;
	Fri, 18 Oct 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIPYQylA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192A40862;
	Fri, 18 Oct 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283240; cv=none; b=SyyJt0yYkZBpsZNr2KbitzgBdVbC18gMnIaciWn8HygU3VgnglwWf33kds2923ntgKR1675hUJhsMbycJhv/SFJw5PL3lAzA4Poalt76bUVuKXynIRopg1wDy5D2mQvBVEGnzElinHSMpxJWp2mp7SReN0clvUbqnlzS5fkLGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283240; c=relaxed/simple;
	bh=ulJIiXuGSzjSoZr1Pfm50dn2MJ30OLcof8T4iqcw4Rw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU50E5UayGd/jUg39LkxBurItFa/cmDoI5+vKgMXAug9V1MSI8CysSxAIz5UzVvHVy5memHQd21Xt7YIoHRkgneN9w0D0SkVi5dLtDtczfwuEmKyWK6aMk5f0FsI5FrdveR5L2X4EwVqb/XFxk6t/A/jfrIYqiI7q0jb3pJixTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIPYQylA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99e3b3a411so568925066b.0;
        Fri, 18 Oct 2024 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729283236; x=1729888036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLTAIYzIokOOAJ2uN73IdFzEEOIT0hSeGnTqsPosd2E=;
        b=lIPYQylAooyq8OEr5GXJH5ZLSnr/NdVhMHb9cEqA/p4bARay89zdsgo3zSCMlvxh/D
         Yt5tI5h8LjYlt6ZzlPq2RgaRCBGcF5PfPjmVxwH37p0MBbjRews+Kk8IEvQJBnXIZwkK
         sCc9Ov9W+JutvVgnz+RSavAK6MYSr84l6Bdanp5dQgDBCU70FdRRtttH+0pn/J4+vWNw
         JbeUsRPDErxRGRi7AqMvcT0X7p3J/9wC8cGIp7SoaXPcopAlQ4USqHvkfdqiMVM5/WN2
         25ZJhoOLVqBaSJtu9nB5bZuN4reywlY+WMaV6FQ6jKHNPB2dyj7Yy60DqH2Fy+DkCyLj
         gvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283236; x=1729888036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLTAIYzIokOOAJ2uN73IdFzEEOIT0hSeGnTqsPosd2E=;
        b=tiPI6SZo2UOErUugM3NDh4MVMEKR9SpTnSZEnDcGE3LoozKlCod/HMaBq95dxJEDc4
         gTJyRHsXdHHhHd+YyKik/vtkKtVEIJ5PDdSyr3p8a5HEonbckSXbAQvfYtRPnM3YOHqS
         CNj5ZlDH9WIZjChynH/31IEbBBxukO95iRX1mOoVV5b+lMqavzu3rojLgJTe5EwUyN4j
         ODVDKvFsBkSDdXXQ91aAeYbqaZONsorhpeOpyAMJUSkJqn44EoOGVhyJDv2SO/ii4vF9
         9oAyC6TjjX7umDOePgx7NwzNWDR5voNj9p/XVB4JExCCqLlwtrtgIWmZR/6rV2XY9w+L
         VmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVikEVgPxKLwpfwBXNlGiosbDwBfuYFGXC4FpxMTDrcjCfSm2NYEmeUIIrWklV4dZncKYE=@vger.kernel.org, AJvYcCXR0alV6yIGEuZrtG+1Rh13a9oFmrnQftB4EtPn1N+MRLitY82BKPezsCY78Wh4V5zhOCkIaOidzCQ90DD2cDM7TzT3@vger.kernel.org, AJvYcCXiCPZ+00NhX9ruAuCKZxrq3mj+5AW+QiI8JlsXWzGZXPHpq0c11FZ5I0zxyKT8xfh4qvYgPS//PKYwdHPV@vger.kernel.org, AJvYcCXxpx7ObrTDN84j5R7VcdaKw0MXnfMzO303zkJIqcWv3z8FcVwJCXqkrpNN80gZQHj2QUP+2aD5QgSWEDBLobMtFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7A++IJaAWQYx+5Cb604gkiK9i1aG0YmKg80iMBfGukct06uhk
	oYzEQx2tbvJefH8tVVE362ex5fbGKLtbBUzh35iJFi1flzEuUJIs
X-Google-Smtp-Source: AGHT+IGdjHTDDVglci63fyGhCtXzlJjrBgte9bk2LEaTfmxkDaZ0bOYrQyR9lSMlajWpF+CnUSa9iw==
X-Received: by 2002:a17:907:8004:b0:a9a:6c41:50c0 with SMTP id a640c23a62f3a-a9a6c4152aemr236981066b.26.1729283236080;
        Fri, 18 Oct 2024 13:27:16 -0700 (PDT)
Received: from krava (85-193-35-5.rib.o2.cz. [85.193.35.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e83dsm136174066b.38.2024.10.18.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:27:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 18 Oct 2024 22:27:12 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: The state of uprobes work and logistics
Message-ID: <ZxLEoPQXiNT-MCdt@krava>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <20241018073628.GC17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018073628.GC17263@noisy.programming.kicks-ass.net>

On Fri, Oct 18, 2024 at 09:36:28AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:
> 
> >   - Jiri Olsa's uprobe "session" support ([5]). This is less
> > performance focused, but important functionality by itself. But I'm
> > calling this out here because the first two patches are pure uprobe
> > internal changes, and I believe they should go into tip/perf/core to
> > avoid conflicts with the rest of pending uprobe changes.
> > 
> > Peter, do you mind applying those two and creating a stable tag for
> > bpf-next to pull? We'll apply the rest of Jiri's series to
> > bpf-next/master.
> 
> >   [5] https://lore.kernel.org/bpf/20241015091050.3731669-1-jolsa@kernel.org/
> 
> I don't actually appear to have these.. Jiri, can you bounce them my
> way or resend?

sorry about that, I split the uprobe perf/core changes and reposted [1]

thanks,
jirka


[1] https://lore.kernel.org/bpf/20241018202252.693462-1-jolsa@kernel.org/T/#ma43c549c4bf684ca1b17fa638aa5e7cbb46893e9

