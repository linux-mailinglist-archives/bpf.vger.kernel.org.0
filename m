Return-Path: <bpf+bounces-42712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD209A9514
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5854282D3A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4111EEE9;
	Tue, 22 Oct 2024 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyXlnMpn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A454A07
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558016; cv=none; b=fzjs7FTu16+d0Cd/XdJGKORd9SqqAGqNqm4KDQ0LQd4Nuk4AXW2+iWiWGgzeTdsn0rdJSky7wjYSHiVv3HhvNUCXXcNinXFrCcYhcO+ruV+trGqB113h3D6hSCuQcMXXs4eCdKL1QMuXg0YPO1HfySZcL1hi4HJzJ51QrZVWv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558016; c=relaxed/simple;
	bh=iH+i4NF8bj4VtHDLym/C7SfY0VKvalJO7ulL5n8jS4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKfVTUYfLVXuo7aI6dvKsfXHDyK22gFSofD2k0HP9JH6yj9aY6beDsLgIfl1v9DX6agD8QMfiliNY7N50LlpP4viGqfcS5y+1DxSl8Z/Or+Px6dRgd6/WPczflAfKrHFcd7FWSVaY9rvh7f5VyUr4u5We6TsQym3O6MEUFEbUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyXlnMpn; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so2783004a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558013; x=1730162813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iH+i4NF8bj4VtHDLym/C7SfY0VKvalJO7ulL5n8jS4k=;
        b=AyXlnMpnRxqEEYH9CjZ05ovY0nQpAA+0I6QwxhAJOG+RMhR07l7Ol+FySO2qIb5fpv
         u0Ud/IwYnTAB93BygfdejiTIV3jqk69Aguojz1OyplgiNVKi9tkMs9vU7m9v7Tcou9mY
         3D4B7uUmRjkwljee/T5Lx9wvS+CU3UXiQv4ZwZx/1k3py6RalGyV8ca0Ie1/RssemziN
         qqwVTm0Kcvj36mvviZxe7DoQneCh7SECIglKUqQ6pq4b6TfvBkcymTir4amzQJ2JVhjA
         AiXRBi6QEM/33zMpfL0580gRkSi848iCNAXgfje4ZtrVigBBDPoNcuapLpBZGr6MOMXJ
         gsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558013; x=1730162813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH+i4NF8bj4VtHDLym/C7SfY0VKvalJO7ulL5n8jS4k=;
        b=cFToF+blhaflGwcH9Q5j4VAVwXW0rzxN1QCVz4ajzhHe01KadAfuZFZ4CvN80YVzcj
         d9yZPwyLMN8rDZQl0rz8RE7latBwyhXYNqa5fCHICbbImGvEzyyMZlTu5J76d02sq6pl
         BvzBN49iU+/bx5iEIylogihA0bvmVn1zE3Gi6C3Eeb370k51imq/f5CP1ZMRVLCr2VRi
         O43zkbhzO0nkqldS55Zg7ZCrgAO0PdGkyOZ6ad3yxWDtu9uj02j6Fz2KWDs7LsAMbizk
         MxcBl9Rx8qInKMVlnbE0838zEPWGT59jsSMtIEwIX1SQ1nGNi6KHIpK/T+XzqO5uyOwq
         HK3g==
X-Forwarded-Encrypted: i=1; AJvYcCX+GZR4D3uiV+32uanjtpLxU1IWG0i3Hh2s8oexvOiaqfdqLitZYwimOo4noBoTY28OfqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9xkCngkxRBtfOdTcEv/2XQHlRObYKPwHIUGpAh/TghDKc9v8
	2Loc63W6HWelGVCi9mMVQUg92wMtl9QR+jQsRJfIaGKih4VPDAtne0CZqOBDsZ5fijjLOIYU8uy
	bkJOd+4uptFLf89/06k+H9E2hDkK3t6G09Jk=
X-Google-Smtp-Source: AGHT+IH23PtCNbUlXO0M29kfSOtF38a6GaXrxvOEUNZvKD04DK2eB3ckj9Cqld8gf6vRaXVxNY4HbkdWObpabMVSdg4=
X-Received: by 2002:a05:6402:13ca:b0:5c9:813a:b1b3 with SMTP id
 4fb4d7f45d1cf-5ca0af8c7e3mr12162508a12.35.1729558013064; Mon, 21 Oct 2024
 17:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021152809.33343-1-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 02:46:16 +0200
Message-ID: <CAP01T75oEqO5fKtETcz7u+HAD4rJgOnBZ+QnV3JXiFvtHTDDdw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/5] bpf: Add MEM_WRITE attribute
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:28, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Add a MEM_WRITE attribute for BPF helper functions which can be used in
> bpf_func_proto to annotate an argument type in order to let the verifier
> know that the helper writes into the memory passed as an argument. In
> the past MEM_UNINIT has been (ab)used for this function, but the latter
> merely tells the verifier that the passed memory can be uninitialized.
>
> There have been bugs with overloading the latter but aside from that
> there are also cases where the passed memory is read + written which
> currently cannot be expressed, see also 4b3786a6c539 ("bpf: Zero former
> ARG_PTR_TO_{LONG,INT} args in case of error").
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

