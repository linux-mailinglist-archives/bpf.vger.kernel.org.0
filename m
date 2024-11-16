Return-Path: <bpf+bounces-45017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6C9CFFBB
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD16BB2544D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7618FC85;
	Sat, 16 Nov 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL7EY4ix"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC918B482;
	Sat, 16 Nov 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772924; cv=none; b=O/2Y9Q1eaempPeMa/6ypmB5OpS40jTN5HL7unGaMYmdEsAMH9WqVfS5NaTXgEyVlDVOhVwL7maGAG8vJrtBaApaPRtW80+VXStZ+SunCM5lKyAzAJDjPlH8bhrPDWyj6WeerqZYdr8AVEfWUeop6wCrXV7HlHw8g8LmOmB7Sphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772924; c=relaxed/simple;
	bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oyc4EqiiNGD8NZlOC17ZWuMHYi4tmVnnvneVkp0szCQrTL/Wu5O6ExZXwlrdvQyw9eZOZp1UI1KlBAQ+D/v7oAzs4ZeDdw/VnZT5x6kk5ZT+9zim8qOGlUKB+PzPxoZqn8crWNBuSio0wNleGBNPKzVvIzf8TvDnvPyF3FCLpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL7EY4ix; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3823cf963f1so153312f8f.1;
        Sat, 16 Nov 2024 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772921; x=1732377721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
        b=UL7EY4ix4lAdjh+JxPpt39KqtRToKxsVaN4k9ydY0b3w2QFbau4yGGnX71mBRa0Q+j
         5FpdzmWI6+7HLNulrOKCmrUhAlNZhohB05KaPfl/SUZ/Tn2JtTxeeBVFoe/E3viHUV1r
         kOT5YGz7hgog23onikdkHKi6nYSKPrEPvJ8+Nv8srM/L/V514vW8RvIxI8uEuW871VZ1
         pYolZkoX2RWGkZYl0aGe/vIRm5Wdhhq1d6Bwx6yMQ8XpjNc6BVr/iv+qO88J8dJ0p0XI
         4UUJZ/kHVHElCk7iKXk5Exfx2aH82Oht6elRyzVtQMmeGcKBevan7ohfrboe9DGyROz4
         v8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772921; x=1732377721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
        b=W9nCYHeoAd0bdbnFq1zHAdIPmpykl5+/+NJxc/W32EXSYGLU+Z+AtHAyCchdxGy6J0
         or7kVrqILzMVAoPfaH9Kc0vl0ObviyJ7Wvo8YqAJoU7wrS2ycLNOHLxVhGfkw/OciZTV
         6i1Q3sj94/6uK+dINtwfM6I1Xr8sdWg3ZggoiGm/0EaO3TFHJ/9ZZTMTWaIg8zgfSuKe
         Y8nJ7QR0lMoo+w5mex5GZRIoAVA0yjJSNrcvwo5lYvVI/QwgGF/n94RsItEjRQvXpjrD
         ++uNM+BIwThXCtgoW9ejTAQ/QtrKSznR2LhUBPao94j/HoN5yJkEsAjwhG5gDjZX5p+2
         by+A==
X-Forwarded-Encrypted: i=1; AJvYcCXq5X0toTyoN5Vrx1nBRW+YNFOdMRQmTRiy0+44+U+M0oBIpsdVBnHJhZyrxDQ+/fDOsh4=@vger.kernel.org, AJvYcCXr0E7Z67sElMZkOD9JHfM9zTXaqJUhKHK7ToHOwUJccbfrSIr7Yrrym4xzi8L+t2SlpsK8YJ9LyHvn3ktD@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJX0qbV4dfdHfuToqliMKvTQKkWDdZtXuc6CdFB4GF2e1iM8Z
	Fyt5ZkEQtjQpr3WRGjRrb11WyhHBLHxntM9U0OPkznwNf8T9InhHIAwx829ga5DXUt25yCvl44n
	Ky8+uCgeVDvqDvrZgQrWXJkzDs94=
X-Google-Smtp-Source: AGHT+IFQ/o+7fboa/cFjS9jNYnRv2Xn1kVPcEe2go1Tliw6ReETIuha0jykNvpXLIypVYBUW8aqD3xeOXhVojofPA0A=
X-Received: by 2002:a05:6000:4619:b0:382:1e06:fb2 with SMTP id
 ffacd0b85a97d-38225a92035mr5439250f8f.38.1731772921103; Sat, 16 Nov 2024
 08:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev> <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev> <87sersyvuc.ffs@tglx> <20241116092102.O_30pj9W@linutronix.de>
In-Reply-To: <20241116092102.O_30pj9W@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 08:01:49 -0800
Message-ID: <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	clrkwllms@kernel.org, Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:21=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> > IIRC, BPF has it's own allocator which can be used everywhere.
>
> Thomas Wei=C3=9Fschuh made something. It appears to work. Need to take a
> closer look.

Any more details?
bpf_mem_alloc is a stop gap.
As Vlastimil Babka suggested long ago:
https://lwn.net/Articles/974138/
"...next on the target list is the special allocator used by the BPF
subsystem. This allocator is intended to succeed in any calling
context, including in non-maskable interrupts (NMIs). BPF maintainer
Alexei Starovoitov is evidently in favor of this removal if SLUB is
able to handle the same use cases..."

Here is the first step:
https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail=
.com/

