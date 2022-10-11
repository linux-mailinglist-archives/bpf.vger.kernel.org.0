Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D25FA979
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 02:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJKArT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKArS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 20:47:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B97B1E0
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:47:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so28119311eja.7
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8e8NQU4wkeaVRrWYZdh5PQNc7vU/mN30F0HP9UUdYc=;
        b=buOdT8TwBq05mcJ6+QQza0Q9+b5O0d5nvsXo4c5/FbGmUhMnuiXqpLP2kblkhZyE5k
         Po32VCq6zXfn4V++t+sYivDZSBVH1nv5gwOHIn/UHQwn8LnRs66NdiDaRW6Bi1DbVN53
         6CqTf4XKBAF/q8/n08kLtf5JsjGGID8KiRRrlbooi0hIMk93yPvxqUHg8HCaCGHw2+0Q
         w5wC6NcMZe7CXsQIGzPyXs0Pshzz9E+aW8sI4RNT6xncSJCER2YF9tdltZpLGcdwKhDF
         xMNmxIbyLUQbaC0HEF6vTep5dRCxhmHva1dZ2C0OZmth+SPYSdjEWhQEFhQRViMbHTuM
         v+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8e8NQU4wkeaVRrWYZdh5PQNc7vU/mN30F0HP9UUdYc=;
        b=yW4aNSdfC1mpb+f93JM1HPeo5h8MeQNY4Y7vfVmBQkcVNEgszrzwPWeLB9EuiE4FF5
         diDu7FncJnU4F86cWWAL1Cj59GkPaM2DnSQ0vqCuRc06l0meN4Kgf8FAVhAkOLzGJTUc
         7M8Nmz/qjNle3ogl6q5Dvi5PFmdUOu8lOXQjFdR/XRKkVl7h+LKW2M7ZdNnNpr+o8hHF
         ckq25qbF1B7j9Pw6/SO8lEvGacN54v+sFl2CoKfgB4HK64lxRY7r8pqyviw5uv1rQDhs
         yWaDggbrFUO85wpqJ5v0eniYp56nUB/6RTr5nc2OJ/E7BQiDrE95MVbe1JA/y8++clDs
         Va9w==
X-Gm-Message-State: ACrzQf1naR7G2sTwDzSV9Rvvu6M+cZwjp+ErbOslwN1diJxr3FGSPvk8
        i5cuoiGz4YRpp+JSPgtJ4e2zQCLx7w8faVoHDZM=
X-Google-Smtp-Source: AMsMyM4AgOwbK5nlu3LVMmJphJVzHaC9eKUI5pZYiuY9m7EFXOWfjGmQ0oQSxAkcVD+0k2ZnOnsNv6bS9nbQkPhjr/4=
X-Received: by 2002:a17:907:7245:b0:78d:1de4:7033 with SMTP id
 ds5-20020a170907724500b0078d1de47033mr16533844ejc.114.1665449235850; Mon, 10
 Oct 2022 17:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
In-Reply-To: <20221007174816.17536-1-shung-hsi.yu@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Oct 2022 17:47:04 -0700
Message-ID: <CAEf4BzZkv12zHH8wGPxMQmM-TKpMtte8jRL92AecQAPs2JQB9g@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] libbpf: fix fuzzer-reported issues
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> Hi, this patch set fixes several fuzzer-reported issues of libbpf when
> dealing with (malformed) BPF object file.
>
> The 1st patch fix out-of-bound heap write reported by oss-fuzz
> (currently incorrectly marked as fixed). The 2nd and 3rd patch fix
> null-pointer dereference found by locally-run fuzzer.
>
> Suggest at least taking the 1st fix in this patch set or apply an
> alternative fix for it (see the extra note after its commit message for
> detail).
>
> Shung-Hsi Yu (3):
>   libbpf: use elf_getshdrnum() instead of e_shnum
>   libbpf: fix null-pointer dereference in find_prog_by_sec_insn()
>   libbpf: deal with section with no data gracefully
>
>  tools/lib/bpf/libbpf.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
>
> base-commit: 0326074ff4652329f2a1a9c8685104576bd8d131
> --
> 2.37.3
>

LGTM, but see my comment on patch #1. If that suggestion makes sense
and will work, please send v2. But base it on top of bpf-next, I don't
think there is any need to base this on bpf tree. Thanks.
