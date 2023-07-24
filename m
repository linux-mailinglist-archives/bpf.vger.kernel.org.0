Return-Path: <bpf+bounces-5709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDF75F35C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893EE1C20B4C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75768C05;
	Mon, 24 Jul 2023 10:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E008BFA
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 10:32:32 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA97BF
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 03:32:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4435fa903f2so966966137.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690194748; x=1690799548;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqU0ZHivlcSjqSqGmUSdPcVUboVZuiZTmbFJJNDkXyY=;
        b=gylbh1sPeUSxn/1II6Rwp1Qq5AdA9jYDRLKQYgVNuPXDVz6bL4VV9k+wjg26vXwAwC
         mBvb1pdolelVzPrc1DpKlFivKfwqvx5+vr9litjDWiJGiEEuvxGN0pWdMj2ehqqklPZQ
         rCOYZzJIwcEwM0tJSGr00vgu29nk5mA0pWPNKNHiBKPchF/ZSv4rG+pu91hDRe9xu3FB
         h2HPw/7acMrIMqCrE0NUq8YVDtSWcx7sRYsEKYR0FBLbj/tpypebceDHVqJ2tEFiwOxW
         O1WhvqLXo2A+dKhXT1oHbEyT+s49lz/bI/5WjFWA8K9sXYlN5N8aB6PzTuMLUnQUitov
         YeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194748; x=1690799548;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqU0ZHivlcSjqSqGmUSdPcVUboVZuiZTmbFJJNDkXyY=;
        b=Qms7qjtA/vKU5Cqzmwj7285J1oRrpAsKGugTCYXBltwHNnE3cfiWtzIFgRXz8m1C8H
         iRc4djz+JN9eYXJb218S7BXzPO32k6JI9UYG9+QbpYsN9EocGhnt5xsPEq5OrBgMICEm
         keBJMaHpWv9zYzS6zJd6LXR6daExuq6+fRM28KfnkNga4Vo+pXLkSnzm71P2Hkh2NFSF
         eElhtFaYH/GIMxQRh8QtTXnElpvKbnLBcUzo9g0eYRKF+byw9St0nXRNM2RVZ+r1Iaak
         RAp0iAnhsZf/ancfccOgxL2eXw+QWXPb0zQxWEHsSc7ilfXwBMo+y/Q8b6NgUkTqGAl2
         ssdQ==
X-Gm-Message-State: ABy/qLafLFGS2E19VO1gzYgVbKlgcqT3CjWFPaMWhYlYXDj7usQdsG8W
	xDnem2ryi2j3jyX8UGRUJtn+/gCunTxJMvK3IRPdr3SXjkA=
X-Google-Smtp-Source: APBJJlGqQWMvibHqLaFjgrRvAeolHaJQWqYPBhlNbb8moh8cqdTcjJZi7mljuhfeSvQ4jpR2r6St69GJB/Y+S1hVshA=
X-Received: by 2002:a67:eb96:0:b0:446:9cc3:ccf with SMTP id
 e22-20020a67eb96000000b004469cc30ccfmr1628274vso.28.1690194748668; Mon, 24
 Jul 2023 03:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Timofei Pushkin <pushkin.td@gmail.com>
Date: Mon, 24 Jul 2023 13:32:17 +0300
Message-ID: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
Subject: Question: CO-RE-enabled PT_REGS macros give strange results
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear BPF community,

I'm developing a perf_event BPF program which reads some register
values (frame and instruction pointers in particular) from the context
provided to it. I found that CO-RE-enabled PT_REGS macros give results
different from the results of the usual PT_REGS  macros. I run the
program on the same system I compiled it on, and so I cannot
understand why the results differ and which ones should I use?

From my tests, the results of the usual macros are the correct ones
(e.g. I can symbolize the instruction pointers I get this way), but
since I try to follow the CO-RE principle, it seems like I should be
using the CO-RE-enabled variants instead.

I did some experiments and found out that it is the
bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
change the results and not __builtin_preserve_access_index. But I
still don't get why exactly it changes the results.

Thank you in advance,
Timofei

