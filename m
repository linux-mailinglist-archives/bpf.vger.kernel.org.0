Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B25A174E
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiHYQ54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiHYQ5z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 12:57:55 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBCAF482;
        Thu, 25 Aug 2022 09:57:54 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11cb3c811d9so23985279fac.1;
        Thu, 25 Aug 2022 09:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vZPkATes42g9Rf3ZT8P2sPxyGQKWOzKNeKbkEMB+isI=;
        b=Zs8Wwkqtvt4Pkx9XxbO1vMmM+3DYh4uEj39R4ohr4PhUDwVE3fe8SFoXIldMijjUaU
         Tt8BqHCoLALvqrstLw79lcP7YsmW1tW9O/ObAYzf4gjmCTnJiMnlRWbVnX/VqYB0ZGLI
         hQ5cPD7+20BYNjW2/h/8+9GPPikij07f8RKm2vYyhvP5+y+KI8QQtofZfP//9NKERmsi
         QzFVMuhI74eneSMut2T6iZtVovks++Di3UfIkpF4EmzfwyJS+IzRmHsn5TOvdUBYWcmf
         RI2cyDb5IB711WZzS+KgyORToM13FztlZJh7xR7MaJ3LGc1FHSt/3infvXUk6ssay0tI
         9MkA==
X-Gm-Message-State: ACgBeo1DQl93EbMbjrR0+b4powj+CPwC5Kh92/5A46SjoMCZuVzg8adL
        JTMvXqS70uuC3oniQ3UOL5TWvSyWzV9X0SfVt1YBcHAla+U=
X-Google-Smtp-Source: AA6agR7HOBk5ejY6byXm1G1lhTs4b6AS9dBCcnGusX3T1fAPsNQaryeY4HbEUNsV2HG+3x2I+twH89sb5AHryI0TM5Q=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr20987oab.92.1661446673135; Thu, 25 Aug
 2022 09:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
 <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com> <6305b7e7c7709_6d4fc20869@john.notmuch>
In-Reply-To: <6305b7e7c7709_6d4fc20869@john.notmuch>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 Aug 2022 09:57:42 -0700
Message-ID: <CAM9d7chYaeHvEkq2zCKeA6FiO0wfC2LCGc-1Sj=KdS8oU-2iFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 10:32 PM John Fastabend
<john.fastabend@gmail.com> wrote:
> Namhyung Kim wrote:
> > Ok, now I think that I can use a bpf-output sw event.  It would need
> > another BPF program to write data to the event and the test program
> > can read it from BPF using this helper. :)
>
> Ah good idea. Feel free to carry my ACK to the v2 with the test.

Hmm.. it seems not to work because
1. bpf_output sw event doesn't have the overflow mechanism and it
   doesn't call the bpf program.
2. even if I added it, it couldn't run due to the recursion protection by
   bpf_prog_active.

Thanks,
Namhyung
