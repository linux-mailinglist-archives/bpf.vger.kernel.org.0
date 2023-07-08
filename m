Return-Path: <bpf+bounces-4502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A074BA7E
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 02:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD98E1C2110D
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096410EB;
	Sat,  8 Jul 2023 00:15:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688F10E3
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 00:15:12 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB319B2
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 17:15:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66872bfa48aso4014324b3a.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688775310; x=1691367310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nETmYJjgT8aoTFOsp8DLKXk+glLs0WNsSqhpsY5wWJg=;
        b=MHyqpcROOsORiRuiig5QS97hOe5HhZFl3Tt54WjbYvip6fb6JMsMsqcFJ6sK75U84M
         htn1+uBCqrpZ2M+dPnHVW59TTkffvZCiRUxEdwYUAQhdV3Y2jXC2VaOaCXSec058PZ97
         eTOGRz3UCPBv0AuVNX/5lWj0tpObuomQVAcAjDsFTxGI4KfZYqUsyrEm7Kx2+0UzcCyS
         JfsWBIogpPx6vOOWLwRjxmVU4Ah8yGzWO8INL9k/6F/8y5nZy91aJ7NoEs+XmKd9/yZS
         Dcq2X4C1lHNmwbLPnX0DfoflDqgcU6CbNfA2Q7CtWvi57vgx/bnjvyK8mH9I6ApU/jQB
         Vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688775310; x=1691367310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nETmYJjgT8aoTFOsp8DLKXk+glLs0WNsSqhpsY5wWJg=;
        b=MMpI71gT8P0fVDsLl0PqChB2X7mJPup7eFoblbmaXk0muhqMFqqMHxMPyRz9jv0gCl
         JhKyK9DxO+brbkcps2k+w4fLtYFhwW7z1zUkk4seOfYuNCdDhtWFPKlqCEXThM+mwGqb
         h8MpaA6P5gmeR+986eXjuMuSKEeE4rJCV1wQ7TjFbQYUQyzSmiXqQ9cXorh6RyfOyffp
         +nuA4w2xmlpVH6Z2h56SjWsWOicxuQJIzYiSVmTHBCLwGWyGctxG1J/DvzexxYF+ybS3
         3WlEL7MXDE1e/+sS8ruxWZQmii3/qcbwYHvj8saxCVZ8rXUbZek6/fvKHqTuodew3jw0
         NGAA==
X-Gm-Message-State: ABy/qLZxNa5TXIpce8zskPLA+Srk6TTC4rMZXEiqZuhz0xw4BjZsBeQ4
	RY8bMOVu+sINATe32X3OSrKvoZE=
X-Google-Smtp-Source: APBJJlFEc+cYhmAlo3tI45jURaJmwcNhv5hLHkov61yQJgZ28+zNvXA2cNzpYGCwt2UsNlO7OuFpOvo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8890:0:b0:668:7512:7c49 with SMTP id
 z16-20020aa78890000000b0066875127c49mr9252588pfe.5.1688775310535; Fri, 07 Jul
 2023 17:15:10 -0700 (PDT)
Date: Fri, 7 Jul 2023 17:15:09 -0700
In-Reply-To: <20230707231156.1711948-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707231156.1711948-1-andrii@kernel.org>
Message-ID: <ZKiqjS03rRlALV7z@google.com>
Subject: Re: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/07, Andrii Nakryiko wrote:
> Don't reset recorded sec_def handler unconditionally on
> bpf_program__set_type(). There are two situations where this is wrong.
> 
> First, if the program type didn't actually change. In that case original
> SEC handler should work just fine.
> 
> Second, catch-all custom SEC handler is supposed to work with any BPF
> program type and SEC() annotation, so it also doesn't make sense to
> reset that.
> 
> This patch fixes both issues. This was reported recently in the context
> of breaking perf tool, which uses custom catch-all handler for fancy BPF
> prologue generation logic. This patch should fix the issue.
> 
>   [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90686db50d@amd.com/
> 
> Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

