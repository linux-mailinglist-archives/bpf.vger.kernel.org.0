Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33FA60BA3F
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiJXUaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiJXU3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 16:29:42 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19310B7BC;
        Mon, 24 Oct 2022 11:42:29 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id v27so10753927eda.1;
        Mon, 24 Oct 2022 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cB2FYQ6zz4yJrapqJDJTE5DptWCfldmXwjxtDOt/B0s=;
        b=JN7uxoITIaVl18LJEZQ0ufGu4PrZM3yonCdBdmDjIjeRttqLXldyazzyxeWnrSn5ql
         RywZjtQ1k/Psr56DQf50jQ4Tv+k3koil8KMUizZtO9ZA8sHX+hyrLHky/M3cWW6MvWbB
         7C25I7hB8OmkzdYvEVOj2qlgyLDyrCZXMiI6GkQMG/hB6k2Y2YYvhLzlBt6iSJtkAvKj
         9p11+6+OG6VqO8tfk+di6COkBQIsDtPZAW8cAMhf6tV+Z1fHXkyowQWMi7N3v25BegqT
         TLohY7NCKyR/R+j1lzxI3N58giI9sjf6Yycyc3Rxz9BB2oNL5bioL4jWGI3RENL/icWL
         lJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB2FYQ6zz4yJrapqJDJTE5DptWCfldmXwjxtDOt/B0s=;
        b=B+LUFbzvGkq0dyeFDcKBqXbrIMMH4Y+iy3N+G01e8PFKJOIUS0XVoW5wdjcsOgVa2e
         GQ9kVWO3MZDq0eAxRYsRwDdbCONKq+VNHG4L7DA9s+VKc+tq1M+winVODTRsiH48X1X8
         ysADIU6QmDwoRpHq0JzAcLW8+xZqKuhnjKwvFL2YThCy+NA6SS7sEkO6/QLYK/E4LyAi
         kiHAf7BOSigdhDV9B6Y/L1OTn6OT64junDQAvBrqHBZZtSyDA0JZjkGAu+hETsJjA9QN
         NfkgbdeeLFsjrQm/yAZqx5mAFl0CSv9uzvinN0c3P9S4wdH8ZXypMXLP1a+1S6DuPE8r
         mpmA==
X-Gm-Message-State: ACrzQf1bQmvZahEVv9Mi/UAAYzw0HDxQ9/LS57XnJ2qsZfH5etixt3Oz
        JxAthx5xJ0fWijelD4j0ixmq3jQgcNP/396EKrQz0Yhp
X-Google-Smtp-Source: AMsMyM75RA19jCY4FY6bMQuqjKdIyJBP2VW+qVB6WUTfI9OfCrlw3k8Y27szZCYA0BCsUzUe2wY3pE6zfHB/ytHRURY=
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id
 jz6-20020a17090775e600b007a1084820cbmr11452017ejc.745.1666636083384; Mon, 24
 Oct 2022 11:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221022110529.51857-1-liuxin350@huawei.com>
In-Reply-To: <20221022110529.51857-1-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Oct 2022 11:27:51 -0700
Message-ID: <CAEf4BzbhhcvAn4yCdHUZZSLCLotywRM5e_-12sYSjg7h8nbdmQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: glob_sym may be a NULL pointer and cause the
 program crash
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 22, 2022 at 4:05 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> I found that `glob_sym` does not check whether it is NULL when reading the
> code. `glob_sym` obtains the pointer of btf information in the linker from
> `find_glob_sym`, which may be return NULL pointer. However, the code then
> references `glob_sym->sec_id`. This may cause program to crash.
>

May cause a crash or did you actually see an example of such a crash?

As far as I can see from the code, such global_sym is guaranteed to
exist, see how btf_type_map is filled in linker_append_btf(), slightly
above the code you are trying to fix


> Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> Signed-off-by: Weibin Kong <kongweibin2@huawei.com>
> ---
>  tools/lib/bpf/linker.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 4ac02c28e152..d02d2754910f 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2355,6 +2355,11 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
>                         if (btf_is_non_static(t)) {
>                                 name = btf__str_by_offset(linker->btf, t->name_off);
>                                 glob_sym = find_glob_sym(linker, name);
> +                               if (!glob_sym) {
> +                                       pr_warn("global '%s': section mismatch %d\n", name,
> +                                               dst_sec->id);
> +                                       return -EINVAL;
> +                               }
>                                 if (glob_sym->sec_id != dst_sec->id) {
>                                         pr_warn("global '%s': section mismatch %d vs %d\n",
>                                                 name, glob_sym->sec_id, dst_sec->id);
> --
> 2.33.0
>
