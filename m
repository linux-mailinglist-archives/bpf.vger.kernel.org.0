Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF48335B34A
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhDKLGw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKLGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 07:06:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416BC061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 04:06:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s16so5202915iog.9
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 04:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jFG0OCtLOSQVeS3qPU1OvTw12sEFCIOmxByreHdr7iY=;
        b=SMO67DkfeChdlMfdqz1h4HlczekSjyoNQPNlkEVTL3bbRvLIMxtp7QZLhyaFgS3DA9
         IgCAIWms7f+Xieo9fv2DK7JGKPR/2s/GmP9yvqQjsqDrNlZMtjYe2y4GeLuNaSQbbz/y
         9Wlm517QvP/U0eLkiTpkaIuHzhEbrwkDmvtecsY5z/xfwgCBV7t3kZozxs54Va+0ndg+
         sM6jED0y8CYtlYVbWsw/UBIPDzQfYwnztA2JHop7QoSB2EEeOCIxzBBy9OibiViNQOrH
         VKNucPovF+157qP0ViPv1BqMh0DstDcnTRzNh3cl3mVKL6+LejY/A0V5Ggcj11W4O4WM
         OatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jFG0OCtLOSQVeS3qPU1OvTw12sEFCIOmxByreHdr7iY=;
        b=aTxQlVgjXFcTr98g1oBjUjEt05S6Ntj3QP2IfixpiGUzVPhk4f9H36QvfS8HraUbcn
         0ytWu+REdUcp/5etYUBIW8XQnDe38kEf7rVOgU/E+yOS+FLc6vpxbaAWp2WnFWIfeIpX
         xSzgzRgViXnY1lDtUkqaxPXMmMNQ/jmL2YTYY0HdbakLHI4XJ767b8TbS33HAskhLSwl
         6KD/8Y1TWnK9jWw2E5tAhrJ2EafAqkgh2iNEwiUMf3X0tkA69U6ikj6AIHXGlhdrv33x
         ZvhVzXRrnwbimyMEodbJLTGsuHSPg4tzUVI960GoM/h6CSPKk1XLgZwAXYPESaO0hfUo
         S5aA==
X-Gm-Message-State: AOAM533P4p/D/vihyGjAy1SIWkTwb9UOfNtbO5KMN/KHDQtYQ1Dz8lHQ
        KpVdiVN++DNjKlqwLjrTbJL9bvMRHROQTWXsDRU=
X-Google-Smtp-Source: ABdhPJwCV6Rp525iWToa4Ef36f3H63y4C3q5COtXVm+4YUMzEwzmDv0bILr4v0k63gyES1y4zr3WEMvGvtC5eM9RQs0=
X-Received: by 2002:a05:6638:2605:: with SMTP id m5mr18312279jat.97.1618139193583;
 Sun, 11 Apr 2021 04:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164951.770920-1-yhs@fb.com>
In-Reply-To: <20210410164951.770920-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 13:05:57 +0200
Message-ID: <CA+icZUUuqNrzho6vQXNUonSuvbZbkyEx100UWzGFEzUrGzYSKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] bpftool: fix a clang compilation warning
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>
> With clang compiler:
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   # build selftests/bpf or bpftool
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>   make -j60 -C tools/bpf/bpftool LLVM=1 LLVM_IAS=1
> the following compilation warning showed up,
>   net.c:160:37: warning: comparison of integers of different signs: '__u32' (aka 'unsigned int') and 'int' [-Wsign-compare]
>                 for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
>                                                   ^~~~~~~~~~~~~~~~~
>   .../tools/include/uapi/linux/netlink.h:99:24: note: expanded from macro 'NLMSG_OK'
>                            (nlh)->nlmsg_len <= (len))
>                            ~~~~~~~~~~~~~~~~ ^   ~~~
>
> In this particular case, "len" is defined as "int" and (nlh)->nlmsg_len is "unsigned int".
> The macro NLMSG_OK is defined as below in uapi/linux/netlink.h.
>   #define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
>                              (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
>                              (nlh)->nlmsg_len <= (len))
>
> The clang compiler complains the comparision "(nlh)->nlmsg_len <= (len))",
> but in bpftool/net.c, it is already ensured that "len > 0" must be true.
> So let us add an explicit type conversion (from "int" to "unsigned int")
> for "len" in NLMSG_OK to silence this warning.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index ff3aa0cf3997..f836d115d7d6 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -157,7 +157,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>                 if (len == 0)
>                         break;
>
> -               for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
> +               for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, (unsigned int)len);
>                      nh = NLMSG_NEXT(nh, len)) {
>                         if (nh->nlmsg_pid != nl_pid) {
>                                 ret = -LIBBPF_ERRNO__WRNGPID;
> --
> 2.30.2
>

Thanks for the patch.

I remember darkly I have seen this, too.

The only warning I see remaining *here* is fixed by this patch from bpf-next:

commit 7519c387e69d367075bf493de8a9ea427c9d2a1b
"selftests: xsk: Remove unused function"

- Sedat -

[1] https://git.kernel.org/bpf/bpf-next/c/7519c387e69d367075bf493de8a9ea427c9d2a1b
