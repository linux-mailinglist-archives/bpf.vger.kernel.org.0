Return-Path: <bpf+bounces-11990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81F7C64AC
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 07:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E35B282753
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED407D267;
	Thu, 12 Oct 2023 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsMqN34I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63D28EF
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:40:30 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F491
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:40:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso510882b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697089229; x=1697694029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTU++vj7KKiXdg5qf6JV1sH46X22s1hVyQQXsKxm+ag=;
        b=KsMqN34IVJjs40Au8+pMI1xQPT3IzqYzUXktCW3IVOtf/KCfWSUq9xZt+bkmjg1gCb
         pTN/ADuFIdQbY5dGVAU87uKGucIPOEPvbgx+4E5lGjzzeHgKzfIiXtGTCFIJXh5hn7Ab
         Z38/GhyhLh/rNNBs/EjvQD1kf8OJZsyfN7+RM7v4pv1dU3c9HYHiwQLaFGTTpFGBUiM7
         CWouHPAiR6Z0pzmkS3gT2Xnr/XJAmsmMciXkpaK0eOY0zHV+dts0EwMjP6OozVfugxCO
         BQA2lXI9p2d0mUut+l0i8d0PhFZmKSOmhCp3H1J1K/zUb6YqED5lY0Fw+QVN0/gT3OeD
         tC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697089229; x=1697694029;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTU++vj7KKiXdg5qf6JV1sH46X22s1hVyQQXsKxm+ag=;
        b=JChf7ugHzZEX3hJbYJ75ytMAeD0+Ygm5j9e6lLOsgWYOf2bDXI0FzW9neoF5rDrb8f
         f/KRDEXscVOhHg9dkktIviVcS3psYpfSJ/4X1fZqxQaFA4vB6j8JUjyAcB0vRI/NZqcf
         4xZhZ+mFZFUFQDcsaQZAtauzf5unaZg6VNAeloB65K3k6PnnmhnnZ/yZPogfiJ3CXHPp
         64+xueqy0uMtZCJ+1quJ87yELjur2SY+790Ly7Cz7mJLo9IeObcbLu//hL5TUu6GsfMy
         3tXlfguaHQSwU+S0a/MOaZXL2ldBto35nQ0Dc96tHVI00JPAo1KTAhXZSGUrXGo+PP21
         rGIg==
X-Gm-Message-State: AOJu0YwDBDjGBhemEm1P527TP5oinafMnuYU5KkoFEBAqKOjf6I2IQXK
	h0yPcw6wgfhAsoyxaBj87mI=
X-Google-Smtp-Source: AGHT+IF6rlRjl1lngn1JfVLAby51R7oYcUBkUbnX628xrX6tYE/tWyOUomFSTgYTSo1q5IOJkiPD6g==
X-Received: by 2002:a05:6a21:a586:b0:16b:bbca:4a5d with SMTP id gd6-20020a056a21a58600b0016bbbca4a5dmr16292779pzc.62.1697089228927;
        Wed, 11 Oct 2023 22:40:28 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:5969:89b6:5dd6:5429])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001bf5e24b2a8sm909750plk.174.2023.10.11.22.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:40:28 -0700 (PDT)
Date: Wed, 11 Oct 2023 22:40:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <652786cb45d6f_4a0102088f@john.notmuch>
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 0/5] BPF verifier log improvements
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> This patch set fixes ambiguity in BPF verifier log output of SCALAR register
> in the parts that emit umin/umax, smin/smax, etc ranges. See patch #4 for
> details.
> 
> Also, patch #5 fixes an issue with verifier log missing instruction context
> (state) output for conditionals that trigger precision marking. See details in
> the patch.
> 
> First two patches are just improvements to two selftests that are very flaky
> locally when run in parallel mode.
> 
> Patch #3 changes 'align' selftest to be less strict about exact verifier log
> output (which patch #4 changes, breaking lots of align tests as written). Now
> test does more of a register substate checks, mostly around expected var_off()
> values. This 'align' selftests is one of the more brittle ones and requires
> constant adjustment when verifier log output changes, without really catching
> any new issues. So hopefully these changes can minimize future support efforts
> for this specific set of tests.

LGTM, I had one question/comment in there but I don't think its too
important feel free to ignore if you like.

Acked-by: John Fastabend <john.fastabend@gmail.com>

