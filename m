Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4578335D69C
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 06:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhDMEsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 00:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhDMEsc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 00:48:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A808CC061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:48:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y2so14655738ybq.13
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GrlN9cYluW7wV1i8k7cbz+8mVLPzds32uTabCg0PX0=;
        b=lMglkkz9fzjwm6TiMqrD8afRKOuR+6bvfgFHcpZCbqr2gKV6eNoZeDdz91UR7fmZvZ
         O5U5EoAMInh9YLnEnsV9i7rvqhXqYL+OXFYjPnhdAq+duTUcD45VMs5tkO326p4Z+0NX
         W4mwu7aenKikltIQwCmi2NZclUmtHyFTNsNCOBqmrt+0Tmle5ZwEMQOG7AbCLng+fc0W
         Spv0zo3BJniWwRgUyBIZHJsOU39kT7WhXzfUESGaqIXYsy6VXS3DsajYwK1EUe2ntKr4
         zv5JxFSCSOAqyOou8EpQsb71LBp0bJhZCQ/KkrUs5peDbfPQXi/3QQg5ZzyiRPRgFrs5
         U3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GrlN9cYluW7wV1i8k7cbz+8mVLPzds32uTabCg0PX0=;
        b=f25SLwBQVB1XHMdPZol/HOuVJvdHtLkcCdqXrgZvA9KwJXqu6qpIxDXU1mpLCsrw/x
         iszJLe5jvu9Hm0+HuLPXYbZQqeOIY6Nq+jspuAIWybp0EYyMqCzGcZ4R1qqvDAlRZUbE
         bUP6DGlWjLcmmSNmzVUOyNPbKmN+kAP/neN2jsdfMxYBIu82/4qGBCr7TAdzbrjyVoHC
         51OL6ggf0a2jzBxrPH8REO4f513HkyIr5na8ptZ7yCmqdzXq3GEYpv7QE71qzMWLVL/U
         rvA4YSqJS27y0pAAfphsRo/eJyODCYiOprqEQqeA3vf3aej15kBKWfleb0IP0Drq3tNj
         8Q0Q==
X-Gm-Message-State: AOAM533HHQOAtsQiYTCNBT8r0p4xxn+ir3Os8gh/upnWSzqZHLBDor5o
        WOR7hZTR2u+Jxek3Cz+1Vq14MbiyQSm60X1r0sc=
X-Google-Smtp-Source: ABdhPJxSCwEPpSD7+4JwRVXuzY+EkN79QY11ccDapuLPFZbFIJIq2mvBzPJtJxCx50RGBtmq/Z6f8yQhta4BZjICv4k=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr42634254ybi.347.1618289292999;
 Mon, 12 Apr 2021 21:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <20210412142932.268930-1-yhs@fb.com>
In-Reply-To: <20210412142932.268930-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 21:48:02 -0700
Message-ID: <CAEf4BzZ8MSU+RSQP8ZW7gJWY80hriqj8gP1-p9AhjurMAOOp-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] bpftool: fix a clang compilation warning
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
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
> So theoretically the compiler could deduce that comparison of
> "(nlh)->nlmsg_len" and "len" is okay, but this really depends on compiler
> internals. Let us add an explicit type conversion (from "int" to "unsigned int")
> for "len" in NLMSG_OK to silence this warning right now.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

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
