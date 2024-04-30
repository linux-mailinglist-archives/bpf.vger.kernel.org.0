Return-Path: <bpf+bounces-28301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B944E8B81D4
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B2B20920
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1B179B2;
	Tue, 30 Apr 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAMQaj4l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4A19DF6B
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511998; cv=none; b=ggOixzFIxS6BXcUb58YoOvhh2MI54OxIzTZvjyX6eWsYCKQ28o+i5T2rDskkKlHy0Uuku0DutXBtAo6doOxJ3n8zSxRfC+Ax9Zpy9A9SAcpuPJ6CeIZdnHa+SEV9s+X/FTwERzzW2ar5lgqDoshv+xTlykxgJ1Prrn0Ku23Iqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511998; c=relaxed/simple;
	bh=nbhg+FtJ+rzaLBEkfGphqAzbuTdb8Sqf3FsUE3wlhgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXJfzSpzxN6smbbebcOCJ7kQcpQFIcm/C9gE8W+Mrw6Gxq2ip9bJtpHH5FJCAYARpC8Y+MCnCLAANeXN+diLi6H69m0yXmx5jssOMMZzXVKoGk/xS/F21wbh6zibfYewsRNS70n5nPi34UlA9i//M7N4OvYmxxoYV2vvu/KCthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAMQaj4l; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a524ecaf215so779987966b.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714511995; x=1715116795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbhg+FtJ+rzaLBEkfGphqAzbuTdb8Sqf3FsUE3wlhgE=;
        b=RAMQaj4lgsTIqoGCwZZrVf0jtt/FK35kwjwV1vW3Ln0KLGEg7hC7NiDMt7nNvA1DM3
         Jhm25juOkZ1U6QILpWwwBQjkR+i71C+n5DQOq8tL+M88/ltTCPtT0VZUkAcODvhBcQYN
         xa8Qwms4yIxWUVGDZATSzdVAyKa/p0248C/FsHmtllKdvs7GtWdhfzDEKe0aEGA9IIAs
         0hjCMBcZGxj4R09Ux1+IhNwZqbeSuS8ShaoTNs4OuShMAxwFdJBN4BAvDhn1zKaqESSq
         Z7K7KhrwAWKbno4HjEc0lv7Pd3Vs54otRBMP06Rzk8vqR72z8nmSB+9CvCbHjV/iEa4D
         nQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714511995; x=1715116795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbhg+FtJ+rzaLBEkfGphqAzbuTdb8Sqf3FsUE3wlhgE=;
        b=mqipHnp10pFme3EWLn7x/Fkox4X8Pqkuf35MPaKfLM0IowXUNWBE21BMxK9wQStecN
         YPLwTjaukZ04eNTghCptgkGUR6U58o7cgVfQEr27w7YBF/HIJ9lziBKM2DjigEw2yVAH
         lapMXABvcd4mXoQYPnAvOoNLOm47k75QMXqvHIR8RpZXoZckXXH3EapckjTkDXvIDZ5H
         pmOYtaclAVzNexv9ZvCn3GhTpfF+LTR1rHljoQNFgDTWbRphctI4HPlLRbtw8x7Jn3R/
         du9s62gfcNACGjkaSXg/9WN9KmKFJCT4ZFDFufE6RNIZgaV6gvKbnZQc/cMWW7jkeSZM
         lUkg==
X-Gm-Message-State: AOJu0Yzo/VhuLA7FMzTVD8kzE8IPV65cUDWOA4DLScSfU+vWH+xcznIt
	PwAERsA/AjWcENu8Loq6Y8n9CRBgkXivACF4CrQZPELxVuw0SYMTHdva09zPeDSlov6ozk6kpQb
	MajeO117RxdLZCgszcEAJG+nNVFM=
X-Google-Smtp-Source: AGHT+IHtp3zYER1zgzVW1n/H9LmPhoDIRMfznFyHkEyAJ2zB9F+x88Q/GAsPCegJXHQY4t3BBpHJxRyaamtW07vG8yM=
X-Received: by 2002:a17:906:b1c2:b0:a58:bdfa:c2b1 with SMTP id
 bv2-20020a170906b1c200b00a58bdfac2b1mr583967ejb.9.1714511994379; Tue, 30 Apr
 2024 14:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430201952.888293-1-andrii@kernel.org> <20240430201952.888293-2-andrii@kernel.org>
In-Reply-To: <20240430201952.888293-2-andrii@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 23:19:18 +0200
Message-ID: <CAP01T75HvUJe9RvdSGP1WdmWhgsWiqEY2QRZtHqZEop42MT=wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix ring_buffer__consume_n() return
 result logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 22:31, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add INT_MAX check to ring_buffer__consume_n(). We do the similar check
> to handle int return result of all these ring buffer APIs in other APIs
> and ring_buffer__consume_n() is missing one. This patch fixes this
> omission.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

