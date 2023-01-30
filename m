Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AB681FC6
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 00:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjA3XlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 18:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3XlM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 18:41:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC722A23;
        Mon, 30 Jan 2023 15:41:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 7so8854348pga.1;
        Mon, 30 Jan 2023 15:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eFw+vUyxAlXvyIKzXin+BYmD1wliXJ2GCQPgnmMqPE=;
        b=Snt/OPG2tgQ8VVC0fHoRXK5F8u+MEs8vNfrE7F5EYVieTVuQnSTLLkj7I7UadmSNzB
         qBfPd7mdvtAie6eUa/SAWtMFRatf/cRsILFZLpc4PC/0CFsSZJiZbvwnvti2VzLA4zt6
         J/KbXXBo2XLxqQIk8ANh7C54MqVwqTJejwJ6j/FDOzvt6pS9ni09j3sAy7d8mF0mRsJn
         4L2M2mN8koQOmg7J+xMHItxyOj9Y4tGSYjU5bETIjJkCMGqsWC7Ezp5aAEdcpASIseRL
         qAjNqBa3ClOQ49VUuRaqZpezHZzhUwz1/toBEfoVqt6TtHqNWI+UC2cQObppQ2TifQMl
         Tx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eFw+vUyxAlXvyIKzXin+BYmD1wliXJ2GCQPgnmMqPE=;
        b=vbKlGO9tT343ywy5MLCyKfBCESTX5YuRBMBkrD7kI1EtyKG3U8lnDTFws7c1J8u7GG
         c9NMsfUgPuPhEm2G0Qh0McgTKknoOCqKMwHBfbfh4nxhwfEN5vJ4I7xJTWw30uyIQqZj
         Bbe8sIxf7k/4MErbPOSIxE1BPaAzDuzwDaDbL69L00Vez3QhnRSH3HUJy3bx+xOkO1rE
         to+xIkRaBnydq9bFYPmrcR0jiFrY0j92xhE/aGvPJcC6TiXTzkV42Hmt4TppJtBjhLKS
         cL+9WH2kUn7QnH2yHPgB906xN36KIRVM591SUGWqQ+k4iMd64DE61h1x+yWVTVlY/owT
         u0dw==
X-Gm-Message-State: AO0yUKUGIfr9+wVu1nSTe7bpfQq73iRVjPV05b++BQBwJQiJdH+BiDNb
        VDTigHbLEf2zka6YTnanCgA=
X-Google-Smtp-Source: AK7set91W+OMws+4fUqP4r4tKzPFUXR3RfGq0xeU4+1VuTm6Jw8XNrpgKH4YxYrPfmJMkJejYoWgSg==
X-Received: by 2002:a05:6a00:2123:b0:592:3e51:d881 with SMTP id n3-20020a056a00212300b005923e51d881mr17105931pfj.14.1675122068136;
        Mon, 30 Jan 2023 15:41:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e190-20020a621ec7000000b005809d382016sm7952191pfe.74.2023.01.30.15.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:41:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Jan 2023 13:41:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 23/30] sched_ext: Add cgroup support
Message-ID: <Y9hVkifLuMTYIW97@slm.duckdns.org>
References: <20230128001639.3510083-24-tj@kernel.org>
 <202301290107.J4Eavi26-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301290107.J4Eavi26-lkp@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 29, 2023 at 02:05:35AM +0800, kernel test robot wrote:
> Hi Tejun,
> 
> I love your patch! Perhaps something to improve:

Fixed the build bugs from the two lkp reports. Will include the right base
tag from the next posting.

Thanks.

-- 
tejun
