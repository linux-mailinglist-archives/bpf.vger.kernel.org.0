Return-Path: <bpf+bounces-79155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F73D28D81
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15623305E3FC
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F4326952;
	Thu, 15 Jan 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2KCJV4v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNCyho49"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE930F539
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513672; cv=pass; b=Zeqh+Y9mlMmj4ar7a51jsyVU+goK4VI9f2Blro1mCuSwC/SO1kpNCf1kV2deCm2esg24KkZHjy4SDPS9rB83y2XQcKEJpdUhQPfpxC5/lqxdt2IqEX/mldOjThAvj3lM7eAgC+GONG3xJCRlb7zEWPGi9oXxVmuLlkQC9ln8Lx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513672; c=relaxed/simple;
	bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBGpltnMABDeeXaLBXa32tD6eqCL4eTM5qLBOUR13ZHTR7EOAC4RSORzDHFke5oFSukBZnwANnZcr2N1ozQ1f+LmHgg0AbsfDwy1bGDQaqKkXD0r6pNZvC4kNUbcyypzOa+nnR8OxgfJ57d6d7rHUl6B5HBYscOu69xc/86sbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2KCJV4v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNCyho49; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768513669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
	b=V2KCJV4vfJPv1Iorv0na51f8MgFlqEas3AR2zP2tstPb7ZKjFTajcYk89/l5orIc+l/oS1
	8hSaaRStVsXkASsMRmuk5dCWXDbaI7T6A9dp7xOcoqsR2wqRv5kuXhMmoxzFQhONDvjYUk
	dRYh4slhRPhJ8Rm/Vf14IqaSvQj1Qrw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-ePTUOr8NNnCc4X_Z7y3ToQ-1; Thu, 15 Jan 2026 16:47:48 -0500
