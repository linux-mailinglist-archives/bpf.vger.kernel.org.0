Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D16B8A6E
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCNFft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCNFfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:35:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2525E18
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:35:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cn6so1694320pjb.2
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678772140;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bq2cWFDh1W2DIHMBNaqZafdJDpBB4Wse74AHPlhtA4=;
        b=cTlXI1h4zS8U2fu8w2W5dd2SljBSXvg4uF5845K0Az4Vy1Ce4aWuP6DXVmtDCl9YIQ
         ZWXzzfJpgtzXMOPW4BVKmwsU9gcAfQN5R+f8Nh5FDkrBMnY+TEwFSVnYYIhue2WPqXEi
         3aRqigTcP3Frvalo8Al6HhJlR7gj3Re/S212t1eZI4ICTZPMPq7KLLWV8FDkV80qhKre
         /k8ya9lMzLXJV5Vgb9iMISROwKhSJXwi5A0Nds+nrKpqg6qN8YgqwtiPdnxmfRNAK4cW
         4V40oYdYQwPjQ2m0EnSeq6bJoplhYu3tzDss/Y0o8XsS4FhljCSAe9dE6Vxxg0ZpJUDk
         qtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772140;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Bq2cWFDh1W2DIHMBNaqZafdJDpBB4Wse74AHPlhtA4=;
        b=3wrtdDFObbIpuwOqkMMoN86MEURCo4rwjPkaKD7GdPKT+RtdUOA5Vsm0v74A2Ul+Gm
         v/BXv2TSQlps9SlOSZ9zDiIzyOSF/IR+2k9nKjsAa8Wliq4jQM7ALCoOzfY2tTG7SRBQ
         ByeY2ruQyBUjbjNUp5Uob4Mvc4Ey065ZO9Tro42BYOVQYWUSPmCDmd9ntSNPBZZjGy+9
         fRvYyUAOZJVU1GTEEf9ZaiY8etYwYlpTUKOFfdq41et1XZNUIj3gni6DK/R0n3dEGiOw
         W9AatRrxr6E37D8lo3bIdWyiXOIOcz12cD6M2PbpuQ4/7KCBIokGqUMR5/Ap3cNR42Kq
         TBnw==
X-Gm-Message-State: AO0yUKVsDRxX5+ZQSwjZs+/dk9js+W7F++bnkhUhKSqY1Gwrea8AthEf
        XN3+3WWQhll9YJHfB5ssGgQ=
X-Google-Smtp-Source: AK7set/6KXTH0VMrh1q9ra0+K2wGduL/FVuKVqYZnj3VVKYc1W6v9hr2QP5ZSw9Bk8M3FVH/PxuNsA==
X-Received: by 2002:a05:6a20:a10e:b0:d4:f4c1:ec33 with SMTP id q14-20020a056a20a10e00b000d4f4c1ec33mr3658586pzk.6.1678772139880;
        Mon, 13 Mar 2023 22:35:39 -0700 (PDT)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78dc9000000b00571f66721aesm647311pfr.42.2023.03.13.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:35:39 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:35:38 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     patchwork-bot+netdevbpf@kernel.org,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com
Message-ID: <641007aa17a0a_42581208a0@john.notmuch>
In-Reply-To: <167875201690.9292.11466523661883628604.git-patchwork-notify@kernel.org>
References: <20230313214641.3731908-1-davemarchevsky@fb.com>
 <167875201690.9292.11466523661883628604.git-patchwork-notify@kernel.org>
Subject: Re: [PATCH v1 bpf-next] bpf: Disable migration when freeing stashed
 local kptr using obj drop
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

patchwork-bot+netdevbpf@ wrote:
> Hello:
> 
> This patch was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Mon, 13 Mar 2023 14:46:41 -0700 you wrote:
> > When a local kptr is stashed in a map and freed when the map goes away,
> > currently an error like the below appears:
> > 
> > [   39.195695] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u32:15/2875
> > [   39.196549] caller is bpf_mem_free+0x56/0xc0
> > [   39.196958] CPU: 15 PID: 2875 Comm: kworker/u32:15 Tainted: G           O       6.2.0-13016-g22df776a9a86 #4477
> > [   39.197897] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > [   39.198949] Workqueue: events_unbound bpf_map_free_deferred
> > [   39.199470] Call Trace:
> > [   39.199703]  <TASK>
> > [   39.199911]  dump_stack_lvl+0x60/0x70
> > [   39.200267]  check_preemption_disabled+0xbf/0xe0
> > [   39.200704]  bpf_mem_free+0x56/0xc0
> > [   39.201032]  ? bpf_obj_new_impl+0xa0/0xa0
> > [   39.201430]  bpf_obj_free_fields+0x1cd/0x200
> > [   39.201838]  array_map_free+0xad/0x220
> > [   39.202193]  ? finish_task_switch+0xe5/0x3c0
> > [   39.202614]  bpf_map_free_deferred+0xea/0x210
> > [   39.203006]  ? lockdep_hardirqs_on_prepare+0xe/0x220
> > [   39.203460]  process_one_work+0x64f/0xbe0
> > [   39.203822]  ? pwq_dec_nr_in_flight+0x110/0x110
> > [   39.204264]  ? do_raw_spin_lock+0x107/0x1c0
> > [   39.204662]  ? lockdep_hardirqs_on_prepare+0xe/0x220
> > [   39.205107]  worker_thread+0x74/0x7a0
> > [   39.205451]  ? process_one_work+0xbe0/0xbe0
> > [   39.205818]  kthread+0x171/0x1a0
> > [   39.206111]  ? kthread_complete_and_exit+0x20/0x20
> > [   39.206552]  ret_from_fork+0x1f/0x30
> > [   39.206886]  </TASK>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v1,bpf-next] bpf: Disable migration when freeing stashed local kptr using obj drop
>     https://git.kernel.org/bpf/bpf-next/c/9e36a204bd43
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

Alexei is quick but FWIW LGTM as well.
