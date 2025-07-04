Return-Path: <bpf+bounces-62409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67669AF99A5
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA73B3B4B87
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F155204F9B;
	Fri,  4 Jul 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h69Jaubf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136B1EEE6
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650116; cv=none; b=LRcqAWg1hK6CjS7qfbvE6AuBxk1CSYzkDrYMpwI5KqoNyQaxvShmYjswH2YL7BcKmnKVpy/lcam8vU7m7hRXqsbHXZotiXH5IZkKX5SQBo8AOq2cNqst8eLPINNocurw2cBJ51Sb+nZ0+u8M9sd5XIHkh8nPmDP6UOdLk1tOVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650116; c=relaxed/simple;
	bh=265bJ3kUN0Ud8E5OLacD0s1Ts8hntCWvPzOqcz4Szpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppLNpo0XNdb10hkz7qajVp+o5O7jtPF+uNjlYAXd3O5S70847lpu2CWZ/+TvRcIOxLBwsa5ZtslezLq1g09aW8NxVSL2fMA/Tz7raF/NJFHnLZgq3EgIPIsFy9P//IeUVEhIc9csA69TZiAHBo4LTh8XRnIddm9cm16ABKS5/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h69Jaubf; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad572ba1347so163331466b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751650113; x=1752254913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFEfIQjMObSFaaAnPlPY9lpp2zJsEkb/oD3KLDkcA9s=;
        b=h69JaubfTgdZxud8ZFQ5IiuKspfYLj8XAFdjeFmQnzs4oTszf6M3A4+qcKv4s0SpQD
         LrhNnH4HPre6ZWnFTa2bXWko7gOyXGQFev1z9eu4ZE/PUWrfCyTEFPiF7nPKkXJxSRGw
         Zn78t0bF97uVKQAmAq3lxCdcjocwrMtzLsQagUT5zg1mb0VOzjTrQpvecIGjB7xwGS6q
         0OnK8W/xechsEmWaDOTKTUuULZXmkj1OEw4sZWGgRfS19xbd+umLTBm9aXQiidDxOpuJ
         mJQcUF0g+RAg9kLQEgheKU62MYlF1w8nzp7GeioQN1Na8fcpBz4SjI4vgNzjrAs+KNam
         sLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650113; x=1752254913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFEfIQjMObSFaaAnPlPY9lpp2zJsEkb/oD3KLDkcA9s=;
        b=lR+yhUjnOJXtGFSkWxOevKFeZDEIZtbmv9EPsOj0gbSUZ2WsSrkTBGphHCYIscxSmw
         6ts0+KLJH6S9av8RMfbWBXT5czVlgIwp831Hbo4HYCB3qccpjBnd3ymt55m1jY6e7UjZ
         kc3I6kZUUCSyCN2JZjSy2R84FR2+dcnQCUjNoQO0fmlK8Yvl0s9cm85HvnONCGz+shJw
         xQfkpiEDON3Yo0kaIf0hzV8AoBatrJ1CpPJCr/DXbn/0ihMcBNFmEAuKqGAMTDkWslTs
         EhusQpNFHx2A9jOEYgcD9jdyhRlfq3mQFKgqmtru+sVSMKH5Ues2A69KSQlm9ciECFft
         ZgqQ==
X-Gm-Message-State: AOJu0YxAubQBVMI6VHe/M5D8l0iwF3Qv4WYsp2QMPdTPlJrVip24JcUP
	pT54PVYUXnmSTR4XGM4qKKTEhbjMWmQTj2s8Q5cArVHVHkUGiO0p4uvmFjyiUV4E1ALhs1LqOF3
	mDWgSl/9B7Cj0732bTXNpWhDAZ7vSX+xJNFJnX4I2nw==
X-Gm-Gg: ASbGnctsdUPtdSms374HZmsYqs1800+6QW9lCuLwGA6PJ7T4Y2v0mhS8L02ptsDHVw1
	t2LLK7JjEmlx+d7GgeYYWw+OQjMn1UF8wEGLk4Ro6m0jO0jSLf76OyEdnSsYEVJe9BD2CSGshpj
	vtnE6J6XJYBwW2HZxVXUvKlorvMm3h/mmoafB2kMBQVmK3J2J+kpZyeOgtvuASHDFoOt7Q4/s1g
	1OAZ8Lox4yLHg==
X-Google-Smtp-Source: AGHT+IEi4Qxc0AnZOLrl2ZvQohNMI2wQZz+6r0GtyiWICLMaPTDCxtS+1NbZeK0RATozZ3OAH06xQ+VOxzmh/Kv4AOU=
X-Received: by 2002:a17:907:a701:b0:ae4:535:fc0 with SMTP id
 a640c23a62f3a-ae40535112dmr184725266b.57.1751650113185; Fri, 04 Jul 2025
 10:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-3-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-3-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 19:27:56 +0200
X-Gm-Features: Ac12FXwdMtXKaJ5CupQOrZgvgdPuyjOfUeBK9aYiSfjgR49A6yBBGb_qM6GDVRw
Message-ID: <CAP01T74tZiv8g1xucQd8TBFuXHo2Fikpb3be-P7ypJOfsYtQ2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: rdonly_untrusted_mem for btf id walk
 pointer leafs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:42, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> When processing a load from a PTR_TO_BTF_ID, the verifier calculates
> the type of the loaded structure field based on the load offset.
> For example, given the following types:
>
>   struct foo {
>     struct foo *a;
>     int *b;
>   } *p;
>
> The verifier would calculate the type of `p->a` as a pointer to
> `struct foo`. However, the type of `p->b` is currently calculated as a
> SCALAR_VALUE.
>
> This commit updates the logic for processing PTR_TO_BTF_ID to instead
> calculate the type of p->b as PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.
> This change allows further dereferencing of such pointers (using probe
> memory instructions).
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

