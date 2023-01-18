Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0D6728A4
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 20:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjARTmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 14:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjARTmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 14:42:36 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C725867D;
        Wed, 18 Jan 2023 11:42:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i65so23600164pfc.0;
        Wed, 18 Jan 2023 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K65UcviOlf6YVdTbw/WN8oMYq2A2Ccs69LPNY455PLw=;
        b=AaQBAhIcFZtmkzeSF+FZFFOg8NkgpVulhdR/F1A65spQ6QiIufjQ5w5Bwnd4qBh9ad
         zPYGZ/joQCNvJvRTqkCi3aRHpjzgIFwvHhNJVw4WjIpAKHPIvLu1p/UBwLifLPD08PCW
         jjBrL+LVhI+azdXZ6BzM//YupgvqAIrbAsyTp0mwXZtpzqCxXYL8l+k1grl2JytgtxqE
         oqn5uivAE4mOKP3gyggCrWQxWKhwodqSUvtcE1tQL/ai3JYEUwOHqIA9u6mTa4XdPC2G
         2vCNKl+DE0mjNLTVJV8qEg0YTMwF0cZBsS2Z+gnd7eGZHnZYf5T4UdluX6DqKyiVvbtt
         qn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K65UcviOlf6YVdTbw/WN8oMYq2A2Ccs69LPNY455PLw=;
        b=O7PHr5g4wz1ELbG9OaabItZLSE/x47S/6qSZdHJQLCILXDP64vsriK1z+8qDbhxj2L
         j97aDssORU3V6In1YJVkoS6ax0N+E66Sous6R894uByEFcV1TdlapawHHkaQdPcun5xF
         NwtIMsZVD3HJg+Gs4u7eD9dodSxa7keuIgx8hsB5Fr0MDizoLSs8jguZmXm0GgkyE4sQ
         Ill5oSotsinJlvRZqZXebp0REvZ4nlsdQvvf94/a0nhiWOVpxgFFeg0KD2gCf1AiAjzT
         NmtDDrnQhuknWslnjwp/dAdJHHOe7urftA4pMexWxEI1NByaGnlflFoK30NfkHH33iVt
         t5lA==
X-Gm-Message-State: AFqh2koJPTDlUMMjNqbmQ/wSGZYoz914iGtCBqE2Dcu+Werlvrbrvup8
        VM6WPdLD5rQUWTcNq4qdwbc=
X-Google-Smtp-Source: AMrXdXvX2j7CKzfEOpUE9eCBUUTALAZ2fh3LCsFYMEk2ZAqC58nLKUl3rax3Y6fF6Ea/WObz3gpwzw==
X-Received: by 2002:a62:3684:0:b0:574:3cde:385a with SMTP id d126-20020a623684000000b005743cde385amr8211479pfa.32.1674070954184;
        Wed, 18 Jan 2023 11:42:34 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:194d])
        by smtp.gmail.com with ESMTPSA id a203-20020a621ad4000000b00580e3917af7sm19323392pfa.117.2023.01.18.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:42:33 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:42:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF (v3)
Message-ID: <20230118194230.mqitrgfb3j73hzw4@MacBook-Pro-6.local>
References: <20230118060559.615653-1-namhyung@kernel.org>
 <Y8fO/Tro6wstoAeo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8fO/Tro6wstoAeo@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 18, 2023 at 11:50:37AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 17, 2023 at 10:05:51PM -0800, Namhyung Kim wrote:
> > Namhyung Kim (8):
> >   perf/core: Save the dynamic parts of sample data size
> >   perf/core: Add perf_sample_save_callchain() helper
> >   perf/core: Add perf_sample_save_raw_data() helper
> >   perf/core: Add perf_sample_save_brstack() helper
> >   perf/core: Set data->sample_flags in perf_prepare_sample()
> >   perf/core: Do not pass header for sample id init
> >   perf/core: Introduce perf_prepare_header()
> >   perf/core: Call perf_prepare_sample() before running BPF
> 
> Thanks!,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter.
The patches look good to me as well.
How do you want to route them bpf-next or tip ?

Namhyung,
I'd also like to see a follow up patch with a selftest/bpf for this.

BPF CI didn't have a chance to really test the set, since
there is a build issue on s390 due to llvm upstream repo.
We're aware and working on that.
