Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0A64A678
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiLLSHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiLLSHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:07:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A912663;
        Mon, 12 Dec 2022 10:06:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d15so3283522pls.6;
        Mon, 12 Dec 2022 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21vllFG+Z7XQj9bX1Q/ZTIbRQO4PW5q6SuQhEbvBcOg=;
        b=gWUeK5C1NLmSnOnHhHTt1Jvbah+2mjCCBnz1DLjmHC02tA0+Fik3RaQ7gK8H2gJGRv
         wP1sDoJmahck7XHbJ8XQWYntNPBAMaAJeuKoqCBuN3OoVKVzKgsY+XnD57Wy35KI7Ta7
         L1gNRTZXbrHkYfaBDNjVKcof05ueVbS1RhySPhIUTy3dYqrS91MS/1GIzpJkTb9pdJTj
         ofHw0aclzIUI3bCDCnuZRhgXZTuknYtTe4eGjRwBKkjSkjYMCbGHZFfWwqjqYulakLTS
         JoCcYf29nKBqNN0wZFQ2hLvXyM+6qwLL/rzk6V9SgmlAsHXDd7gd8iRkCzMWNbpBboBT
         4/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21vllFG+Z7XQj9bX1Q/ZTIbRQO4PW5q6SuQhEbvBcOg=;
        b=gvtgY2YCfBZwS4AV+Z7ip5o0pUUeLqbhP8rgs6FtgvsK4uMr7/SdRqhfqPpOzZSOVv
         pY7kTJOa+mnDSZs1V9YyfwxTLkBlVbO2N6PlIXNPsFzXFmgiTIabd2cgm52uwmBZ3HGB
         ZGG1SBiWmwSyvO0DEg13bXRhehPnyqfds+l8qh5lcvtQarwzJCFIFZzaSDfqefbEjKD0
         dmT0G19KRaJFHNGd/IVegjYkWtaiSKWxkKueLQQzr5hjMjHMR80tKNTQtUsPDbJvb8St
         k3lXNyeJ3pbZ84rTLiTCHz3PMuKSMXfABzdm+l4NmbRpQ4C8yLEQQKybpQ5ppGAuLptK
         xgjw==
X-Gm-Message-State: ANoB5pmnU+Dq+1r2vmd/6DbboX09Iord4Zp1n6Sn9niQMO9B7B07AaGU
        iI0atc1YpeCOEMis/JKSMPE=
X-Google-Smtp-Source: AA0mqf5hzZ8OsX0fZnJQjoE+rdIyXLNCPURpIc6D/Lh0Bw2RKD8GchcHPa7kqUbVmSMkTAM6fY/dnw==
X-Received: by 2002:a17:903:251:b0:189:db2b:ac1a with SMTP id j17-20020a170903025100b00189db2bac1amr20138215plh.36.1670868417128;
        Mon, 12 Dec 2022 10:06:57 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b001894881842dsm6666385plg.151.2022.12.12.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:06:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 08:06:55 -1000
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
Subject: Re: [PATCH 10/31] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <Y5dtvxIpha/kja2l@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-11-tj@kernel.org>
 <Y5cXMMor2qZAj7Cw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cXMMor2qZAj7Cw@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 12:57:36PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:52PM -1000, Tejun Heo wrote:
> > ->rq_{on|off}line are called either during CPU hotplug or cpuset partition
> > updates. Let's add an argument to distinguish the two cases. The argument
> > will be used by a new sched_class to track CPU hotplug events.
> 
> Again, utter lack of why.

sched_ext wants to tell the BPF scheduler about CPU hotplugs in a way that's
synchronized with rq state changes, so it needs to distinguish the two
cases. Will update the description.

Thanks.

-- 
tejun
