Return-Path: <bpf+bounces-21794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7885225D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C51C21E64
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F664F605;
	Mon, 12 Feb 2024 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK3ZHET8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69504EB49
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780060; cv=none; b=KG47BNSApuLhn1DmEaWChZMhxdEy90tWU9o/j9zSjJcjkVVuPucvr22f8Jpx/mqrfhxJ66iZfYByMlYZjeGNDoYwuhcfmK5LbCbuSkI2064g/9B0sKmLlttdxRd+58umgb4yc7/zsteeVN2gPb5qoK6ODB7U1jghywxXpWrSLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780060; c=relaxed/simple;
	bh=QrQgnfkkDkruN847jyG2xQVs2WzGiMK0hgzae1YDQFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwKJDznbzzT4XJk7jP4YWqaCVQjOuhDkqOHfEs0SR0jTy1+rbYQg5ZJdCPk+rwGotfQMxCwV5tk7cagFHHyDajLZ7iV56fMP9xof9olcblLkhpbcRdK4d11IuHYYaOPtTZcjg8dILWFL2pgpId8Baiw0DvnqVCp3YCzK7LuSlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK3ZHET8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2355AC433F1
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780057;
	bh=QrQgnfkkDkruN847jyG2xQVs2WzGiMK0hgzae1YDQFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vK3ZHET8UQxf1qVgDglLoPh3y08hxW+nSZzomBnFbtmnuxa+3XvdxTf6ohGBqNKM6
	 bgPDwxp+2nhVbANrwfvE0L1NDO8uloF4ZmlMlyP7wgrSh0QhMrkAzeiDtzujV+Q9WW
	 RwYURM7h4iZw4ZZnWfquD5q8paaLPiohIwFzsIARUVFpqY097oUYKzFMjFztM1+sY5
	 XQcDHj+HZCILGESv9krkz4iVeXOofO7niyPvaPYeBDZr9ZWEefBg1DnBsdjMbV01lJ
	 +Q8hHa8G3EjE4oEG33eSWTzFyjCbb4CgtMT6cCBVvvbmcjahg+xw7kjQJAIE1NSmzk
	 KLrq5tM2QhvjQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5114c05806eso5946288e87.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:20:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyN47NKpOqaDxiqjyJ2QLk5piiTX6ylzIYtAfLKczwaGNjm3+r6
	hEwXZSr9JxDM103jyRdbXcUTNEmHXxkgCE1SflWmCJ9sHtszK3ybcHnAJrhkZhKag3nJZ879RFb
	Xg8+GCFeEsw6rtfCJu5956JCl6sE=
X-Google-Smtp-Source: AGHT+IGCpqtr0QTNSrEXoxgK9OLS1/Y3yh6mYujt9+7d7GTc6m1WsNjoWbV8a+6g+TKeXKDoOVPjZz3UDir4opl33PY=
X-Received: by 2002:ac2:5dd4:0:b0:511:8e03:c91c with SMTP id
 x20-20020ac25dd4000000b005118e03c91cmr2803040lfq.8.1707780055300; Mon, 12 Feb
 2024 15:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqEB3REkEKJahQu@google.com>
In-Reply-To: <ZcqEB3REkEKJahQu@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 Feb 2024 15:20:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5rYmo+Vb5X8xODK9wpTD5kFqDAZiavoeS=xic37fJ6vg@mail.gmail.com>
Message-ID: <CAPhsuW5rYmo+Vb5X8xODK9wpTD5kFqDAZiavoeS=xic37fJ6vg@mail.gmail.com>
Subject: Re: Generic Data Structure Iterators
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	yonghong.song@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:48=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
[...]
>
> Now having said this, I'm wondering whether anyone here has considered
> possibly solving this iterator based problem a little more
> generically? That is, by exposing a set of kfuncs that allow you to
> iterate over a list_head, hlist_head, rbtree, etc, independent of an
> underlying in-kernel type and similar to your *list_for_each*() based
> helpers that you'd typically find for each of these in-kernel generic
> data structures. If so, what were your findings when exploring this
> problem space?

Here are my 2 cents on this:

BPF iterators are designed to be really safe. So it is necessary to handle
locking/refcounting accurately in the helpers. AFAICT, it is hard to do
something universal, like list_for_each(), and still be safe.

If we can accept failures (user space core dump, etc.), we can use
kcore based solutions, such as crash and drgn.

Thanks,
Song

