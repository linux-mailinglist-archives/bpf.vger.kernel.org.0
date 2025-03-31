Return-Path: <bpf+bounces-54980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2521AA76C56
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D42D3AC7DF
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC5214A82;
	Mon, 31 Mar 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbcFukHe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588982147F8;
	Mon, 31 Mar 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440381; cv=none; b=SA6deBDcicZ6El8L86/BgfKQrnIACB0cB4WKbCmEiqpYzCpCa+Cp699u+kxFtZEZtUVkKkgbS8AW/F18XXZpUCUCQ0TMaYn9acI75trA4qvhBfC4iiato6lD2nXPqP4hBCz3RpR0CA3hAtcyFyJOhJNpbsCcFgAzOmoZ7jMJydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440381; c=relaxed/simple;
	bh=svhWANGn+EWtMdd+5q4QTvgsWSZF1j2OeMkBHckk+3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhx6hScrRFNjo3E2g6+l/cbcjKv3j7dESU9DuVQWKJiYTKjJqd4TUH+H+B6cGK890Nqy61CnnweIcC5w3trOAWATXVVgPp7yCTpC+D2BmCC58afvjyi4JOo2LulcWfwWcPmrEAVK0KK7/jhIFAqjACevZFbcWI0OLdIU8A+pMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbcFukHe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3443252f8f.0;
        Mon, 31 Mar 2025 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743440378; x=1744045178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svhWANGn+EWtMdd+5q4QTvgsWSZF1j2OeMkBHckk+3A=;
        b=jbcFukHeNPY9bOON7W69HlqvCBl/BnwVqQQ8CMVHuXf1+EjZBrF7V7TWihs4cIqKct
         GqUrr88CQmF3TWH6/4IAKQFz2PtCibHZ03Yxt9Px0CVPNb0wuEnbOj2o6l0PhZkvjOcZ
         Me0x9ISNdsB1um+c27COjBXyRMffX9CRYPVrdvkBTQ8VPMpWbkgcBQ/wc0gkM4KN5m3U
         udzJFUnUH8k+lIyHyoj1cj/4CCRi9L0IRvAkD5L1TSAWm+X8GtxS3RKHVoJs0AVo67Vg
         RomVV+BGLTkEMqD0lOlNVNsUS+qHv6Ul8cCmkZdc8K7XoBOqfoWHRVaBww929F+/aNe8
         jW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743440378; x=1744045178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svhWANGn+EWtMdd+5q4QTvgsWSZF1j2OeMkBHckk+3A=;
        b=KVbgcl/ti5sqo3JNwUBZ3bmh7JC0w37Gkh4FX2MQBj4Elq5O1J6G1LXjs1Pe6GPuYX
         qXBP+crPrdZ/Gt6U/FKQp/mRlIvlR4MmY4qSIbN2aAh7KVdJKFGbeZblnVB98cPDP8WM
         7uDpy60+NYvrZHnCNX0HXBLc4qp7ZiZOBFU3/tVoqPhTGnlPQk6MnycyR9vi1tJViMjU
         Oee7TqUKdC0rFSFUdOi11ddNqBlUlsdK190rImdIXzdtOFoowc7e4l6yg4pIcdezP3GF
         /WpZn2jENzcbtfvJod86e4oBaxkeSQp++/ijQ7U7io37kXm6hksGJLQJq0lEz0PbUcwp
         g7lg==
X-Forwarded-Encrypted: i=1; AJvYcCX+meyM1blNDb1zrbU9LpH323wUvIp9dOhGmBRoPt1YvqjUrLc1jqvcMe7d74cYK8mtRZU=@vger.kernel.org, AJvYcCXX+ptLPZNmOdFQkFhi8FnjCiNB1EDSHVRkRD77LcuyPKvH8vJBXC7h9haObiN2sQGOg91Kak8sIimH/rZB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zwNo8kDcTl0pnO4wX5Xx2Xw+z2TWYFRUgZryYSaiL7i69+Dg
	olXZNQvELIAt7I2NM1POMv03NzXbTx80VWM+rofDYDvkhM8JdI2VEaJ6miSx1Rgs0WhzFkAljHX
	NmSOxMBRkGrNtWOA6jgtDL4S/FUQ=
X-Gm-Gg: ASbGnctxa+yh4Jt3J4swSrXrucsALClFWkesBQ2PYDcUW5YqulmZi34S7uNzVqG3I7U
	58cAh13UKZzM5gzK+khfScotjSvC3a6bBYlZCsRDf3CMmHXz9E2E9/1wbBDn57bVKqfxBJy9BZe
	1s9S0zB3b0BkjMRxv3Kq9VLBXjPZxuYymPwf2ZvpHVqVjmTJJVjJlR
X-Google-Smtp-Source: AGHT+IE1Z17kjyZuDzVGno6zZBu7MyYqcRIK/BbsvxfL1+ydmojeQAX23y8s8yjeRBU80qs38UCvusIMb7lW9swNI8I=
X-Received: by 2002:a05:6000:1acc:b0:38f:4ffd:c757 with SMTP id
 ffacd0b85a97d-39c11b76660mr8262301f8f.2.1743440378370; Mon, 31 Mar 2025
 09:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
 <Z-p0B27EtOW_lswI@tiehlicka> <aeac0a2e-bf4a-4a73-8c64-6244978284b1@suse.cz>
In-Reply-To: <aeac0a2e-bf4a-4a73-8c64-6244978284b1@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Mar 2025 09:59:26 -0700
X-Gm-Features: AQ5f1JqKYxn7JdyLNyI45Go41PJZFzTycC5bLyXNarHY9jjsIN4SBcPCbzP-SsM
Message-ID: <CAADnVQ+26Lqt1H8Q5dkX_NDutuuWa+RO-91rmRNfcPUwtsazKg@mail.gmail.com>
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 5:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> >> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportu=
nistic page allocation")
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Makes sense. Fixes tag is probably over reaching but whatever.
>
> It's fixing 6.15-rc1 code so no possible stable implications anyway.

All true. I added the Fixes tag only because if I didn't then
somebody would question why the tag is missing :)

I often look at "Fixes:" as "Strongly-related-to:".
We might backport these patches to older kernels way before 6.15
is released, so having a documented way to strongly connect patches
is a good thing.

Thanks for the reviews everyone.

