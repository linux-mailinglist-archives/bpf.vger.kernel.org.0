Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC06686D7
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbjALWXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 17:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjALWXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 17:23:01 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446BB81
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:18:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g20so14848792pfb.3
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X1P2fSn3dI4UOACTvwLsfIYG4DV8Xk5OayjZY8tr+pk=;
        b=e0XNUXEagm3x2RsteUn7b8zAn6lUMkJfXm8dhN87zRZEX2QBPvDxTeSYhaaB39gJ6x
         vuBqohlEZ9epEFy1Ro2TTXvHUd7DjskTY/aJyBBDkC6wx46ArFpzL9llepWY+qG0kOk7
         hXBpHRItcroFkxx5Q3F0E6VSAaFic0lUuQd9DBF+ZbUvGCp98MesOuUYALBjv6Ix7M97
         7J3ByX0FUUuqPfoYDT+nzu0v8grpAXHkg6CxF/c8Awzz15Mu3wDSLEBVeaOo5rt4i/hH
         mL1BDOK0ztA+P0JqpoeSLoSwB3883B/f1ABbxaBTsfF8TcRERYKUEGVFiEMWhqprUvmA
         zQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1P2fSn3dI4UOACTvwLsfIYG4DV8Xk5OayjZY8tr+pk=;
        b=KDGK5FEVaUJJEV0H0kvX/w+7ersvivtXgGgij5ab6zgZA9BM5zsCOXA4mgkttYC5lI
         j8QnegNvHOzY0DafcCbem8zjuS6YWSN60iBbHnUYvU0TKS5dZ6qN9ssz8J6Iqe+gt3h2
         qzF2zOxOHdiJxopcLIRDHvs2s9e+EJPCJeVCywt+qutC3hKH6G3HgBrzEKQ4smK3098z
         SD9kOF7zE/zI9LimwZQyhr3Fe2VlqkQmjb8L6upMlc1BkikhZloeFXR7JaRTcTW9e7Pj
         idiL3WwA8DaxFUdtba9kjGLrwh6dEoNSIKCM7qhoiQ+ixOyVzQ6kkv53cclBtrQtTY4A
         AqKg==
X-Gm-Message-State: AFqh2kqCaGdhBgwky+znctxIf2nvpY95eTq8a8+rgSqzrDkcQ/vZlJKF
        0/C+pD5ibJFi0rEtNQnCdLvMp55E8sVRvncYoE8oPfE/Trnjdasw
X-Google-Smtp-Source: AMrXdXuqErVRzNIHwHwF1CrimbUibvQaRDx0Z5B90a+Ubb8fiZlboIKYB62ZKEfX0wzSV2xbSoAG+egGObVF+jlaWwg=
X-Received: by 2002:a63:4519:0:b0:47c:948e:c0bf with SMTP id
 s25-20020a634519000000b0047c948ec0bfmr6976835pga.240.1673561897091; Thu, 12
 Jan 2023 14:18:17 -0800 (PST)
MIME-Version: 1.0
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 12 Jan 2023 14:18:05 -0800
Message-ID: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
Subject: CORE feature request: support checking field type directly
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

Feature request:

To support checking the type of a specific field directly.

Background:

Currently, As far as I know, CORE is able to check a field=E2=80=99s
existence, offset, size and signedness, but not the field=E2=80=99s type
directly.

There are changes that convert a field from a scalar type to a struct
type, without changing the field=E2=80=99s name, offset or size. In that ca=
se,
it is currently difficult to use CORE to check such changes. For a
concrete example,

Commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an atomic_long=
_t=E2=80=9D)

Changed the type of rw_semaphore::owner from tast_struct * to
atomic_long_t. In that change, the field name, offset and size remain
the same. But the BPF program code used to extract the value is
different. For the kernel where the field is a pointer, we can write:

sem->owner

While in the kernel where the field is an atomic, we need to write:

sem->owner.counter.

It would be great to be able to check a field=E2=80=99s type directly.
Probably something like:

#include =E2=80=9Cvmlinux.h=E2=80=9D

struct rw_semaphore__old {
        struct task_struct *owner;
};

struct rw_semaphore__new {
        atomic_long_t owner;
};

u64 owner;
if (bpf_core_field_type_is(sem->owner, struct task_struct *)) {
        struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)sem;
        owner =3D (u64)sem->owner;
} else if (bpf_core_field_type_is(sem->owner, atomic_long_t)) {
        struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)sem;
        owner =3D new->owner.counter;
}

Hao
