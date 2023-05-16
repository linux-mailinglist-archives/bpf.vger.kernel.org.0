Return-Path: <bpf+bounces-669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76614705601
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33564281465
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C338187E;
	Tue, 16 May 2023 18:32:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7FE557
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:32:22 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA655BD
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:32:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9660af2499dso2470996466b.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684261939; x=1686853939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jHQmm+JwR3EoD17DhyOID0gJQJhkJ+xedoACFWregI=;
        b=St+y51eyqG80tFwhpa3GMTomEbhYHK75h1y82NTTPlE6X/Sc5zfgF77t1AQt+voDwW
         isjFqJ1cv/2g36CUhwhNiiEAGejwFtF64JHXX7VL0Op48Z5YPJrIoeZGNQDtP5pehOZ2
         g1NoTq8GwuHNKhI18iPi4rUGvoQ9ZuyxsF1crFUCMdtxr9yJjyfoe+xQYxxeoyVeWzRH
         46R9Paw+enTvB8K2aIFi3w0M2Dkfe1QNVn3Hr1QdiPnCKAQMRmOllXQN4ittuaDGpz4Z
         P4mNJA0mJT8Idy3JcowmLir8gFVRAMBbBOyYwjaaePBq6h/dStzBkqGSGcUTiREQLO7h
         YFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261939; x=1686853939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jHQmm+JwR3EoD17DhyOID0gJQJhkJ+xedoACFWregI=;
        b=O9yJSTernoD/ECHgO5ZbvItWe5T42uPt2Gshe7sB6Kn++tluas/wHa2q8OiDIv+SvI
         UieACkdHKCvAsdL+mnRDR5zT1nH8GbTCtk6vzs7FquzoGWkCC4EX9cRwG91zA1kQDJyF
         MeMfs0MKc1/wLXLSqmOOsDnqqXecDzOFEbhPrBrg8qRFFx3gxYVDgVl1nQQcJmfBcENx
         WDiq8QTFF13c/5KgK0Na3FW+gxSQe9RUC6h1tm+R0nMgmP2L2RC84AYHTYPBMUniF2RR
         P9Og3GrJBDji7bOkcAUDzqby2SxITLbECiJBRF66Ja2GiiKvJLTaVX1TN7CSFVZymLOJ
         tAYw==
X-Gm-Message-State: AC+VfDxPGK7iNSfIHfnrWtIgS68rOthqMf3Dc6/zDi5I30tpOJH1gi1S
	WycQ+BvU9s2O9tPU9Hw5kFrnVkTWW3VfePlXbbE=
X-Google-Smtp-Source: ACHHUZ53gor3XIcFS+tWiVsACFLfQvI9GtcJq5GDL6dQrNXyqaZyClyYRhGdtb6xaWFdQF3mPX/k/tpWZcGovQkwG0Q=
X-Received: by 2002:a17:906:eec9:b0:94e:46ef:1361 with SMTP id
 wu9-20020a170906eec900b0094e46ef1361mr33653278ejb.34.1684261938750; Tue, 16
 May 2023 11:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EE887B7B-BAC1-4D59-8752-ACD8705725F4@icloud.com> <6AAA2A54-2161-447E-BEFB-BE92281A1EB0@icloud.com>
In-Reply-To: <6AAA2A54-2161-447E-BEFB-BE92281A1EB0@icloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 11:32:05 -0700
Message-ID: <CAEf4Bzam12RMgue7eBy7Hsj4Pw=_x=izvgJXNX4wMh3JPn1wrA@mail.gmail.com>
Subject: Re: add helper to get value of Thread Local Storage base register
To: chen.yunxing@icloud.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 8:25=E2=80=AFPM <chen.yunxing@icloud.com> wrote:
>
> Hi,
>
> I want to discuss the requirement of add bpf helper:
>
> for the purpose of accessing user space variable of TLS(Thread Local Stor=
age)=EF=BC=8Cwe need get the TLS register of current Thread/Task.
>
> then the TLS variable can be accessed via add offset to this register (as=
 the base)
>
> for example at arm:
>
> mrs x0, tpidr_el0

thread-local storage is only meaningful for user-space, so you don't
need to access actual register state, you can get it from struct
task_struct:

- for x86-64: task->thread.fsbase
- for aarm64: task->thread.uw.tp_value

Each architecture should have a similar field storing thread-local
storage base pointer.

