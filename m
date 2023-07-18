Return-Path: <bpf+bounces-5175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CE7581DB
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3495F2813D4
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BB13AD1;
	Tue, 18 Jul 2023 16:15:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B7101C2
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:15:16 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2ABE43
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 09:15:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso36398756d6.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689696912; x=1690301712;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL80Hh0hgHPYF+ScY5cReDWH1ysqjAt3uvCwW1/IBsE=;
        b=UpKtYFdSIlEnOrCZBagoAYUeHPKub4b7KEfH5NdnZ546tz5bIW8agGjVEXqy0zmboW
         gjpG/hRTgqsWB00GpPQDLDQY7FONSNyzZAkQUf//p1jw3Jbsm9zH4WY4HwnVh9gxIQ93
         d8uwIu8F+CEOVGndDI50vkN/SF5C0a8ngYLfDdHRYrATr8OxPywwvbIOvKtS/OHF1VAw
         0XnVPmuS2sOSL26Snltq5W01Dg30wJoiZzgOT01gyyb2JF5wBxmLLLpDY11o/wo6SmlJ
         xImM1Uwbu0xzl/i7c9g8kav2xtqfDVl7m80uj2rm5kA/4OhlZlvFN3scTEhCPM7XoIuT
         CUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696912; x=1690301712;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bL80Hh0hgHPYF+ScY5cReDWH1ysqjAt3uvCwW1/IBsE=;
        b=HH+6j5U/jgmbfqTpWZ3GNFXD9ma9c+5UoONPimcu8UOWBRoQ0u8GPjL05ERtuurrRE
         X4B28drE4z5vHcHwtfMOKPimVBoEsomwFuilBueUJxk0hAEwmn3xGOg42YLlhBpQlhyR
         pWpyEllqb2jCZ0KBQR3xUQyJGo1iy4HwLcdRcotjVhZyaIGxOeFn1FFAvKeHW3WrOGEv
         3yvtpGfK93uOe8jXlhut6g3PQieO9mmKmAttJq7s6d/kkcHtxpl9Ur6AuPplcKeUJMvE
         QNf0yygpzfLx8M3gAsRBP05tPeQA0GZgqj9dzxFTw4hbH6xW7C6FkIw4j0MA2GRXPf4b
         S6qw==
X-Gm-Message-State: ABy/qLa5fy4tBXSwFjuMQiFE26Q8fjl+YpcUqOjPKR5uLdkkPIsVQmoK
	rfuNNtoFDwwgrQRCrGeaI3+5wSRyaNWTDM97oPx9Pw==
X-Google-Smtp-Source: APBJJlHeL6F0fsQdBYSytEPSBN8Au/lxigPrUH69zpHuJqXldXkF7EiP7RbI8WaZebcgGlAI3epPFg==
X-Received: by 2002:a0c:da0d:0:b0:637:398f:83be with SMTP id x13-20020a0cda0d000000b00637398f83bemr103778qvj.14.1689696911895;
        Tue, 18 Jul 2023 09:15:11 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a15b600b00767dcf6f4adsm686774qkk.51.2023.07.18.09.15.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 09:15:11 -0700 (PDT)
Message-ID: <1d6b05aa-f7c1-84ca-645a-f872813ca76f@google.com>
Date: Tue, 18 Jul 2023 12:15:10 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
To: bpf <bpf@vger.kernel.org>
Content-Language: en-US
From: Barret Rhoden <brho@google.com>
Subject: Repo for tips / tricks / common code?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi -

Is there any interest in a repo or something for reusable BPF code bits? 
  I've got some stuff that I do in my programs that might be useful to 
others, but not to the level of a full bpf helper.

For instance, one technique I've developed is to have list-like data 
structures for *mmappable* data that are e.g. per-cpu and per-task. 
Internally, it's an Array map, and each element is identified by its 
index in the array instead of by point.  And the linked-list is built 
with index integers instead of pointers.

Anyway, that's just an example, and I imagine other people have their 
own techniques.  I've got the code sitting in an open-source repo 
elsewhere, and had a couple people off-list ask me about it.  I could 
email it to the list, but it'd get lost in the noise.

If you're curious about specifics, the linked list code is here [1], and 
I briefly mentioned the data structures in my LPC 22 talk [2].  I've got 
an AVL tree that works with this stuff too.

Thanks,
Barret


[1] https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
[2] 
https://lpc.events/event/16/contributions/1365/attachments/986/1912/lpc22-ebpf-kernel-scheduling-with-ghost.pdf

