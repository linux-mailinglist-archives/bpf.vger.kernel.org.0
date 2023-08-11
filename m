Return-Path: <bpf+bounces-7509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC667784D3
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 03:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B150F281F70
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6E811;
	Fri, 11 Aug 2023 01:16:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECF7F1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 01:16:32 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E4B2D47;
	Thu, 10 Aug 2023 18:16:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-688142a392eso207889b3a.3;
        Thu, 10 Aug 2023 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691716591; x=1692321391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7A74P9LNG97yYutySLhIbBECqSrJ/IoJkCnqWAFDU4=;
        b=NM7Crc69h/P9zdkhwQuXjq3i8g8yyEut+oy6f8GuSqKfyt7MMwep+n5haSjgq7e6fA
         uyRJCl6mpV/gqTgx1GDJ6Xj6oyPa3XvM9c47tuhkIUHQvv8iXsz53Tiv2ZulggfwN9cS
         KVo3kvay8HmCqL4TrZeVbSrMnuhQXYHTsTHZeuk9m2ktY+224iapL403FN2qYPrUV69+
         1CKeg27d2BUAH05FDkB4x6xt+f+93Ca7GVauVIwkDwaT2CNprhHtxGYl2DiEsZDJTo93
         BScBGrN4Dy315948nCaauta5PjHKjv7dmpVmf/iaAhImV6cJeH8GuDmbVjSH8OpRXQnr
         A+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691716591; x=1692321391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7A74P9LNG97yYutySLhIbBECqSrJ/IoJkCnqWAFDU4=;
        b=VpNPAuUY7JU+teaz2FlkNgCWlcV7dMyS4f2ZN2Ytlch6nl2RWNwt+mHojLEPiK8v40
         2oFX9log1KmxDhFrjBtIup/umjij9xxhR5zTkY9ZouO4CeFAvPTBhE8Sb9U7JV7bzaq2
         uaqQyz/EdTGrh5Xm3ta3y+XDW824ThnOnRYYcxFBGZHkL1pLAbvsgbkkA1Blwq4xbnmr
         fWWULio5OTmOg3jk0tjBrFbGrsa3e3QviCa4fQm2YjSK32DrnnElm4PjL33oeMwhIa3y
         A59mOjP1UQ1cPSxvaMpzkrQVVbwXyCq4K4iOGpOifFfD2X9yCwFrmw2jn58Ivw/pXP86
         D9jQ==
X-Gm-Message-State: AOJu0YxwX89eLbV0rMS9sbYwpX8ObhNND8NJtDSBCEzg+DmYcUqlPQN3
	KucnqDEWW2EeUODNL70+G10=
X-Google-Smtp-Source: AGHT+IGTFO/cvizvZYCJMST8W44PMA1lVt8eNcY/AOXomuQuwi8bz6s53epM8VQ8q/RtAZRJ7SPE8g==
X-Received: by 2002:a17:902:ea02:b0:1b8:6cae:3570 with SMTP id s2-20020a170902ea0200b001b86cae3570mr594090plg.11.1691716590921;
        Thu, 10 Aug 2023 18:16:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:952e])
        by smtp.gmail.com with ESMTPSA id r7-20020a1709028bc700b001bb1f0605b2sm2413334plo.214.2023.08.10.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 18:16:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 10 Aug 2023 15:16:28 -1000
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
Message-ID: <ZNWL7NQjH1kWQ2sk@slm.duckdns.org>
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
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Another ping.

Thanks.

-- 
tejun

