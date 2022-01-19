Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E261494296
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiASVo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 16:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiASVo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 16:44:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C7DC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 13:44:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso294621pjv.1
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2zY3x42Ezw9fGCMdse1EWXxfN0YK4mcJtKfIDc6Mr0=;
        b=BJ+6mPuiVx+33GkW8OeYbwJt3EowIevdXPT2aeAZO+BhGxKMuUgGR9fxUpcwC3lore
         lDfKRaDrtjndJSFNuxuyTxsPTtLxnljm24FLs3dZtKf0kZuEHbaDRKEromQqh6pdAvuZ
         E18RVedW8oq38vs7z7A+TRv8qnCl55t/8aH2Cxx2Mnqxb+RAvpijN64W0HsO9J9h/C7K
         6Wey0ZDCtXAJiPm8Wa+g5FOblrjwM1HqcFo2hHfwvVFTybQa4rJ3dYxa7N0XZBpr19nV
         0B59Wt5Efd3isojqJ5w8oWMNVlYKrW6oNCVX9fK0TO7LMJM5k36nEdWL7IiJlNqxT/am
         hRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2zY3x42Ezw9fGCMdse1EWXxfN0YK4mcJtKfIDc6Mr0=;
        b=eGfHuzz7jxrZPWOx8vXEs3lbAyxuSj1+JR+rlLxzxW/QfBaaoe2yxDVWG77AtCAWec
         AY0AduYNoNsGZj4LlVA2kmPAKOT647pIZUT7pyuvLhwGQ9Yq8XC8/dNkNR8ukdSkWI0H
         +NYvSd+jBJs/fCQdxHQj7cQOAnUqbEwKr3qggoE+jfCfgzxkaX4y5yVhNPE4i+7BcHi6
         TD2CnKyeRYYvKUUe5P7Bw+l6E3737Ci1jSPRSC/0xiNqotmSDM8/4eNJXYpjmu2kPe3l
         mEHv3LJIPsJhsYsS0yXitQW/0CBobI1zuLtklivtR+VbOV5REpbDpgJBl8rplmu2XuwW
         pj/Q==
X-Gm-Message-State: AOAM532qcXew+27/BKriFQUi7bOpqg44we+dS3rL1AFRry9cfVOEqatu
        mwdatgSRcB1JmNY859eM3zGz3al6KZX/BldJMug=
X-Google-Smtp-Source: ABdhPJzEz92sAYmkKwx5q/hN0o4KAEAY/l9qN5K62NS1l7eReVsQwkYZMolYtV9Zl7+TlttXdN5KYvc7Zn7GECkPrV0=
X-Received: by 2002:a17:90a:de8e:: with SMTP id n14mr6626695pjv.122.1642628695852;
 Wed, 19 Jan 2022 13:44:55 -0800 (PST)
MIME-Version: 1.0
References: <YeadK5ykhh7slnXL@debian.home>
In-Reply-To: <YeadK5ykhh7slnXL@debian.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Jan 2022 13:44:44 -0800
Message-ID: <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Add bpf_copy_from_user_remote to read a
 process VM given its PID.
To:     "Gabriele N. Tornetta" <phoenix1987@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 2:57 AM Gabriele N. Tornetta
<phoenix1987@gmail.com> wrote:
>
> Add a new BPF helper to read the VM of a process identified by PID.
> Whilst PIDs are ambiguous without a namespace, many traditional
> observability tools, like profilers and debuggers, accept a PID to
> attach to a running process. The new helper proposed by this patch
> is aimed at providing the capability of reading a remote process VM
> to similar tools.

So how exactly is it going to be used with a pid provided by a tool?

I'm guessing if bpf prog attaches to some syscall it will filter out
all events that don't match the pid.
Then when current_pid == user_provided_pid it will read memory.
In such case the prog can use bpf_get_current_task_btf()
and Kenny's bpf_access_process_vm(), right?