X-MC-Unique: ePTUOr8NNnCc4X_Z7y3ToQ-1
X-Mimecast-MFC-AGG-ID: ePTUOr8NNnCc4X_Z7y3ToQ_1768513667
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64da80b3699so2249324a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 13:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768513667; cv=none;
        d=google.com; s=arc-20240605;
        b=OTFG7lMGeyN6BN80IWiN8A6Idas/HUhDTG5CJ6yjw8KwwkVVbWnqYM4pj9+RL66vI9
         RrssKIjurkVTYVqj2Of6DEyOKN0J7cSyz8BcUXPT/1hdUBXVdf6BFrJ/D3GqXPCp3YD9
         4g8u3n88yyXYWmBl1ljy4FK2fpdx3zWw46P7UagR66W6sEJgkgtOmR4/1Qhp1xRHuLS0
         GrgzlKTOyy8DpsEueL1DEZwS2EhRJsBGwnqLqcwTk6+cBx28eGVwNdznLxTTHTo+lCZh
         89vSL2xRY+kGkXcx+C0zTywTJQgw5HKznHt+AThlVdeWoRk+Op1yzB2QGab+Y3tD1B3c
         19jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
        fh=9KcU3atMq1KN33BdY93Bna9nvh4RPYdfovz3zsIlp7s=;
        b=Iz/73WP2Sic+hEd+EBlY3W2UvwNtwpL2+CIfUU0vhzDu9xLOSLTfPkXdW9UuWEF2ct
         HpZONnxzrfMsndETKxdetmtHS/3Ik7JAVwCNNZfZRJPEJjgM/g+Yd4cFULskTJqMY+jc
         B9x41thwLhgmysNIKJ9xLF51XwaEYLprDIREyLaxWytfE6xqXix/3IiQ+xyJ4g6skDMO
         OGjMi1vp/pScMsV/8Mq0wQkL+4gMP0wv60DJBEs75/DR2+oLg6hQ/s4atzRHoY840QYY
         iyKr9+SqiOr+4v3S+RmW+q1yiFy/bAwhhkRcUF5P85jUgEDhkhBd58/3XBvysJ006urF
         8asw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768513667; x=1769118467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
        b=SNCyho49y3xMemSCjWUo6r46olD1j/5ppjLNZY9TQhotPLEja3sMytr6rgn9IGvYWC
         LValY2Fli3aHtBfAoOKmoFCvlIHbOwlHrzF41MZVXg6mtS8XHG87XDwk8l+sP9mCSo2O
         ZUcXuTuCWy/WkPMzBcuzTJxD0vTgAvgMPum1FrFxtYVDxbDuiCT3x3wVSWLjfh5PBmWa
         aVqSneMqzqvW2imnp6siM9gGsZ5/B8CKHyoYVyyCr5ipJKu62/9MRZVt5ZJrrxoWCBds
         qzFbyTDwY2UysoiGC/IwS4yxYL8eYVJAe0OjWgA2nIwfED4sG3nHka44bucdiWk6OHpk
         eSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513667; x=1769118467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
        b=b8fdZYx0n4gffOCK1t3c5gMmKgY+wZy3z4iB01QqiZ073YvNDgcexQ1iRaf32lrDNb
         lEaMGWwntMDlVIbcGY8L/EE0Td0/bRtCUkojEZyQYXN+Mk4TS0YfTKUecKUrFBi2iiwt
         yAwhN9OWnWxqfbP7Spa8qAsOpGKnmn1bwwuABhPvK1DcuqJNeXqFfNOBvOuToWaRtxF5
         bLukXWqYMH8DD1YDIm0sxTEbYEBWwGUbjYQ1nGK7XZy+F+jp3chE/YNz9R/CNTj7PQ+A
         2xSu/HgpQzBn5Qmx7655EYmeM4kNNHCSwb186VdHJJaklFGROlq9Ph1NUX2p++RAOxR6
         fopQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwsV9azb9TeZcZtSZCYKDVynazLSDFEl402X8aEM/b10Uw42BG2hx4iTRJg28uKfsQqLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7O7qSqlWNpPzEmwG/RxZ1mTPmsKs1rNklu/9U3SqfunkXtbv
	2oM9hIKyulCsdmWds0s2eVUOQsztd7yqpVAzUT6Y1BmDI9V+L/eJu4oM7qRxSmLMukLABEumzZd
	gWc0nvRj2Eo5393OLeDAARErMrYjF1mVIOBQlH7tEJX4qgDhB+L1p/2ximmCFvPYE+DIpHBs2ZX
	AFum3U5ynw+vFp4Pvr40tkMzvA3lh8
X-Gm-Gg: AY/fxX6R1AyLzOnZM22Jx0wz124HfPgBc3XoWoGJ6Z2dKMr8qiUhCFs5Y9hC2e9kzjk
	/OORYI6sbisX6/z+MGe7eMKV3nICaXKjOf8/7eizS+dFVL9O7TXWgx94S3ZFuYQP/Oo/1nIql/S
	4PcF8gtdommQRfht+F3/kZpX/IVIzVuBVJVr8BdjMh26UIhWZZX2vu/dI20DAL/VB4MegfpHxUr
	1UIbRrWLZPyg421Tz8lQVV6ng==
X-Received: by 2002:a50:8d8b:0:b0:64d:2822:cf68 with SMTP id 4fb4d7f45d1cf-65452acb34cmr460643a12.21.1768513667089;
        Thu, 15 Jan 2026 13:47:47 -0800 (PST)
X-Received: by 2002:a50:8d8b:0:b0:64d:2822:cf68 with SMTP id
 4fb4d7f45d1cf-65452acb34cmr460627a12.21.1768513666696; Thu, 15 Jan 2026
 13:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
In-Reply-To: <20260115163650.118910-4-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 15 Jan 2026 23:47:10 +0200
X-Gm-Features: AZwV_QgmE7V_w2qHIpX_JB5LIS1_ZBI1TTwK4IhXV8NP7XdRm6XAytzFx6veMZI
Message-ID: <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 19:25, Wander Lairson Costa <wander@redhat.com> wrote:
> To simplify and improve the robustness of argument parsing, introduce a
> new extract_arg() helper macro. This macro extracts the value from a
> "key=value" pair, making the code more concise and readable.

Would you consider using getsubopt?

Costa


