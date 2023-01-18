Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB7670F7F
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 02:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjARBHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 20:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjARBGs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 20:06:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF24B4BD
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 16:55:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s3so22431881pfd.12
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 16:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qsvv2gS4uCvYkqiwZFbM5ckEnt1ocYo1UbmP/627MbI=;
        b=BdOf/00j+mYl9ytan3wr0CPeAaEHzTTjgZuDZfHZmf882iWqusXpN8mwkYzmeifme7
         p2VSr4lJudCu1OLaJHxCyBJP7fzVfxJpcg98Ya9pZXAioYdVvO3inA+YSCfERaWkcORr
         fDaD7hbS/BTo645Z5CdFPfw3xk2VxvTrHIu8dODlD4XyEzLWxbJL578mPO1+gMhq241f
         mgaCSDenDtmWdYicMM+dtAzL6YW+O909OB21VtxowhqsNEwbmqAV8kxNEESa3higJmgQ
         oQ6BwPGjlbK6WGROY05WCPOJwbbjYoejAWI1oaJS0dkQ2CrW+o1z3ww2JxbdvRnC4eSq
         1PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qsvv2gS4uCvYkqiwZFbM5ckEnt1ocYo1UbmP/627MbI=;
        b=CUSLs/Z2Yj7FMXV/Fpj1uhQtKKvIQaVpYXWRYY5ljoJgjdgAX7R0FHCTF6i3O8skSS
         BsKu50Qx1HlsQMH3vPWGX7ome2PuJH7PhWrni7fd/iinz2xmKn3/cSOEHcRZpRge+VCk
         Ikruefn3vtX6ZP9XD1ZlYoEL3q4E3+bFLFeXedsvvpJhMFfP4tNlep6C9rqJ5MX4GN5x
         4QcQWZTzwSgu2vgCc8N4Zz+ktJqi9g4onfbGmgPd0JaVG57XdDMdLtkNe4ZnbuQY3Pon
         diYUyvYiusnKHECdfFWXMLWv0nsPA6rvWcs6ctIn2dvXWH3opBNy0oB8GJz18BoeHFiW
         wvEQ==
X-Gm-Message-State: AFqh2kpgxBNam+eut/dtpIu7aQgT8xJ1RF4QQBVhw2h1hB/LmxgvdIWI
        F3GIcgi5qFnHaj9ZdYSLsGQH+ms0k3wp8WR6UXWbkw==
X-Google-Smtp-Source: AMrXdXujCftcG8mO9D9Itp/oAKLrkOaPstzkodGufrTYsR0zFncyDaJ/54JMo1lZK5g8jILC8sXbccmj645nI0jlX6A=
X-Received: by 2002:a63:d02:0:b0:479:4295:b4e5 with SMTP id
 c2-20020a630d02000000b004794295b4e5mr330635pgl.252.1674003356321; Tue, 17 Jan
 2023 16:55:56 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <20230117215658.xec7cirlfx2z7z2m@muellerd-fedora-PC2BDTX9> <20230117222158.uyezr5ab72ck5fhv@muellerd-fedora-PC2BDTX9>
In-Reply-To: <20230117222158.uyezr5ab72ck5fhv@muellerd-fedora-PC2BDTX9>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 17 Jan 2023 16:55:44 -0800
Message-ID: <CA+khW7gFq3VKEvF7hZXQsLJagz=HMZ4kJwh=QdmFG1pFbq1xRw@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@meta.com
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

Hi Daniel,

On Tue, Jan 17, 2023 at 2:22 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> I apologize for the response. Somehow Andrii's reply and the entire threa=
d was
> lost on me. Anyway, glad it's working for you.
>

Andrii helped me get it work. TYPE_MATCHES is a solution to my
problem. Now I have a better understanding on how
bpf_core_type_matches works.

For the record, the following works on my old kernel and new kernels:

struct rw_semaphore___old {
        struct task_struct *owner;
};

struct rw_semaphore___new {
        atomic_long_t owner;
};

u64 owner;
if (bpf_core_type_matches(struct rw_semaphore___old)) { /* owner is
task_struct pointer */
        struct rw_semaphore___old *old =3D (struct rw_semaphore___old *)sem=
;
        owner =3D (u64)sem->owner;
} else if (bpf_core_type_matches(struct rw_semaphore___new)) { /*
owner field is atomic_long_t */
        struct rw_semaphore___new *new =3D (struct rw_semaphore___new *)sem=
;
        owner =3D (u64)new->owner.counter;
}

Thanks for your response!
Hao
