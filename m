Return-Path: <bpf+bounces-41883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184499D828
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF663B20D70
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AA1D0B9B;
	Mon, 14 Oct 2024 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkD6iDOw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2771D0490;
	Mon, 14 Oct 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937645; cv=none; b=hAwF1jx79IjxeWL+uRht4ChYa/50R47GYEC8huUMhPoB9vWgG02eC7SQ9q6rC4GdeQPiJp+dCjlxZckLP0Fbot3GvslDbFgKvVc4/IO37XfN5MkznpCSXEJE8a8VOf4EKYdcUbOK7/xMap8YkXGszzDpKRghmxh/RXAFvNCDGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937645; c=relaxed/simple;
	bh=T7hR8tJ06xrBOZxmj2ZoouJ4PMBncoMUs3f9JxO7pTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkJE65HgZRwjdmhcurGRP//xD1o6Rh5a2jVaNkvp01DfisukrRhUaQsifhydQYKiwIDVfs00MgEcmhsoIDklFSWO6lmOsXCBR56o3u5QYL07YVlr4zqzbO/EuMDDXT/x6ta1p2IiD9bLmxIz+TVAoLeFY28Xe1TowG/QS30tiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkD6iDOw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso757063b3a.0;
        Mon, 14 Oct 2024 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728937643; x=1729542443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7hR8tJ06xrBOZxmj2ZoouJ4PMBncoMUs3f9JxO7pTk=;
        b=FkD6iDOwnmCyFYc41DhVMGuVK11pNPMDB8LuCWWmtKPtO3rYc6H/kjLpa14OAplFOo
         CEOTIA6TBKUtMkYbcfgEOmAOfYyyY//yLW59gSYzQN4KsQVo4d1jYYQV1+8DEFpGorti
         Qhb7k27LZ0jfxhW2189T4I+Q7U2cezo2VgXRMIaPDpOC3lMndOsrzIZIWx9fsRaGcFsn
         mKd7nMyRgL8+0GIai3rWTE+Se4jZqijJhTHzi2cd89eBEp0grD7s9wJgYV/fdd9Xbh8a
         9WeNVdEGqhd3TNrwquxQMeAQIbQFAqBPxl2TOPkSvsAAKuC6PDuOU7f3bJd81T+5VjnE
         pQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937643; x=1729542443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7hR8tJ06xrBOZxmj2ZoouJ4PMBncoMUs3f9JxO7pTk=;
        b=OBs2Sn5hJX/3ndukjg8YevntP6GIbQRtRrjzSKQQhlTi9HLdIRCRfyHFO0sQNyFdAK
         1s1VO/dzt+44CmiWDWI9zcskQYtwYpX0eToQWlNT9R4uSIkgrx0mFoC23F7eiWcyywEL
         wxwheSL5MbdjWo6Q65Z83/rwo7QYUrSG/axS9ltiC+XLxsALCsdizb4eEmqmNWkmmabB
         dJnc5mVbSAlaAwVSkdo0DBWzHJThFtK+HCUhzUFhjz3BOryAgHhPAH+xxbVOFErLcO0Y
         DHXdKYwE3dqtpzHaMDbyjGkA3TlKkFs8QZ9RbpVymRiKLAiOBg6AKsUCZ3Cn4dOC4WO+
         Qe/g==
X-Forwarded-Encrypted: i=1; AJvYcCUX5T9J6KrmjJk9MINDbRm+aAuxB4Xpk7rdZP73KKBrL6nFMgrvrReDRDuq249/rEgn0I3gX0h+NMxrJ2pt@vger.kernel.org, AJvYcCVuH5uVzFpwEJLkecg6xU6n5ZrxBF8mWWHFWNDbTs6iToc+LlvQgnO3mQg/s2WVUIaS0po=@vger.kernel.org, AJvYcCW343Jzh9g1e+TPUFm/2lr0fv3S+OWj4+I/oRpLSmKiP2BYAtFVuU8aFk1cB/4FRCmiWHslrdk10jVsbeMurEa55eaO@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCgxKT8iOKS1MBAFUAwNhfjFGVx34tdXBLfh7FeSYFJQVXV6N
	Qpnnt+HqANsSwU9Z7XLckjBUw6sl4pukcsCzW/gWEtKq2Sc5ILtbN+U88kZ8u5VeMfK8Nd3dNre
	0zuwkwxfs3/Z6pkMBsqK/YZlvS5anKQ==
X-Google-Smtp-Source: AGHT+IFwGAVjPCdEfP0TFh0THmiQ2svUymXIDU62M+8OYi04yZko9TY8AU62qmmEpn/aJdwuEt6QmxmqOdM2SpHuNKk=
X-Received: by 2002:a05:6a00:8d3:b0:71e:5a6a:94ca with SMTP id
 d2e1a72fcca58-71e5a6a9589mr10680912b3a.19.1728937643345; Mon, 14 Oct 2024
 13:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv>
In-Reply-To: <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Oct 2024 13:27:11 -0700
Message-ID: <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 10, 2024 at 01:56:41PM GMT, Andrii Nakryiko wrote:
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > Add helper functions to speculatively perform operations without
> > read-locking mmap_lock, expecting that mmap_lock will not be
> > write-locked and mm is not modified from under us.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google=
.com
>
> Looks good to me. mmap_lock_speculation_* functions could use kerneldoc
> but that can be added later.

Yep, though probably best if Suren can do that in the follow up, as he
knows all the right words to use :)

>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>

Thanks!

>

