Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEF63BBB3
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiK2Ida (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 03:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiK2Ic4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 03:32:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31459874
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:32:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so19953982wrr.8
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SfXkuxJt4Sl+5v785RM4HPYC1KEfbN5bUOLoDO26OM=;
        b=QLdxAbijrKCbrqIJHGTskqic691OxKjV6La8Bn3AybAenfEs8WD0BARsXHJdW1nYCr
         o0edCLXY1qNNeoN0tiASntnV3HU8UqPROcrZPDes4HlMgDUSbnOl8FS0j12bKdJGQOQ2
         fICV0gK8dT9S+p79xNg4Xz2OfkbJbefB3tyVEAdXFsPhv1VhoX9tNpEpW+0QWx5tVFhA
         LcdIEGFvrxs9WLbV8vHGxfIcPdz/7Xu+ITz24rxO12PkylPlBFlfkJGv6mNJh0iBRKQz
         vJx2r2Siu+N6ddxVmUbsSGGSONz+NxGSr+FQ8wZR+8NHK4FeRPb0zlcar/01RG+aRrDh
         7hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SfXkuxJt4Sl+5v785RM4HPYC1KEfbN5bUOLoDO26OM=;
        b=aoFtPIJhRddrpext5oW5DN/wlLcuA6V1fJAIGl3JcUnD0ze8/bf/eHumpds4cF7OA9
         iwisUJgqSB09PvUVl0oXrUbZiyLEUkyMD9Dwl8GKTgFmsmGeQpjymKB9L3o8kkj/MgKh
         Fl8AZJMgCKn/wroU5Qvswi9AKtRvPfoaZ4NY8hnkUZiH8AXha4oFE+5rbJs0CawqjqXq
         mhI69t6Scf1GXzK/txgfNq/+NfUzx/W7L7pBVpnFHxJXz+U+X2GRY8xL1QxQijN+dzmJ
         C5PYGW+wp9Yx7N+LorHocb/JfI5kVteF1OKI8c6IzoAxHIzXrE4I0uI8Vi1HTA9x4/LH
         Jvzw==
X-Gm-Message-State: ANoB5plB10sGHa7dOF34zC3odkFI7s/zQcRkct0dG39WG/vFt22S9otg
        nVPEXdLHN5GKc0SW0Pom2O8=
X-Google-Smtp-Source: AA0mqf6GiHfa2jUUtJETKLK/6D6r+vdYNsh8pn8CGmLYhK8SXAeZBCL60bFlnRpA/hud024t1bwvhg==
X-Received: by 2002:a05:6000:a05:b0:242:1836:c955 with SMTP id co5-20020a0560000a0500b002421836c955mr5489978wrb.37.1669710724514;
        Tue, 29 Nov 2022 00:32:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4a89000000b00241fde8fe04sm13072814wrq.7.2022.11.29.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:32:04 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 29 Nov 2022 09:32:02 +0100
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 bpf-next 3/4] selftests/bpf: Add bpf_vma_build_id_parse
 find_vma callback test
Message-ID: <Y4XDghSltmxvtiay@krava>
References: <20221128132915.141211-1-jolsa@kernel.org>
 <20221128132915.141211-4-jolsa@kernel.org>
 <CA+khW7hks-xqS-w7ZhKkSaj6eBDWu8QEW1qgaXi5oG5KdRQoWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7hks-xqS-w7ZhKkSaj6eBDWu8QEW1qgaXi5oG5KdRQoWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 11:25:02AM -0800, Hao Luo wrote:
> On Mon, Nov 28, 2022 at 5:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding tests for using new bpf_vma_build_id_parse kfunc in find_vma
> > callback function.
> >
> > On bpf side the test finds the vma of the test_progs text through the
> > test function pointer and reads its build id with the new kfunc.
> >
> > On user side the test uses readelf to get test_progs build id and
> > compares it with the one from bpf side.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> <...>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
> > new file mode 100644
> > index 000000000000..8937212207db
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
> <...>
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(test1, int a)
> > +{
> > +       struct task_struct *task = bpf_get_current_task_btf();
> > +
> > +       if (task->pid != target_pid)
> > +               return 0;
> 
> I think here we should use task->tgid. IIRC, task->pid corresponds to
> thread id in the userspace. task->tgid is the process id.

right, will change

thanks,
jirka

> 
> > +
> > +       ret = bpf_find_vma(task, addr, check_vma, NULL, 0);
> > +       return 0;
> > +}
> <...>
> > --
> > 2.38.1
> >
