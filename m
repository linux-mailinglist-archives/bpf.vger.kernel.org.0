Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D416858802F
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiHBQYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHBQYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 12:24:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8721CFE2
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 09:24:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 206so9261707pgb.0
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=r/FElKSKI4d4N1KuRWDt63GFTsTI67NXPb95hO4t7Yk=;
        b=fp2qX5CYeQojibAepS5RnJrVBaPQMB2adp4B6k9r87odXKDU67NIWQxzfAHXKHQtLw
         4ot1kNkofzUlOqHXhGn8e5gi+O+N9W22+0mDWQ2v8DZLjzCJiyd8vyK10R7cRsGnQB/e
         yP6LGUN/PoR2vLavHZUtjyg+rlHQUveB/3JmolzxZwtTuwQx5fC/axKI5B2Bv0v+sQ2F
         JyAdoUMiti1scMTLDS9Gi6UcNZZMmU1deDqDj7TuCDUClcAa7B5867xPoSbrVzdJ+Ew4
         8NEFVhzPdHYV4/D0YKcVrV0cN6W1VRXi/DoulovHHREJnc/k7+Sj1q8734ct9TL2JjJp
         Paow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=r/FElKSKI4d4N1KuRWDt63GFTsTI67NXPb95hO4t7Yk=;
        b=Hq0OKfQUiYhJuS0i1t38GiFXAn/4SGRFyUgJvUZ05vcWxP2p+R1EeVFXbOhyEG9LU2
         G6dTG8eZiahItGCRHZY791vkfzJE+LNSM/6C2t4T5As1lSzEvR3SXl7JZhsj6IE5FXa4
         UfKKCVkCLnH/I8FSyRQcclTYQOtegUhdmlNNu7iIy+HwnrwAwAZfHOfzyxmmWrmlWH/y
         YDEGcayEjfEawxqF7f+KCocYrE9JV9v8EU+Wa+Vln3zJYtkvjrhwmSQO+6OoAhIT4/eN
         NbD09574Q77RbMi3VXRwfLQsv4Wwmp63OAsifP3JFj4JAKuI3Fwv/YlyciFyaZgEQpaW
         W2sw==
X-Gm-Message-State: AJIora/Zij/0U3TxstXtqAwm/QWo904QFXlCrVhbHVRMm0sNjhwkMYo0
        tcysErF8eGoWOROkF5kaocuK4R7XDVD5dNS1y+pFMzotzDo=
X-Google-Smtp-Source: AA6agR4OhweH57++xr/XpFy3h2RsPF5imt9xUb5K/3ksWUtSzGRxu8xMF1igzMgVFL8rd7ZlgYq1ayg9n5+U4oyI+Lk=
X-Received: by 2002:a17:902:7005:b0:16d:bcca:443e with SMTP id
 y5-20020a170902700500b0016dbcca443emr21618545plk.73.1659457466167; Tue, 02
 Aug 2022 09:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
 <CA+khW7hWwXc3vXJaXSUzhWEwBAsH0JdxK6SC-H4DOXw+PxuUgA@mail.gmail.com>
In-Reply-To: <CA+khW7hWwXc3vXJaXSUzhWEwBAsH0JdxK6SC-H4DOXw+PxuUgA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 2 Aug 2022 09:24:14 -0700
Message-ID: <CAKH8qBt1odxduc7KXTdq_NK_y7WZ8v35QUGkXKe6y9hSDc9OtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Aug 1, 2022 at 12:34 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 1, 2022 at 10:39 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Apparently, no existing selftest covers it. Add a new one where
> > we load cgroup/bind4 program and attach fentry to it.
> > Calling bpf_obj_get_info_by_fd on the fentry program
> > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> >
> > v2:
> > - use ret instead of err in find_prog_btf_id (Hao)
> > - remove verifier log (Hao)
> > - drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> I see Martin has comments based on v1, but v2 looks good to me.
>
> Acked-by: Hao Luo <haoluo@google.com>

Thank you for the review! I'll move some stuff around for v3, so I'll
have to ask you to have one more :-(
