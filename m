Return-Path: <bpf+bounces-74210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12CC4D08F
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065C21887C67
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEFA24DD17;
	Tue, 11 Nov 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q4HHA45X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BE34CFDE
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857006; cv=none; b=UtRaDdP2KAfXA4pGxA+PkuSfX3ZT2QviUom93608uYEd8X+3Rl3qvUh/VmASED28C1btI18Jsb/hD6+L52uo/ZKTgHHyS4n47Wpy5EVV+1PGfNlAM8c0xu0KNPIbpql6l/Rvhn3jzp0m+kzla10yohZ60+Mg9TxNhWKISiFtxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857006; c=relaxed/simple;
	bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpcggl86yhfzmdRy2i++wUvgDOEJ6CC3BkwpclEJD4xiqVLY+TYZdPRZho+KRbi6FF6Bsxzyq+y3Qx4H+lTS0hNd3OJ8cTHB1RbNT9f7hZlTm0TPfKs4CJX7KGwvJvVQDvRFRBAPpo0Kifz2Dryt2CESF1bJPHGoequYtgv2RfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q4HHA45X; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e4d9fc4316so40133691cf.2
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 02:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762857004; x=1763461804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=q4HHA45Xx0xTDskll4DjSU6SWhWolRSlpTtA8cDnYPTI/9mbRIiB52rjVByj7Xz8ay
         nFP0//QDDttEQdXDUPTQYuhtZxg4E9Z6etcMAQhjvLkWtzN7d8du6hlQT4fTRYhV57g2
         fSGQ47hY+Biwn3/0+lGUjV8ol/iJevVJFrQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857004; x=1763461804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=vxPt6m1j79XjQnJrSQxnhgbG9mQ6T1Jmuc168pKECoIAqO8GMoBUFTNCuqKwiDXKYs
         e6NoLxmSVuCMUKB8/efd7LvnolClG3/BUBqvR+QBGC3cmUdj9BuYcdyroyjoORumV0PR
         p2fZfLpAcATDy51ffGZM9EZ6+Gg07Su4/dP6pFCT/FiJLy4Jrc5k9xaj4UlbvADSmJ84
         jJwDNMfq4JaERa8pm5hbt7G00KlIEyKw0laxkuKE2L3FcdpUYpXZTp8Lj2vE9dF0QAfH
         GXCulCZ5fD1f8iihFzycm8lZoNME13yTnoNeE8AoYYNEh/Xz+FReJbUXUbLUUVo4hyjz
         xdDw==
X-Forwarded-Encrypted: i=1; AJvYcCWgUqX6uEczNFAZus21LH+vhO8T2z3yq8Foa7akPkxxpZdbMcgnACpB/zpNbYqIpa71BeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTw9cbOAX3IhHH15aTAe8LPQMjcb42DDIkwNG3913QD3DZ9nI
	jw43/UUONVzHjBqsO38kZagZrOAZMJntstkz0n73dnKwUsePMBHwUhxm/vCbwtWQjgJWQz/l+5q
	4rNCE5RvRZ9G8IM9lcCxZZB6oeG2HLkt+38BmzjVINA==
X-Gm-Gg: ASbGncthzxBBjUFyvKooqWJ2Y7mII/hVTlszKgmlwF1k45faDGd50BWYFHmO6k8dyp/
	2ikWt24hk2/FfDuTm8FYJrcna5P/WVbG4ossKS+3mmZdMYsko/eCIIOEnJXpznCYLgwwN5WkNaa
	5VRSYc+WVg5YFR2XhYpdi+U4rryYL90yhjjwSuJHDpdYLh/ZS8fkBQiyVtN8xDBY1wstNJMxVle
	7g+5sbELOppdxUNr6Ym5gpIf0bPhdoT74hdzWSTedU5QfUcSTHu6bF936vPeX4G3SnwyA==
X-Google-Smtp-Source: AGHT+IG1vPc79jE1NxMTWUcAkMOFXJ1dO7xwNLHncVzXeQGMi6M4ZcaWG7wZ9Wn4xgn8RqaQcm4UKxcrnMz8XFw/71I=
X-Received: by 2002:ac8:7d8b:0:b0:4ed:b378:145d with SMTP id
 d75a77b69052e-4edb3781c5fmr87056701cf.45.1762857003684; Tue, 11 Nov 2025
 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:29:52 +0100
X-Gm-Features: AWmQ_bnbS5BGnOdlDcNli2J3_mWe2QdNv2AalQvWZZg8jjhCbQzLKZqYiVdFPQQ
Message-ID: <CAJfpegv5eZK=70GEdbofg8u-CKS7gL6Ur5PD86Ay4h3Z8D986A@mail.gmail.com>
Subject: Re: [PATCH v3 03/50] new helper: simple_remove_by_name()
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
> simple_recursive_removal(), but instead of victim dentry it takes
> parent + name.
>
> Used to be open-coded in fs/fuse/control.c, but there's no need to expose
> the guts of that thing there and there are other potential users, so
> let's lift it into libfs...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

