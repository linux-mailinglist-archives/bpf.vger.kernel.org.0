Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5B54D35D
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348559AbiFOVKd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244672AbiFOVKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 17:10:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01754005;
        Wed, 15 Jun 2022 14:10:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq6so25613811ejb.11;
        Wed, 15 Jun 2022 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+e5WSuTokr9JPK19yT3iV5VjDMxp0CsMqUd82dkDfNw=;
        b=E7fl3/tfPrJIHXOdi2ZLg0bezkWJaCCVssMcntFzW/rG8qML0Lg9+RaHh/fS9w71G+
         hx6lM2B7obpx8AnKtQHbJGeFl2nhzgF63kN9dnhO/N1WB5B6PyiV64N2IOUPyHXF/Pav
         fuQaYfTeesgH1MMdHRdpvvf3JzYLKQoxf7PzincM96t5gIA81WMe3vyLsYagwjC+7+LZ
         uHKv6zvPg2ctlnWnBzD+20nv0gXMV647gBgoKkqCJvJMMxrrhKJsUcjWBYzCO3OuKzZe
         KxVyYZ0i57LGZGmEGeYzXmB/pawwrdtjmak5KO0cZd7qxxGMbhcSZACiPFV17M0vy0G4
         fjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+e5WSuTokr9JPK19yT3iV5VjDMxp0CsMqUd82dkDfNw=;
        b=DbDYzch5EhjXVYZsLiH+IxMAxpNUbkhJ9nao1Srk2p/qhhqyUEr2FsJkvN/rz+jNN4
         9aQhio54zGhIloLWK3LBi1ANk0/4E0of9FNCyYJ2IwpAx0IaGzeMf6A6d/kI1x71NUIQ
         w89XFKqdkGY+yZGVf1t86s5jzzdZsMffWjGr0Ulxe/vp8JGlP3yHswSk87efFLassi8m
         jap3lvDIvWn7CSbTmhOmGKHofmCbv6J5J8nEcSpzFFkDnaOholx57ftTnLxJWQFCKu+x
         3IhzGBgwuXWV5JoPXq0nqxjc5k84yGzOPSPQzGoAuiEzhg5zHp+bCGrJTKMPIpsYXqPN
         CbBg==
X-Gm-Message-State: AJIora+A882bDpBTk64zrFL88crPiE4EtMVH5QIbJQO1JAuh3Z6JEpck
        vEdPhvRcq/cFwbiaj10vLJc=
X-Google-Smtp-Source: AGRyM1u2aR6m0+zusfzkc1IccfcreBIzvcK7QxJ4O76ZRZ1UqhFZa/ZvZ0x6LAv/HuZhPMsRoDvsvw==
X-Received: by 2002:a17:907:97c4:b0:711:ea9a:103b with SMTP id js4-20020a17090797c400b00711ea9a103bmr1657077ejc.155.1655327430278;
        Wed, 15 Jun 2022 14:10:30 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id ch25-20020a0564021bd900b0042dd4ccccf5sm171123edb.82.2022.06.15.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:10:29 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:09:28 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220615210928.6asl44eqiznvnyef@erthalion.local>
References: <20220615195501.15597-1-songliubraving@fb.com>
 <D96E92E8-46A2-440C-AF8B-71BADA60C5D9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D96E92E8-46A2-440C-AF8B-71BADA60C5D9@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, Jun 15, 2022 at 08:27:41PM +0000, Song Liu wrote:
>
> > On Jun 15, 2022, at 12:55 PM, Song Liu <9erthalion6@gmail.com> wrote:
>
> This is not the right way to change author of a commit, as it still keeps
> your email. You need
>
> git commit --amend --author="Song Liu <songliubraving@fb.com>"

Thanks, I was thinking the --from key would be enough. Let me get a
second try.
