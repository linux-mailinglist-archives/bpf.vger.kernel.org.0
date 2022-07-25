Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE257F9CF
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiGYHAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiGYHAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:00:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5765BE14
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:00:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h9so14634466wrm.0
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=T/k7bs1dN/RlwhtDkhFpDvzqhulHevjIXq9jn2lCJ2U=;
        b=I50cxlhArgry4sHLmRXvP2xjzB7FkW/H9lT849xifNuiID+cTL+O7/ZSUmnbAIrCkV
         q1x4XupHdiyWC4KMzmW+H7d3FXkIhmXGrLVukeFBXHdv05tEl59hWZyxkWXfpfUaPmrY
         6TCZQNQ9RwSqmvwSS15d0YsKVbUFf6X75FoZcUaIM3qlDIGJ1Ajbkmi7VeZjwRXYICOj
         aUZITNNNddnlZqJ4fcUZ3pNyjSGP2ZPFFq1Zgu82O18/1p84MBmjWw9o3cGSJkKCvuBA
         17deCZm95BSkW84v7h38zQLNAca+v/zsMl4RXyASuK+CTxEmruYR59UkgQ3s+0JfwF8e
         gPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=T/k7bs1dN/RlwhtDkhFpDvzqhulHevjIXq9jn2lCJ2U=;
        b=hTwFnI8A6EBXMbfCc47AvF5Gw7IOZXn6OwF8V8SaFFmkjLfDF0o43GZe2pwnvo8KX7
         UgsKv7EBzAGl6TOnwAn8bRqVF8d0Uhp1kHXDMFIG/xdjm+kE5QeOE3jd+rWbrYFF1cKo
         qVw5NRZYFUeHfZ2vmi9usKGDGo3VCsN9OzaZjmMymJlkiHoqa3BOJCIcJmTfyN+xKit/
         k+oPqQJ6/4ybkUu7/3R0S16YCgNdrkpyMHMZpnrgeQ4BTUteurzgsbJ1KePbPAH1AhNH
         BevJB5nwuBKqan6SILu0Ut2IGszhabw4R6383/tkHryHjEri27zYT2JNP1tZa34uimuk
         jT+g==
X-Gm-Message-State: AJIora9ghqGtL8SCX5kL2LpoRXCCr3215QycUpaegFvHagk8j5i+qeVa
        BIJgwfrg3Gv9hnKJ5U2o+Cc=
X-Google-Smtp-Source: AGRyM1scaj7/YfkanjkfiMg+FmJ1CaxF+oWlJis4my4VZlbvrcp3AJnw/nJZeihzoW9CSxbWI+oEag==
X-Received: by 2002:a5d:620b:0:b0:21e:5b97:c826 with SMTP id y11-20020a5d620b000000b0021e5b97c826mr6398498wru.600.1658732447244;
        Mon, 25 Jul 2022 00:00:47 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c248500b003a3279b9037sm16619951wms.16.2022.07.25.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 00:00:43 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 25 Jul 2022 09:00:41 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yt4/mbWQly4VXMoZ@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <20220722235358.0eaa62d0@rorschach.local.home>
 <20220722235619.4bd4a0e1@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722235619.4bd4a0e1@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 11:56:19PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jul 2022 23:53:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > If you are interested in more details about the birth of fentry, here's
> > the email that started it all:
> > 
> >  https://lore.kernel.org/lkml/1258657614.22249.824.camel@gandalf.stny.rr.com/
> 
> And I was the one to suggest the "fentry" name as well.
> 
>  https://lore.kernel.org/lkml/1258720459.22249.1018.camel@gandalf.stny.rr.com/

ah, did not know that, thanks for sharing

jirka
