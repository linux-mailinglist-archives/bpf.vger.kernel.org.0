Return-Path: <bpf+bounces-74207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC27C4D0C2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FEB44F1252
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19C34AAF9;
	Tue, 11 Nov 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cxh7bLzT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770F34A796
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856574; cv=none; b=PeE0+qnOVvRrt6jDMtKsrktIGYRcTlzYRTBloqyKWgjAHSIjsEYPqIkjv2kSIve1uanfbeC4fORvWgSFxgc+k/XTs4w1t+Y5r7bbANpMuUKxlfqErDL6+lr1yX2sEDt/cmMkLR2K8Vo5Lpr/PA5sHCTEQ7Qnq6bcWZKnvZzg+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856574; c=relaxed/simple;
	bh=JrxCJS6doR540ni5O4K+fTfT2J1vhfEKtnYrNkU/J6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZXReL1VXzhQpUGv5Kb+hj2D9uh0rlv3zjjqdvBcoUmLqI2+b3GyN//dKRn1NmrlTQoGX+pkCt8dIAxV7Yl92Vqd733gLOh+83ngdeXqolbdPOQy7yc/j1E9OYZ+UJsiagOXA+kCI9vJ9OO8yvasQf7r7D9NGUITL/vXh1kF1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cxh7bLzT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edb7c8232aso28519791cf.3
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856571; x=1763461371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=Cxh7bLzTrr9BQePvVGjJ40vDC0NZ2fTThVB7BYFO3Iak6qyEFFlUvplymWg0joF7Q3
         HVvSugfkZBwk1iaxvYjWFo+NLRPZYh1e5zW3LFB3CpoBIX+SjOYunRJ+TM2+q8sIqGZU
         epcQ5oRizTN8F+VsWK6pLYxh6lReG0wjdPWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856571; x=1763461371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=wCO59bohAxYmwzWQD0jwFMZJxjtOYKWkxBsXnrGfSSIOUzIYndg3MnLCCQ5nHlo26T
         nU3vn6gXyTTteC5Cfk/rnqNI/Gw0jdwyGQLZDUtMDi78TP+FKzgixF3nKxCtpBcjV/bo
         7ypIBSv9mtvgqttH3J34thBMaF/aEsmifylD0LGUmx05DtDafc4ljit1uoLOMFoDOLY+
         OcIn8yRx+Ne9wLYQnVrtOQeps6pmuZ4p8srQM3fDJfDbk/lQGRxb57JUsfLifqfpEvVs
         fIXqXaNFKytAnQLsmORSDzl5PKNwcGQpnp890HxaZg2royORnsOvefv3dCZRNBxgCm1B
         Gt2A==
X-Forwarded-Encrypted: i=1; AJvYcCVQxyaUD3gUSAIA8np17cdAq7IHSZbI+6FwmubeDGdtP7F43ZXqT7JhsMN3pGm+jnNqy0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmxWpOhhjUr66G+RFAOGRq9MoX7U1nVflrvSmuFISN7OvDyDcW
	7JjvKV8IleU9rYnAuSsWxAUHWSBJrcee5jzkmxLwJc+dr2lfs7LZvEdtVqKLERDihlKNd5h5EuH
	1/w9qCBxWe1v/CWob1j+PZ9T3fFEuQGI8vGOX/3COoA==
X-Gm-Gg: ASbGnctlhfIqWY6x0WiMoTQhTdZ5P3Zu/8WDaS384zTuOGoUHG9evK5lNvuaWQbzpdC
	/UXVjyo+9nDaYIIEzdBj2NVIpUj5Jc4MuOpE3BuLGJNO12IxvW9buOtrpngk69Ac8N7Az/HCG5y
	1krl6X/VhnpJXiOmWmK6KavnoB6kLj/lz4brUPUlK5clgtNacNWS91qRSj39DDmUWYTiDR0ZQ8F
	LQyDDO5SpYJMC5ifog0RWUqPQw5g33Irefb3WBvwbNYVpJEs2LzMOg0GVk=
X-Google-Smtp-Source: AGHT+IElRIVhqCvDTFpSgFEYkQvi9Gos4SnKPGf8Juir9zGtxxq03gYdBJSCGUUe4Ii0djCwuMFVWPO3CN8YKO0f0p8=
X-Received: by 2002:ac8:57d3:0:b0:4ec:f073:4239 with SMTP id
 d75a77b69052e-4eda4e7cbb2mr148255861cf.6.1762856570888; Tue, 11 Nov 2025
 02:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:22:38 +0100
X-Gm-Features: AWmQ_bn6E4e4WTTnqqQ9ptsMdEgyTHjWIJOU4-smQyjZiT3MKecFKgj620d_-Vc
Message-ID: <CAJfpeguqvHUDVzR7N=To8keErrF8Bn9kuojoFtM_58sLY_XXDw@mail.gmail.com>
Subject: Re: [PATCH v3 01/50] fuse_ctl_add_conn(): fix nlink breakage in case
 of early failure
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
> fuse_ctl_remove_conn() used to decrement the link count of root
> manually; that got subsumed by simple_recursive_removal(), but
> in case when subdirectory creation has failed the latter won't
> get called.
>
> Just move the modification of parent's link count into
> fuse_ctl_add_dentry() to keep the things simple.  Allows to
> get rid of the nlink argument as well...
>
> Fixes: fcaac5b42768 "fuse_ctl: use simple_recursive_removal()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

