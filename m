Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9B6C033D
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCSQrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSQrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 12:47:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB411E9E0;
        Sun, 19 Mar 2023 09:47:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id cu12so404494pfb.13;
        Sun, 19 Mar 2023 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679244439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNXdkCP379d0n05Ny7NdJBsoGvbBUIjiHT0jJjacijY=;
        b=AuMsBXhO5UfsM5LBAGd2t0YxCtEBtTAjA0cv1L/SqzlDbPjdDkXtx6kZpwopSOpk3Z
         byRhdn4ckFOqi1d+XTGBswTiFoSUCxA3rakf+WyTXMv+ZhAYeBcHy29PrfxnDHxtKkmH
         Hq8VwteKi6lfCrWCT4vUEXQblrlAflye6CsRjE5cPVT8NwxvUBV+kAZ7Y2W8pxxlL/4H
         otpokro2+cqaCYyryiQ5qcWFl9Pon1jW1PldBfeWk+vDLMSKAo1cpW5NoZ/wyG/W76ZQ
         he8EsuuZCcNyg2J2WFXK/IJgVbCVChLlTaZeddEctobIqpR6ZRBBTuqNflce+Kv3FjCO
         u3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679244439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNXdkCP379d0n05Ny7NdJBsoGvbBUIjiHT0jJjacijY=;
        b=IV3SEyTgnsR9p/BBj9VT5D1K77gUa4by7xQSrXM4N5el4qE1kHiTLTtPFJJdfwCODk
         UG+FWpp4KXRd8o145hMk8ht4CLke9AJUbDRU5chiiV0xerrPAokiPJpbIPsp3VuXQZZA
         XdsDZOdhcjLNtekzGoE1fG2boWn084Ak8pT6YnTQwPbRJjjPkD++EPoYyrd4tv2mw2lu
         4x9hzIOGwS7UqzP7Nk5n5vgqnnkhEMud+gXUTcCGSvVZDyAVqEWkUYGDhccVYC6TRnBA
         4hY/V71PkVuWbwKwYvPSBW4jEpPxhcJTaBuUULKsAvdwBYCsOmBwsVHj6h82qFAhMiL8
         p1yA==
X-Gm-Message-State: AO0yUKXqtTwszSmOy6aIs8EEXwDuIJc6iagng3M5/Fvd8zYhQRjP/Law
        D01wx6pg+RuErSDA77UgSag=
X-Google-Smtp-Source: AK7set9SKx04gv2R//75Mo/Nz9xxP//1h1Pxy9iJuxBTRVLGrP4ukKQJBNBBBEMiYV+X8noi5NNZmA==
X-Received: by 2002:aa7:949d:0:b0:624:ac1a:a9dd with SMTP id z29-20020aa7949d000000b00624ac1aa9ddmr13084729pfk.31.1679244438691;
        Sun, 19 Mar 2023 09:47:18 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:2bcf])
        by smtp.gmail.com with ESMTPSA id 207-20020a6301d8000000b0050bd4bb900csm4770016pgb.71.2023.03.19.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:47:17 -0700 (PDT)
Date:   Sun, 19 Mar 2023 09:47:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Teng Qi <starmiku1207184332@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
Subject: Re: [PATCH v2] kernel: bpf: stackmap: fix a possible sleep-in-atomic
 bug in bpf_mmap_unlock_get_irq_work()
Message-ID: <20230319164714.zu6kqylibrzug4ja@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230317035227.22293-1-starmiku1207184332@gmail.com>
 <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALyQVayJaZ_s9yuL07ReZRmTT52ua7B+92CdYnLi9GiegpOKNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALyQVayJaZ_s9yuL07ReZRmTT52ua7B+92CdYnLi9GiegpOKNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 19, 2023 at 02:12:49AM +0800, Teng Qi wrote:
> Regarding the first problem, our tool discovered a possible code path that
> 
> starts from mmap_read_unlock() and leads to sleep in kernel v6.3-rc2 source
> 
> code.
> 
> 
> 
> kernel/bpf/mmap_unlock_work.h:52 mmap_read_unlock(mm);
> 
> include/linux/mmap_lock.h:144 up_read(&mm->mmap_lock);
> 
> kernel/locking/rwsem.c:1616 __up_read(sem);
> 
> kernel/locking/rwsem.c:1352 rwsem_wake(sem);
> 
> kernel/locking/rwsem.c:1211 rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> 
> kernel/locking/rwsem.c:566 wake_q_add_safe(wake_q, tsk);
> 
> kernel/sched/core.c:990 put_task_struct(task);
> 
> include/linux/sched/task.h:119 __put_task_struct(t);
> 
> kernel/fork.c:857 exit_creds(tsk);
> 
> kernel/cred.c:172 put_cred(cred);
> 
> include/linux/cred.h:288 __put_cred(cred);
> 
> kernel/cred.c:151 put_cred_rcu(&cred->rcu);
> 
> kernel/cred.c:121 put_group_info(cred->group_info);
> 
> include/linux/cred.h:53 groups_free(group_info);
> 
> kernel/groups.c:31 kvfree(group_info);
> 
> mm/util.c:647 vfree(addr); <- oops, sleep when size of group_info is large
> 
> 
> 
> However, we cannot guarantee that this code path will be triggered during
> 
> runtime since it was generated by a static analysis tool.

So it is a purely theoretical issue and out of thousands users of up_read()
you've decided to fix one where it is called form mmap_read_unlock().
Why?

You also see that __up_read is doing preempt_disable and then calls rwsem_wake()
which will theoretically can call vfree() with "oops", right?
So agian, why target mmap_read_unlock() ?
