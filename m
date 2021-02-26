Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6304325BAC
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 03:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBZC2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 21:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhBZC2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 21:28:51 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF20C061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 18:28:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a24so4472943plm.11
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zClmVHj7520q8MrPMu5iWp59NDWfX6ZFRgy0fsDtwo4=;
        b=WKciwzFkO0EeS3bQeYtsn4sBD0ud71ENcVShqpYAmCDR6iG9Yo/5AhksQrMSgk114Z
         Ueosck7w89vPywIFV5Dykomd8vggWTu9YKM2HfRefx0cJ8lolssSitq2cc0xU3mXuZSX
         oWCvx6FZC9H/ljzThQAIdCOo3GTWAzH7jx/HD2CTeyOwf87/jxeLGC8pkQzcwn+vdVhK
         My9PNm8UV3SzT0YFdi8cssbMy6UOxLmbSE7TmWbluIOEAz2xsZuMpiInZKjKF60uF4zg
         3gKE8xB2658CfPnDdjrcuqwvWOOHNx9QXBJYmDkIN60+lGmjNLVRZakIAUFhwOttow1d
         MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zClmVHj7520q8MrPMu5iWp59NDWfX6ZFRgy0fsDtwo4=;
        b=nodVwz4wY73DCZw1upyAMNQckLwxhTcdQ6AI9hYhsQG+sZWTfu/lxjOggKuTa7PDPS
         b+Zeqq+ABhxjeokWxm6YDX3/85YoteYkqqW4Y8lPHT4XynOG28UvVTXkqN3iayEq8uwi
         QTwDklxHFBpny0xvx1hWtwPWoc9QRwWIADw6o4aSpfnHZfihdq4JNQ6OhjzQxU4i0mqY
         z257e7zBpKn/t3Ok18q3BVREX/a0sbmLuiuunE5mpsciWjpsZrS6waSCj+xpS9gr20IJ
         DE/dHvCHp1HVJ+b/y7nPVQUcdVVvy67AyS3HyZtIDmvCIhA66s8c+6TuD+fciQ0k7TR4
         jrnA==
X-Gm-Message-State: AOAM53011GOE8t002mDqmwKRge+eSY53vrVMjkM5a2WBxlxktSkqKbzq
        crn5nsVP5Q+cw5JPvVvArU1GeZYYZdHN+gSjg9nktvhRY8v93Q==
X-Google-Smtp-Source: ABdhPJwnaHhu22da3m0/zNdH2v3RxUc2xMxyNHqOECiRO13zVvrzq2nkai/BspGiUeBSoKj465PPJp0//ufG9fLDYpE=
X-Received: by 2002:a17:90a:8594:: with SMTP id m20mr948183pjn.215.1614306490844;
 Thu, 25 Feb 2021 18:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073313.4120653-1-yhs@fb.com>
In-Reply-To: <20210225073313.4120653-1-yhs@fb.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 25 Feb 2021 18:27:59 -0800
Message-ID: <CAM_iQpUjQ1sD1pyk2GnCuoyMYBhDFcF0KY0Qg9uMtH8DRGGEMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 11:33 PM Yonghong Song <yhs@fb.com> wrote:
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index a0d9eade9c80..931870f9cf56 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -675,3 +675,19 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>          */
>         return ret == 0 ? 0 : -EAGAIN;
>  }
> +
> +BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
> +          void *, callback_ctx, u64, flags)
> +{
> +       return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
> +}

A quick question: is ->map_for_each_callback() now mandatory for
every map? I do not see you check for NULL here. Or you check map
types somewhere I miss?

At least some maps do not support iteration, for example, queue/stack.
If you can document supported maps in bpf_for_each_map_elem() doc,
it would be very nice.

Thanks for working on this!
