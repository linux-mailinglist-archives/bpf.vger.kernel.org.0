Return-Path: <bpf+bounces-21752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38E851C8E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4456D1F2351B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD363FB1D;
	Mon, 12 Feb 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2vzoDF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036763D556
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761691; cv=none; b=YooHaP54OjTVgcejVJYcNQiUnb/FOrTONIs7mWvRVO6WBRlztf7e4sYGn3f8vRfgb6U3XNcmiITqoyYN4LR2P9jTwqjY472FE0NNPYQGiL6b/9mlBCCH6Fo+HApo4arqLLarBKu9kW4idf3FYPOGSQuOadjYZmTMIDJ1uqdVfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761691; c=relaxed/simple;
	bh=y6kIj1m9I+a+9mFYx2ZeT01Y8L26QwyVeHIvVmeyQ2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZof0QLVJ3C294XQ1z7vQ9WUyc70bHijxkTkmujT1D+cTrj/H7OUCbakY27cazaF4v1/GaqJkGojWhInQyfxNcr5AUvOeKzA63pIEJfFt8uO9tErn8qfgUAaqglJ39bZ4/FU+7hJjlLlefqSybrMHewDyJRQg40e2S1A0EB7qAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy2vzoDF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339289fead2so2277505f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707761688; x=1708366488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6kIj1m9I+a+9mFYx2ZeT01Y8L26QwyVeHIvVmeyQ2o=;
        b=Uy2vzoDF9lJbyAZtsa54esI6ALF61bI/68ZSyahTR0xk9us+Ma0h5fmkVr67EEdq/6
         YMc5MPgFshuyYsJhiOl2/2aOH6atfNR3a27+GS5r1/ZFwyxdnP9au+7Fzyw2HwgtcIvs
         uaRvE3c5Jpoa5K5qv711GGN+wzQbPGCcs0oLQ5Sn6wr/+KDQLB33Z+s7s7JrwFnW5IOE
         zFDQ6Ho1xn29GVHfEHYTJraWNnEFYUlNSCj5vftlXUi+lJzuu7DSpIKDygo+K9sk3dkc
         kOf+dvtvdjAPfFiBf5hUAuxMfmKz98j8n7g+QblQAcXIdPBnDgUebpdT6b82OL1AZXFF
         1mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761688; x=1708366488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6kIj1m9I+a+9mFYx2ZeT01Y8L26QwyVeHIvVmeyQ2o=;
        b=VB8vTfyXRrdt283ggw3hXNl1aFoOYy2lRvFPsRqw5t+j5IwZ5gwzvFg5LHFL9VH+Tt
         hd6Fb1WIRjJkZV7FrvTHJgbCeto0RJgNmYLnvmk5Inowes8NHcTe1NkgOn+oTQQKShX7
         lS37cT3YZhViWnEbPqIJLJXTYLim2qmGF3U8824jde/SGiyowyUZA3FkdfM4elVz8kHj
         sZcqV2y0nSP8moQx2WDKMin78IYEf++z/cYQC0jlXrTNc0Vqq4cs87P7yzR8W+q0Lohd
         jHIp4SqmPyOy/jEUOAbeZdCw29tnT2rWaDa3rwKjdUB+UA1hZny1yfABYcaa8mWnWFF5
         mpdg==
X-Gm-Message-State: AOJu0YycQctDKa4+Qn+tlqDTeOW6WdIojr1PDU9H9JhIqGybw9caHOIw
	fZHYssMFLOUq8OjLD4xDFnwfatMGVEpL5cAZ0OB+gQVF9TR76SvmSdKQx9KjYmhP64CzuUCyygD
	q1jstt/emqVQtl+LXj9i9UipT3hY=
X-Google-Smtp-Source: AGHT+IGnzw6vjRsRWeSwIm+3UaqK/Nw+2KYF2nvj79gxX+5EhgUcWqVLhYDHBojnlRag+MJM5qnNz7lmLkn1Mm5d9b8=
X-Received: by 2002:a5d:64c6:0:b0:33b:734f:3a8d with SMTP id
 f6-20020a5d64c6000000b0033b734f3a8dmr5857370wri.4.1707761688063; Mon, 12 Feb
 2024 10:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <8dd6d3c0-6b76-480c-8fba-3b0e50fd9040@redhat.com>
In-Reply-To: <8dd6d3c0-6b76-480c-8fba-3b0e50fd9040@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 10:14:36 -0800
Message-ID: <CAADnVQ+nQuD1mNfe0ihX2fjAEGfBVtT=U+_ek8yD-uW=0GKbHA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/20] bpf: Introduce BPF arena.
To: David Hildenbrand <david@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:14=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> How easy is this to access+use by unprivileged userspace?

not possible. bpf arena requires cap_bpf + cap_perfmon.

> arena_vm_fault() seems to allocate new pages simply via
> alloc_page(GFP_KERNEL | __GFP_ZERO); No memory accounting, mlock limit
> checks etc.

Right. That's a bug. As Kumar commented on the patch 5 that it needs to
move to memcg accounting the way we do for all other maps.
It will be very similar to bpf_map_kmalloc_node().

