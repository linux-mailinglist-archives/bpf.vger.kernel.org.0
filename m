Return-Path: <bpf+bounces-10393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD587A6A4A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB161C20A80
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 17:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3F3AC1A;
	Tue, 19 Sep 2023 17:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571A347B9
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:56:06 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AC9E;
	Tue, 19 Sep 2023 10:56:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bed2c786eso5162218b3a.0;
        Tue, 19 Sep 2023 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146163; x=1695750963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzonaQ79d7wJ9qs7WU1NKwWXIzHEEFCVZuaiuHwUSFg=;
        b=DwWhvgQr9IHx/G8f5qKouJuv+45w3EpB2r/ZoougWWpLYR3DMjFcpPr3uTKaXNCTfz
         OnWWVX9UQtdjzeP8jd7G2Wqeua/JW2IVWROzZ3QD4pwSOZePvrrOZ9OR5Qywm98RRo/t
         YKmzRtAScEIduAZv56LTdcIyLvs2f5CUCeHUcfDgNPmIZ3gl+WNSXBoVv27lUjVdG5pT
         4KIM90EcGIGpYkQEqtmsGFWlrFyVwi9bPSoG2FB8xU/Iim05aw7Ei8v9LEwAk6dLwgfV
         Iai49uzf0w3WBfGP6FZbHZSwhy7EZIh3/p/6iXmL88CLMo57BV6rnCfgtqqz1uIiCr7v
         6NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146163; x=1695750963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzonaQ79d7wJ9qs7WU1NKwWXIzHEEFCVZuaiuHwUSFg=;
        b=VsEQT+IqnHAq/mnPGvtoojzLI0xEZUaCiX6jl3OfPwVXSPmnPJDz0Q4juoVVsX2DwU
         wwfwM0MC4uHsVX4S8bNJ9Pg9cBtztkjvmXf4QEywYBbChgGTeFDuYcIBU2WlSfbg/fLr
         LGWqkrkR3YlLVuW6u1ukGQVuTNYjS3nvRN8T+urJlX9AA9guogHXjGOiY2B/gZVd4lP8
         evRDB0BFKYvx7pDdDnyceN/Bw4KJDocdAnj2YfftoRN6bwwMezzREYvdjyIpLULDhlY0
         dNeHti7YYgD4p6bUh3Rhjo13gSCqZhk6qyXZ+Jho/Tm4RtSGWBm5AfPDALQfTcys4V8f
         9cWg==
X-Gm-Message-State: AOJu0Ywc2vDYSJ4hzf00T/o5KTN5ghtxgzmd1DJ4TTo7EwaJQRbuuj9C
	NzkmO2iCsCoWmof8ssx351M=
X-Google-Smtp-Source: AGHT+IFSOm++lO4qiGpS1SSP68TVsim82fK5+KFumC+bmZ0Wb1uqJABLU69ifDwKZ3w8Bhmne67umQ==
X-Received: by 2002:a17:903:228b:b0:1bf:5df2:8e97 with SMTP id b11-20020a170903228b00b001bf5df28e97mr198428plh.4.1695146162885;
        Tue, 19 Sep 2023 10:56:02 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001bbbbda70ccsm10247033plh.158.2023.09.19.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:56:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 19 Sep 2023 07:56:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZQngsfCdj0TJbEUL@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
 <20230817124457.b5dca734zcixqctu@suse.de>
 <ZOfMNEoqt45Qmo00@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOfMNEoqt45Qmo00@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Mel.

I don't think the discussion has reached a point where the points of
disagreements are sufficiently laid out from both sides. Do you have any
further thoughts?

Thanks.

-- 
tejun

