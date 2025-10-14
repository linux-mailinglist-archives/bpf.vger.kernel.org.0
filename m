Return-Path: <bpf+bounces-70926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C0BDB552
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0804EC1DA
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9F30B51E;
	Tue, 14 Oct 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbsnma8/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F683074AC
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475201; cv=none; b=Di8Ikct1y3c+1IkdwltQEl8mjVqdOetCGNc4AkSSzHQylzV/UNKJwptYgTAcs62kHyxlqEAIs/TrSia5ZKPKd0rrzlCRodsPLf75+qHQ6w5F/esTwFJZimyyc/wrgzQnCO2Zsf3G5BqlsQw4/QN8tvJHz/m7BZd+PiK1g89hpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475201; c=relaxed/simple;
	bh=tlqXJrR5QFFSL3+AFtql2iNs/YSJc0yU7mIXICuEH2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hopllUoROj8jVqoiisxyvBmGtd2xi6xNFFijbNWErP0oV+1mmpcMApKYD5ptKAbVglN3op1mhukBneX+7fjvF3Pvow638l8W2TtzvH5PbewV+80CE2ESXAqYLCVs93i4vl2hfYprpZ9HsMeoPqS60pUYQ33FFVgnrfR1Pm4Pvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbsnma8/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso237442f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760475198; x=1761079998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JFsuSiVOqgbcHX6dcWl4uWddnz/5FUG4MhwGgmr6aU=;
        b=nbsnma8/1efuwyCLVGfWFlTt7jH0txEij2y6VMFjkpmhVJGo4tTliSUtx94DWn+XYm
         NVHl83HWsQaqrOxub0SJMXKQGwQiGXSlWUQ4o/Fnlt2fADShdvylvthBF6PziIXZtvBC
         nXWcl+5WpD9oRw/f7KxCeJ/haSvwlD7qQew4AAC1XPgiFJRFlU+dse+2Bzq4rjVQvvrD
         B10CuvS7YBfg0ahTdOZwLumLZwtB6XfQ7T4U2IMUdCqEdg3wnXZvVXvwzrYNoBwsjp0Z
         np3tKgAiS0XD/OYwVLZFLO+X1mgv2gdrUYUrTb2E7WEWyoSgQPWuxT2Otd3aHkIUsqN6
         2aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475198; x=1761079998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JFsuSiVOqgbcHX6dcWl4uWddnz/5FUG4MhwGgmr6aU=;
        b=vhp1uAKvR03WtZ/e3+u/vRF6uqlXgE8MFKek8CRcnIWSrNS1hgl25BggPNHDc3Nzqt
         gbopiutAD2Ww80AcZuzAhTvj/wOFsBKamlHOOokUrxQ/99/cWu2nnON0Ol62GGfF3HgX
         +gZzzLy4A0IEYHvcVtOS/QK3EExdK3fzTvqM8zQA9y0G55h+d2Xi0sarKrE5QLIHQLP4
         gUBqmGelONtjQiPR/ce1Wnku3z9CYAmTjPHuipS7H3bpMgHjhtujdWgyHP6XmIqTjTSw
         22tans8xSZpaIYJTzm+CxKN8Vm45/YnzncamVcFuEwUBQcvuK8ffxS1iSlFXesySVnWy
         HR4A==
X-Forwarded-Encrypted: i=1; AJvYcCX96JWzNlYUBDgGYgHv7IxKlugEKQDCQTzZQx/lUWabWb2QskK7PYtq/QeL6J6hdmyOj5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWz3BbfeWky6/UZBIsKDxnAeVzZahGLHzTzdS3spM8Ls2eMB5
	NI0qZqvXfDs3QbeTRP39goanjFZ592dp1IC8zyGoYLu4d0FOYnWk2F1dAlhOCzowy9viDqd6v3V
	U7mBg3WIjqA7vmfr3O6sYwF5EfSTrWEc=
X-Gm-Gg: ASbGncuCRAyTfBKlQmJeyX8wAoYyZ2T9FvMZdVRy23JiceF08Z5uGgsMoZ+EGTpeso6
	wnZdLv2NfgeptlPf+6l4zdvcFrd60wVZhb+zqT9tV3/IyqG1VihzbGrUbjG1xAp0y74+kUIdUSX
	+Y4FbizmRpD51mDP7DE9uIgabDXb9szYNzqR9sJVKVnpzRnRBqYfFsEh8FynL3qUu9CMH6VP3aB
	VDgp2aeMxBcaCcGvAzC09/6FjrOpNMZPK2ZI0szTg==
X-Google-Smtp-Source: AGHT+IGdKnsarC8XEuiLJTR0Z+LCHOtiSbPZRsxVDK/PIpmylC7qZ52/5RseqFkxsoYOBt1a0lL5ap49imUx4AxY4PU=
X-Received: by 2002:a05:6000:4301:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-4266e6ca4f2mr20054019f8f.16.1760475197482; Tue, 14 Oct 2025
 13:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202510101652.7921fdc6-lkp@intel.com> <aOzKEsav2RubINEO@hyeyoo>
In-Reply-To: <aOzKEsav2RubINEO@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 13:53:04 -0700
X-Gm-Features: AS18NWAWcf_MT4SkGxMNw4WzewXOKnGlmlXtd7IoU2eahWJ0OnVXdm74h9uv2Ek
Message-ID: <CAADnVQLA=q573GEQukX63vfoqdAJK1CjoyD2=DZcQgeqAg-XMA@mail.gmail.com>
Subject: kmemleak and bpf_timer. Was: [linus:master] [slab] af92793e52: BUG_kmalloc-#(Not_tainted):Freepointer_corrupt
To: Harry Yoo <harry.yoo@oracle.com>, Peilin Ye <yepeilin@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, kbuild test robot <lkp@intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:45=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> So here we are freeing an object that is allocated via kmalloc_nolock().
> (And before being allocated via kmalloc_nolock(), it was freed via
> kfree_rcu()).

There is another problem here, but the root cause is the same.

I see this kmemleak splat:
[    8.105530] kmemleak: Trying to color unknown object at
0xff11000100e918c0 as Black
[    8.106521] Call Trace:
[    8.106521]  <TASK>
[    8.106521]  dump_stack_lvl+0x4b/0x70
[    8.106521]  kvfree_call_rcu+0xcb/0x3b0
[    8.106521]  ? hrtimer_cancel+0x21/0x40
[    8.106521]  bpf_obj_free_fields+0x193/0x200
[    8.106521]  htab_map_update_elem+0x29c/0x410
[    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
[    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
[    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0

it's due to combination of features and fixes,
but mainly this
commit 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=3Dfalse path
in bpf_timer_init()")

__GFP_HIGH is confusing slab/kmemleak internals to skip
caling kmemleak_alloc_recursive(), so subsequent kfree_rcu()->
kvfree_call_rcu()->kmemleak_ignore() complains with above splat.

I think the only proper fix is to covert bpf_timer to use
kmalloc_nolock/kfree_nolock. I have a wip fix. Will send soon.

