Return-Path: <bpf+bounces-8240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE178416E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E787280EEC
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A81C2BF;
	Tue, 22 Aug 2023 13:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082A7F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:00:16 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E208CD1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:00:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so5416445a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692709213; x=1693314013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2eUuplzSRIEGKV1Ud+NslnfablQ6MA7uvbHJe8DDJk=;
        b=CF2HMwBu28ks0bi7qnjzJQLOjlmpmNQgpi7PnP/8uEmFQLEeWM4j9FXnXDJp0XCgXk
         zLT62l6TokK7BeW4PbiObevtBqbYTLtVCfP4j6Bh0hyvsbsSHDBSwymohz6O5kZKZ2mp
         H4n8zYFPOS/bC7yc2jRKEYnTpZoNzmiWRjbqSe7pjSfAQXiI9GGIeq/QWdriFpwExYSf
         f4/86o3WWcfziKgKqQcMQs5uNIS60WtkymtORPwIBxdjCSv7hv2Gmt//inp/zicV+JP0
         dcyJlCm1vu0fZZv1KDyROFo9J1SYOwWYtaQHheej7Iq/5Yz/+6xvAspA7IP2q3qBvyUY
         28RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709213; x=1693314013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2eUuplzSRIEGKV1Ud+NslnfablQ6MA7uvbHJe8DDJk=;
        b=M9/H3Di/lY8IMvIE8ngZyQIPS1WPIEom8aKWzpviwidDFj5hzvfieTjRE6eivZHZ4b
         b4YGsyNTHwsqXkD2jOpyVqU4p6gzYr5WkdyIwV8kxLF2sv3EuY9xVXvh1luwlwY7Ihys
         1SdnLsx3OTS0qvklVBv0QK+b7gays41mHRdXe2FPDgC4+ux4SnusHmGUtvFZGrPA/rSf
         KXTCrEgtX9Frimc2UNyrUYGxr0m2rSataS97/ePgaoF0uK2kOVap6B82twzBXomBU0RW
         sktcEo8Nxg8mr2qARakWyBSYwGZMTBth8rDEly8l2wF+5Aq6uKftzNdxTn/PyQ6ySs2m
         wxYg==
X-Gm-Message-State: AOJu0YwWfUFQzZ7CUOFj1tAthKjEj8jSCLFRxK6IvN6r6rxJ6wLD6hru
	8DFR6CdC5+wqmElPitnQuXiXOc80wD5xtA7h44g=
X-Google-Smtp-Source: AGHT+IH4rifg7a813k6RnWSVaNUaIbFhsy/enYDFc+Yi+WpvelDvqe/VevjU/Nx79+WMfu1ASjoZHW/516DApP9DHt4=
X-Received: by 2002:aa7:c648:0:b0:525:7e46:940 with SMTP id
 z8-20020aa7c648000000b005257e460940mr7631065edr.24.1692709212470; Tue, 22 Aug
 2023 06:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050053.2886960-1-yonghong.song@linux.dev>
In-Reply-To: <20230822050053.2886960-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 18:29:36 +0530
Message-ID: <CAP01T74=ZAQjH246Nsdp=m_MV9s5NTUBn2ftLFNMq0TL3M856Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a bpf_kptr_xchg() issue with
 local kptr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 10:31, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> When reviewing local percpu kptr support, Alexei discovered a bug
> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
> locally allocated obj type do not match ([1]). Missed struct btf_id
> comparison is the reason for the bug. This patch added such struct btf_id
> comparison and will flag verification failure if types do not match.
>
>   [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

