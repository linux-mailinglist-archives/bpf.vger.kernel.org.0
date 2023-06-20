Return-Path: <bpf+bounces-2909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49253736994
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C4D281287
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B69C8FB;
	Tue, 20 Jun 2023 10:41:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B60101C9
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:41:25 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F08120
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 03:41:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f901f87195so25344875e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687257672; x=1689849672;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tN1Rzn2bNXClKyAEuubd4ihCMJbmRLFEUC0yIdqtIuc=;
        b=Cp25SEXxVBdmQ3YhQ4WAmqTkpfq5RiN5fjAPeUTmoI70BoRffMwDudTzUJOCDdkWfs
         Mm5Fl8cSReZjiuABMz4xbWVAeLDSESuU3h1Xphbz4k0ClCOwurvSzYwieSk9ErFC3A1k
         iqIZpBImy7zaQGUBx8I0nJ6W7HB5T2vRSlPlrCG8N3kduGoOJ7OECrQETdhrkfwO/4mG
         mRiA08BCRNnf6pri41Li2JwwIflc0yIpCNN9BWMRCtECYHjbJdjFyE2yNAeQ3HH3nLxc
         NHtbxpwTmnhj+SjeYQW7HJZbXCaChH2epNfxmtO+2OQQIz4jqGbHRrAhJoNYSw7lHNmp
         MlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257672; x=1689849672;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN1Rzn2bNXClKyAEuubd4ihCMJbmRLFEUC0yIdqtIuc=;
        b=aiHWeVCW1KBJrUen8fUsNVUakxQdinrtSkbbScBbEbHcAdiFDmCyvuesVPn3rWn/3Z
         Abimw9lqQpEJe1f+qwYkW+xY9p6yxQ6SmB73DH47V6P3RRtuBfnlYWhAb1aPukj/09FZ
         NUpKAwUt1Bi6O+ZnzBOkpxukWapxu4wgHC9gSwmbvcOdCyALL+lxnEp4/Pm3F4BwHTLb
         qLOdMAuladYRF1l00twoqvO9WJmWVqGcUNjPNSV4U38wDaewqsjaMzXJ0rbo2yOnrUGl
         puiUZYA7VeYB0pCVNFo/weOV2O4vz3OeEy7VXug8GglzstjryQVIADZL1BjQd8uDfohQ
         SSXg==
X-Gm-Message-State: AC+VfDzlMFvmd/gNoWy6lz6CwxTxJlSy1TdJ3+bdaI8iXsbwW1BmTEvW
	MwEl/+njR7qSdYfhfuIa4sELvL7PeaRSAda4XTHdzQ==
X-Google-Smtp-Source: ACHHUZ6nEM00+Cf/gYU7ZDLPjxv1dMQNxvLGrwi2ND0J2ETCuSaQt1PcYTO4Elv5zAc7VKqdRrDRCA==
X-Received: by 2002:adf:ce84:0:b0:30e:5bf2:ef1b with SMTP id r4-20020adfce84000000b0030e5bf2ef1bmr15263318wrn.25.1687257672253;
        Tue, 20 Jun 2023 03:41:12 -0700 (PDT)
Received: from [192.168.144.29] (lfbn-mon-1-626-49.w2-4.abo.wanadoo.fr. [2.4.20.49])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm2003709wme.25.2023.06.20.03.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:41:11 -0700 (PDT)
Message-ID: <9642870b-3876-6b99-cf62-45ca11cfe80e@google.com>
Date: Tue, 20 Jun 2023 12:41:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: Calling functions while holding a spinlock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com>
 <CAADnVQKbNjKJgYODUS0zO3dR8dxEcFpgY3GkhEEmwT462HW+wA@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKbNjKJgYODUS0zO3dR8dxEcFpgY3GkhEEmwT462HW+wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/15/23 12:17, Alexei Starovoitov wrote:
> On Wed, Jun 14, 2023 at 1:32 PM Barret Rhoden <brho@google.com> wrote:
>>
>> Hi -
>>
>> Would it be possible to add logic to the verifier to handle calling
>> functions within my program (subprograms?) while holding a bpf_spin_lock?
>>
>> Some of my functions are large enough that the compiler won't inline
>> them, so I'll get a BPF_CALL to PC + offset (relative call within my
>> program).  Whenever this pops up, I force the compiler to inline the
>> function, but that's brittle.  I'd rather just have the ability to call
>> a function.
> 
> always_inline works as a workaround, right?
> And it's guaranteed to work, no?
> I'm not sure why you're saying it's brittle.

yeah, it works.  the brittleness comes when i don't mark a function 
always_inline, but i don't notice since the compiler was inlining it 
anyways.  but eventually i make a change and the compiler decides to 
not-inline it.  e.g. i call the same function again somewhere else in my 
program, and now it's worth it to make it a separate function.

it's not super urgent - and i've been hit by it enough times that i can 
usually find the problem if it pops up.

> It probably generates less performant code,
> so it would be good to add such support.
> It wasn't done earlier, because spin_lock-ed section
> supposed to be short. So the restriction was kinda forcing
> program authors to minimize the lock time.
> Could you please share the example code where you want to use it?

stuff like this:

https://github.com/google/ghost-userspace/blob/main/third_party/bpf/biff_flux.bpf.c#L115

similar to that one, i have an "AVL tree insert" function that the 
compiler didn't want to inline - especially if i called it twice.  (the 
AVL code hasn't hit our opensource ghost repo yet).

> Just to make sure we're talking about calling bpf subprograms only
> and you're not requesting to call arbitrary helpers and kfuncs
> while holding the lock.
> Some of the kfuncs can be allowed under lock if there is a real need.

i was talking about bpf subprogs.  though one helper that would be nice 
to call while holding a lock is bpf_loop.  i've got some loops that i'd 
turn into bpf-loops, but can't due to the spinlock.

thanks,

barret



