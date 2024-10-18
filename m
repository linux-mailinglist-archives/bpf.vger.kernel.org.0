Return-Path: <bpf+bounces-42427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E819A41EC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1AD1C23651
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04B200BAF;
	Fri, 18 Oct 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcaJoHLm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C3768E1
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263947; cv=none; b=D1Z9BrekwqmeZDDgXPDYccsBePg2eiMN6fmdPCLTxF0Z+1mg3DopJlTZmOGYUADjoNMlDNVnNneKbKXGkx8YOg/iOl6MK/i9ntnjK/sGgH3W+Xv4Jug/MtMMD08n8EWi8kx/B7hb5M3Bw5iTici06/8xs6habx59/UCdxjn/8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263947; c=relaxed/simple;
	bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAbJRPLHu9MEejY7lAd97VGNfbB9pgum/ZGJ2a0YyhW07yojXx1eRnzGtTcrOOcA4DkJR6+JUeX5U9DTRGw5O6eCnwy8yI8oVhdXxPnSsB6g/D9M4BWQhBLFLn7M9gjdBP5rzrQDrxnE2rMPT/c9MHpkuLXNA1bc7zSYEMl5YUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcaJoHLm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e66ba398so29273e87.0
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729263943; x=1729868743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
        b=zcaJoHLmZnptFNjmtbc/WSclLW6gBDOFuB0ikdayjxq+ZhvVbt7k/jgBGpRgt2cQeN
         y5W3znAnofIi8tIfofMq4BkpStjbexm79XVWhtrHjv8xHxJpY6191YLBHHe3EpX0lsoD
         2yvdzem5mdRkgc20wbfml0ZbyOAe7JgJ4TBBBrdkgyVpP6B24+mlwIatuhEiFsaWGLNT
         cfD/XCKafe2OruBfJhOZWFmE+RkcxK10NqJXcDZPNOeOoan8DUrggC3u8F820LQ4oHgb
         sLqgkvLPqVtFi9Q8wdKxvMVFa2dngFyrgrtQhcksFobe3k2nPuB+OQ4iLo+bESX/2U2+
         mwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729263943; x=1729868743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
        b=gH4VqOZN6XggmskgS7ydwYCIPuO9aTzMkXoUZLF98t3Y0ES65FxCEozXv3gNx7/r9N
         7Kbo6rWiqHhzmSE3SoS7b3+NyGRFb3+qErwFuVBCPzjCy1JeWyz/t0zoE24pCZV02WIf
         gA+1ZwQ9IIoc1mV/f/bL4zGQoZvgJ9KN+koTr1BPx/9AefKt6rq7Ur82nurJVLwbPKzP
         b9d64Vf3GaPVf5SHAZxVkxzayLiDYr+xL6TBa4QfgIfjPTrNvZkUZnDn89g41iz1kMzN
         /lTZiEDPx0n9VyS0hgrYy4kQawMFJlKPjtM/d2xOLNbvTn7PtlT2ViVKmfMyv1VPtkhn
         01Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVY8208iXsqf8oN5MdFN4wy8/1bym19WobEbNxc3CeNbWFpLCO9EaRg8WCEGhJjFmBlFXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAl/+8wJqFsIFMHQcwjwaPyNAstdcyXd2EDcu06pK+201ln9fk
	y9Md1GLLZH3k6KIMmgQIkP+fBGFy8zjRSRJxC3ASGER+DqTucqC1LTwj6TBi3Y2xEWa0N4ZC93D
	B4Styarne/RbIa/x82UvCZ8KHusRU/Ubei+f4
X-Google-Smtp-Source: AGHT+IHEdjAuAnZpQTb3020lZcH6NNioXnQO8TFmyT8yTm8pf+QhIDKkj1QU/pK6ubOymnxvMFhGxeUvu4tJjCuhK2I=
X-Received: by 2002:a05:6512:31c2:b0:52e:8475:7c23 with SMTP id
 2adb3069b0e04-53a157613d6mr366525e87.7.1729263942596; Fri, 18 Oct 2024
 08:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 17:05:04 +0200
Message-ID: <CAG48ez1Bd7dWmXpMS2=f6gHoSxhySv2v3m5_BvucMNtC3AZeew@mail.gmail.com>
Subject: Re: [RFC][PATCH] mm: Split locks in remap_file_pages()
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ebpqwerty472123@gmail.com, paul@paul-moore.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:48=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect(=
).
>
> However, that commit called security_mmap_file() inside the mmap_lock loc=
k,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock and retrieves the V=
MA
> and the file associated, and calculate the 'prot' and 'flags' variable; t=
he
> second takes a write lock on mmap_lock, checks that the VMA flags and the
> VMA file descriptor are the same as the ones obtained in the first critic=
al
> region (otherwise the system call fails), and calls do_mmap().
>
> In between, after releasing the read lock and taking the write lock, call
> security_mmap_file(), and solve the lock inversion issue.
>
> Cc: stable@vger.kernel.org
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
> Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.4=
6d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com> (Calculate prot and=
 flags earlier)
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Jann Horn <jannh@google.com>

