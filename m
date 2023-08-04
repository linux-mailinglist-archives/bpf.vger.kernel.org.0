Return-Path: <bpf+bounces-6909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD076F662
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 02:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52AD282380
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34C622;
	Fri,  4 Aug 2023 00:08:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B3161
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 00:08:50 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D63C20;
	Thu,  3 Aug 2023 17:08:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f94328a4so1076513b3a.0;
        Thu, 03 Aug 2023 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107729; x=1691712529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdGNo436RRR5piitT8Ey0vZmgRldp+adK8zxk8KlAPw=;
        b=Jc0XwZZWxCOuKCVHueS/60G6Z1XRwl3CZBdwjOdA3+eXm/Uob+q5xzqmiKYjCCAh9d
         Op+oN+qkpwDD2JSSD9PoiMzAscdq8Sk8gFYA4XfZQDDa6641tUSET8A8RNKiAw91mx82
         353TLvV3UznE4hPLeEFXbqO4+XIVITarZBuwiCda4ILnW/wXI5VMCpfOPvz++hrUDE6a
         L+8jkWuKlMjC7zXLHjIvYihOih4js+03GVNhzt1v5q2/9uPkKEbU8quDXXBzWHeu2H+p
         75CcQOcKW+GpgHOJk21ZelNZxx5bT8L+Mk5PTZXZyvGw3/m6VgGHf3RvmMBaZ7qtV4Nx
         /XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107729; x=1691712529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdGNo436RRR5piitT8Ey0vZmgRldp+adK8zxk8KlAPw=;
        b=hrmwia88KeoSiTWnvQXqmBSJDoKsH/bWRrC5oPqq8ETDk7KgeqFkSy7LwGmJwZcY4C
         UiAegrFVOV8HWQ2oDLMxgtg0Qd7SzKaZGWkZloWwxrYFPckfsM8qQR9OGQd3dNqF/cZ9
         7T6eezadVG7UyoxcwDNcIDj7d4ryZRpsDxqIkKuazQTMZpAw1zcrFy9shaY4mpf/CHI9
         Bk6G8B8Yq/24KRGW5ZhftWZa3fiqSaAO/cCi6q8/evC1Dphf4yEVfTqhLfOw+QPr4NKu
         cCSyFOWuXNRNurlSd+IbnroifcOS/feFb8x+KgqoEvqjj+ODx5L0aQosYbQYVWfQisRf
         7M7w==
X-Gm-Message-State: AOJu0YwOcnS2X+n4F6q4i7m3r0Yzjovj4fkk2JSeyRb3TZ6uxlGpgirq
	sns0hp05hUZpz4GDc+PsTRQ=
X-Google-Smtp-Source: AGHT+IGsIwoh1jqathDwtOrJuP/7vsHSia8epOOXFCFUOd65tgykMV4QHak+Il0BEzTmZfmEwZumeQ==
X-Received: by 2002:a05:6a21:338b:b0:132:ce08:1e28 with SMTP id yy11-20020a056a21338b00b00132ce081e28mr376085pzb.22.1691107728994;
        Thu, 03 Aug 2023 17:08:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id v9-20020aa78509000000b0068285a7f107sm387916pfn.177.2023.08.03.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:08:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 3 Aug 2023 14:08:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZMxBj6N6K3IBbMHk@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMMH1WiYlipR0byf@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

A gentle ping. I think it warrants further discussions.

Thanks.

-- 
tejun

