Return-Path: <bpf+bounces-56372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D813A95C78
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F77A1898348
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4719CD1B;
	Tue, 22 Apr 2025 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6LwoL/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678C18DB1A;
	Tue, 22 Apr 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291143; cv=none; b=aXgBUn8Gl66XJ5J1EEgrYmhgda9THSFYWoA+yg1DAa8us3ssqfICQs7lEQg0hb52Sqw3RTS0WGpjdT3TT5v2o565mq59owGkibgdiScLErXIP2BmniQuEuCmGgyPP1qIT4Ll6psPqSf/yp7h+SJ810DhQN5sQMAAGpC90xty+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291143; c=relaxed/simple;
	bh=+f/HJlhJlRazFf4bfzmKLwnvBqH6IvbWdVd+86KV2dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGr04OrDaUSz3LVU91vM5KDpT6kFU7S0VHSWfu0ZEPezv3pCCiJWW0KrQZQBjpE/+PI8UE+lGN3aLtbV2zjMPI4iT5FM1u1jdFmt9U4fm0+g5ECmW3efoEDRvn8JRHpX37zvza8VbHIeEi0XyZnlceeiRCMHyKYBnoQ0TjuhfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6LwoL/k; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso8365606a12.0;
        Mon, 21 Apr 2025 20:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745291140; x=1745895940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+f/HJlhJlRazFf4bfzmKLwnvBqH6IvbWdVd+86KV2dw=;
        b=e6LwoL/kAe8an9qrSDfqvOSKI7844DhgL/BgVr+aA9CMM+ePKSz591vjYMh9k9RVhg
         rMXL4gkprNcmyv4dS05OxMAf67OaJjdYWwtPKRkl1kBoD7d89jFhaD9cLZ9gIyRFFFs1
         xOwcn9Cih4/WRlIwDvyparbdFclPKITPCpPhe18tXGohNrtMny9+vbhYAkAT0h4P+5c0
         /rliiu8hj/XboygFfploT/woVgnB1Gw/BthNtP6h4mVDHGQ/oSZrQRdStK5TkuaQIzat
         G+8iElv5rv0FysMN+hGGixSnGE2d7zb6dIVvNW5cQ1d/Al8up4Iyh5C7K5pcUrMi5X5M
         mdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745291140; x=1745895940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f/HJlhJlRazFf4bfzmKLwnvBqH6IvbWdVd+86KV2dw=;
        b=CP0KRRqUtQH4cshJIXIwzhvfVHTJciKprm4SRs1Im2Zm1pSrnynLusPSStAhfmIPcR
         /wiHY7tN6kH2XXa27HwsriJ16VBESdrIASsF7kri1AW6YVd1gOVJj4R9qfDwUEeIsN9/
         AuMylmu5db0rRIbyvwXIWQbK47+D8t4JCArENMmdF7B8YqYm/374dOdMMB7FkguCUBGv
         x543VO9cjHKOImJmdmXhOpE8Y7fBRCEXcVQjKFXyGoTP6aotVL9VqS5JhhvGF+1RkY1L
         Cgm7bGqi+bDYQQgypggBrgWH8m80VWGmSj4kj0cmUTRmmymB2aAaqmaheMhukJvImk28
         r/NA==
X-Forwarded-Encrypted: i=1; AJvYcCW15NjVDlgWStrdw1QSDqrc7CnoOx8/ELa8AON308U7wBQlimtCciOfHEdH5cwnti1lIAO4MhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFNHLW3B3l7hf6SHBsbDK454ZNibx8vmWeRKLfqJphkyhQJUr
	Gyu39BjF2/Cd/eRdWU4Y9428jqb+T1+DVwiov9sAtTqKV1OmyBiYyNhcH3RpAvh7uWU5IVE/1o0
	Qe2iil50K94eIUIrsJdaQPFIhOrc=
X-Gm-Gg: ASbGnctsYNtxJcDbpStQb++KEvI1fY4tbEwj51Mx79Otl7jprkjCAQlry1BhTR1AwOK
	2AsG4IiByv3iFVFI6oLAhC/XYKE8kkJltW3pUhOEvdbI4c3byNTDpD4LqfAOj9fzmZ+5daX1WU4
	iL9TLMQpCr8s5df6xOLAd+3xYSgapAo255SmnU1+uQ9oraqHkPTRNODQ==
X-Google-Smtp-Source: AGHT+IE9xOUErtQYNaokTwT/MzZVkzhKr0c4Wm4f53sARntJInn18FJT5ynt3lM7N8QzLTp2tNWGdIM55ByRuGjySr0=
X-Received: by 2002:a17:906:c108:b0:ac7:ec31:deb0 with SMTP id
 a640c23a62f3a-acb74adb1b5mr844612466b.9.1745291139838; Mon, 21 Apr 2025
 20:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-9-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-9-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 05:05:03 +0200
X-Gm-Features: ATxdqUFTiBIv1hL636YZojfZbMSOaCY7TFb_kEHFg--oh3iDLvimd6QyOysOBfA
Message-ID: <CAP01T757bT+F5uMyz-LWZoyMuP=B_9qDuN=v7jmv58C9opL4WQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 08/12] bpf: Simplify reg0 marking for the
 list kfuncs that return a bpf_list_node pointer
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The next patch will add bpf_list_{front,back} kfuncs to peek the head
> and tail of a list. Both of them will return a 'struct bpf_list_node *'.
>
> Follow the earlier change for rbtree, this patch checks the
> return btf type is a 'struct bpf_list_node' pointer instead
> of checking each kfuncs individually to decide if
> mark_reg_graph_node should be called. This will make
> the bpf_list_{front,back} kfunc addition easier in
> the later patch.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

