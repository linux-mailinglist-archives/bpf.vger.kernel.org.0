Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313E699A34
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPQf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 11:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBPQf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFECF4ECC8;
        Thu, 16 Feb 2023 08:35:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so5052844edv.3;
        Thu, 16 Feb 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9ZLZdKvW1QVCmUWsXtgHPZR5cuWnVGfKqKD47mtzUA=;
        b=KAZ0xYp++drIOklGW2WrpnwBMImSXOIkW8OONTj7yFEzHFzBQwzoH6BF67+jXlMtnY
         Z/XtC5J/yUWxcOf4ZLghWNaM1pyPiBIg+twhxdBVPNiqXzTHGEJ+h5KJ3mtfW/VzHpr7
         8WuZsnXskkbuDGN1QSU7gEOD91rbPF4ipLJazXqG5MBMrZmR+VPZpDP61dIi7n+NFT+o
         J8zyyb0iKwi3xtD5/hnCDgRSTIosoDgITLGU5pmA9rRz392tsC12fLngrU1EG83enydf
         mHLBZuaV9oBWYH2i7nhzSb4CnhbzF0/flXaZLNqcpEQezJrZjAjecpf6QYpwdOpukjc5
         VwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9ZLZdKvW1QVCmUWsXtgHPZR5cuWnVGfKqKD47mtzUA=;
        b=IQlUs8R/OxOPUoRq0PRz4Y77gOtsqugGzKQkdWpSprCjlUVm1WxcXV6AjN1xl/emV8
         f/DiEx5X9RGHCiG5vCmhhnkbVan1G1B8uWxTBdnUIZq4X6rVXiaSoyTnSMGh6BmTNuUI
         WziXYQs/PJSiMGrbOiDmkKEnnATQ1Yus+KPd+YaW+uFoiZ2mu9XDUnzuC2OcfrhnecF5
         yXKRMwG3nxpEWNA7j3dSR0iA4n//znfJUkkyF4VlYG5CZcTz+jAZdNsRWPv69g2dfdUs
         FYZur6z6mkZAXkowEWA17xhPDHURi2WUIvZZJMBPSSK9WUtla+SpS8tZjC4xzKnn4UhQ
         7exw==
X-Gm-Message-State: AO0yUKUI7biRJNewMue7ozGgn57/gioMUosSlSKwIGaPKiK5Ish+LKLn
        VqfnNOeTz8mXqiR8x+NiPOWEhQo/njX0HEXQDB0=
X-Google-Smtp-Source: AK7set/yQbfJr6jPNdlRCXcB2E8cqwTRu/Dw+/XSgBtyhOS+8ChyUo4BL5tNXIAKl5KqiKSv4Twt3k+pRBTABRW8i48=
X-Received: by 2002:a17:906:497:b0:883:ba3b:eb94 with SMTP id
 f23-20020a170906049700b00883ba3beb94mr3055424eja.3.1676565324200; Thu, 16 Feb
 2023 08:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo> <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com> <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com> <e16811cc-2d44-73a0-6430-d247605bc836@huaweicloud.com>
In-Reply-To: <e16811cc-2d44-73a0-6430-d247605bc836@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Feb 2023 08:35:12 -0800
Message-ID: <CAADnVQ+w9h4T6k+F5cLGVVx1jkHvKCF7=ki_Fb1oCp1SF1ZDNA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 5:55 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Beside BPF_REUSE_AFTER_RCU_GP, is BPF_FREE_AFTER_RCU_GP a feasible solution ?

The idea is for bpf_mem_free to wait normal RCU GP before adding
the elements back to the free list and free the elem to global kernel memory
only after both rcu and rcu_tasks_trace GPs as it's doing now.

> Its downside is that it will enforce sleep-able program to use
> bpf_rcu_read_{lock,unlock}() to access these returned pointers ?

sleepable can access elems without kptrs/spin_locks
even when not using rcu_read_lock, since it's safe, but there is uaf.
Some progs might be fine with it.
When sleepable needs to avoid uaf they will use bpf_rcu_read_lock.
