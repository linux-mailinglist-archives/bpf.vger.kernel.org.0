Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08B6EACFC
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDUOcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjDUOct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 10:32:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D781700;
        Fri, 21 Apr 2023 07:32:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1915174b3a.2;
        Fri, 21 Apr 2023 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682087527; x=1684679527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKDz2VHpFBglJoWx92yV80JbTCBVsrzDLB/aXuxYn7k=;
        b=ltXM4AlOnELHD2rT+GbhgCb88ip1hWJV7dJsLlerzzZcvSs3NxFybmmyGrqG/ItvOy
         2cTdRD2HBNGQ3fI1XEePdUp98Wqc2rUXhTVs/SBFmISGKDrfS/BjgNtkfxocmZCi8kua
         BvksrgLW5e/H4mzcB/ZMw9HMO+4xSidWtr5Uz/6nO6POZzjEGUFFSxCLwWLL5mwAG9dd
         3i5PxmWJGeeRTYLVyaZ3rv/jKgcFMEwWDS45ujq6euEu8KQxYSvzoAjGf8/+lPPLGoHR
         oYYQ18dAwopIIgGlm4IisWOFF5GO4HSsEZLrNtSeGCr/rRK2nVYzDmeETxq5/i52p3yA
         sRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087527; x=1684679527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKDz2VHpFBglJoWx92yV80JbTCBVsrzDLB/aXuxYn7k=;
        b=ECmmISS1zXsz1skAvz72ogGDzUUpTh3F+BHMgeBaQwKit2EOY1mqcYAEtHuxX6Xs5W
         lisRJdKyAr7VAuZZ1L2I3vljxKLnXuQYLm1wxmmqulMbToOYa4bqsyEfJ9GKiIAmnBuR
         vj7/2D9jFM8iVdlSn90U0jvDAOmI2qaqjG2m7aaHDjIJJvxaBRLUijHYSpa/nRK0v9O0
         6QXZ9TKuoJt1JKJIkDhNfC650bIGTp7bvtp/rhC9wH6yoQjciv0mfmAOyiY9C16w0bMY
         q/WOcXshkrPyG0rO53sHJxdxpubkFSVpMcDo/Q6+4z/yCPCUWnfO8HRq+6NrYKXH3fdR
         emXw==
X-Gm-Message-State: AAQBX9fv/OzoivjgKM6qD33N05cTRB2sqVJOPzkH2cnFMMMr5uplQnBD
        /yuMAGSf2tESFiTe7X2NrtE=
X-Google-Smtp-Source: AKy350ZCsPjHGHo3yUgkWG/vVX55EVxASCuC+pXoAwL+OTbbpyG9pnlp4y8BUcCz0XORvQXbwzlc9Q==
X-Received: by 2002:a17:902:e80a:b0:1a8:32e:3256 with SMTP id u10-20020a170902e80a00b001a8032e3256mr6665679plg.35.1682087527036;
        Fri, 21 Apr 2023 07:32:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090ae59200b00246a7401d23sm2767350pjz.41.2023.04.21.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:32:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Apr 2023 04:32:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 24/32] sched_ext: Add cgroup support
Message-ID: <ZEKeZf3BwuUacRWT@slm.duckdns.org>
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-25-tj@kernel.org>
 <ZEGaZ+lQL7pHpmY5@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGaZ+lQL7pHpmY5@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Thu, Apr 20, 2023 at 10:02:47PM +0200, Andrea Righi wrote:
> ^ #ifdef CONFIG_CGROUP_SCHED, otherwise we may get build errors, like:
> 
> kernel/sched/ext.c:4251:34: error: 'struct task_struct' has no member named 'sched_task_group'

Oops, thanks for spotting that. Will fix.

-- 
tejun
