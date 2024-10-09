Return-Path: <bpf+bounces-41441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6816E997054
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145FC1F23C1D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0A1F7086;
	Wed,  9 Oct 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VGlkuqiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67201F7085
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488238; cv=none; b=en0pkts0ePDvjv60RW8yIb4X+CT6SxJ+JPamYYVEO2eelabWY2WvQm5tejhJVDa+CmGKX0Wq639oJ3aDlxCltZj+Ln7lYS73A1kbsHMo0BYg4D4QxoDUzb3rKvc00meXQDaoslBzaFjEOy/fn8T6CnkX8SL0vg0zCfoniuVPcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488238; c=relaxed/simple;
	bh=La4KVBvoExKm9pO09UAsxMsz2f1GjMBJB04Ukn3GBBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbfQ79HCNUSLNQHm3OHV8vUSNk04ijq1+OPRmkfKltTAdutq3F/I9W6vD9Wt+nsNYyu/o6Z9GlPUy6rPD3HdCgR8nwQgjOpkUr6RWNTLHnRcuKLY7DNHm7l3GJIWuqBlD9sJHx5sAc/Cp5xUhUVb5LWBBTzUkOraaNoqKyxvSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VGlkuqiU; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so351492241.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488236; x=1729093036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=VGlkuqiUsB0pWWkcZ3G0Zj5BDzVCtgiQCy283PDBNf3/M0aBDd3r+YxGncj7lg3CyJ
         2yaYH4Tg9TyACyW2XOp+Rb4dcCfr3eOGPL4JFIx9zY5fzKgqH6Wh+OXWasXIn0GFuh7t
         U5aakPSJyibwjoQeIBRXwqFnufHi4ZcxlF4CrK0gL9Y3Mn4ne4tB71SOzrNQTPfdhVkJ
         Uf/OwTuU3Ju+0wIc25QX2ZtyzL46dx0R3Yh0sqh4/mWW5bu54Qsh4Etzp4EzonDGt443
         JEDxfZsRR2/CGo5GB2sOpLAOxq9rwkhp/GexxnA1Ws8eYu4IWdgr7ZMmOcJixiMaQK4s
         0kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488236; x=1729093036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=B1lbZ4OY0AMEjNrF2XibQUwo9kL2sjVNV/JAbyY1L+XkPzyhFGS7wGIvGR0ammp66V
         H62K3uuPu6jjZV0x+sn+PlVqJgX6oWiJSDugAuJoeUmOl86G+di+wN1Fv/2YylvG3XM5
         9NbEvd0EY8kKwT5nOuo68+EtO3aQkaHJLO1Ea22tfJjh10EHZppbPTDXnkh0t4Afo7I1
         rn34sHx+O0NMBIqIT8PpnxbQfBm+dqAyEwW117BxVjjKt0dJJTTa03b5k2QcQ/PkfnEc
         5e+fo4gz2NN8moc3lctkOgaZR1+XcIYbBiVoOGoo6GN5PJks43TqFg3RZ8VPIBSbyFHB
         8E4A==
X-Forwarded-Encrypted: i=1; AJvYcCXWoD162sHoNPb5QwbLrguny6pZzJQpGrqwzR9oL3pyuzr0qwDfKvmmJTfGv9pAkVOG5s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEljo4GpqGMleTJQbmb8Wj0JLlmFu84ptrwkIne9wvHIoKy2fc
	f7yz2SDISdD1s5QWd3IkvFeMpaj05JQZxoYu9hLnbBGKpRnye6WnCtOu68CWDKXwgGH61ihT2g9
	RxQXTxGAIM/5UeHxr5XqM/tvqozOxxfxvU8mn
X-Google-Smtp-Source: AGHT+IEu5xzMzhH/wgeDgjEGKWpciv4mCxSojd55huo7SKv5IrO0ylLHZx0Mi5aaHn5HxWNAJbzCfGMT+FuD46vf8r4=
X-Received: by 2002:a05:6122:3126:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50cf0c7e54dmr2055501e0c.10.1728488235831; Wed, 09 Oct 2024
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com> <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:37:05 -0400
Message-ID: <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Move out the mutex in the ima_iint_cache structure to a new structure
> > called ima_iint_cache_lock, so that a lock can be taken regardless of
> > whether or not inode integrity metadata are stored in the inode.
> >
> > Introduce ima_inode_security() to simplify accessing the new structure =
in
> > the inode security blob.
> >
> > Move the mutex initialization and annotation in the new function
> > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > ima_iint_unlock() to respectively lock and unlock the mutex.
> >
> > Finally, expand the critical region in process_measurement() guarded by
> > iint->mutex up to where the inode was locked, use only one iint lock in
> > __ima_inode_hash(), since the mutex is now in the inode security blob, =
and
> > replace the inode_lock()/inode_unlock() calls in ima_check_last_writer(=
).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima.h      | 26 ++++++++---
> >  security/integrity/ima/ima_api.c  |  4 +-
> >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
> >  security/integrity/ima/ima_main.c | 39 +++++++---------
> >  4 files changed, 104 insertions(+), 42 deletions(-)
>
> I'm not an IMA expert, but it looks reasonable to me, although
> shouldn't this carry a stable CC in the patch metadata?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Sorry, one more thing ... did you verify this patchset resolves the
syzbot problem?  I saw at least one reproducer.

--=20
paul-moore.com

