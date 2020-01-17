Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5333140183
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 02:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbgAQBlh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 20:41:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34430 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbgAQBlg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 20:41:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so21276676qkk.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pm7yctWXySy9C2T/6qcfkqKUjJL7wyLsf2MlCGo4DDQ=;
        b=aW1/vwIHnbtPolixVhPtJ9ZF9h4AE0pAFamuTUfIg+YMrLZEZeXxEqeN3ifNrHy+3L
         qZ+QqF6yNzBwDl56eOQPl3I0kgtSaz6aS4/TokHXPfJfDPgDGm86vMnCobzJS08FjByK
         UMeNB9Y/3bjctgZQ0A3BFUK4/mCafSK81/xmf7QF9C+BboatiLXcORLDW/vXbLaSVEYF
         uoVQJifS6qHdY0go14ympv5N+lsHpt0Bt0G0Z4z6877QEzi4PsLAAXMRN8W5FRLOyGwu
         woF6U5O3w4DsH4GUbJXO0t/z5QEVw3XMERbLh0eqvrJ416HaCx5aUtF8BEefTfotw/wu
         OLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm7yctWXySy9C2T/6qcfkqKUjJL7wyLsf2MlCGo4DDQ=;
        b=bwESYVSId6QYt6Komn9OSEXGPaE6jEa+ppgnFz0Jj+6YwFv00ppQCWBYe33TethwTt
         CZ79qZqDzzk+bUg+jCTr0JozzSfaNfOqPx79rUKoeWTvEBVAVBO7rSlhkrjug3PCqudm
         5SNzFAxZnyQoAEfSTBW/Z7d9BhqIa6q1ayigVwi/F5FjKTf/WDQjS9uM2ubaR2OgZQtG
         inxP8PtvoNyXTWIRKBMDnGWY6D0xIrAurX+nTF3ezY3BU+gVYeJPEnh4fGkVqUsNZIhd
         5KWU/JvAWSeJSwPfD1iS5TygS+WZtjlVOl5Ur8tiaH4zsj2PEvRkJTqz2qqbRFO+w4pp
         5HvA==
X-Gm-Message-State: APjAAAXdQsq78DKo9a4B/B06Ew/tMQpMdtf72RNsbEMRJ1JYRWSzBZ3z
        Y5IR/AqeuHrLP8Hf8ZimOAnkTpFdnbwkRHdN/fgZvw==
X-Google-Smtp-Source: APXvYqy93c0rjMp3z5HO/Aioj9jo57FOQ2CfYytzcdPbEjn07awjXiE2aB4AsYbBkCETGemxFXSxIZrGXnu+vagIDWk=
X-Received: by 2002:a37:8ac4:: with SMTP id m187mr31316626qkd.277.1579225295498;
 Thu, 16 Jan 2020 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20200116145300.59056-1-yuehaibing@huawei.com>
In-Reply-To: <20200116145300.59056-1-yuehaibing@huawei.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 16 Jan 2020 17:41:24 -0800
Message-ID: <CAMzD94T3TowoygCu3mAtd3WaZtSk1m1AVVpUHYB_bPAyE9QS3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove set but not used variable 'first_key'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        songliubraving@fb.com, Yonghong Song <yhs@fb.com>, andriin@fb.com,
        Linux NetDev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 5:38 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> kernel/bpf/syscall.c: In function generic_map_lookup_batch:
> kernel/bpf/syscall.c:1339:7: warning: variable first_key set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.

Previous logic was using it but I forgot to delete it. Thanks for fixing it!

Acked-by: Brian Vazquez <brianvv@google.com>

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/bpf/syscall.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0d94d36..c26a714 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1336,7 +1336,6 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         void *buf, *buf_prevkey, *prev_key, *key, *value;
>         int err, retry = MAP_LOOKUP_RETRIES;
>         u32 value_size, cp, max_count;
> -       bool first_key = false;
>
>         if (attr->batch.elem_flags & ~BPF_F_LOCK)
>                 return -EINVAL;
> @@ -1365,7 +1364,6 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         }
>
>         err = -EFAULT;
> -       first_key = false;
>         prev_key = NULL;
>         if (ubatch && copy_from_user(buf_prevkey, ubatch, map->key_size))
>                 goto free_buf;
> --
> 2.7.4
>
>
