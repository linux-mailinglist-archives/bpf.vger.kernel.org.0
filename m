Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF9592D11
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiHOJoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 05:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiHOJoh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 05:44:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C282250B;
        Mon, 15 Aug 2022 02:44:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so8889896edd.13;
        Mon, 15 Aug 2022 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=f6h5YvnnhUBTVA2/77kd5JhLYGCJQmP66s+igL3NlOE=;
        b=jOzwbKkUhnit+kSc3f7FEboyZKhP/xwrtiWbkz9oKw7d4uwnoL+B6BiggWJwUQxlID
         D+Vm2/azR63JPfbRkBmbJa3taWE/lFYP/Jx64n0k6LvvObmjUrW+NC/PQJzTI+VCWuxh
         YbPEy7sDt1mNJ+WlZnrMrAPsXq7hYbsBnvvHHmQLqnE5E4ApVy3vg1tnhFRAnNdPFvny
         lv4FEsyv8uaYjZ22iuBeWAN9EaQ8urRcC2mvc4x8GTzNmdY21douLB1egiG5hs+7cK28
         V3jUudGGZgAsIjPyZM291cOAGHNVmdbi6tEUbnicUq866U0EMUXlNfT0ELcDzuOGb8Z3
         TVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=f6h5YvnnhUBTVA2/77kd5JhLYGCJQmP66s+igL3NlOE=;
        b=kSaXfShAmxZWujyiPZRrpH6eXRNmokFCPxuHymytGjtwUnIdhj66XzGlUMbdNrkCSU
         lmlRpa1htOBQK1V0Nc9G6GvEtPCyXEBd/rJE28HqnhKu9gi3V1sqV81sP++E5Pq404WO
         Qc9u268Ti0CDrvmH4Vesp948V24MFa6eWQF8V11aGdjUj+MOOjDYQVGff6S9WqUD216v
         7ME8JJuwOHsUbDAzb53ed+bmDbsQxhxxKZ8Z6JqBS482dgWkanrdvHi5/1l4GI981rxI
         zwArTRxBcUZc08Www4/XnYCHY0f1V8yurV8AbU9oFMIL0z/d3AhthjW7LzLVwz2Q/eO1
         B43Q==
X-Gm-Message-State: ACgBeo3VA9R8rJxf/hPew7FFCAjiECtEZV8gLonOUEwhZbtsh/SQHpYR
        OVZKEsELzPNSpp79/Ibqmf4=
X-Google-Smtp-Source: AA6agR43tIiHOhUKUkkocih6rFXzyNyrWIyC6VkVxFU8U2Z/uDFVVah/uCDEbRz0yKpZbpTUIZyKUg==
X-Received: by 2002:a05:6402:35d5:b0:43d:a02f:cbfb with SMTP id z21-20020a05640235d500b0043da02fcbfbmr13400449edc.275.1660556674984;
        Mon, 15 Aug 2022 02:44:34 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906379a00b007308fab3eb7sm3844720ejc.195.2022.08.15.02.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:44:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 11:44:32 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YvoVgMzMuQbAEayk@krava>
References: <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 10:03:17AM +0200, Peter Zijlstra wrote:
> On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > On Fri, 12 Aug 2022 23:18:15 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > the patch below moves the bpf function into sepatate object and switches
> > > off the -mrecord-mcount for it.. so the function gets profile call
> > > generated but it's not visible to ftrace
> 
> Why ?!?

there's bpf dispatcher code that updates bpf_dispatcher_xdp_func
function with bpf_arch_text_poke and that can race with ftrace update
if the function is traced

the idea to solve it is to 'mark' the function independent of ftrace,
and add a way to make the function invissible to ftrace but with the
profile code fentry call generated

jirka
