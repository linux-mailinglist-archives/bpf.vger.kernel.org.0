Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC171689FDC
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBCREF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBCREE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 12:04:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5DA9D064;
        Fri,  3 Feb 2023 09:04:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so17067494ejb.9;
        Fri, 03 Feb 2023 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/LjMUcO/7qQ2hMePRsCGULrFrcm1c2xAKqFZPdsOxA=;
        b=IdtS0xpkdZcV/dCIHF/zIRZARlplqr+h2NcnmvP6g3J/XW+HYJ1WChWO6v6E6QF0Zg
         8vLe9h+QZNPLefmNKlZjMrT/tpKatDKW7WJlHgfPAtt1u85/BzkWAoQCAbZDLRwCyGFT
         sOiQHmpsvHbWzm6rkJLZe9VasDEnXAHagL5hKwsWB6GcpLZnEf2zyjuMqkpd908vffZ0
         3qxoO77ys+ZRwu9EYZUqGHO870cMYqmXVGQwpz+9fZDX1pNYSVpNBZ0eD9aNmrC2/Xt/
         8fM/qarZxJyArhzkiG5AloicplOkHsTDxYgaJH/O0X/LA50PDJB6ccrklv6wifnvJ3bv
         1Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/LjMUcO/7qQ2hMePRsCGULrFrcm1c2xAKqFZPdsOxA=;
        b=aLaqpW5O58Osbphhm1NCJRzqLkp2p25lczrH9unVDVOdd9ZnS97N60Jyn/K1sP01bQ
         dRYTc4jGDtcScz546Ufs7yL5KurLSfXk/SGscF0YhP2ojLl1CXUwLz7bRYhwCoOgzVxY
         mxuIG/aOzRYmn3CpMGqF9vhp6YMrGHKIVX6TywFjdAsF3N5Dq5ykqOlSL652paDX+HHC
         mxQNyUV35bawEyZ0Gb9LyXxHMPJ15JVXh/9kvG51CuOJZ3QCcD3g95TzoYjkVayOpxS0
         N+0Pzjc81+Czno5tKu3eJDVj6XLbbYe9ofUISu5iZcZF7PkBlqPz2dMQ/Tzw//g/To1K
         VfRA==
X-Gm-Message-State: AO0yUKVK4nYVlfXTr+tyBrtUsmbZdceOR7cq6rhiJtj0oAsiDph9I4QK
        hBXZKbdiMognIUvZEs2zZUprjYtENuBok5GzERw=
X-Google-Smtp-Source: AK7set/oeQHjWqQzeSutGXWIq4zs9g9eQYfk2WM7WXjHyVv4ZJx5YXbQfyJr2cXcopgoJYlgxTtBXHXnV6kAbZ7Q25M=
X-Received: by 2002:a17:906:6d13:b0:878:786e:8c39 with SMTP id
 m19-20020a1709066d1300b00878786e8c39mr3383054ejr.105.1675443842009; Fri, 03
 Feb 2023 09:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20230203155727.793518-1-void@manifault.com> <20230203155727.793518-2-void@manifault.com>
In-Reply-To: <20230203155727.793518-2-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Feb 2023 09:03:50 -0800
Message-ID: <CAADnVQ+Xx-rkhe-B0qC=SuZAjEP-RQ_=dm3SyXuasnRcNc30uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle /
 stability expectations
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        bagasdotme@gmail.com, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 3, 2023 at 7:57 AM David Vernet <void@manifault.com> wrote:
>
> BPF kernel <-> kernel API stability has been discussed at length over
> the last several weeks and months. Now that we've largely aligned over
> kfuncs being the way forward, and BPF helpers being considered
> functionally frozen, it's time to document the expectations for kfunc
> lifecycles and stability so that everyone (BPF users, kfunc developers,
> and maintainers) are all aligned, and have a crystal-clear understanding
> of the expectations surrounding kfuncs.
>
> To do that, this patch adds that documentation to the main kfuncs
> documentation page via a new 'kfunc lifecycle expectations' section. The
> patch describes how decisions are made in the kernel regarding whether
> to include, keep, deprecate, or change / remove a kfunc. As described
> very overtly in the patch itself, but likely worth highlighting here:
>
> "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> development elsewhere in the kernel".
>
> Rather, the intention and expectation is for kfuncs to be treated like
> EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> safe and valuable option for maintainers and kfunc developers to extend
> the kernel, without tying anyone's hands, or imposing any kind of
> restrictions on maintainers in the same way that UAPI changes do.
>
> In addition to the 'kfunc lifecycle expectations' section, this patch
> also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> authors or maintainers can choose to add to kfuncs if and when they
> decide to deprecate them. Note that as described in the patch itself, a
> kfunc need not be deprecated before being changed or removed -- this
> flag is simply provided as an available deprecation mechanism for those
> that want to provide a deprecation story / timeline to their users.
> When necessary, kfuncs may be changed or removed to accommodate changes
> elsewhere in the kernel without any deprecation at all.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Co-developed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: David Vernet <void@manifault.com>

David, Toke,
Thanks a lot for writing it down.
It certainly captures the main points.
Applied.
