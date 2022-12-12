Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCA64A62A
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiLLRrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiLLRrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:47:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311013F45;
        Mon, 12 Dec 2022 09:47:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so5391641pll.0;
        Mon, 12 Dec 2022 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KIRaN3WDqmUUaVTW9iHZr2+iJnqBAu9ZpvcFSzezwk=;
        b=Spn2yU4s03YU4KB7Cu6/Z7pSfm1ajmNiJQBOnZeeVN05NmjaByr8rJW/Jw6lq1qftL
         mNggN1kjtKStCP+SRLpx/fMTD5WuEMe3Vyen2kf4KAbNe330+TfLFjHH4jXXwCIHBzU4
         m/iK3Yv8iRKoNq/zQ2H6zO4YH4Aksf0sKCITeOBaYl9E6JQ4MD363X3ik37owpNYmkuw
         +sjtCLo3V/X94d6XyZ3VXw6DpmsNM1i9beEh9X3+bXf4YkVVvyyRQK38M/jZpBByy3jb
         ULWbZ+Kbm/mZM3WCI9+2z08RZHwTtfrqj9N4r7ZsEnSiUYdWODN/f/iQfi4OgQP38tVJ
         0aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KIRaN3WDqmUUaVTW9iHZr2+iJnqBAu9ZpvcFSzezwk=;
        b=IH1WqNlks4t6Z2P6GyhpNEXGEvXnTm8iUZp2DUHGaG3JxLMOFkmWWfk5sbeF/wvudp
         /7sGLvoqzux84AfULfJawQdCDcasP9iSjFFsO3Tc5MqhMlwPCSe46PIuahT41oUtkAQr
         4AgFmzZQu4efEqN77nXetvjLd2yHnM82Ek60sPJeSDrMQ4iX4JtOV5hHVpIY3ebhRZtF
         BhIy17E1KooiyFIIIkwKlYV9voMcoIlGYg+p16nqvXg1MABjGbTYrTsGbzQql9nwTW58
         G0hWjthn/dHEJiw6x2iXpWfZFHSTwZphmooaTyhWGOmqYXrlDDiMeYN56HmYUt9MNjxu
         gzUg==
X-Gm-Message-State: ANoB5pmRFnBIRk9omZU5O0D6PVXumY359IXhoqzESgWoYNsS1BQSFXSc
        AbHpvS3hz5ECmiyG2z97Yko=
X-Google-Smtp-Source: AA0mqf5xxuWgOaHIdN3scLmRqly7RT8hB0qT/H62AfRpB24zxpIZ8cryvYmGAcXp4nYVppd3kvejww==
X-Received: by 2002:a17:902:dac3:b0:189:62f7:e5fc with SMTP id q3-20020a170902dac300b0018962f7e5fcmr22471235plx.14.1670867243287;
        Mon, 12 Dec 2022 09:47:23 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b00189f69c1aa0sm6650577plb.270.2022.12.12.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:47:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:47:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 08/31] sched: Expose css_tg() and __setscheduler_prio()
 in kernel/sched/sched.h
Message-ID: <Y5dpKXSnZ8ut3bwG@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-9-tj@kernel.org>
 <Y5cVZzcfqQ7nAm4p@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cVZzcfqQ7nAm4p@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 12:49:59PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:50PM -1000, Tejun Heo wrote:
> > These will be used by a new sched_class.
> 
> Uhhh.. wtf does a policy need __setscheduler_prio() for?

Whether a task is on sched_ext or not is determined by a few factors - the
chosen sched class of the task, whether the BPF scheduler is loaded and
whether it's using scx_bpf_switch_all(). That selection logic is implemented
in __setscheduler_prio(). When the BPF scheduler gets initialized and
exited, the selection changes and sched_ext needs to walk the tasks
reapplying the selection logic, so the export.

This ties together with the sched_enq_and_set_task() that you replied to in
another thread. Imma continue there.

-- 
tejun
