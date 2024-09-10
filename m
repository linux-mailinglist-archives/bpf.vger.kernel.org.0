Return-Path: <bpf+bounces-39507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A897416D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D7D2888FF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B91A4AD7;
	Tue, 10 Sep 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsGSQcVD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A81A2C0D;
	Tue, 10 Sep 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991138; cv=none; b=uT75TMCcI4fFGQbPwXypGtnFA82WT9TpgLYuDlNSS0DJFjD8RY2bWbK4FjIsRMV5NbxpoCXM9dgKvLOe0TB17Xwy9CUBSeM2AN6r6KH20dHKfoIhx6psHtA/hbPY6dSF1wMHhiDCimI1M5YF/ve7yM1xbYUKk+F9F77fbO6TCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991138; c=relaxed/simple;
	bh=GjEfxluKTJVRF/DjHSV9HalaftsH0waQ1mRxQ+bwGd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3sL5gigCQYEM2Cpqrb00/LVFO2IQ02KFchfJaL+oIFG1K9OdJSQHN8O6vp0DgKGbm0jA5qtgBSym4J9j1p1bPNYCUDKlkgjQCAOaee5ZcCnGE3w+Cfm3j6wh/smDgXLqSb7+LoVbVdukhxOqOH0xAfXNagCFWJQM6JmOUlFn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsGSQcVD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd967d8234so3810025a12.2;
        Tue, 10 Sep 2024 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725991136; x=1726595936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjEfxluKTJVRF/DjHSV9HalaftsH0waQ1mRxQ+bwGd0=;
        b=TsGSQcVDPplNK0k5HdvIQ1V9vq/8iHqVp1MRFIrwlO8iKL0MmUM6XQPqhVf5T47m+a
         Aj2gOu1sIHQwXABQhTB3Jwe0S9mZhMvHwBP+GKc79jbqsOOW4sfm/Gf/PTukasbCNQe4
         RqD2E8P9oPfoIaLe/SvBaxXksDwyFgc8dO3FwMEonTo9HdDrUaU+El+cqPyowVu6UUIa
         GipXqnnftZc03ibi8YOmhtmGIDeeKv95uKoft8LyQ+kwJgHE7K8J7457dOuiOvUMmvfw
         jrH7wYnRJ+xCcJr9hF9bAwxgWrouB8i9MrjfbwaSgiczXMxa/fOOxgPR1p+iGUfKVFd8
         Ydsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725991136; x=1726595936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjEfxluKTJVRF/DjHSV9HalaftsH0waQ1mRxQ+bwGd0=;
        b=CipgBw0P4UB1oeOZMpwz2174eukJ8YqAdqNSMY7MBtTpI6tFloM5E20jLdUXmrRisr
         +T+8d9ukwM6PPBeMtt5ZaxNcdVa+BopklMrVGtwGnvHEcZlMYlwjTluDC3dNLrTzivWp
         fl44Wbu0mNT9isxjVkmMjN+NImoR/f/2yDuSqH/O8xZNzNj0G9CpHQDjxUrLghBmtD9y
         Hiu3U+Ay6B9Q+qFFHkieiyT74AnK53Ve1PdjiAS/HUAzK0TCtO+EN00YLxmJKm2WBGPC
         /ZL+1LK3XUO9w1KlAzNqAVzSTop9TXjMfeiaZg4LUHCYcHjMr+cfC8ubJi/C5oqwy06C
         bgRg==
X-Forwarded-Encrypted: i=1; AJvYcCVRwi8kWFKD0Pzoni/Tyt62a0GUUN3ZnKkEi+bGSsuZvri4VKGa+VODpYjiWAoe/ssGIaKWnoaasrkhDLD8Bl9591Ks@vger.kernel.org, AJvYcCWn1xvtN3iHY9u8/VFvS9cWNTc9NUmy+NAgftZLXk8JJVuU21MDy/wn9DAiV4X7kxRhOnQ=@vger.kernel.org, AJvYcCXA6Q93YY0JNg+Qac76WAAXlNe/5s+TF0BLSoPFwlemraK5QNp7RbJ7G//MH5wO334smQSw7umsUicH5PAO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0BFwKNP/XjxTdKo8i3vDEq+3MwiW6TLDpDWost8x7cYBrFk0
	aHmRdXvK0JUO4PzQhYgsAQhTKw/SaHBq8mgIu7zsjYqXNioJ0lBgVz52tCFbpWyNIVM6N4kKkOs
	LfyelbouAOGBmIE6IBOui/07MEeg=
X-Google-Smtp-Source: AGHT+IFNXrrVPS1asK6Ez1I46sSg3pMZ8OK2Mpk2mTEoVt5umC/wSIE0wWN0Ozv5MLC/PZQn/zRdVhrtnobU1pfO/ig=
X-Received: by 2002:a05:6a20:e68e:b0:1cc:e14b:cf3b with SMTP id
 adf61e73a8af0-1cf5e0f65d9mr1617076637.27.1725991136326; Tue, 10 Sep 2024
 10:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
In-Reply-To: <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 10:58:44 -0700
Message-ID: <CAEf4BzazZSUtJ9vPd6Xj4539MCebctOZJmO7xmdUhoQiv5mBFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:06=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> > Implement speculative (lockless) resolution of VMA to inode to uprobe,
> > bypassing the need to take mmap_lock for reads, if possible. Patch #1 b=
y Suren
> > adds mm_struct helpers that help detect whether mm_struct were changed,=
 which
> > is used by uprobe logic to validate that speculative results can be tru=
sted
> > after all the lookup logic results in a valid uprobe instance.
>
> Random thought: It would be nice if you could skip the MM stuff
> entirely and instead go through the GUP-fast path, but I guess going
> from a uprobe-created anon page to the corresponding uprobe is hard...
> but maybe if you used the anon_vma pointer as a lookup key to find the
> uprobe, it could work? Though then you'd need hooks in the anon_vma
> code... maybe not such a great idea.

So I'm not crystal clear on all the details here, so maybe you can
elaborate a bit. But keep in mind that a) there could be multiple
uprobes within a single user page, so lookup has to take at least
offset within the page into account somehow. But also b) single uprobe
can be installed in many independent anon VMAs across many processes.
So anon vma itself can't be part of the key.

Though maybe we could have left some sort of "cookie" stashed
somewhere to help with lookup. But then again, multiple uprobes per
page.

It does feel like lockless VMA to inode resolution would be a cleaner
solution, let's see if we can get there somehow.

