Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB75B7D13
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIMWbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 18:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiIMWbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 18:31:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2EC61119
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 15:31:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so12638337pgb.4
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t2Q9w3JUYdWVYE8i7yIKCVCQoxRVkYxv3+zuzR+3R4k=;
        b=bUuKMnuCiSUWwwU8rNuIjMU0LRTgjgntVnFdOWsxbjCeDn+EcRNepT6WjT2lp+2Nyb
         gKuwPFctibylIkt6QnSr+5GThNKc/myfmZMC19zMlkIJV4ykS+1YpesI7tEbMu5ZlaQt
         HxkJDZt8OuCwKCkrPgGUnw319ujOsxdl/dAYQg2t4T/BEBmemqYrdAquhRjVOYNoMpqv
         SFe+8BminF9p3VG4D1tRo64oqjV5MObUswJCKq1fZtxpGTq0UuXzk2IL7kd4Cfke31+G
         Ii+wqGgpoDbiRj1/r8hnBbNaOupH7yYgSCMTMGGD1THNioq6eJ9/KoVnRZu7A2fdCc28
         Pf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t2Q9w3JUYdWVYE8i7yIKCVCQoxRVkYxv3+zuzR+3R4k=;
        b=mYbE0xmavGEmiykFivjHWDXsEinkcuSiFMXqEnhUJgk8tp1DYuIcIcQENYq2ZFWyF+
         Fpaslmsw6GtccmIHUBfvnrjuiMjyuXa2Tlzy993yUQpcmUWAo5vTgg6iUO4IlM6AMflH
         jAE4P5TtzB2Fln6Dro0bpU9wU6TSa/lKzX4xtn9LnZVU1xOG62qHjyI+wynBDEy+yTYP
         PjAf8Tk94VcehcxAyC2cocKJOfgY2yCwNEq9lXQifZaYD08pCCgIU8sZiispMFu78NV+
         2wZyjJi0VyQw+u4r3RX62O8gqtn4ytcZqdL3KhPJJ9FeI51irJNE/GKP4lyQjHqKKxKU
         MWXA==
X-Gm-Message-State: ACgBeo2Oc/O+uxRW9OptwTkz81/CFUne9J/YDJziAU6cvRMWZ3ICTYK1
        bdG42ST0VQXgtqpoZtjECJCQIf0YlWHen02SGqZQKA==
X-Google-Smtp-Source: AA6agR5ZgUCizkeUDu4rS2h4s/T8Z1OGQrw6I+5Nd0UfywFDe+Y5Kd0wCw4irGfTnINQoS7iHOcpNAMZWxJXA7pDGDc=
X-Received: by 2002:a63:7984:0:b0:439:57e4:97a2 with SMTP id
 u126-20020a637984000000b0043957e497a2mr2538999pgc.191.1663108264083; Tue, 13
 Sep 2022 15:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 13 Sep 2022 15:30:53 -0700
Message-ID: <CAKH8qBsoc8Upz=NvOtD=SOfVPcEnW-2wghbM1zYBacBwmGNvAQ@mail.gmail.com>
Subject: Re: [bpf-next v2] bpf: use kvmemdup_bpfptr helper
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 13, 2022 at 1:29 AM Wang Yufen <wangyufen@huawei.com> wrote:
>
> Use kvmemdup_bpfptr helper instead of open-coding to
> simplify the code.
>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  kernel/bpf/syscall.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4fb08c4..f862406 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1416,19 +1416,14 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>         }
>
>         value_size = bpf_map_value_size(map);
> -
> -       err = -ENOMEM;
> -       value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> -       if (!value)
> +       value = kvmemdup_bpfptr(uvalue, value_size);
> +       if (IS_ERR(value)) {
> +               err = PTR_ERR(value);
>                 goto free_key;
> -
> -       err = -EFAULT;
> -       if (copy_from_bpfptr(value, uvalue, value_size) != 0)
> -               goto free_value;
> +       }
>
>         err = bpf_map_update_value(map, f, key, value, attr->flags);
>
> -free_value:
>         kvfree(value);
>  free_key:
>         kvfree(key);
> --
> 1.8.3.1
>
