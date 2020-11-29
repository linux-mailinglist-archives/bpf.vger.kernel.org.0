Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67A2C7722
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgK2BQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgK2BQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:16:41 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F8C0613D1;
        Sat, 28 Nov 2020 17:15:55 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so7749832pfu.13;
        Sat, 28 Nov 2020 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nhgDak2gmcRsyajHqGgxRS9WORqPAav0kIUUw3T7Plc=;
        b=Yb1LcmeNbu8aAtGduGSGTKy4OY7Mec/GByVl5d8Fdmx4B+2eBfGWZvyKFHZuJlokuy
         ZFkY4yIuuAaNM3butWHC/eqraH+WxEMOuoYF8PU7sj4UBzWjzVOkW6Tkwraoitgfyxj6
         xctePttTsq96ntG380S4cgzeUzatG5pQd5jP289DPqvLXHgbxBrIj0xHzFU0HqZgqIWE
         OoUD3yVAATlJDlbS4GQ7B6LD+bNu+/OuWh1BuVPzwdPUg7J4TqCtsZxRweFFzcwgwDlO
         cfnV7V8qZzbfAHdQXlgVcQiUeQhc/QySh9ZeW1gaGPFrMfZFiE0+e2ptlxnuWKPJW9RI
         cuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhgDak2gmcRsyajHqGgxRS9WORqPAav0kIUUw3T7Plc=;
        b=IUpChq197q4MPwTc+epqUCsUG0OHZXc18iCKJ/hcVxmhZT+T2wSdE8Nh/0tr/TMRUx
         JsPe9nOXl+DIjv/cONBl4aQ4ZZFUAoAlt2gceHyEHDQtxbGMcGRr715NI4NLZwIGuXWe
         3VW286dp1uK1zSB1zUSdVRzJ8K66dOp7mOR7l/j7BKDhlobJPObzWzPO/NcwkElMEYDn
         GM8Vj/BCYO2h9TM4Oat91odghy8a/Xq8DwKmTR3hNKt7TJNWyVHgIQmh/C+NAfe7fHGV
         1TerMZX2Dq3XjEs2SBIiHHLvriXElRmox19cC+4Mu3k9bAVDvdfPnB7NgrawLMgQmMgW
         prHg==
X-Gm-Message-State: AOAM530Sxf0d7AIMjx9/iAxFwkJJl7CKqMKKSduYgkWYoWBVwtFkN66l
        cEWRaeC1xQnHXteqIEA8TfE=
X-Google-Smtp-Source: ABdhPJxJOQZl4uOjTcEwmA7B/l9tKhiVyNfNvSApgd9an00FF1nF93foouiPG+lHgLs14CDjlwO2tw==
X-Received: by 2002:a17:90a:384e:: with SMTP id l14mr19165408pjf.104.1606612555342;
        Sat, 28 Nov 2020 17:15:55 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id h16sm5100865pjt.43.2020.11.28.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:15:54 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:15:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of
 ModR/M for *(reg + off)
Message-ID: <20201129011552.jbepegeeo2lqv6ke@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-2-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127175738.1085417-2-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 05:57:26PM +0000, Brendan Jackman wrote:
> +/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
> +static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)

same concern as in the another patch. If you could avoid intel's puzzling names
like above it will make reviewing the patch easier.
