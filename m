Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE05640334
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 10:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiLBJXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 04:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiLBJXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 04:23:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683BBD898
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 01:22:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669972924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jN/FnY85dfL2uWBcKIUq9YWjB9CWbQK73JR0ADLNweY=;
        b=tNwNfn2BoTpguFlNmMcCGmQZ57f7O5ptYfE84121JapxyM2IJS6BE1wxmO2v5OD+4hIId3
        j30CY9V70/llWqEDMevzxkyi3b/xUrUGErjYEpt4SosVrzw5D17UDthk5VGf/Ah5klEsTR
        BDjNlTy7+AtXsodKffEhS2UaniGsh8N8VEb9Lv8EaRrw8ioXllujlA/xs9slSAvChPrD2U
        xGlq4QE0E0zLwxHnmX5Jt7xJCEREBFIwkanT/MfjSMGCF4t1L3xGcOiorD4PFZuItCkvjF
        NO4cqd38O9swBp+D0Hiq5q5ccKgc+v7Fn5jOQUAV51+vkS1+LOiB4nkTq7vNNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669972924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jN/FnY85dfL2uWBcKIUq9YWjB9CWbQK73JR0ADLNweY=;
        b=mJcGxkkoiGFDkLQsDp4UFhcfjGwFIXBUDGVyb1LS6iaseGGipALH6oQ6ZGIsm5oaxAeixh
        RHi5kyqdadQ6p2Cw==
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
Date:   Fri, 02 Dec 2022 10:22:04 +0100
Message-ID: <878rjqqhxf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song!

On Fri, Dec 02 2022 at 00:38, Song Liu wrote:
> Thanks for all these suggestions!

Welcome.

> On Thu, Dec 1, 2022 at 5:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> You have to be aware, that the rodata space needs to be page granular
>> while text and data can really aggregate below the page alignment, but
>> again might have different alignment requirements.
>
> I don't quite follow why rodata space needs to be page granular. If text can
> go below page granular, rodata should also do that, no?

Of course it can, except for the case of ro_after_init_data, because
that needs to be RW during module_init() and is then switched to RO when
module_init() returns success. So for that you need page granular maps
per module, right?

Sure you can have a separate space for rodata and ro_after_init_data,
but as I said to Mike:

  "The point is, that rodata and ro_after_init_data is a pretty small
   portion of modules as far as my limited analysis of a distro build
   shows.

   The bulk is in text and data. So if we preserve 2M pages for text and
   for RW data and bite the bullet to split one 2M page for
   ro[_after_init_]data, we get the maximum benefit for the least
   complexity."

So under the assumption that rodata is small, it's questionable whether
the split of rodata and ro_after_init_data makes a lot of difference. It
might, but that needs to be investigated.

That's not a fundamental conceptual problem because adding a 4th type to
the concept we outlined so far is straight forward, right?

> I guess I will do my homework, and come back with as much information
> as possible for #1 + #2 + #3. Then, we can discuss whether it makes
> sense at all.

Correct. Please have a close look at the 11 architecture specific
module_alloc() variants so you can see what kind of tweaks and magic
they need, which lets you better specify the needs for the
initialization parameter set required.

> Does this sound like the right approach?

Very much so.

Thanks,

        tglx
