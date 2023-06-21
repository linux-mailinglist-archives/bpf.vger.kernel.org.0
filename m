Return-Path: <bpf+bounces-3003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A439737FB7
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A201C20E3C
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30A101D9;
	Wed, 21 Jun 2023 10:51:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5FC2F0
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:51:29 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE71FDF
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:51:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso6055450a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344686; x=1689936686;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oyf6rZ6h6vqmK6XCOupG0Id3pl+KDJart0qpjZLrRs4=;
        b=JQ1iLIr683R4+ieoWQ62WIk6i/4XQD170Z6Egb1cnJ1zSDvoYUrYn4w71bXc22ewHY
         YxfmwhkClf7R69AOLbxQDQwEuIEIu4Q7P7OXUQnNU65D8CSbBOf44xwUk8r2C/julJ+C
         zvEF2vTQBjVLKwZ+PjBUinNxOyXXxkje1taAHc2CzDdeanZfnJph20cOQB+LVkFukWx3
         C3+r0c/qdziqzcT5o0UE+/OP8Z19JvbwBq+C+oemAqhXeiCPBOA0X1/+oY+J+tqYfMzA
         Emmf/T0XDSpjS8ExjkSIvuDYRaqmiYmu8MvRvROYukjfV9cCVCwgdUkst0P9J6cRuBDL
         b5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344686; x=1689936686;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oyf6rZ6h6vqmK6XCOupG0Id3pl+KDJart0qpjZLrRs4=;
        b=LJd+Zjb/hnL6Ok4whKMPdco3+ug9PxTmJ3wuLiTcCBhsXBuOK5LV5HjSMMiz/GpPNu
         sh/2XBxunSkZ3bObVzwjbx6EyNeLifCfsyuEd9hZrLb/5EJ3mT7Pi9asQrKqgUM+MHOS
         3AuZUw5fXYXjPX2Rr7iCfwxKNUhCeQtOhhxaBV+H1liuYxRY5e8mCkOJy87KDa6jDewa
         jNsb1aAhUig2mxX1YE00YMafq76k9zO2CtcSBN7OYO+qsJfKGHe32BwVVkuhCOkog5Hb
         7FAY/s7RKV5gWhdGfy3oRvbtJXRErO9DUlIxXPCWfUA5GECU9ctYjIXYPSszW33YkH9W
         wZzw==
X-Gm-Message-State: AC+VfDzmEclK/jqEPC23BfWa1gLlXuBNMv9euYrm7QoxxiSQfjTKQaWZ
	7yMmHD0u5ikAJpUu+49ccuSg/o7ouU0oon3jdaS/oqH4ryU=
X-Google-Smtp-Source: ACHHUZ7RAIbuf5BEzCZrVPr7bzGtknn85znZGqXIuBbWYye18+XjI/5en/JgkY4NwMiZLaKiDPj1gweqcriwa90b8HE=
X-Received: by 2002:aa7:d78d:0:b0:51a:4557:2caf with SMTP id
 s13-20020aa7d78d000000b0051a45572cafmr6524309edq.34.1687344686079; Wed, 21
 Jun 2023 03:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Wed, 21 Jun 2023 12:51:14 +0200
Message-ID: <CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com>
Subject: [QUESTION] Check weird behavior with CO-RE relocations
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all!

Recently I faced a strange issue with CO-RE relocations and the
required privileged to run our eBPF probe. In Falco, we try to support
a vast range of kernel versions and distros, so to support COS systems
we added this custom patch [0]. More in detail:

if(...)
{
}
else
{
    struct task_struct___cos *task_cos = (void *)task;

    if(bpf_core_field_exists(task_cos->audit->loginuid))
    {
        BPF_CORE_READ_INTO(loginuid, task_cos, audit, loginuid.val);
    }
}

The issue is that now when running on not-COS systems we face this
error when using only `CAP_BPF` and `CAP_PERFMON` capabilities:

libbpf: failed to iterate BTF objects: -1
libbpf: prog 't1_execve_x': relo #791: target candidate search failed
for [1238] struct audit_task_info: -1
libbpf: prog 't1_execve_x': relo #791: failed to relocate: -1
libbpf: failed to perform CO-RE relocations: -1
libbpf: failed to load object 'bpf_probe'
libbpf: failed to load BPF skeleton 'bpf_probe': -1

If we use CAP_SYS_ADMIN all seems to work fine. The issue seems
related to the fact that during the relocation libbpf is not able
to find `audit_task_info` in the running kernel BTF, since we are not
running on COS system, and for this reason, it searches for it in
modules BTF, but in order to do that we need CAP_SYS_ADMIN[1].
Is this the intended behavior?
If we want to support specific kernel structs like `audit_task_info`
do we need to run with CAP_SYS_ADMIN always enabled?
Is there a way to disable BTF module search with libbpf?

Side point:
Not sure this is the right place to report it but it seems that some
COS versions ([2]) backported something wrong: they backported the
`BPF_FUNC_ktime_get_coarse_ns` bpf helper but not the memcg-based
memory accounting. For this reason, libbpf doesn't bump the
RLIMIT_MEMLOCK supposing that the system uses a  memcg-based memory
accounting and so we face the same error reported here [3]

[0]: https://github.com/falcosecurity/libs/pull/1062
[1]: https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6f970171dc9d01/kernel/bpf/syscall.c#L3704
[2]: https://github.com/falcosecurity/falco/issues/2626
[3]: https://lore.kernel.org/netdev/20220610112648.29695-1-quentin@isovalent.com/T/

