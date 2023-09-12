Return-Path: <bpf+bounces-9842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65D79DCC3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107BB1C20AC5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263513AC1;
	Tue, 12 Sep 2023 23:38:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CF1171C
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:38:15 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC4810FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:38:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so783703a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561893; x=1695166693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nC4/C3BBLtDM50UQlGU9Qhr3zk/fPtLbtDCYWIKj688=;
        b=gDQTtSnpRnHeSJQFbE4dt+hhxrgkq3JLJ0eymnyyXsOIaKRfVNdaUJa0Lqrep03qDc
         9RJOCAAcOc7Zii5b0hDjh7Hn6G58c1dIv/noJIydDtx0SFkDApvUOfDz1MQroaIeIdEX
         9OAFrUVO/6TAbjJXUtv1DQ5NE+uB4hfNZ0mqY814/mPMvekWHcltR1cfL0FFgIdIXbGe
         s8uNmHLO87FT2HmdAuHL+zBUuRyyDhxA6mZd7r9Tl1FaFbjpfrgbAQF0XNWzldq2wq++
         MMTGV8v4oKTM3Jc9ZkDLz959bLmbYZxIawVmCDJhm+to3GjGS8k3TzVbbQW5KalPl8qZ
         8euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561893; x=1695166693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC4/C3BBLtDM50UQlGU9Qhr3zk/fPtLbtDCYWIKj688=;
        b=cyo9mgRrjieU9f35kYb2vCg441+9esH3yyOUfp9GnocWCY1AB6fejX2BsinXGFYBCl
         6QZvPzhsoW4A1NF6SKLZ3ErQ6OXFVXnqZYE/qm+joGfxOtaRfTti1M2xq8CJlkJZJfkO
         UVcduNvLe8j8yBmjD0G3Vlrgm1+pY8Y4brPB+GuM8cMaJJP0HDD8G8RW6Fv8IPhmbOSP
         RItNBNXaOaPs3PTgxekWL3FZH66LhqDfhNSqOuvJ+WKzslL7snM+ReL+PDeYN7PJ0/Se
         bNutE9r6O/KHzQOAitbWN952IJcDoCpSB6+jDKkn5C98TF3oaTfMCtxs4ZdXkB8d2Bvn
         XKNw==
X-Gm-Message-State: AOJu0Yx38uOY3yoJo5/X3QC1a4s9N4XQV273W6IQIYhR6E/C6C2oYM2/
	N/qHoD3zw5S3Jm8FmcSDIIZNdcAdh8z4s7WgCdkAOjgQTf0=
X-Google-Smtp-Source: AGHT+IGb5teW5dyE+ML1sxej2uLIw7Eyqs4gZeqMF5cwodfJAxP+rl5/EnIrhQCjirTcBKCcRDhuwsM/3JTU2pXCZH0=
X-Received: by 2002:a05:6402:2694:b0:52e:4789:bee2 with SMTP id
 w20-20020a056402269400b0052e4789bee2mr6218877edd.6.1694561893310; Tue, 12 Sep
 2023 16:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com>
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Sep 2023 01:37:37 +0200
Message-ID: <CAP01T75Ho4gji-87Cp6C7EP+De_hbuJmW75No0=8E_tELOCyKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] Exceptions - 1/2
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Sept 2023 at 01:32, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> This series implements the _first_ part of the runtime and verifier
> support needed to enable BPF exceptions. Exceptions thrown from programs
> are processed as an immediate exit from the program, which unwinds all
> the active stack frames until the main stack frame, and returns to the
> BPF program's caller. The ability to perform this unwinding safely
> allows the program to test conditions that are always true at runtime
> but which the verifier has no visibility into.
>
> [...]

Hi everyone, just to make sure this is not missed, I had to revert
back to the ASM approach as I found the C approach to be too fragile
during testing. David asked whether we could move this facility into
libbpf as well, but I think with the current state it is probably
better to let things sit in bpf_experimental.h for a while.

The problem with BTF info generation for such ksyms still remains, I
tried and kept the (void)bpf_throw suggestion from Andrii but I'm not
sure it helps in every case, atleast with clang 17 I can reduce the
program to a simple case where it doesn't produce the BTF info needed
for successful loading. For now, another no-overhead solution can be
having a bpf_throw call that never executes in a static function that
is never used. The libbpf loading process will never append this to
the main program's instruction sequence (since unreferenced), it will
just be there in the object.

