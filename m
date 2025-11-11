Return-Path: <bpf+bounces-74209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30869C4D128
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 616764FD493
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79B34C818;
	Tue, 11 Nov 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S677OMUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F734B425
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856912; cv=none; b=PHtXodFoPLtgwFzVLIYcfuRkN5lw50StLiBo87WeSUHkwfhNhWuBrhgCuInsPtVgKw3sr2DelsHMMpeygaKLZHqDETve6yvYzOT6g10HFnzuTkxfV/9gOWoGxIsSJBzYUWkMy3HIZtr0cndNa9zk2mvrN6F3vRXx8wE7kL3QUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856912; c=relaxed/simple;
	bh=AFJjiFOvGyHo0S6e8akF06HQkuXboJRcqUguRvorBaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pINr16RXsBaBCfv5/XIra/H2I585eFs25+AbnYtPzAtgUSiaPpk0jLH9jigk0Z6vrF/PFAU23IpYOLoQzKafPugK6Q/vW13fdudD2EJ0C9oyPOjSrHpTzbQRTsCdi2z5KKWqFw11wX6ZvCGELzlKtiWu9AtTJJXXtIPbPJbUJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S677OMUs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edaeb11634so20277941cf.0
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856909; x=1763461709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=S677OMUsTqJF1qJWtI73xM3czE842pFDa4Z3u6wgcHg/XV9/ynva0/WZAQSUJTVye3
         RAw/yyuEH0ysJcdYdNkFWVhuAC6gwvAe/aOJifEx4sjXEwAkhG5vctExTDyw9eYdZTpx
         KoJTGHwJutDyzWwASbXuKTO+L6tY34jBFFhG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856909; x=1763461709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=DsuwEwycEIOXwKsFTyyXokm/LSjE3P3pBYMz1NjkOIRnH69MRWg1va/p/Bnlk0mHmo
         xo1maVm+OfR0w1mJ8U7csirFKIMDv5mDWDLLYiPep10HG+VzGunQGtmUfSinQxHLhKAs
         0s2lfY246MZw3vHK+tdReJjGCX4kaAbvkTMxxaXf2p7TOgNVOJimGjVYs+HnARlwMirw
         HQ/HxtGL8G9tBYOa/pKFjhSEf0ELNwxKweaoEZHgt5h5SZcxHQglnMvHTY4XXzBk7+yj
         49mIZcqTK53zX5zd0LjthzbPS+IzGKiNHs4/qdomIH2RgriBDBF/EeBzg3MKZbVLBKI3
         xVIA==
X-Forwarded-Encrypted: i=1; AJvYcCXPt9a9WgFmk6Tlmxe5y+GPu1WhSSF1rENhn6DYDr7jYMq1u17CAsqAds3n1SJl2S+EbpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx011ATmi4kEGvCcupw7/bGNKO/UrcvrfGQVnJnf//B71xgBATI
	SgUqB3R/fX+ZVWdUNwgukGpZ0jqHb09J+ITVcyO/qPODpvlss/tXv40zZn1QNznwDhMC80PSQJ/
	yVWmidDbaIXJa1T+a9juIhGcBBGb8H76k1/m6UzKp7A==
X-Gm-Gg: ASbGncsV/ghKJgHiG8D9fbD7N4XdupBZYFSrc5D8B2wlUyLBrzKRkGbod9Nc+EP6NP3
	LiLqCGwC0bZmhFcoS+qOEUgQCmSEqTySYL/xbWzHkwyXNgE+F/WOa3cDoI7wcmFp0xjLbu8rllX
	Pcyh6cyCMeiXHH7JtnTKw8q40/BNyREGf/wwL0fQfmgvN9dwFRlasA/xUv75MHVI8UgbR7KlVz+
	A9Ou2S8oYHuaYO15KN53bbUAOPigkTajleEh8pdfjg5GSDoIhZYwatVsig=
X-Google-Smtp-Source: AGHT+IF2jsXtOYznzAlKiswAAYjfBT86jbKpGaMbobTgICmObIV//j5aCRxdPYkP+19MfGrAnajQvcSXxRuiu1TbWoM=
X-Received: by 2002:a05:622a:1898:b0:4ed:602d:dfb8 with SMTP id
 d75a77b69052e-4eda5043040mr135933731cf.82.1762856908949; Tue, 11 Nov 2025
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:28:17 +0100
X-Gm-Features: AWmQ_bl7He3VQsld2UXN2E831Naa9ot3hmwpZMaWScQnQVWsufspzsog6zo2yMQ
Message-ID: <CAJfpegv0jMq96xD8gSbMBydj=1wRixVGy+qd3feC2vSSn7v_rg@mail.gmail.com>
Subject: Re: [PATCH v3 17/50] convert fuse_ctl
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> objects are created in fuse_ctl_add_dentry() by d_alloc_name()+d_add(),
> removed by simple_remove_by_name().
>
> What we return is a borrowed reference - it is valid until the call of
> fuse_ctl_remove_conn() and we depend upon the exclusion (on fuse_mutex)
> for safety.  Return value is used only within the caller
> (fuse_ctl_add_conn()).
>
> Replace d_add() with d_make_persistent() + dput().  dput() is paired
> with d_alloc_name() and return value is the result of d_make_persistent().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

